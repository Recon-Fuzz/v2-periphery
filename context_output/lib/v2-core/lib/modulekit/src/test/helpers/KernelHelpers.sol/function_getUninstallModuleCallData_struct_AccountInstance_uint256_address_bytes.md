# Function: getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol/contract_KernelHelpers.md]

## Metadata

- **Contract**: KernelHelpers
- **Signature**: `getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 15831:1200:236

## Implementation

```solidity
/// @notice Gets the data to uninstall a module on an account instance
///  @param instance AccountInstance the account instance to uninstall the module from
///  @param moduleType uint256 the type of the module
///  @param module address the address of the module to uninstall
///  @param initData bytes the data to pass to the module
///  @return callData the data to uninstall the module
function getUninstallModuleCallData(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData) virtual override public view returns (bytes memory callData) {
    if (moduleType == MODULE_TYPE_HOOK) {
        Execution[] memory executions = new Execution[](3);
        executions[0] = Execution({target: getHookMultiPlexer(instance), value: 0, callData: abi.encodeCall(MockHookMultiPlexer.removeHook, (module))});
        executions[1] = Execution({target: module, value: 0, callData: abi.encodeCall(IModule.onUninstall, (initData))});
        executions[2] = Execution({target: module, value: 0, callData: abi.encodeCall(TrustedForwarder.clearTrustedForwarder, ())});
        callData = encode({executions: executions});
    } else {
        callData = abi.encodeCall(IERC7579Account.uninstallModule, (moduleType, module, initData));
    }
}
```

## Related Implementations

### getHookMultiPlexer(struct AccountInstance)

- **Kind**: internal
- **Source**: 20760:180:236
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/KernelHelpers.sol:KernelHelpers:getHookMultiPlexer(struct AccountInstance)`

```solidity
/// @notice Gets the hook multiplexer for an account instance
///  @param instance AccountInstance the account instance to get the hook multiplexer for
///  @return address the address of the hook multiplexer
function getHookMultiPlexer(AccountInstance memory instance) public view returns (address) {
    return address(KernelFactory(instance.accountFactory).hookMultiPlexer());
}
```

### encode(struct Execution[])

- **Kind**: internal
- **Source**: 21481:444:235
- **Link**: `lib/v2-core/lib/modulekit/src/test/helpers/HelperBase.sol:HelperBase:encode(struct Execution[])`

```solidity
/// @notice Encode a batch of ERC7579 Execution Transactions
///  @param executions Execution[] the array of executions
///  @return erc7579Tx bytes the encoded ERC7579 transaction
function encode(Execution[] memory executions) virtual public pure returns (bytes memory erc7579Tx) {
    ModeCode mode = ModeLib.encode({callType: CALLTYPE_BATCH, execType: EXECTYPE_DEFAULT, mode: MODE_DEFAULT, payload: ModePayload.wrap(bytes22(0))});
    return abi.encodeCall(IERC7579Account.execute, (mode, abi.encode(executions)));
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: KernelHelpers.getUninstallModuleCallData(struct AccountInstance,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: KernelHelpers.getHookMultiPlexer(struct AccountInstance) (NodeID: 1)
  │   💬 Args: [instance]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: HelperBase.encode(struct Execution[]) (NodeID: 2)
      💬 Args: [executions]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 3)
        💬 Args: [CALLTYPE_BATCH, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Gets the data to uninstall a module on an account instance
 @param instance AccountInstance the account instance to uninstall the module from
 @param moduleType uint256 the type of the module
 @param module address the address of the module to uninstall
 @param initData bytes the data to pass to the module
 @return callData the data to uninstall the module
