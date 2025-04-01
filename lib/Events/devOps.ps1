$devOpsServicesButton.Add_Click({
    # Clear grid
    clear-grid -grid $devOpsTableGrid;

    # [Debug]
	# write-host "Selected item: $($devOpsAccountsCombobox.SelectedItem)";
    # write-host "Selected item: $($devOpsServicesCombobox.SelectedItem)";

    if (
        $null -eq $devOpsAccountsCombobox.SelectedItem -or
        $null -eq $devOpsServicesCombobox.SelectedItem
    ) {
        # [Debug]
        # write-host $devOpsAccountsCombobox.SelectedItem;

       [System.Windows.MessageBox]::Show($devOpsMissingDialog,'Services input','OK','Warning');
    } else {
        $script:devOpsAccount = $config.devOps.accounts | where-object {$_.name -eq $devOpsAccountsCombobox.SelectedItem};

        # [Debug]
        # write-host $devOpsAccount.profile;


        switch ($($devOpsServicesCombobox.SelectedItem))
        {
            # Codebuild
            "codebuild" { 
                # Get running instances per account
                $Form.Cursor = [System.Windows.Input.Cursors]::Wait;

                $script:devOpsCodebuildResult = aws codebuild list-projects `
                    --sort-by "NAME" `
                    --sort-order "ASCENDING" `
                    --profile $devOpsAccount.profile | ConvertFrom-Json;

                $Form.Cursor = [System.Windows.Input.Cursors]::Arrow;

                if ($devOpsCodebuildResult.projects.Count -lt 1) {
                    [System.Windows.MessageBox]::Show($codebuildMissingDialog,'Services input','OK','Warning');
                } else {
                    # Init table layout
                    set-devOps-codebuild-table-layout -grid $devOpsTableGrid -result $devOpsCodebuildResult.projects;
                } 
            }

            # Codedeploy
            "codedeploy" { 
                write-host "codedeploy";
            }
            
            # Pipelines
            "pipeline" { 
                # Get running instances per account
                $Form.Cursor = [System.Windows.Input.Cursors]::Wait;

                $script:devOpsPipelineResult = aws codepipeline list-pipelines `
                    --no-paginate `
                    --output json `
                    --profile $devOpsAccount.profile | ConvertFrom-Json;

                $Form.Cursor = [System.Windows.Input.Cursors]::Arrow;

                # [Debug]
                # write-host $devOpsPipelineResult;

                if ($devOpsPipelineResult.pipelines.Count -lt 1) {
                    [System.Windows.MessageBox]::Show($pipelinesMissingDialog,'Services input','OK','Warning');
                } else {
                    # Init table layout
                    set-devOps-pipeline-table-layout -grid $devOpsTableGrid -result $devOpsPipelineResult.pipelines;
                } 
            }
        }
    }
});
