fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'triggerderler'
description 'td-moneywash'
version '1.7'

server_scripts { 
    "server/*",
}

client_scripts { 
    "client/*",
}

shared_scripts { 
	"shared/*",
	'@ox_lib/init.lua'
}

dependencies {
	'ox_lib',
}
