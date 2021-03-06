# пропускать все ошибки
$ErrorActionPreference = "Continue"
Try 
{
  #   проверить существование папки с сейвами, если не создана - создать
  $dateStr = (Get-Date).ToString('yyyyMMdd')
  $save_folder = 'Q:\BankXXI\zc\save\'+$dateStr  
  $isFolder = Test-Path $save_folder
    if($isFolder -eq "True") {
        Write-host "Папка сейов существует" -ForegroundColor Yellow 
    }
    else {
        Write-host "Создана папка сейвов "$save_folder -ForegroundColor Yellow 
        New-Item -Path $save_folder -ItemType "directory"
    }   
   # цикл по всем выделенным файлам
   foreach ($argument in $args) {
       # получить имя выбранных файлов и составить их путь на сервере
       $file_loc = (Get-Item $argument).FullName #локальный файл полный путь
       $file_ser = 'Q:\BankXXI\zc\'+ (Get-Item $argument).Name #файл на сервере полный путь
       $file_ser_name = (Get-Item $file_ser).Name
       # вычислить дату изменения
       $dupdate_loc = (Get-Item $argument).LastWriteTime
       $dupdate_ser = (Get-Item $file_ser).LastWriteTime
       # файла на сервере может не быть - тогда просто копировать
       if (!$dupdate_ser) {
        Copy-Item -Path $file_loc -Destination $file_ser
       }
       # сравнить дату изменения , если новее заменить
           else {
               if ($dupdate_loc -gt $dupdate_ser) {
                Copy-Item -Path $file_ser -Destination $save_folder'\'$file_ser_name
                Write-Host $file_ser_name' от '$dupdate_ser' перенесен в '$save_folder
                Copy-Item -Path $file_loc -Destination $file_ser;
                Write-Host $file_ser_name' от '$dupdate_loc' перенесен на Q'
               # локальный файл старее - ничего не делать
               } else {Write-Host $file_loc + 'старее чем' + $file_ser}
           }
   }
}
Catch
{
    Write-Host $error[0].Exception
} 

Finally
{

}



# $PSCommandPath
# (Get-Item $PSCommandPath ).Extension
# (Get-Item $PSCommandPath ).Basename
# (Get-Item $PSCommandPath ).Name
# (Get-Item $PSCommandPath ).DirectoryName
# (Get-Item $PSCommandPath ).FullName
# $ConfigINI = (Get-Item $PSCommandPath ).DirectoryName+"\"+(Get-Item $PSCommandPath ).BaseName+".ini"
# $ConfigINI
