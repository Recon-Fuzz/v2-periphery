# Function: name()

**Contract**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 1760:89:267
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev Returns the name of the token.
function name() virtual public view returns (string memory) {
    return _name;
}
```

## State Variable Reads

- **_name** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.name() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns the name of the token.

### Interface Documentation

 @dev Returns the name of the token.
