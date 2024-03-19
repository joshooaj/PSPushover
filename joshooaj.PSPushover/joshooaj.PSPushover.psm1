# Dot source public/private functions when importing from source
if (Test-Path -Path $PSScriptRoot/Public) {
    $classes = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Classes/*.ps1') -Recurse -ErrorAction Stop)
    $public  = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Public/*.ps1')  -Recurse -ErrorAction Stop)
    $private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Private/*.ps1') -Recurse -ErrorAction Stop)
    foreach ($import in @(($classes + $public + $private))) {
        try {
            . $import.FullName
        } catch {
            throw "Unable to dot source [$($import.FullName)]"
        }
    }

    Export-ModuleMember -Function $public.Basename
}

$script:PushoverApiDefaultUri = 'https://api.pushover.net/1'
$script:PushoverApiUri = $script:PushoverApiDefaultUri

$appDataRoot = [environment]::GetFolderPath([System.Environment+SpecialFolder]::ApplicationData)
$script:configPath = Join-Path $appDataRoot 'joshooaj.PSPushover\config.xml'
$script:config = $null
if (-not (Import-PushoverConfig)) {
    Reset-PushoverConfig
}

$soundsCompleter = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $soundList = @('incoming', 'pianobar', 'climb', 'gamelan', 'bugle', 'vibrate', 'pushover', 'cosmic', 'spacealarm', 'updown', 'none', 'persistent', 'cashregister', 'mechanical', 'bike', 'classical', 'falling', 'alien', 'magic', 'siren', 'tugboat', 'intermission', 'echo')
    $soundList | Where-Object {
        $_ -like "$wordToComplete*"
    } | Foreach-Object {
        "'$_'"
    }
}
Register-ArgumentCompleter -CommandName Send-Pushover -ParameterName Sound -ScriptBlock $soundsCompleter
