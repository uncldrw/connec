#aws sso login --sso-session aws-inno-on;
#aws ssm start-session --region eu-central-1 --target "i-0e3a58cf293195cc4" --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="pre-prod-backend-database-20210201070559962100000004.cryil3lukuje.eu-central-1.rds.amazonaws.com",portNumber="3306",localPortNumber="13303" --profile AWSAdministratorAccess-880356245698;

    $result = aws ec2 describe-instances `
        --filters "Name=instance-state-name,Values=running" "Name=tag:usablejumphost,Values=yes" `
        --max-items=1 `
        --profile AWSAdministratorAccess-880356245698 | ConvertFrom-Json;

    write-host $result;

#Write-Host "testing";