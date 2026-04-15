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
	vim.cmd("edit " .. vim.fn.fnameescape(path))

	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].readonly = true
	vim.bo[buf].modifiable = false
	vim.diagnostic.enable(false, { bufnr = buf })
end

local function find_docs(query)
	local data_dir = data_folder()
	local wanted = query:lower()

	for file in vim.fs.dir(data_dir) do
		local name, _ = file_info(file)
		if name:lower() == wanted then
			open_file_buffer(data_dir .. file)
			return
		end
	end

	vim.notify("No documentation found for query: " .. query, vim.log.levels.WARN)
end

return {
	data_folder = data_folder,
	file_info = file_info,
	open_file_buffer = open_file_buffer,
	find_docs = find_docs,
}
