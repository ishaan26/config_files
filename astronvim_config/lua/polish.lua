-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes

local function setup_pandoc_docx()
	local function buf_read_cb()
		local original_file = vim.fn.expand("%:p") -- Full path
		local temp_tex_file = original_file .. ".tmp.tex"
		-- Convert docx to latex
		local cmd = "pandoc -f docx -t latex "
			.. vim.fn.shellescape(original_file)
			.. " -o "
			.. vim.fn.shellescape(temp_tex_file)
		local result = os.execute(cmd)
		if result ~= 0 then
			vim.notify(
				"Pandoc read failed: " .. original_file .. " (exit code: " .. result .. ")",
				vim.log.levels.ERROR
			)
			return
		end
		-- Read the temp_tex_file into the buffer
		local file = io.open(temp_tex_file, "r")
		if not file then
			vim.notify("Failed to open temp file: " .. temp_tex_file, vim.log.levels.ERROR)
			return
		end
		local content = file:read("*a")
		file:close()
		vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
		-- Set filetype to latex
		vim.bo.filetype = "tex"
		-- Delete the temp_tex_file
		os.remove(temp_tex_file)
	end

	local function buf_write_cmd_cb()
		local original_file = vim.fn.expand("%:p") -- Full path
		local temp_tex_file = original_file .. ".tmp.tex"
		-- Write buffer content to temp_tex_file
		local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
		local file = io.open(temp_tex_file, "w")
		if not file then
			vim.notify("Failed to write temp file: " .. temp_tex_file, vim.log.levels.ERROR)
			return
		end
		file:write(content)
		file:close()
		-- Convert latex to docx
		local cmd = "pandoc -f latex -t docx "
			.. vim.fn.shellescape(temp_tex_file)
			.. " -o "
			.. vim.fn.shellescape(original_file)
		local result = vim.fn.system(cmd)
		if vim.v.shell_error ~= 0 then
			vim.notify("Pandoc write failed: " .. original_file .. " (error: " .. result .. ")", vim.log.levels.ERROR)
			os.remove(temp_tex_file)
			return
		end
		-- Delete the temp_tex_file
		os.remove(temp_tex_file)
		-- Mark buffer as not modified
		vim.bo.modified = false
	end

	-- Set up autocmd for reading docx files
	vim.api.nvim_create_autocmd("BufRead", {
		pattern = "*.docx",
		callback = buf_read_cb,
	})

	-- Set up autocmd for writing docx files
	vim.api.nvim_create_autocmd("BufWriteCmd", {
		pattern = "*.docx",
		callback = buf_write_cmd_cb,
	})
end

setup_pandoc_docx()
