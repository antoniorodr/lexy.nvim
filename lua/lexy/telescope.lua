local common = require("lexy.common")

--TODO: Implement telescope picker

local function telescope_attach_mappings(prompt_bufnr, map)
	local actions = require("telescope.actions")
	map("i", "<cr>", function(nr)
		actions.close(prompt_bufnr)
		local entry = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
		common.open_doc_in_new_window(entry.filename or entry.value)
		if entry.lnum then
			vim.cmd(":" .. entry.lnum)
			vim.cmd("norm! zz")
		end
	end, { buffer = true })
	return true
end

local function apidocs_open(params, slugs_to_mtimes, candidates)
	local docs_path = common.data_folder()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local previewers = require("telescope.previewers")
	local conf = require("telescope.config").values

	local function entry_maker(entry)
		return {
			value = docs_path .. entry.path,
			ordinal = entry.display,
			display = entry.display,
			contents = entry.display,
		}
	end

	pickers
		.new({}, {
			prompt_title = "Lexy docs",
			finder = finders.new_table({
				results = candidates,
				entry_maker = entry_maker,
			}),
			previewer = previewers.new_buffer_previewer({
				-- messy because of the conceal
				setup = function(self)
					vim.schedule(function()
						local winid = self.state.winid
						vim.wo[winid].conceallevel = 2
						vim.wo[winid].concealcursor = "n"
						local augroup = vim.api.nvim_create_augroup("TelescopeApiDocsResumeConceal", { clear = true })
						vim.api.nvim_create_autocmd({ "User" }, {
							group = augroup,
							pattern = "TelescopeResumePost",
							callback = function()
								local action_state = require("telescope.actions.state")
								local current_picker = action_state.get_current_picker(vim.api.nvim_get_current_buf())
								if
									current_picker.prompt_title == "API docs"
									or current_picker.prompt_title == "API docs search"
								then
									local winid = current_picker.all_previewers[1].state.winid
									vim.wo[winid].conceallevel = 2
									vim.wo[winid].concealcursor = "n"
								end
							end,
						})
					end)
					return {}
				end,
				define_preview = function(self, entry)
					common.load_doc_in_buffer(self.state.bufnr, entry.value)
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = telescope_attach_mappings,
		})
		:find()
end

return {
	apidocs_open = apidocs_open,
}
