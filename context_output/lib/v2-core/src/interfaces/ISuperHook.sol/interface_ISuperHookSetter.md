# Interface: ISuperHookSetter

## Metadata

- **Name**: ISuperHookSetter
- **Type**: Interface
- **Path**: lib/v2-core/src/interfaces/ISuperHook.sol

## Public/External Functions

### setOutAmount(uint256,address)

- **Signature**: `setOutAmount(uint256,address)`
- **Visibility**: external
- **Source Range**: 1914:66:422

**Signature:**
```solidity
/// @notice Sets the output amount for the hook
///  @dev Used for updating `outAmount` when fees were deducted
///  @param outAmount The amount of tokens processed by the hook
///  @param caller The caller address for context identification
function setOutAmount(uint256 outAmount, address caller) external;;
```
