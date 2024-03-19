function Test-PushoverUser {
    [CmdletBinding()]
    [OutputType([PSPushoverUserValidation])]
    param (
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
        [string]
        $Device,

        [Parameter()]
        [PSPushoverInformationLevel]
        $InformationLevel = [PSPushoverInformationLevel]::Detailed
    )

    begin {
        $config = Get-PushoverConfig
        $uri = $config.ApiUri + '/users/validate.json'
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

        $body = [ordered]@{
            token  = $Token | ConvertTo-PlainText
            user   = $User | ConvertTo-PlainText
            device = $Device
        }

        try {
            $bodyJson = $body | ConvertTo-Json
            Write-Verbose "Message body:`r`n$($bodyJson.Replace($Body.token, "********").Replace($Body.user, "********"))"
            if (Get-Command Invoke-RestMethod -ParameterName SkipHttpErrorCheck -ErrorAction SilentlyContinue) {
                $response = Invoke-RestMethod -Method Post -Uri $uri -Body $bodyJson -ContentType application/json -SkipHttpErrorCheck
            } else {
                $response = Invoke-RestMethod -Method Post -Uri $uri -Body $bodyJson -ContentType application/json -UseBasicParsing
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

        if ($null -ne $response.status) {
            switch ($InformationLevel) {
                ([PSPushoverInformationLevel]::Quiet) {
                    Write-Output ($response.status -eq 1)
                }

                ([PSPushoverInformationLevel]::Detailed) {
                    [PSPushoverUserValidation]@{
                        Valid    = $response.status -eq 1
                        IsGroup  = $response.group -eq 1
                        Devices  = $response.devices
                        Licenses = $response.licenses
                        Error    = $response.errors | Select-Object -First 1
                    }
                }
                Default { throw "InformationLevel $InformationLevel not implemented." }
            }
        } else {
            Write-Error "Unexpected response: $($response | ConvertTo-Json)"
        }
    }
}
