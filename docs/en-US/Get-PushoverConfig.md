---
external help file: joshooaj.PSPushover-help.xml
Module Name: joshooaj.PSPushover
online version: https://www.joshooaj.com/PSPushover/en-US/Get-PushoverConfig/
schema: 2.0.0
---

# Get-PushoverConfig

## SYNOPSIS

Get the Pushover configuration from the PSPushover module

## SYNTAX

```
Get-PushoverConfig [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Properties like the API URI and default application and user tokens can be read and written
using Get-PushoverConfig and Set-PushoverConfig.

The location of the configuration file depends on your operating system. On Windows the path is
usually `C:\Users\<user>\AppData\Roaming\joshooaj.PSPushover\config.xml` and on Linux the path may
be `/home/<user>/.config/joshooaj.PSPushover/config.xml`. PSPushover determines the application
data path using the command `[Environment]::GetFolderPath([System.Environment+SpecialFolder]::ApplicationData)`

## EXAMPLES

### Example 1

```powershell
Get-PushoverConfig | Format-List

<# Sample output
ApiUri     : https://api.pushover.net/1
AppToken   : System.Security.SecureString
UserToken  : System.Security.SecureString
ConfigPath : /home/vscode/.config/PSPushover/config.xml
#>
```

Returns the PSPushover configuration for the current user which includes the default base URI for the Pushover API, the
default app and user tokens, and the location where the configuration is stored.

## PARAMETERS

### -ProgressAction

Ignore this common parameter. PlatyPS is undergoing a rewrite and the current version does not recognize ProgressAction as a common parameter.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSCustomObject

## NOTES

## RELATED LINKS
