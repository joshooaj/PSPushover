---
external help file: joshooaj.PSPushover-help.xml
Module Name: joshooaj.PSPushover
online version: https://www.joshooaj.com/PSPushover/en-US/Get-PushoverSound/
schema: 2.0.0
---

# Get-PushoverSound

## SYNOPSIS

Gets the sounds available to use for notifications associated with an application.

## SYNTAX

```
Get-PushoverSound [[-Token] <SecureString>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-PushoverSound` cmdlet gets the sounds available to use for notifications associated with
an application. There is a collection of sounds available to choose from, and you may add your own
sounds through your [Pushover.net](https://pushover.net) dashboard.

## EXAMPLES

### Example 1

```powershell
Get-PushoverSound
```

Gets a hashtable containing the sounds available for the default application in your environment.

### Example 2

```powershell
$appToken = Read-Host -Prompt 'Application token' -AsSecureString
Get-PushoverSound -Token $appToken
```

Gets a hashtable containing the sounds available for the application represented by the token
stored in the $appToken variable.

## PARAMETERS

### -Token

Specifies the Pushover application API token/key. The default value will be used if it has been
previously set with Set-PushoverConfig.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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

### System.Collections.Hashtable

## NOTES

## RELATED LINKS
