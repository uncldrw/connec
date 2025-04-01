[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$Form = New-Object System.Windows.Forms.Form
$Form.Size = New-Object System.Drawing.Size(370,470)
$Form.Text = "Color Form"
$Icon = [system.drawing.icon]::ExtractAssociatedIcon("C:WindowsSystem32mspaint.exe")
$Form.Icon = $Icon

#region Colors
$Colors = @()
$Colors += "AliceBlue"
$Colors += "AntiqueWhite"
$Colors += "Aqua"
$Colors += "Aquamarine"
$Colors += "Azure"
$Colors += "Beige"
$Colors += "Bisque"
$Colors += "Black"
$Colors += "BlanchedAlmond"
$Colors += "Blue"
$Colors += "BlueViolet"
$Colors += "Brown"
$Colors += "BurlyWood"
$Colors += "CadetBlue"
$Colors += "Chartreuse"
$Colors += "Chocolate"
$Colors += "Coral"
$Colors += "CornflowerBlue"
$Colors += "Cornsilk"
$Colors += "Crimson"
$Colors += "Cyan"
$Colors += "DarkBlue"
$Colors += "DarkCyan"
$Colors += "DarkGoldenrod"
$Colors += "DarkGray"
$Colors += "DarkGreen"
$Colors += "DarkKhaki"
$Colors += "DarkMagenta"
$Colors += "DarkOliveGreen"
$Colors += "DarkOrange"
$Colors += "DarkOrchid"
$Colors += "DarkRed"
$Colors += "DarkSalmon"
$Colors += "DarkSeaGreen"
$Colors += "DarkSlateBlue"
$Colors += "DarkSlateGray"
$Colors += "DarkTurquoise"
$Colors += "DarkViolet"
$Colors += "DeepPink"
$Colors += "DeepSkyBlue"
$Colors += "DimGray"
$Colors += "DodgerBlue"
$Colors += "Firebrick"
$Colors += "FloralWhite"
$Colors += "ForestGreen"
$Colors += "Fuchsia"
$Colors += "Gainsboro"
$Colors += "GhostWhite"
$Colors += "Gold"
$Colors += "Goldenrod"
$Colors += "Gray"
$Colors += "Green"
$Colors += "GreenYellow"
$Colors += "Honeydew"
$Colors += "HotPink"
$Colors += "IndianRed"
$Colors += "Indigo"
$Colors += "Ivory"
$Colors += "Khaki"
$Colors += "Lavender"
$Colors += "LavenderBlush"
$Colors += "LawnGreen"
$Colors += "LemonChiffon"
$Colors += "LightBlue"
$Colors += "LightCoral"
$Colors += "LightCyan"
$Colors += "LightGoldenrodYellow"
$Colors += "LightGray"
$Colors += "LightGreen"
$Colors += "LightPink"
$Colors += "LightSalmon"
$Colors += "LightSeaGreen"
$Colors += "LightSkyBlue"
$Colors += "LightSlateGray"
$Colors += "LightSteelBlue"
$Colors += "LightYellow"
$Colors += "Lime"
$Colors += "LimeGreen"
$Colors += "Linen"
$Colors += "Magenta"
$Colors += "Maroon"
$Colors += "MediumAquamarine"
$Colors += "MediumBlue"
$Colors += "MediumOrchid"
$Colors += "MediumPurple"
$Colors += "MediumSeaGreen"
$Colors += "MediumSlateBlue"
$Colors += "MediumSpringGreen"
$Colors += "MediumTurquoise"
$Colors += "MediumVioletRed"
$Colors += "MidnightBlue"
$Colors += "MintCream"
$Colors += "MistyRose"
$Colors += "Moccasin"
$Colors += "NavajoWhite"
$Colors += "Navy"
$Colors += "OldLace"
$Colors += "Olive"
$Colors += "OliveDrab"
$Colors += "Orange"
$Colors += "OrangeRed"
$Colors += "Orchid"
$Colors += "PaleGoldenrod"
$Colors += "PaleGreen"
$Colors += "PaleTurquoise"
$Colors += "PaleVioletRed"
$Colors += "PapayaWhip"
$Colors += "PeachPuff"
$Colors += "Peru"
$Colors += "Pink"
$Colors += "Plum"
$Colors += "PowderBlue"
$Colors += "Purple"
$Colors += "Red"
$Colors += "RosyBrown"
$Colors += "RoyalBlue"
$Colors += "SaddleBrown"
$Colors += "Salmon"
$Colors += "SandyBrown"
$Colors += "SeaGreen"
$Colors += "SeaShell"
$Colors += "Sienna"
$Colors += "Silver"
$Colors += "SkyBlue"
$Colors += "SlateBlue"
$Colors += "SlateGray"
$Colors += "Snow"
$Colors += "SpringGreen"
$Colors += "SteelBlue"
$Colors += "Tan"
$Colors += "Teal"
$Colors += "Thistle"
$Colors += "Tomato"
$Colors += "Turquoise"
$Colors += "Violet"
$Colors += "Wheat"
$Colors += "White"
$Colors += "WhiteSmoke"
$Colors += "Yellow"
$Colors += "YellowGreen"
#endregion Colors

#region Funcitons
Function Change-ButtonColor{
$n = $UserNameBox.Text
$ColorOutputBox.BackColor = $Colors[$n]
$outputBox.text = $Colors[$n]

}

Function Set-Color{
 If ($ColorDropDownBox.SelectedItem -lt 0){
 $ColorSelected = "No color was selected"
 Write-host $ColorSelected -ForegroundColor Red
 }
 Else {
 $ColorSelected = $ColorDropDownBox.SelectedItem.ToString()
 $ColorOutputBox.BackColor = $ColorSelected
 Write-host "Color Selected: $ColorSelected" -ForegroundColor Green
 }
}
#endregion Funcitons

#region Color Selection
#region Color Selection Dropdown Box Label
$ColorDropdownBoxLabel = New-Object system.windows.Forms.Label
$ColorDropdownBoxLabel.Text = "Color Choices"
$ColorDropdownBoxLabel.AutoSize = $true
$ColorDropdownBoxLabel.Width = 25
$ColorDropdownBoxLabel.Height = 10
$ColorDropdownBoxLabel.location = new-object system.drawing.point(20,10)
$ColorDropdownBoxLabel.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($ColorDropdownBoxLabel)
#endregion Color Selection Dropdown Box Label
#region Color Selection Dropdown Box
$ColorDropDownBox = New-Object System.Windows.Forms.ComboBox
$ColorDropDownBox.Location = New-Object System.Drawing.Size(20,30)
$ColorDropDownBox.Size = New-Object System.Drawing.Size(180,20)
$ColorDropDownBox.DropDownHeight = 200

foreach($Color in $Colors)
{
 $ColorDropDownBox.Items.add($Color)
}
$ColorDropDownBox.Add_SelectedValueChanged({Set-Color})
$Form.Controls.Add($ColorDropDownBox)
#endregion Color Selection Dropdown Box
#endregion Color Selection Selection

#region Color Output Box
#region Color Output Box Label
$ColorOutputBoxLabel = New-Object system.windows.Forms.Label
$ColorOutputBoxLabel.Text = "Color Output"
$ColorOutputBoxLabel.AutoSize = $true
$ColorOutputBoxLabel.Width = 25
$ColorOutputBoxLabel.Height = 10
$ColorOutputBoxLabel.location = new-object system.drawing.point(20,70)
$ColorOutputBoxLabel.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($ColorOutputBoxLabel)
#endregion Color Output Box Label
$ColorOutputBox = New-Object System.Windows.Forms.TextBox
$ColorOutputBox.Location = New-Object System.Drawing.Size(20,90)
$ColorOutputBox.Size = New-Object System.Drawing.Size(320,320)
$ColorOutputBox.MultiLine = $true
$ColorOutputBox.ScrollBars = "Vertical"
$Form.Controls.Add($ColorOutputBox)
#endregion Color Output Box


$Form.Add_Shown({$Form.Activate()})
Clear-Host
[void] $Form.ShowDialog()