#=================================================================================
# SSH combobox 
#
# Event: Add_SelectionChanged()
#================================================================================
$sshAccountscombobox.Add_SelectionChanged({
	# Clear grid
	clear-grid -grid $sshTableGrid;

	# [Debug]
	# write-host "Selected item: $($this.SelectedItem)";

	$script:sshConnectAccount = $config.ssh | where-object {$_.name -eq $this.SelectedItem};
	
    # Get running instances per account
	$Form.Cursor = [System.Windows.Input.Cursors]::Wait;

	$tempsSsh = aws ec2 describe-instances `
		--query 'Reservations[*].Instances[*].[InstanceId, Tags[?Key==`Name`] | [0].Value]' `
		--filters Name=instance-state-name,Values=running `
		--profile $sshConnectAccount.profile `
		--output json | ConvertFrom-Json;
	$script:sshInstanceResult = @();

	foreach($reservation in $tempsSsh) {
		$sshInstanceResult += $reservation;
	}

	$Form.Cursor = [System.Windows.Input.Cursors]::Arrow;

	if ($sshInstanceResult.Count -eq 0) {
		[System.Windows.MessageBox]::Show($instancesMissingDialog,'Services input','OK','Warning');
	} else {
		# Init table layout
		set-ssh-table-layout -grid $sshTableGrid -result $sshInstanceResult;
	}
});