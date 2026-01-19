-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local function setup_pandoc_docx()
	local function buf_read_cb()
		local original_file = vim.fn.expand("%:p") -- Full path of original DOCX
		local base_name = vim.fn.expand("%:r") -- Base name without extension
		local new_typ_file = base_name .. ".typ" -- Persistent .typ file
		-- Convert docx to typst
		local cmd = "pandoc -f docx -t typst "
			.. vim.fn.shellescape(original_file)
			.. " -o "
			.. vim.fn.shellescape(new_typ_file)
		local result = os.execute(cmd)
		if result ~= 0 then
			vim.notify(
				"Pandoc read failed: " .. original_file .. " (exit code: " .. result .. ")",
				vim.log.levels.ERROR
			)
			return
		end
		-- Read the new_typ_file into the buffer
		local file = io.open(new_typ_file, "r")
		if not file then
			vim.notify("Failed to open typ file: " .. new_typ_file, vim.log.levels.ERROR)
			return
		end
		local content = file:read("*a")
		file:close()
		-- Set buffer to new .typ file name
		vim.api.nvim_buf_set_name(0, new_typ_file)
		vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
		-- Set filetype to typst
		vim.bo.filetype = "typst"
	end

	local function buf_write_cmd_cb()
		local typ_file = vim.fn.expand("%:p") -- Current buffer is the .typ file
		local base_name = vim.fn.expand("%:r") -- Base name without .typ extension
		local new_docx_file = base_name .. "_new.docx"
		-- Write buffer content to the .typ file
		local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
		local file = io.open(typ_file, "w")
		if not file then
			vim.notify("Failed to write typ file: " .. typ_file, vim.log.levels.ERROR)
			return
		end
		file:write(content)
		file:close()
		-- Convert typst to new docx
		local cmd = "pandoc -f typst -t docx "
			.. vim.fn.shellescape(typ_file)
			.. " -o "
			.. vim.fn.shellescape(new_docx_file)
		local result = vim.fn.system(cmd)
		if vim.v.shell_error ~= 0 then
			vim.notify("Pandoc write failed: " .. new_docx_file .. " (error: " .. result .. ")", vim.log.levels.ERROR)
			return
		end
		-- Mark buffer as not modified
		vim.bo.modified = false
	end

	-- Set up autocmd for reading docx files
	vim.api.nvim_create_autocmd("BufRead", {
		pattern = "*.docx",
		callback = buf_read_cb,
	})

	-- Set up autocmd for writing typst files created from docx
	vim.api.nvim_create_autocmd("BufWriteCmd", {
		pattern = "*.typ",
		callback = buf_write_cmd_cb,
	})
end

setup_pandoc_docx()
