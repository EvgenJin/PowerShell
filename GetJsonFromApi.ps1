$search = 'Екатеринбург, Ирбитская 11'
$request =  'https://kladr-api.ru/api.php?query='+$search+'&oneString=1&limit=50&withParent=0'
Invoke-WebRequest $request |
ConvertFrom-Json |
select -expand result |
Select id, name, zip, okato, fullName, oktmo, parentGuid