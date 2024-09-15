local CaeserCipher = {}


-- The principle of the Caeser Cipher rely on the string being strictly of alphabetical characters.
CaeserCipher.encipher = function(str, shiftValue)
    local result = {}

    shiftValue = tonumber(shiftValue)
    str = tostring(str)

    for i = 1, str:len(), 1 do
        local char = str:sub(i, i + 1):byte()

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

            table.insert(result, string.char(newCharValue))
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
            table.insert(result, string.char(newCharValue))
        else
            -- The character is not an alphabet character, keep the same
            table.insert(result, string.char(char))
        end
    end

    return table.concat(result)
end

CaeserCipher.decipher = function(encryptedStr, shiftValue)
    local result = {}

    shiftValue = -tonumber(shiftValue)
    encryptedStr = tostring(encryptedStr)

    for i = 1, encryptedStr:len(), 1 do
        local char = encryptedStr:sub(i, i + 1):byte()

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

            table.insert(result, string.char(newCharValue))
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
            table.insert(result, string.char(newCharValue))
        else
            -- The character is not an alphabet character, keep the same
            table.insert(result, string.char(char))
        end
    end

    return table.concat(result)
end

CaeserCipher.bruteforce = function(encryptedStr)
    -- There are 26 letters in the Alphabet, so a total of 26 Real Shift values (excluding 0)
    local potentialOriginalStrs = {}

    for i = 1, 26 do
        local decryptionResult = CaeserCipher.decipher(encryptedStr, i)
        table.insert(potentialOriginalStrs, decryptionResult)
    end

    return potentialOriginalStrs
end



return CaeserCipher
