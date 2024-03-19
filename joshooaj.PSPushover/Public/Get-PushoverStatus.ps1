function Get-PushoverStatus {
    [CmdletBinding()]
    [OutputType([PSPushoverNotificationStatus])]
    param (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [securestring]
        $Token,

        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $Receipt
    )

    begin {
        $config = Get-PushoverConfig
        $uriBuilder = [uribuilder]($config.ApiUri + '/receipts')
    }

    process {
        if ($null -eq $Token) {
            $Token = $config.AppToken
            if ($null -eq $Token) {
                throw "Token not provided and no default application token has been set using Set-PushoverConfig."
            }
        }
        $uriBuilder.Path += "/$Receipt.json"
        $uriBuilder.Query = "token=" + ($Token | ConvertTo-PlainText)
        try {
            $uriBuilder.Query = "token=" + ($Token | ConvertTo-PlainText)
            $response = Invoke-RestMethod -Method Get -Uri $uriBuilder.Uri
        }
        catch {
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
            }
            finally {
                $reader.Dispose()
            }
        }

        if ($response.status -eq 1) {
            [PSPushoverNotificationStatus]@{
                Receipt = $Receipt
                Acknowledged = [bool]$response.acknowledged
                AcknowledgedAt = [datetimeoffset]::FromUnixTimeSeconds($response.acknowledged_at).DateTime.ToLocalTime()
                AcknowledgedBy = $response.acknowledged_by
                AcknowledgedByDevice = $response.acknowledged_by_device
                LastDeliveredAt = [datetimeoffset]::FromUnixTimeSeconds($response.last_delivered_at).DateTime.ToLocalTime()
                Expired = [bool]$response.expired
                ExpiresAt = [datetimeoffset]::FromUnixTimeSeconds($response.expires_at).DateTime.ToLocalTime()
                CalledBack = [bool]$response.called_back
                CalledBackAt = [datetimeoffset]::FromUnixTimeSeconds($response.called_back_at).DateTime.ToLocalTime()
            }
        }
        else {
            if ($null -ne $response.error) {
                Write-Error $response.error
            }
            elseif ($null -ne $response.errors) {
                foreach ($problem in $response.errors) {
                    Write-Error $problem
                }
            }
            else {
                $response
            }
        }
    }
}
