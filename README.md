# Neovim Configuration

#### Build off of mine, or start your own!

<br>

> Before starting, ensure you have:
>
> - **neovim**
> - a [patched font](https://www.nerdfonts.com/) and a terminal that supports glyphs

<br>

### Quickstart with my config:

```
cd ~/.config/ && git clone https://github.com/nivas7/nvim
```

- Key maps are in `lua/config/mappings.lua`
  - Leader is bound to space, you can press space by itself for which-key to pop up with bindings info
- Neovim options are set in `lua/config/options.lua` with some comments for info
- All plugin configuration is located in the `lua/plugins/` folder

<br>

### Starting your own config:

Yes, there are a lot of choices! But don't worry, you can easily change your mind later.

**1. Do you want:**

- Minimal?
- Power User?
- Full IDE?

An example directory structure and plugin configuration for each of those is included below.

**2. Choose directory structure**

- If you prefer vimscript, use an `init.vim`
- Otherwise, use an `init.lua`
- If you intend to have a lot of plugins or want a neater structure, split into separate files
  - You can always expand to more files later

**3. Pick plugin manager**

- [vim-plug](https://github.com/junegunn/vim-plug) is a minimal option
- [lazy.nvim](https://github.com/folke/lazy.nvim) is more feature-rich
- or [several other choices](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#plugin-manager)

**4. Pick plugins**

- [Awesome neovim plugins list](https://github.com/rockerBOO/awesome-neovim)
- See below for a rough guide on types of plugins

**5. Set mappings, options, and plugin config**

- Use `:help options` or browse [here](https://neovim.io/doc/user/options.html)
- You don't _always_ need to configure plugins: most have sensible defaults, and you can set as few or as many opts as you wish.
  <br><br>

## File Structure

```.
├── init.lua
├── lazy-lock.json
├── LICENSE
├── lua
│   ├── core
│   │   ├── autocmds.lua
│   │   ├── init.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   ├── options.lua
│   │   ├── satusline.lua
│   │   └── winbar.lua
│   └── plugins
│       ├── ccc.lua
│       ├── cmp.lua
│       ├── dap.lua
│       ├── formatting.lua
│       ├── gitsigns.lua
│       ├── lazydev.lua
│       ├── lsp
│       │   ├── lspconfig.lua
│       │   ├── lsp-signature.lua
│       │   └── mason.lua
│       ├── noice.lua
│       ├── oil.lua
│       ├── snacks.lua
│       ├── themes
│       │   ├── catppuccin.lua
│       │   ├── cold.lua
│       │   ├── rosepine.lua
│       │   └── theme.lua
│       ├── tools.lua
│       ├── transparent.lua
│       ├── treesitter.lua
│       ├── trouble.lua
│       └── which-key.lua
├── README.md
└── vim.toml
```
