function set-text-block {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $foreground,
        [Parameter(Mandatory)][int] $fontSize,
        [Parameter(Mandatory)][string] $fontWeight,
        [Parameter(Mandatory)][string] $horizontalAlignment,
        [Parameter(Mandatory)][string] $verticalAlignment,
        [Parameter(Mandatory)][string] $text,
        [Parameter(Mandatory)][string] $margin
    )

    $textBlock = new-object System.Windows.Controls.TextBlock;
    $textBlock.Name = $name;
    $textBlock.VerticalAlignment = $verticalAlignment;
    $textBlock.HorizontalAlignment = $horizontalAlignment;
    $textBlock.Foreground = $foreground;
    $textBlock.FontFamily = "Arial";
    $textBlock.FontSize = $fontSize;
    $textBlock.FontWeight = $fontWeight;
    $textBlock.Text = $text;
    $textBlock.Margin = $margin;
    $textBlock.TextWrapping = "Wrap";

    return $textBlock;
}