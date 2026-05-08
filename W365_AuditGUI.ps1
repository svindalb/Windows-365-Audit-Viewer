# Cloud PC Audit Event Viewer with Filters
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Cloud PC Audit Event Viewer"
$form.Size = New-Object System.Drawing.Size(1400, 800)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::White
$form.MinimumSize = New-Object System.Drawing.Size(1200, 600)

# Status Label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Location = New-Object System.Drawing.Point(10, 10)
$statusLabel.Size = New-Object System.Drawing.Size(700, 20)
$statusLabel.Text = "Click 'Load Data' to fetch audit events..."
$statusLabel.ForeColor = [System.Drawing.Color]::Blue
$statusLabel.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
$form.Controls.Add($statusLabel)

# Progress Bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(720, 10)
$progressBar.Size = New-Object System.Drawing.Size(500, 20)
$progressBar.Minimum = 0
$progressBar.Maximum = 100
$progressBar.Value = 0
$progressBar.Visible = $false
$progressBar.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($progressBar)

# Progress Percentage Label
$progressLabel = New-Object System.Windows.Forms.Label
$progressLabel.Location = New-Object System.Drawing.Point(1210, 10)
$progressLabel.Size = New-Object System.Drawing.Size(60, 20)
$progressLabel.Text = "0%"
$progressLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$progressLabel.ForeColor = [System.Drawing.Color]::Blue
$progressLabel.Visible = $false
$progressLabel.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($progressLabel)

# Load Data Button
$loadButton = New-Object System.Windows.Forms.Button
$loadButton.Location = New-Object System.Drawing.Point(10, 40)
$loadButton.Size = New-Object System.Drawing.Size(120, 30)
$loadButton.Text = "Load Data"
$loadButton.BackColor = [System.Drawing.Color]::DodgerBlue
$loadButton.ForeColor = [System.Drawing.Color]::White
$loadButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($loadButton)

# Apply Filter Button
$filterButton = New-Object System.Windows.Forms.Button
$filterButton.Location = New-Object System.Drawing.Point(140, 40)
$filterButton.Size = New-Object System.Drawing.Size(105, 30)
$filterButton.Text = "Apply Filter"
$filterButton.BackColor = [System.Drawing.Color]::Green
$filterButton.ForeColor = [System.Drawing.Color]::White
$filterButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($filterButton)

# Clear Filter Button
$clearButton = New-Object System.Windows.Forms.Button
$clearButton.Location = New-Object System.Drawing.Point(250, 40)
$clearButton.Size = New-Object System.Drawing.Size(100, 30)
$clearButton.Text = "Clear Filter"
$clearButton.BackColor = [System.Drawing.Color]::Gray
$clearButton.ForeColor = [System.Drawing.Color]::White
$clearButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($clearButton)

# Export Button
$exportButton = New-Object System.Windows.Forms.Button
$exportButton.Location = New-Object System.Drawing.Point(360, 40)
$exportButton.Size = New-Object System.Drawing.Size(110, 30)
$exportButton.Text = "Export CSV"
$exportButton.BackColor = [System.Drawing.Color]::Orange
$exportButton.ForeColor = [System.Drawing.Color]::White
$exportButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$exportButton.Enabled = $false
$form.Controls.Add($exportButton)

# Activity Type Label
$activityTypeLabel = New-Object System.Windows.Forms.Label
$activityTypeLabel.Location = New-Object System.Drawing.Point(10, 80)
$activityTypeLabel.Size = New-Object System.Drawing.Size(120, 20)
$activityTypeLabel.Text = "Activity Type:"
$form.Controls.Add($activityTypeLabel)

# Activity Type Dropdown
$activityTypeCombo = New-Object System.Windows.Forms.ComboBox
$activityTypeCombo.Location = New-Object System.Drawing.Point(130, 80)
$activityTypeCombo.Size = New-Object System.Drawing.Size(250, 25)
$activityTypeCombo.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$activityTypeCombo.Font=New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
$activityTypeCombo.Items.Add("All")
$activityTypeCombo.SelectedIndex = 0
$form.Controls.Add($activityTypeCombo)

