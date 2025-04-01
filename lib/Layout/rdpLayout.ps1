# Dropdown
set-dropdown-grid `
	-grid $rdpDropdownAccountsGrid `
	-cols 2 `
	-rows 2 `
	-width 750 `
	-height 100 `
	-background "#FFE5E5E5";

$label = set-dropdown-label `
	-name "rdpAccountsLabel" `
	-content "Please choose an AWS Account";

$rdpDropdownAccountsGrid.AddChild($label);

$script:rdpAccountscombobox = set-combobox `
	-grid $rdpDropdownAccountsGrid `
	-name "rdpAccountscombobox" `
	-foreground "#FF5A5B65" `
	-width 250 `
	-height 30 `
	-row 2 `
	-col 1 `
	-type "col";

$rdpDropdownAccountsGrid.AddChild($rdpAccountscombobox);

$null = set-combobox-accounts -accounts $config.rdp -combobox $rdpAccountscombobox;

function set-rdp-table-layout
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $result
    )

	# Set table grid
	set-table-grid `
		-grid $rdpTableGrid `
		-accounts $result `
		-cols 3;

	# Set header
	set-rdp-header `
		-grid $rdpTableGrid `
		-name "rdpConnectHeader" `
		-content "AWS RDP connections via SSM" `
		-background "LightSlateGray" `
		-width 750;

	# Set sub header
	set-rdp-sub-header `
		-grid $rdpTableGrid `
		-names @("rdp_ConnectSubHeaderName", "rdp_ConnectSubHeaderInstance", "rdp_ConnectSubHeaderConnect") `
		-content @("Name", "Instance", " ") `
		-thickness @("1,1,1,1", "1,1,0,1", "1,1,0,1") `
		-cols 3 `
		-row 2 `
        -width @(249, 250, 249);

	# Data
	set-rdp-data `
        -grid $rdpTableGrid `
        -instances $result `
		-names @("rdp_ConnectLabelName", "rdp_ConnectLabelInstance", "rdp_ConnectButton") `
		-thickness @("1,1,1,1", "1,1,0,1", "1,1,0,1") `
		-cols 3 `
        -width @(249, 250, 249) `
		-foreground @("#FF5A5B65", "Green", "#FF5A5B65");
}