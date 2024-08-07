# Set the directory path
$directoryPath = "C:\Programming\webapp\blog\dangerous-debris\src\content\blog"

# Get all .md files in the directory
$files = Get-ChildItem -Path $directoryPath -Filter "*.md"

foreach ($file in $files) {
    # Check if the file name starts with a date (YYYYMMDD.md)
    if ($file.Name -match "^\d{8}\.md$") {
        # Extract the date from the filename
        $date = [DateTime]::ParseExact($file.Name.Substring(0, 8), "yyyyMMdd", $null)
        
        # Create the new filename
        $newFileName = "sj-" + $file.Name
        
        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newFileName
        
        # Create the frontmatter content
        $frontmatter = @"
---
author: tpotts
pubDatetime: $($date.ToString("yyyy-MM-ddT00:00:00Z"))
title: Study Journal $($date.ToString("dd-MM-yyyy"))
slug: $($newFileName -replace '\.md$', '')
featured: false
draft: false
tags:
  - study-journal
description: Study Journal entry for $($date.ToString("dd-MM-yyyy"))
---

"@

        # Read the existing content of the file
        $content = Get-Content -Path (Join-Path -Path $directoryPath -ChildPath $newFileName) -Raw
        
        # Combine the frontmatter and existing content
        $newContent = $frontmatter + $content
        
        # Write the combined content back to the file
        Set-Content -Path (Join-Path -Path $directoryPath -ChildPath $newFileName) -Value $newContent
    }
}

Write-Host "File update process completed."