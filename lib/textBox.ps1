function set-text-box {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $name,
        [Parameter(Mandatory)][string] $margin
    )

    $textBox = new-object System.Windows.Controls.TextBox;
    $textBox.Name = $name;
    $textBox.Width = 200;
    $textBox.Margin = $margin;

    return $textBox;
}