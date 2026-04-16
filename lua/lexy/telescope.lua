local common = require("lexy.common")

---@param opts? { restrict_sources: string[] }
local function collect_files(opts)
	local files = {}

	for _, dir in ipairs(common.get_data_dirs(opts)) do
		for name in vim.fs.dir(dir) do
			local path = dir .. name
			if vim.fn.isdirectory(path) == 0 then
				table.insert(files, path)
			end
		end
	end

	return files
end

---@param opts? { restrict_sources: string[] }
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
