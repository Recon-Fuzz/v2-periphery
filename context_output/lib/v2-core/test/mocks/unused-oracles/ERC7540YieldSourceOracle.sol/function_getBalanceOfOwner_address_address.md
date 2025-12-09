# Function: getBalanceOfOwner(address,address)

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: public
- **Source Range**: 2740:268:498

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getBalanceOfOwner(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256) {
    return IERC20(IERC7540(yieldSourceAddress).share()).balanceOf(ownerOfShares);
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **IERC7540::share()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540YieldSourceOracle.getBalanceOfOwner(address,address) (NodeID: 0)
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
