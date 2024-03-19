function Send-MessageWithAttachment {
    <#
    .SYNOPSIS
        Sends an HTTP POST to the Pushover API using an HttpClient
    .DESCRIPTION
        When sending an image attachment with a Pushover message, you must use multipart/form-data
        and there doesn't seem to be a nice way to do this using Invoke-RestMethod like we're doing
        in the public Send-Message function. So when an attachment is provided to Send-Message, the
        body hashtable is constructed, and then sent over to this function to keep the main
        Send-Message function a manageable size.
    #>
    [CmdletBinding()]
    param (
        # Specifies the various parameters and values expected by the Pushover messages api.
        [Parameter(Mandatory)]
        [hashtable]
        $Body,

        # Specifies the image to attach to the message as a byte array
        [Parameter(Mandatory)]
        [byte[]]
        $Attachment,

        # Optionally specifies a file name to associate with the attachment
        [Parameter()]
        [string]
        $FileName = 'attachment.jpg'
    )

    begin {
        $uri = $script:PushoverApiUri + '/messages.json'
    }

    process {
        try {
            $client = [system.net.http.httpclient]::new()
            try {
                $content = [system.net.http.multipartformdatacontent]::new()
                foreach ($key in $Body.Keys) {
                    $textContent = [system.net.http.stringcontent]::new($Body.$key)
                    $content.Add($textContent, $key)
                }
                $jpegContent = [system.net.http.bytearraycontent]::new($Attachment)
                $jpegContent.Headers.ContentType = [system.net.http.headers.mediatypeheadervalue]::new('image/jpeg')
                $jpegContent.Headers.ContentDisposition = [system.net.http.headers.contentdispositionheadervalue]::new('form-data')
                $jpegContent.Headers.ContentDisposition.Name = 'attachment'
                $jpegContent.Headers.ContentDisposition.FileName = $FileName
                $content.Add($jpegContent)

                Write-Verbose "Message body:`r`n$($content.ReadAsStringAsync().Result.Substring(0, 2000).Replace($Body.token, "********").Replace($Body.user, "********"))"
                $result = $client.PostAsync($uri, $content).Result
                Write-Output ($result.Content.ReadAsStringAsync().Result | ConvertFrom-Json)
            }
            finally {
                $content.Dispose()
            }
        }
        finally {
            $client.Dispose()
        }
    }
}