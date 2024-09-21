local RailFenceCipher = {}

-- The rail fence cipher is based off having the individual letters on a 'grid' with so many 'rails' and reading it diagonally up and down

--- Enciphers a given string using the Rail Fence Cipher.
--- @param str string: The input string to be enciphered.
--- @param key number: The number of rails to use for the cipher.
--- @return string: The enciphered string.
RailFenceCipher.encipher = function(str, key)
    local result = {}
    local rails = {} -- Here we will have 'key' amount of rails (the key dictates the rails)
    str = tostring(str)

    local currentRail = 1
    local direction = 1

    for i = 1, str:len(), 1 do
        if not rails[currentRail] then
            rails[currentRail] = {}
        end

        table.insert(rails[currentRail], str:sub(i, i))

        -- Change direction if we have reached the bottom
        if currentRail == key then
            direction = -1
        elseif currentRail == 1 then
            direction = 1
        end

        currentRail = currentRail + direction
    end

    for _, rail in ipairs(rails) do
        for _, value in ipairs(rail) do
            table.insert(result, value)
        end
    end

    return table.concat(result)
end

--- Deciphers a given string using the Rail Fence Cipher.
--- @param encryptedStr string: The input string to be deciphered.
--- @param key number: The number of rails used for the cipher.
--- @return string: The deciphered string.
RailFenceCipher.decipher = function(encryptedStr, key)
    local result = {}
    local rails = {}
    encryptedStr = tostring(encryptedStr)

    local currentRail = 1
    local direction = 1

    -- Here we recreate the rail pattern
    for i = 1, encryptedStr:len() do
        if not rails[currentRail] then
            rails[currentRail] = {}
        end

        table.insert(rails[currentRail], i)

        if currentRail == key then
            direction = -1
        elseif currentRail == 1 then
            direction = 1
        end

        currentRail = currentRail + direction
    end

    -- Here, we place down the letters back into that railfence pattern
    local index = 1
    for i = 1, key do
        for j = 1, #rails[i] do
            rails[i][j] = encryptedStr:sub(index, index)
            index = index + 1
        end
    end

    -- We then reread the pattern in the expected order.
    currentRail = 1
    direction = 1
    for i = 1, encryptedStr:len() do
        table.insert(result, rails[currentRail][1])
        table.remove(rails[currentRail], 1)

        if currentRail == key then
            direction = -1
        elseif currentRail == 1 then
            direction = 1
        end

        currentRail = currentRail + direction
    end

    return table.concat(result)
end

return RailFenceCipher
