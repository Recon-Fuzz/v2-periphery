# Function: decimals(address)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `decimals(address)`
- **Visibility**: external
- **Source Range**: 635:139:638

## Implementation

```solidity
function decimals(address yieldSourceAddress) external view returns (uint8) {
    return IERC4626(yieldSourceAddress).decimals();
}
```

## External Calls

- **IERC4626::decimals()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.decimals(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the number of decimals of the yield source shares
 @dev Critical for accurately interpreting share amounts and calculating prices
      Different yield sources may have different decimal precision
 @param yieldSourceAddress The address of the yield-bearing token contract
 @return decimals The number of decimals used by the yield source's share token
