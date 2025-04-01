#=================================================================================
# SSH connector
#
# Start a AWS SSM session with a forwarding template
#
# @arg String $connect_profile
# @arg String $instanceId
#================================================================================
# aws sso login --sso-session aws-inno-on;

# Cli args
$connectProfile=$args[0];
$instanceId = $args[1];
$radioButtonWslIsChecked = $args[2];
$radioButtonPowershellIsChecked = $args[3];

# Header
$text = "#================================================================================`n";
$text += "# spectrum8 Connector`n";
$text += "#`n";
$text += "# SSH`n";
$text += "#`n";
$text += "#================================================================================";
write-host $text -ForegroundColor Green;

# [Debug]
$text = '';
$text += "Target:  " + $instanceId + "`n";
$text += "`n";
$text += "Starting sso session...";
write-host $text;


# Check for SSH usage
if ($radioButtonWslIsChecked) {
    wsl -e export BROWSER='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe';
    wsl -e aws sso login --profile $connectProfile;
    wsl -e aws ssm start-session --region eu-central-1 --target "$instanceId" --profile $connectProfile;
}

if ($radioButtonPowershellIsChecked) {
    aws ssm start-session --region eu-central-1 --target "$instanceId" --profile $connectProfile;
}
