local AffineCipher = {}

-- The affine cipher generally follows this: (ax + b)mod26 where a is coprime with 26

-- The modular inverse is required for to decipher an Affine Cipher
local function modInverse(aCoefficient)
    aCoefficient = aCoefficient % 26
    for i = 1, 26 - 1 do
        if (aCoefficient * i) % 26 == 1 then
            return i
        end
    end
    return nil -- No modular inverse if this point is reached
end

-- Should primarily be used as a 'helper' function for providing a 'valid' aCoefficient
AffineCipher.generateCoprimeOfNumber = function(number)
    -- To be implemented
end

AffineCipher.encipher = function(str, aCoefficient, bCoefficient) -- Where aCoefficient and bCoefficient are used for (ax + b)mod26
    local result = {}

    str = tostring(str)

    for i = 1, str:len() do
        local initialCharDecimal = str:byte(i)
        local finalCharDecimal = 0

        if initialCharDecimal >= 65 and initialCharDecimal <= 90 then
            -- Uppercase letter
            finalCharDecimal = (((initialCharDecimal - 65) * aCoefficient) + bCoefficient) % 26
            finalCharDecimal = finalCharDecimal + 65
        elseif initialCharDecimal >= 97 and initialCharDecimal <= 122 then
            -- Lowercase letter

            finalCharDecimal = ((((initialCharDecimal - 97)) * aCoefficient) + bCoefficient) % 26
            finalCharDecimal = finalCharDecimal + 97
        else
            -- Non alphabetic character, keep it as is
            finalCharDecimal = initialCharDecimal
        end

        table.insert(result, string.char(finalCharDecimal))
    end

    return table.concat(result)
end

AffineCipher.decipher = function(encyrptedStr, aCoefficient, bCoefficient)
    local result = {}

    local aInverse = modInverse(aCoefficient)

    encyrptedStr = tostring(encyrptedStr)

    for i = 1, encyrptedStr:len() do
        local initialCharDecimal = encyrptedStr:byte(i)
        local finalCharDecimal = 0

        if initialCharDecimal >= 65 and initialCharDecimal <= 90 then
            -- Uppercase letter
            finalCharDecimal = (((initialCharDecimal - 65) - bCoefficient) * aInverse) % 26
            if finalCharDecimal < 0 then finalCharDecimal = finalCharDecimal + 26 end
            finalCharDecimal = finalCharDecimal + 65
        elseif initialCharDecimal >= 97 and initialCharDecimal <= 122 then
            -- Lowercase letter
            finalCharDecimal = ((((initialCharDecimal - 97)) - bCoefficient) * aInverse) % 26
            if finalCharDecimal < 0 then finalCharDecimal = finalCharDecimal + 26 end
            finalCharDecimal = finalCharDecimal + 97
        else
            -- Non alphabetic character, keep it as is
            finalCharDecimal = initialCharDecimal
        end

        table.insert(result, string.char(finalCharDecimal))
    end

    return table.concat(result)
end

return AffineCipher
