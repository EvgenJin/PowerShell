# прочитать записи из csv
# програть поисковиком по логам в папке
# вытащить регуляркой нужный реквизит 
# записать в другой файл  
$csv = Import-Csv "C:\tmp\process.csv"
$folder = '\\10.26.232.39\log4j\rkk*'
$a = Get-ChildItem -Path $folder -recurse | Where-Object -FilterScript {($_.LastWriteTime -gt (get-date).AddDays(-25))}

function getmatch {
  Param ([string]$a)
  $a.Tostring() -match '(?<= IDB=")(\S+?)(?=")'
  $res = $matches[1]
  return $res
}

foreach ($item in $a) {
  foreach ($c in $csv) {      
    $res = Get-Content $item.FullName -Encoding UTF8 | Select-String $c.id.ToString()
    if ($res){
        #$res.Tostring -match '(?<= IDB=")(\S+?)(?=")'
        #$res.Tostring -match ' IDB="\S.+?"'
        #$m = $matches[0]
        #Write-Host $a' ---> '$c
        $m = getmatch -a $res
        Write-Host $item' --- > '$c.id ' -----> ' $m
        $c.id + ';' + $m -replace "True ","" >> "C:\tmp\pdn.txt"
        
    }       
  }
}
    
