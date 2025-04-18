#=================================================================================
# RDP connector
#
# Start a AWS SSM session with a forwarding template
#
# @arg String $connect_profile
# @arg String $port_number
# @arg String $local_port_number
# @arg String $rds
# @arg String $instance_id
#================================================================================
# aws sso login --sso-session aws-inno-on;

# Cli Args
$connect_profile    = $args[0];
$port_number        = $args[1];
$local_port_number  = $args[2];
$instance_id        = $args[3];

$rdp                = aws ec2 describe-instances `
    --instance-ids $instance_id `
    --query "Reservations[0].Instances[0].NetworkInterfaces[0].PrivateDnsName" `
    --profile $connect_profile;

# Header
$text = "#================================================================================`n";
$text += "# spectrum8 Connector`n";
$text += "#`n";
$text += "# RDP`n";
$text += "#`n";
$text += "#================================================================================";
write-host $text -ForegroundColor Green;

# [Debug]
$text = '';
$text += "Jumphost: " + $instance_id + "`n";
$text += "Local port " + $local_port_number + "`n";
$text += "Mapping port: " + $port_number + "`n";
$text += "Target:  " + $rdp + " via 127.0.0.1`n";
$text += "`n";
$text += "Starting sso session...";
write-host $text;

# Start sso session
aws ssm start-session `
    --region eu-central-1 `
    --target "$instance_id" `
    --document-name AWS-StartPortForwardingSessionToRemoteHost `
    --parameters host="$rdp",portNumber="$port_number",localPortNumber="$local_port_number" `
    --profile $connect_profile;
