$lgButton.Add_Click({
    $Form.Cursor = [System.Windows.Input.Cursors]::Wait;

    if ($checkboxDb.isChecked) { $newCheckboxDb = '--db '; }
    if ($checkboxShops.isChecked) { $newCheckboxShops = '--shops '; }
    if ($checkboxForce.isChecked) { $newCheckboxForce = '--force '; }
    if ($checkboxAws.isChecked) { $newCheckboxAws = '--with-aws '; }
    if ($checkboxDbUpdate.isChecked) { $newCheckboxDbUpdate = '--db-update '; }
    if ($checkboxApi.isChecked) { $newCheckboxApi = '--api '; }
    if ($checkboxSp.isChecked) { $newCheckboxSp = '--serviceportal '; }
    if ($checkboxUpdate.isChecked) { $newCheckboxUpdate = '--update '; }

    $contextString = "$($newCheckboxDb)$($newCheckboxShops)$($newCheckboxForce)$($newCheckboxAws)$($newCheckboxDbUpdate)$($newCheckboxApi)$($newCheckboxSp)$($newCheckboxUpdate)";
    $validateDatetime = validate-lg-datetime -DateTime $lgTextBox.text;

    if ($contextString -replace '\s', '' -eq '' -or $validateDatetime -eq $false) {
        [System.Windows.MessageBox]::Show($lgMissingDialog,'LG input','OK','Warning');
        $Form.Cursor = [System.Windows.Input.Cursors]::Arrow;
    } else {
        $apiKey = $($config.lg.api_key);

        $json = @{
            context = $contextString
            start_date = $lgTextBox.text
            reason = "lg"
        }

        # [Debug]
        #        write-host $apiKey;
        #        write-host $contextString;
        #        write-host $dateString;

        $body = $json | ConvertTo-Json
        $url = 'https://cvrztj3vg1.execute-api.eu-central-1.amazonaws.com/prod/queue'
        $headers = @{
            'Content-Type' = 'application/json'
            'Accept' = 'application/json'
            'x-api-key' = $apiKey
        }

        Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body

        $Form.Cursor = [System.Windows.Input.Cursors]::Arrow;

        [System.Windows.MessageBox]::Show($lgSuccessDialog,'LG output','OK','Warning');
    }
});

$nowButton.Add_Click({
    $lgTextBox.Text = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
});