# Interface: ISuperSignatureStorage

## Metadata

- **Name**: ISuperSignatureStorage
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperSignatureStorage.sol
- **Documentation**: @title ISuperSignatureStorage
   @author Superform Labs
   @notice Interface for retrieving signature data for smart account validation
   @dev Used by validators to retrieve stored signature data associated with accounts

## Errors

### INVALID_USER_OP

```solidity
/// @notice Thrown when more than one user op is detected for signature storage
error INVALID_USER_OP();
```

## Public/External Functions

### retrieveSignatureData(address)

- **Signature**: `retrieveSignatureData(address)`
- **Visibility**: external
- **Source Range**: 1220:85:426

**Signature:**
```solidity
/// @notice Retrieve signature data for a specific smart account
///  @dev Returns the stored signature data that can be used for validation
///       This data typically includes merkle roots or public keys authorized by the account
///  @param account The smart account address to retrieve signature data for
///  @return The signature data associated with the account (e.g., merkle roots)
function retrieveSignatureData(address account) external view returns (bytes memory);;
```
