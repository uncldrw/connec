function set-connect-button {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $foreground,
        [Parameter(Mandatory)][int] $width,
        [Parameter(Mandatory)][string] $height,
        [Parameter(Mandatory)][string ] $content
    )

    $button = new-object System.Windows.Controls.Button;
    $button.Name = $name;
    $button.Foreground = $foreground;
    $button.Width = $width;
    $button.Height = $height;
    $button.Content = $content;
    $button.Style = $style;

    return $button;
}

function set-show-services-button {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $foreground,
        [Parameter(Mandatory)][int] $width,
        [Parameter(Mandatory)][string] $height,
        [Parameter(Mandatory)][string ] $content,
        [Parameter(Mandatory)][string ] $margin
    )

    $button = new-object System.Windows.Controls.Button;
    $button.Name = $name;
    $button.Foreground = $foreground;
    $button.Width = $width;
    $button.Height = $height;
    $button.Content = $content;
    $button.Style = $style;
    $button.Margin = $margin;
    $button.HorizontalAlignment = "Left";

    return $button;
}

function set-lg-button {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $foreground,
        [Parameter(Mandatory)][int] $width,
        [Parameter(Mandatory)][string] $height,
        [Parameter(Mandatory)][string ] $content,
        [Parameter(Mandatory)][string ] $margin
    )

    $button = new-object System.Windows.Controls.Button;
    $button.Name = $name;
    $button.Foreground = $foreground;
    $button.Width = $width;
    $button.Height = $height;
    $button.Content = $content;
    $button.Style = $style;
    $button.Margin = $margin;

    return $button;
}


function set-now-button {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $foreground,
        [Parameter(Mandatory)][int] $width,
        [Parameter(Mandatory)][string] $height,
        [Parameter(Mandatory)][string ] $content,
        [Parameter(Mandatory)][string ] $margin
    )

    $button = new-object System.Windows.Controls.Button;
    $button.Name = $name;
    $button.Foreground = $foreground;
    $button.Width = $width;
    $button.Height = $height;
    $button.Content = $content;
    $button.Style = $style;
    $button.Margin = $margin;

    return $button;
}