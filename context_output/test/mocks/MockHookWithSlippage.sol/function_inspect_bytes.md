# Function: inspect(bytes)

**Contract**: [test/mocks/MockHookWithSlippage.sol/contract_MockHookWithSlippage.md]

## Metadata

- **Contract**: MockHookWithSlippage
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 1335:135:595

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
┌─ [0] ⚙️ FUNCTION: MockHookWithSlippage.inspect(bytes) (NodeID: 0)
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
