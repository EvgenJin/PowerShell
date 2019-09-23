# Имена папок в csv. Скрипт идет циклом по целевой папке и создает директорию если ее не существует 
# Создать каждому пользователю из файла каталог в сет ресурсе
$csv = Import-Csv "C:\tmp\process.csv"

foreach($item in $csv)
    {
        #$($item.login)
        if(!(Test-Path T:\$($item.login) -PathType Container)) { 
            New-Item -ItemType directory -Path T:\$($item.login)
            Write-Host T:\$($item.login) + 'created'
        } else {
            write-host $($item.login)+"-- Path found"
        }
    }