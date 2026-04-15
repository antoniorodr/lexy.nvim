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

local function find_docs(query)
	local data_dir = data_folder()

	for file in vim.fs.dir(data_dir) do
		if file:match(query) then
			open_file_buffer(data_dir .. file)
		end
	end
end

return {
	data_folder = data_folder,
	file_info = file_info,
	open_file_buffer = open_file_buffer,
}
