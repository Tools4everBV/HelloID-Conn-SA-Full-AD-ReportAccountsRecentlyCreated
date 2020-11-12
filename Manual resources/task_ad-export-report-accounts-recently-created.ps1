try {
    if($exportReport -eq "True") {
        ## export file properties
        if($HIDreportFolder.EndsWith("\") -eq $false){
            $HIDreportFolder = $HIDreportFolder + "\"
        }
        
        $timeStamp = $(get-date -f yyyyMMddHHmmss)
        $exportFile = $HIDreportFolder + "Report_AD_AccountsRecentlyCreated_" + $timeStamp + ".csv"
        
        ## Report details
        $lastDate = (Get-Date).AddDays(-30)
        $filter = {whenCreated -gt $lastDate}
        $properties = "CanonicalName", "Displayname", "UserPrincipalName", "SamAccountName", "Department", "Title", "Enabled", "whenCreated"
        
        $ous = $ADusersReportOU | ConvertFrom-Json
        $result = foreach($item in $ous) {
            Get-ADUser -Filter $filter -SearchBase $item.ou -Properties $properties
        }
        $resultCount = @($result).Count
        $result = $result | Sort-Object -Property whenCreated -Descending
        
        ## export details
        $exportData = @()
        if($resultCount -gt 0){
            foreach($r in $result){
                $exportData += [pscustomobject]@{
                    "CanonicalName" = $r.CanonicalName;
                    "Displayname" = $r.Displayname;
                    "UserPrincipalName" = $r.UserPrincipalName;
                    "SamAccountName" = $r.SamAccountName;
                    "Department" = $r.Department;
                    "Title" = $r.Title;
                    "Enabled" = $r.Enabled;
                    "whenCreated" = $r.whenCreated;
                }
            }
        }
        
        $exportCount = @($exportData).Count
        HID-Write-Status -Message "Export row count: $exportCount" -Event Information
        
        $exportData = $exportData | Sort-Object -Property productName, userName
        $exportData | Export-Csv -Path $exportFile -Delimiter ";" -NoTypeInformation
        
        HID-Write-Status -Message "Report [$exportFile] containing $exportCount records created successfully" -Event Success
        HID-Write-Summary -Message "Report [$exportFile] containing $exportCount records created successfully" -Event Success
    }
} catch {
    HID-Write-Status -Message "Error generating report. Error: $($_.Exception.Message)" -Event Error
    HID-Write-Summary -Message "Error generating report" -Event Failed
    
    Hid-Add-TaskResult -ResultValue []
}