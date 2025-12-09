# Function: execUserOp(struct AccountInstance,bytes,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `execUserOp(struct AccountInstance,bytes,address)`
- **Visibility**: public
- **Source Range**: 1766:972:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice Gets userOp and userOpHash for an executing calldata on an account instance
///  @param instance AccountInstance the account instance to execute the userop for
///  @param callData bytes the calldata to execute
///  @param txValidator address the address of the validator
///  @return userOp PackedUserOperation the packed user operation
///  @return userOpHash bytes32 the hash of the user operation
function execUserOp(AccountInstance memory instance, bytes memory callData, address txValidator) virtual public returns (PackedUserOperation memory userOp, bytes32 userOpHash) {
    bytes memory initCode;
    bool notDeployedYet = instance.account.code.length == 0;
    if (notDeployedYet) {
        initCode = instance.initCode;
    }
    userOp = PackedUserOperation({sender: instance.account, nonce: getNonce(instance, callData, txValidator), initCode: initCode, callData: callData, accountGasLimits: bytes32(abi.encodePacked(uint128(2e6), uint128(2e6))), preVerificationGas: 2e6, gasFees: bytes32(abi.encodePacked(uint128(1), uint128(1))), paymasterAndData: bytes(""), signature: bytes("")});
    userOpHash = instance.aux.entrypoint.getUserOpHash(userOp);
}
```

## Related Implementations

### getNonce(struct AccountInstance,bytes,address)

- **Kind**: internal
- **Source**: 23309:343:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:getNonce(struct AccountInstance,bytes,address)`

```solidity
/// @notice Get the nonce for an account instance
///  @param instance AccountInstance the account instance to get the nonce for
///  @param txValidator address the address of the validator
///  @return nonce uint256 the nonce
function getNonce(AccountInstance memory instance, bytes memory, address txValidator) virtual public returns (uint256 nonce) {
    uint192 key = uint192(bytes24(bytes20(address(txValidator))));
    nonce = instance.aux.entrypoint.getNonce(address(instance.account), key);
}
```

## External Calls

- **IEntryPoint::getUserOpHash(struct PackedUserOperation)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.execUserOp(struct AccountInstance,bytes,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: HelperBase.getNonce(struct AccountInstance,bytes,address) (NodeID: 1)
      💬 Args: [instance, callData, txValidator]
      👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets userOp and userOpHash for an executing calldata on an account instance
 @param instance AccountInstance the account instance to execute the userop for
 @param callData bytes the calldata to execute
 @param txValidator address the address of the validator
 @return userOp PackedUserOperation the packed user operation
 @return userOpHash bytes32 the hash of the user operation
