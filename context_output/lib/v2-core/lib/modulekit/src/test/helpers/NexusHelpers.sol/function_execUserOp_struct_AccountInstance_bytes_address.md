# Function: execUserOp(struct AccountInstance,bytes,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol/contract_NexusHelpers.md]

## Metadata

- **Contract**: NexusHelpers
- **Signature**: `execUserOp(struct AccountInstance,bytes,address)`
- **Visibility**: public
- **Source Range**: 1249:982:237

## Implementation

```solidity
/// @notice Gets userOp and userOpHash for an executing calldata on an account instance
///  @param instance AccountInstance the account instance to execute the callData on
///  @param callData bytes the calldata to execute
///  @param txValidator address the address of the validator
///  @return userOp PackedUserOperation the user operation
///  @return userOpHash bytes32 the hash of the user operation
function execUserOp(AccountInstance memory instance, bytes memory callData, address txValidator) override public view returns (PackedUserOperation memory userOp, bytes32 userOpHash) {
    bytes memory initCode;
    bool notDeployedYet = instance.account.code.length == 0;
    if (notDeployedYet) {
        initCode = instance.initCode;
    }
    userOp = PackedUserOperation({sender: instance.account, nonce: getNonce(instance, 0x00, txValidator), initCode: initCode, callData: callData, accountGasLimits: bytes32(abi.encodePacked(uint128(2e6), uint128(2e6))), preVerificationGas: 2e6, gasFees: bytes32(abi.encodePacked(uint128(1), uint128(1))), paymasterAndData: bytes(""), signature: bytes("")});
    userOpHash = instance.aux.entrypoint.getUserOpHash(userOp);
}
```

## Related Implementations

### getNonce(struct AccountInstance,bytes1,address)

- **Kind**: internal
- **Source**: 2708:323:237
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol:NexusHelpers:getNonce(struct AccountInstance,bytes1,address)`

```solidity
/// @notice Gets the nonce for an account instance
///  @param instance AccountInstance the account instance to get the nonce for
///  @param vMode bytes1 the mode of the validator
///  @param validator address the address of the validator
///  @return nonce uint256 the nonce
function getNonce(AccountInstance memory instance, bytes1 vMode, address validator) internal view returns (uint256 nonce) {
    uint192 key = makeNonceKey(vMode, validator);
    nonce = instance.aux.entrypoint.getNonce(address(instance.account), key);
}
```

### makeNonceKey(bytes1,address)

- **Kind**: internal
- **Source**: 3211:232:237
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol:NexusHelpers:makeNonceKey(bytes1,address)`

```solidity
/// @notice Makes a nonce key for an account instance
///  @param vMode bytes1 the mode of the validator
///  @param validator address the address of the validator
function makeNonceKey(bytes1 vMode, address validator) internal pure returns (uint192 key) {
    assembly {
        key := or(shr(88, vMode), validator)
    }
}
```

## External Calls

- **IEntryPoint::getUserOpHash(struct PackedUserOperation)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: NexusHelpers.execUserOp(struct AccountInstance,bytes,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: NexusHelpers.getNonce(struct AccountInstance,bytes1,address) (NodeID: 1)
      💬 Args: [instance, 0x00, txValidator]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: NexusHelpers.makeNonceKey(bytes1,address) (NodeID: 2)
        💬 Args: [vMode, validator]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Gets userOp and userOpHash for an executing calldata on an account instance
 @param instance AccountInstance the account instance to execute the callData on
 @param callData bytes the calldata to execute
 @param txValidator address the address of the validator
 @return userOp PackedUserOperation the user operation
 @return userOpHash bytes32 the hash of the user operation
