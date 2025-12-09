# Contract: ERC4337Helpers

## Metadata

- **Name**: ERC4337Helpers
- **Type**: Contract
- **Path**: lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol
- **Documentation**: @notice A library that contains helper functions for ERC-4337 operations

## Structs

### ExecutionContext

```solidity
struct ExecutionContext {
    uint256 isExpectRevert;
    address payable beneficiary;
    bytes userOpCalldata;
    bool success;
    bytes returnData;
}
```

## Errors

### UserOperationReverted

```solidity
error UserOperationReverted(bytes32 userOpHash, address sender, string senderLabel, uint256 nonce, bytes revertReason);
```

### InvalidRevertMessage

```solidity
error InvalidRevertMessage(bytes4 expected, bytes4 reason);
```

### InvalidRevertMessageBytes

```solidity
error InvalidRevertMessageBytes(bytes expected, bytes reason);
```
