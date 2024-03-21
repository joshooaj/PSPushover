@{
    PSDepend             = @{
        Version = '0.3.8'
    }
    PSDependOptions      = @{
        Target = 'CurrentUser'
    }
    'Pester'             = @{
        Version    = '5.5.0'
        Parameters = @{
            SkipPublisherCheck = $true
        }
    }
    'psake'              = @{
        Version = '4.9.0'
    }
    'BuildHelpers'       = @{
        Version = '2.0.16'
    }
    'PowerShellBuild'    = @{
        Version = '0.6.1'
    }
    'PSScriptAnalyzer'   = @{
        Version = '1.21.0'
    }
    'PythonRequirements' = @{
        DependencyType = 'Command'
        Source         = 'pip install -qr requirements.txt --cache-dir .cache/pip/'
    }
    'DotnetCLI'          = @{
        DependencyType = 'DotnetSdk'
        Version        = '8.0.200'
        Target         = './.cache/dotnet/'
    }
}
