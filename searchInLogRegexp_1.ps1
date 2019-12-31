# прочитать записи из csv
# найти лог с той же датой изменения
# вытащить регуляркой нужный реквизит 
# записать в другой файл  
$csv = Import-Csv "C:\tmp\process2.csv" -Delimiter ";"
$folder = '\\10.26.232.39\log4j\rkk*'

function getmatch {
  Param ([string]$a)
  $a.Tostring() -match '(?<= IDB=")(\S+?)(?=")'
  $res = $matches[0]
  return $res
}

foreach ($line in $csv) {
    $file = Get-ChildItem -Path $folder -recurse | Where-Object -FilterScript {($_.LastWriteTime.ToString("dd.MM.yyyy") -eq $line.dat)}
    $content = Get-Content $file.FullName -Encoding UTF8 | Select-String $line.id.ToString()
    if ($content){
      $m = getmatch -a $content
      $m = $m -replace "True","" 
      Write-Host $line.id';'$m
    }
}