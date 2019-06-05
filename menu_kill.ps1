Do {
  # всего памяти
  $os = Get-Ciminstance Win32_OperatingSystem
  # свободная память / всего 
  $pctFree = [math]::Round(($os.FreePhysicalMemory/$os.TotalVisibleMemorySize)*100,2) 
  $free = [math]::Round($os.FreePhysicalMemory/1024/1024)  
  # массив 
  $ProcArray = @()
  # получить процессы с группировкой
  $Processes = get-process | Group-Object -Property ProcessName
  # цикл по всем процессам 
  foreach($Process in $Processes) {
        $prop = @(
                @{n='Count';e={$Process.Count}}
                @{n='Name';e={$Process.Name}}
                @{n='Memory';e={($Process.Group|Measure WorkingSet -Sum).Sum/1024/1024}}
                )
        $ProcArray += "" | Select-Object $prop
  }
  # новый массив фильтр по тем кто занимает больше 200 метров
  # | Where-Object -FilterScript {($_.Memory) -gt 200}
  $ProcArray1 = $ProcArray| Where-Object -FilterScript {($_.Memory) -gt 200} | Select-Object Count,Name,@{n='Memory';e={"$(($_.Memory).ToString('N0'))mb"}}
  Write-Host "Свободная память: "$pctFree"% ("$free "GB)" -ForegroundColor Green 
  Write-Host "Процессы, занимающие больше 200 метров памяти" -ForegroundColor Red
  # инициализация массива меню
  # Write-Host $ProcArray1
  $menu = @{}
  # цикл по всем объектам 
  for ($i=1;$i -le $ProcArray1.count; $i++)
  {
    # -and $($ProcArray1[$i-1].Memory -gt 200)
    if (@("svchost","ekrn") -NotContains $($ProcArray1[$i-1].Name) -and $($ProcArray1[$i-1].Name -gt '')) {
      Write-Host "$i. $($ProcArray1[$i-1].Name), $($ProcArray1[$i-1].Memory)" -ForegroundColor Green
      $menu.Add($i,($ProcArray1[$i-1].Name))
    }
  }
  
  if ($menu.Count -eq 0) {Write-Host "Нет прожорливых процессов" -ForegroundColor Cyan}
  
  [int]$ans = Read-Host 'Какой процесс убить?'
  $selection = $menu.Item($ans);
  # если выбор не пустой запустить закрытие процесса
  if ($selection -gt '') {
    Get-Process | Where-Object {$_.Path -like "*"+$selection+"*"} | Stop-Process -Force -processname {$_.ProcessName}
  }
}
# гонять бесконечно
while ($true)




