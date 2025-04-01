if (Get-Module -ListAvailable -Name "ps2exe") {
    Write-Host "Module exists"
} 
else {
    Write-Host "Module does not exist"
}