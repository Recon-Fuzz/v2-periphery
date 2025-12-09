# Function: getBalanceOfOwner(address,address)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: external
- **Source Range**: 1831:111:607

## Implementation

```solidity
function getBalanceOfOwner(address, address) external view returns (uint256) {
    return tvlByOwner;
}
```

## State Variable Reads

- **tvlByOwner** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.getBalanceOfOwner(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Gets the share balance of a specific owner in a yield source
 @dev Returns raw share balance without converting to underlying assets
      Used to track participation in the system and for accounting
 @param yieldSourceAddress The yield-bearing token address
 @param ownerOfShares The address to check the balance for
 @return balance The number of yield-bearing tokens owned by the address
