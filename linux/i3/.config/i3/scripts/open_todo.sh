#!/bin/bash
# Open today's to-do file in Neovim inside Kitty

todo_dir=~/notes/5.TODO
todo_file="$todo_dir/$(date +'%Y-%m-%d').md"
template_file=~/notes/4.Templates/todo-template.md
yesterday_date=$(date +'%Y-%m-%d' -d "yesterday")
yesterday_todo_file="$todo_dir/$yesterday_date.md"

# Extract unfinished tasks from yesterday's to-do file
unfinished_tasks=""
if [[ -f "$yesterday_todo_file" ]]; then
    unfinished_tasks=$(grep -E "^\- \[ ]" "$yesterday_todo_file")  # Extract tasks with [ ]
fi

# Check if the template exists
if [[ ! -f "$template_file" ]]; then
    echo "Template file does not exist!"
    exit 1
fi

# Escape special characters in unfinished tasks (to avoid issues in sed)
escaped_unfinished_tasks=$(echo "$unfinished_tasks" | sed 's/[&/\]/\\&/g')

# Replace newline characters with a temporary placeholder
escaped_unfinished_tasks=$(echo "$escaped_unfinished_tasks" | sed ':a;N;$!ba;s/\n/%%NEWLINE%%/g')

# Replace {{date}} and {{uncompleted}} in the template
sed -e "s/{{date}}/$(date +'%Y-%m-%d')/g" \
    -e "s|{{uncompleted}}|$escaped_unfinished_tasks|g" \
    "$template_file" > /tmp/test_output.md

# Restore newlines after the replacement and save to the todo file
final_unfinished_tasks=$(cat /tmp/test_output.md | sed 's/%%NEWLINE%%/\n/g')

# Create today's to-do file
echo "$final_unfinished_tasks" > "$todo_file"

# Open the file with Kitty and Neovim
kitty --class "todo_float" nvim "$todo_file"
