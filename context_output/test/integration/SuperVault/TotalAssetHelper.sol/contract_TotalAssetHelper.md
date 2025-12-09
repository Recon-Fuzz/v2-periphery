# Contract: TotalAssetHelper

## Metadata

- **Name**: TotalAssetHelper
- **Type**: Contract
- **Path**: test/integration/SuperVault/TotalAssetHelper.sol
- **Documentation**: @title TotalAssetHelper
   @author Superform Labs
   @notice Helper contract for calculating totalAssets of a SuperVault strategy
   @dev Used for testing purposes to retrieve totalAssets by querying all yield sources

## Structs

### YieldSourceTVL

```solidity
/// @notice Struct to hold TVL information for a yield source
struct YieldSourceTVL {
    address source;
    uint256 tvl;
}
```

## Public/External Functions

### totalAssets(address)

- **Signature**: `totalAssets(address)`
- **Visibility**: external
- **Source Range**: 1563:1728:582
- **Details**: [function_totalAssets_address.md](./function_totalAssets_address.md)

**Signature:**
```solidity
/// @notice Calculate the total assets of a SuperVault strategy
///  @param strategy Address of the SuperVaultStrategy contract
///  @return totalAssets_ Total assets held by the strategy across all yield sources
///  @return sourceTVLs Breakdown of TVL by yield source
function totalAssets(address strategy) external view returns (uint256 totalAssets_, YieldSourceTVL[] memory sourceTVLs);
```
