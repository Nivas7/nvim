# Neovim Notes

## Keybinds

| Action        | Mode  | Keybind     | Description        |
|---------------|-------|-------------|--------------------|
| Native Format | n     | `mggggqG'q` | Format && Returns to Same Place|

---

## Marks

- Set mark: `m{a-z}`
- Jump to mark: `'a` (line) / `` `a `` (cursor)
- Delete: `:delmarks a`

>[!NOTE]
> Marks like `` ` `` and `'` are not literal characters in your text.
> They represent positions saved by Neovim (e.g., last jump location).
> - ` `` ` jumps to the exact cursor position of your last change.
> - `''` jumps to the start of the line of that change.

## Netrw

> It is native File Explored bundeled with neovim


###  Sidebar-Like File Explorer

```vim
:Lex
```

* Opens netrw in a vertical split.
* Behaves like a project drawer.
* Remembers window (use `P` to jump back to the file window).

---

###  Fix Split/Window Opening Bugs

```vim
:let g:netrw_chgwin = -1
```

* Resets target window to avoid files opening in the wrong split.

---

###  Smarter Navigation in Netrw

| Key  | Action                         |
| ---- | ------------------------------ |
| `u`  | Go back in directory history   |
| `-^` | Go to grandparent directory    |
| `gh` | Toggle hidden files (dotfiles) |
| `P`  | Focus back to previous window  |

---

###  Bulk File Actions via Target

```vim
mt    " Mark target directory
mf    " Mark files
mc    " Copy marked → target
mm    " Move marked → target
```

---

###  Hide Dotfiles by Default

```lua
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]
```

---

###  Quick Bookmark Navigation

```vim
mb    " Mark bookmark
gb    " Go to bookmark
```

Useful for project roots, quick jumps.

---

### Sync CWD With Browsing

```lua
vim.g.netrw_keepdir = 0
```

* Keeps your `cwd` in sync with netrw navigation.
* Important for tools that rely on correct working directory.

---

### Clean UI Tweaks

```lua
vim.g.netrw_banner = 0         -- Hide top banner
vim.g.netrw_liststyle = 3      -- Tree-style listing
```

