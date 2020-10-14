$ProgramName = "*Blade & Soul*"
$link = "https://www.bladeandsoul.com"
$install = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\*\Products\*\InstallProperties" | Where-Object { $_.getValue('DisplayName') -like $ProgramName } | Where-Object { $_.getValue('HelpLink') -like $link } | ForEach-Object { $_.getValue('InstallLocation') }
$x = $install
'Courtesy of kiwi :3'
$Urly = "https://raw.githubusercontent.com/kvy1/kiwi/master/public.txt"
$ZipFiley = 'url.txt'
$Destination= $x
Invoke-WebRequest -Uri $Urly -OutFile $x\$ZipFiley
$Url = Get-Content -Path $x\$ZipFiley
$ZipFile = 'bnspatch.zip'
$Destination= $x
Invoke-WebRequest -Uri $Url -OutFile $x\$ZipFile 
Expand-Archive -Path $x\$ZipFile -DestinationPath $x -Force
$w = [Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments)
if(!(Test-Path $w'\bns\patches.xml' -PathType leaf))
{
Move-Item -Path $x'\patches.xml' -Destination $w'\bns' -Force
}
if(!(Test-Path $w'\bns\addons'))
{
New-Item -Path $w'\bns' -Name "addons" -ItemType "directory"
}
if(!(Test-Path $w'\bns\patches'))
{
New-Item -Path $w'\bns' -Name "patches" -ItemType "directory"
}
Move-Item -Path $x'\use-ingame-login.xml' -Destination $w'\bns\patches' -Force
Remove-Item $x\$ZipFile
Remove-Item $x\url.txt -Force
Remove-Item $x\patches.xml -Force
