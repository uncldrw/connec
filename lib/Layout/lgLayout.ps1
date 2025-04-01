##########################################################################################
# Date grid
##########################################################################################
set-dropdown-grid `
	-grid $dateGrid `
	-cols 2 `
	-rows 2 `
	-width 750 `
	-height 100 `
	-background "#FFE5E5E5";

$label = set-basic-label `
	-name "dateLabel" `
	-foreground "#FF5A5B65" `
	-fontSize 16 `
	-content "Date format: YYYY-MM-DD HH:MM:SS" `
	-margin "10,25,10,15";

$dateGrid.AddChild($label);

$script:lgTextBox = set-text-box `
	-name "dateLabel" `
	-margin "-140,55,10,15";

$dateGrid.AddChild($lgTextBox);

$script:nowButton = set-now-button `
    -name "nowButton" `
    -foreground "#FF5A5B65" `
    -width 50 `
    -height 30 `
    -content "now()" `
    -margin "150,55,25,15";

$dateGrid.AddChild($nowButton);

##########################################################################################
# Rollout grid
##########################################################################################
set-dropdown-grid `
	-grid $rolloutGrid `
	-cols 2 `
	-rows 2 `
	-width 750 `
	-height 100 `
	-background "#FFE5E5E5";

$label = set-basic-label `
	-name "rolloutLabel" `
	-foreground "#FF5A5B65" `
	-fontSize 16 `
	-content "Rollout" `
	-margin "10,15,10,15";

$rolloutGrid.AddChild($label);

# Database
$script:checkboxDb = set-checkbox `
    -name 'checkboxDb' `
    -fontSize 14 `
    -content '--db' `
    -margin @(10,55,0,0);

$rolloutGrid.AddChild($checkboxDb);

# Shops
$script:checkboxShops = set-checkbox `
    -name 'checkboxShops' `
    -fontSize 14 `
    -content '--shops' `
    -margin @(115,55,0,0);

$rolloutGrid.AddChild($checkboxShops);

# Force
$script:checkboxForce = set-checkbox `
    -name 'checkboxForce' `
    -fontSize 14 `
    -content '--force' `
    -margin @(220,55,0,0);

$rolloutGrid.AddChild($checkboxForce);

# With AWS
$script:checkboxAws = set-checkbox `
    -name 'checkboxAws' `
    -fontSize 14 `
    -content '--with-aws' `
    -margin @(10,75,0,0);

$rolloutGrid.AddChild($checkboxAws);

# Database update
$script:checkboxDbUpdate = set-checkbox `
    -name 'checkboxDbUpdate' `
    -fontSize 14 `
    -content '--db-update' `
    -margin @(115,75,0,0);

$rolloutGrid.AddChild($checkboxDbUpdate);

# update
$script:checkboxUpdate = set-checkbox `
	-name 'checkboxUpdate' `
	-fontSize 14 `
	-content '--update' `
	-margin @(220,75,0,0);

$rolloutGrid.AddChild($checkboxUpdate);


##########################################################################################
# Apiv1 grid
##########################################################################################
set-dropdown-grid `
	-grid $apiGrid `
	-cols 2 `
	-rows 2 `
	-width 750 `
	-height 100 `
	-background "#FFE5E5E5";

$label = set-basic-label `
	-name "apiLabel" `
	-foreground "#FF5A5B65" `
	-fontSize 16 `
	-content "API v1" `
    -margin "10,15,10,15";

$apiGrid.AddChild($label);

# Apiv1
$script:checkboxApi = set-checkbox `
    -name 'checkboxApi' `
    -fontSize 14 `
    -content '--api' `
    -margin @(10,55,0,0);

$apiGrid.AddChild($checkboxApi);


##########################################################################################
# Serviceportal grid
##########################################################################################
set-dropdown-grid `
	-grid $spGrid `
	-cols 2 `
	-rows 2 `
	-width 750 `
	-height 100 `
	-background "#FFE5E5E5";

$label = set-basic-label `
	-name "spLabel" `
	-foreground "#FF5A5B65" `
	-fontSize 16 `
	-content "Serviceportal" `
	-margin "10,15,10,15";

$spGrid.AddChild($label);

# Apiv1
$script:checkboxSp = set-checkbox `
    -name 'checkboxSp' `
    -fontSize 14 `
    -content '--serviceportal' `
    -margin @(10,55,0,0);

$spGrid.AddChild($checkboxSp);


##########################################################################################
# Button
##########################################################################################
$script:lgButton = set-lg-button `
    -name "lgButton" `
    -foreground "#FF5A5B65" `
    -width 150 `
    -height 30 `
    -content "Push SQS" `
    -margin "-600,450,0,0";

$topGrid.AddChild($lgButton);

