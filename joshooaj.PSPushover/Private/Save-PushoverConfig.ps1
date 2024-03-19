function Save-PushoverConfig {
    <#
    .SYNOPSIS
        Save module configuration to disk
    #>
    [CmdletBinding()]
    param ()

    process {
        Write-Verbose "Saving the module configuration to '$($script:configPath)'"
        $directory = ([io.fileinfo]$script:configPath).DirectoryName
        if (-not (Test-Path -Path $directory)) {
            $null = New-Item -Path $directory -ItemType Directory -Force
        }
        $script:config | Export-Clixml -Path $script:configPath -Force
    }
}