# Function: getTVLByOwnerOfSharesMultiple(address[],address[][])

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getTVLByOwnerOfSharesMultiple(address[],address[][])`
- **Visibility**: external
- **Source Range**: 2485:438:607

## Implementation

```solidity
function getTVLByOwnerOfSharesMultiple(address[] memory yieldSources, address[][] memory) external view returns (uint256[][] memory) {
    uint256[][] memory result = new uint256[][](yieldSources.length);
    for (uint256 i = 0; i < yieldSources.length; i++) {
        result[i] = new uint256[](1);
        result[i][0] = tvlByOwner;
    }
    return result;
}
```

## State Variable Reads

- **tvlByOwner** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getTVLByOwnerOfSharesMultiple(address[],address[][]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Batch version of getTVLByOwnerOfShares for multiple yield sources and owners
 @dev Efficiently calculates TVL for multiple owners across multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @param ownersOfShares 2D array where each sub-array contains owner addresses for a yield source
 @return userTvls 2D array of TVL values for each owner in each yield source
