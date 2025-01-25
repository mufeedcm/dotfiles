#!/bin/bash
# Open today's to-do file in Neovim inside st

todo_dir=~/notes/5.TODO
todo_file="$todo_dir/$(date +'%Y-%m-%d').md"
template_file=~/notes/4.Templates/todo-template.md
yesterday_date=$(date +'%Y-%m-%d' -d "yesterday")
yesterday_todo_file="$todo_dir/$yesterday_date.md"

# Check if today's to-do file already exists. If it does, do nothing.
if [[ -f "$todo_file" ]]; then
    echo "Today's to-do file already exists, no changes made."
    st -e nvim "$todo_file"
    exit 0
fi

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

# Replace {{date}} and {{uncompleted}} in the template
final_content=$(sed -e "s/{{date}}/$(date +'%Y-%m-%d')/g" \
    -e "/{{uncompleted}}/r /dev/stdin" -e "s/{{uncompleted}}//g" \
    "$template_file" <<< "$unfinished_tasks")

# Create today's to-do file with the template and unfinished tasks
echo "$final_content" > "$todo_file"

# Open the file with st and Neovim
st -e nvim "$todo_file"
