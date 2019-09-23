# заполнение шалона word через закладки
$directorypath = $PSScriptRoot
Write-Host $directorypath
	Write-Host "Кто пойдет на работу?  => " 
	$name = Read-Host
	Write-Host "Какого числа?  => "
	$date = Read-Host
	Write-Host "Сколько часов?  => "
	$hourse = Read-Host

     $word = New-Object -ComObject "Word.application"
     $doc = $word.Documents.add($PSScriptRoot+'/template.dot')
     $doc.FormFields.Item('FIO').Result = $name
     $doc.FormFields.Item('DATE').Result = $date
     $doc.FormFields.Item('HOURS').Result = $hourse
     $file = $PSScriptRoot+"/template.doc"
     $doc.SaveAs([ref]$file)
     $Word.Quit()
