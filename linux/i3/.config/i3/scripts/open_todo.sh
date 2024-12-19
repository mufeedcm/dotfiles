#!/bin/bash
# Open today's to-do file in Neovim inside Kitty

todo_dir=~/notes/5.TODO
todo_file="$todo_dir/$(date +'%Y-%m-%d').md"
template_file=~/notes/4.Templates/todo-template.md

# Create the file if it doesn't exist, using the template with the current date
if [[ ! -f "$todo_file" ]]; then
    # Replace {{date}} with the actual date and copy the template to the new to-do file
    sed "s/{{date}}/$(date +'%Y-%m-%d')/g" "$template_file" > "$todo_file"
fi

# Open the file with Kitty and Neovim
kitty --class "todo_float" nvim "$todo_file"
