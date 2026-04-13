local M = {}
local lexy_local_docs = os.getenv("HOME") .. "/.config/lexy/files"

M.search = function(query)
	-- This function will search for the query in the lexy_local_docs directory and return the file
	if not query or query == "" then
		vim.notify("Please provide a search query.")
		return
	end

	for file in vim.fs.dir(lexy_local_docs) do
		if file:match(query) then
			return vim.fs.joinpath(lexy_local_docs, file)
		end
	end
end

M.list = function()
	--This function will do the same as `Lexy list`command, but it will be opened with the neovim picker (snacks/telescope)
end

M.setup = function(opts)
	opts = opts or {}
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
