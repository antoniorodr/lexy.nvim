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

local function format_entries(item, picker)
	local filename = common.filename_to_display(item)[1]
	local filetype = common.filename_to_display(item)[2] or ""
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
			folder .. " | ",
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
