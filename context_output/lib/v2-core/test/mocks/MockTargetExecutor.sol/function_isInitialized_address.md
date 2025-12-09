# Function: isInitialized(address)

**Contract**: [lib/v2-core/test/mocks/MockTargetExecutor.sol/contract_MockTargetExecutor.md]

## Metadata

- **Contract**: MockTargetExecutor
- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 2152:148:487

## Implementation

```solidity
function isInitialized(address account) override(IModule, ISuperExecutor) external view returns (bool) {
    return _initialized[account];
}
```

## State Variable Reads

- **_initialized** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTargetExecutor.isInitialized(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Checks if an account has initialized this executor
 @dev Used to verify if an account has permission to use this executor
 @param account The address to check initialization status for
 @return True if the account is initialized, false otherwise

 @dev Returns if the module was already initialized for a provided smartaccount
