#=================================================================================
# RDP combobox 
#
# Event: Add_SelectionChanged()
#================================================================================
$rdpAccountscombobox.Add_SelectionChanged({
	# Clear grid
	clear-grid -grid $rdpTableGrid;

	# [Debug]
	# write-host "Selected item: $($this.SelectedItem)";

	$script:rdpConnectAccount = $config.rdp | where-object {$_.name -eq $this.SelectedItem};
	
    # Get running instances per account
	$Form.Cursor = [System.Windows.Input.Cursors]::Wait;

    $tempRdp = aws ec2 describe-instances `
        --query 'Reservations[*].Instances[*].[InstanceId, Tags[?Key==`Name`] | [0].Value]' `
        --filters "Name=instance-state-name,Values=running" "Name=platform-details,Values=Windows,Windows BYOL,Windows with SQL Server Enterprise,Windows with SQL Server Standard,Windows with SQL Server Web" `
        --profile $rdpConnectAccount.profile `
        --output json | ConvertFrom-Json;
    $script:rdpInstanceResult = @();

    foreach($reservation in $tempRdp) {
        $rdpInstanceResult += $reservation;
    }

	$Form.Cursor = [System.Windows.Input.Cursors]::Arrow;

	if ($rdpInstanceResult.Count -eq 0) {
		[System.Windows.MessageBox]::Show($instancesMissingDialog,'Services input','OK','Warning');
	} else {
		# Init table layout
		set-rdp-table-layout -grid $rdpTableGrid -result $rdpInstanceResult;
	}
});