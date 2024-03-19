function ConvertTo-PlainText {
    [CmdletBinding()]
    param (
        # Specifies a securestring value to decrypt back to a plain text string
        [Parameter(Mandatory, ValueFromPipeline)]
        [securestring]
        $Value
    )

    process {
        ([pscredential]::new('unused', $Value)).GetNetworkCredential().Password
    }
}