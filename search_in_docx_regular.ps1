$Word = New-Object -ComObject Word.Application
$Document = $Word.Documents.Open('Q:\BankXXI\TEMPLATE.WORD\kred_dog\2014\Ипотека\ЗАКЛАДНЫЕ\20.04.2017\ЗАКЛАДНАЯ_СОЗАЕМ1_2_3_КВАРТ.dot')
$range = $Document.content

$Document.Paragraphs | ForEach-Object {
    $string = $_.Range.Text
    ($string| select-string "{\D+?}" -allmatches).Matches.Value
}

$Word.Documents.Close($false)

