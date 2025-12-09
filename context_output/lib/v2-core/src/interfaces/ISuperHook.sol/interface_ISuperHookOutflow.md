# Interface: ISuperHookOutflow

## Metadata

- **Name**: ISuperHookOutflow
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol
- **Documentation**: @title ISuperHookOutflow
   @author Superform Labs
   @notice Interface for hooks that specifically handle outflows (withdrawals)
   @dev Provides additional functionality needed only for outflow operations

## Public/External Functions

### replaceCalldataAmount(bytes,uint256)

- **Signature**: `replaceCalldataAmount(bytes,uint256)`
- **Visibility**: external
- **Source Range**: 5869:103:422

**Signature:**
```solidity
/// @notice Replace the amount in the calldata
///  @param data The data to replace the amount in
///  @param amount The amount to replace
///  @return data The data with the replaced amount
function replaceCalldataAmount(bytes memory data, uint256 amount) external pure returns (bytes memory);;
```
