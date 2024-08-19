# Set the directory path (change this to your desired directory)
$directoryPath = "C:\Programming\webapp\blog\dangerous-debris\src\content\blog"

# Get all files in the directory and sort them alphabetically
$files = Get-ChildItem -Path $directoryPath -File | Sort-Object Name

# Create an array to store the file information
$fileArray = @()

# Assign numbers to files and create the array of key-value pairs
for ($i = 1; $i -le $files.Count; $i++) {
    $fileArray += @{$i = $files[$i - 1].FullName }
}

# Count the number of objects in the array
$n = $fileArray.Count

# Generate a random number between 1 and n
$randomNumber = Get-Random -Minimum 1 -Maximum ($n + 1)

# Get the selected file path
$selectedFilePath = $fileArray[$randomNumber - 1].$randomNumber

# Get the file name
$selectedFileName = [System.IO.Path]::GetFileName($selectedFilePath)

# Function to extract metadata from file
function Get-FileMetadata($filePath) {
    $content = Get-Content $filePath -Raw
    if ($content -match '(?s)^---\s*\r?\n(.*?)\r?\n---') {
        $metadata = $matches[1] -split "\r?\n"
        $metadataObj = @{}
        foreach ($line in $metadata) {
            if ($line -match '^(\w+):\s*(.*)$') {
                $key = $matches[1]
                $value = $matches[2].Trim()
                if ($value -match '^\[.*\]$') {
                    # Handle array values
                    $value = $value.Trim('[]') -split ',\s*' | ForEach-Object { $_.Trim() }
                }
                $metadataObj[$key] = $value
            }
        }
        return $metadataObj
    }
    return $null
}

# Extract metadata
$metadata = Get-FileMetadata $selectedFilePath

# Output the result
Write-Host "Selected file: [$selectedFileName]"
if ($metadata) {
    Write-Host "`nMetadata:"
    foreach ($key in $metadata.Keys) {
        $value = $metadata[$key]
        if ($value -is [array]) {
            $value = $value -join ", "
        }
        Write-Host "  $key - $value"
    }
}
else {
    Write-Host "No metadata found in the file."
}