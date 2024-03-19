function Reset-PushoverConfig {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    process {
        if ($PSCmdlet.ShouldProcess("PSPushover Module Configuration", "Reset to default")) {
            Write-Verbose "Using the default module configuration"
            $script:config = @{
                PushoverApiDefaultUri = 'https://api.pushover.net/1'
                PushoverApiUri        = 'https://api.pushover.net/1'
                DefaultAppToken       = $null
                DefaultUserToken      = $null
            }
            Save-PushoverConfig
        }
    }
}
