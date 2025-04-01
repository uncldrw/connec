# Toggle window
# $controlToggleTerminal.Add_Click({
# 	# [Debug]
# 	write-host $this.isChecked;

# 	if ($this.isChecked -eq $true) {
# 		Hide-Window -toggle 1;
# 	} else {
# 		Hide-Window -toggle 0;
# 	}
# });

# Toggle expander
$controlExpander.Add_Expanded({
    $tabControl.Margin = "0,185,0,5";
});

$controlExpander.Add_Collapsed({
    $tabControl.Margin = "0,50,0,5";
});