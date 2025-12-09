# Function: lockAsset(bytes32,address,address,address,uint256,uint64)

**Contract**: [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]

## Metadata

- **Contract**: VaultBank
- **Signature**: `lockAsset(bytes32,address,address,address,uint256,uint64)`
- **Visibility**: external
- **Source Range**: 2581:608:552

## Implementation

```solidity
/// @inheritdoc IVaultBank
function lockAsset(bytes32 yieldSourceOracleId, address account, address token, address hookAddress, uint256 amount, uint64 toChainId) external {
    address vaultBank = SUPER_REGISTRY.getVaultBank(toChainId);
    if (vaultBank == address(0)) revert INVALID_VAULT_BANK_ADDRESS();
    if (!SUPER_GOVERNOR.isHookRegistered(hookAddress)) revert INVALID_HOOK();
    uint256 _nonce = nonces[toChainId];
    nonces[toChainId]++;
    _lockAssetForChain(yieldSourceOracleId, account, token, amount, toChainId, _nonce);
}
```

## Related Implementations

### _lockAssetForChain(bytes32,address,address,uint256,uint64,uint256)

- **Kind**: internal
- **Source**: 1878:785:554
- **Link**: `test/draft/src/VaultBank/VaultBankSource.sol:VaultBankSource:_lockAssetForChain(bytes32,address,address,uint256,uint64,uint256)`

```solidity
function _lockAssetForChain(bytes32 yieldSourceOracleId, address account, address token, uint256 amount, uint64 toChainId, uint256 nonce) internal {
    if (amount == 0) revert INVALID_AMOUNT();
    if (token == address(0)) revert INVALID_TOKEN();
    if (account == address(0)) revert INVALID_ACCOUNT();
    if (yieldSourceOracleId == bytes32(0)) revert INVALID_YIELD_SOURCE_ORACLE_ID();
    if (!_lockedAssets.contains(token)) {
        _lockedAssets.add(token);
    }
    _lockedAmounts[token] += amount;
    IERC20(token).safeTransferFrom(account, address(this), amount);
    emit SharesLocked(yieldSourceOracleId, account, token, amount, _chainId, toChainId, nonce);
}
```

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 12370:165:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
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

## External Calls

- **ISuperRegistry::getVaultBank(uint64)**
- **ISuperGovernor::isHookRegistered(address)**

## State Variable Reads

- **SUPER_REGISTRY** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **nonces** (`mapping(uint64 => uint256)`)
- **_lockedAssets** (`struct EnumerableSet.AddressSet`)
- **_chainId** (`uint64`)

## State Variable Writes

- **nonces** (`mapping(uint64 => uint256)`)
- **_lockedAssets** (`struct EnumerableSet.AddressSet`)
- **_lockedAmounts** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBank.lockAsset(bytes32,address,address,address,uint256,uint64) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: VaultBankSource._lockAssetForChain(bytes32,address,address,uint256,uint64,uint256) (NodeID: 1)
      💬 Args: [yieldSourceOracleId, account, token, amount, toChainId, _nonce]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 2)
    │   💬 Args: [_lockedAssets, token]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 3)
    │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │     👁️  Def: private
    └─ [2] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 4)
        💬 Args: [_lockedAssets, token]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 5)
          💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
          👁️  Def: private
        └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 6)
            💬 Args: [set, value]
            👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IVaultBank

### Interface Documentation

@notice Lock an asset for an account
 @dev This function is used to lock an asset for an account
 @param yieldSourceOracleId The yield source oracle ID
 @param account The account to lock the asset for
 @param token The asset to lock
 @param hookAddress The hook address to lock the asset through
 @param amount The amount of the asset to lock
 @param toChainId The destination chain ID
