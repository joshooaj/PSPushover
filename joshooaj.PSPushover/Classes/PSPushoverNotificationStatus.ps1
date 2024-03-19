class PSPushoverNotificationStatus {
    [string]$Receipt
    [bool]$Acknowledged
    [datetime]$AcknowledgedAt
    [string]$AcknowledgedBy
    [string]$AcknowledgedByDevice
    [datetime]$LastDeliveredAt
    [bool]$Expired
    [datetime]$ExpiresAt
    [bool]$CalledBack
    [datetime]$CalledBackAt
}
