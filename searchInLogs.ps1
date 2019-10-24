#  grep по логам в каталоге
Do {
  # Write-Host "Где искать?  => " -ForegroundColor Green -NoNewline
  $folder = '\\10.26.232.39\log4j'
  Write-Host "Что искать в 10.26.232.39\log4j ?  => " -ForegroundColor Green -NoNewline
  $search = Read-Host
  Write-Host "Сколько дней погружение ?  => " -ForegroundColor Green -NoNewline
  $days = Read-Host
  # $folder = 'C:/tmp/logs'
  # $folder\*log
  $a = Get-ChildItem -Path $folder -recurse | Where-Object -FilterScript {($_.LastWriteTime -gt (get-date).AddDays(-$days))}
  
  foreach ($item in $a) {
    $res = Get-Content $item.FullName -Encoding UTF8 | Select-String $search
    if ($res){
      Write-Host $item.FullName
      Write-Host $res
      Write-Host "------------end----------------------"	
    } 
  }
}
while ($true)