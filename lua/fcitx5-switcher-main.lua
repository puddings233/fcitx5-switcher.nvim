function Fcitx5_manual_switch_i()
	vim.api.nvim_input("i")
	vim.system({"fcitx5-remote", "-o"}, {on_exit})
end

function Fcitx5_manual_switch_a()
	vim.api.nvim_input("a")
	vim.system({"fcitx5-remote", "-o"}, {on_exit})
end

local function fcitx5_switch_to_en()
	vim.system({"fcitx5-remote", "-c"}, {on_exit})
end

local function fcitx5_switch_to_ch()
	vim.system({"fcitx5-remote", "-o"}, {on_exit})
end

local function is_uincode_4e00_to_9fff()
	local current_row, current_col = unpack(vim.api.nvim_win_get_cursor(0))
	if current_col < 3 then
		return false
	end
	local char = vim.api.nvim_buf_get_text(0, current_row - 1, current_col - 3, current_row - 1, current_col, {})[1]
	if not char or #char ~= 3 then
		return false
	end
	local char_byte_1, char_byte_2, char_byte_3 = string.byte(char, 1, 3)
	if ( char_byte_1 >= 228 and char_byte_1 <= 233 and
		char_byte_2 >= 128 and char_byte_2 <=191 and
		char_byte_3 >= 128 and char_byte_3 <=191 ) then
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
