local cash = 0
local bank = 0
local dirtyMoney = 0


function getPlayerId(player)
    if type(player) == 'number' then
        return player
    elseif type(player) == 'string' then
        for _, id in ipairs(GetPlayers()) do
            if GetPlayerName(id) == player then
                return id
            end
        end
    elseif type(player) == 'userdata' then
        return tonumber(PlayerId())
    end
    return nil
end



-- Function to get the player's cash
function GetPlayerCash(source)
    local player = source
    local cash = 0

    -- Retrieve the cash from the database
    exports.oxmysql:execute('SELECT cash FROM users WHERE identifier = ?', { GetPlayerIdentifier(player, 0) }, function(result)
        if result[1] ~= nil then
            cash = tonumber(result[1].cash)
        end
    end)

    return cash
end

-- Function to add cash to the player
function AddPlayerCash(source, amount)
    local player = source
    local currentCash = GetPlayerCash(player)

    -- Calculate the new cash value
    local newCash = currentCash + amount

    -- Update the cash in the database
    exports.oxmysql:execute('UPDATE users SET cash = ? WHERE identifier = ?', { newCash, GetPlayerIdentifier(player, 0) })
end

-- Function to remove cash from the player
function RemovePlayerCash(source, amount)
    local player = source
    local currentCash = GetPlayerCash(player)

    -- Check if the player has enough cash
    if currentCash >= amount then
        -- Calculate the new cash value
        local newCash = currentCash - amount

        -- Update the cash in the database
        exports.oxmysql:execute('UPDATE users SET cash = ? WHERE identifier = ?', { newCash, GetPlayerIdentifier(player, 0) })
        -- Cash successfully removed
        TriggerClientEvent('chat:addMessage', player, { args = { '^2Success:', '$' .. amount ' was removed from your cash.'} })
        return true
    else
        TriggerClientEvent('chat:addMessage', player, { args = { '^1Error:', 'Insufficient funds' } })
        return false
    end
end

-- Define the getPlayerBankBalance function
local function getPlayerBankBalance(playerId)
    -- Perform the database query to fetch the bank balance
    -- Replace this with your actual database query code
    local bankBalance = 0 -- Replace with your database retrieval logic

    -- Return the bank balance
    return bankBalance
end


-- Export the functions
exports('getPlayerBankBalance', getPlayerBankBalance)
exports('GetPlayerCash', GetPlayerCash)
exports('AddPlayerCash', AddPlayerCash)
exports('RemovePlayerCash', RemovePlayerCash)

--- Get player date such as cash, bank and dirty money
local function getPlayerData(player, callback)
    local playerId = tonumber(player)
    local identifiers = GetPlayerIdentifiers(playerId)
    local identifier = identifiers[1]
    exports.oxmysql:execute('SELECT * FROM users WHERE identifier = ?', {identifier}, function(result)
        if result[1] ~= nil then
            local data = {
                identifier = result[1].identifier,
                license = result[1].license,
                name = result[1].name,
                job = result[1].job or "Citizen",
                cash = result[1].cash,
                bank = result[1].bank,
                dirty_money = result[1].dirty_money,
                position = json.decode(result[1].position) or nil
            }
            callback(data)
        else
            callback(nil)
        end
    end)
end