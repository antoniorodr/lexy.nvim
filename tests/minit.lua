#!/usr/bin/env -S nvim -l

vim.env.LAZY_STDPATH = ".tests"

local lazypath = vim.fn.fnamemodify(vim.env.LAZY_STDPATH .. "/lazy/lazy.nvim", ":p")
if vim.fn.isdirectory(lazypath) == 0 then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		error("Failed to bootstrap lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

require("lazy.minit").setup({
	spec = {
		{ dir = vim.uv.cwd() },
	},
})
