local ROT13 = {}

-- ROT13 is just incrementing the alphabet by 13.
-- This is shown in the form (x+13)%26

--- Enciphers a given string using the ROT13 algorithm.
--- @param str string: The input string to be enciphered.
--- @return string: The enciphered string.
ROT13.encipher = function(str)
    local result = {}
    str = tostring(str)

    for i = 1, str:len() do
        local initialCharDecimal = str:byte(i)
        local finalCharDecimal = 0

        if initialCharDecimal >= 65 and initialCharDecimal <= 90 then
            -- Uppercase letter
            finalCharDecimal = (initialCharDecimal - 65 + 13) % 26
            finalCharDecimal = finalCharDecimal + 65
        elseif initialCharDecimal >= 97 and initialCharDecimal <= 122 then
            -- Lowercase letter
            finalCharDecimal = (initialCharDecimal - 97 + 13) % 26
            finalCharDecimal = finalCharDecimal + 97
        end

        table.insert(result, string.char(finalCharDecimal))
    end

    return table.concat(result)
end

--- Deciphers a given string using the ROT13 algorithm.
--- @param encryptedStr string: The input string to be deciphered.
--- @return string: The deciphered string.
ROT13.decipher = function(encryptedStr)
    local result = {}
    encryptedStr = tostring(encryptedStr)

    for i = 1, encryptedStr:len() do
        local initialCharDecimal = encryptedStr:byte(i)
        local finalCharDecimal = 0

        if initialCharDecimal >= 65 and initialCharDecimal <= 90 then
            -- Uppercase letter
            finalCharDecimal = (initialCharDecimal - 65 - 13) % 26
            finalCharDecimal = finalCharDecimal + 65
        elseif initialCharDecimal >= 97 and initialCharDecimal <= 122 then
            -- Lowercase letter
            finalCharDecimal = (initialCharDecimal - 97 - 13) % 26
            finalCharDecimal = finalCharDecimal + 97
        end

        table.insert(result, string.char(finalCharDecimal))
    end

    return table.concat(result)
end

return ROT13
