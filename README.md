<a id="lexy-nvim"></a>

# lexy.nvim

> [!caution]
> **Status:** Under development

## ℹ️ About

**lexy.nvim** is a Neovim plugin for working with local [Lexy](https://github.com/antoniorodr/lexy) documentation inside the editor. It is intended to connect Lexy's cached Learn X in Y Minutes files with familiar Neovim workflows and picker UIs.

The project is currently focused on the integration layer: setup, commands, keymaps, and picker backends for Neovim.

Project documentation currently lives in this README.

## 🎬 Demo

## ✨ Features

- Integrates local Lexy documentation into Neovim
- Registers a `:LexySearch {query}` user command
- Provides a configurable keymap hook for Lexy actions
- Reads documentation from Lexy's local cache in `~/.config/lexy/files/`
- Includes starter backend modules for `snacks.nvim` and `telescope.nvim`
- Keeps the plugin setup lightweight and Lua-native

## 📋 Requirements

Before starting, make sure the required tools and dependencies are installed on your machine:

```bash
nvim --version
lexy --help
```

`lexy.nvim` requires Neovim 0.11 or newer and a working [Lexy](https://github.com/antoniorodr/lexy) installation. Since the plugin reads Lexy's local cache, you should run Lexy at least once so the files under `~/.config/lexy/files/` exist.

To use a picker UI, install either [snacks.nvim](https://github.com/folke/snacks.nvim) or [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).

## 📦 Installation

### `vim.pack`

```lua
vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/antoniorodr/lexy.nvim" },
  })
end)
```

### `lazy.nvim`

```lua
{
  "antoniorodr/lexy.nvim",
  dependencies = {
    "folke/snacks.nvim", -- or "nvim-telescope/telescope.nvim"
  },
  config = function()
    require("lexy").setup()
  end,
}
```

## 🚀 Getting Started

Once installed, configure the plugin and use one of the exposed entry points:

```lua
require("lexy").setup({
  keymap = "<leader>sl",
})
```

Then use `:LexySearch python` or the configured keymap as your entry point into the plugin. The picker flow is still under active development.

If you are using `snacks.nvim`, it is a good idea to run `:checkhealth snacks` to verify that the picker integration is set up correctly.

## ❤️ Do you like my work?

If you find the project useful, you can support the author here:

[![GitHub Sponsor](https://img.shields.io/badge/Sponsor_on_GitHub-30363D?logo=github&style=for-the-badge)](https://github.com/sponsors/antoniorodr)

[Back to top](#lexy-nvim)
