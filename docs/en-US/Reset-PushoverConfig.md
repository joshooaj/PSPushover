---
external help file: joshooaj.PSPushover-help.xml
Module Name: joshooaj.PSPushover
online version: https://www.joshooaj.com/PSPushover/en-US/Reset-PushoverConfig/
schema: 2.0.0
---

# Reset-PushoverConfig

## SYNOPSIS

Reset the PSPushover module configuration to default values for the current user.

## SYNTAX

```
Reset-PushoverConfig [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this cmdlet to reset your current user's PSPushover configuration to default values. This will
reset the Pushover API base URI to the default value, and remove your user and application tokens
if they were previously stored using `Set-PushoverConfig`.

## EXAMPLES

### Example 1

```powershell
Reset-PushoverConfig
```

Deletes the stored application and user tokens if present, and resets the base URI for the Pushover
API to the default value.

## PARAMETERS

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
