function Import-PushoverConfig {
    <#
    .SYNOPSIS
        Imports the configuration including default API URI's and tokens
    .DESCRIPTION
        If the module has been previously used, the configuration should be present. If the config
        can be imported, the function returns true. Otherwise it returns false.
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param ()

    process {
        if (Test-Path -Path $script:configPath) {
            try {
                Write-Verbose "Importing configuration from '$($script:configPath)'"
                $script:config = Import-Clixml -Path $script:configPath
                return $true
            }
            catch {
                Write-Error "Failed to import configuration from '$script:configPath'." -Exception $_.Exception
            }
        }
        else {
            Write-Verbose "No existing module configuration found at '$($script:configPath)'"
        }
        $false
    }
}