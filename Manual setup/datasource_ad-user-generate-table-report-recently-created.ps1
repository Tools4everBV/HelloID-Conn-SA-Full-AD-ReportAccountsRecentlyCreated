try {
    $lastDate = (Get-Date).AddDays(-30)
    $filter = {whenCreated -gt $lastDate}
    $properties = "CanonicalName", "Displayname", "UserPrincipalName", "SamAccountName", "Department", "Title", "Enabled", "whenCreated"
    
    $ous = $ADusersReportOU | ConvertFrom-Json
    $result = foreach($item in $ous) {
        Get-ADUser -Filter $filter -SearchBase $item.ou -Properties $properties
    }
    $resultCount = @($result).Count
    $result = $result | Sort-Object -Property whenCreated -Descending
    
    HID-Write-Status -Message "Result count: $resultCount" -Event Information
    HID-Write-Summary -Message "Result count: $resultCount" -Event Information
    
    if($resultCount -gt 0){
        foreach($r in $result){
            $returnObject = @{CanonicalName=$r.CanonicalName; Displayname=$r.Displayname; UserPrincipalName=$r.UserPrincipalName; SamAccountName=$r.SamAccountName; Department=$r.Department; Title=$r.Title; Enabled=$r.Enabled; whenCreated=$r.whenCreated;}
            Hid-Add-TaskResult -ResultValue $returnObject
        }
    } else {
        Hid-Add-TaskResult -ResultValue []
    }
    
} catch {
    HID-Write-Status -Message "Error generating report. Error: $($_.Exception.Message)" -Event Error
    HID-Write-Summary -Message "Error generating report" -Event Failed
    
    Hid-Add-TaskResult -ResultValue []
}