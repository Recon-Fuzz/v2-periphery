# Interface: IERC3156FlashBorrower

## Metadata

- **Name**: IERC3156FlashBorrower
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/interfaces/Flashloan.sol
- **Documentation**:  @dev Interface of the ERC3156 FlashBorrower, as defined in
   https://eips.ethereum.org/EIPS/eip-3156.

## Public/External Functions

### onFlashLoan(address,address,uint256,uint256,bytes)

- **Signature**: `onFlashLoan(address,address,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 2190:194:213

**Signature:**
```solidity
///  @dev Receive a flash loan.
///  @param initiator The initiator of the loan.
///  @param token The loan currency.
///  @param amount The amount of tokens lent.
///  @param fee The additional amount of tokens to repay.
///  @param data Arbitrary data structure, intended to contain user-defined parameters.
///  @return The keccak256 hash of "ERC3156FlashBorrower.onFlashLoan"
function onFlashLoan(address initiator, address token, uint256 amount, uint256 fee, bytes calldata data) external returns (bytes32);;
```
