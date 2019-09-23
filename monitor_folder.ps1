# триггер на изменение файлов в папке
$pathtomonitor = "C:\tmp"
$timeout = -1

$FileSystemWatcher = New-Object System.IO.FileSystemWatcher $pathtomonitor
$FileSystemWatcher.IncludeSubdirectories = $true

Write-Host "Мониторю изменения в: $PathToMonitor + $env:username"
while ($true) {
  $change = $FileSystemWatcher.WaitForChanged('All', $timeout)
  if ($change.TimedOut -eq $false)
  {
      Write-Host "Изменение зафиксировано:"
      $change | Out-Default
      (Get-Date), $change.ChangeType.ToString(), $change.Name
        $wshell = New-Object -ComObject Wscript.Shell
        $Output = $wshell.Popup("Файл "+$change.Name+" изменен!")
        Write-Host $change
        # [System.Windows.Forms.MessageBox]::Show($Result.Name,"Появился новый файл", [System.Windows.Forms.MessageBoxButtons]::OK)
   }
  else
  {
      Write-Host "." -NoNewline
  }
 }