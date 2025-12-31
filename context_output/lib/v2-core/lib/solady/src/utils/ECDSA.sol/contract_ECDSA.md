# Contract: ECDSA

## Metadata

- **Name**: ECDSA
- **Type**: Contract
- **Path**: lib/v2-core/lib/solady/src/utils/ECDSA.sol
- **Documentation**: @notice Gas optimized ECDSA wrapper.
   @author Solady (https://github.com/vectorized/solady/blob/main/src/utils/ECDSA.sol)
   @author Modified from Solmate (https://github.com/transmissions11/solmate/blob/main/src/utils/ECDSA.sol)
   @author Modified from OpenZeppelin (https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/cryptography/ECDSA.sol)
   @dev Note:
   - The recovery functions use the ecrecover precompile (0x1).
   - As of Solady version 0.0.68, the `recover` variants will revert upon recovery failure.
     This is for more safety by default.
     Use the `tryRecover` variants if you need to get the zero address back
     upon recovery failure instead.
   - As of Solady version 0.0.134, all `bytes signature` variants accept both
     regular 65-byte `(r, s, v)` and EIP-2098 `(r, vs)` short form signatures.
     See: https://eips.ethereum.org/EIPS/eip-2098
     This is for calldata efficiency on smart accounts prevalent on L2s.
   WARNING! Do NOT directly use signatures as unique identifiers:
   - The recovery operations do NOT check if a signature is non-malleable.
   - Use a nonce in the digest to prevent replay attacks on the same contract.
   - Use EIP-712 for the digest to prevent replay attacks across different chains and contracts.
     EIP-712 also enables readable signing of typed data for better user safety.
   - If you need a unique hash from a signature, please use the `canonicalHash` functions.

## State Variables

### N

```solidity
/// @dev The order of the secp256k1 elliptic curve.
uint256 internal constant N = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141
```

### _HALF_N_PLUS_1

```solidity
/// @dev `N/2 + 1`. Used for checking the malleability of the signature.
uint256 private constant _HALF_N_PLUS_1 = 0x7fffffffffffffffffffffffffffffff5d576e7357a4501ddfe92f46681b20a1
```

## Errors

### InvalidSignature

```solidity
/// @dev The signature is invalid.
error InvalidSignature();
```
