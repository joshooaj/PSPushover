function Set-PushoverConfig {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [uri]
        $ApiUri,

        [Parameter(ParameterSetName = 'AsPlainText')]
        [securestring]
        $Token,

        [Parameter()]
        [securestring]
        $User,

        [Parameter()]
        [switch]
        $Temporary
    )

    process {
        if ($PSBoundParameters.ContainsKey('ApiUri')) {
            if ($PSCmdlet.ShouldProcess("Pushover ApiUri", "Set value to '$ApiUri'")) {
                $script:config.PushoverAPiUri = $ApiUri.ToString()
            }
        }
        if ($PSBoundParameters.ContainsKey('Token')) {
            if ($PSCmdlet.ShouldProcess("Pushover Default Application Token", "Set value")) {
                $script:config.DefaultAppToken = $Token
            }
        }
        if ($PSBoundParameters.ContainsKey('User')) {
            if ($PSCmdlet.ShouldProcess("Pushover Default User Key", "Set value")) {
                $script:config.DefaultUserToken = $User
            }
        }

        if (-not $Temporary) {
            Save-PushoverConfig
        }
    }
}