# Activity Result Label
$activityResultLabel = New-Object System.Windows.Forms.Label
$activityResultLabel.Location = New-Object System.Drawing.Point(400, 82)
$activityResultLabel.Size = New-Object System.Drawing.Size(120, 20)
$activityResultLabel.Text = "Activity Result:"
$form.Controls.Add($activityResultLabel)

# Activity Result Dropdown
$activityResultCombo = New-Object System.Windows.Forms.ComboBox
$activityResultCombo.Location = New-Object System.Drawing.Point(530, 80)
$activityResultCombo.Size = New-Object System.Drawing.Size(200, 25)
$activityResultCombo.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$activityResultCombo.Font=New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
$activityResultCombo.Items.AddRange(@("All", "Success", "Failure"))
$activityResultCombo.SelectedIndex = 0
$form.Controls.Add($activityResultCombo)

# Search Label
$searchLabel = New-Object System.Windows.Forms.Label
$searchLabel.Location = New-Object System.Drawing.Point(740, 82)
$searchLabel.Size = New-Object System.Drawing.Size(120, 20)
$searchLabel.Text = "Search (UPN):"
$form.Controls.Add($searchLabel)

# Search TextBox
$searchTextBox = New-Object System.Windows.Forms.TextBox
$searchTextBox.Location = New-Object System.Drawing.Point(870, 80)
$searchTextBox.Size = New-Object System.Drawing.Size(290, 25)
$searchTextBox.Font=New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
$searchTextBox.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($searchTextBox)

# Resource Id Label
$resourceIdLabel = New-Object System.Windows.Forms.Label
$resourceIdLabel.Location = New-Object System.Drawing.Point(10, 117)
$resourceIdLabel.Size = New-Object System.Drawing.Size(120, 20)
$resourceIdLabel.Text = "Resource Id:"
$form.Controls.Add($resourceIdLabel)

# Resource Id TextBox
$resourceIdTextBox = New-Object System.Windows.Forms.TextBox
$resourceIdTextBox.Location = New-Object System.Drawing.Point(130, 115)
$resourceIdTextBox.Size = New-Object System.Drawing.Size(250, 25)
$resourceIdTextBox.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
$form.Controls.Add($resourceIdTextBox)

# Date Range Enable CheckBox
$dateRangeCheckBox = New-Object System.Windows.Forms.CheckBox
$dateRangeCheckBox.Location = New-Object System.Drawing.Point(400, 117)
$dateRangeCheckBox.Size = New-Object System.Drawing.Size(120, 22)
$dateRangeCheckBox.Text = "Use date range"
$form.Controls.Add($dateRangeCheckBox)

# From Date Label
$fromDateLabel = New-Object System.Windows.Forms.Label
$fromDateLabel.Location = New-Object System.Drawing.Point(530, 117)
$fromDateLabel.Size = New-Object System.Drawing.Size(40, 20)
$fromDateLabel.Text = "From:"
$form.Controls.Add($fromDateLabel)

# From Date Picker
$fromDatePicker = New-Object System.Windows.Forms.DateTimePicker
$fromDatePicker.Location = New-Object System.Drawing.Point(575, 115)
$fromDatePicker.Size = New-Object System.Drawing.Size(220, 25)
$fromDatePicker.Format = [System.Windows.Forms.DateTimePickerFormat]::Custom
$fromDatePicker.CustomFormat = "yyyy-MM-dd HH:mm"
$fromDatePicker.Value = (Get-Date).AddDays(-7)
$fromDatePicker.Enabled = $false
$form.Controls.Add($fromDatePicker)

# To Date Label
$toDateLabel = New-Object System.Windows.Forms.Label
$toDateLabel.Location = New-Object System.Drawing.Point(810, 117)
$toDateLabel.Size = New-Object System.Drawing.Size(30, 20)
$toDateLabel.Text = "To:"
$form.Controls.Add($toDateLabel)

# To Date Picker
$toDatePicker = New-Object System.Windows.Forms.DateTimePicker
$toDatePicker.Location = New-Object System.Drawing.Point(845, 115)
$toDatePicker.Size = New-Object System.Drawing.Size(220, 25)
$toDatePicker.Format = [System.Windows.Forms.DateTimePickerFormat]::Custom
$toDatePicker.CustomFormat = "yyyy-MM-dd HH:mm"
$toDatePicker.Value = Get-Date
$toDatePicker.Enabled = $false
$form.Controls.Add($toDatePicker)

