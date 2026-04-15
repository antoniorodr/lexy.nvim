local common = require("lexy.common")

local M = {}

Config = {}

local function set_picker(opts)
	if opts and (opts.picker == "snacks" or opts.picker == "telescope" or opts.picker == "ui_select") then
		return opts
	end
	if not opts then
		opts = {}
	end
	if package.loaded["snacks"] then
		opts.picker = "snacks"
		return opts
	end
	if package.loaded["telescope"] then
		opts.picker = "telescope"
		return opts
	end
	opts.picker = "ui_select"
	return opts
end

M.search = function(query)
	-- This function will search for the query in the lexy_local_docs directory and return the file
	if not query or query == "" then
		vim.notify("Please provide a search query.")
		return
	end

	--TODO: Search for the query and present items in a picker (snacks/telescope)
end

M.list = function(opts)
	--This function will do the same as `Lexy list`command, but it will be opened with the neovim picker (snacks/telescope)
	--TODO: List all the items in the lexy_local_docs directory and present them in a picker (snacks/telescope)
	local picker = Config.picker
	if opts and opts.picker then
		picker = opts.picker
	end

	if picker == "snacks" then
		require("lexy.snacks").lexy_list(opts)
		return
	end
end

M.setup = function(opts)
	opts = opts or {}
	set_picker(opts)
	vim.api.nvim_create_user_command("LexyList", function()
		M.list(opts)
	end, {})
	vim.api.nvim_create_user_command("LexySearch", function(opts)
		M.search(opts.args)
	end, {
		desc = "Search for a file in lexy",
		nargs = 1,
	})

	local keymap = opts.keymap or "<leader>sl"

	vim.keymap.set("n", keymap, M.list, {
		desc = "List items from lexy",
		silent = true, -- Prevents the command from being echoed in the command line
	})
end

return M
