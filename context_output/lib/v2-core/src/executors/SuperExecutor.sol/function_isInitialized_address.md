# Function: isInitialized(address)

**Contract**: [lib/v2-core/src/executors/SuperExecutor.sol/contract_SuperExecutor.md]

## Metadata

- **Contract**: SuperExecutor
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 3754:148:362
- **Inherited From**: SuperExecutorBase

## Implementation

```solidity
/// @inheritdoc ISuperExecutor
function isInitialized(address account) override(IModule, ISuperExecutor) external view returns (bool) {
    return _initialized[account];
}
```

## State Variable Reads

- **_initialized** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperExecutorBase.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc ISuperExecutor

### Interface Documentation

@notice Checks if an account has initialized this executor
 @dev Used to verify if an account has permission to use this executor
 @param account The address to check initialization status for
 @return True if the account is initialized, false otherwise

 @dev Returns if the module was already initialized for a provided smartaccount
