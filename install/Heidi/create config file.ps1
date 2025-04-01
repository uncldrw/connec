# Frage nach dem RDS IAM Datenbankbenutzer
$rdsIamUser = Read-Host "`nBitte geben Sie Ihren RDS IAM Datenbankbenutzer ein (vermutlich Kürzel-iam)"

# Hole den Windows Benutzernamen
$windowsUser = $env:USERNAME

# Lese die Inhalte von test.txt
$content = Get-Content -Path 'export_partial.txt' -Raw

# Ersetze ##RDS-IAM-USERNAME## und ##WINDOWS-USER-NAME## mit den entsprechenden Werten
$content = $content -replace '##RDS-IAM-USERNAME##', $rdsIamUser
$content = $content -replace '##WINDOWS-USER-NAME##', $windowsUser

# Speichere die modifizierte Datei unter einem neuen Namen
$content | Out-File -FilePath 'append_to_heidi_config.cfg' -Encoding utf8

Write-Host "Exportiere nun deine HeidiSQL einstellungen, füge den Inhalt aus append_to_heidi_config.cfg unten an und importiere diese erneut." -ForegroundColor Green;
