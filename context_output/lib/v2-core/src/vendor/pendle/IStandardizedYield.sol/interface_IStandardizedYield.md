# Interface: IStandardizedYield

## Metadata

- **Name**: IStandardizedYield
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/pendle/IStandardizedYield.sol

## Implements Interfaces

- **IERC20Metadata** [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Events

### Transfer (inherited from IERC20)

```solidity
///  @dev Emitted when `value` tokens are moved from one account (`from`) to
///  another (`to`).
///  Note that `value` may be zero.
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval (inherited from IERC20)

```solidity
///  @dev Emitted when the allowance of a `spender` for an `owner` is set by
///  a call to {approve}. `value` is the new allowance.
event Approval(address indexed owner, address indexed spender, uint256 value);
```

### Deposit

```solidity
/// @dev Emitted when any base tokens is deposited to mint shares
event Deposit(address indexed caller, address indexed receiver, address indexed tokenIn, uint256 amountDeposited, uint256 amountSyOut);
```

### Redeem

```solidity
/// @dev Emitted when any shares are redeemed for base tokens
event Redeem(address indexed caller, address indexed receiver, address indexed tokenOut, uint256 amountSyToRedeem, uint256 amountTokenOut);
```

### ClaimRewards

```solidity
/// @dev Emitted when (`user`) claims their rewards
event ClaimRewards(address indexed user, address[] rewardTokens, uint256[] rewardAmounts);
```

## Enums

### AssetType

```solidity
/// @dev check `assetInfo()` for more information
enum AssetType {
    TOKEN,
    LIQUIDITY
}
```

## Public/External Functions

### deposit(address,address,uint256,uint256)

- **Signature**: `deposit(address,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2622:217:466

**Signature:**
```solidity
///  @notice mints an amount of shares by depositing a base token.
///  @param receiver shares recipient address
///  @param tokenIn address of the base tokens to mint shares
///  @param amountTokenToDeposit amount of base tokens to be transferred from (`msg.sender`)
///  @param minSharesOut reverts if amount of shares minted is lower than this
///  @return amountSharesOut amount of shares minted
///  @dev Emits a {Deposit} event
///  Requirements:
///  - (`tokenIn`) must be a valid base token.
function deposit(address receiver, address tokenIn, uint256 amountTokenToDeposit, uint256 minSharesOut) external payable returns (uint256 amountSharesOut);;
```

### redeem(address,uint256,address,uint256,bool)

- **Signature**: `redeem(address,uint256,address,uint256,bool)`
- **Visibility**: external
- **Source Range**: 3482:237:466

**Signature:**
```solidity
///  @notice redeems an amount of base tokens by burning some shares
///  @param receiver recipient address
///  @param amountSharesToRedeem amount of shares to be burned
///  @param tokenOut address of the base token to be redeemed
///  @param minTokenOut reverts if amount of base token redeemed is lower than this
///  @param burnFromInternalBalance if true, burns from balance of `address(this)`, otherwise burns from `msg.sender`
///  @return amountTokenOut amount of base tokens redeemed
///  @dev Emits a {Redeem} event
///  Requirements:
///  - (`tokenOut`) must be a valid base token.
function redeem(address receiver, uint256 amountSharesToRedeem, address tokenOut, uint256 minTokenOut, bool burnFromInternalBalance) external returns (uint256 amountTokenOut);;
```

### exchangeRate()

- **Signature**: `exchangeRate()`
- **Visibility**: external
- **Source Range**: 4097:60:466

**Signature:**
```solidity
///  @notice exchangeRate * syBalance / 1e18 must return the asset balance of the account
///  @notice vice-versa, if a user uses some amount of tokens equivalent to X asset, the amount of sy
///   he can mint must be X * exchangeRate / 1e18
///  @dev SYUtils's assetToSy & syToAsset should be used instead of raw multiplication
///   & division
function exchangeRate() external view returns (uint256 res);;
```

### claimRewards(address)

- **Signature**: `claimRewards(address)`
- **Visibility**: external
- **Source Range**: 4471:86:466

**Signature:**
```solidity
///  @notice claims reward for (`user`)
///  @param user the user receiving their rewards
///  @return rewardAmounts an array of reward amounts in the same order as `getRewardTokens`
///  @dev
///  Emits a `ClaimRewards` event
///  See {getRewardTokens} for list of reward tokens
function claimRewards(address user) external returns (uint256[] memory rewardAmounts);;
```

### accruedRewards(address)

- **Signature**: `accruedRewards(address)`
- **Visibility**: external
- **Source Range**: 4779:93:466

**Signature:**
```solidity
///  @notice get the amount of unclaimed rewards for (`user`)
///  @param user the user to check for
///  @return rewardAmounts an array of reward amounts in the same order as `getRewardTokens`
function accruedRewards(address user) external view returns (uint256[] memory rewardAmounts);;
```

### rewardIndexesCurrent()

- **Signature**: `rewardIndexesCurrent()`
- **Visibility**: external
- **Source Range**: 4878:76:466

**Signature:**
```solidity
function rewardIndexesCurrent() external returns (uint256[] memory indexes);;
```

### rewardIndexesStored()

- **Signature**: `rewardIndexesStored()`
- **Visibility**: external
- **Source Range**: 4960:80:466

**Signature:**
```solidity
function rewardIndexesStored() external view returns (uint256[] memory indexes);;
```

### getRewardTokens()

- **Signature**: `getRewardTokens()`
- **Visibility**: external
- **Source Range**: 5120:68:466

**Signature:**
```solidity
///  @notice returns the list of reward token addresses
function getRewardTokens() external view returns (address[] memory);;
```

### yieldToken()

- **Signature**: `yieldToken()`
- **Visibility**: external
- **Source Range**: 5275:54:466

**Signature:**
```solidity
///  @notice returns the address of the underlying yield token
function yieldToken() external view returns (address);;
```

### getTokensIn()

- **Signature**: `getTokensIn()`
- **Visibility**: external
- **Source Range**: 5407:68:466

**Signature:**
```solidity
///  @notice returns all tokens that can mint this SY
function getTokensIn() external view returns (address[] memory res);;
```

### getTokensOut()

- **Signature**: `getTokensOut()`
- **Visibility**: external
- **Source Range**: 5563:69:466

**Signature:**
```solidity
///  @notice returns all tokens that can be redeemed by this SY
function getTokensOut() external view returns (address[] memory res);;
```

### isValidTokenIn(address)

- **Signature**: `isValidTokenIn(address)`
- **Visibility**: external
- **Source Range**: 5638:68:466

**Signature:**
```solidity
function isValidTokenIn(address token) external view returns (bool);;
```

### isValidTokenOut(address)

- **Signature**: `isValidTokenOut(address)`
- **Visibility**: external
- **Source Range**: 5712:69:466

**Signature:**
```solidity
function isValidTokenOut(address token) external view returns (bool);;
```

### previewDeposit(address,uint256)

- **Signature**: `previewDeposit(address,uint256)`
- **Visibility**: external
- **Source Range**: 5787:165:466

**Signature:**
```solidity
function previewDeposit(address tokenIn, uint256 amountTokenToDeposit) external view returns (uint256 amountSharesOut);;
```

### previewRedeem(address,uint256)

- **Signature**: `previewRedeem(address,uint256)`
- **Visibility**: external
- **Source Range**: 5958:164:466

**Signature:**
```solidity
function previewRedeem(address tokenOut, uint256 amountSharesToRedeem) external view returns (uint256 amountTokenOut);;
```

### assetInfo()

- **Signature**: `assetInfo()`
- **Visibility**: external
- **Source Range**: 6563:108:466

**Signature:**
```solidity
///  @notice This function contains information to interpret what the asset is
///  @return assetType the type of the asset (0 for ERC20 tokens, 1 for AMM liquidity tokens,
///      2 for bridged yield bearing tokens like wstETH, rETH on Arbi whose the underlying asset doesn't exist on the
///  chain)
///  @return assetAddress the address of the asset
///  @return assetDecimals the decimals of the asset
function assetInfo() external view returns (AssetType assetType, address assetAddress, uint8 assetDecimals);;
```

### totalSupply() (inherited from IERC20)

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 776:55:268

**Signature:**
```solidity
///  @dev Returns the value of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address) (inherited from IERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 913:68:268

**Signature:**
```solidity
///  @dev Returns the value of tokens owned by `account`.
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256) (inherited from IERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 1205:69:268

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from the caller's account to `to`.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transfer(address to, uint256 value) external returns (bool);;
```

### allowance(address,address) (inherited from IERC20)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1549:83:268

**Signature:**
```solidity
///  @dev Returns the remaining number of tokens that `spender` will be
///  allowed to spend on behalf of `owner` through {transferFrom}. This is
///  zero by default.
///  This value changes when {approve} or {transferFrom} are called.
function allowance(address owner, address spender) external view returns (uint256);;
```

### approve(address,uint256) (inherited from IERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 2310:73:268

**Signature:**
```solidity
///  @dev Sets a `value` amount of tokens as the allowance of `spender` over the
///  caller's tokens.
///  Returns a boolean value indicating whether the operation succeeded.
///  IMPORTANT: Beware that changing an allowance with this method brings the risk
///  that someone may use both the old and the new allowance by unfortunate
///  transaction ordering. One possible solution to mitigate this race
///  condition is to first reduce the spender's allowance to 0 and set the
///  desired value afterwards:
///  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
///  Emits an {Approval} event.
function approve(address spender, uint256 value) external returns (bool);;
```

### transferFrom(address,address,uint256) (inherited from IERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2691:87:268

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from `from` to `to` using the
///  allowance mechanism. `value` is then deducted from the caller's
///  allowance.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transferFrom(address from, address to, uint256 value) external returns (bool);;
```

### name() (inherited from IERC20Metadata)

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 378:54:271

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() external view returns (string memory);;
```

### symbol() (inherited from IERC20Metadata)

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 499:56:271

**Signature:**
```solidity
///  @dev Returns the symbol of the token.
function symbol() external view returns (string memory);;
```

### decimals() (inherited from IERC20Metadata)

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 631:50:271

**Signature:**
```solidity
///  @dev Returns the decimals places of the token.
function decimals() external view returns (uint8);;
```
