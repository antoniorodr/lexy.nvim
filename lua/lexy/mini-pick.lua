local common = require("lexy.common")
local MiniPick = require("mini.pick")

---@param opts? { restrict_sources: string[] }
local function lexy_list(opts)
	local files = {}

	for _, dir in ipairs(common.get_data_dirs(opts)) do
		for name in vim.fs.dir(dir) do
			local path = dir .. name
			if vim.fn.isdirectory(path) == 0 then
				table.insert(files, { path = path, text = name })
			end
		end
	end

	MiniPick.start({
		source = {
			items = files,
			name = "Lexy docs",
			show = function(buf_id, items, query)
				MiniPick.default_show(buf_id, items, query, { show_icons = true })
			end,
			choose = function(item)
				MiniPick.stop()
				common.open_file_buffer(item.path)
			end,
			preview = function(buf_id, item)
				local lines = vim.fn.readfile(item.path)
				vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
				vim.bo[buf_id].filetype = vim.filetype.match({ filename = item.path }) or "text"
			end,
		},
	})
end

return {
	lexy_list = lexy_list,
}
