# Function: deployAccount(struct AccountInstance)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `deployAccount(struct AccountInstance)`
- **Visibility**: public
- **Source Range**: 16557:2137:238

## Implementation

```solidity
/// @notice Deploys an account instance if it has not been deployed yet
///          reverts if no initCode is provided
///  @param instance AccountInstance the account instance to deploy
function deployAccount(AccountInstance memory instance) virtual override public {
    if (instance.account.code.length == 0) {
        if (instance.initCode.length == 0) {
            revert("deployAccount: no initCode provided");
        } else {
            (bytes memory initCode, bytes memory callData) = _getInitCallData(instance.salt, instance.initCode, encode({target: address(0), value: 0 wei, callData: ""}));
            assembly {
                let factory := mload(add(initCode, 20))
                let success := call(gas(), factory, 0, add(initCode, 52), mload(initCode), 0, 0)
                if iszero(success) {
                    revert(0, 0)
                }
            }
            PackedUserOperation memory userOp = PackedUserOperation({sender: instance.account, nonce: getNonce(instance, callData, address(instance.defaultValidator)), initCode: "", callData: callData, accountGasLimits: bytes32(abi.encodePacked(uint128(2e6), uint128(2e6))), preVerificationGas: 2e6, gasFees: bytes32(abi.encodePacked(uint128(1), uint128(1))), paymasterAndData: bytes(""), signature: bytes("")});
            bytes32 userOpHash = instance.aux.entrypoint.getUserOpHash(userOp);
            bytes memory userOpValidationCallData = abi.encodeCall(ISafe7579Launchpad.validateUserOp, (userOp, userOpHash, 0));
            startPrank(address(instance.aux.entrypoint));
            (bool success, ) = instance.account.call(userOpValidationCallData);
            if (!success) {
                revert("deployAccount: failed to call account");
            }
            (success, ) = instance.account.call(callData);
            if (!success) {
                revert("deployAccount: failed to call account");
            }
            stopPrank();
        }
    }
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

### encode(address,uint256,bytes)

- **Kind**: internal
- **Source**: 20733:551:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:encode(address,uint256,bytes)`

```solidity
/// @notice Encode a single ERC7579 Execution Transaction
///  @param target address the target
///  @param value uint256 the value
///  @param callData bytes the callData of the call
///  @return erc7579Tx bytes the encoded ERC7579 transaction
function encode(address target, uint256 value, bytes memory callData) virtual public pure returns (bytes memory erc7579Tx) {
    ModeCode mode = ModeLib.encode({callType: CALLTYPE_SINGLE, execType: EXECTYPE_DEFAULT, mode: MODE_DEFAULT, payload: ModePayload.wrap(bytes22(0))});
    bytes memory data = abi.encodePacked(target, value, callData);
    return abi.encodeCall(IERC7579Account.execute, (mode, data));
}
```

### encode(CallType,ExecType,ModeSelector,ModePayload)

- **Kind**: internal
- **Source**: 4337:376:150
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/common/lib/ModeLib.sol:ModeLib:encode(CallType,ExecType,ModeSelector,ModePayload)`

```solidity
function encode(CallType callType, ExecType execType, ModeSelector mode, ModePayload payload) internal pure returns (ModeCode) {
    return ModeCode.wrap(bytes32(abi.encodePacked(callType, execType, bytes4(0), ModeSelector.unwrap(mode), payload)));
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

### startPrank(address)

- **Kind**: free-function
- **Source**: 1684:73:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:startPrank(address)`

```solidity
function startPrank(address _addr) {
    Vm(VM_ADDR).startPrank(_addr);
}
```

### stopPrank()

- **Kind**: free-function
- **Source**: 1759:53:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:stopPrank()`

```solidity
function stopPrank() {
    Vm(VM_ADDR).stopPrank();
}
```

## External Calls

- **IEntryPoint::getUserOpHash(struct PackedUserOperation)**
- **address::call(bytes memory)**

## Native Transfers

- **unknown** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeHelpers.deployAccount(struct AccountInstance) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SafeHelpers._getInitCallData(bytes32,bytes,bytes) (NodeID: 1)
  │   💬 Args: [instance.salt, instance.initCode, encode({target: address(0), value: 0 wei, callData: ""})]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: HelperBase.encode(address,uint256,bytes) (NodeID: 3)
  │ │   💬 Args: [address(0), 0 wei, ""]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 4)
  │ │     💬 Args: [CALLTYPE_SINGLE, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: LibBytes.slice(bytes,uint256,uint256) (NodeID: 2)
  │     💬 Args: [originalInitCode, 120, originalInitCode.length]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: HelperBase.getNonce(struct AccountInstance,bytes,address) (NodeID: 5)
  │   💬 Args: [instance, callData, address(instance.defaultValidator)]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Unknown.startPrank(address) (NodeID: 6)
  │   💬 Args: [address(instance.aux.entrypoint)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Unknown.stopPrank() (NodeID: 7)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Deploys an account instance if it has not been deployed yet
         reverts if no initCode is provided
 @param instance AccountInstance the account instance to deploy
