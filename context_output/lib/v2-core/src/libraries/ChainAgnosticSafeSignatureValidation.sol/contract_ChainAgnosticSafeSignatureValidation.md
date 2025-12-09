# Contract: ChainAgnosticSafeSignatureValidation

## Metadata

- **Name**: ChainAgnosticSafeSignatureValidation
- **Type**: Contract
- **Path**: lib/v2-core/src/libraries/ChainAgnosticSafeSignatureValidation.sol

## State Variables

### CHAIN_AGNOSTIC_DOMAIN_TYPEHASH

```solidity
/// @notice Chain-agnostic domain separator type hash
///  @dev Uses a fixed domain without chainId for cross-chain compatibility
///  @notice verifyingContract is the safe smart account address
bytes32 private constant CHAIN_AGNOSTIC_DOMAIN_TYPEHASH = 0x8b73c3c69bb8fe3d512ecc4cf759cc79239f7b179b0ffacaa9a75d522b39400f
```

### FIXED_CHAIN_ID

```solidity
/// @notice Fixed chain ID for cross-chain signature 1271 compatibility
uint256 private constant FIXED_CHAIN_ID = 1
```

### DOMAIN_NAME

```solidity
/// @notice Domain name and version for cross-chain 1271 signatures
string private constant DOMAIN_NAME = "SuperformSafe"
```

### DOMAIN_VERSION

```solidity
string private constant DOMAIN_VERSION = "1.0.0"
```
