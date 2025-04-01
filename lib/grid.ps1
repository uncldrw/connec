#=================================================================================
# Set basic table grid
# 
# @param Grid $grid
# @param Array $accounts
#================================================================================
function set-table-grid {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][array] $accounts,
        [Parameter(Mandatory)][int] $cols
    )
    
    # Row definitions
    # +2 because we have header and sub header
    for ($i=0; $i -lt ($accounts.Count + 2); $i++){
        # [Debug]
        # write-host $i;

        $tmpRow = new-object system.windows.controls.rowdefinition;
        $tmpRow.height = "Auto";

        $tmpRowSpacer = new-object system.windows.controls.rowdefinition;
        $tmpRowSpacer.height = 1;

        $grid.RowDefinitions.add($tmpRow);
        $grid.RowDefinitions.add($tmpRowSpacer);
    }

    # Column definitions
    for ($i=0; $i -lt $cols; $i++) { 
        $tmpCol = new-object system.windows.controls.columndefinition;

        $grid.ColumnDefinitions.add($tmpCol);
    }
}

#=================================================================================
# Set dropdown grid
# 
# @param Grid $grid
# @param Int $cols
# @param Int $rows
# @param Int $width
# @param Int $height
# @param String $background
# @param String $borderBrush
#================================================================================
function set-dropdown-grid {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][int] $cols,
        [Parameter(Mandatory)][int] $rows,
        [Parameter(Mandatory)][int] $width,
        [Parameter(Mandatory)][int] $height,
        [Parameter(Mandatory)][string] $background
    )

    # Row definitions
    # +2 because we have header and sub header
    for ($i=0; $i -lt $rows; $i++){
        # [Debug]
        # write-host $i;

        $tmpRow = new-object system.windows.controls.rowdefinition;
        $tmpRow.height = "Auto";

        $tmpRowSpacer = new-object system.windows.controls.rowdefinition;
        $tmpRowSpacer.height = 1;

        $grid.RowDefinitions.add($tmpRow);
        $grid.RowDefinitions.add($tmpRowSpacer);
    }

    # Column definitions
    for ($i=0; $i -lt $cols; $i++) {
        $tmpCol = new-object system.windows.controls.columndefinition;

        $grid.ColumnDefinitions.add($tmpCol);
    }

    $grid.Width = $width;
    $grid.Height = $height;
    $grid.Background = $background;
    # $grid.Margin = "29,25,15,0";
}
