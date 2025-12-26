# Function: isInitialized(address)

**Contract**: [lib/v2-core/src/validators/SuperDestinationValidator.sol/contract_SuperDestinationValidator.md]

## Metadata

- **Contract**: SuperDestinationValidator
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 2461:114:439
- **Inherited From**: SuperValidatorBase

## Implementation

```solidity
function isInitialized(address account) external view returns (bool) {
    return _initialized[account];
}
```

## State Variable Reads

- **_initialized** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperValidatorBase.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev Returns if the module was already initialized for a provided smartaccount
