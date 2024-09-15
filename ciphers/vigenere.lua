local VignereCipher = {}

local function caeserCipherOnCharacter(char, shiftValue)
    -- We should consider converting the shiftValue (as the shiftValue here is alphabetic)
    if shiftValue >= 65 and shiftValue <= 90 then
        -- Uppercase letter
        shiftValue = shiftValue - 65
    elseif shiftValue >= 97 and shiftValue <= 122 then
        -- Lowercase letter
        shiftValue = shiftValue - 97
    else
        -- Non-alphabetic character
    end


    if (char > 64) and (char < 91) then
        -- The character is uppercase
        local newCharValue = char + shiftValue
        if (newCharValue) < 65 then
            -- The character is technically out of range in the negatives
            local amountOutBy = 65 - newCharValue

            newCharValue = 91 - amountOutBy
        elseif (newCharValue) > 90 then
            -- The character is technically out of range in the positives
            local amountOutBy = newCharValue - 90

            newCharValue = 64 + amountOutBy
        end

        return string.char(newCharValue)
    elseif (char > 96) and (char < 123) then
        -- The character is lowercase
        local newCharValue = char + shiftValue
        if (newCharValue) < 97 then
            -- The character is technically out of range in the negatives
            local amountOutBy = 97 - newCharValue

            newCharValue = 123 - amountOutBy
        elseif (newCharValue) > 122 then
            -- The character is technically out of range in the positives
            local amountOutBy = newCharValue - 122

            newCharValue = 96 + amountOutBy
        end
        return string.char(newCharValue)
    else
        -- The character is not an alphabet character, keep the same
        return string.char(char)
    end
end


local function caeserDecipherOnCharacter(char, shiftValue)
    -- We should consider converting the shiftValue (as the shiftValue here is alphabetic)
    if shiftValue >= 65 and shiftValue <= 90 then
        -- Uppercase letter
        shiftValue = shiftValue - 65
    elseif shiftValue >= 97 and shiftValue <= 122 then
        -- Lowercase letter
        shiftValue = shiftValue - 97
    else
        -- Non-alphabetic character
    end


    if (char > 64) and (char < 91) then
        -- The character is uppercase
        local newCharValue = char - shiftValue
        if (newCharValue) < 65 then
            -- The character is technically out of range in the negatives
            local amountOutBy = 65 - newCharValue

            newCharValue = 91 - amountOutBy
        elseif (newCharValue) > 90 then
            -- The character is technically out of range in the positives
            local amountOutBy = newCharValue - 90

            newCharValue = 64 + amountOutBy
        end

        return string.char(newCharValue)
    elseif (char > 96) and (char < 123) then
        -- The character is lowercase
        local newCharValue = char - shiftValue
        if (newCharValue) < 97 then
            -- The character is technically out of range in the negatives
            local amountOutBy = 97 - newCharValue

            newCharValue = 123 - amountOutBy
        elseif (newCharValue) > 122 then
            -- The character is technically out of range in the positives
            local amountOutBy = newCharValue - 122

            newCharValue = 96 + amountOutBy
        end
        return string.char(newCharValue)
    else
        -- The character is not an alphabet character, keep the same
        return string.char(char)
    end
end

VignereCipher.encipher = function(str, encryptionKey)
    local result = {}

    str = tostring(str)
    encryptionKey = tostring(encryptionKey)

    local strLen = str:len()
    local keyLen = encryptionKey:len()

    -- We want to make the encryptionKey the same length as the string
    if strLen ~= keyLen then
        -- So, we make adjustments to the encryptionKey based on it's length
        if (strLen < keyLen) then
            encryptionKey = encryptionKey:sub(strLen, keyLen)
        else
            while #encryptionKey < strLen do
                encryptionKey = encryptionKey .. encryptionKey
            end
            encryptionKey = encryptionKey:sub(1, strLen)
        end
    end


    for i = 1, strLen, 1 do
        local cipheredCharacter = caeserCipherOnCharacter(str:sub(i, i + 1):byte(), encryptionKey:sub(i, i + 1):byte())
        table.insert(result, cipheredCharacter)
    end

    return table.concat(result)
end

VignereCipher.decipher = function(encryptedStr, encryptionKey)
    local result = {}

    encryptedStr = tostring(encryptedStr)
    encryptionKey = tostring(encryptionKey)

    local strLen = encryptedStr:len()
    local keyLen = encryptionKey:len()

    -- We want to make the encryptionKey the same length as the string
    if strLen ~= keyLen then
        -- So, we make adjustments to the encryptionKey based on it's length
        if (strLen < keyLen) then
            encryptionKey = encryptionKey:sub(strLen, keyLen)
        else
            while #encryptionKey < strLen do
                encryptionKey = encryptionKey .. encryptionKey
            end
            encryptionKey = encryptionKey:sub(1, strLen)
        end
    end


    for i = 1, strLen do
        local cipheredCharacter = caeserDecipherOnCharacter(encryptedStr:sub(i, i + 1):byte(),
            encryptionKey:sub(i, i + 1):byte())
        table.insert(result, cipheredCharacter)
    end

    return table.concat(result)
end

return VignereCipher
