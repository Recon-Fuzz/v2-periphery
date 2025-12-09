# Function: getTVLByOwnerOfShares(address,address)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: external
- **Source Range**: 2058:115:607

## Implementation

```solidity
function getTVLByOwnerOfShares(address, address) external view returns (uint256) {
    return tvlByOwner;
}
```

## State Variable Reads

- **tvlByOwner** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getTVLByOwnerOfShares(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the total value locked in a yield source by a specific owner
 @dev Used to track individual position sizes within the system
 @param yieldSourceAddress The yield-bearing token address to check
 @param ownerOfShares The address owning the yield-bearing tokens
 @return tvl The total value locked by the owner, in underlying asset terms
