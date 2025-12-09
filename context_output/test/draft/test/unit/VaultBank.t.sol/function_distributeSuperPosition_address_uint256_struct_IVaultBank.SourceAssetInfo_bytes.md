# Function: distributeSuperPosition(address,uint256,struct IVaultBank.SourceAssetInfo,bytes)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `distributeSuperPosition(address,uint256,struct IVaultBank.SourceAssetInfo,bytes)`
- **Visibility**: external
- **Source Range**: 4554:978:552
- **Inherited From**: VaultBank

## Implementation

```solidity
/// @inheritdoc IVaultBank
function distributeSuperPosition(address account_, uint256 amount_, SourceAssetInfo calldata sourceAsset_, bytes calldata proof_) override external onlyRelayer() {
    _validateDistributeSPProof(account_, sourceAsset_.yieldSourceOracleId, sourceAsset_.asset, amount_, sourceAsset_.chainId, proof_);
    address spAddress = _retrieveSuperPosition(sourceAsset_.yieldSourceOracleId, sourceAsset_.chainId, sourceAsset_.asset, sourceAsset_.name, sourceAsset_.symbol, sourceAsset_.decimals);
    _mintSP(account_, spAddress, amount_);
    nonces[uint64(_chainId)]++;
    emit SuperpositionsMinted(account_, spAddress, sourceAsset_.asset, amount_, sourceAsset_.chainId, _extractNonce(proof_));
}
```

## Related Implementations

### _validateDistributeSPProof(address,bytes32,address,uint256,uint64,bytes)

- **Kind**: internal
- **Source**: 7354:716:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_validateDistributeSPProof(address,bytes32,address,uint256,uint64,bytes)`

```solidity
function _validateDistributeSPProof(address account, bytes32 yieldSourceOracleId, address token, uint256 amount, uint64 fromChainId, bytes calldata proof) internal {
    (uint32 chainId, address emittingContract, bytes memory topics, bytes memory unindexedData) = ICrossL2ProverV2(SUPER_REGISTRY.getProver()).validateEvent(proof);
    address vaultBank = SUPER_REGISTRY.getVaultBank(uint64(fromChainId));
    if (emittingContract != vaultBank) revert INVALID_PROOF_EMITTER();
    _validateSPTopics(account, yieldSourceOracleId, token, topics);
    _validateSPData(amount, fromChainId, chainId, unindexedData);
}
```

### _validateSPTopics(address,bytes32,address,bytes)

- **Kind**: internal
- **Source**: 8404:757:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_validateSPTopics(address,bytes32,address,bytes)`

```solidity
function _validateSPTopics(address account, bytes32 yieldSourceOracleId, address token, bytes memory topics) private pure {
    if (topics.toBytes32(0) != IVaultBankSource.SharesLocked.selector) revert INVALID_PROOF_EVENT();
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

### _validateSPData(uint256,uint64,uint32,bytes)

- **Kind**: internal
- **Source**: 9167:687:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_validateSPData(uint256,uint64,uint32,bytes)`

```solidity
function _validateSPData(uint256 amount, uint64 fromChainId, uint32 chainId, bytes memory unindexedData) private {
    (uint256 eventAmount, uint64 eventSrcChainId, uint64 eventDstChainId, uint256 eventNonce) = abi.decode(unindexedData, (uint256, uint64, uint64, uint256));
    if (eventAmount != amount) revert INVALID_PROOF_AMOUNT();
    if ((eventSrcChainId != fromChainId) || (uint64(chainId) != fromChainId)) revert INVALID_PROOF_SOURCE_CHAIN();
    if (eventDstChainId != _chainId) revert INVALID_PROOF_TARGETED_CHAIN();
    if (noncesUsed[fromChainId][eventNonce]) revert NONCE_ALREADY_USED();
    noncesUsed[fromChainId][eventNonce] = true;
}
```

### _retrieveSuperPosition(bytes32,uint64,address,string,string,uint8)

- **Kind**: internal
- **Source**: 1981:788:553
- **Link**: `test/draft/src/VaultBank/VaultBankDestination.sol:VaultBankDestination:_retrieveSuperPosition(bytes32,uint64,address,string,string,uint8)`

