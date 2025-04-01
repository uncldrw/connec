#=================================================================================
# Set header
# 
# @param Grid $grid
# @param String $name
#================================================================================
function set-header
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
        -col 7 `
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
function set-sub-header
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
function set-data
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $accounts,
        [Parameter(Mandatory)][array] $names,
        [Parameter(Mandatory)][array] $thickness,
        [Parameter(Mandatory)][int] $cols,
        [Parameter(Mandatory)][array] $width,
        [Parameter(Mandatory)][array] $foreground
    )

    $i = 4;
    $c = 1;

    ForEach ($account in $accounts) {
        # [Debug]
        # write-host $account.name;

        $content = @($account.name, " ", " ");
        $script:instance = @("", "", "", $account.cluster, $account.reader1, $account.reader2, $account.writer);

        # Table like background
        if ($c % 2 -eq 0) {
            $background = "#FFE5E5E5";
        } else {
            $background = "lightgray";
        }

        for ($z=0; $z -lt $cols; $z++) {
            $name = $names[$z];

            if ($z -gt 2) {
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

                if ($instance[$z] -ne '') {
                    $button = set-connect-button `
                    -name $($name + "_" + $z + "_" + $c) `
                    -foreground $foreground[$z] `
                    -width 100 `
                    -height 30 `
                    -content "Connect";

                    Set-Variable -Name $($name + "_" + $z + "_" + $c) -Value $button -scope "script";

                    $border.AddChild($button);

                    # Add Click event
                    $button.Add_Click({
                        $type = $this.name.split("_")[0];
                        $rdsType = $this.name.split("_")[2];
                        $realPos = [int]$this.name.split("_")[3];
                        $posArray = $realPos - 1;

                        # [Debug]
                        write-host $this.name;
                        write-host $($config.$type[$posArray].profile);
                        write-host $instance[$rdsType];
                        write-host $posArray;

                        # Show spinning icon
                        $Form.Cursor = [System.Windows.Input.Cursors]::Wait;
                        $data = get-config-data -connectProfile $($config.$type[$posArray].profile);
                        $Form.Cursor = [System.Windows.Input.Cursors]::Arrow;

                        # Show port and instance in table
                        $label = Get-Variable $($type + "_ConnectLabelPort_" + $realPos);
                        $label.Value.Text = $data.local_port_number;
                        $label = Get-Variable $($type + "_ConnectLabelInstance_" + $realPos);
                        $label.Value.Text = $data.instance_id;

                        # Start AWS command in new window
                        wt --window 0 -p "Windows Powershell" `
                            -d "$pwd" `
                            powershell `
                            -noExit `
                            "$($config.$type[$posArray].command) $($config.$type[$posArray].profile) $($data.port_number) $($data.local_port_number) $($instance[$rdsType]) $($data.instance_id)";

                        # Sleep because it takes a while for the listener to spawn
                        Start-Sleep -Seconds 3

                        # Generate token [text output only in hidden debug window!]
                        $token = aws rds generate-db-auth-token --hostname $($instance[$rdsType]) --port $($data.port_number) --username $($config.$type[$posArray].username) --region=eu-central-1 --profile $($config.$type[$posArray].profile);
                        $text = "`n";
                        $text += 'Generating token for passwordless login';
                        $text += "Token: " + $token + "`n";
                        write-host $text;

                        # Create a new Heidi session [text output only in hidden debug window!]
                        $text = "`n";
                        $text += 'Starting heidi sql with given profile';
                        $text += "Heidi path: " + $($config.misc.heidi) + "`n";
                        $text += "Heidi session: " + $($config.$type[$posArray].heidi_session) + "`n";
                        write-host $text;
                        & $($config.misc.heidi) -d="$($config.$type[$posArray].heidi_session)" --password="$token";
                    });
                }

                $grid.AddChild($border);
                
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
