# Function: getBalanceOfOwner(address,address)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC4626YieldSourceOracle.sol/contract_ERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: ERC4626YieldSourceOracle
- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: public
- **Source Range**: 2231:252:355

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getBalanceOfOwner(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256) {
    return IERC4626(yieldSourceAddress).balanceOf(ownerOfShares);
}
```

## External Calls

- **IERC4626::balanceOf(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626YieldSourceOracle.getBalanceOfOwner(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Gets the share balance of a specific owner in a yield source
 @dev Returns raw share balance without converting to underlying assets
      Used to track participation in the system and for accounting
 @param yieldSourceAddress The yield-bearing token address
 @param ownerOfShares The address to check the balance for
 @return balance The number of yield-bearing tokens owned by the address
