#=================================================================================
# Set header
# 
# @param Grid $grid
# @param String $name
#================================================================================
function set-rdp-header
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $content,
        [Parameter(Mandatory)][string] $background,
        [Parameter(Mandatory)][int] $width
    )

    $border = set-border `
        -grid $grid `
        -borderBrush "#FFB5B5D8" `
        -thickness "1,1,1,1" `
        -height 40 `
        -width $width `
        -background $background `
        -row 0 `
        -col 4 `
        -type "colspan";

    $label = set-label `
        -name $name `
        -foreground "#FF5A5B65" `
        -fontSize 16 `
        -fontWeight "Bold" `
        -content $content `
        -horizontalAlignment "Center" `
        -verticalAlignment "Center";

    $grid.AddChild($border);
    $border.AddChild($label);
}

#=================================================================================
# Set sub header
# 
# @param Grid $grid
# @param Array $names
# @param Array $content
# @param Array $thickness
# @param Int $cols
# @param Int $row
#================================================================================
function set-rdp-sub-header
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $names,
        [Parameter(Mandatory)][array] $content,
        [Parameter(Mandatory)][array] $thickness,
        [Parameter(Mandatory)][int] $cols,
        [Parameter(Mandatory)][int] $row,
        [Parameter(Mandatory)][array] $width
    )

    for ($i=0; $i -lt $cols; $i++){ 
        $border = set-border `
            -grid $grid `
            -borderBrush "#FFB5B5D8" `
            -thickness $thickness[$i] `
            -height 30 `
            -width $width[$i] `
            -background "LightBlue" `
            -row $row `
            -col $i `
            -type "col";

        $label = set-label `
            -name $names[$i] `
            -foreground "#FF5A5B65" `
            -fontSize 14 `
            -fontWeight "Regular" `
            -content $content[$i] `
            -horizontalAlignment "Center" `
            -verticalAlignment "Center";

        $grid.AddChild($border);
        $border.AddChild($label);
    }
}

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
function set-rdp-data
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
                    -name $("rdp_" + $tmpInstanceId + "_" + $c) `
                    -foreground $foreground[$z] `
                    -width 150 `
                    -height 30 `
                    -content "Connect";

                Set-Variable -Name $("rdp_" + $tmpInstanceId + "_" + $c) -Value $button -scope "script";

                $grid.AddChild($border);
                $border.AddChild($button);

                # Add Click event
                $button.Add_Click({
                    $splitName = $this.name.split("_");
                    $instanceId = $splitName[1] + "-" + $splitName[2];
                    $z = [int] $splitName[3];
                    $portSuffix = "$($rdpConnectAccount.profile.Substring($rdpConnectAccount.profile.Length - 3))"
                    
                    # Start AWS command in new window
                    wt --window 0 -p "Windows Powershell" `
                        -d "$pwd" `
                        powershell `
                        -noExit `
                        "$($rdpConnectAccount.command) $($rdpConnectAccount.profile) 3389 4$($z)$($portSuffix) $($instanceId)";

                    # Sleep because it takes a while for the listener to spawn
                    Start-Sleep -Seconds 3

                    # Start remote desktop connection
                    # cmdkey /list | ForEach-Object{if($_ -like "*Target:*"){cmdkey /del:($_ -replace " ","" -replace "Target:","")}};
                    # cmdkey /generic:TERMSRV/"localhost:$($data.local_port_number)" /user:".\passport-epossum-spe" /pass:"wur57f4chv3rk43uf3r!n";
                    & mstsc.exe /v:localhost:$("4$($z)$($portSuffix)") /prompt;
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
