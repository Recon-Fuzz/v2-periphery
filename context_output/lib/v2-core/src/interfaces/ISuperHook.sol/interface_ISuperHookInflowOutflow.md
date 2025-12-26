# Interface: ISuperHookInflowOutflow

## Metadata

- **Name**: ISuperHookInflowOutflow
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**: @title ISuperHookInflowOutflow
   @author Superform Labs
   @notice Interface for hooks that handle both inflows and outflows
   @dev Provides standardized amount extraction for both deposit and withdrawal operations

## Public/External Functions

### decodeAmount(bytes)

- **Signature**: `decodeAmount(bytes)`
- **Visibility**: external
- **Source Range**: 5340:73:422

**Signature:**
```solidity
/// @notice Extracts the amount from the hook's calldata
///  @dev Used to determine the quantity of assets or shares being processed
///  @param data The hook-specific calldata containing the amount
///  @return The amount of tokens to process
function decodeAmount(bytes memory data) external pure returns (uint256);;
```
