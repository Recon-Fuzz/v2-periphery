# Interface: IUnlockCallback

## Metadata

- **Name**: IUnlockCallback
- **Type**: Interface
- **Path**: lib/v2-core/lib/v4-core/src/interfaces/callback/IUnlockCallback.sol
- **Documentation**: @notice Interface for the callback executed when an address unlocks the pool manager

## Public/External Functions

### unlockCallback(bytes)

- **Signature**: `unlockCallback(bytes)`
- **Visibility**: external
- **Source Range**: 408:77:330

**Signature:**
```solidity
/// @notice Called by the pool manager on `msg.sender` when the manager is unlocked
///  @param data The data that was passed to the call to unlock
///  @return Any data that you want to be returned from the unlock call
function unlockCallback(bytes calldata data) external returns (bytes memory);;
```
