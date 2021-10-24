fx_version "bodacious"
game "gta5"

ui_page "ui/index.html"

files {
	"ui/*",
	"ui/**/*",
	"ui/**/**/*"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client-side/*",
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server-side/*",
}