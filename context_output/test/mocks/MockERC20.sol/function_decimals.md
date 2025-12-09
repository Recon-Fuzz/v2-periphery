# Function: decimals()

**Contract**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 1290:90:589

## Implementation

```solidity
/// @notice Get the number of decimals for the token
function decimals() override public view returns (uint8) {
    return _decimals;
}
```

## State Variable Reads

- **_decimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Get the number of decimals for the token

### Interface Documentation

 @dev Returns the decimals places of the token.
