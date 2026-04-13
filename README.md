<h1 align="center">`Lexy.nvim`</h1>

<p align="center">
  <img alt="Github top language" src="https://img.shields.io/github/languages/top/antoniorodr/Lexy.nvim?color=56BEB8">

  <img alt="Github language count" src="https://img.shields.io/github/languages/count/antoniorodr/Lexy.nvim?color=56BEB8">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/antoniorodr/Lexy.nvim?color=56BEB8">

  <img alt="License" src="https://img.shields.io/github/license/antoniorodr/Lexy.nvim?color=56BEB8">

  <img alt="Github issues" src="https://img.shields.io/github/issues/antoniorodr/Lexy.nvim?color=56BEB8" />

  <img alt="Github forks" src="https://img.shields.io/github/forks/antoniorodr/Lexy.nvim?color=56BEB8" /> 

  <img alt="Github stars" src="https://img.shields.io/github/stars/antoniorodr/Lexy.nvim?color=56BEB8" /> 
</p>

<p align="center">
  <a href="#dart-about">About</a> &#xa0; | &#xa0; 
  <a href="#sparkles-features">Features</a> &#xa0; | &#xa0;
  <a href="#rocket-technologies">Technologies</a> &#xa0; | &#xa0;
  <a href="#white_check_mark-requirements">Requirements</a> &#xa0; | &#xa0;
  <a href="#checkered_flag-starting">Starting</a> &#xa0; | &#xa0;
  <a href="#memo-license">License</a> &#xa0; | &#xa0;
  <a href="https://github.com/antoniorodr" target="_blank">Author</a>
</p>

<br>


## :dart: About

[Lexy](https://github.com/antoniorodr/lexy) is a lightweight CLI tool that fetches programming tutorials from "Learn X in Y Minutes" directly into your terminal. `lexy.nvim` is a Neovim plugin to use Lexy in your Neovim editor.

## :sparkles: Features

:heavy_check_mark: Search for documentation using a Neovim picker like [snacks.nvim](https://github.com/folke/snacks.nvim) or [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim);\\
:heavy_check_mark: Open documentation in a buffer from the cmd;

## :white_check_mark: Requirements

Before using `lexy.nvim`, you need to have [Lexy](https://github.com/antoniorodr/lexy) installed. You can follow the instructions in the [Lexy repository](https://github.com/antoniorodr/lexy).

You will also need [Neovim](https://neovim.io/) version 0.11 or higher.

## :checkered_flag: Installation

### `vim.pack`

```lua  
vim.schedule(function()
    vim.pack.add('antoniorodr/lexy.nvim')
end)
```

### `lazy.nvim`

```lua
return {
  'antoniorodr/lexy.nvim',
  dependencies = {
    'folke/snacks.nvim', -- Or 'nvim-telescope/telescope.nvim' 
  },
}
```

> [!tip]
> It's a good idea to run `:checkhealth snacks` to see if everything is set up correctly.

## :memo: License

This project is under license from Apache 2.0. For more details, see the [LICENSE](LICENSE.md) file.

## :eyes: Do you like my work?

If you like my work and want to support me, you can buy me a coffee ☕ or even a burrito 🌯 by sponsoring me.

[![GitHub Sponsor](https://img.shields.io/badge/Sponsor_on_GitHub-30363D?logo=github&style=for-the-badge)](https://github.com/sponsors/antoniorodr)

&#xa0;

<a href="#top">Back to top</a>
