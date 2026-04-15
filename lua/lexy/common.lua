local function data_folder()
	local folder = os.getenv("HOME") .. "/.config/lexy/files/"
	return folder
end

local function open_file_buffer(path)
	vim.cmd("edit " .. path)

	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].readonly = true
	vim.bo[buf].modifiable = false
	vim.diagnostic.enable(false, { bufnr = buf })
end
