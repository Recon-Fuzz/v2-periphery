# Function: totalAssets(address)

**Contract**: [test/integration/SuperVault/TotalAssetHelper.sol/contract_TotalAssetHelper.md]

## Metadata

- **Contract**: TotalAssetHelper
- **Signature**: `totalAssets(address)`
- **Visibility**: external
- **Source Range**: 1563:1728:582

## Implementation

```solidity
/// @notice Calculate the total assets of a SuperVault strategy
///  @param strategy Address of the SuperVaultStrategy contract
///  @return totalAssets_ Total assets held by the strategy across all yield sources
///  @return sourceTVLs Breakdown of TVL by yield source
function totalAssets(address strategy) external view returns (uint256 totalAssets_, YieldSourceTVL[] memory sourceTVLs) {
    ISuperVaultStrategy.YieldSourceInfo[] memory yieldSourcesList = _getYieldSourcesList(strategy);
    uint256 length = yieldSourcesList.length;
    sourceTVLs = new YieldSourceTVL[](length);
    uint256 validSourceCount;
    (, address asset, ) = ISuperVaultStrategy(strategy).getVaultInfo();
    totalAssets_ += IERC20(asset).balanceOf(strategy);
    for (uint256 i; i < length; ++i) {
        address source = yieldSourcesList[i].sourceAddress;
        address oracle = yieldSourcesList[i].oracle;
        if (oracle != address(0)) {
            uint256 baseTvl = _getTvlByOwnerOfShares(strategy, source, oracle);
            totalAssets_ += baseTvl;
            sourceTVLs[validSourceCount++] = YieldSourceTVL({source: source, tvl: baseTvl});
        }
    }
    if (validSourceCount < length) {
        assembly {
            mstore(sourceTVLs, validSourceCount)
        }
    }
}
```

## Related Implementations

### _getYieldSourcesList(address)

- **Kind**: internal
- **Source**: 3658:418:582
- **Link**: `test/integration/SuperVault/TotalAssetHelper.sol:TotalAssetHelper:_getYieldSourcesList(address)`

```solidity
/// @notice Get the list of yield sources for a strategy
///  @param strategy Address of the SuperVaultStrategy contract
///  @return List of yield source addresse
function _getYieldSourcesList(address strategy) internal view returns (ISuperVaultStrategy.YieldSourceInfo[] memory) {
    try ISuperVaultStrategy(strategy).getYieldSourcesList() returns (ISuperVaultStrategy.YieldSourceInfo[] memory info) {
        return info;
    } catch {
        return new ISuperVaultStrategy.YieldSourceInfo[](0);
    }
}
```

### _getTvlByOwnerOfShares(address,address,address)

- **Kind**: internal
- **Source**: 5544:343:582
- **Link**: `test/integration/SuperVault/TotalAssetHelper.sol:TotalAssetHelper:_getTvlByOwnerOfShares(address,address,address)`

```solidity
/// @notice Get the TVL for a yield source by owner of shares
///  @param strategy Address of the SuperVaultStrategy contract
///  @param source Address of the yield source
///  @param oracle Address of the yield source oracle
///  @return TVL of the yield source
function _getTvlByOwnerOfShares(address strategy, address source, address oracle) internal view returns (uint256) {
    if (oracle == address(0)) return 0;
    try IYieldSourceOracle(oracle).getTVLByOwnerOfShares(source, strategy) returns (uint256 tvl) {
        return tvl;
    } catch {
        return 0;
    }
}
```

## External Calls

- **ISuperVaultStrategy::getVaultInfo()**
- **IERC20::balanceOf(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TotalAssetHelper.totalAssets(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TotalAssetHelper._getYieldSourcesList(address) (NodeID: 1)
  │   💬 Args: [strategy]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TotalAssetHelper._getTvlByOwnerOfShares(address,address,address) (NodeID: 2)
      💬 Args: [strategy, source, oracle]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Calculate the total assets of a SuperVault strategy
 @param strategy Address of the SuperVaultStrategy contract
 @return totalAssets_ Total assets held by the strategy across all yield sources
 @return sourceTVLs Breakdown of TVL by yield source
