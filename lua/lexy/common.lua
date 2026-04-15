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

local function get_lexy_docs()
	local docs = {}
	for file in vim.fs.dir(data_folder()) do
		local filename = file_info(file)
		docs[filename] = vim.fs.joinpath(data_folder(), file)
	end
	return docs
end

return {
	data_folder = data_folder,
	file_info = file_info,
	get_lexy_docs = get_lexy_docs,
}
