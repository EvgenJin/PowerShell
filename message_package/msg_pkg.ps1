# add the required .NET assembly:
Add-Type -AssemblyName System.Windows.Forms
$search = 'Екатеринбург, Ирбитская 11'
$request =  'https://kladr-api.ru/api.php?query='+$search+'&oneString=1&limit=50&withParent=0'
$res = Invoke-WebRequest $request
$result = $res | ConvertFrom-Json | select -expand result | Select id, name, zip, okato, fullName, oktmo, parentGuid
$result.Count
[System.Windows.Forms.MessageBox]::Show("Развалено пакетов: "+ $result.Count, "Развал пакетов");







# show the MsgBox:
#$result = [System.Windows.Forms.MessageBox]::Show('Do you want to restart?', 'Warning', 'YesNo', 'Warning')
# # check the result:
# if ($result -eq 'Yes')
# {
#   # Restart-Computer -WhatIf  
#   [System.Windows.Forms.MessageBox]::Show('Do you want to restart?', 'Warning', 'YesNo', 'Warning')
# }
# else
# {
#   # Write-Warning 'Skipping Restart'
# }
