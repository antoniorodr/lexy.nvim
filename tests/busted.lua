#!/usr/bin/env -S nvim -l

local uv = vim.uv or vim.loop
local cwd = uv.cwd()
local stdpath = vim.fs.normalize(cwd .. "/.tests")
local rocks = vim.fs.normalize(stdpath .. "/rocks")

for _, name in ipairs({ "config", "data", "state", "cache" }) do
	vim.env[("XDG_%s_HOME"):format(name:upper())] = stdpath .. "/" .. name
end

package.path = table.concat({
	rocks .. "/share/lua/5.1/?.lua",
	rocks .. "/share/lua/5.1/?/init.lua",
	package.path,
}, ";")

package.cpath = table.concat({
	rocks .. "/lib/lua/5.1/?.so",
	rocks .. "/lib/lua/5.1/?/?.so",
	package.cpath,
}, ";")

local args = vim.deepcopy(_G.arg or {})
if #args == 0 then
	args = { "tests" }
end

table.insert(args, 1, "--verbose")
table.insert(args, 1, "--lpath=" .. table.concat({
	cwd .. "/lua/?.lua",
	cwd .. "/lua/?/init.lua",
	cwd .. "/lua/?/?.lua",
}, ";"))
table.insert(args, 1, "--directory=" .. cwd)

_G.arg = args

local ok, err = pcall(require("busted.runner"), {
	standalone = false,
})

if not ok then
	vim.api.nvim_echo({ { err, "ErrorMsg" } }, true, {})
	os.exit(1)
end
