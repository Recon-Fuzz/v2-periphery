# Function: getTVLMultiple(address[])

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getTVLMultiple(address[])`
- **Visibility**: external
- **Source Range**: 2929:184:607

## Implementation

```solidity
function getTVLMultiple(address[] memory) external view returns (uint256[] memory) {
    uint256[] memory tvls = new uint256[](1);
    tvls[0] = tvl;
    return tvls;
}
```

## State Variable Reads

- **tvl** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getTVLMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Batch version of getTVL for multiple yield sources
 @dev Efficiently calculates total TVL across multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @return tvls Array containing the total TVL for each yield source
