# ���������� ������ word ����� ��������
$directorypath = $PSScriptRoot
Write-Host $directorypath
	Write-Host "��� ������ �� ������?  => " 
	$name = Read-Host
	Write-Host "������ �����?  => "
	$date = Read-Host
	Write-Host "������� �����?  => "
	$hourse = Read-Host

     $word = New-Object -ComObject "Word.application"
     $doc = $word.Documents.add($PSScriptRoot+'/template.dot')
     $doc.FormFields.Item('FIO').Result = $name
     $doc.FormFields.Item('DATE').Result = $date
     $doc.FormFields.Item('HOURS').Result = $hourse
     $file = $PSScriptRoot+"/template.doc"
     $doc.SaveAs([ref]$file)
     $Word.Quit()
