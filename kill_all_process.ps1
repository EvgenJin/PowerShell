# менюшка завершения процессов с указанием потреблямой ОЗУ
Do {
  # всего памяти
  $os = Get-Ciminstance Win32_OperatingSystem
  # свободная память / всего 
  $pctFree = [math]::Round(($os.FreePhysicalMemory/$os.TotalVisibleMemorySize)*100,2) 
  $free = [math]::Round($os.FreePhysicalMemory/1024/1024)
  Write-Host "Free mem: "$pctFree"% ("$free "GB)" -ForegroundColor Green 
  Write-Host "What u want to kill?  => " -ForegroundColor Red -NoNewline

  $name = Read-Host
  Get-Process | Where-Object {$_.Path -like "*"+$name+"*"} | Stop-Process -Force -processname {$_.ProcessName}
}

while ($true)
