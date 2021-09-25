$w = [Environment]::GetFolderPath([System.Environment+SpecialFolder]::LocalApplicationData)
$v = "$w\BNSR\Saved\Config\WindowsNoEditor"
$kiwi = 'C:\Kiwi'
'Courtesy of kiwi :3'
if(!(Test-Path $kiwi))
{
    New-Item -Path 'C:/' -Name "Kiwi" -ItemType directory | Out-Null
}
if(!(Test-Path $kiwi\installed.txt -PathType leaf))
{
Invoke-WebRequest "https://raw.githubusercontent.com/kvy1/kiwi_installer/main/gameini" -UseBasicParsing -OutFile 'C:\Kiwi\game.txt'
$game = Get-Content -Path $kiwi\game.txt
Invoke-WebRequest "https://raw.githubusercontent.com/kvy1/kiwi_installer/main/inputini" -UseBasicParsing -OutFile 'C:\Kiwi\input.txt'
$zinput = Get-Content -Path $kiwi\input.txt
Invoke-WebRequest "https://raw.githubusercontent.com/kvy1/kiwi_installer/main/engineini" -UseBasicParsing -OutFile 'C:\Kiwi\engine.txt'
$engine = Get-Content -Path $kiwi\engine.txt

Add-Content -Path $v\Game.ini "`n"
foreach($line in $game)
{
    Add-Content -Path $v\Game.ini "$line"
}

Add-Content -Path $v\Input.ini "`n"
foreach($line in $zinput)
{
    Add-Content -Path $v\Input.ini "$line"
}

Add-Content -Path $v\Engine.ini "`n"
foreach($line in $engine)
{
    Add-Content -Path $v\Engine.ini "$line"
}

Add-Content -Path $kiwi\installed.txt "Installed"

Remove-Item -Path $kiwi\game.txt -Force
Remove-Item -Path $kiwi\input.txt -Force
Remove-Item -Path $kiwi\engine.txt -Force

'FINISHED! UWU'
}
else {
    'Already installed! If not then delete the installed.txt file in C:/Kiwi'
}
