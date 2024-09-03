# Define the fixed directory path
$directoryPath = "C:\Programming\webapp\blog\dangerous-debris\src\content\blog"

# Get the current date and time, then subtract 45 minutes
$currentDate = (Get-Date).AddMinutes(-45)

# Format dates for filename and frontmatter
$fileNameDate = $currentDate.ToString("yyyyMMdd")
$pubDatetime = $currentDate.ToString("yyyy-MM-ddTHH:mm:ssZ")
$titleDate = $currentDate.ToString("dd-MM-yyyy")

# Create new filename
$newFileName = "sj-$fileNameDate.md"
$newFilePath = Join-Path -Path $directoryPath -ChildPath $newFileName

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

# Select a random file from the directory
$randomFile = Get-ChildItem -Path $directoryPath -File | Get-Random
$randomFilePath = $randomFile.FullName

# Extract description from the random file's frontmatter
$metadata = Get-FileMetadata $randomFilePath
$description = if ($metadata -and $metadata.ContainsKey("description")) { 
  $metadata.description 
}
else { 
  $randomFile.Name 
}

# Create the content for the new file
$content = @"
---
author: tpotts
pubDatetime: $pubDatetime
title: Study Journal $titleDate
slug: sj-$fileNameDate
featured: false
draft: false
tags:
  - study-journal
description: Study Journal entry for $titleDate
---
# Where I'm at
-
# What I learnt
-
# What I did
-
# What I reviewed
The content that I reviewed today was: [$description](./$($randomFile.Name))
-
"@

# Check if the directory exists, create it if it doesn't
if (-not (Test-Path -Path $directoryPath)) {
  New-Item -ItemType Directory -Path $directoryPath -Force
}

# Write the content to the new file
Set-Content -Path $newFilePath -Value $content

# Output results
Write-Host "New Study Journal entry created: $newFilePath"
Write-Host "File selected for review: $($randomFile.Name)"
Write-Host "Description used for link: $description"