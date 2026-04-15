local common = require("lexy.common")
local Snacks = require("snacks")

local common_layout_options = {
	preview = true,
	preset = "telescope",
}
local common_win_options = {
	preview = {
		wo = {
			number = true,
			relativenumber = false,
			signcolumn = "no",
			conceallevel = 2,
			concealcursor = "n",
			winfixbuf = true,
			list = false,
			wrap = false,
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
	local filename = common.file_info(item)[1]
	local filetype = common.file_info(item)[2] or "txt"
	local icon, hl = Snacks.util.icon(filetype, "filetype", {
		fallback = picker.opts.icons.files,
	})
	icon = Snacks.picker.util.align(icon, picker.opts.formatters.file.icon_width or 2)
	local new_item = {
		{
			icon,
			hl,
			virtual = true,
		},
		{
			"SnacksPickerSpecial",
			field = "file",
		},
	}
	new_item[#new_item + 1] = {
		common.filename_to_display(filename),
		"SnacksPickerFile",
		field = "file",
	}
	return new_item
end

local function lexy_list(opts)
	Snacks.picker.files({
		layout = common_layout_options,
		win = common_win_options,
		dirs = get_data_dirs(opts),
		confirm = function(picker, item)
			require("apidocs").open_doc_in_new_window(item.file)
		end,
		format = format_entries,
	})
end

return {
	lexy_list = lexy_list,
}
