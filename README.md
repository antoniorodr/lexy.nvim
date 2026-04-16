# `lexy.nvim`

> [!caution]
> **Status:** Under development.

## ℹ️ About

**lexy.nvim** is a Neovim plugin for working with local [Lexy](https://github.com/antoniorodr/lexy) documentation inside the editor. It is intended to connect Lexy's cached Learn X in Y Minutes files with familiar Neovim workflows and picker UIs.

## 🎬 Demo

![Lexy.nvim demo](./assets/lexy.nvim.gif)

## ✨ Features

- Integrates local Lexy documentation into Neovim
- Registers a `:LexySearch {query}` and a `:LexyList` user command
- Provides a configurable keymap hook for `:LexyList` command
- Reads documentation from Lexy's local cache in `~/.config/lexy/files/`
- Integration with `snacks.nvim` and `telescope.nvim`

## 📋 Requirements

`lexy.nvim` requires Neovim 0.11 or newer and a working [Lexy](https://github.com/antoniorodr/lexy) installation. Since the plugin reads Lexy's local cache, you should run Lexy at least once so the files under `~/.config/lexy/files/` exist.

To use a picker UI, install either [snacks.nvim](https://github.com/folke/snacks.nvim) or [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).

## 📦 Installation

### `vim.pack`

```lua
vim.schedule(function()
	vim.pack.add({ "https://github.com/antoniorodr/lexy.nvim" })
	require("lexy").setup()
end)
```

### `lazy.nvim`

```lua
{
  "antoniorodr/lexy.nvim",
  dependencies = {
    "folke/snacks.nvim", -- or "nvim-telescope/telescope.nvim"
  },
  opts = {} -- see Configuration section below if you want to customize the plugin
}
```

## 🚀 Getting Started

Once installed, you can either use the `:LexySearch {query}` and `:LexyList` user commands or the default keymap `<leader>sll` to start searching through your local Lexy documentation. The plugin will read from the cached files in `~/.config/lexy/files/` and present results in a picker UI if you have one of the supported picker plugins installed.

> [!tip]
> It's a good idea to run `:checkhealth snacks` to see if everything is set up correctly.

## 🛠️ Configuration

The plugin provides a `setup` function that accepts a configuration table for customize the keymaps. For example:

```lua
require("lexy").setup({
    keymaps = {
        search = "<leader>S",
    },
})
```

## ❤️ Do you like my work?

If you find the project useful, you can support the author here:

[![GitHub Sponsor](https://img.shields.io/badge/Sponsor_on_GitHub-30363D?logo=github&style=for-the-badge)](https://github.com/sponsors/antoniorodr)
