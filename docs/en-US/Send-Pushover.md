---
external help file: joshooaj.PSPushover-help.xml
Module Name: joshooaj.PSPushover
online version: https://www.joshooaj.com/PSPushover/en-US/Send-Pushover/
schema: 2.0.0
---

# Send-Pushover

## SYNOPSIS

Sends a message to one or more users using the Pushover API.

## SYNTAX

```
Send-Pushover [-Message] <String> [-Title <String>] [-Attachment <Byte[]>] [-FileName <String>] [-Url <Uri>]
 [-UrlTitle <String>] [-MessagePriority <MessagePriority>] [-RetryInterval <TimeSpan>]
 [-ExpireAfter <TimeSpan>] [-Timestamp <DateTime>] [-Sound <String>] [-Tags <String[]>] [-Token <SecureString>]
 [-User <SecureString>] [-Device <String[]>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

The `Send-Pushover` cmdlet sends a message to one or more users using the Pushover API.
Notifications require a message, and may be customized with a number of optional parameters
including a title, image, url, sound, timestamp, and priority.

Notifications with a MessagePriority of "Emergency" can be customized with a retry interval, and
expiration. Emergency notifications can be monitored in order to track when and who has
acknowledged them.

## EXAMPLES

### EXAMPLE 1

```powershell
Send-PushoverMessage -Token $token -User $user -Title 'What time is it?' -Message 'It''s time for lunch'
```

Sends a notification to the user or group specified in the $user string variable, from the application designed by the application API token value in $token

### EXAMPLE 2

```powershell
Send-PushoverMessage -Token $token -User $user -Title 'What time is it?' -Message 'It''s time for lunch' -MessagePriority Emergency -RetryInterval (New-TimeSpan -Seconds 60) -ExpireAfter (New-TimeSpan -Hours 1)
```

Sends the same notification as Example 1, except with emergency priority which results in the notification being repeated every 60 seconds, until an hour has passed or the message has been acknowledged.

## PARAMETERS

### -Attachment

Optionally specifies an image in bytes to be attached to the message.

```yaml
Type: Byte[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Device

Optionally specifies one or more devices to which notifications should be sent.
Useful for sending notifications to a targetted device instead of all of the user's devices.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpireAfter

Specifies the amount of time unacknowledged notifications will be retried before Pushover stops sending notifications.
Valid only with MessagePriority of 'Emergency'.

```yaml
Type: TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (New-TimeSpan -Minutes 10)
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName

Optionally specifies the file name to associate with the attachment.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Attachment.jpg
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message

Specifies the message to be sent with the Pushover notification.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -MessagePriority

Parameter help description

```yaml
Type: MessagePriority
Parameter Sets: (All)
Aliases:
Accepted values: Normal, High, Emergency, Lowest, Low

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryInterval

Specifies the interval between emergency Pushover notifications.
Pushover will retry until the message is acknowledged, or expired.
Valid only with MessagePriority of 'Emergency'.

```yaml
Type: TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (New-TimeSpan -Minutes 1)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sound

Optionally specifies the notification sound to use

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags

Optionally specifies one or more tags to associate with the Pushover notification.
Tags can be used to cancel emergency notifications in bulk.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timestamp

Optionally specifies the timestamp associated with the message.
Default is DateTime.Now.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title

Specifies the title of the Pushover notification.
The default will be the application name configured for the application API token supplied.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token

Specifies the application API token/key from which the Pushover notification should be sent.
Note: The default value will be used if it has been previously set with Set-PushoverConfig

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

### -Url

Optionally specifies a supplementary URL associated with the message.

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

### -UrlTitle

Optionally specifies a title for the supplementary URL if specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -User

Specifies the User or Group identifier to which the Pushover message should be sent.
Note: The default value will be used if it has been previously set with Set-PushoverConfig

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

### String

## NOTES

## RELATED LINKS
