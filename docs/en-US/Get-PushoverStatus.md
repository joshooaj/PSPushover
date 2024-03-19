---
external help file: joshooaj.PSPushover-help.xml
Module Name: joshooaj.PSPushover
online version: https://www.joshooaj.com/PSPushover/en-US/Get-PushoverStatus/
schema: 2.0.0
---

# Get-PushoverStatus

## SYNOPSIS

Gets the status of a Pushover notification using the receipt from Send-Pushover.

## SYNTAX

```
Get-PushoverStatus [[-Token] <SecureString>] [-Receipt] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION

When sending a Pushover notification with MessagePriority of 'Emergency', a receipt is returned.
This receipt is a random string associated with the notification and can be used to check if and
when the notification was delivered and acknowledged, or if it has expired and is no longer
causing notifications to be sent to the user(s).

When the notification is acknowledged, the user and device performing the acknowledgement will be
included in the returned `[PSPushoverNotificationStatus]` response.

## EXAMPLES

### EXAMPLE 1

```powershell
$receipt = Send-Pushover -Message 'Are we there yet?' -MessagePriority Emergency -Sound tugboat
Get-PushoverStatus -Receipt $receipt

<# Sample output

# Before acknowledgement
Receipt              : ro3r26sualp9jb71azpp3eizrtfiir
Acknowledged         : False
AcknowledgedAt       : 01/01/1970 00:00:00
AcknowledgedBy       :
AcknowledgedByDevice :
LastDeliveredAt      : 03/17/2024 21:47:44
Expired              : False
ExpiresAt            : 03/17/2024 21:57:44
CalledBack           : False
CalledBackAt         : 01/01/1970 00:00:00

# After acknowledgement
Receipt              : ro3r26sualp9jb71azpp3eizrtfiir
Acknowledged         : True
AcknowledgedAt       : 03/17/2024 21:48:50
AcknowledgedBy       : <redacted user token>
AcknowledgedByDevice : android
LastDeliveredAt      : 03/17/2024 21:48:44
Expired              : False
ExpiresAt            : 03/17/2024 21:57:44
CalledBack           : False
CalledBackAt         : 01/01/1970 00:00:00
#>
```

Sends an emergency Pushover message and then uses the receipt to check the status of that notification.

## PARAMETERS

### -Receipt

Specifies the receipt returned by Send-Pushover when sending notifications with a
"MessagePriority" value of "Emergency". The receipt is a random string value in the same format
as an application or user token.

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

### PSPushoverNotificationStatus

## NOTES

## RELATED LINKS
