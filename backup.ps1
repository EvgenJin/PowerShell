# сохранение файлов где дата изменения = прошлые 10 дней
$target = Get-ChildItem -Path C:\Users\eshahov\Documents\SQL -Force -Recurse | Where-Object -FilterScript {($_.LastWriteTime -gt (get-date).AddDays(-10))}
$backup = "H:\backup\SQL"

foreach ($item in $target)
{
    if (!$item.PSIsContainer) {
        Copy-Item -Path $item.FullName -Destination $backup -Force
    }
}