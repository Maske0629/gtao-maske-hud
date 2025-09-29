local ESX = exports['es_extended']:getSharedObject()
local isShowing = false
local showDuration = 5000 -- HUD display duration in milliseconds
local canPress = true
local hudInitialized = false
local playerLoaded = false

-- Update the HUD with current bank and cash amounts
local function UpdateHUD()
    if not ESX.IsPlayerLoaded() or not hudInitialized then return end

    ESX.TriggerServerCallback("gtaOHud:GetAccountData", function(accounts)
        if accounts then
            if isShowing then
                RemoveMultiplayerBankCash()
                RemoveMultiplayerWalletCash()
            end

            isShowing = true

            SetMultiplayerBankCash()
            SetMultiplayerWalletCash()

            StatSetInt("BANK_BALANCE", accounts.bank or 0, true)
            StatSetInt("MP0_WALLET_BALANCE", accounts.cash or 0, true)

            Citizen.SetTimeout(showDuration, function()
                RemoveMultiplayerBankCash()
                RemoveMultiplayerWalletCash()
                isShowing = false
            end)
        end
    end)
end

-- Player has loaded into the game
RegisterNetEvent('esx:playerLoaded', function()
    playerLoaded = true
    -- Delay HUD initialization to avoid showing stale data
    Citizen.SetTimeout(3000, function()
        hudInitialized = true
    end)
end)

-- Automatically update HUD when money changes
RegisterNetEvent('esx:setAccountMoney', function(account)
    UpdateHUD()
end)

RegisterNetEvent('esx:addAccountMoney', function(account)
    UpdateHUD()
end)

RegisterNetEvent('esx:removeAccountMoney', function(account)
    UpdateHUD()
end)

-- Command to toggle the HUD display
RegisterCommand("openhud", function()
    if playerLoaded and hudInitialized and canPress then
        canPress = false
        UpdateHUD()
        Citizen.SetTimeout(showDuration, function()
            canPress = true
        end)
    end
end, false)

-- Register key mapping so players can change the HUD toggle key in FiveM settings (default = Z)
RegisterKeyMapping("openhud", "Show HUD (Money Display)", "keyboard", "z")