#=================================================================================
# Set data
# 
# Table layout data row with button on the right column
#
# @param Grid $grid
# @param Array $names
# @param Array $thickness
# @param Int $cols
#================================================================================
function set-ssh-data
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $instances,
        [Parameter(Mandatory)][array] $names,
        [Parameter(Mandatory)][array] $thickness,
        [Parameter(Mandatory)][int] $cols,
        [Parameter(Mandatory)][array] $width,
        [Parameter(Mandatory)][array] $foreground
    )

    $i = 4;
    $c = 1;

    ForEach ($instance in $instances) {
        $instanceId = $instance[0];
        $instanceName = $instance[1];

        # [Debug]
        # write-host $instanceId;
        # write-host $instanceName;

        $content = @($instanceName, $instanceId, " ");

        # Table like background
        if ($c % 2 -eq 0) { $background = "#FFE5E5E5"; } 
        else { $background = "lightgray"; }

        for ($z=0; $z -lt $cols; $z++) {
            $name = $names[$z];

            if ($z -eq ($cols-1)) {
                # Connect button
                $border = set-border `
                    -grid $grid `
                    -borderBrush "#FFB5B5D8" `
                    -thickness $thickness[$z] `
                    -height 40 `
                    -width $width[$z] `
                    -background $background `
                    -row $i `
                    -col $z `
                    -type "col";

                $tmpInstanceId = $instanceId.replace("-", "_");
                $button = set-connect-button `
                    -name $("ssh_" + $tmpInstanceId + "_" + $c) `
                    -foreground $foreground[$z] `
                    -width 150 `
                    -height 30 `
                    -content "Connect";

                Set-Variable -Name $("ssh_" + $tmpInstanceId + "_" + $c) -Value $button -scope "script";

                $grid.AddChild($border);
                $border.AddChild($button);

                # Add Click event
                $button.Add_Click({
                    $splitName = $this.name.split("_");
                    $instanceId = $splitName[1] + "-" + $splitName[2];
        
                    # Start AWS command in new window
                    wt --window 0 -p "Windows Powershell" `
                        -d "$pwd" `
                        powershell `
                        -noExit `
                        "$($sshConnectAccount.command) $($sshConnectAccount.profile) $instanceId $($radioButtonWsl.IsChecked) $($radioButtonPowershell.IsChecked)";
                });
                
            } else {
                $border = set-border `
                    -grid $grid `
                    -borderBrush "#FFB5B5D8" `
                    -thickness $thickness[$z] `
                    -height 40 `
                    -width $width[$z] `
                    -background $background `
                    -row $i `
                    -col $z `
                    -type "col";

                $label = set-text-block `
                    -name $($name + "_" + $c) `
                    -foreground $foreground[$z] `
                    -fontSize 14 `
                    -fontWeight "Regular" `
                    -horizontalAlignment "Left" `
                    -verticalAlignment "Center" `
                    -text $content[$z] `
                    -margin "5,5,5,5";

                Set-Variable -Name $($name + "_" + $c) -Value $label -scope "script";

                $grid.AddChild($border);
                $border.AddChild($label);
            }
        }

        $i+=2;
        $c++;
    }
}
