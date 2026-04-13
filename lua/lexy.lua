local M = {}

M.list = function()
	vim.system("lexy list")
end

M.setup = function(opts)
	opts = opts or {}
	vim.api.nvim_create_user_command("LexyList", M.list, {})

	local keymap = opts.keymap or "<leader>sl"

	vim.keymap.set("n", keymap, M.list, {
		desc = "List items from lexy",
		silent = true, -- Prevents the command from being echoed in the command line
	})
end

return M
