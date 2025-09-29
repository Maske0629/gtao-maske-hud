ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('gtaOHud:GetAccountData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(nil) end

    local cash = xPlayer.getMoney()
    local bank = xPlayer.getAccount('bank').money

    cb({
        cash = cash,
        bank = bank
    })
end)