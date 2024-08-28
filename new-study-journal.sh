#!/bin/zsh

# Directory path (update this to your macOS path)
DIRECTORY_PATH="/Users/thomaspotts/blog/blog/src/content/blog"

# Create directory if it doesn't exist
mkdir -p "$DIRECTORY_PATH"

# Get current date and time, then subtract 45 minutes
CURRENT_DATE=$(date -v -45M +"%Y-%m-%d %H:%M:%S")

# Format dates for filename and frontmatter
FILE_NAME_DATE=$(date -j -f "%Y-%m-%d %H:%M:%S" "$CURRENT_DATE" +"%Y%m%d")
PUB_DATETIME=$(date -j -f "%Y-%m-%d %H:%M:%S" "$CURRENT_DATE" +"%Y-%m-%dT%H:%M:%SZ")
TITLE_DATE=$(date -j -f "%Y-%m-%d %H:%M:%S" "$CURRENT_DATE" +"%d-%m-%Y")

# Create new filename
NEW_FILE_NAME="sj-$FILE_NAME_DATE.md"
NEW_FILE_PATH="$DIRECTORY_PATH/$NEW_FILE_NAME"

# Select a random file from the directory
RANDOM_FILE=$(ls "$DIRECTORY_PATH" | sort -R | head -1)
RANDOM_FILE_PATH="$DIRECTORY_PATH/$RANDOM_FILE"

# Extract description from the random file's frontmatter
DESCRIPTION=$(sed -n '/^description:/s/^description:\s*//p' "$RANDOM_FILE_PATH" | tr -d '"')

# If description is empty, use the file name as fallback
if [ -z "$DESCRIPTION" ]; then
    DESCRIPTION=$RANDOM_FILE
fi

# Create the content for the new file
cat > "$NEW_FILE_PATH" << EOL
---
author: tpotts
pubDatetime: $PUB_DATETIME
title: Study Journal $TITLE_DATE
slug: sj-$FILE_NAME_DATE
featured: false
draft: false
tags:
 - study-journal
description: Study Journal entry for $TITLE_DATE
---
# Where I'm at
- 

# What I learnt
- 

# What I did
- 

# What I reviewed
The content that I reviewed today was: [$DESCRIPTION](./$RANDOM_FILE)
- 
EOL

echo "New Study Journal entry created: $NEW_FILE_PATH"
echo "File selected for review: $RANDOM_FILE"
echo "Description used for link: $DESCRIPTION"