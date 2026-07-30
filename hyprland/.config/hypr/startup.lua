--Commands that mst run on session startup go here
hl.on("hyprland.start", function()
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("quickshell -d -p ~/.config/quickshell")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("blueman-applet")
end)
