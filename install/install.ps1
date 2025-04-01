$text =     "#================================================================================#`n";
$text +=    "#                                                                                #`n";
$text +=    "#                          spectrum8 connector v1.2                              #`n";
$text +=    "#                                                                                #`n";
$text +=    "#                                   Install                                      #`n";
$text +=    "#                                                                                #`n";
$text +=    "#================================================================================#";
write-host $text -ForegroundColor Green;

#=================================================================================
# Init
#=================================================================================
$scriptDir = if (-not $PSScriptRoot) { Split-Path -Parent (Convert-Path ([environment]::GetCommandLineArgs()[0])) } else { $PSScriptRoot }
$script:config = Get-Content "./config/config.json" | ConvertFrom-Json
$script:accountMap = @{
    "c.rickert@spectrum8.de"    = 'cri-iam';
    "sh.kriebel@spectrum8.de"   = 'shk-iam';
    "b.otte@spectrum8.de"       = 'bot-iam';
    "h.leweling@spectrum8.de"   = 'hle-iam';
    "j.bullmann@spectrum8.de"   = 'jbu-iam';
    "j.hoang@spectrum8.de"      = 'dho-iam';
    "jf.michels@spectrum8.de"   = 'jfm-iam';
    "k.daniels@spectrum8.de"    = 'kda-iam';
    "g.erhardt@spectrum8.de"    = 'ger-iam';
    "m.fanous@spectrum8.de"     = 'mfa-iam';
    "m.wegen@spectrum8.de"      = 'mwe-iam';
    "t.pousen@spectrum8.de"     = 'tpo-iam';
    "v.mischke@spectrum8.de"    = 'vmi-iam';
    "y.buschmeyer@spectrum8.de" = 'ybu-iam';
    "p.wolff@spectrum8.de"      = 'pwo-iam';
    "m.casao@spectrum8.de"      = 'mca-iam';
}

mkdir downloads

#=================================================================================
# AWS SDK & Co
#=================================================================================
if (!(Get-Command "aws" -errorAction SilentlyContinue))
{
    write-host "Downloading AWS ClIv2";
    Invoke-WebRequest https://awscli.amazonaws.com/AWSCLIV2.msi -OutFile "downloads/awscli.msi";

    write-host "Installing AWS CLIv2";
    Start-Process "downloads/awscli.msi" -Wait;

    write-host "OK" -ForegroundColor Green;
}

# Install session manager plugin
if (!(Get-Command "session-manager-plugin" -errorAction SilentlyContinue))
{
    write-host "Downloading Session-Manager Plugin";
    Invoke-WebRequest https://s3.amazonaws.com/session-manager-downloads/plugin/latest/windows/SessionManagerPluginSetup.exe `
    -OutFile "downloads/session-manager-plugin.exe";

    write-host "Installing Session-Manager Plugin";
    Start-Process "downloads/session-manager-plugin.exe" -Wait;
    wsl -e "sudo apt update && sudo apt get session-manager-plugin -y";

    write-host "OK" -ForegroundColor Green;
}

#=================================================================================
# Connector shortcut
#=================================================================================
# Ask for target path
$shortcutTarget = [Environment]::GetFolderPath("Desktop");
$testPath = Test-Path -Path "$shortcutTarget";

while ($testPath -ne $true) {
    write-host "Unable to find [$shortcutTarget] path in filesystem";
    $shortcutTarget = Read-Host "Please enter a valid path:";

    $testPath = Test-Path -Path "$shortcutTarget";
}

# Create shortcut
$WshShell = New-Object -comObject WScript.Shell;
$shortcut = $WshShell.CreateShortcut($($shortcutTarget + "/spectrum8_connector_v1.2.lnk"));
$shortcut.TargetPath = "C:\Windows\System32\cmd.exe";
$shortcut.Arguments =  "/c start /min powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File $pwd/connector.ps1";
$shortcut.WorkingDirectory = "$pwd";
$shortcut.IconLocation = "C:\windows\system32\Shell32.dll,18";
$Shortcut.Save();

write-host "Creating shortcut in path: $shortcutTarget";
write-host "OK" -ForegroundColor Green;

#=================================================================================
# Setup json config
#=================================================================================
# Get identify AD user
$aduser = whoami /upn;
$dbuser = $accountMap.$aduser;

# Set new config with right creds
write-host "Writing aduser [$dbuser] to config";
$i = 0;
foreach($rds in $config.rds) {
    $config.rds[$i].username = $dbuser;

    $i++;
}
write-host "OK" -ForegroundColor Green;

# Ask for api_key
$api_key = read-host "Please enter your api_key:";
while ($api_key -eq '') {
    write-host "The entered api_key seems to be empty";
    $api_key = read-host "Please enter your api_key:";
}

write-host "Writing api_key [$api_key] to config";
$config.lg.api_key = $api_key;
write-host "OK" -ForegroundColor Green;

# Write config to file
write-host "Writing config to file";
$config | ConvertTo-Json -Depth 5 | Out-File $scriptDir\config\config.json;
write-host "OK" -ForegroundColor Green;

#=================================================================================
# Heidi cfg
#=================================================================================
# Frage nach dem RDS IAM Datenbankbenutzer
$rdsIamUser = Read-Host "`nPlease enter your Heidi login name (<user shortcut>-iam):"

# Hole den Windows Benutzernamen
$windowsUser = $env:USERNAME

# Lese die Inhalte von test.txt
$content = Get-Content -Path $scriptDir\install\Heidi\export_partial.txt -Raw

# Ersetze ##RDS-IAM-USERNAME## und ##WINDOWS-USER-NAME## mit den entsprechenden Werten
$content = $content -replace '##RDS-IAM-USERNAME##', $rdsIamUser
$content = $content -replace '##WINDOWS-USER-NAME##', $windowsUser

# Speichere die modifizierte Datei unter einem neuen Namen
$content | Out-File -FilePath $scriptDir\install\Heidi\append_to_heidi_config.cfg -Encoding utf8

Write-Host "Please export your Heidi config file and append install\Heidi\append_to_heidi_config.cfg. Don't forget to reimport your new config!" -ForegroundColor Green;

# Finished
read-host "Press any Key to exit...";
exit;
