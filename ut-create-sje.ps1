# Define the fixed directory path
$directoryPath = "C:\Programming\webapp\blog\dangerous-debris\src\content\blog"

# Get the current date and time
$currentDate = Get-Date

# Format the date for the filename
$fileNameDate = $currentDate.ToString("yyyyMMdd")

# Create the new filename
$newFileName = "sj-$fileNameDate.md"

# Format the date and time for the frontmatter
$pubDatetime = $currentDate.ToString("yyyy-MM-ddTHH:mm:ssZ")
$titleDate = $currentDate.ToString("dd-MM-yyyy")

# Create the frontmatter content
$frontmatter = @"
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

"@

# Create the initial content
$initialContent = @"
# Where I'm at
- 

# What I learnt
- 

# What I did
- 

"@

# Create the full path for the new file
$newFilePath = Join-Path -Path $directoryPath -ChildPath $newFileName

# Combine the frontmatter and initial content
$fullContent = $frontmatter + $initialContent

# Check if the directory exists
if (-not (Test-Path -Path $directoryPath)) {
    Write-Host "The specified directory does not exist. Creating it now."
    New-Item -ItemType Directory -Path $directoryPath -Force
}

# Write the full content to the new file
Set-Content -Path $newFilePath -Value $fullContent

Write-Host "New Study Journal entry created: $newFilePath"