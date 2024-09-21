local AffineCipher = {}

-- The affine cipher generally follows this: (ax + b)mod26 where a is coprime with 26

--- Calculates the modular inverse of a given coefficient.
--- @param aCoefficient number: The coefficient for which to find the modular inverse.
--- @return number|nil: The modular inverse if it exists, otherwise nil.
local function modInverse(aCoefficient)
    aCoefficient = aCoefficient % 26
    for i = 1, 26 - 1 do
        if (aCoefficient * i) % 26 == 1 then
            return i
        end
    end
    return nil -- No modular inverse if this point is reached
end

--- Generates a coprime of a given number (ideal for the aCoefficient in the encipher).
--- @param number number: The number for which to generate a coprime.
--- @return number: A coprime of the given number.
AffineCipher.generateCoprimeOfNumber = function(number)
    local function gcd(a, b) -- greatest common divisor
        while b ~= 0 do
            a, b = b, a % b
        end
        return a
    end

    for i = 2, number - 1 do
        if gcd(number, i) == 1 then -- meaning they are coprimes as only 1 is their common divisor
            return i
        end
    end
    return 1 -- 1 is coprime with any number
end

--- Enciphers a given string using the Affine Cipher.
--- @param str string: The input string to be enciphered.
--- @param aCoefficient number: The 'a' coefficient used in the affine transformation.
--- @param bCoefficient number: The 'b' coefficient used in the affine transformation.
--- @return string: The enciphered string.
AffineCipher.encipher = function(str, aCoefficient, bCoefficient)
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
            finalCharDecimal = (((initialCharDecimal - 97) * aCoefficient) + bCoefficient) % 26
            finalCharDecimal = finalCharDecimal + 97
        else
            -- Non-alphabetic character, keep it as is
            finalCharDecimal = initialCharDecimal
        end

        table.insert(result, string.char(finalCharDecimal))
    end

    return table.concat(result)
end

--- Deciphers a given string using the Affine Cipher.
--- @param encryptedStr string: The input string to be deciphered.
--- @param aCoefficient number: The 'a' coefficient used in the affine transformation.
--- @param bCoefficient number: The 'b' coefficient used in the affine transformation.
--- @return string: The deciphered string.
AffineCipher.decipher = function(encryptedStr, aCoefficient, bCoefficient)
    local result = {}

    local aInverse = modInverse(aCoefficient)

    encryptedStr = tostring(encryptedStr)

    for i = 1, encryptedStr:len() do
        local initialCharDecimal = encryptedStr:byte(i)
        local finalCharDecimal = 0

        if initialCharDecimal >= 65 and initialCharDecimal <= 90 then
            -- Uppercase letter
            finalCharDecimal = (((initialCharDecimal - 65) - bCoefficient) * aInverse) % 26
            if finalCharDecimal < 0 then finalCharDecimal = finalCharDecimal + 26 end
            finalCharDecimal = finalCharDecimal + 65
        elseif initialCharDecimal >= 97 and initialCharDecimal <= 122 then
            -- Lowercase letter
            finalCharDecimal = (((initialCharDecimal - 97) - bCoefficient) * aInverse) % 26
            if finalCharDecimal < 0 then finalCharDecimal = finalCharDecimal + 26 end
            finalCharDecimal = finalCharDecimal + 97
        else
            -- Non-alphabetic character, keep it as is
            finalCharDecimal = initialCharDecimal
        end

        table.insert(result, string.char(finalCharDecimal))
    end

    return table.concat(result)
end

return AffineCipher
