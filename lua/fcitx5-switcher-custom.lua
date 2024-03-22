local M = {}

function M.setup(opt)
	opt = opt or {}
	if opt.enable_manual and opt.mod == "i" then
		vim.keymap.set("n", opt.key, ":lua Fcitx5_manual_switch_i()<CR>", {noremap = true});
	elseif opt.enable_manual and opt.mod == "a" then
		vim.keymap.set("n", opt.key, ":lua Fcitx5_manual_switch_a()<CR>", {noremap = true});
	end
end

return M
