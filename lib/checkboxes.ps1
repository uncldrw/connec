function set-checkbox {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][int] $fontSize,
        [Parameter(Mandatory)][string] $content,
        [Parameter(Mandatory)][array] $margin
    )

    $checkbox = new-object System.Windows.Controls.checkbox;
    $checkbox.Name = $name;
    $checkbox.FontFamily = "Arial";
    $checkbox.FontSize = $fontSize;
    $checkbox.FontWeight = "Thin";
    $checkbox.Content = $content;
    $checkbox.Margin = "$($margin[0]),$($margin[1]),$($margin[2]),$($margin[3])";

    return $checkbox;
}