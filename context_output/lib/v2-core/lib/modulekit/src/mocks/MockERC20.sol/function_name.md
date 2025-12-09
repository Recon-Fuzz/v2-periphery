# Function: name()

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 695:92:196

## Implementation

```solidity
function name() override external view returns (string memory) {
    return _name;
}
```

## State Variable Reads

- **_name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the name of the token.
