local common = require("lexy.common")

local function get_data_dirs(opts)
	local data_dir = common.data_folder()
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

local function collect_files(opts)
	local files = {}

	for _, dir in ipairs(get_data_dirs(opts)) do
		for name in vim.fs.dir(dir) do
			local path = dir .. name
			if vim.fn.isdirectory(path) == 0 then
				table.insert(files, path)
			end
		end
	end

	return files
end

local function lexy_list(opts)
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local previewers = require("telescope.previewers")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers
		.new({}, {
			prompt_title = "Lexy docs",
			finder = finders.new_table({
				results = collect_files(opts),
				entry_maker = function(path)
					local basename = vim.fs.basename(path)
					return {
						value = path,
						display = basename,
						ordinal = basename,
						filename = path,
					}
				end,
			}),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry)
					vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.fn.readfile(entry.value))
					vim.bo[self.state.bufnr].filetype = vim.filetype.match({
						filename = entry.value,
					}) or "text"
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				local function open_selection()
					local entry = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					common.open_file_buffer(entry.value)
				end

				map("i", "<CR>", open_selection)
				map("n", "<CR>", open_selection)
				return true
			end,
		})
		:find()
end

return {
	lexy_list = lexy_list,
}
