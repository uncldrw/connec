# set-dropdown-grid `
# 	-grid $devOpsDropdownAccountsGrid `
# 	-cols 2 `
# 	-rows 2 `
# 	-width 750 `
# 	-height 150 `
# 	-background "#FFE5E5E5";

# Header
$label = set-basic-label `
	-name "devOpsAccountsLabel" `
	-foreground "#FF5A5B65" `
	-fontSize 14 `
	-content "Please choose an AWS Account" `
	-margin "10,15,10,15";
	
$devOpsDropdownAccountsGrid.AddChild($label);

$script:devOpsAccountsCombobox = set-basic-combobox `
	-grid $devOpsDropdownAccountsGrid `
	-name "devOpsAccountsCombobox" `
	-foreground "#FF5A5B65" `
	-width 250 `
	-height 30 `
	-margin "10,50,10,15";

$devOpsDropdownAccountsGrid.AddChild($devOpsAccountsCombobox);

$null = set-combobox-accounts -accounts $config.devOps.accounts -combobox $devOpsAccountsCombobox;

$label = set-basic-label `
	-name "devOpsServicesLabel" `
	-foreground "#FF5A5B65" `
	-fontSize 14 `
	-content "Please choose an AWS Service" `
	-margin "360,15,10,15";
	
$devOpsDropdownAccountsGrid.AddChild($label);

$script:devOpsServicesCombobox = set-basic-combobox `
	-grid $devOpsDropdownAccountsGrid `
	-name "devOpsServicesCombobox" `
	-foreground "#FF5A5B65" `
	-width 250 `
	-height 30 `
	-margin "360,50,10,15";

$devOpsDropdownAccountsGrid.AddChild($devOpsServicesCombobox);

$null = set-combobox-services -services $config.devOps.services -combobox $devOpsServicesCombobox;

$script:devOpsServicesButton = set-show-services-button `
    -name "devOpsShowServicesButton" `
    -foreground "#FF5A5B65" `
    -width 150 `
    -height 30 `
    -content "Show projects" `
    -margin "10,100,10,15";

$devOpsDropdownAccountsGrid.AddChild($devOpsServicesButton);


#=================================================================================
# Set devOps pipeline table data
# 
# Table layout data row with button on the right column
#
# @param Grid $grid
# @param Array $result
#================================================================================
function set-devOps-pipeline-table-layout
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $result
    )

    # SSH table grid
	set-table-grid `
        -grid $devOpsTableGrid `
        -accounts $result `
        -cols 5;

    # Set header
    set-header `
        -grid $devOpsTableGrid `
        -name "devOpsPipelineHeader" `
        -content "Aws Pipelines" `
        -background "LightSlateGray" `
        -width 750;

    # Set sub header
    set-sub-header `
        -grid $devOpsTableGrid `
        -names @("devOps_PipelineSubHeaderName", "devOps_PipelineSubHeaderUpdated", "devOps_PipelineSubHeaderStart", "devOps_PipelineSubHeaderDownload", "devOps_PipelineSubHeaderUpload") `
        -content @("Name", "Updated", " ", " ", " ") `
        -thickness @("1,1,1,1", "0,1,0,1", "1,1,0,1", "1,1,0,1", "1,1,0,1") `
        -cols 5 `
        -row 2 `
        -width @(149, 149, 149, 149, 149);

    # Data
    set-devOps-pipeline-table-data `
        -grid $devOpsTableGrid `
        -pipelines $result `
        -names @("devOps_PipelineLabelName", "devOps_PipelineLabelUpdated", "devOps_PipelineButtonStart", "devOps_PipelineButtonDownload", "devOps_PipelineButtonUpload") `
        -thickness @("1,1,1,1", "0,1,0,1", "1,1,0,1", "1,1,0,1", "1,1,0,1") `
        -cols 5 `
        -width @(149, 149, 149, 149, 149) `
        -foreground @("#FF5A5B65", "Green", "#FF5A5B65", "#FF5A5B65", "#FF5A5B65");
}

#=================================================================================
# Set devOps codebuild table data
# 
# Table layout data row with button on the right column
#
# @param Grid $grid
# @param Array $result
#================================================================================
function set-devOps-codebuild-table-layout
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $result
    )

    # SSH table grid
	set-table-grid `
        -grid $devOpsTableGrid `
        -accounts $result `
        -cols 3;

    # Set header
    set-header `
        -grid $devOpsTableGrid `
        -name "devOpsCodebuildHeader" `
        -content "Aws Codebuild projects" `
        -background "LightSlateGray" `
        -width 750;

    # Set sub header
    set-sub-header `
        -grid $devOpsTableGrid `
        -names @("devOps_CodebuildSubHeaderName", "devOps_CodebuildSubHeaderDownload", "devOps_CodebuildSubHeaderUpload") `
        -content @("Name", " ", " ") `
        -thickness @("1,1,1,1", "0,1,0,1", "1,1,1,1") `
        -cols 3 `
        -row 2 `
        -width @(249, 250, 249);

    # Data
    set-devOps-codebuild-table-data `
        -grid $devOpsTableGrid `
        -projects $result `
        -names @("devOps_CodebuildLabelName", "devOps_CodebuildButtonDownload", "devOps_CodebuildButtonUpload") `
        -thickness @("1,1,1,1", "0,1,0,1", "1,1,1,1") `
        -cols 3 `
        -width @(249, 250, 249) `
        -foreground @("#FF5A5B65", "#FF5A5B65", "#FF5A5B65");
}
