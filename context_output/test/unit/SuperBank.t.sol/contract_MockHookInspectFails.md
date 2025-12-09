# Contract: MockHookInspectFails

## Metadata

- **Name**: MockHookInspectFails
- **Type**: Contract
- **Path**: test/unit/SuperBank.t.sol
- **Documentation**: @notice Mock hook that reverts in inspect() method
   @dev Used to test the catch branch in _validateHookConfiguration

## Public/External Functions

### inspect(bytes)

- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 76276:109:658
- **Details**: [function_inspect_bytes.md](./function_inspect_bytes.md)

**Signature:**
```solidity
function inspect(bytes memory) external pure returns (bytes memory);
```
