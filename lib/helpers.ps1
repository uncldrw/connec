<#
    Get and format instances
#>
function Get-and-format-instances {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][array] $accounts,
        [Parameter(Mandatory)][system.Windows.Forms.ComboBox] $sshListAccounts,
        [Parameter(Mandatory)][system.Windows.Forms.ComboBox] $sshListInstances
    )

    $selectedAccount = $accounts[$sshListAccounts.SelectedItem];
    $instances = @();

    # [Debug]
    write-host "Selected item: $selectedAccount";

    # Get running instances per account
    $result = aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId, Tags[?Key==`Name`]| [0].Value]' --filters Name=instance-state-name,Values=running --profile $selectedAccount --output json | ConvertFrom-Json;

    # Clear $sshListInstances first
    $sshListInstances.Items.Clear();

    # Format instances in dropdown view
    for ($i=0; $i -lt $result.length; $i++){
        $instances.Add($result[$i].split(" ")[1], $result[$i].split(" ")[0]);

        $string = $result[$i].split(" ")[1] + "[" + $result[$i].split(" ")[0] + "]";
        $sshListInstances.Items.Add($string);
    }

    # [Debug]
    # write-host $result[0];

    return $instances;
}

<#
    Hide window
#>
function Hide-Window {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][boolean] $toggle
    )

    Write-Verbose 'Hiding PowerShell console...'
    # .NET method for hiding the PowerShell console window
    # https://stackoverflow.com/questions/40617800/opening-powershell-script-and-hide-command-prompt-but-not-the-gui
    Add-Type -Name Window -Namespace Console -MemberDefinition '
    [DllImport("Kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
    '
    $consolePtr = [Console.Window]::GetConsoleWindow()
    [Console.Window]::ShowWindow($consolePtr, $toggle) # 0 = hide
}

<#
    Fill sshListAccounts
#>
function Set-List-Accounts {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][array] $accounts,
        [Parameter(Mandatory)][system.Windows.Forms.ComboBox] $combobox
    )

    # Add accounts to sshListAccounts combobox
    foreach($account in $accounts.keys)
    {
        # [Debug]
        # Key
        # $account 

        # Value
        # $accounts.$account

        $combobox.Items.Add($account);
    }
}

function clear-grid {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][system.windows.controls.grid] $grid
    )

    # Unload table first
    $grid.Children.Clear();
    $grid.RowDefinitions.Clear();
    $grid.ColumnDefinitions.Clear();
}

<#
    Validate LG timestamp
#>
function validate-lg-datetime {
    param (
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [string]$DateTime
    )

    if ($DateTime -eq '') {
        return $false;
    }

    $format = 'yyyy-MM-dd HH:mm:ss'

    try {
        [void][datetime]::ParseExact($DateTime, $format, [System.Globalization.CultureInfo]::InvariantCulture)
        return $true;
    } catch {
        return $false;
    }
}
