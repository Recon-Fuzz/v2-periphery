# Function: add_new_vault()

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `add_new_vault()`
- **Visibility**: public
- **Source Range**: 1605:78:648
- **Inherited From**: ManagersTargets

## Implementation

```solidity
/// @dev Deploy a new vault using the current asset and add it to the list of vaults,
///  then set it as the current vault
function add_new_vault() public {
    _newVault(superVault.asset());
}
```

## Related Implementations

### _newVault(address)

- **Kind**: internal
- **Source**: 3712:132:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_newVault(address)`

```solidity
/// @notice Legacy function name for backward compatibility
///  @param asset The asset to create the yield source for
///  @return The address of the new yield source
function _newVault(address asset) internal returns (address) {
    return _newYieldSource(asset, YieldSourceType.ERC4626);
}
```

### _newYieldSource(address,enum YieldSourceType)

- **Kind**: internal
- **Source**: 2370:808:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_newYieldSource(address,enum YieldSourceType)`

```solidity
/// @notice Creates a new yield source and adds it to the list of yield sources
///  @param asset The asset to create the yield source for
///  @param yieldSourceType The type of yield source to deploy
///  @return The address of the new yield source
function _newYieldSource(address asset, YieldSourceType yieldSourceType) internal returns (address) {
    address yieldSource_;
    if (yieldSourceType == YieldSourceType.ERC4626) {
        yieldSource_ = address(new MockERC4626Tester(asset));
    } else if (yieldSourceType == YieldSourceType.ERC5115) {
        yieldSource_ = address(new MockERC5115Tester(asset));
    } else if (yieldSourceType == YieldSourceType.ERC7540) {
        yieldSource_ = address(new MockERC7540Tester(asset));
    } else {
        revert InvalidYieldSourceType();
    }
    _addYieldSource(yieldSource_);
    __yieldSource = yieldSource_;
    __currentYieldSourceType = yieldSourceType;
    return yieldSource_;
}
```

### _addYieldSource(address)

- **Kind**: internal
- **Source**: 3976:189:635
- **Link**: `test/recon/managers/YieldManager.sol:YieldManager:_addYieldSource(address)`

```solidity
/// @notice Adds a yield source to the list of yield sources
///  @param target The address of the yield source to add
function _addYieldSource(address target) internal {
    if (_yieldSources.contains(target)) {
        revert YieldSourceExists();
    }
    _yieldSources.add(target);
}
```

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8860:165:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 4255:127:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._indexes[value] != 0;
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8305:150:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2214:404:72
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._indexes[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

## External Calls

- **SuperVault::asset()**

## State Variable Reads

- **_yieldSources** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **__yieldSource** (`address`)
- **__currentYieldSourceType** (`enum YieldSourceType`)
- **_yieldSources** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ManagersTargets.add_new_vault() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: YieldManager._newVault(address) (NodeID: 1)
      💬 Args: [superVault.asset()]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: YieldManager._newYieldSource(address,enum YieldSourceType) (NodeID: 2)
        💬 Args: [asset, YieldSourceType.ERC4626]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: YieldManager._addYieldSource(address) (NodeID: 3)
          💬 Args: [yieldSource_]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 4)
        │   💬 Args: [_yieldSources, target]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 5)
        │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
        │     👁️  Def: private
        └─ [4] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 6)
            💬 Args: [_yieldSources, target]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 7)
              💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
              👁️  Def: private
            └─ [6] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 8)
                💬 Args: [set, value]
                👁️  Def: private
```

## Documentation

### Function Documentation

@dev Deploy a new vault using the current asset and add it to the list of vaults,
 then set it as the current vault
