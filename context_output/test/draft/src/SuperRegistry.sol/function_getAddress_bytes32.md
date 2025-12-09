# Function: getAddress(bytes32)

**Contract**: [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Metadata

- **Contract**: SuperRegistry
- **Signature**: `getAddress(bytes32)`
- **Visibility**: external
- **Source Range**: 4593:203:550

## Implementation

```solidity
/// @inheritdoc ISuperRegistry
function getAddress(bytes32 key) external view returns (address) {
    address value = _addressRegistry[key];
    if (value == address(0)) revert CONTRACT_NOT_FOUND();
    return value;
}
```

## State Variable Reads

- **_addressRegistry** (`mapping(bytes32 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistry.getAddress(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperRegistry

### Interface Documentation

@notice Gets an address from the registry
 @param key The registry key
 @return The address value
