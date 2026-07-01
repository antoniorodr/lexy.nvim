local common = require("lexy.common")
local MiniPick = require("mini.pick")

local function get_icon(path)
	if _G.MiniIcons then
		return MiniIcons.get("file", path)
	end

	if pcall(require, "nvim-web-devicons") then
		local devicons = require("nvim-web-devicons")
		local basename = vim.fs.basename(path)
		local icon, hl = devicons.get_icon(basename)
		return icon or " ", hl or "MiniPickIconFile"
	end

	return " ", "MiniPickIconFile"
end

local function show_with_icons(buf_id, items_to_show, query)
	MiniPick.default_show(buf_id, items_to_show, query)

	local lines = vim.api.nvim_buf_get_lines(buf_id, 0, -1, false)
	for i, item in ipairs(items_to_show) do
		local path = type(item) == "string" and item or item.path or item.text
		local icon, icon_hl = get_icon(path)

		lines[i] = lines[i] .. "  " .. icon
	end

	vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)

	for i, item in ipairs(items_to_show) do
		local path = type(item) == "string" and item or item.path or item.text
		local icon, icon_hl = get_icon(path)
		local line = lines[i]
		local icon_pos = line:find(icon, 1, true)

		if icon_pos then
			vim.api.nvim_buf_add_highlight(buf_id, -1, icon_hl, i - 1, icon_pos - 1, icon_pos - 1 + #icon)
		end
	end
end

---@param opts? { restrict_sources: string[] }
local function lexy_list(opts)
	local files = {}

	for _, dir in ipairs(common.get_data_dirs(opts)) do
		for name in vim.fs.dir(dir) do
			local path = dir .. name
			if vim.fn.isdirectory(path) == 0 then
				table.insert(files, path)
			end
		end
	end

	MiniPick.start({
		source = {
			items = files,
			name = "Lexy docs",
			choose = function(item)
				common.open_file_buffer(item)
			end,
			preview = function(buf_id, item)
				local lines = vim.fn.readfile(item)
				vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
				vim.bo[buf_id].filetype = vim.filetype.match({ filename = item }) or "text"
			end,
			show = show_with_icons,
		},
	})
end

return {
	lexy_list = lexy_list,
}
