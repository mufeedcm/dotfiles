-- Compile with GCC

vim.keymap.set("n", "<Leader>cb", function()
	vim.cmd("write") -- Save the current file
	local filepath = vim.fn.expand("%:p")
	local filename = vim.fn.expand("%:t:r")
	local bin_dir = "bin"
	local output = bin_dir .. "/" .. filename

	-- Create bin/ directory if it doesn't exist
	if vim.fn.isdirectory(bin_dir) == 0 then
		vim.fn.mkdir(bin_dir, "p")
	end

	-- Compile the file and place the executable in bin/
	local cmd = "gcc " .. filepath .. " -o " .. output
	vim.cmd('VimuxRunCommand("' .. cmd .. '")') -- Run the GCC command
end, { buffer = true, desc = "Compile with GCC" })

-- Run the executable and switch focus to terminal
vim.keymap.set("n", "<Leader>cr", function()
	local filename = vim.fn.expand("%:t:r") -- Get the filename without extension
	local bin_path = "bin/" .. filename
	local current_path = "./" .. filename

	-- Check if the bin/ directory exists and the file is executable
	if vim.fn.isdirectory("bin") == 1 and vim.fn.filereadable(bin_path) == 1 then
		vim.cmd('VimuxRunCommand("clear; ' .. bin_path .. '")') -- Run from bin/
		vim.cmd("VimuxZoomRunner") -- Switch focus to terminal
	elseif vim.fn.filereadable(current_path) == 1 then
		vim.cmd('VimuxRunCommand("clear; ' .. current_path .. '")') -- Run from current directory
		vim.cmd("VimuxZoomRunner") -- Switch focus to terminal
	else
		print("Executable not found in bin/ or current directory!")
	end
end, { buffer = true, desc = "Run from bin/ or current directory and focus terminal" })
