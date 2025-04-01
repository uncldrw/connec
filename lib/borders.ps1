#=================================================================================
# Set dropdown grid
# 
# @param Grid $grid
# @param string $borderBrush
# @param string $thickness
# @param Int $height
# @param Int $width
# @param String $background
# @param Int $row
# @param Int $col
# @param String $type
#================================================================================
function set-border {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][string] $borderBrush,
        [Parameter(Mandatory)][string] $thickness,
        [Parameter(Mandatory)][int] $height,
        [Parameter(Mandatory)][int] $width,
        [Parameter(Mandatory)][string] $background,
        [Parameter(Mandatory)][int] $row,
        [Parameter(Mandatory)][int] $col,
        [Parameter(Mandatory)][string] $type
    )

    $border = new-object System.Windows.Controls.Border;
    $border.BorderBrush = $borderBrush;
    $border.MinHeight = $height;
    $border.Width = $width;
    # $border.HorizontalAlignment = "Central";
    # $border.VerticalAlignment = "Middle";
    $border.Background = $background;
    $border.BorderThickness = $thickness;
    
    [System.Windows.Controls.Grid]::SetRow($border, $row);

    if ($type -eq "colspan") {
        [System.Windows.Controls.Grid]::SetColumnSpan($border, $col);
    }

    if ($type -eq "col") {
        [System.Windows.Controls.Grid]::SetColumn($border, $col);
    }

    return $border;
}

function set-dropdown-border {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid,
        [Parameter(Mandatory)][string] $borderBrush,
        [Parameter(Mandatory)][string] $thickness,
        [Parameter(Mandatory)][int] $height,
        [Parameter(Mandatory)][int] $width,
        [Parameter(Mandatory)][string] $background,
        [Parameter(Mandatory)][int] $row,
        [Parameter(Mandatory)][int] $col,
        [Parameter(Mandatory)][string] $type,
        [Parameter(Mandatory)][string] $margin
    )

    $border = new-object System.Windows.Controls.Border;
    $border.BorderBrush = $borderBrush;
    $border.MinHeight = $height;
    $border.Width = $width;
    $border.HorizontalAlignment = "Left";
    $border.VerticalAlignment = "Center";
    $border.Background = $background;
    $border.BorderThickness = $thickness;
    $border.Margin = $margin;
    
    [System.Windows.Controls.Grid]::SetRow($border, $row);

    if ($type -eq "colspan") {
        [System.Windows.Controls.Grid]::SetColumnSpan($border, $col);
    }

    if ($type -eq "col") {
        [System.Windows.Controls.Grid]::SetColumn($border, $col);
    }

    return $border;
}
