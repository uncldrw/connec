#region XAML window definition
# Right-click XAML and choose WPF/Edit... to edit WPF Design
# in your favorite WPF editing tool
$xaml = @'

<Window
   xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
   xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
   xmlns:d="http://schemas.microsoft.com/expression/blend/2008" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="d"
   MinWidth="200"
   Width ="400"
   SizeToContent="Height"
   Title="Backup"
   Topmost="True" Height="250.77">
    <Grid>
        <Label Content="Gesamtfortschritt:" HorizontalAlignment="Left" Margin="20,3,0,0" VerticalAlignment="Top"/>
        <ProgressBar Height="20" Margin="20,34,20,0" VerticalAlignment="Top" Minimum="0" Maximum="100" Value="0" Name="pbStatusTotal"/>
        <TextBlock Text="{Binding ElementName=pbStatusTotal, Path=Value, StringFormat={}{0:0}%}" HorizontalAlignment="Center" Margin="188,36,182,168" />
        <Label Content="Aktueller Ordner:" HorizontalAlignment="Left" Margin="20,59,0,0" VerticalAlignment="Top"/>
        <ProgressBar Height="20" Margin="20,90,20,0" VerticalAlignment="Top" Minimum="0" Maximum="100" Value="60" Name="pbStatusCurrentDirectory"/>
        <TextBlock Text="{Binding ElementName=pbStatusCurrentDirectory, Path=Value, StringFormat={}{0:0}%}" HorizontalAlignment="Center" Margin="188,92,182,112" RenderTransformOrigin="0.31,0.521" />
    </Grid>
</Window>

'@
#endregion

#region Code Behind
function Convert-XAMLtoWindow
{
  param
  (
    [Parameter(Mandatory=$true)]
    [string]
    $XAML
  )
  
  Add-Type -AssemblyName PresentationFramework
  
  $reader = [XML.XMLReader]::Create([IO.StringReader]$XAML)
  $result = [Windows.Markup.XAMLReader]::Load($reader)
  $reader.Close()
  $reader = [XML.XMLReader]::Create([IO.StringReader]$XAML)
  while ($reader.Read())
  {
      $name=$reader.GetAttribute('Name')
      if (!$name) { $name=$reader.GetAttribute('x:Name') }
      if($name)
      {$result | Add-Member NoteProperty -Name $name -Value $result.FindName($name) -Force}
  }
  $reader.Close()
  $result
}

function Show-WPFWindow
{
  param
  (
    [Parameter(Mandatory=$true)]
    [Windows.Window]
    $Window
  )
  
  $result = $null
  $null = $window.Dispatcher.InvokeAsync{
    $result = $window.ShowDialog()
    Set-Variable -Name result -Value $result -Scope 1
  }.Wait()
  $result
}
#endregion Code Behind

#region Convert XAML to Window
$window = Convert-XAMLtoWindow -XAML $xaml 
#endregion

#region Manipulate Window Content
$pbStatusTotal = $window.FindName('pbStatusTotal')
$pbStatusTotal.Value = 0
#endregion

$syncHash = [hashtable]::Synchronized(@{})
$syncHash.pbStatusTotal = $pbStatusTotal

$newRunspace = [runspacefactory]::CreateRunspace()
$newRunspace.ApartmentState = "STA"
$newRunspace.ThreadOptions = "ReuseThread" 
$newRunspace.Open()
$newRunspace.SessionStateProxy.SetVariable("syncHash",$syncHash)

$newPowershell = [powershell]::Create()
$newPowershell.AddScript({
    # in this expample we set the progress-bar value every 500 ms
    for ($i = 1;$i -le 10;$i++){
        sleep -Milliseconds 100
        $syncHash.pbStatusTotal.Dispatcher.Invoke("Normal", [action]{$syncHash.pbStatusTotal.Value=$i *10})
    }
}) | out-null

$newPowershell.Runspace = $newRunspace

$window.add_ContentRendered({
    $handle = $newPowershell.BeginInvoke()
})

# Show Window
$result = Show-WPFWindow -Window $window
