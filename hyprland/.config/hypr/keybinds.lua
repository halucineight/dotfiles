local terminal = "kitty"
local menu = "quickshell ipc call launcher toggle"
local browser = "firefox"
local main_mod = "SUPER"

hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + C", hl.dsp.window.close())
hl.bind(main_mod .. " + M", hl.dsp.exit())
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())

hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))

for workspace = 1, 10 do
	local key = workspace % 10
	hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
	hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(main_mod .. " + F", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(main_mod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(main_mod .. " + Escape", hl.dsp.exec_cmd("quickshell ipc call powerMenu toggle"))
hl.bind(main_mod .. " + SHIFT + A", hl.dsp.exec_cmd("pkill quickshell; quickshell &"))

hl.bind(main_mod .. " + F11", hl.dsp.exec_cmd("grimblast copysave active"))
hl.bind(main_mod .. " + ALT + F11", hl.dsp.exec_cmd("grimblast copysave output"))
hl.bind(main_mod .. " + SHIFT + F11", hl.dsp.exec_cmd("grimblast copysave area"))

hl.bind(main_mod .. " + G", hl.dsp.exec_cmd(browser))

hl.bind(main_mod .. " + E", hl.dsp.exec_cmd("kitty yazi"))

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
