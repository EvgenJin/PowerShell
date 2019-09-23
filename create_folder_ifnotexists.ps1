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