properties {
    & dotnet tool restore
    # Set this to $true to create a module with a monolithic PSM1
    $PSBPreference.Build.CompileModule = $true
    $PSBPreference.Docs.RootDir = './docs'
    $PSBPreference.General.ModuleVersion = (dotnet nbgv get-version -f json | ConvertFrom-Json).NuGetPackageVersion
    $PSBPreference.Help.DefaultLocale = 'en-US'
    $PSBPreference.Test.OutputFile = 'out/testResults.xml'
    $PSBPreference.Test.ScriptAnalysis.SettingsPath = Join-Path $psake.build_script_dir 'PSScriptAnalyzerSettings.psd1'
    $psake.context.tasks.stagefiles.PostAction = {
        $outputManifestPath = [io.path]::Combine($PSBPreference.Build.ModuleOutDir, "$($PSBPreference.General.ModuleName).psd1")
        Update-Metadata -Path $outputManifestPath -PropertyName ModuleVersion -Value $PSBPreference.General.ModuleVersion
    }
}

task Default -depends Test
task Build -FromModule PowerShellBuild -minimumVersion '0.6.1'
task Test -FromModule PowerShellBuild -minimumVersion '0.6.1'

task Serve -depends Build {
    if ($null -eq (Get-Command mkdocs -ErrorAction SilentlyContinue)) {
        throw "Cannot find the 'mkdocs' command. Install python and mkdocs, or consider using the dev container."
    }
    exec {
        mkdocs serve -a 0.0.0.0:8000
    }
}

task PublishDocs -depends Build {
    exec {
        docker run -v "$($psake.build_script_dir)`:/docs" -e 'CI=true' --entrypoint 'sh' squidfunk/mkdocs-material:latest -c 'pip install -r requirements.txt && mkdocs gh-deploy --force'
    }
}
