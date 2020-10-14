$ProgramName = "*Blade & Soul*"
$link = "https://www.bladeandsoul.com"
$install = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\*\Products\*\InstallProperties" | Where-Object { $_.getValue('DisplayName') -like $ProgramName } | Where-Object { $_.getValue('HelpLink') -like $link } | ForEach-Object { $_.getValue('InstallLocation') }
$x = $install

'Courtesy of kiwi :3'

$Urly = "https://raw.githubusercontent.com/kvy1/kiwi/master/git.txt"
$ZipFiley = 'url.txt'
$Destination= $x
Invoke-WebRequest -Uri $Urly -OutFile $x\$ZipFiley
$Url = Get-Content -Path $x\$ZipFiley
$ZipFile = 'bnspatch.zip'
$Destination= $x
Invoke-WebRequest -Uri $Url -OutFile $x\$ZipFile 
Expand-Archive -Path $x\$ZipFile -DestinationPath $x -Force
Expand-Archive -Force -Path $x\Public\bnspatch.zip -DestinationPath $x
Expand-Archive -Force -Path $x\Public\highpriority.zip -DestinationPath $x
Expand-Archive -Force -Path $x\Public\lessloadingscreens.zip -DestinationPath $x
Expand-Archive -Force -Path $x\Public\pluginloader.zip -DestinationPath $x
Expand-Archive -Force -Path $x\Public\simplemodetrainingroom.zip -DestinationPath $x

$w = [Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments)

Move-Item -Path $x'\Public\patches.xml' -Destination $w'\bns' -Force

if(!(Test-Path $w'\bns\addons'))
{
New-Item -Path $w'\bns' -Name "addons" -ItemType "directory"
}
if(!(Test-Path $w'\bns\patches'))
{
New-Item -Path $w'\bns' -Name "patches" -ItemType "directory"
}
if(!(Test-Path $w'\bns\patches'))
{
New-Item -Path $w'\bns' -Name "patches" -ItemType "directory"
}
Remove-Item $x\$ZipFile
Remove-Item $x\Public -recurse -Force
Remove-Item $x\url.txt -Force

Read-Host "Finished uwu :3"
