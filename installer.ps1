Function Get-Folder($initialDirectory="")

{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select Your BNS Folder"
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if($foldername.ShowDialog() -eq "OK")
    {
        $x += $foldername.SelectedPath
    }
    return $x
}

$x = Get-Folder

if(!(Test-Path $x'\bin'))
{
Write-Host "Wrong Folder"
}
else
{
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
}
