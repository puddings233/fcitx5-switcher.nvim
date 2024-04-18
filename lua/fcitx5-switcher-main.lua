function Fcitx5_manual_switch_i()
	vim.api.nvim_input("i")
	os.execute("fcitx5-remote -o")
end

function Fcitx5_manual_switch_a()
	vim.api.nvim_input("a")
	os.execute("fcitx5-remote -o")
end

local function fcitx5_switch_to_en()
	os.execute("fcitx5-remote -c")
end

local function fcitx5_switch_to_ch()
	os.execute("fcitx5-remote -o")
end

local function is_uincode_4e00_to_9fff()
	local _, current_col = unpack(vim.api.nvim_win_get_cursor(0))
	local char = string.sub(vim.api.nvim_get_current_line(), current_col - 2 , current_col)
	if #char ~= 3 then
		return false
	elseif string.byte(char, 1) >= 228 and
		string.byte(char, 1) <= 233 and
		string.byte(char, 2) >= 128 and
		string.byte(char, 2) <= 191 and
		string.byte(char, 3) >= 128 and
		string.byte(char, 3) <= 191 then
		return true
	else
		return false
 end
end

local function auto_change()
	if is_uincode_4e00_to_9fff() then
		fcitx5_switch_to_ch()
	end
end

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = {"*"},
	callback = function ()
		fcitx5_switch_to_en()
	end
})

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = {"*"},
	callback = function ()
		auto_change()
	end
})
