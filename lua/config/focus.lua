-- Match nvim's focused/unfocused look to the focused/unfocused tmux pane.
-- tmux is the source of truth (~/.tmux/.tmux.conf):
--   window-active-style "fg=#D8DEE9,bg=#2E3440"  -> focused pane
--   window-style "fg=default,bg=default,dim"     -> unfocused pane
-- The `dim` attribute fades the foreground and leaves the background alone, so
-- both tmux states share the same background and differ only in foreground.
-- Requires `set -g focus-events on` in tmux.

local BG = "#2E3440" -- tmux active/inactive background
local FG_FOCUSED = "#D8DEE9" -- tmux active foreground
local FG_UNFOCUSED = "#838994" -- ~50% fade of FG_FOCUSED toward BG, approximating `dim`

local function set_normal(fg)
    vim.api.nvim_set_hl(0, "Normal", { fg = fg, bg = BG })
    vim.api.nvim_set_hl(0, "NormalNC", { fg = fg, bg = BG })
    -- Keep the always-on sign column gutter matching the buffer background.
    vim.api.nvim_set_hl(0, "SignColumn", { bg = BG })
end

local function focused() set_normal(FG_FOCUSED) end
local function unfocused() set_normal(FG_UNFOCUSED) end

focused() -- nvim starts focused

local group = vim.api.nvim_create_augroup("TmuxMatchFocus", { clear = true })
vim.api.nvim_create_autocmd("FocusGained", { group = group, callback = focused })
vim.api.nvim_create_autocmd("FocusLost", { group = group, callback = unfocused })
-- Re-assert focused colors whenever the colorscheme (re)loads.
vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = focused })
