# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/claim/gearbox/GearboxClaimRewardHook.sol/contract_GearboxClaimRewardHook.md]

## Metadata

- **Contract**: GearboxClaimRewardHook
- **Signature**: `build(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 5451:1084:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @dev Standard build pattern - MUST include preExecute first, postExecute last
///  @inheritdoc ISuperHook
function build(address prevHook, address account, bytes calldata hookData) virtual external view returns (Execution[] memory executions) {
    Execution[] memory hookExecutions = _buildHookExecutions(prevHook, account, hookData);
    executions = new Execution[](hookExecutions.length + 2);
    executions[0] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.preExecute, (prevHook, account, hookData))});
    for (uint256 i = 0; i < hookExecutions.length; i++) {
        executions[i + 1] = hookExecutions[i];
    }
    executions[executions.length - 1] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.postExecute, (prevHook, account, hookData))});
}
```

## Related Implementations

### _buildHookExecutions(address,address,bytes)

- **Kind**: internal
- **Source**: 1603:413:372
- **Link**: `lib/v2-core/src/hooks/claim/gearbox/GearboxClaimRewardHook.sol:GearboxClaimRewardHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address, address, bytes calldata data) override internal pure returns (Execution[] memory executions) {
    address farmingPool = data.extractYieldSource();
    if (farmingPool == address(0)) revert ADDRESS_NOT_VALID();
    return _build(farmingPool, abi.encodeCall(IGearboxFarmingPool.claim, ()));
}
```

### extractYieldSource(bytes)

- **Kind**: internal
- **Source**: 396:131:432
- **Link**: `lib/v2-core/src/libraries/HookDataDecoder.sol:HookDataDecoder:extractYieldSource(bytes)`

```solidity
function extractYieldSource(bytes memory data) internal pure returns (address) {
    return BytesLib.toAddress(data, 32);
}
```

### toAddress(bytes,uint256)

- **Kind**: internal
- **Source**: 12130:354:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toAddress(bytes,uint256)`

```solidity
function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
    require(_bytes.length >= (_start + 20), "toAddress_outOfBounds");
    address tempAddress;
    assembly {
        tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }
    return tempAddress;
}
```

### _build(address,bytes)

- **Kind**: internal
- **Source**: 676:250:370
- **Link**: `lib/v2-core/src/hooks/claim/BaseClaimRewardHook.sol:BaseClaimRewardHook:_build(address,bytes)`

```solidity
function _build(address yieldSource, bytes memory encoded) internal pure returns (Execution[] memory executions) {
    executions = new Execution[](1);
    executions[0] = Execution({target: yieldSource, value: 0, callData: encoded});
}
```

## External Calls

- **ISuperHookResult::getOutAmount(address)**
- **IAcrossSpokePoolV3::wrappedNativeToken()**
- **ISuperSignatureStorage::retrieveSignatureData(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: GearboxClaimRewardHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: HookDataDecoder.extractYieldSource(bytes) (NodeID: 2)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │     💬 Args: [data, 32]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseClaimRewardHook._build(address,bytes) (NodeID: 4)
        💬 Args: [farmingPool, abi.encodeCall(IGearboxFarmingPool.claim, ())]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Standard build pattern - MUST include preExecute first, postExecute last
 @inheritdoc ISuperHook

### Interface Documentation

@notice Builds the execution array for the hook operation
 @dev This is the core method where hooks define their on-chain interactions
      The returned executions are a sequence of contract calls to perform
      No state changes should occur in this method
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account to perform executions for (usually an ERC7579 account)
 @param data The hook-specific parameters and configuration data
 @return executions Array of Execution structs defining calls to make
