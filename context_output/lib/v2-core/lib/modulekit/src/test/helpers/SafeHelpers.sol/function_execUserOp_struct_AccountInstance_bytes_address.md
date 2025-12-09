# Function: execUserOp(struct AccountInstance,bytes,address)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `execUserOp(struct AccountInstance,bytes,address)`
- **Visibility**: public
- **Source Range**: 2506:1124:238

## Implementation

```solidity
/// @notice Gets userOp and userOpHash for an executing calldata on an account instance
///  @param instance AccountInstance the account instance to execute the callData on
///  @param callData bytes the calldata to execute
///  @param txValidator address the address of the validator
///  @return userOp PackedUserOperation the user operation
///  @return userOpHash bytes32 the hash of the user operation
function execUserOp(AccountInstance memory instance, bytes memory callData, address txValidator) virtual override public returns (PackedUserOperation memory userOp, bytes32 userOpHash) {
    bytes memory initCode;
    bool notDeployedYet = instance.account.code.length == 0;
    if (notDeployedYet) {
        initCode = instance.initCode;
    }
    if (initCode.length != 0) {
        (initCode, callData) = _getInitCallData(instance.salt, initCode, callData);
    }
    userOp = PackedUserOperation({sender: instance.account, nonce: getNonce(instance, callData, txValidator), initCode: initCode, callData: callData, accountGasLimits: bytes32(abi.encodePacked(uint128(2e6), uint128(2e6))), preVerificationGas: 2e6, gasFees: bytes32(abi.encodePacked(uint128(1), uint128(1))), paymasterAndData: bytes(""), signature: bytes("")});
    userOpHash = instance.aux.entrypoint.getUserOpHash(userOp);
}
```

## Related Implementations

### _getInitCallData(bytes32,bytes,bytes)

- **Kind**: internal
- **Source**: 19200:877:238
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol:SafeHelpers:_getInitCallData(bytes32,bytes,bytes)`

```solidity
/// @notice Gets the initCode and callData for a new account instance
///  @param salt bytes32 the salt for the account instance
///  @param originalInitCode bytes the original initCode for the account instance
///  @param erc4337CallData bytes the callData for the ERC4337 call
function _getInitCallData(bytes32 salt, bytes memory originalInitCode, bytes memory erc4337CallData) public pure returns (bytes memory initCode, bytes memory callData) {
    address factory;
    assembly {
        factory := mload(add(originalInitCode, 20))
    }
    bytes memory initData2 = LibBytes.slice(originalInitCode, 120, originalInitCode.length);
    ISafe7579Launchpad.InitData memory initData = abi.decode(initData2, (ISafe7579Launchpad.InitData));
    initData.callData = erc4337CallData;
    initCode = abi.encodePacked(factory, abi.encodeCall(SafeFactory.createAccount, (salt, abi.encode(initData))));
    callData = abi.encodeCall(ISafe7579Launchpad.setupSafe, (initData));
}
```

### slice(bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 19213:1115:320
- **Link**: `lib/v2-core/lib/solady/src/utils/LibBytes.sol:LibBytes:slice(bytes,uint256,uint256)`

```solidity
/// @dev Returns a copy of `subject` sliced from `start` to `end` (exclusive).
///  `start` and `end` are byte offsets.
function slice(bytes memory subject, uint256 start, uint256 end) internal pure returns (bytes memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        let l := mload(subject)
        if iszero(gt(l, end)) {
            end := l
        }
        if iszero(gt(l, start)) {
            start := l
        }
        if lt(start, end) {
            result := mload(0x40)
            let n := sub(end, start)
            let i := add(subject, start)
            let w := not(0x1f)
            for {
                let j := and(add(n, 0x1f), w)
            } 1 {} {
                mstore(add(result, j), mload(add(i, j)))
                j := add(j, w)
                if iszero(j) {
                    break
                }
            }
            let o := add(add(result, 0x20), n)
            mstore(o, 0)
            mstore(0x40, add(o, 0x20))
            mstore(result, n)
        }
    }
}
```

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
┌─ [0] ⚙️ FUNCTION: SafeHelpers.execUserOp(struct AccountInstance,bytes,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers._getInitCallData(bytes32,bytes,bytes) (NodeID: 1)
  │   💬 Args: [instance.salt, initCode, callData]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: LibBytes.slice(bytes,uint256,uint256) (NodeID: 2)
  │     💬 Args: [originalInitCode, 120, originalInitCode.length]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: HelperBase.getNonce(struct AccountInstance,bytes,address) (NodeID: 3)
      💬 Args: [instance, callData, txValidator]
      👁️  Def: public
```

## Documentation

### Function Documentation

@notice Gets userOp and userOpHash for an executing calldata on an account instance
 @param instance AccountInstance the account instance to execute the callData on
 @param callData bytes the calldata to execute
 @param txValidator address the address of the validator
 @return userOp PackedUserOperation the user operation
 @return userOpHash bytes32 the hash of the user operation
