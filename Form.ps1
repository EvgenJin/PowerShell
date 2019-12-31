    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    $guiForm = New-Object System.Windows.Forms.Form
    $guiForm.Text = "Форма"
    $guiForm.Size = New-Object System.Drawing.Size(800,400)
    $guiForm.StartPosition = "CenterScreen"
    #$guiForm.FormBorderStyle = "FixedDialog"
    #$guiForm.MaximizeBox = $false

    $Label = New-Object System.Windows.Forms.Label
    $Label.Text = "Путь к файлу"
    $Label.Location  = New-Object System.Drawing.Point(10,0)
    $Label.AutoSize = $true
    $guiForm.Controls.Add($Label)

    # Text
    $guiTextBoxFile = New-Object System.Windows.Forms.TextBox
    $guiTextBoxFile.Location = New-Object System.Drawing.Size(10,20)
    $guiTextBoxFile.Size = New-Object System.Drawing.Size(400,10)
    $guiForm.Controls.Add($guiTextBoxFile)

    # Button_open_file
    [System.Windows.Forms.Button]$guiButtonOpenFile = New-Object System.Windows.Forms.Button
    $guiButtonOpenFile.Location = New-Object System.Drawing.Size(415,10)
    $guiButtonOpenFile.Size = New-Object System.Drawing.Size(95,20)
    $guiButtonOpenFile.Text = "Выбрать файл"
    $guiForm.Controls.Add($guiButtonOpenFile)

    # Button_send_file
    [System.Windows.Forms.Button]$guiButtonSend = New-Object System.Windows.Forms.Button
    $guiButtonSend.Location = New-Object System.Drawing.Size(10,30)
    $guiButtonSend.Size = New-Object System.Drawing.Size(100,20)
    $guiButtonSend.Text = "Загрузить"
    $guiForm.Controls.Add($guiButtonSend)

    # result text
    $ResultTextBox = New-Object System.Windows.Forms.TextBox
    $ResultTextBox.Location  = New-Object System.Drawing.Point(10,60)
    $ResultTextBox.Size = New-Object System.Drawing.Size(400,10)
    $ResultTextBox.Text = ''
    $guiForm.Controls.Add($ResultTextBox)

    # OpenFileDialog
    $guiOpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $guiOpenFileDialog.initialDirectory = "c:\temp"
    $guiOpenFileDialog.filter = "All files (*.*)| *.*"
    $guiOpenFileDialog.initialDirectory = "c:"

 
    $guiButtonOpenFile.Add_Click(
        {
            $guiOpenFileDialog.ShowDialog()
            $guiTextBoxFile.Text = $guiOpenFileDialog.Filename
        }
    )

    $guiButtonSend.Add_Click(
        {
            $uri = "https://file.io"
            $myfile = $guiTextBoxFile.Text
            $fileBytes = [System.IO.File]::ReadAllBytes($myfile);
            $fileEnc = [System.Text.Encoding]::GetEncoding('UTF-8').GetString($fileBytes);
            $boundary = [guid]::NewGuid().ToString()
            $LF = "`r`n";

            $body = ( "--$boundary",
                      "Content-Disposition: form-data; name=`"file`"; filename=`"C:\SUService.log`"",
                      "Content-Type: application/octet-stream$LF",
                      #$myfile,
                      "--$boundary--$LF"
                     ) -join $LF
            $response = Invoke-RestMethod -Uri $uri -Method POST -ContentType "multipart/form-data; boundary=`"$boundary`"" -Body $body
            $ResultTextBox.Text = $response.link
        }
    )
    
    $guiForm.Add_Shown({$guiForm.Activate()})
    $guiForm.ShowDialog()