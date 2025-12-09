# Function: decimals(address)

**Contract**: [lib/v2-core/src/accounting/oracles/ERC4626YieldSourceOracle.sol/contract_ERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: ERC4626YieldSourceOracle
- **Signature**: `decimals(address)`
- **Visibility**: external
- **Source Range**: 752:148:355

## Implementation

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function decimals(address yieldSourceAddress) override external view returns (uint8) {
    return IERC4626(yieldSourceAddress).decimals();
}
```

## External Calls

- **IERC4626::decimals()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626YieldSourceOracle.decimals(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc AbstractYieldSourceOracle

### Interface Documentation

@notice Returns the number of decimals of the yield source shares
 @dev Critical for accurately interpreting share amounts and calculating prices
      Different yield sources may have different decimal precision
 @param yieldSourceAddress The address of the yield-bearing token contract
 @return decimals The number of decimals used by the yield source's share token
