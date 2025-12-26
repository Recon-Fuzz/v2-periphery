# Contract: SignatureTransientStorage

## Metadata

- **Name**: SignatureTransientStorage
- **Type**: Contract
- **Path**: lib/v2-core/src/libraries/SignatureTransientStorage.sol

## State Variables

### SIGNATURE_KEY_STORAGE

```solidity
/// @notice Storage key for transient signature data
///  @dev Uses the transient storage pattern to store signature data temporarily
///       This is more gas efficient than regular storage for temporary data
bytes32 internal constant SIGNATURE_KEY_STORAGE = keccak256("transient.signature.bytes.mapping")
```

## Errors

### INVALID_USER_OP

```solidity
/// @notice Error thrown when more than one user op is detected for signature storage
error INVALID_USER_OP();
```
