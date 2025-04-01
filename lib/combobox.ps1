function set-basic-combobox
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $foreground,
        [Parameter(Mandatory)][int] $width,
        [Parameter(Mandatory)][string] $height,
        [Parameter(Mandatory)][string] $margin
    )

    $combobox = new-object System.Windows.Controls.ComboBox;
    $combobox.Name = $name;
    $combobox.Foreground = $foreground;
    $combobox.Width = $width;
    $combobox.Height = $height;
    # $button.IsEditable = "True";
    # $button.Text = "Test";
    $combobox.HorizontalAlignment = "Left";
    $combobox.VerticalAlignment = "Top";
    $combobox.Margin = $margin;

    return $combobox;
}

function set-combobox
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $foreground,
        [Parameter(Mandatory)][int] $width,
        [Parameter(Mandatory)][string] $height,
        [Parameter(Mandatory)][int] $row,
        [Parameter(Mandatory)][string] $col,
        [Parameter(Mandatory)][string] $type,
        $margin
    )

    $combobox = new-object System.Windows.Controls.ComboBox;
    $combobox.Name = $name;
    $combobox.Foreground = $foreground;
    $combobox.Width = $width;
    $combobox.Height = $height;
    # $button.IsEditable = "True";
    # $button.Text = "Test";
    $combobox.HorizontalAlignment = "Left";
    $combobox.VerticalAlignment = "Top";

    if ($null -ne $margin) {
        $combobox.Margin = $margin;
    } else {
        $combobox.Margin = "10,50,0,0";
    }

    [System.Windows.Controls.Grid]::SetRow($grid, $row);

    if ($type -eq "colspan") {
        [System.Windows.Controls.Grid]::SetColumnSpan($grid, $col);
    }

    if ($type -eq "col") {
        [System.Windows.Controls.Grid]::SetColumn($grid, $col);
    }

    return $combobox;
}

function set-combobox-accounts
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][array] $accounts,
        [Parameter(Mandatory)][system.Windows.Controls.ComboBox] $combobox
    )

    # Add accounts to sshListAccounts combobox
    foreach ($account in $accounts)
    {
        $combobox.Items.Add($account.name);
    }
}

function set-combobox-services
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][array] $services,
        [Parameter(Mandatory)][system.Windows.Controls.ComboBox] $combobox
    )

    # Add accounts to sshListAccounts combobox
    foreach ($service in $services)
    {
        $combobox.Items.Add($service);
    }
}
