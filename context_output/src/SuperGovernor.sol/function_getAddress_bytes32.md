# Function: getAddress(bytes32)

**Contract**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

## Metadata

- **Contract**: SuperGovernor
- **Signature**: `getAddress(bytes32)`
- **Visibility**: external
- **Source Range**: 28178:203:509

## Implementation

```solidity
/// @inheritdoc ISuperGovernor
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
┌─ [0] ⚙️ FUNCTION: SuperGovernor.getAddress(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperGovernor

### Interface Documentation

@notice Gets an address from the registry
 @param key The key of the address to get
 @return The address value
