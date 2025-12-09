# Function: getTVL(address)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getTVL(address)`
- **Visibility**: external
- **Source Range**: 2179:84:607

## Implementation

```solidity
function getTVL(address) external view returns (uint256) {
    return tvl;
}
```

## State Variable Reads

- **tvl** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getTVL(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the total value locked across all users in a yield source
 @dev Critical for monitoring the size of each yield source in the system
 @param yieldSourceAddress The yield-bearing token address to check
 @return tvl The total value locked in the yield source, in underlying asset terms