$dateRangeCheckBox.Add_CheckedChanged({
    $fromDatePicker.Enabled = $dateRangeCheckBox.Checked
    $toDatePicker.Enabled = $dateRangeCheckBox.Checked
})

# Auto-enable the date range filter as soon as the user changes either picker
$fromDatePicker.Add_ValueChanged({
    if (-not $dateRangeCheckBox.Checked) { $dateRangeCheckBox.Checked = $true }
})
$toDatePicker.Add_ValueChanged({
    if (-not $dateRangeCheckBox.Checked) { $dateRangeCheckBox.Checked = $true }
})

# Results Count Label
$countLabel = New-Object System.Windows.Forms.Label
$countLabel.Location = New-Object System.Drawing.Point(10, 150)
$countLabel.Size = New-Object System.Drawing.Size(1360, 20)
$countLabel.Text = "Records: 0"
$countLabel.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($countLabel)

# DataGridView
$dataGridView = New-Object System.Windows.Forms.DataGridView
$dataGridView.Location = New-Object System.Drawing.Point(10, 175)
$dataGridView.Size = New-Object System.Drawing.Size(1360, 585)
$dataGridView.AutoSizeColumnsMode = [System.Windows.Forms.DataGridViewAutoSizeColumnsMode]::AllCells
$dataGridView.AllowUserToAddRows = $false
$dataGridView.AllowUserToDeleteRows = $false
$dataGridView.ReadOnly = $true
$dataGridView.SelectionMode = [System.Windows.Forms.DataGridViewSelectionMode]::FullRowSelect
$dataGridView.BackgroundColor = [System.Drawing.Color]::White
$dataGridView.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
$dataGridView.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.Color]::DodgerBlue
$dataGridView.ColumnHeadersDefaultCellStyle.ForeColor = [System.Drawing.Color]::White
$dataGridView.ColumnHeadersDefaultCellStyle.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$dataGridView.ColumnHeadersHeight="60"
$dataGridView.EnableHeadersVisualStyles = $false
$dataGridView.AlternatingRowsDefaultCellStyle.BackColor = [System.Drawing.Color]::LightGray
$dataGridView.AutoSizeRowsMode = [System.Windows.Forms.DataGridViewAutoSizeRowsMode]::AllCells
$dataGridView.DefaultCellStyle.WrapMode = [System.Windows.Forms.DataGridViewTriState]::True
$dataGridView.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
$form.Controls.Add($dataGridView)

# Global data storage
$script:allData = @()
$script:filteredData = @()

