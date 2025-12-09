# Function: version()

**Contract**: [lib/v2-core/test/mocks/MockTargetExecutor.sol/contract_MockTargetExecutor.md]

## Metadata

- **Contract**: MockTargetExecutor
- **Signature**: `version()`
- **Visibility**: external
- **Source Range**: 2405:88:487

## Implementation

```solidity
function version() external pure returns (string memory) {
    return "0.0.1";
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockTargetExecutor.version() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the version of the executor implementation
 @dev Used for tracking implementation version for upgrades and compatibility
 @return The version string of the specific executor implementation
