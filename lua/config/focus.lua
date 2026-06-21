-- Canonical nvim <-> tmux focus integration: let tmux own pane appearance.
--
-- nvim normally paints an opaque background over every cell, which hides
-- tmux's per-pane styling. Making the background transparent lets tmux's
-- window-active-style / window-style (including the `dim` attribute on the
-- inactive pane) show through, so an nvim pane is styled and dimmed exactly
-- like any other pane when its tmux pane gains/loses focus.
--
-- tmux is the source of truth (~/.tmux/.tmux.conf): `set -g focus-events on`
-- plus the window-style / window-active-style settings.
-- Ref: https://tech.serhatteker.com/post/2019-07/tmux-vim-focus/
--
-- Re-applied on ColorScheme since loading a colorscheme repaints these groups.

local function make_transparent()
    -- `hi <group> guibg=NONE` clears only the background, preserving foregrounds.
    for _, group in ipairs({ "Normal", "NormalNC", "SignColumn", "EndOfBuffer", "NonText" }) do
        vim.cmd(("highlight %s guibg=NONE ctermbg=NONE"):format(group))
    end
end

make_transparent()

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("TmuxTransparentBg", { clear = true }),
    callback = make_transparent,
})
