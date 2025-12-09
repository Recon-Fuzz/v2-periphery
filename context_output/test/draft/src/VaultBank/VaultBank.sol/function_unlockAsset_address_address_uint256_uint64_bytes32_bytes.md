# Function: unlockAsset(address,address,uint256,uint64,bytes32,bytes)

**Contract**: [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]

## Metadata

- **Contract**: VaultBank
- **Signature**: `unlockAsset(address,address,uint256,uint64,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 3226:611:552

## Implementation

```solidity
/// @inheritdoc IVaultBank
function unlockAsset(address account, address token, uint256 amount, uint64 fromChainId, bytes32 yieldSourceOracleId, bytes calldata proof) external {
    _validateUnlockAssetProof(account, yieldSourceOracleId, token, amount, fromChainId, proof);
    uint256 _nonce = nonces[uint64(_chainId)];
    nonces[uint64(_chainId)]++;
    _releaseAssetFromChain(yieldSourceOracleId, account, token, amount, fromChainId, _nonce);
}
```

## Related Implementations

### _validateUnlockAssetProof(address,bytes32,address,uint256,uint64,bytes)

- **Kind**: internal
- **Source**: 9860:789:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_validateUnlockAssetProof(address,bytes32,address,uint256,uint64,bytes)`

```solidity
function _validateUnlockAssetProof(address account, bytes32 yieldSourceOracleId, address token, uint256 amount, uint64 fromChainId, bytes calldata proof) internal {
    (uint32 chainId, address emittingContract, bytes memory topics, bytes memory unindexedData) = ICrossL2ProverV2(SUPER_REGISTRY.getProver()).validateEvent(proof);
    if (uint64(chainId) != fromChainId) revert INVALID_PROOF_CHAIN();
    address vaultBank = SUPER_REGISTRY.getVaultBank(uint64(fromChainId));
    if (emittingContract != vaultBank) revert INVALID_PROOF_EMITTER();
    _validateUnlockTopics(account, yieldSourceOracleId, token, topics);
    _validateUnlockData(amount, fromChainId, unindexedData);
}
```

### _validateUnlockTopics(address,bytes32,address,bytes)

- **Kind**: internal
- **Source**: 10655:753:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_validateUnlockTopics(address,bytes32,address,bytes)`

```solidity
function _validateUnlockTopics(address account, bytes32 yieldSourceOracleId, address token, bytes memory topics) private pure {
    if (topics.toBytes32(0) != IVaultBank.SuperpositionsBurned.selector) revert INVALID_PROOF_EVENT();
    if (topics.toBytes32(32) != yieldSourceOracleId) revert INVALID_PROOF_YIELD_SOURCE_ORACLE_ID();
    if (topics.toBytes32(64) != bytes32(uint256(uint160(account)))) revert INVALID_PROOF_ACCOUNT();
    if (topics.toBytes32(96) != keccak256(abi.encodePacked(token))) revert INVALID_PROOF_TOKEN();
}
```

### toBytes32(bytes,uint256)

- **Kind**: internal
- **Source**: 14840:320:573
- **Link**: `test/draft/vendor/BytesLib.sol:BytesLib:toBytes32(bytes,uint256)`

```solidity
function toBytes32(bytes memory _bytes, uint256 _start) internal pure returns (bytes32) {
    require(_bytes.length >= (_start + 32), "toBytes32_outOfBounds");
    bytes32 tempBytes32;
    assembly {
        tempBytes32 := mload(add(add(_bytes, 0x20), _start))
    }
    return tempBytes32;
}
```

### _validateUnlockData(uint256,uint64,bytes)

- **Kind**: internal
- **Source**: 11414:522:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_validateUnlockData(uint256,uint64,bytes)`

```solidity
function _validateUnlockData(uint256 amount, uint64 fromChainId, bytes memory unindexedData) private {
    (uint256 eventAmount, uint64 eventChainId, uint256 eventNonce) = abi.decode(unindexedData, (uint256, uint64, uint256));
    if (eventAmount != amount) revert INVALID_PROOF_AMOUNT();
    if (eventChainId != _chainId) revert INVALID_PROOF_TARGETED_CHAIN();
    if (noncesUsed[fromChainId][eventNonce]) revert NONCE_ALREADY_USED();
    noncesUsed[fromChainId][eventNonce] = true;
}
```

### _releaseAssetFromChain(bytes32,address,address,uint256,uint64,uint256)

