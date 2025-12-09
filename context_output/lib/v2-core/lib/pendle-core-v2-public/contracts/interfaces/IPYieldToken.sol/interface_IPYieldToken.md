# Interface: IPYieldToken

## Metadata

- **Name**: IPYieldToken
- **Type**: Interface
- **Path**: lib/v2-core/lib/pendle-core-v2-public/contracts/interfaces/IPYieldToken.sol

## Implements Interfaces

- **IPInterestManagerYT** [lib/v2-core/lib/pendle-core-v2-public/contracts/interfaces/IPInterestManagerYT.sol/interface_IPInterestManagerYT.md]
- **IRewardManager** [lib/v2-core/lib/pendle-core-v2-public/contracts/interfaces/IRewardManager.sol/interface_IRewardManager.md]
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

### CollectInterestFee (inherited from IPInterestManagerYT)

```solidity
event CollectInterestFee(uint256 amountInterestFee);
```

### NewInterestIndex

```solidity
event NewInterestIndex(uint256 indexed newIndex);
```

### Mint

```solidity
event Mint(address indexed caller, address indexed receiverPT, address indexed receiverYT, uint256 amountSyToMint, uint256 amountPYOut);
```

### Burn

```solidity
event Burn(address indexed caller, address indexed receiver, uint256 amountPYToRedeem, uint256 amountSyOut);
```

### RedeemRewards

```solidity
event RedeemRewards(address indexed user, uint256[] amountRewardsOut);
```

### RedeemInterest

```solidity
event RedeemInterest(address indexed user, uint256 interestOut);
```

### CollectRewardFee

```solidity
event CollectRewardFee(address indexed rewardToken, uint256 amountRewardFee);
```

## Public/External Functions

### mintPY(address,address)

- **Signature**: `mintPY(address,address)`
- **Visibility**: external
- **Source Range**: 883:95:304

**Signature:**
```solidity
function mintPY(address receiverPT, address receiverYT) external returns (uint256 amountPYOut);;
```

### redeemPY(address)

- **Signature**: `redeemPY(address)`
- **Visibility**: external
- **Source Range**: 984:75:304

**Signature:**
```solidity
function redeemPY(address receiver) external returns (uint256 amountSyOut);;
```

### redeemPYMulti(address[],uint256[])

- **Signature**: `redeemPYMulti(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 1065:162:304

**Signature:**
```solidity
function redeemPYMulti(address[] calldata receivers, uint256[] calldata amountPYToRedeems) external returns (uint256[] memory amountSyOuts);;
```

### redeemDueInterestAndRewards(address,bool,bool)

- **Signature**: `redeemDueInterestAndRewards(address,bool,bool)`
- **Visibility**: external
- **Source Range**: 1233:190:304

**Signature:**
```solidity
function redeemDueInterestAndRewards(address user, bool redeemInterest, bool redeemRewards) external returns (uint256 interestOut, uint256[] memory rewardsOut);;
```

### rewardIndexesCurrent()

- **Signature**: `rewardIndexesCurrent()`
- **Visibility**: external
- **Source Range**: 1429:68:304

**Signature:**
```solidity
function rewardIndexesCurrent() external returns (uint256[] memory);;
```

### pyIndexCurrent()

- **Signature**: `pyIndexCurrent()`
- **Visibility**: external
- **Source Range**: 1503:53:304

**Signature:**
```solidity
function pyIndexCurrent() external returns (uint256);;
```

### pyIndexStored()

- **Signature**: `pyIndexStored()`
- **Visibility**: external
- **Source Range**: 1562:57:304

**Signature:**
```solidity
function pyIndexStored() external view returns (uint256);;
```

### getRewardTokens()

- **Signature**: `getRewardTokens()`
- **Visibility**: external
- **Source Range**: 1625:68:304

**Signature:**
```solidity
function getRewardTokens() external view returns (address[] memory);;
```

### SY()

- **Signature**: `SY()`
- **Visibility**: external
- **Source Range**: 1699:46:304

**Signature:**
```solidity
function SY() external view returns (address);;
```

### PT()

- **Signature**: `PT()`
- **Visibility**: external
- **Source Range**: 1751:46:304

**Signature:**
```solidity
function PT() external view returns (address);;
```

### factory()

- **Signature**: `factory()`
- **Visibility**: external
- **Source Range**: 1803:51:304

**Signature:**
```solidity
function factory() external view returns (address);;
```

### expiry()

- **Signature**: `expiry()`
- **Visibility**: external
- **Source Range**: 1860:50:304

**Signature:**
```solidity
function expiry() external view returns (uint256);;
```

### isExpired()

- **Signature**: `isExpired()`
- **Visibility**: external
- **Source Range**: 1916:50:304

**Signature:**
```solidity
function isExpired() external view returns (bool);;
```

### doCacheIndexSameBlock()

- **Signature**: `doCacheIndexSameBlock()`
- **Visibility**: external
- **Source Range**: 1972:62:304

**Signature:**
```solidity
function doCacheIndexSameBlock() external view returns (bool);;
```

### pyIndexLastUpdatedBlock()

- **Signature**: `pyIndexLastUpdatedBlock()`
- **Visibility**: external
- **Source Range**: 2040:67:304

**Signature:**
```solidity
function pyIndexLastUpdatedBlock() external view returns (uint128);;
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

### userReward(address,address) (inherited from IRewardManager)

- **Signature**: `userReward(address,address)`
- **Visibility**: external
- **Source Range**: 101:104:305

**Signature:**
```solidity
function userReward(address token, address user) external view returns (uint128 index, uint128 accrued);;
```

### userInterest(address) (inherited from IPInterestManagerYT)

- **Signature**: `userInterest(address)`
- **Visibility**: external
- **Source Range**: 164:105:301

**Signature:**
```solidity
function userInterest(address user) external view returns (uint128 lastPYIndex, uint128 accruedInterest);;
```
