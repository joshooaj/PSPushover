---
external help file: joshooaj.PSPushover-help.xml
Module Name: joshooaj.PSPushover
online version: https://www.joshooaj.com/PSPushover/en-US/Set-PushoverConfig/
schema: 2.0.0
---

# Set-PushoverConfig

## SYNOPSIS

Sets the Pushover configuration in the PSPushover module

## SYNTAX

```
Set-PushoverConfig [-ApiUri <Uri>] [-Token <SecureString>] [-User <SecureString>] [-Temporary]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The Pushover API URI can be modified for the purpose of test automation, and application
and user tokens can be securely stored on disk so that you don't have to supply the tokens
with every call to Send-Pushover in case you are always sending notifications from the same
application and to the same user/group.

The location of the configuration file depends on your operating system. On Windows the path is
usually `C:\Users\<user>\AppData\Roaming\joshooaj.PSPushover\config.xml` and on Linux the path may
be `/home/<user>/.config/joshooaj.PSPushover/config.xml`. PSPushover determines the application
data path using the command `[Environment]::GetFolderPath([System.Environment+SpecialFolder]::ApplicationData)`

## EXAMPLES

### EXAMPLE 1

```powershell
Set-PushoverConfig -Token (Read-Host -AsSecureString)
Set-PushoverConfig -User (Read-Host -AsSecureString)
```

Prompts for the desired default application token and user token and persists it to disk to use as the default application and user tokens.

### EXAMPLE 2

```powershell
Set-PushoverConfig -ApiUri http://localhost:8888 -Temporary
```

Sets the Pushover API URI to `http://localhost:8888` for the duration of the PowerShell session
or until the PSPushover module is forcefully imported again.

## PARAMETERS

### -ApiUri

Species the base URI to which all HTTP requests should be sent.
Recommended to change this only for the purposes of test automation.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Temporary

Specifies that the new settings should only be temporary and should not be saved to disk. The next time the PSPushover
module is imported, the temporary value will be lost and the default values will be loaded from disk.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token

The default application token to use when the token isn't otherwise specified.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -User

The default user or group token to use when the token isn't otherwise specified.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

## OUTPUTS

## NOTES

## RELATED LINKS
