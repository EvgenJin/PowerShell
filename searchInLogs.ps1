#  grep по логам в каталоге
Do {
  # Write-Host "Где искать?  => " -ForegroundColor Green -NoNewline
  $folder = '\\10.26.232.39\log4j'
  Write-Host "Что искать?  => " -ForegroundColor Green -NoNewline
  # $folder = 'C:/tmp/logs'
  $a = Get-ChildItem -Path $folder\*log -recurse 
  $search = Read-Host
  foreach ($item in $a) {
    $res = Get-Content $item.FullName -Encoding UTF8 | Select-String $search
    if ($res){
      Write-Host $item.FullName' --> '$res
    } 
  }
}
while ($true)