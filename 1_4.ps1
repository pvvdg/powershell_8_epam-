# 4.	������� ����� �� ��������

Get-Content machines.txt | ForEach-Object { $string += $_ + ',' }
$string = $string.Substring(0, $string.Length - 1) 
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $string

$parameters = @{
    ComputerName = (Get-Content Machines.txt)
    Credential   = 'k502'
    ScriptBlock  = { 
        New-Item -Path 'C:\' -Name "Directory" -ItemType "directory"
        New-SMBShare -Name SharedFolder `
            -Path 'C:\Directory' `
            -FullAccess 'k502'
        Get-SmbShare | Format-Table
    } 
}
Invoke-Command @parameters

