# Mini SHA

# this is to basically understand how SHA works but by using a much smaller hash size

# note that this is also a fertile playground to test mixing / effect of rotations and block sizes, etc.
# Rotate right for 8-bit integers
ror8 <- function(x, n) {
  x <- as.integer(bitwAnd(x, 0xFF))
  n <- as.integer(n)
  left_part  <- bitwAnd(bitwShiftL(x, (8L - n)), 0xFF)
  right_part <- bitwShiftR(x, n)
  bitwAnd(bitwOr(right_part, left_part), 0xFF)
}

# Mini-SHA (toy example)
mini_sha <- function(message) {
  msg_bytes <- as.integer(utf8ToInt(message))
  bit_len <- length(msg_bytes) * 8L
  
  # Append '1' bit
  msg_bytes <- c(msg_bytes, 0x80L)
  
  # Pad with zeros until length ≡ 24 mod 32 bits
  while (((length(msg_bytes) * 8L) %% 32L) != 24L) {
    msg_bytes <- c(msg_bytes, 0x00L)
  }
  
  # Append length (8-bit)
  msg_bytes <- c(msg_bytes, bit_len & 0xFF)
  
  # Initial hash values
  H0 <- 0x12L
  H1 <- 0x34L
  
  # First 8 primes -- this is exactly the same idea as used by SHA-256
  primes8 <- c(2, 3, 5, 7, 11, 13, 17, 19)
  
  # Derive K values from cube roots (8-bit version)
  K <- as.integer(floor((primes8^(1/3) %% 1) * 256))
  K
  sprintf("0x%02X", K)  # Hex form
  
  # Message schedule
  W <- integer(8)
  W[1:length(msg_bytes)] <- msg_bytes
  if (length(msg_bytes) < 8) {
    for (i in (length(msg_bytes) + 1):8) {
      W[i] <- bitwAnd(
        bitwXor(W[i-3], W[i-5]) + bitwShiftR(W[i-1], 1L),
        0xFF
      )
    }
  }
  
  # Compression
  A <- H0
  B <- H1
  for (i in 1:8) {
    temp <- bitwAnd(
      ror8(A, 3) + bitwXor(A, B) + W[i] + K[i],
      0xFF
    )
    A <- B
    B <- temp
  }
  
  # Feed-forward
  H0 <- bitwAnd(H0 + A, 0xFF)
  H1 <- bitwAnd(H1 + B, 0xFF)
  
  sprintf("%02x%02x", H0, H1)
}

# Test
inputs <- c("hello", "hellp", "world", "crypto")
data.frame(Input = inputs, MiniSHA = sapply(inputs, mini_sha))
