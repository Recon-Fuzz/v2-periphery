# Function: getBalanceOfOwner(address,address)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol/contract_ERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: ERC5115YieldSourceOracle
- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: public
- **Source Range**: 3718:262:356

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getBalanceOfOwner(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256) {
    return IStandardizedYield(yieldSourceAddress).balanceOf(ownerOfShares);
}
```

## External Calls

- **IStandardizedYield::balanceOf(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC5115YieldSourceOracle.getBalanceOfOwner(address,address) (NodeID: 0)
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
