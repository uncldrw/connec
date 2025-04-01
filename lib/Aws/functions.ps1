#=================================================================================
# Get config data from specific account
#
# @param String $connectProfile
#================================================================================
function get-config-data {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $connectProfile
    )

    $portNumber = aws configure get port_number --profile $connectProfile;
    $localPortNumber = aws configure get local_port_number --profile $connectProfile;
    $rds = aws configure get rds --profile $connectProfile;

    #    $result = aws ec2 describe-instances `
    #        --filters "Name=instance-state-name,Values=running" "Name=tag:usablejumphost,Values=yes" `
    #        --profile $connectProfile | ConvertFrom-Json;
    #    $instanceId = $result.Reservations[0].Instances.InstanceId;

    $instances = aws ec2 describe-instances `
        --filters "Name=instance-state-name,Values=running" `
        --query "Reservations[].Instances[?((InstanceType!='t3.nano' && InstanceType!='t3a.nano') && Tags[?Key=='usablejumphost' && Value=='yes'])].InstanceId" `
        --profile $connectProfile | ConvertFrom-Json;

    $cleanedInstances = @();
    foreach ($id in $instances) {
        if ($id -ne '') {
            $cleanedInstances += $id;
        }
    }

    # Get random instance id from list
    $instanceId = Get-Random -InputObject $cleanedInstances;

    return @{
        'port_number' 		= $portNumber;
        'local_port_number' = $localPortNumber;
        'rds' 		        = $rds;
        'instance_id' 	    = $instanceId;
    };
}
