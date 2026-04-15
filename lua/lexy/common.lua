local function data_folder()
	return os.getenv("HOME") .. "/.config/lexy/files/"
end

local function filename_to_display(filename)
	local name, extension = filename:match("(.+)%.([^%.]+)$")

	if name then
		return name, extension
	else
		return filename, nil
	end
end

local function get_lexy_docs()
	local docs = {}
	for file in vim.fs.dir(data_folder()) do
		local filename = filename_to_display(file)
		docs[filename] = vim.fs.joinpath(data_folder(), file)
	end
	return docs
end

return {
	data_folder = data_folder,
	filename_to_display = filename_to_display,
	get_lexy_docs = get_lexy_docs,
}
