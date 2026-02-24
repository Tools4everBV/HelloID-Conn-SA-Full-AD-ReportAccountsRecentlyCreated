# HelloID-Conn-SA-Full-AD-ReportAccountsRecentlyCreated

| :information_source: Information                                                                                                                                                                                                                                                                                                                                                          |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements. |

## Description
_HelloID-Conn-SA-Full-AD-ReportAccountsRecentlyCreated_ is a template designed for use with HelloID Service Automation (SA) Delegated Forms. It can be imported into HelloID and customized according to your requirements. 

This HelloID Service Automation Delegated Form provides an Active Directory report containing the user accounts that have been created during the last 30 days. The following options are available:
 1. Overview of AD user accounts that have been created recently
 2. Download the report data to CSV format

## Getting started
### Requirements

- **HelloID Agent**:<br>
  A HelloID Agent is required to execute PowerShell commands against the on-premises Active Directory. The agent must be installed on a server that has network access to the Active Directory domain controllers and the appropriate permissions to query AD.

- **Active Directory PowerShell Module**:<br>
  The Active Directory PowerShell module must be installed on the server where the HelloID Agent is running. This module is part of the Remote Server Administration Tools (RSAT) and provides the cmdlets necessary to query Active Directory.

- **Active Directory Permissions**:<br>
  The account running the HelloID Agent service must have read permissions on the Active Directory organizational units (OUs) that will be queried for the report.

### Connection settings

The following user-defined variables are used by the connector.

| Setting         | Description                                                                                     | Mandatory |
|-----------------|-------------------------------------------------------------------------------------------------|-----------|
| AdUsersReportOu | Semicolon-separated list of AD OUs to search for accounts (e.g., "OU=Users,DC=domain,DC=local") | Yes       |

## Remarks

### Report Filter Criteria
- **Recently Created Accounts**: The report specifically identifies accounts where the `whenCreated` attribute is within the last 30 days. This helps track newly created user accounts for audit and compliance purposes.

### Performance Considerations
- **Multiple OU Search**: The data source searches through multiple OUs as specified in the `AdUsersReportOu` variable. If you have a large Active Directory environment with many OUs, consider limiting the scope to improve performance.

### CSV Download Feature
- **Client-Side Download**: The form includes a CSV download button that allows users to export the report data directly from their browser without requiring server-side file generation.

### No Task Actions
- **Report Only**: This delegated form is designed for reporting purposes only and does not perform any actions on the accounts. The task script is a placeholder that performs no operations.

## Development resources

### PowerShell Cmdlets

The following PowerShell cmdlets are used by the connector:

| Cmdlet     | Description                              |
|------------|------------------------------------------|
| Get-ADUser | Retrieves Active Directory user accounts |

### API documentation

This connector uses the Active Directory PowerShell module which is part of Microsoft's Remote Server Administration Tools (RSAT). For more information, see the [Microsoft Active Directory PowerShell documentation](https://docs.microsoft.com/en-us/powershell/module/activedirectory/).

## Getting help
> :bulb: **Tip:**  
> _For more information on Delegated Forms, please refer to our [documentation](https://docs.helloid.com/en/service-automation/delegated-forms.html) pages_.

## HelloID docs
The official HelloID documentation can be found at: https://docs.helloid.com/