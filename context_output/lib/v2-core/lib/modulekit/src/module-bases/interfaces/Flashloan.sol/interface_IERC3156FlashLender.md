# Interface: IERC3156FlashLender

## Metadata

- **Name**: IERC3156FlashLender
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/module-bases/interfaces/Flashloan.sol
- **Documentation**:  @dev Interface of the ERC3156 FlashLender, as defined in
   https://eips.ethereum.org/EIPS/eip-3156.

## Public/External Functions

### maxFlashLoan(address)

- **Signature**: `maxFlashLoan(address)`
- **Visibility**: external
- **Source Range**: 702:69:213

**Signature:**
```solidity
///  @dev The amount of currency available to be lended.
///  @param token The loan currency.
///  @return The amount of `token` that can be borrowed.
function maxFlashLoan(address token) external view returns (uint256);;
```

### flashFee(address,uint256)

- **Signature**: `flashFee(address,uint256)`
- **Visibility**: external
- **Source Range**: 1031:81:213

**Signature:**
```solidity
///  @dev The fee to be charged for a given loan.
///  @param token The loan currency.
///  @param amount The amount of tokens lent.
///  @return The amount of `token` to be charged for the loan, on top of the returned principal.
function flashFee(address token, uint256 amount) external view returns (uint256);;
```

### flashLoan(contract IERC3156FlashBorrower,address,uint256,bytes)

- **Signature**: `flashLoan(contract IERC3156FlashBorrower,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 1443:181:213

**Signature:**
```solidity
///  @dev Initiate a flash loan.
///  @param receiver The receiver of the tokens in the loan, and the receiver of the callback.
///  @param token The loan currency.
///  @param amount The amount of tokens lent.
///  @param data Arbitrary data structure, intended to contain user-defined parameters.
function flashLoan(IERC3156FlashBorrower receiver, address token, uint256 amount, bytes calldata data) external returns (bool);;
```
