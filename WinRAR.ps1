## Прокинуть параметром путь до файла (fpath), дату начала (dbeg) , дату конца (dend), пароль (010101)
## C:\Projects> powershell.exe -file C:\Projects\Скрипты\WinRAR.ps1 -fpath C:\temp\UND_SEND.xlsm -dbeg 0809 -dend 1010 -pass 010101
param([string]$fpath, [string]$path, [string]$pass)
$rar = "C:\Program Files\WinRAR\rar.exe"
# задать пароль
$pass = "-hp" + $pass
# задать имя файла
$fn = "Уральский. Выдачи_"+$dbeg+"_"+$dend
# задать путь выходного архива
# $rarname= (Split-Path $fpath) + "\" + $fn + ".rar"
# $rarname= (Split-Path $fpath) + "\" + $fn + ".rar"

# архивировать
&$rar a -ep1 -m5 $pass $path $fpath


#  a архивировать
# -hp добавить пароль
# -m степень от 1 до 5


# $start_day_fn = (Get-Date).AddDays(-7).ToString("ddMM")
# $end_day_fn = (Get-Date).ToString("ddMM")
# $file_in = "C:\temp\UND_SEND.xlsm"
# $pass = "-hp" + (Get-Date -Format ddMMyyyy)