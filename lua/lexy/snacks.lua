local common = require("lexy.common")
local Snacks = require("snacks")

local common_layout_options = {
	preview = true,
}

local common_win_options = {
	preview = {
		wo = {
			number = true,
			relativenumber = true,
			signcolumn = "no",
			conceallevel = 2,
			concealcursor = "n",
			winfixbuf = true,
			list = false,
			wrap = true,
		},
	},
}

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

local function format_entries(item, picker)
	local path = item.file or item.text or item
	local basename = vim.fs.basename(path)
	local filename, extension = common.file_info(basename)
	local filetype = extension or "txt"

	local icon, hl = Snacks.util.icon(basename, "file", {
		fallback = picker.opts.icons.files,
	})

	icon = Snacks.picker.util.align(icon, picker.opts.formatters.file.icon_width or 2)

	return {
		{ icon, hl, virtual = true },
		{
			filename .. "." .. filetype,
			"SnacksPickerFile",
			field = "file",
		},
	}
end

local function lexy_list(opts)
	Snacks.picker.files({
		layout = common_layout_options,
		win = common_win_options,
		dirs = get_data_dirs(opts),
		confirm = function(picker, item)
			picker:close()
			common.open_file_buffer(item.file)
		end,
		format = format_entries,
	})
end

return {
	lexy_list = lexy_list,
}
