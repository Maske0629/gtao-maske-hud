fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'GTAO HUD for ESX - Money display similar to GTA Online'

author 'maske0926'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    '@es_extended/imports.lua',
    'server.lua'
}

dependencies {
    'es_extended'

}
