$search = 'Екатеринбург, Ирбитская 11'
$request =  'https://kladr-api.ru/api.php?query='+$search+'&oneString=1&limit=50&withParent=1'
Invoke-WebRequest $request |
ConvertFrom-Json |
select -expand result |
Select id, name, zip, okato, fullName, oktmo, parentGuid
# https://devblogs.microsoft.com/scripting/playing-with-json-and-powershell/