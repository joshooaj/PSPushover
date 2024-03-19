BeforeAll {

    # NEW: Pre-Specify RegEx Matching Patterns
    $gitTagMatchRegEx   = 'tag:\s?.(\d+(\.\d+)*)' # NOTE - was 'tag:\s*(\d+(?:\.\d+)*)' previously

    $moduleName         = $env:BHProjectName
    $outputManifestPath = Join-Path -Path $env:BHBuildOutput -ChildPath "$($env:BHProjectName).psd1"
    $manifestData       = Test-ModuleManifest -Path $outputManifestPath -Verbose:$false -ErrorAction Stop -WarningAction SilentlyContinue

    $script:manifest    = $null
}
Describe 'Module manifest' {

    Context 'Validation' {

        It 'Has a valid manifest' {
            $manifestData | Should -Not -BeNullOrEmpty
        }

        It 'Has a valid name in the manifest' {
            $manifestData.Name | Should -Be $moduleName
        }

        It 'Has a valid root module' {
            $manifestData.RootModule | Should -Be "$($moduleName).psm1"
        }

        It 'Has a valid version in the manifest' {
            $manifestData.Version -as [Version] | Should -Not -BeNullOrEmpty
        }

        It 'Has a valid description' {
            $manifestData.Description | Should -Not -BeNullOrEmpty
        }

        It 'Has a valid author' {
            $manifestData.Author | Should -Not -BeNullOrEmpty
        }

        It 'Has a valid guid' {
            {[guid]::Parse($manifestData.Guid)} | Should -Not -Throw
        }

        It 'Has a valid copyright' {
            $manifestData.CopyRight | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Git tagging' -Skip {
    BeforeAll {
        $gitTagVersion = $null

        # Ensure to only pull in a single git executable (in case multiple git's are found on path).
        if ($git = (Get-Command git -CommandType Application -ErrorAction SilentlyContinue)[0]) {
            $thisCommit = & $git log --decorate --oneline HEAD~1..HEAD
            if ($thisCommit -match $gitTagMatchRegEx) { $gitTagVersion = $matches[1] }
        }
    }

    It 'Is tagged with a valid version' {
        $gitTagVersion               | Should -Not -BeNullOrEmpty
        $gitTagVersion -as [Version] | Should -Not -BeNullOrEmpty
    }

    It 'Matches manifest version' {
        $manifestData.Version -as [Version] | Should -Be ( $gitTagVersion -as [Version])
    }
}
