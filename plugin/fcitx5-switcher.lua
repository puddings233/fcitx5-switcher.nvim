local function check_fcitx5_available()
	if os.execute("fcitx5-remote --check > /dev/null") == 0 then
		return true
	else
		return false
	end
end

if check_fcitx5_available() then
	require("fcitx5-switcher-main")
end
