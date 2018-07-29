#First 3 are for connecting to the Office 365 powershell:
#1. Open a promt for username and password to be used
$UserCredential = Get-Credential
#2. sets the ground for connection to Office365:
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
#3. Establishes the connection:
Import-PSSession $Session -DisableNameChecking

#4. Choose ONE of the following (Not both!!):
#Option A: For a file with a simple list, can be TXT or CSV or XML etc. - Read each line as an object (Foreach-object).
Get-Content "C:\folder\subfolder\csvfile.csv"| ForEach-Object {Add-DistributionGroupMember -Identity "group_name" -Member "$_"}


#Option B: For a CSV File without header - that is IDENTICAL to a simple file like option 1, but IS a CSV file:
Import-Csv 'C:\folder\subfolder\csvfile.csv' -Header "Mail" | ForEach-Object { Add-DistributionGroupMember -Identity "group_name" -Member $_.mail} 

#Set retention policy for users in this group (Need a policy to be created in the 365 UI first):
Get-DistributionGroupMember "group_name" | Set-Mailbox -RetentionPolicy "retention_policy"