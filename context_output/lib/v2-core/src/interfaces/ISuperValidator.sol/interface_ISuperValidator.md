# Interface: ISuperValidator

## Metadata

- **Name**: ISuperValidator
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperValidator.sol
- **Documentation**: @title ISuperValidator
   @author Superform Labs

## Structs

### DstProof

```solidity
/// @notice Structure holding proof data for destination chain operations
///  @dev Contains merkle proof and destination chain ID
struct DstProof {
    bytes32[] proof;
    uint64 dstChainId;
    DstInfo info;
}
```

### DstInfo

```solidity
/// @notice Structure holding destination chain operation details
///  @dev Used to validate destination `proof` on source validator
struct DstInfo {
    address account;
    address executor;
    address[] dstTokens;
    uint256[] intentAmounts;
    address validator;
    bytes data;
}
```

### DestinationData

```solidity
/// @notice Structure representing data specific to a destination chain operation
///  @dev Contains all necessary data to validate and execute a cross-chain operation
struct DestinationData {
    bytes callData;
    uint64 chainId;
    address sender;
    address executor;
    address[] dstTokens;
    uint256[] intentAmounts;
}
```

### SignatureData

```solidity
/// @notice Structure holding signature data used across validator implementations
///  @dev Contains all components needed for merkle proof verification and signature validation
struct SignatureData {
    uint64[] chainsWithDestinationExecution;
    uint48 validUntil;
    uint48 validAfter;
    bytes32 merkleRoot;
    bytes32[] proofSrc;
    DstProof[] proofDst;
    bytes signature;
}
```

## Errors

### INVALID_SENDER

```solidity
/// @notice Thrown when the sender account has not been initialized
error INVALID_SENDER();
```

### NOT_INITIALIZED

```solidity
error NOT_INITIALIZED();
```

### NOT_IMPLEMENTED

```solidity
error NOT_IMPLEMENTED();
```

### PROOF_NOT_FOUND

```solidity
error PROOF_NOT_FOUND();
```

### INVALID_CHAIN_ID

```solidity
error INVALID_CHAIN_ID();
```

## Events

### AccountOwnerSet

```solidity
event AccountOwnerSet(address indexed account, address indexed owner);
```

### AccountUnset

```solidity
event AccountUnset(address indexed account);
```

## Public/External Functions

### namespace()

- **Signature**: `namespace()`
- **Visibility**: external
- **Source Range**: 3319:59:427

**Signature:**
```solidity
function namespace() external pure returns (string memory);;
```
