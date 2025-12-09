# Function: decimals()

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 895:92:196

## Implementation

```solidity
function decimals() override external view returns (uint8) {
    return _decimals;
}
```

## State Variable Reads

- **_decimals** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.decimals() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the decimals places of the token.
