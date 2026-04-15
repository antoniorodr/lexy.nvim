local M = {}

local Config = {
	picker = nil,
	keymap = "<leader>sll",
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
	if not query or query == "" then
		vim.notify("Please provide a search query.", vim.log.levels.WARN)
		return
	end

	require("lexy.common").find_docs(query)
end

M.list = function(opts)
	local picker = (opts and opts.picker) or Config.picker

	if picker == "snacks" then
		require("lexy.snacks").lexy_list(opts)
		return
	end

	-- if picker == "telescope" then
	-- 	require("lexy.telescope").lexy_list(opts)
	-- 	return
	-- end

	vim.notify("No picker found, using ui_select", vim.log.levels.INFO)
end

M.setup = function(opts)
	opts = opts or {}

	Config.picker = resolve_picker(opts)
	Config.keymap = opts.keymap or "<leader>sll"
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

	vim.api.nvim_create_user_command("LexySearch", function(query)
		M.search(query.args)
	end, {
		desc = "Search for a file in lexy",
		nargs = 1,
		complete = function(arg_lead)
			local common = require("lexy.common")
			local matches = {}

			for file in vim.fs.dir(common.data_folder()) do
				local name, _ = common.file_info(file)

				if name:find(arg_lead, 1, true) == 1 then
					table.insert(matches, name)
				end
			end

			return matches
		end,
	})
end

return M
