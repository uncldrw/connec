function set-label {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $foreground,
        [Parameter(Mandatory)][int] $fontSize,
        [Parameter(Mandatory)][string] $fontWeight,
        [Parameter(Mandatory)][string] $content,
        [Parameter(Mandatory)][string] $horizontalAlignment,
        [Parameter(Mandatory)][string] $verticalAlignment
    )

    $label = new-object System.Windows.Controls.Label;
    $label.Name = $name;
    $label.VerticalAlignment = $verticalAlignment;
    $label.HorizontalAlignment = $horizontalAlignment;
    $label.Foreground = $foreground;
    $label.FontFamily = "Arial";
    $label.FontSize = $fontSize;
    $label.FontWeight = $fontWeight;
    $label.Content = $content;

    return $label;
}

function set-dropdown-label {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $content
    )

    $label = new-object System.Windows.Controls.Label;
    $label.Name = $name;
    $label.VerticalAlignment = "Top";
    $label.HorizontalAlignment = "Left";
    $label.Foreground = "#FF5A5B65";
    $label.FontFamily = "Arial";
    $label.FontSize = 14;
    $label.Content = $content;
    $label.Margin = "10,15,0,0";

    return $label;
}

function set-basic-label {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $foreground,
        [Parameter(Mandatory)][int] $fontSize,
        [Parameter(Mandatory)][string] $content,
        [Parameter(Mandatory)][string] $margin
    )

    $label = new-object System.Windows.Controls.Label;
    $label.Name = $name;
    $label.VerticalAlignment = "Top";
    $label.HorizontalAlignment = "Left";
    $label.Foreground = $foreground;
    $label.FontFamily = "Arial";
    $label.FontSize = $fontSize;
    $label.Content = $content;
    $label.Margin = $margin;

    return $label;
}
