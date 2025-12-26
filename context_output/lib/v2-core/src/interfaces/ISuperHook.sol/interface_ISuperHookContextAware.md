# Interface: ISuperHookContextAware

## Metadata

- **Name**: ISuperHookContextAware
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**: @title ISuperHookContextAware
   @author Superform Labs
   @notice Interface for hooks that can use previous hook results in their execution
   @dev Enables contextual awareness and data flow between hooks in a chain

## Public/External Functions

### decodeUsePrevHookAmount(bytes)

- **Signature**: `decodeUsePrevHookAmount(bytes)`
- **Visibility**: external
- **Source Range**: 4733:81:422

**Signature:**
```solidity
/// @notice Determines if this hook should use the amount from the previous hook
///  @dev Used to create hook chains where output from one hook becomes input to the next
///  @param data The hook-specific data containing configuration
///  @return True if the hook should use the previous hook's output amount
function decodeUsePrevHookAmount(bytes memory data) external pure returns (bool);;
```
