# Function: description()

**Contract**: [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]

## Metadata

- **Contract**: FixedPriceOracle
- **Signature**: `description()`
- **Visibility**: external
- **Source Range**: 3702:96:533

## Implementation

```solidity
/// @notice Returns the description of this oracle
///  @return The description string
function description() external pure returns (string memory) {
    return DESCRIPTION;
}
```

## State Variable Reads

- **DESCRIPTION** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedPriceOracle.description() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Returns the description of this oracle
 @return The description string
