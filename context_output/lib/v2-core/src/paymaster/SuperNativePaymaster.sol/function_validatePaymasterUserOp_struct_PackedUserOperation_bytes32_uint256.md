# Function: validatePaymasterUserOp(struct PackedUserOperation,bytes32,uint256)

**Contract**: [lib/v2-core/src/paymaster/SuperNativePaymaster.sol/contract_SuperNativePaymaster.md]

## Metadata

- **Contract**: SuperNativePaymaster
- **Signature**: `validatePaymasterUserOp(struct PackedUserOperation,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 1781:349:442
- **Inherited From**: BasePaymaster

## Implementation

```solidity
/// @inheritdoc IPaymaster
function validatePaymasterUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash, uint256 maxCost) override external returns (bytes memory context, uint256 validationData) {
    _requireFromEntryPoint();
    return _validatePaymasterUserOp(userOp, userOpHash, maxCost);
}
```

## Related Implementations

### _requireFromEntryPoint()

- **Kind**: internal
- **Source**: 4603:135:442
- **Link**: `lib/v2-core/src/vendor/account-abstraction/BasePaymaster.sol:BasePaymaster:_requireFromEntryPoint()`

```solidity
///  Validate the call is made from a valid entrypoint
function _requireFromEntryPoint() virtual internal {
    require(msg.sender == address(entryPoint), "Sender not EntryPoint");
}
```

### _validatePaymasterUserOp(struct PackedUserOperation,bytes32,uint256)

- **Kind**: internal
- **Source**: 5365:853:436
- **Link**: `lib/v2-core/src/paymaster/SuperNativePaymaster.sol:SuperNativePaymaster:_validatePaymasterUserOp(struct PackedUserOperation,bytes32,uint256)`

```solidity
function _validatePaymasterUserOp(PackedUserOperation calldata userOp, bytes32, uint256) virtual override internal returns (bytes memory context, uint256 validationData) {
    (uint256 maxGasLimit, uint256 nodeOperatorPremium, uint256 postOpGas) = abi.decode(userOp.paymasterAndData[PAYMASTER_DATA_OFFSET:], (uint256, uint256, uint256));
    if (nodeOperatorPremium > MAX_NODE_OPERATOR_PREMIUM) {
        revert INVALID_NODE_OPERATOR_PREMIUM();
    }
    return (abi.encode(userOp.sender, userOp.unpackMaxFeePerGas(), userOp.unpackMaxPriorityFeePerGas(), maxGasLimit, nodeOperatorPremium, postOpGas), 0);
}
```

### unpackMaxFeePerGas(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 3873:149:443
- **Link**: `lib/v2-core/src/vendor/account-abstraction/UserOperationLib.sol:UserOperationLib:unpackMaxFeePerGas(struct PackedUserOperation)`

```solidity
function unpackMaxFeePerGas(PackedUserOperation calldata userOp) internal pure returns (uint256) {
    return unpackLow128(userOp.gasFees);
}
```

### unpackLow128(bytes32)

- **Kind**: internal
- **Source**: 3585:118:443
- **Link**: `lib/v2-core/src/vendor/account-abstraction/UserOperationLib.sol:UserOperationLib:unpackLow128(bytes32)`

```solidity
function unpackLow128(bytes32 packed) internal pure returns (uint256) {
    return uint128(uint256(packed));
}
```

### unpackMaxPriorityFeePerGas(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 3709:158:443
- **Link**: `lib/v2-core/src/vendor/account-abstraction/UserOperationLib.sol:UserOperationLib:unpackMaxPriorityFeePerGas(struct PackedUserOperation)`

```solidity
function unpackMaxPriorityFeePerGas(PackedUserOperation calldata userOp) internal pure returns (uint256) {
    return unpackHigh128(userOp.gasFees);
}
```

### unpackHigh128(bytes32)

- **Kind**: internal
- **Source**: 3406:117:443
- **Link**: `lib/v2-core/src/vendor/account-abstraction/UserOperationLib.sol:UserOperationLib:unpackHigh128(bytes32)`

```solidity
function unpackHigh128(bytes32 packed) internal pure returns (uint256) {
    return uint256(packed) >> 128;
}
```

## State Variable Reads

- **entryPoint** (`contract IEntryPoint`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IEntryPoint.sol/interface_IEntryPoint.md]
- **MAX_NODE_OPERATOR_PREMIUM** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasePaymaster.validatePaymasterUserOp(struct PackedUserOperation,bytes32,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BasePaymaster._requireFromEntryPoint() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperNativePaymaster._validatePaymasterUserOp(struct PackedUserOperation,bytes32,uint256) (NodeID: 2)
      💬 Args: [userOp, userOpHash, maxCost]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: UserOperationLib.unpackMaxFeePerGas(struct PackedUserOperation) (NodeID: 3)
    │   💬 Args: [userOp]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: UserOperationLib.unpackLow128(bytes32) (NodeID: 4)
    │     💬 Args: [userOp.gasFees]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: UserOperationLib.unpackMaxPriorityFeePerGas(struct PackedUserOperation) (NodeID: 5)
        💬 Args: [userOp]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: UserOperationLib.unpackHigh128(bytes32) (NodeID: 6)
          💬 Args: [userOp.gasFees]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IPaymaster

### Interface Documentation

 Payment validation: check if paymaster agrees to pay.
 Must verify sender is the entryPoint.
 Revert to reject this request.
 Note that bundlers will reject this method if it changes the state, unless the paymaster is trusted (whitelisted).
 The paymaster pre-pays using its deposit, and receive back a refund after the postOp method returns.
 @param userOp          - The user operation.
 @param userOpHash      - Hash of the user's request data.
 @param maxCost         - The maximum cost of this transaction (based on maximum gas and gas price from userOp).
 @return context        - Value to send to a postOp. Zero length to signify postOp is not required.
 @return validationData - Signature and time-range of this operation, encoded the same as the return
                          value of validateUserOperation.
                          <20-byte> sigAuthorizer - 0 for valid signature, 1 to mark signature failure,
                                                    other values are invalid for paymaster.
                          <6-byte> validUntil - last timestamp this operation is valid. 0 for "indefinite"
                          <6-byte> validAfter - first timestamp this operation is valid
                          Note that the validation code cannot use block.timestamp (or block.number) directly.
