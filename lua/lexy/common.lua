local function data_folder()
	local folder = os.getenv("HOME") .. "/.config/lexy/files/"
	return folder
end

local function file_info(filename)
	local name, extension = filename:match("(.+)%.([^%.]+)$")

	if name then
		return name, extension
	else
		return filename, nil
	end
end

local function open_file_buffer(path)
	vim.cmd("edit " .. path)

	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].readonly = true
	vim.bo[buf].modifiable = false
	vim.diagnostic.enable(false, { bufnr = buf })
end

return {
	data_folder = data_folder,
	file_info = file_info,
	open_file_buffer = open_file_buffer,
}
