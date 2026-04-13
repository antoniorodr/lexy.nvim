local M = {}

M.search = function(query)
	-- This function will search for the query in the lexy_local_docs directory and return the file
	if not query or query == "" then
		vim.notify("Please provide a search query.")
		return
	end

	--TODO: Search for the query and present items in a picker (snacks/telescope)
end

M.list = function()
	--This function will do the same as `Lexy list`command, but it will be opened with the neovim picker (snacks/telescope)
	--TODO: List all the items in the lexy_local_docs directory and present them in a picker (snacks/telescope)
end

M.setup = function(opts)
	opts = opts or {}
	-- vim.api.nvim_create_user_command("LexyList", M.list, {})
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
