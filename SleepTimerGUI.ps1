Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Main Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Sleep Timer"
$form.Size = New-Object System.Drawing.Size(300,180)
$form.StartPosition = "CenterScreen"

# Minutes Label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Enter minutes:"
$label.Location = New-Object System.Drawing.Point(20,20)
$label.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($label)

# Input Box
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(130, 18)
$textBox.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($textBox)

# Start Button
$startButton = New-Object System.Windows.Forms.Button
$startButton.Text = "Start"
$startButton.Location = New-Object System.Drawing.Point(20,60)
$form.Controls.Add($startButton)

# Cancel Button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Text = "Cancel"
$cancelButton.Location = New-Object System.Drawing.Point(130,60)
$cancelButton.Enabled = $false
$form.Controls.Add($cancelButton)

# Notify Icon (Tray)
$trayIcon = New-Object System.Windows.Forms.NotifyIcon
$trayIcon.Icon = [System.Drawing.SystemIcons]::Information
$trayIcon.Visible = $true
$trayIcon.Text = "Sleep Timer"

# Timer L
$timerJob = $null
$startButton.Add_Click({
    $minutes = $textBox.Text -as [int]
    if ($minutes -le 0) {
        [System.Windows.Forms.MessageBox]::Show("Enter a valid number of minutes.")
        return
    }

    $seconds = $minutes * 60
    $trayIcon.BalloonTipTitle = "Sleep Timer"
    $trayIcon.BalloonTipText = "PC will sleep in $minutes minute(s)"
    $trayIcon.ShowBalloonTip(3000)

    $startButton.Enabled = $false
    $cancelButton.Enabled = $true

    # Srt background
    $script:timerJob = Start-Job {
        param($seconds)
        Start-Sleep -Seconds $seconds
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.Application]::SetSuspendState("Suspend", $false, $false)
    } -ArgumentList $seconds
})

# Cancels L
$cancelButton.Add_Click({
    if ($timerJob -and ($timerJob.State -eq 'Running')) {
        Stop-Job $timerJob | Out-Null
        Remove-Job $timerJob
        $trayIcon.BalloonTipTitle = "Sleep Timer"
        $trayIcon.BalloonTipText = "Sleep cancelled."
        $trayIcon.ShowBalloonTip(3000)
    }
    $startButton.Enabled = $true
    $cancelButton.Enabled = $false
})

# Cleanup on exit
$form.Add_FormClosing({
    $trayIcon.Dispose()
    if ($timerJob) {
        Remove-Job $timerJob -Force
    }
})

# Run the form
[void]$form.ShowDialog()
