fx_version 'cerulean'
game 'gta5'

author 'JaxDanger'
description 'Commands for jrp framework'
version '0.0.5'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}


server_scripts {
    'sv_car.lua',
    'sv_tpm.lua',
    'sv_getpos.lua',
    'sv_functions.lua',
}

client_scripts {
    'cl_tpm.lua',
    'sv_car.lua',
}