# Function to load data
function Get-AuditData {
    try {
        # Show progress bar
        $progressBar.Value = 0
        $progressBar.Visible = $true
        $progressLabel.Visible = $true
        $progressLabel.Text = "0%"
        
        $statusLabel.Text = "Loading audit events from Microsoft Graph..."
        $statusLabel.ForeColor = [System.Drawing.Color]::Blue
        $form.Refresh()
        
        # Check if connected
        $progressBar.Value = 5
        $progressLabel.Text = "5%"
        $form.Refresh()
        $context = Get-MgContext -ErrorAction SilentlyContinue
        if (-not $context) {
            $statusLabel.Text = "Not connected to Microsoft Graph. Connecting..."
            $form.Refresh()
            Connect-MgGraph -Scopes "CloudPC.Read.All" -NoWelcome -TenantId "8bc60b89-006a-432f-92f2-32d9f7317197"
        }
        
        $progressBar.Value = 15
        $progressLabel.Text = "15%"
        $form.Refresh()
        
        # Fetch audit events
        # If a date range is selected, push it server-side via $filter so we don't pull
        # the entire audit history (avoids freezing the UI on large tenants).
        $graphFilter = $null
        if ($dateRangeCheckBox.Checked) {
            $fromUtcLoad = [datetime]::SpecifyKind($fromDatePicker.Value, [System.DateTimeKind]::Local).ToUniversalTime()
            $toUtcLoad   = [datetime]::SpecifyKind($toDatePicker.Value,   [System.DateTimeKind]::Local).ToUniversalTime()
            $fromIso = $fromUtcLoad.ToString("yyyy-MM-ddTHH:mm:ssZ")
            $toIso   = $toUtcLoad.ToString("yyyy-MM-ddTHH:mm:ssZ")
            $graphFilter = "activityDateTime ge $fromIso and activityDateTime le $toIso"
            $statusLabel.Text = "Fetching audit events ($fromIso .. $toIso UTC)..."
        } else {
            $statusLabel.Text = "Fetching audit events (all)..."
        }
        $form.Refresh()

        if ($graphFilter) {
            $auditEvents = Get-MgBetaDeviceManagementVirtualEndpointAuditEvent -All -Filter $graphFilter |
                Select-Object -Property ActivityDateTime,ActivityType,ActivityResult,Resources -ExpandProperty Actor |
                Select-Object -Property ActivityDateTime,ActivityType,ActivityResult,UserId,UserPrincipalName,Resources -ExpandProperty Resources |
                Select-Object ActivityDateTime,ActivityType,ActivityResult,ResourceId,UserId,UserPrincipalName
        } else {
            $auditEvents = Get-MgBetaDeviceManagementVirtualEndpointAuditEvent -All |
                Select-Object -Property ActivityDateTime,ActivityType,ActivityResult,Resources -ExpandProperty Actor |
                Select-Object -Property ActivityDateTime,ActivityType,ActivityResult,UserId,UserPrincipalName,Resources -ExpandProperty Resources |
                Select-Object ActivityDateTime,ActivityType,ActivityResult,ResourceId,UserId,UserPrincipalName
        }
        
        $progressBar.Value = 60
        $progressLabel.Text = "60%"
        $form.Refresh()
        
        if ($auditEvents.Count -eq 0) {
            $statusLabel.Text = "No audit events found."
            $statusLabel.ForeColor = [System.Drawing.Color]::Red
            $progressBar.Visible = $false
            $progressLabel.Visible = $false
            return
        }
        
        # Store the data
        $script:allData = $auditEvents
        
        $progressBar.Value = 70
        $progressLabel.Text = "70%"
        $statusLabel.Text = "Processing activity types..."
        $form.Refresh()
        
        # Populate Activity Type dropdown
        $uniqueActivityTypes = $script:allData | Select-Object -ExpandProperty ActivityType -Unique | Sort-Object
        $activityTypeCombo.Items.Clear()
        $activityTypeCombo.Items.Add("All")
        foreach ($type in $uniqueActivityTypes) {
            if ($type) {
                $activityTypeCombo.Items.Add($type)
            }
        }
        $activityTypeCombo.SelectedIndex = 0
        
        $progressBar.Value = 85
        $progressLabel.Text = "85%"
        $statusLabel.Text = "Loading data into grid..."
        $form.Refresh()
        
        # Display all data initially
        Update-DataGrid -data $script:allData
        
        $progressBar.Value = 99
        $progressLabel.Text = "99%"
        $statusLabel.Text = "Finalizing..."
        $form.Refresh()
        
        Start-Sleep -Milliseconds 300
        
        if ($progressBar.Value -lt 100) {
            $progressBar.Value = 100
        }
        $progressBar.Maximum = 101
        $progressBar.Value = 101
        $progressBar.Maximum = 100
        $progressBar.Value = 100
        $progressLabel.Text = "100%"
        $form.Refresh()
        
        Start-Sleep -Milliseconds 400
        
        $statusLabel.Text = "Data loaded successfully! Total records: $($script:allData.Count)"
        $statusLabel.ForeColor = [System.Drawing.Color]::Green
        $exportButton.Enabled = $true
        
        # Hide progress bar
        $progressBar.Visible = $false
        $progressLabel.Visible = $false
        
    } catch {
        $progressBar.Visible = $false
        $progressLabel.Visible = $false
        $statusLabel.Text = "Error loading data: $($_.Exception.Message)"
        $statusLabel.ForeColor = [System.Drawing.Color]::Red
        [System.Windows.Forms.MessageBox]::Show("Error loading audit events:`n`n$($_.Exception.Message)", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
}

# Function to update DataGridView
function Update-DataGrid {
    param($data)

    # Normalize to array so .Count works on single-item / null results
    if ($null -eq $data) {
        $data = @()
    } elseif ($data -isnot [System.Array] -and $data -isnot [System.Collections.IList]) {
        $data = @($data)
    }

    # Suspend layout & disable expensive auto-sizing while we rebuild — this fixes the flicker/freeze
    $dataGridView.SuspendLayout()
    $previousRowsMode = $dataGridView.AutoSizeRowsMode
    $dataGridView.AutoSizeRowsMode = [System.Windows.Forms.DataGridViewAutoSizeRowsMode]::None
    foreach ($col in $dataGridView.Columns) {
        $col.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::None
    }
    $dataGridView.DataSource = $null

    try {
        if ($data.Count -eq 0) {
            $countLabel.Text = "Records: 0 (No matching results)"
            $script:filteredData = @()
            return
        }

        # Create DataTable
        $dataTable = New-Object System.Data.DataTable
        $dataTable.BeginLoadData() | Out-Null

        # Add columns
        $dataTable.Columns.Add("Activity DateTime", [string]) | Out-Null
        $dataTable.Columns.Add("Activity Type", [string]) | Out-Null
        $dataTable.Columns.Add("Activity Result", [string]) | Out-Null
        $dataTable.Columns.Add("User Id", [string]) | Out-Null
        $dataTable.Columns.Add("Resource Id", [string]) | Out-Null
        $dataTable.Columns.Add("User Principal Name", [string]) | Out-Null

        # Add rows
        foreach ($item in $data) {
            $row = $dataTable.NewRow()
            $row["Activity DateTime"] = $item.ActivityDateTime
            $row["Activity Type"] = $item.ActivityType
            $row["Activity Result"] = $item.ActivityResult
            $row["User Id"] = $item.UserId
            $row["Resource Id"] = $item.ResourceId
            $row["User Principal Name"] = $item.UserPrincipalName
            $dataTable.Rows.Add($row)
        }

        $dataTable.EndLoadData() | Out-Null
        $dataGridView.DataSource = $dataTable

        # Re-apply auto-size once after data is bound
        for ($i = 0; $i -lt $dataGridView.Columns.Count - 1; $i++) {
            $dataGridView.Columns[$i].AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::AllCells
        }
        $dataGridView.Columns[$dataGridView.Columns.Count - 1].AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::Fill

        $countLabel.Text = "Records: $($data.Count)"
        $script:filteredData = $data
    }
    finally {
        $dataGridView.AutoSizeRowsMode = $previousRowsMode
        $dataGridView.ResumeLayout()
    }
}

# Function to apply filters
function Invoke-Filters {
    if ($script:allData.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("Please load data first.", "Info", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        return
    }
    
    $filtered = $script:allData

    # Filter by Activity Type
    if ($activityTypeCombo.SelectedItem -ne "All") {
        $selectedActivityType = $activityTypeCombo.SelectedItem
        $filtered = $filtered | Where-Object { $_.ActivityType -eq $selectedActivityType }
    }

    # Filter by Activity Result
    if ($activityResultCombo.SelectedItem -ne "All") {
        $selectedResult = $activityResultCombo.SelectedItem
        $filtered = $filtered | Where-Object { $_.ActivityResult -eq $selectedResult }
    }

    # Filter by Search (UserPrincipalName)
    if ($searchTextBox.Text.Trim() -ne "") {
        $searchTerm = $searchTextBox.Text.Trim()
        $filtered = $filtered | Where-Object { $_.UserPrincipalName -like "*$searchTerm*" }
    }

    # Filter by Resource Id
    if ($resourceIdTextBox.Text.Trim() -ne "") {
        $resourceIdTerm = $resourceIdTextBox.Text.Trim()
        $filtered = $filtered | Where-Object { $_.ResourceId -like "*$resourceIdTerm*" }
    }

    # Filter by Date Range (applied to in-memory results, not the Graph query)
    if ($dateRangeCheckBox.Checked) {
        # Pickers are local time. Treat events as UTC (Graph returns UTC) and compare in UTC.
        $fromUtc = [datetime]::SpecifyKind($fromDatePicker.Value, [System.DateTimeKind]::Local).ToUniversalTime()
        $toUtc   = [datetime]::SpecifyKind($toDatePicker.Value,   [System.DateTimeKind]::Local).ToUniversalTime()

        $filtered = $filtered | Where-Object {
            $raw = $_.ActivityDateTime
            $dt = $null
            if ($raw -is [datetime]) {
                # Force any Unspecified Kind to Utc (Graph returns UTC)
                if ($raw.Kind -eq [System.DateTimeKind]::Utc) {
                    $dt = $raw
                } elseif ($raw.Kind -eq [System.DateTimeKind]::Local) {
                    $dt = $raw.ToUniversalTime()
                } else {
                    $dt = [datetime]::SpecifyKind($raw, [System.DateTimeKind]::Utc)
                }
            } elseif ($raw -is [System.DateTimeOffset]) {
                $dt = $raw.UtcDateTime
            } elseif ($raw) {
                $parsed = [datetime]::MinValue
                $styles = [System.Globalization.DateTimeStyles]::AssumeUniversal -bor [System.Globalization.DateTimeStyles]::AdjustToUniversal
                if ([datetime]::TryParse([string]$raw, [System.Globalization.CultureInfo]::InvariantCulture, $styles, [ref]$parsed)) {
                    $dt = $parsed
                } elseif ([datetime]::TryParse([string]$raw, [System.Globalization.CultureInfo]::CurrentCulture, $styles, [ref]$parsed)) {
                    $dt = $parsed
                }
            }
            if ($null -eq $dt) { return $false }
            ($dt -ge $fromUtc) -and ($dt -le $toUtc)
        }
    }

    # Force array so .Count is reliable
    $filtered = @($filtered)

    Update-DataGrid -data $filtered
    $statusLabel.Text = "Filter applied. Showing $($filtered.Count) of $($script:allData.Count) records."
    $statusLabel.ForeColor = [System.Drawing.Color]::Green
}

# Function to clear filters
function Clear-Filters {
    $activityTypeCombo.SelectedIndex = 0
    $activityResultCombo.SelectedIndex = 0
    $searchTextBox.Clear()
    $resourceIdTextBox.Clear()
    $dateRangeCheckBox.Checked = $false
    $fromDatePicker.Value = (Get-Date).AddDays(-7)
    $toDatePicker.Value = Get-Date

    if ($script:allData.Count -gt 0) {
        Update-DataGrid -data $script:allData
        $statusLabel.Text = "Filters cleared. Showing all $($script:allData.Count) records."
        $statusLabel.ForeColor = [System.Drawing.Color]::Blue
    }
}

# Function to export to CSV
function Export-ToCsv {
    if ($script:filteredData.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show("No data to export.", "Info", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        return
    }
    
    $saveDialog = New-Object System.Windows.Forms.SaveFileDialog
    $saveDialog.Filter = "CSV Files (*.csv)|*.csv"
    $saveDialog.FileName = "CloudPC_AuditEvents_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv"
    
    if ($saveDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        try {
            $script:filteredData | Export-Csv -Path $saveDialog.FileName -NoTypeInformation -Encoding UTF8
            [System.Windows.Forms.MessageBox]::Show("Data exported successfully to:`n$($saveDialog.FileName)", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Error exporting data:`n$($_.Exception.Message)", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    }
}
# Event Handlers
$loadButton.Add_Click({ Get-AuditData })
$filterButton.Add_Click({ Invoke-Filters })
$clearButton.Add_Click({ Clear-Filters })
$exportButton.Add_Click({ Export-ToCsv })

# Allow Enter key in search box to apply filter
$searchTextBox.Add_KeyDown({
    if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Enter) {
        Invoke-Filters
    }
})

# Allow Enter key in resource id box to apply filter
$resourceIdTextBox.Add_KeyDown({
    if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Enter) {
        Invoke-Filters
    }
})

# Show the form
[void]$form.ShowDialog()
# End of Script