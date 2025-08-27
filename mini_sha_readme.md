# Mini SHA-R

A toy implementation of SHA-like cryptographic hashing in R, designed for educational purposes to understand the core concepts of secure hash algorithms.

## Overview

This repository contains a simplified version of the SHA (Secure Hash Algorithm) family, implemented in R with much smaller hash sizes to make the algorithm's mechanics more transparent and easier to understand. While not cryptographically secure, it demonstrates the key principles used in production hash functions like SHA-256.

## Features

- **Educational Focus**: Simplified implementation that maintains the core SHA structure while being easy to follow
- **Bit Manipulation**: Demonstrates essential cryptographic operations like rotations, XOR, and modular arithmetic
- **Configurable**: Fertile playground for experimenting with different mixing functions, rotation amounts, and block sizes
- **Clear Structure**: Well-commented code showing each step of the hashing process

## How It Works

The Mini-SHA implementation follows the same fundamental structure as SHA-256 but with reduced parameters:

1. **Message Preprocessing**: Converts input to bytes and applies padding
2. **Initial Hash Values**: Uses small 8-bit initial values (0x12, 0x34)
3. **Constants Generation**: Derives round constants from cube roots of the first 8 prime numbers
4. **Message Schedule**: Extends the input using bit operations
5. **Compression Function**: Processes the message through 8 rounds using rotations and XOR operations
6. **Final Output**: Produces a 16-bit (2-byte) hash

## Key Functions

- `ror8()`: 8-bit right rotation function
- `mini_sha()`: Main hashing function that processes input strings
- Built-in test cases demonstrating hash output for sample inputs

## Example Usage

```r
source("mini_sha_1.R")

# Hash a single string
mini_sha("hello")
# Output: "a4c2"

# Test multiple inputs
inputs <- c("hello", "hellp", "world", "crypto")
results <- data.frame(Input = inputs, MiniSHA = sapply(inputs, mini_sha))
print(results)
```

## Educational Value

This implementation is perfect for:
- Understanding how cryptographic hash functions work internally
- Learning about bit manipulation in cryptography
- Experimenting with different hash function parameters
- Teaching the avalanche effect in hash functions
- Exploring the relationship between input changes and output changes

## Limitations

⚠️ **Warning**: This is a toy implementation for educational purposes only. It:
- Uses only 16-bit output (easily brute-forceable)
- Has a simplified round function
- Is not suitable for any security applications
- May have collisions with relatively few inputs

## Contributing

Feel free to experiment with different parameters:
- Try different rotation amounts
- Modify the round function
- Change the number of rounds
- Experiment with different constants

## License

This code is provided for educational purposes. Feel free to use, modify, and share for learning about cryptographic hash functions.

---

*This implementation helps bridge the gap between theoretical understanding of hash functions and their practical implementation, making the "magic" of cryptography more accessible to learners.*