- **Kind**: internal
- **Source**: 2669:809:554
- **Link**: `test/draft/src/VaultBank/VaultBankSource.sol:VaultBankSource:_releaseAssetFromChain(bytes32,address,address,uint256,uint64,uint256)`

```solidity
function _releaseAssetFromChain(bytes32 yieldSourceOracleId, address account, address token, uint256 amount, uint64 fromChainId, uint256 nonce) internal {
    if (account == address(0)) revert INVALID_ACCOUNT();
    if (token == address(0)) revert INVALID_TOKEN();
    if ((amount == 0) || (amount > _lockedAmounts[token])) revert INVALID_AMOUNT();
    if (yieldSourceOracleId == bytes32(0)) revert INVALID_YIELD_SOURCE_ORACLE_ID();
    _lockedAmounts[token] -= amount;
    if (_lockedAmounts[token] == 0) {
        _lockedAssets.remove(token);
    }
    IERC20(token).safeTransfer(account, amount);
    emit SharesUnlocked(yieldSourceOracleId, account, token, amount, _chainId, fromChainId, nonce);
}
```

### remove(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 11736:156:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:remove(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function remove(AddressSet storage set, address value) internal returns (bool) {
    return _remove(set._inner, bytes32(uint256(uint160(value))));
}
```

### _remove(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 3071:1368:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_remove(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function _remove(Set storage set, bytes32 value) private returns (bool) {
    uint256 position = set._positions[value];
    if (position != 0) {
        uint256 valueIndex = position - 1;
        uint256 lastIndex = set._values.length - 1;
        if (valueIndex != lastIndex) {
            bytes32 lastValue = set._values[lastIndex];
            set._values[valueIndex] = lastValue;
            set._positions[lastValue] = position;
        }
        set._values.pop();
        delete set._positions[value];
        return true;
    } else {
        return false;
    }
}
```

## State Variable Reads

- **nonces** (`mapping(uint64 => uint256)`)
- **SUPER_REGISTRY** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **noncesUsed** (`mapping(uint64 => mapping(uint256 => bool))`)
- **_lockedAmounts** (`mapping(address => uint256)`)
- **_chainId** (`uint64`)

## State Variable Writes

- **nonces** (`mapping(uint64 => uint256)`)
- **noncesUsed** (`mapping(uint64 => mapping(uint256 => bool))`)
- **_lockedAmounts** (`mapping(address => uint256)`)
- **_lockedAssets** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBank.unlockAsset(address,address,uint256,uint64,bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: VaultBank._validateUnlockAssetProof(address,bytes32,address,uint256,uint64,bytes) (NodeID: 1)
  │   💬 Args: [account, yieldSourceOracleId, token, amount, fromChainId, proof]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: VaultBank._validateUnlockTopics(address,bytes32,address,bytes) (NodeID: 2)
  │ │   💬 Args: [account, yieldSourceOracleId, token, topics]
  │ │   👁️  Def: private
  │ │ ├─ [3] ⚙️ FUNCTION: BytesLib.toBytes32(bytes,uint256) (NodeID: 3)
  │ │ │   💬 Args: [topics, 0]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BytesLib.toBytes32(bytes,uint256) (NodeID: 4)
  │ │ │   💬 Args: [topics, 32]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BytesLib.toBytes32(bytes,uint256) (NodeID: 5)
  │ │ │   💬 Args: [topics, 64]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BytesLib.toBytes32(bytes,uint256) (NodeID: 6)
  │ │     💬 Args: [topics, 96]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: VaultBank._validateUnlockData(uint256,uint64,bytes) (NodeID: 7)
  │     💬 Args: [amount, fromChainId, unindexedData]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: VaultBankSource._releaseAssetFromChain(bytes32,address,address,uint256,uint64,uint256) (NodeID: 8)
      💬 Args: [yieldSourceOracleId, account, token, amount, fromChainId, _nonce]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet.remove(struct EnumerableSet.AddressSet,address) (NodeID: 9)
        💬 Args: [_lockedAssets, token]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet._remove(struct EnumerableSet.Set,bytes32) (NodeID: 10)
          💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IVaultBank

### Interface Documentation

@notice Unlock an asset for an account
 @param account The account to unlock the asset for
 @param token The asset to unlock
 @param amount The amount of the asset to unlock
 @param fromChainId The `from` (destination) chain
 @param yieldSourceOracleId The yield source oracle ID
 @param proof_ The proof of the `burnSuperPosition` event
