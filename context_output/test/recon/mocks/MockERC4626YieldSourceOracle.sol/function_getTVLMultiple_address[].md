# Function: getTVLMultiple(address[])

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getTVLMultiple(address[])`
- **Visibility**: external
- **Source Range**: 3560:357:638

## Implementation

```solidity
function getTVLMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory) {
    uint256[] memory tvls = new uint256[](yieldSourceAddresses.length);
    for (uint256 i = 0; i < yieldSourceAddresses.length; i++) {
        tvls[i] = IERC4626(yieldSourceAddresses[i]).totalAssets();
    }
    return tvls;
}
```

## External Calls

- **IERC4626::totalAssets()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getTVLMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Batch version of getTVL for multiple yield sources
 @dev Efficiently calculates total TVL across multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @return tvls Array containing the total TVL for each yield source
