# Function: decimals(address)

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `decimals(address)`
- **Visibility**: external
- **Source Range**: 641:126:640

## Implementation

```solidity
function decimals(address) external pure returns (uint8) {
    return 18;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.decimals(address) (NodeID: 0)
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
