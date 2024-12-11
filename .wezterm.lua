-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"
config.front_end = "WebGpu"

-- config.font = wezterm.font("MonaspiceKR NF", { weight = "Regular", italic = false })
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "DemiBold", italic = false })
-- config.font = wezterm.font("IosevkaTerm Nerd Font", { italic = false })
config.font_size = 16
config.font_rules = {
	{
		intensity = "Half",
		font = wezterm.font("JetBrainsMono Nerd Font", { italic = false }),
	},
}

config.window_padding = {
	left = "0cell",
	right = "0cell",
	top = "0cell",
	bottom = "0cell",
}
config.window_decorations = "RESIZE"

config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{
		key = "_",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

-- To make ZenMode work
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return config
