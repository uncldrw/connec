#=================================================================================
# 	Spectrum8 connector
#
#	Funktions:
#	- connect to RDS databases via sso/ssm
#	- connect to SSH target instance
#
#	Author: c.rickert@spectrum8.de
#=================================================================================
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms");
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing");
[void][Reflection.Assembly]::LoadWithPartialName("PresentationCore");


#=================================================================================
# Xaml
#=================================================================================
$xaml = Get-Content "$pwd\xaml\skelleton.xaml";

#-replace wird benötigt, wenn XAML aus Visual Studio kopiert wird.
[xml]$XAML = $xaml -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window';

# Read XAML
$reader = New-Object System.Xml.XmlNodeReader $xaml;
$script:Form = [Windows.Markup.XamlReader]::Load($reader);

# Set custom icon
$Form.add_Loaded({
    $Form.Icon = Join-Path $PSScriptRoot "img\spectrum.ico"
})

# Store Form Objects In PowerShell
$xaml.SelectNodes("//*[@Name]") | ForEach-Object {Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}


#=================================================================================
# Init
#=================================================================================
aws sso login --sso-session aws-inno-on;

$script:style = $Form.tryFindResource("ButtonStyle");
$script:config = Get-Content "./config/config.json" | ConvertFrom-Json

# Modules
Import-Module $PSScriptRoot\config\accountMapping.ps1 -Force;
Import-Module $PSScriptRoot\lib\helpers.ps1 -Force;
Import-Module $PSScriptRoot\lib\Aws\functions.ps1 -Force;

Import-Module $PSScriptRoot\lib\grid.ps1 -Force;
Import-Module $PSScriptRoot\lib\labels.ps1 -Force;
Import-Module $PSScriptRoot\lib\buttons.ps1 -Force;
Import-Module $PSScriptRoot\lib\combobox.ps1 -Force;
Import-Module $PSScriptRoot\lib\borders.ps1 -Force;
Import-Module $PSScriptRoot\lib\textBlock.ps1 -Force;
Import-Module $PSScriptRoot\lib\textBox.ps1 -Force;
Import-Module $PSScriptRoot\lib\Messages\dialogs.ps1 -Force;
Import-Module $PSScriptRoot\lib\checkboxes.ps1 -Force;

# Hide windows for the current process
# Hide-Window 0;

#=================================================================================
# Layouts
#=================================================================================
Import-Module $PSScriptRoot\lib\Layout\tableLayout.ps1 -Force;
Import-Module $PSScriptRoot\lib\Layout\sshTableLayout.ps1 -Force;
Import-Module $PSScriptRoot\lib\Layout\rdpTableLayout.ps1 -Force;
Import-Module $PSScriptRoot\lib\Layout\devOpsTableLayout.ps1 -Force;
Import-Module $PSScriptRoot\lib\Layout\rdsLayout.ps1 -Force;
Import-Module $PSScriptRoot\lib\Layout\rdpLayout.ps1 -Force;
Import-Module $PSScriptRoot\lib\Layout\sshLayout.ps1 -Force;
Import-Module $PSScriptRoot\lib\Layout\devOpsLayout.ps1 -Force;
Import-Module $PSScriptRoot\lib\Layout\lgLayout.ps1 -Force;


#=================================================================================
# Events
#
# Place all event listener at the end!
#=================================================================================
Import-Module $PSScriptRoot\lib\Events\misc.ps1 -Force;
Import-Module $PSScriptRoot\lib\Events\ssh.ps1 -Force;
Import-Module $PSScriptRoot\lib\Events\rdp.ps1 -Force;
Import-Module $PSScriptRoot\lib\Events\devOps.ps1 -Force;
Import-Module $PSScriptRoot\lib\Events\lg.ps1 -Force;


#Show Form
$Form.ShowDialog() | out-null
