# Interface: IRecoverable

## Metadata

- **Name**: IRecoverable
- **Type**: Interface
- **Path**: test/mocks/centrifuge/IRecoverable.sol

## Public/External Functions

### recoverTokens(address,address,uint256)

- **Signature**: `recoverTokens(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 452:75:617

**Signature:**
```solidity
/// @notice Used to recover any ERC-20 token.
///  @dev    This method is called only by authorized entities
///  @param  token It could be 0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
///          to recover locked native ETH or any ERC20 compatible token.
///  @param  to Receiver of the funds
///  @param  amount Amount to send to the receiver.
function recoverTokens(address token, address to, uint256 amount) external;;
```
