function Get-PushoverConfig {
    [CmdletBinding()]
    param ()

    process {
        [pscustomobject]@{
            PSTypeName = 'PushoverConfig'
            ApiUri     = $script:config.PushoverApiUri
            AppToken   = $script:config.DefaultAppToken
            UserToken  = $script:config.DefaultUserToken
            ConfigPath = $script:configPath
        }
    }
}
