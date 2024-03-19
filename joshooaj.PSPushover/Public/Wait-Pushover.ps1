function Wait-Pushover {
    [CmdletBinding()]
    [OutputType([PSPushoverNotificationStatus])]
    param (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [securestring]
        $Token,

        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $Receipt,

        [Parameter()]
        [ValidateRange(5, 10800)]
        [int]
        $Interval = 10
    )

    begin {
        $config = Get-PushoverConfig
    }

    process {
        if ($null -eq $Token) {
            $Token = $config.Token
            if ($null -eq $Token) {
                throw "Token not provided and no default application token has been set using Set-PushoverConfig."
            }
        }

        $timeoutAt = (Get-Date).AddHours(3)
        while ((Get-Date) -lt $timeoutAt.AddSeconds($Interval)) {
            $status = Get-PushoverStatus -Token $Token -Receipt $Receipt -ErrorAction Stop
            $timeoutAt = $status.ExpiresAt
            if ($status.Acknowledged -or $status.Expired) {
                break
            }
            Start-Sleep -Seconds $Interval
        }
        Write-Output $status
    }
}