```solidity
function _retrieveSuperPosition(bytes32 yieldSourceOracleId, uint64 srcChainId, address srcAsset, string calldata _srcName, string calldata _srcSymbol, uint8 _srcDecimals) internal returns (address) {
    address _created = _tokenToSuperPosition[srcChainId][yieldSourceOracleId][srcAsset];
    if (_created != address(0)) return _created;
    _created = address(new VaultBankSuperPosition(_srcName, _srcSymbol, _srcDecimals, yieldSourceOracleId));
    _tokenToSuperPosition[srcChainId][yieldSourceOracleId][srcAsset] = _created;
    _spAssetsInfo[_created].spToToken[srcChainId][yieldSourceOracleId] = srcAsset;
    _spAssetsInfo[_created].wasCreated = true;
    return _created;
}
```

### _mintSP(address,address,uint256)

- **Kind**: internal
- **Source**: 2775:337:553
- **Link**: `test/draft/src/VaultBank/VaultBankDestination.sol:VaultBankDestination:_mintSP(address,address,uint256)`

```solidity
function _mintSP(address account, address superPosition, uint256 amount) internal {
    if (!_spAssetsInfo[superPosition].wasCreated) revert SUPERPOSITION_ASSET_NOT_FOUND();
    VaultBankSuperPosition(superPosition).mint(account, amount);
}
```

### _extractNonce(bytes)

- **Kind**: internal
- **Source**: 8076:322:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_extractNonce(bytes)`

```solidity
function _extractNonce(bytes calldata proof_) internal view returns (uint256) {
    (, , , bytes memory unindexedData) = ICrossL2ProverV2(SUPER_REGISTRY.getProver()).validateEvent(proof_);
    (, , , uint256 eventNonce) = abi.decode(unindexedData, (uint256, uint64, uint64, uint256));
    return eventNonce;
}
```

### onlyRelayer()

- **Kind**: modifier
- **Source**: 1880:118:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:onlyRelayer()`

```solidity
modifier onlyRelayer() {
    if (!SUPER_REGISTRY.isRelayer(msg.sender)) revert INVALID_RELAYER();
    _;
}
```

## State Variable Reads

- **SUPER_REGISTRY** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **noncesUsed** (`mapping(uint64 => mapping(uint256 => bool))`)
- **_tokenToSuperPosition** (`mapping(uint64 => mapping(bytes32 => mapping(address => address)))`)
- **_spAssetsInfo** (`mapping(address => struct IVaultBankDestination.SpAsset)`)

## State Variable Writes

- **nonces** (`mapping(uint64 => uint256)`)
- **noncesUsed** (`mapping(uint64 => mapping(uint256 => bool))`)
- **_tokenToSuperPosition** (`mapping(uint64 => mapping(bytes32 => mapping(address => address)))`)
- **_spAssetsInfo** (`mapping(address => struct IVaultBankDestination.SpAsset)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBank.distributeSuperPosition(address,uint256,struct IVaultBank.SourceAssetInfo,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: VaultBank._validateDistributeSPProof(address,bytes32,address,uint256,uint64,bytes) (NodeID: 1)
  │   💬 Args: [account_, sourceAsset_.yieldSourceOracleId, sourceAsset_.asset, amount_, sourceAsset_.chainId, proof_]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: VaultBank._validateSPTopics(address,bytes32,address,bytes) (NodeID: 2)
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
  │ └─ [2] ⚙️ FUNCTION: VaultBank._validateSPData(uint256,uint64,uint32,bytes) (NodeID: 7)
  │     💬 Args: [amount, fromChainId, chainId, unindexedData]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: VaultBankDestination._retrieveSuperPosition(bytes32,uint64,address,string,string,uint8) (NodeID: 8)
  │   💬 Args: [sourceAsset_.yieldSourceOracleId, sourceAsset_.chainId, sourceAsset_.asset, sourceAsset_.name, sourceAsset_.symbol, sourceAsset_.decimals]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: VaultBankDestination._mintSP(address,address,uint256) (NodeID: 9)
  │   💬 Args: [account_, spAddress, amount_]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: VaultBank._extractNonce(bytes) (NodeID: 10)
  │   💬 Args: [proof_]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: VaultBank.onlyRelayer() (NodeID: 11)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IVaultBank

### Interface Documentation

@notice Creates or retrieves synthethic asset and distributes it to the account
 @param account_ The account to lock the asset for
 @param amount_ The amount of the asset to lock
 @param sourceAssetInfo_ The source asset info
 @param proof_ The proof of the event
