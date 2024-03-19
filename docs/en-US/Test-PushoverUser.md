---
external help file: joshooaj.PSPushover-help.xml
Module Name: joshooaj.PSPushover
online version: https://www.joshooaj.com/PSPushover/en-US/Test-PushoverUser/
schema: 2.0.0
---

# Test-PushoverUser

## SYNOPSIS

Validate a user token and optional device name against the Pushover API.

## SYNTAX

```
Test-PushoverUser [[-Token] <SecureString>] [[-User] <SecureString>] [[-Device] <String>]
 [[-InformationLevel] <PSPushoverInformationLevel>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

If you are collecting user tokens to register them to receive notifications, you may want to verify
that the key is valid before accepting it. Use the `Test-PushoverUser` cmdlet to ensure user tokens
are valid before sending notifications.

The information returned is detailed by default and includes the error text returned from the
Pushover API. For example, the error message may read "device name is not valid for user".

## EXAMPLES

### EXAMPLE 1

```powershell
if ($null -eq (Get-PushoverConfig).AppToken) {
    Set-PushoverConfig -Token (Read-Host -Prompt 'Pushover Application Token' -AsSecureString)
}
Test-PushoverUser -User (Read-Host -Prompt 'Pushover User Key' -AsSecureString)

<# Sample output
Valid    : False
IsGroup  : False
Devices  :
Licenses :
Error    : user key is invalid
#>
```

Checks whether the current user's Pushover config includes a default application token. If not, request the user to enter the application token
and save it for future use. Then request the Pushover user key and test whether the key is valid.

## PARAMETERS

### -Device

Optionally specifies the device on the user account to validate

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationLevel

Specifies the information level desired in the response.
Quiet means a boolean will be returned while Detailed will return an object with more information.

```yaml
Type: PSPushoverInformationLevel
Parameter Sets: (All)
Aliases:
Accepted values: Detailed, Quiet

Required: False
Position: 3
Default value: Detailed
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
Position: 0
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
Position: 1
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

### PSPushoverUserValidation

## NOTES

## RELATED LINKS
