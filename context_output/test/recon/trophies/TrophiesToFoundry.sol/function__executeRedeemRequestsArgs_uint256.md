# Function: _executeRedeemRequestsArgs(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `_executeRedeemRequestsArgs(uint256)`
- **Visibility**: public
- **Source Range**: 17167:3147:647
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Helper function to clamp the values for the function call
function _executeRedeemRequestsArgs(uint256 redeemAmount) public view returns (ISuperVaultStrategy.ExecuteArgs memory executeArgs, address[] memory controllers) {
    address selectedController = _getActor();
    uint256 pendingAmount = superVaultStrategy.pendingRedeemRequest(selectedController);
    uint256 actualRedeemAmount = redeemAmount % (pendingAmount + 1);
    controllers = new address[](1);
    controllers[0] = selectedController;
    YieldSourceType activeYieldSourceType = _getYieldSourceTypeFromAddress(_getYieldSource());
    address redeemHook = _getRedeemHookForType(activeYieldSourceType);
    bytes memory redeemHookCalldata;
    if ((activeYieldSourceType == YieldSourceType.ERC4626) || (activeYieldSourceType == YieldSourceType.ERC5115)) {
        redeemHookCalldata = abi.encodePacked(bytes32(0), _getYieldSource(), address(superVaultStrategy), actualRedeemAmount, false);
    } else {
        redeemHookCalldata = abi.encodePacked(bytes32(0), _getYieldSource(), actualRedeemAmount, false);
    }
    address[] memory hooks = new address[](1);
    hooks[0] = redeemHook;
    bytes[] memory hookCalldata = new bytes[](1);
    hookCalldata[0] = redeemHookCalldata;
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
    expectedAssetsOrSharesOut[0] = actualRedeemAmount;
    bytes32[][] memory globalProofs = new bytes32[][](1);
    globalProofs[0] = new bytes32[](0);
    bytes32[][] memory strategyProofs = new bytes32[][](1);
    strategyProofs[0] = new bytes32[](0);
    executeArgs = ISuperVaultStrategy.ExecuteArgs({hooks: hooks, hookCalldata: hookCalldata, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: globalProofs, strategyProofs: strategyProofs});
}
```

## Related Implementations

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

### _getYieldSourceTypeFromAddress(address)

- **Kind**: internal
- **Source**: 16819:836:631
- **Link**: `test/recon/Setup.sol:Setup:_getYieldSourceTypeFromAddress(address)`

```solidity
/// @dev Helper function to determine yield source type from address
function _getYieldSourceTypeFromAddress(address yieldSource) internal view returns (YieldSourceType) {
    address[] memory yieldSources = _getYieldSources();
    for (uint256 i = 0; i < yieldSources.length; i++) {
        if (yieldSources[i] == yieldSource) {
            if (i == 0) return YieldSourceType.ERC4626;
            if (i == 1) return YieldSourceType.ERC5115;
            if (i == 2) return YieldSourceType.ERC7540;
        }
    }
    return YieldSourceType.ERC4626;
}
```

### _getYieldSource()

- **Kind**: internal
- **Source**: 1548:192:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_getYieldSource()`

```solidity
/// @notice Returns the current active yield source
function _getYieldSource() internal view returns (address) {
    if (__yieldSource == address(0)) {
        revert YieldSourceNotSetup();
    }
    return __yieldSource;
}
```

### _getYieldSources()

- **Kind**: internal
- **Source**: 1799:115:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_getYieldSources()`

```solidity
/// @notice Returns all yield sources being used
function _getYieldSources() internal view returns (address[] memory) {
    return _yieldSources.values();
}
```

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 10259:300:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    /// @solidity memory-safe-assembly
    assembly {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5570:109:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function _values(Set storage set) private view returns (bytes32[] memory) {
    return set._values;
}
```

### _getRedeemHookForType(enum YieldSourceType)

- **Kind**: internal
- **Source**: 15868:440:631
- **Link**: `test/recon/Setup.sol:Setup:_getRedeemHookForType(enum YieldSourceType)`

```solidity
function _getRedeemHookForType(YieldSourceType sourceType) internal view returns (address) {
    if (sourceType == YieldSourceType.ERC4626) {
        return address(redeem4626Hook);
    } else if (sourceType == YieldSourceType.ERC5115) {
        return address(redeem5115Hook);
    } else if (sourceType == YieldSourceType.ERC7540) {
        return address(redeem7540Hook);
    }
    return address(0);
}
```

## External Calls

- **SuperVaultStrategy::pendingRedeemRequest(address)**

## State Variable Reads

- **_actor** (`address`)
- **__yieldSource** (`address`)
- **_yieldSources** (`struct EnumerableSet.AddressSet`)
- **redeem4626Hook** (`contract Redeem4626VaultHook`) [lib/v2-core/src/hooks/vaults/4626/Redeem4626VaultHook.sol/contract_Redeem4626VaultHook.md]
- **redeem5115Hook** (`contract Redeem5115VaultHook`) [lib/v2-core/src/hooks/vaults/5115/Redeem5115VaultHook.sol/contract_Redeem5115VaultHook.md]
- **redeem7540Hook** (`contract Redeem7540VaultHook`) [lib/v2-core/src/hooks/vaults/7540/Redeem7540VaultHook.sol/contract_Redeem7540VaultHook.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets._executeRedeemRequestsArgs(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Setup._getYieldSourceTypeFromAddress(address) (NodeID: 2)
  │   💬 Args: [_getYieldSource()]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 6)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: YieldManager._getYieldSources() (NodeID: 3)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 4)
  │       💬 Args: [_yieldSources]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 5)
  │         💬 Args: [set._inner]
  │         👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: Setup._getRedeemHookForType(enum YieldSourceType) (NodeID: 7)
  │   💬 Args: [activeYieldSourceType]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 8)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: YieldManager._getYieldSource() (NodeID: 9)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Helper function to clamp the values for the function call
