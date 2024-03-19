@{
    RootModule        = 'joshooaj.PSPushover.psm1'
    # ModuleVersion is updated in the output directory using a PostAction on the StageFiles psake task. The version number is provided by nbgv.
    ModuleVersion     = '0.1.0'
    GUID              = '4db4b678-dc3f-47b1-bfe0-4ffc65ae03f4'
    Author            = 'joshooaj'
    CompanyName       = 'joshooaj'
    Copyright         = '(c) Joshua Hendricks. All rights reserved.'
    Description       = 'Send notifications to any device from PowerShell using pushover.net.'
    # FunctionsToExport is updated in the output directory by PowerShellBuild
    FunctionsToExport = '*'
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{
            Tags       = @('notifications', 'pushover', 'push notifications')
            LicenseUri = 'https://github.com/joshooaj/PSPushover/blob/main/LICENSE'
            ProjectUri = 'https://github.com/joshooaj/PSPushover'
            # IconUri = ''
            # ReleaseNotes = ''
            # Prerelease = ''
        }
    }
}
