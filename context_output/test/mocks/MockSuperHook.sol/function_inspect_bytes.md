# Function: inspect(bytes)

**Contract**: [test/mocks/MockSuperHook.sol/contract_MockSuperHook.md]

## Metadata

- **Contract**: MockSuperHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 2008:135:604

## Implementation

```solidity
/// @notice Override inspect to return the target address
function inspect(bytes calldata) override external view returns (bytes memory) {
    return abi.encodePacked(targetToReturn);
}
```

## State Variable Reads

- **targetToReturn** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Override inspect to return the target address

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
