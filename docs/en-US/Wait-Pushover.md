---
external help file: joshooaj.PSPushover-help.xml
Module Name: joshooaj.PSPushover
online version: https://www.joshooaj.com/PSPushover/en-US/Wait-Pushover/
schema: 2.0.0
---

# Wait-Pushover

## SYNOPSIS

Waits for a user to acknowledge receipt of the Pushover message or for the notification to expire.

## SYNTAX

```
Wait-Pushover [[-Token] <SecureString>] [-Receipt] <String> [[-Interval] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Waits for a user to acknowledge receipt of the Pushover message or for the notification to expire
then returns the last `[PSPushoverNotificationStatus]` response object.

## EXAMPLES

### EXAMPLE 1

```powershell
Send-Pushover -Message 'Please clap' -MessagePriority Emergency | Wait-Pushover
```

Sends an emergency Pushover notification and then waits for the notification to expire or for at least one user to acknowledge it.

## PARAMETERS

### -Interval

Specifies the interval between each Pushover API request for receipt status

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -Receipt

Specifies the receipt received from emergency notifications sent using Send-Pushover

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Token

Specifies the Pushover application API token/key.
Note: The default value will be used if it has been previously set with Set-PushoverConfig

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

### PSPushoverNotificationStatus

## NOTES

## RELATED LINKS
