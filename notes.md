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

