#=================================================================================
# Set pipeline table data
# 
# Table layout data row with button on the right column
#
# @param Grid $grid
# @param Array $names
# @param Array $thickness
# @param Int $cols
#================================================================================
function set-devOps-pipeline-table-data
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $pipelines,
        [Parameter(Mandatory)][array] $names,
        [Parameter(Mandatory)][array] $thickness,
        [Parameter(Mandatory)][int] $cols,
        [Parameter(Mandatory)][array] $width,
        [Parameter(Mandatory)][array] $foreground
    )

    $i = 4;
    $c = 1;

    ForEach ($pipeline in $pipelines) {
        $pipelineName = $pipeline.name;
        $pipelineUpdated = $pipeline.updated;

        # [Debug]
        # write-host $pipelineName;
        # write-host $pipelineUpdated;

        $content = @($pipelineName, $pipelineUpdated, " ");

        # Table like background
        if ($c % 2 -eq 0) { $background = "#FFE5E5E5"; } 
        else { $background = "lightgray"; }

        for ($z=0; $z -lt $cols; $z++) {
            $name = $names[$z];

            #=================================================================================
            # Upload
            #=================================================================================
            if ($z -eq ($cols-1)) {
                # Upload button
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

                $tmpPipelineName = $pipelineName.replace("-", "_");
                $button = set-connect-button `
                    -name $("devOps_" + $tmpPipelineName + "_" + $c) `
                    -foreground $foreground[$z] `
                    -width 135 `
                    -height 30 `
                    -content "Upload";

                Set-Variable -Name $("devOps_" + $tmpPipelineName + "_" + $c) -Value $button -scope "script";

                $grid.AddChild($border);
                $border.AddChild($button);

                # Add Click event
                $button.Add_Click({
                    $OpenFileDialog = New-Object Microsoft.Win32.OpenFileDialog;
                    $OpenFileDialog.initialDirectory = "$pwd\public";
                    $OpenFileDialog.filter = "All files (*.*)| *.*";
                    $OpenFileDialog.ShowDialog() | Out-Null;

                    # [Debug]
                    # write-host $OpenFileDialog.filename;
                    
                    if ($OpenFileDialog.filename -ne "") {
                        # Upload pipeline with json content
                        aws codepipeline update-pipeline `
                            --cli-input-json file://$($OpenFileDialog.filename) `
                            --debug `
                            --profile $devOpsAccount.profile;  
                    }
                });

            #=================================================================================
            # Download
            #=================================================================================
            } elseif ($z -eq ($cols-2)) {
                $name = $names[$z];

                # Download button
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

                $tmpPipelineName = $pipelineName.replace("-", "_");
                $button = set-connect-button `
                    -name $( "devOps_" + $tmpPipelineName + "_" + $c ) `
                    -foreground $foreground[$z] `
                    -width 135 `
                    -height 30 `
                    -content "Download";

                Set-Variable -Name $( "devOps_" + $tmpPipelineName + "_" + $c ) -Value $button -scope "script";

                $grid.AddChild($border);
                $border.AddChild($button);

                # Add Click event
                $button.Add_Click({
                    $splitName = $this.name.split("_");

                    #remove first element
                    $tmp = $splitName -ne $splitName[0];

                    #remove last element
                    $pipelineName = $tmp -ne $tmp[-1];

                    # [Debug]
                    # write-host ($pipelineName);

                    # Get pipeline
                    aws codepipeline get-pipeline `
                        --name ($pipelineName -join '-') `
                        --output json `
                        --profile $devOpsAccount.profile | Out-File -Encoding "utf8" -FilePath ".\public\pipeline.json";

                    $dialog = [System.Windows.MessageBox]::Show($devOpsDownloadPipelineDialog, 'Services input', 'OK', 'Warning');

                    if ($dialog -eq "OK")
                    {
                        # Open pipeline json in vscode
                        if ($radioButtonCode.IsChecked)
                        {
                            code ".\public\pipeline.json";
                        }

                        # Open pipeline in notepad++
                        if ($radioButtonNotepad.IsChecked)
                        {
                            notepad++ ".\public\pipeline.json";
                        }
                    }
                });

            }

            #=================================================================================
            # Start pipeline
            #=================================================================================
            elseif ($z -eq ($cols-3)) {
                $name = $names[$z];

                # Download button
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

                $tmpPipelineName = $pipelineName.replace("-", "_");
                $button = set-connect-button `
                    -name $( "devOps_" + $tmpPipelineName + "_" + $c ) `
                    -foreground $foreground[$z] `
                    -width 135 `
                    -height 30 `
                    -content "Start";

                Set-Variable -Name $( "devOps_" + $tmpPipelineName + "_" + $c ) -Value $button -scope "script";

                $grid.AddChild($border);
                $border.AddChild($button);

                # Add Click event
                $button.Add_Click({
                    $splitName = $this.name.split("_");

                    #remove first element
                    $tmp = $splitName -ne $splitName[0];

                    #remove last element
                    $pipelineName = $tmp -ne $tmp[-1];

                    # [Debug]
                    # write-host ($pipelineName);

                    # Start pipeline
                    aws codepipeline start-pipeline-execution `
                        --name ($pipelineName -join '-') `
                        --profile $devOpsAccount.profile;

                    [System.Windows.MessageBox]::Show($devOpsStartPipelineDialog, 'Services input', 'OK', 'Warning');
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

#=================================================================================
# Set codebuild table data
# 
# Table layout data row with button on the right column
#
# @param Grid $grid
# @param Array $names
# @param Array $thickness
# @param Int $cols
#================================================================================
function set-devOps-codebuild-table-data
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $projects,
        [Parameter(Mandatory)][array] $names,
        [Parameter(Mandatory)][array] $thickness,
        [Parameter(Mandatory)][int] $cols,
        [Parameter(Mandatory)][array] $width,
        [Parameter(Mandatory)][array] $foreground
    )

    $i = 4;
    $c = 1;

    ForEach ($project in $projects) {
        $content = @($project, " ", " ");

        # Table like background
        if ($c % 2 -eq 0) { $background = "#FFE5E5E5"; } 
        else { $background = "lightgray"; }

        for ($z=0; $z -lt $cols; $z++) {
            $name = $names[$z];

            if ($z -eq ($cols-1)) {
                # Upload button
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

                $tmpProject = $project.replace("-", "_");
                $button = set-connect-button `
                    -name $("devOps_" + $tmpProject + "_" + $c) `
                    -foreground $foreground[$z] `
                    -width 150 `
                    -height 30 `
                    -content "Upload";

                Set-Variable -Name $("devOps_" + $tmpProject + "_" + $c) -Value $button -scope "script";

                $grid.AddChild($border);
                $border.AddChild($button);

                # Add Click event
                $button.Add_Click({
                    $OpenFileDialog = New-Object Microsoft.Win32.OpenFileDialog;
                    $OpenFileDialog.initialDirectory = "$pwd\public";
                    $OpenFileDialog.filter = "All files (*.*)| *.*";
                    $OpenFileDialog.ShowDialog() | Out-Null;

                    # [Debug]
                    write-host $OpenFileDialog.filename;
                    
                    if ($OpenFileDialog.filename -ne "") {
                        # Upload pipeline with json content
                        aws codebuild update-project `
                            --cli-input-json file://$($OpenFileDialog.filename) `
                            --debug `
                            --profile $devOpsAccount.profile;  
                    }
                });
                
            } elseif ($z -eq ($cols-2)) {
                $name = $names[$z];

                # Download button
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

                $tmpProject = $project.replace("-", "_");
                $button = set-connect-button `
                    -name $("devOps_" + $tmpProject + "_" + $c) `
                    -foreground $foreground[$z] `
                    -width 150 `
                    -height 30 `
                    -content "Download";

                Set-Variable -Name $("devOps_" + $tmpProject + "_" + $c) -Value $button -scope "script";

                $grid.AddChild($border);
                $border.AddChild($button);

                # Add Click event
                $button.Add_Click({

                    $splitName = $this.name.split("_");

                    #remove first element
                    $tmp = $splitName -ne $splitName[0];

                    #remove last element
                    $pipelineName = $tmp -ne $tmp[-1];

                    # [Debug]
                    write-host ($pipelineName);
        
                    # Get running instances per account
                    aws codebuild batch-get-projects `
                        --names ($pipelineName -join '-' ) `
                        --output json `
                        --profile $devOpsAccount.profile | Out-File -Encoding "utf8" -FilePath ".\public\codebuild.json";
                    
                    $dialog = [System.Windows.MessageBox]::Show($devOpsDownloadPipelineDialog,'Services input','OK','Warning');

                    if ($dialog -eq "OK") {
                        # Open pipeline json in vscode
                        if ($radioButtonCode.IsChecked) {
                            code ".\public\codebuild.json";
                        }

                        # Open pipeline in notepad++
                        if ($radioButtonNotepad.IsChecked) {
                            notepad++ ".\public\codebuild.json";
                        }
                    }
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
