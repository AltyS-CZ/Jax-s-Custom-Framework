fx_version 'cerulean'
game 'gta5'

author 'JaxDanger'
description 'Custom Economy Framework'
version '0.0.5'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
}

client_scripts {
    'client/main.lua',
    'client/cl_commands.lua',
}

dependencies {
    'menuv',
}
