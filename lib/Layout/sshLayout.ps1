# Dropdown
set-dropdown-grid `
	-grid $sshDropdownAccountsGrid `
	-cols 2 `
	-rows 2 `
	-width 750 `
	-height 100 `
	-background "#FFE5E5E5";

$label = set-dropdown-label `
	-name "sshAccountsLabel" `
	-content "Please choose an AWS Account";

$sshDropdownAccountsGrid.AddChild($label);

$script:sshAccountscombobox = set-combobox `
	-grid $sshDropdownAccountsGrid `
	-name "sshAccountscombobox" `
	-foreground "#FF5A5B65" `
	-width 250 `
	-height 30 `
	-row 2 `
	-col 1 `
	-type "col";

$sshDropdownAccountsGrid.AddChild($sshAccountscombobox);

$null = set-combobox-accounts -accounts $config.ssh -combobox $sshAccountscombobox;


#=================================================================================
# Set ssh table data
# 
# Table layout data row with button on the right column
#
# @param Grid $grid
# @param Array $result
#================================================================================
function set-ssh-table-layout
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $result
    )

    # SSH table grid
	set-table-grid `
        -grid $sshTableGrid `
        -accounts $result `
        -cols 3;

    # Set header
    set-header `
        -grid $sshTableGrid `
        -name "sshConnectHeader" `
        -content "Aws SSH connections via SSM" `
        -background "LightSlateGray" `
        -width 750;

    # Set sub header
    set-sub-header `
        -grid $sshTableGrid `
        -names @("ssh_ConnectSubHeaderName", "ssh_ConnectSubHeaderInstance", "ssh_ConnectSubHeaderConnect") `
        -content @("Name", "Instance", " ") `
        -thickness @("1,1,1,1", "0,1,0,1", "1,1,1,1") `
        -cols 3 `
        -row 2 `
        -width @(249, 250, 249);

    # Data
    set-ssh-data `
        -grid $sshTableGrid `
        -instances $result `
        -names @("ssh_ConnectLabelName", "ssh_ConnectLabelInstance", "ssh_ConnectButton") `
        -thickness @("1,1,1,1", "0,1,0,1", "1,1,1,1") `
        -cols 3 `
        -width @(249, 250, 249) `
        -foreground @("#FF5A5B65", "Green", "#FF5A5B65");
}