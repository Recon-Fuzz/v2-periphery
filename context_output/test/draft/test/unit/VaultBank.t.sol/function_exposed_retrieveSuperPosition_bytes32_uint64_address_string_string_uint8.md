# Function: exposed_retrieveSuperPosition(bytes32,uint64,address,string,string,uint8)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `exposed_retrieveSuperPosition(bytes32,uint64,address,string,string,uint8)`
- **Visibility**: external
- **Source Range**: 2534:395:570

## Implementation

```solidity
function exposed_retrieveSuperPosition(bytes32 yieldSourceOracleId, uint64 srcChainId, address srcTokenAddress, string calldata name, string calldata symbol, uint8 decimals) external returns (address) {
    return _retrieveSuperPosition(yieldSourceOracleId, srcChainId, srcTokenAddress, name, symbol, decimals);
}
```

## Related Implementations

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

## State Variable Reads

- **_tokenToSuperPosition** (`mapping(uint64 => mapping(bytes32 => mapping(address => address)))`)

## State Variable Writes

- **_tokenToSuperPosition** (`mapping(uint64 => mapping(bytes32 => mapping(address => address)))`)
- **_spAssetsInfo** (`mapping(address => struct IVaultBankDestination.SpAsset)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TestVaultBank.exposed_retrieveSuperPosition(bytes32,uint64,address,string,string,uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: VaultBankDestination._retrieveSuperPosition(bytes32,uint64,address,string,string,uint8) (NodeID: 1)
      💬 Args: [yieldSourceOracleId, srcChainId, srcTokenAddress, name, symbol, decimals]
      👁️  Def: internal
```
