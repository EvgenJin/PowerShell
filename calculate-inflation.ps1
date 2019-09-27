$Start = '2014/12/15'
$end = '2019/09/24'
$amount = 36800
$type = 'price' #value
# price - изменение цены value - изменение стоимости денег
$request =  'https://www.statbureau.org/calculate-inflation-'+$type+'-json?country=russia&start='+$Start+'&end='+$end+'&amount='+$amount+'&format=false'
Invoke-WebRequest $request |
ConvertFrom-Json