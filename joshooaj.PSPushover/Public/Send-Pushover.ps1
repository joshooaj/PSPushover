function Send-Pushover {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message,

        [Parameter()]
        [string]
        $Title,

        [Parameter()]
        [byte[]]
        $Attachment,

        [Parameter()]
        [string]
        $FileName = 'attachment.jpg',

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [uri]
        $Url,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $UrlTitle,

        [Parameter()]
        [MessagePriority]
        $MessagePriority,

        [Parameter()]
        [ValidateScript({
                if ($_.TotalSeconds -lt 30) {
                    throw 'RetryInterval must be at least 30 seconds'
                }
                if ($_.TotalSeconds -gt 10800) {
                    throw 'RetryInterval cannot exceed 3 hours'
                }
                $true
            })]
        [timespan]
        $RetryInterval = (New-TimeSpan -Minutes 1),

        [Parameter()]
        [ValidateScript({
                if ($_.TotalSeconds -le 30) {
                    throw 'ExpireAfter must be greater than the minimum RetryInterval value of 30 seconds'
                }
                if ($_.TotalSeconds -gt 10800) {
                    throw 'ExpireAfter cannot exceed 3 hours'
                }
                $true
            })]
        [timespan]
        $ExpireAfter = (New-TimeSpan -Minutes 10),

        [Parameter()]
        [datetime]
        $Timestamp = (Get-Date),

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Sound,

        [Parameter()]
        [string[]]
        $Tags,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [securestring]
        $Token,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [securestring]
        $User,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Device
    )

    begin {
        $config = Get-PushoverConfig
        $uri = $config.ApiUri + '/messages.json'
    }

    process {
        if ($null -eq $Token) {
            $Token = $config.AppToken
            if ($null -eq $Token) {
                throw "Token not provided and no default application token has been set using Set-PushoverConfig."
            }
        }
        if ($null -eq $User) {
            $User = $config.UserToken
            if ($null -eq $User) {
                throw "User not provided and no default user id has been set using Set-PushoverConfig."
            }
        }

        $deviceList = if ($null -ne $Device) {
            [string]::Join(',', $Device)
        } else { $null }

        $tagList = if ($null -ne $Tags) {
            [string]::Join(',', $Tags)
        } else { $null }

        $body = [ordered]@{
            token     = $Token | ConvertTo-PlainText
            user      = $User | ConvertTo-PlainText
            device    = $deviceList
            title     = $Title
            message   = $Message
            url       = $Url
            url_title = $UrlTitle
            priority  = [int]$MessagePriority
            retry     = [int]$RetryInterval.TotalSeconds
            expire    = [int]$ExpireAfter.TotalSeconds
            timestamp = [int]([datetimeoffset]::new($Timestamp).ToUnixTimeMilliseconds() / 1000)
            tags      = $tagList
            sound     = $Sound
        }

        try {
            if ($Attachment.Length -eq 0) {
                $bodyJson = $body | ConvertTo-Json
                Write-Verbose "Message body:`r`n$($bodyJson.Replace($Body.token, "********").Replace($Body.user, "********"))"
                $response = Invoke-RestMethod -Method Post -Uri $uri -Body $bodyJson -ContentType application/json -UseBasicParsing
            } else {
                $response = Send-MessageWithAttachment -Body $body -Attachment $Attachment -FileName $FileName
            }
        } catch {
            Write-Verbose 'Handling HTTP error in Invoke-RestMethod response'
            $statusCode = $_.Exception.Response.StatusCode.value__
            Write-Verbose "HTTP status code $statusCode"
            if ($statusCode -lt 400 -or $statusCode -gt 499) {
                throw
            }

            try {
                Write-Verbose 'Parsing HTTP request error response'
                $stream = $_.Exception.Response.GetResponseStream()
                $reader = [io.streamreader]::new($stream)
                $response = $reader.ReadToEnd() | ConvertFrom-Json
                if ([string]::IsNullOrWhiteSpace($response)) {
                    throw $_
                }
                Write-Verbose "Response body:`r`n$response"
            } finally {
                $reader.Dispose()
            }
        }

        if ($response.status -ne 1) {
            if ($null -ne $response.error) {
                Write-Error $response.error
            } elseif ($null -ne $response.errors) {
                foreach ($problem in $response.errors) {
                    Write-Error $problem
                }
            } else {
                $response
            }
        }

        if ($null -ne $response.receipt) {
            Write-Output $response.receipt
        }
    }
}
