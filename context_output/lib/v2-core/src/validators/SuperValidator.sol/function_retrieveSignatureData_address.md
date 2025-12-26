# Function: retrieveSignatureData(address)

**Contract**: [lib/v2-core/src/validators/SuperValidator.sol/contract_SuperValidator.md]

## Metadata

- **Contract**: SuperValidator
- **Signature**: `retrieveSignatureData(address)`
- **Visibility**: external
- **Source Range**: 1294:191:438

## Implementation

```solidity
/// @inheritdoc ISuperSignatureStorage
function retrieveSignatureData(address account) external view returns (bytes memory) {
    uint256 identifier = uint256(uint160(account));
    return identifier.loadSignature();
}
```

## Related Implementations

### loadSignature(uint256)

- **Kind**: internal
- **Source**: 2623:537:435
- **Link**: `lib/v2-core/src/libraries/SignatureTransientStorage.sol:SignatureTransientStorage:loadSignature(uint256)`

```solidity
/// @notice Retrieves signature data from transient storage
///  @dev Uses EVM assembly for efficient transient storage operations
///       First loads the length, then each 32-byte chunk of the signature data
///       Transient storage (tload) is used for gas efficiency and temporary data
///  @param identifier The unique identifier for this signature (derived from account address)
function loadSignature(uint256 identifier) internal view returns (bytes memory out) {
    bytes32 storageKey = _makeKey(identifier);
    uint256 len;
    assembly {
        len := tload(storageKey)
    }
    out = new bytes(len);
    for (uint256 i; i < len; i += 32) {
        bytes32 word;
        assembly {
            word := tload(add(storageKey, div(add(i, 32), 32)))
        }
        assembly {
            mstore(add(add(out, 0x20), i), word)
        }
    }
}
```

### _makeKey(uint256)

- **Kind**: internal
- **Source**: 3711:155:435
- **Link**: `lib/v2-core/src/libraries/SignatureTransientStorage.sol:SignatureTransientStorage:_makeKey(uint256)`

```solidity
/// @notice Generates a storage key for transient storage
///  @dev Combines the base storage key with an identifier (usually account address)
///       to create a unique storage location
///  @param identifier The unique identifier (typically derived from account address)
///  @return A unique storage key for the transient storage system
function _makeKey(uint256 identifier) private pure returns (bytes32) {
    return keccak256(abi.encodePacked(SIGNATURE_KEY_STORAGE, identifier));
}
```

## State Variable Reads

- **SIGNATURE_KEY_STORAGE** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperValidator.retrieveSignatureData(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SignatureTransientStorage.loadSignature(uint256) (NodeID: 1)
      💬 Args: [identifier]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SignatureTransientStorage._makeKey(uint256) (NodeID: 2)
        💬 Args: [identifier]
        👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperSignatureStorage

### Interface Documentation

@notice Retrieve signature data for a specific smart account
 @dev Returns the stored signature data that can be used for validation
      This data typically includes merkle roots or public keys authorized by the account
 @param account The smart account address to retrieve signature data for
 @return The signature data associated with the account (e.g., merkle roots)
