local function data_folder()
	local home = vim.loop.os_homedir()
	return home .. "/.config/lexy/files/"
end

---@param filename string
---@return string name, string|nil extension
local function file_info(filename)
	local name, extension = filename:match("(.+)%.([^%.]+)$")

	if name then
		return name, extension
	else
		return filename, nil
	end
end

---@param path string
local function open_file_buffer(path)
	local target_width = math.max(math.floor(vim.o.columns * 0.45), 1)
	local data_dir = data_folder()

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local bufname = vim.api.nvim_buf_get_name(buf)
		if bufname:match("^" .. vim.pesc(data_dir)) then
			vim.api.nvim_win_set_width(win, target_width)
			vim.api.nvim_set_current_win(win)
			vim.cmd("edit " .. vim.fn.fnameescape(path))
			return
		end
	end

	vim.cmd("botright vsplit")
	vim.api.nvim_win_set_width(vim.api.nvim_get_current_win(), target_width)
	vim.cmd("edit " .. vim.fn.fnameescape(path))

	local buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].readonly = true
	vim.bo[buf].modifiable = false
	vim.bo[buf].buflisted = false
	vim.bo[buf].bufhidden = "wipe"
	vim.diagnostic.enable(false, { bufnr = buf })
end

---@param query string
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

---@param opts? { restrict_sources: string[] }
local function get_data_dirs(opts)
	local data_dir = data_folder()
	if not (opts and opts.restrict_sources) then
		return { data_dir }
	end
	local dirs = {}
	for _, source in ipairs(opts.restrict_sources) do
		local dir = data_dir .. source .. "/"
		if vim.fn.isdirectory(dir) == 1 then
			table.insert(dirs, dir)
		end
	end
	return dirs
end

local function update_data()
	vim.system({ "lexy", "update" }, { text = true }, function(obj)
		vim.schedule(function()
			if obj.code == 0 then
				vim.notify("Lexy updated successfully", vim.log.levels.INFO)
			else
				vim.notify("Lexy update failed: " .. (obj.stderr or ""), vim.log.levels.ERROR)
			end
		end)
	end)
end

return {
	data_folder = data_folder,
	file_info = file_info,
	get_data_dirs = get_data_dirs,
	open_file_buffer = open_file_buffer,
	find_docs = find_docs,
	update_data = update_data,
}
