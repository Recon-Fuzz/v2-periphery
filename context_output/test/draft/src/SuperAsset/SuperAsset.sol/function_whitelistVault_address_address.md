# Function: whitelistVault(address,address)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `whitelistVault(address,address)`
- **Visibility**: external
- **Source Range**: 6071:562:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function whitelistVault(address vault, address yieldSourceOracle) external {
    _onlyManager();
    if ((vault == address(0)) || (yieldSourceOracle == address(0))) revert ZERO_ADDRESS();
    if (tokenData[vault].isSupportedUnderlyingVault) revert ALREADY_WHITELISTED();
    tokenData[vault].isSupportedUnderlyingVault = true;
    tokenData[vault].isActive = true;
    tokenData[vault].oracle = yieldSourceOracle;
    _supportedAssets.add(vault);
    emit VaultWhitelisted(vault);
}
```

## Related Implementations

### _onlyManager()

- **Kind**: internal
- **Source**: 42332:139:548
- **Link**: `test/draft/src/SuperAsset/SuperAsset.sol:SuperAsset:_onlyManager()`

```solidity
function _onlyManager() internal view {
    if (msg.sender != factory.getSuperAssetManager(address(this))) revert UNAUTHORIZED();
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 11418:150:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

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
- **Source**: 2497:406:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._positions[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 5101:129:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._positions[value] != 0;
}
```

## State Variable Reads

- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)
- **factory** (`contract ISuperAssetFactory`) [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]

## State Variable Writes

- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)
- **_supportedAssets** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.whitelistVault(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperAsset._onlyManager() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 2)
      💬 Args: [_supportedAssets, vault]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 3)
        💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 4)
          💬 Args: [set, value]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Whitelists a vault
 @param vault Address of the vault to whitelist
 @param oracle Address of the oracle to use to fetch vault prices
