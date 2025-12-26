# Interface: ISuperHookInspector

## Metadata

- **Name**: ISuperHookInspector
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**: @title ISuperHookInspector
   @author Superform Labs
   @notice Interface for the SuperHookInspector contract that manages hook inspection

## Public/External Functions

### inspect(bytes)

- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 2305:87:422

**Signature:**
```solidity
/// @notice Inspect the hook
///  @param data The hook data to inspect
///  @return argsEncoded The arguments of the hook encoded
function inspect(bytes calldata data) external view returns (bytes memory argsEncoded);;
```
