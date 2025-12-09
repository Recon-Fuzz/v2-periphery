# Function: getTickSpacing(uint24)

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `getTickSpacing(uint24)`
- **Visibility**: public
- **Source Range**: 2373:341:506
- **Inherited From**: UniswapV4Parser

## Implementation

```solidity
/// @notice Get tick spacing for a given fee tier
///  @param fee The fee tier
///  @return tickSpacing The tick spacing for the fee tier
function getTickSpacing(uint24 fee) public pure returns (int24 tickSpacing) {
    if (fee == 500) {
        tickSpacing = 10;
    } else if (fee == 3000) {
        tickSpacing = 60;
    } else if (fee == 10_000) {
        tickSpacing = 200;
    } else {
        revert("Unsupported fee tier");
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniswapV4Parser.getTickSpacing(uint24) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Get tick spacing for a given fee tier
 @param fee The fee tier
 @return tickSpacing The tick spacing for the fee tier
