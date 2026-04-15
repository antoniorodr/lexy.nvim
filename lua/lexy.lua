local common = require("lexy.common")

local M = {}

local Config = {
	picker = nil,
	keymap = "<leader>sl",
}

local function resolve_picker(opts)
	if opts and opts.picker then
		return opts.picker
	end

	local has_snacks = pcall(require, "snacks")
	if has_snacks then
		return "snacks"
	end

	local has_telescope = pcall(require, "telescope")
	if has_telescope then
		return "telescope"
	end

	return "ui_select"
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
	local picker = (opts and opts.picker) or Config.picker

	if picker == "snacks" then
		require("lexy.snacks").lexy_list(opts)
	end

	-- if picker == "telescope" then
	-- 	require("lexy.telescope").lexy_list(opts)
	-- end

	vim.notify("No picker found, using ui_select")
end

M.setup = function(opts)
	opts = opts or {}

	Config.picker = resolve_picker(opts)
	Config.keymap = opts.keymap or "<leader>sl"
	Config.restrict_sources = opts.restrict_sources

	vim.api.nvim_create_user_command("LexyList", function()
		M.list(Config)
	end, {})

	vim.keymap.set("n", Config.keymap, function()
		M.list(Config)
	end, {
		desc = "List items",
		silent = true,
	})

	vim.api.nvim_create_user_command("LexySearch", function(opts)
		M.search(opts.args)
	end, {
		desc = "Search for a file in lexy",
		nargs = 1,
	})
end

return M
