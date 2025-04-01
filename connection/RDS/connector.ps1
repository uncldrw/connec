#=================================================================================
# RDS connector
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
$connect_profile   = $args[0];
$port_number       = $args[1];
$local_port_number = $args[2];
$rds               = $args[3];
$instance_id       = $args[4];

# Header
$text = "#================================================================================`n";
$text += "# spectrum8 Connector`n";
$text += "#`n";
$text += "# RDS`n";
$text += "#`n";
$text += "#================================================================================";
write-host $text -ForegroundColor Green;

# [Debug]
$text = '';
$text += "Jumphost: " + $instance_id + "`n";
$text += "Local port " + $local_port_number + "`n";
$text += "Mapping port: " + $port_number + "`n";
$text += "Target:  " + $rds + " via 127.0.0.1`n";
$text += "`n";
$text += "Starting sso session...";
write-host $text;

# Start sso session
aws ssm start-session `
    --region "eu-central-1" `
    --target "$instance_id" `
    --document-name AWS-StartPortForwardingSessionToRemoteHost `
    --parameters host="$rds",portNumber="$port_number",localPortNumber="$local_port_number" `
    --profile $connect_profile `
	--cli-read-timeout 3600 `
	--cli-connect-timeout 3600;
