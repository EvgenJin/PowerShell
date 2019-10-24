# чтобы не закрывался
while($true){
    # адрес апи - можешь в бразуере запустить - увидишь все что есть
    $request =  'https://financialmodelingprep.com/api/v3/majors-indexes'
    $result = Invoke-WebRequest $request | ConvertFrom-Json
    # логика вся тут - в таблицу берет название индекса и цену ------------------------------------фильтровать индексы----
    #---------------------------------------------------------убери блок | Where тогда будет давать все что есть
    $res = $result.majorIndexesList | select indexName, price | Where-Object {$_.indexName -match 'Dow Jones|Nasdaq'} 
    echo $res
    # лупит каждую секунду - увеличивай если надо
    Start-Sleep 1
    # очищает экран, если убрать то будет все лепить друг за другом
    clear
}


