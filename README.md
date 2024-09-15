# Lua Ciphers

Welcome to Lua Ciphers! This is an educational project where I explore and implement commonly used ciphers in Lua. There is no one real goal of this project, other than the fact it was purely educational for me.

## Project Overview

In this project, you'll find implementations of various ciphers, including but not limited to:

- **Caesar Cipher**: A simple substitution cipher where each letter in the plaintext is shifted a certain number of places down the alphabet.
- **Vigenère Cipher**: A method of encrypting alphabetic text by using a simple form of polyalphabetic substitution.
- **Affine Cipher**: A type of monoalphabetic substitution cipher where each letter in an alphabet is mapped to its numeric equivalent, encrypted using a simple mathematical function, and converted back to a letter.
- **ROT13 Cipher**: A special case of the Caesar Cipher where each letter is shifted by 13 places in the alphabet.
- **Rail Fence Cipher**: A transposition cipher that writes the plaintext in a zigzag pattern across multiple "rails" and then reads off each row to create the ciphertext.

## Getting Started

To get started with the project, you'll need to have Lua installed on your machine. You can download Lua from the [official website](https://www.lua.org/download.html).

Clone the repository to your local machine in your project directory:

```sh
git clone https://github.com/selectr4u/lua-ciphers.git
cd lua-ciphers
```

And then you can require the ciphers in your project!

```lua
local ciphers = require 'ciphers.ciphers'
```

## Contributing

Feel free to contribute any other ciphers!

## License
This project is licensed under the MIT License. See the LICENSE file for more details.
