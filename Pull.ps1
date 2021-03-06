# Забрать файл с целевого ресурса
# пропускать все ошибки
# $ErrorActionPreference = "SilentlyContinue"
$ErrorActionPreference = "Stop"
Try 
{
   # цикл по всем выделенным файлам
   foreach ($argument in $args) {
    $file_loc_name = (Get-Item $argument).Name # локальный файл имя
    $file_loc = (Get-Item $argument).FullName # локальный файл полный путь
    $file_ser = 'Q:\BankXXI\zc\'+ (Get-Item $argument).Name # файл на сервере
    $dupdate_ser = (Get-Item $file_ser).LastWriteTime # дата изменения файла на Q
    $dupdate_loc = (Get-Item $argument).LastWriteTime # дата изменения файла на С
    #проверить существование файла на сервере
    if ($dupdate_ser) {
        if ($dupdate_loc -gt $dupdate_ser) {
            # сверить дату изменения локального и серверного файла , если локальный новее спросить
            Write-host "Файл "$file_loc_name" на сервере старее локального, заменить?" -ForegroundColor Yellow
            $Readhost = Read-Host "( y / n )"
            Switch ($ReadHost)
            {
                Y {Write-host "Файл скопирован из Q"; Copy-Item -Path $file_ser -Destination $file_loc}
                N {Write-Host "Файл не копировался из Q"} 
                Default {Write-Host "Файл "$file_ser" не скопирован"}
            }
            # если локальный старее просто копировать
        } else {
            Copy-Item -Path $file_ser -Destination $file_loc
            Write-host "Файл скопирован из Q"
        }
    # файла не существует копировать нечего
    } else {
        Write-Host 'Файла '(Get-Item $argument).Name' Нет на Q:/' -ForegroundColor Yellow
    }
   }
}
Catch [System.Management.Automation.ItemNotFoundException]
{
    Write-Host 'Файл не найден'
}
Finally
{

}