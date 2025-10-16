local M = {}

local fcitx5_available = nil

local function check_fcitx5_available()
	if fcitx5_available == nil then
		fcitx5_available = os.execute("fcitx5-remote >/dev/null 2>&1") == 0
	end
	return fcitx5_available
end

local function safe_fcitx5_operation(command)
	if not check_fcitx5_available() then return end
	local handle = io.popen(command .. " 2>/dev/null", "r")
	if handle then
		handle:close()
	end
end

local function fcitx5_switch_to_en()
	safe_fcitx5_operation("fcitx5-remote -c")
end

local function fcitx5_switch_to_ch()
	safe_fcitx5_operation("fcitx5-remote -o")
end

local function is_chinese_character()
	local line = vim.api.nvim_get_current_line()
	local current_col = vim.api.nvim_win_get_cursor(0)[2] + 1

	if current_col <= 1 then return false end

	local prev_char = line:sub(current_col - 1, current_col - 1)
	if #prev_char == 0 then return false end

	local codepoint = prev_char:byte()
	return codepoint >= 0x4E00 and codepoint <= 0x9FFF
end

function M.create_manual_switch(mode_key)
	return function()
		vim.api.nvim_input(mode_key)
		fcitx5_switch_to_ch()
	end
end

local function auto_change()
	if is_chinese_character() then
		fcitx5_switch_to_ch()
	end
end

function M.setup()
	vim.api.nvim_create_autocmd("InsertLeave", {
		pattern = "*",
		callback = function()
			vim.schedule_wrap(fcitx5_switch_to_en)()
		end
	})

	vim.api.nvim_create_autocmd("InsertEnter", {
		pattern = "*",
		callback = function()
			vim.schedule_wrap(auto_change)()
		end
	})
end

M.Fcitx5_manual_switch_i = M.create_manual_switch("i")
M.Fcitx5_manual_switch_a = M.create_manual_switch("a")

return M
