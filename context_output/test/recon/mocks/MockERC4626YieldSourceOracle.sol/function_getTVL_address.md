# Function: getTVL(address)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getTVL(address)`
- **Visibility**: external
- **Source Range**: 2170:142:638

## Implementation

```solidity
function getTVL(address yieldSourceAddress) external view returns (uint256) {
    return IERC4626(yieldSourceAddress).totalAssets();
}
```

## External Calls

- **IERC4626::totalAssets()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getTVL(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the total value locked across all users in a yield source
 @dev Critical for monitoring the size of each yield source in the system
 @param yieldSourceAddress The yield-bearing token address to check
 @return tvl The total value locked in the yield source, in underlying asset terms
