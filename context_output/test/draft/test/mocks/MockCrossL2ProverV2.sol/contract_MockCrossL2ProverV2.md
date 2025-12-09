# Contract: MockCrossL2ProverV2

## Metadata

- **Name**: MockCrossL2ProverV2
- **Type**: Contract
- **Path**: test/draft/test/mocks/MockCrossL2ProverV2.sol
- **Documentation**: @notice Mock implementation of CrossL2ProverV2 for testing

## State Variables

### _chainId

```solidity
uint32 private _chainId
```

### _emittingContract

```solidity
address private _emittingContract
```

### _topics

```solidity
bytes private _topics
```

### _unindexedData

```solidity
bytes private _unindexedData
```

## Public/External Functions

### setValidateEventReturn(uint32,address,bytes,bytes)

- **Signature**: `setValidateEventReturn(uint32,address,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 454:337:567
- **Details**: [function_setValidateEventReturn_uint32_address_bytes_bytes.md](./function_setValidateEventReturn_uint32_address_bytes_bytes.md)

**Signature:**
```solidity
function setValidateEventReturn(uint32 chainId_, address emittingContract_, bytes memory topics_, bytes memory unindexedData_) external;
```

### setEmittingContract(address)

- **Signature**: `setEmittingContract(address)`
- **Visibility**: external
- **Source Range**: 797:119:567
- **Details**: [function_setEmittingContract_address.md](./function_setEmittingContract_address.md)

**Signature:**
```solidity
function setEmittingContract(address emittingContract_) external;
```

### validateEvent(bytes)

- **Signature**: `validateEvent(bytes)`
- **Visibility**: external
- **Source Range**: 922:283:567
- **Details**: [function_validateEvent_bytes.md](./function_validateEvent_bytes.md)

**Signature:**
```solidity
function validateEvent(bytes calldata) external view returns (uint32 chainId, address emittingContract, bytes memory topics, bytes memory unindexedData);
```

### inspectLogIdentifier(bytes)

- **Signature**: `inspectLogIdentifier(bytes)`
- **Visibility**: external
- **Source Range**: 1211:231:567
- **Details**: [function_inspectLogIdentifier_bytes.md](./function_inspectLogIdentifier_bytes.md)

**Signature:**
```solidity
function inspectLogIdentifier(bytes calldata) external pure returns (uint32 srcChain, uint64 blockNumber, uint16 receiptIndex, uint8 logIndex);
```

### mockSuperpositionsBurnedEvent(address,address,uint256,uint64,uint256,uint32,bytes32)

- **Signature**: `mockSuperpositionsBurnedEvent(address,address,uint256,uint64,uint256,uint32,bytes32)`
- **Visibility**: external
- **Source Range**: 1448:1356:567
- **Details**: [function_mockSuperpositionsBurnedEvent_address_address_uint256_uint64_uint256_uint32_bytes32.md](./function_mockSuperpositionsBurnedEvent_address_address_uint256_uint64_uint256_uint32_bytes32.md)

**Signature:**
```solidity
function mockSuperpositionsBurnedEvent(address account, address token, uint256 amount, uint64 targetChainId, uint256 nonce, uint32 chainId_, bytes32 yieldSourceOracleId) external;
```

### inspectPolymerState(bytes)

- **Signature**: `inspectPolymerState(bytes)`
- **Visibility**: external
- **Source Range**: 2979:450:567
- **Details**: [function_inspectPolymerState_bytes.md](./function_inspectPolymerState_bytes.md)

**Signature:**
```solidity
/// @notice Mock implementation of inspectPolymerState - returns dummy values
///  @dev This implementation is required to satisfy the ICrossL2ProverV2 interface
function inspectPolymerState(bytes calldata) external view returns (bytes32 stateRoot, uint64 height, bytes memory signature);
```
