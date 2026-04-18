# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Create changelog using git-cliff by @antoniorodr

## [0.2.2] - 2026-04-18

### Added
- Add testing explanation by @antoniorodr

### Changed
- Update testing explanation by @antoniorodr
- Update gitignore by @antoniorodr
- Update contributing file to adapt it to the project by @antoniorodr

### Fixed
- Rename minit to busted by @antoniorodr
- Create a tests.sh script to run the tests by @antoniorodr
- Update the workflow to use the script and cache by @antoniorodr
- Fix home path for tests by @antoniorodr

### Removed
- Delete changelog template file by @antoniorodr

## [0.2.1] - 2026-04-17

### Added
- Add test for the common.lua file by @antoniorodr

### Changed
- Merge branch 'fix/lexy-path-windows' by @antoniorodr
- Merge branch 'test/common' by @antoniorodr

### Fixed
- Fix data_folder path to math on windows too by @antoniorodr
- Wrap vim.notify with vim.schedule to avoid errors by @antoniorodr

## [0.2.0] - 2026-04-16

### Changed
- Create the user command LexyUpdate by @antoniorodr

## [0.1.0] - 2026-04-16

### Added
- Add demo gif to the readme by @antoniorodr
- Add type anotations by @antoniorodr
- Add relative line numbers by @antoniorodr
- Add vim.log.levels to every vim.notify by @antoniorodr
- Add autocompletion for arguments by @antoniorodr
- Add stale workflow by @antoniorodr
- Add tests, merge-to-main and run-test-on-pr workflows by @antoniorodr
- Add no-autopilot workflow by @antoniorodr
- Add PR template by @antoniorodr
- Add funding.yml by @antoniorodr
- Add boilerplate code by @antoniorodr

### Changed
- Change print statements with vim.notify by @antoniorodr
- Update readme with the new feature LexyUpdate by @antoniorodr
- Create keymap to run "lexy update" from neovim by @antoniorodr
- Update readme with configuration and installation settings by @antoniorodr
- Write some type annotations by @antoniorodr
- Refactor to move common functions to common.lua by @antoniorodr
- Create a picker for LexyList by @antoniorodr
- Create integration with telescope by @antoniorodr
- Change the way keymaps are set by @antoniorodr
- Open_file_buffer function opens the documentation in split view by @antoniorodr
- Update readme with the actual plugin info by @antoniorodr
- Change the preset for the preview by @antoniorodr
- Show warning color with LexySearch by @antoniorodr
- Change keymap for LexyList by @antoniorodr
- Create boilerplate for search docs by @antoniorodr
- Make files readonly when open in buffer by @antoniorodr
- Change preview size by @antoniorodr
- Refactor format_entries function by @antoniorodr
- Test print when enter neovim by @antoniorodr
- Create local folder variable, before return it by @antoniorodr
- Create functions and files to integrate snacks picker by @antoniorodr
- Update readme with information om project status by @antoniorodr
- Uncomment LexyList command creation line by @antoniorodr
- Write boilerplate code for snacks integration by @antoniorodr
- Change filename_to_display to return filename and extension by @antoniorodr
- Delete back to top from readme by @antoniorodr
- Update readme title by @antoniorodr
- Update readme by @antoniorodr
- Update features on readme by @antoniorodr
- Update readme header by @antoniorodr
- Update license and readme by @antoniorodr
- Update readme by @antoniorodr
- Move common code from lexy to common lua file by @antoniorodr
- Create snacks and telescope lua files by @antoniorodr
- Initial commit by @antoniorodr

### Fixed
- Fix a bug where telescope was not able to find files by @antoniorodr
- Fix error when using LexyList with telescope by @antoniorodr
- Fix icons on preview by @antoniorodr
- Fix bug with the filepath by @antoniorodr
- Fix find_docs function, searching for the whole path by @antoniorodr
- Fix exporting av open_file_buffer function by @antoniorodr
- Fix bug where snacks did not find the files by @antoniorodr
- Fix file name and extension on preview by @antoniorodr
- Fix preview sizing error by @antoniorodr
- Change how Config table is created by @antoniorodr
- Fix snacks picker not appearing by @antoniorodr

### Removed
- Delete some type annotations by @antoniorodr
- Delete unused function collect_files by @antoniorodr
- Delete unused code by @antoniorodr
- Delete test prints by @antoniorodr
- Delete folder option for new items by @antoniorodr

### New Contributors
* @antoniorodr made their first contribution

[unreleased]: https://github.com/antoniorodr/lexy.nvim/compare/v0.2.2...HEAD
[0.2.2]: https://github.com/antoniorodr/lexy.nvim/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/antoniorodr/lexy.nvim/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/antoniorodr/lexy.nvim/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/antoniorodr/lexy.nvim/compare/v0.0.0...v0.1.0

<!-- generated by git-cliff -->
