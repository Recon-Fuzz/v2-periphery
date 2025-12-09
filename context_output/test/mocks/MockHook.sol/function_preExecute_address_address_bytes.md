# Function: preExecute(address,address,bytes)

**Contract**: [test/mocks/MockHook.sol/contract_MockHook.md]

## Metadata

- **Contract**: MockHook
- **Signature**: `preExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 1460:110:593

## Implementation

```solidity
function preExecute(address, address, bytes memory) override external {
    preExecuteCalled = true;
}
```

## State Variable Writes

- **preExecuteCalled** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockHook.preExecute(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Prepares the hook for execution
 @dev Called before the main execution, used to validate inputs and set execution context
      This method may perform state changes to set up the hook's execution state
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account to perform operations for
 @param data The hook-specific parameters and configuration data
