local MonoalphabeticCipher = {}

local function hasNoRepeats(str)
    local charTable = {}
    for i = 1, #str do
        local char = str:sub(i, i)
        if charTable[char] then
            return false
        end
        charTable[char] = true
    end
    return true
end

MonoalphabeticCipher.encipher = function(str, key)
    local result = {}

    str = tostring(str):upper()
    key = tostring(key):upper()

    -- Key must be the length of the alphabet
    if key:len() ~= 26 then
        error("Key must be the length of the alphabet")
    end

    -- Key must have no repeats
    if not hasNoRepeats(key) then
        error("Key must be entirely unique with no repeats of letters")
    end

    print(str)


    for i = 1, str:len() do
        local charInDecimal = str:byte(i)



        -- Only support for uppercase letters
        charInDecimal = charInDecimal - string.byte('A') + 1


        table.insert(result, key:sub(charInDecimal, charInDecimal))
    end

    return table.concat(result)
end

MonoalphabeticCipher.decipher = function(str, key)
    local result = {}
    local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    str = tostring(str)
    key = tostring(key)

    -- Key must be the length of the alphabet
    if key:len() ~= 26 then
        error("Key must be the length of the alphabet")
    end

    -- Key must have no repeats
    if not hasNoRepeats(key) then
        error("Key must be entirely unique with no repeats of letters")
    end

    -- Create a reverse mapping from key to alphabet
    local reverseKey = {}
    for i = 1, 26 do
        reverseKey[key:sub(i, i)] = alphabet:sub(i, i)
    end

    for i = 1, str:len() do
        local char = str:sub(i, i)
        local decipheredChar = reverseKey[char]
        if decipheredChar then
            table.insert(result, decipheredChar)
        else
            table.insert(result, char) -- Keep non-alphabet characters as is
        end
    end

    return table.concat(result)
end

return MonoalphabeticCipher
