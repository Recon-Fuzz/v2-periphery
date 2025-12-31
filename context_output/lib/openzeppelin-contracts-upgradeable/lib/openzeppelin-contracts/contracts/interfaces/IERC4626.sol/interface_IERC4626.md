# Interface: IERC4626

## Metadata

- **Name**: IERC4626
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol
- **Documentation**:  @dev Interface of the ERC-4626 "Tokenized Vault Standard", as defined in
   https://eips.ethereum.org/EIPS/eip-4626[ERC-4626].

## Implements Interfaces

- **IERC20Metadata** [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

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
event Deposit(address indexed sender, address indexed owner, uint256 assets, uint256 shares);
```

### Withdraw

```solidity
event Withdraw(address indexed sender, address indexed receiver, address indexed owner, uint256 assets, uint256 shares);
```

## Public/External Functions

### asset()

- **Signature**: `asset()`
- **Visibility**: external
- **Source Range**: 933:67:44

**Signature:**
```solidity
///  @dev Returns the address of the underlying token used for the Vault for accounting, depositing, and withdrawing.
///  - MUST be an ERC-20 token contract.
///  - MUST NOT revert.
function asset() external view returns (address assetTokenAddress);;
```

### totalAssets()

- **Signature**: `totalAssets()`
- **Visibility**: external
- **Source Range**: 1297:74:44

**Signature:**
```solidity
///  @dev Returns the total amount of the underlying asset that is “managed” by Vault.
///  - SHOULD include any compounding that occurs from yield.
///  - MUST be inclusive of any fees that are charged against assets in the Vault.
///  - MUST NOT revert.
function totalAssets() external view returns (uint256 totalManagedAssets);;
```

### convertToShares(uint256)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: external
- **Source Range**: 2102:80:44

**Signature:**
```solidity
///  @dev Returns the amount of shares that the Vault would exchange for the amount of assets provided, in an ideal
///  scenario where all the conditions are met.
///  - MUST NOT be inclusive of any fees that are charged against assets in the Vault.
///  - MUST NOT show any variations depending on the caller.
///  - MUST NOT reflect slippage or other on-chain conditions, when performing the actual exchange.
///  - MUST NOT revert.
///  NOTE: This calculation MAY NOT reflect the “per-user” price-per-share, and instead should reflect the
///  “average-user’s” price-per-share, meaning what the average user should expect to see when exchanging to and
///  from.
function convertToShares(uint256 assets) external view returns (uint256 shares);;
```

### convertToAssets(uint256)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: external
- **Source Range**: 2913:80:44

**Signature:**
```solidity
///  @dev Returns the amount of assets that the Vault would exchange for the amount of shares provided, in an ideal
///  scenario where all the conditions are met.
///  - MUST NOT be inclusive of any fees that are charged against assets in the Vault.
///  - MUST NOT show any variations depending on the caller.
///  - MUST NOT reflect slippage or other on-chain conditions, when performing the actual exchange.
///  - MUST NOT revert.
///  NOTE: This calculation MAY NOT reflect the “per-user” price-per-share, and instead should reflect the
///  “average-user’s” price-per-share, meaning what the average user should expect to see when exchanging to and
///  from.
function convertToAssets(uint256 shares) external view returns (uint256 assets);;
```

### maxDeposit(address)

- **Signature**: `maxDeposit(address)`
- **Visibility**: external
- **Source Range**: 3390:80:44

**Signature:**
```solidity
///  @dev Returns the maximum amount of the underlying asset that can be deposited into the Vault for the receiver,
///  through a deposit call.
///  - MUST return a limited value if receiver is subject to some deposit limit.
///  - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of assets that may be deposited.
///  - MUST NOT revert.
function maxDeposit(address receiver) external view returns (uint256 maxAssets);;
```

### previewDeposit(uint256)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: external
- **Source Range**: 4493:79:44

**Signature:**
```solidity
///  @dev Allows an on-chain or off-chain user to simulate the effects of their deposit at the current block, given
///  current on-chain conditions.
///  - MUST return as close to and no more than the exact amount of Vault shares that would be minted in a deposit
///    call in the same transaction. I.e. deposit should return the same or more shares as previewDeposit if called
///    in the same transaction.
///  - MUST NOT account for deposit limits like those returned from maxDeposit and should always act as though the
///    deposit would be accepted, regardless if the user has enough tokens approved, etc.
///  - MUST be inclusive of deposit fees. Integrators should be aware of the existence of deposit fees.
///  - MUST NOT revert.
///  NOTE: any unfavorable discrepancy between convertToShares and previewDeposit SHOULD be considered slippage in
///  share price or some other type of condition, meaning the depositor will lose assets by depositing.
function previewDeposit(uint256 assets) external view returns (uint256 shares);;
```

### deposit(uint256,address)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: external
- **Source Range**: 5234:85:44

**Signature:**
```solidity
///  @dev Mints shares Vault shares to receiver by depositing exactly amount of underlying tokens.
///  - MUST emit the Deposit event.
///  - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
///    deposit execution, and are accounted for during deposit.
///  - MUST revert if all of assets cannot be deposited (due to deposit limit being reached, slippage, the user not
///    approving enough underlying tokens to the Vault contract, etc).
///  NOTE: most implementations will require pre-approval of the Vault with the Vault’s underlying asset token.
function deposit(uint256 assets, address receiver) external returns (uint256 shares);;
```

### maxMint(address)

- **Signature**: `maxMint(address)`
- **Visibility**: external
- **Source Range**: 5671:77:44

**Signature:**
```solidity
///  @dev Returns the maximum amount of the Vault shares that can be minted for the receiver, through a mint call.
///  - MUST return a limited value if receiver is subject to some mint limit.
///  - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of shares that may be minted.
///  - MUST NOT revert.
function maxMint(address receiver) external view returns (uint256 maxShares);;
```

### previewMint(uint256)

- **Signature**: `previewMint(uint256)`
- **Visibility**: external
- **Source Range**: 6743:76:44

**Signature:**
```solidity
///  @dev Allows an on-chain or off-chain user to simulate the effects of their mint at the current block, given
///  current on-chain conditions.
///  - MUST return as close to and no fewer than the exact amount of assets that would be deposited in a mint call
///    in the same transaction. I.e. mint should return the same or fewer assets as previewMint if called in the
///    same transaction.
///  - MUST NOT account for mint limits like those returned from maxMint and should always act as though the mint
///    would be accepted, regardless if the user has enough tokens approved, etc.
///  - MUST be inclusive of deposit fees. Integrators should be aware of the existence of deposit fees.
///  - MUST NOT revert.
///  NOTE: any unfavorable discrepancy between convertToAssets and previewMint SHOULD be considered slippage in
///  share price or some other type of condition, meaning the depositor will lose assets by minting.
function previewMint(uint256 shares) external view returns (uint256 assets);;
```

### mint(uint256,address)

- **Signature**: `mint(uint256,address)`
- **Visibility**: external
- **Source Range**: 7472:82:44

**Signature:**
```solidity
///  @dev Mints exactly shares Vault shares to receiver by depositing amount of underlying tokens.
///  - MUST emit the Deposit event.
///  - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the mint
///    execution, and are accounted for during mint.
///  - MUST revert if all of shares cannot be minted (due to deposit limit being reached, slippage, the user not
///    approving enough underlying tokens to the Vault contract, etc).
///  NOTE: most implementations will require pre-approval of the Vault with the Vault’s underlying asset token.
function mint(uint256 shares, address receiver) external returns (uint256 assets);;
```

### maxWithdraw(address)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: external
- **Source Range**: 7858:78:44

**Signature:**
```solidity
///  @dev Returns the maximum amount of the underlying asset that can be withdrawn from the owner balance in the
///  Vault, through a withdraw call.
///  - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
///  - MUST NOT revert.
function maxWithdraw(address owner) external view returns (uint256 maxAssets);;
```

### previewWithdraw(uint256)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: external
- **Source Range**: 8981:80:44

**Signature:**
```solidity
///  @dev Allows an on-chain or off-chain user to simulate the effects of their withdrawal at the current block,
///  given current on-chain conditions.
///  - MUST return as close to and no fewer than the exact amount of Vault shares that would be burned in a withdraw
///    call in the same transaction. I.e. withdraw should return the same or fewer shares as previewWithdraw if
///    called
///    in the same transaction.
///  - MUST NOT account for withdrawal limits like those returned from maxWithdraw and should always act as though
///    the withdrawal would be accepted, regardless if the user has enough shares, etc.
///  - MUST be inclusive of withdrawal fees. Integrators should be aware of the existence of withdrawal fees.
///  - MUST NOT revert.
///  NOTE: any unfavorable discrepancy between convertToShares and previewWithdraw SHOULD be considered slippage in
///  share price or some other type of condition, meaning the depositor will lose assets by depositing.
function previewWithdraw(uint256 assets) external view returns (uint256 shares);;
```

### withdraw(uint256,address,address)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 9742:101:44

**Signature:**
```solidity
///  @dev Burns shares from owner and sends exactly assets of underlying tokens to receiver.
///  - MUST emit the Withdraw event.
///  - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
///    withdraw execution, and are accounted for during withdraw.
///  - MUST revert if all of assets cannot be withdrawn (due to withdrawal limit being reached, slippage, the owner
///    not having enough shares, etc).
///  Note that some implementations will require pre-requesting to the Vault before a withdrawal may be performed.
///  Those methods should be performed separately.
function withdraw(uint256 assets, address receiver, address owner) external returns (uint256 shares);;
```

### maxRedeem(address)

- **Signature**: `maxRedeem(address)`
- **Visibility**: external
- **Source Range**: 10235:76:44

**Signature:**
```solidity
///  @dev Returns the maximum amount of Vault shares that can be redeemed from the owner balance in the Vault,
///  through a redeem call.
///  - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
///  - MUST return balanceOf(owner) if owner is not subject to any withdrawal limit or timelock.
///  - MUST NOT revert.
function maxRedeem(address owner) external view returns (uint256 maxShares);;
```

### previewRedeem(uint256)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: external
- **Source Range**: 11331:78:44

**Signature:**
```solidity
///  @dev Allows an on-chain or off-chain user to simulate the effects of their redemption at the current block,
///  given current on-chain conditions.
///  - MUST return as close to and no more than the exact amount of assets that would be withdrawn in a redeem call
///    in the same transaction. I.e. redeem should return the same or more assets as previewRedeem if called in the
///    same transaction.
///  - MUST NOT account for redemption limits like those returned from maxRedeem and should always act as though the
///    redemption would be accepted, regardless if the user has enough shares, etc.
///  - MUST be inclusive of withdrawal fees. Integrators should be aware of the existence of withdrawal fees.
///  - MUST NOT revert.
///  NOTE: any unfavorable discrepancy between convertToAssets and previewRedeem SHOULD be considered slippage in
///  share price or some other type of condition, meaning the depositor will lose assets by redeeming.
function previewRedeem(uint256 shares) external view returns (uint256 assets);;
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 12081:99:44

**Signature:**
```solidity
///  @dev Burns exactly shares from owner and sends assets of underlying tokens to receiver.
///  - MUST emit the Withdraw event.
///  - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
///    redeem execution, and are accounted for during redeem.
///  - MUST revert if all of shares cannot be redeemed (due to withdrawal limit being reached, slippage, the owner
///    not having enough shares, etc).
///  NOTE: some implementations will require pre-requesting to the Vault before a withdrawal may be performed.
///  Those methods should be performed separately.
function redeem(uint256 shares, address receiver, address owner) external returns (uint256 assets);;
```

### totalSupply() (inherited from IERC20)

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 776:55:49

**Signature:**
```solidity
///  @dev Returns the value of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address) (inherited from IERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 913:68:49

**Signature:**
```solidity
///  @dev Returns the value of tokens owned by `account`.
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256) (inherited from IERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 1205:69:49

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
- **Source Range**: 1549:83:49

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
- **Source Range**: 2310:73:49

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
- **Source Range**: 2691:87:49

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
- **Source Range**: 378:54:50

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() external view returns (string memory);;
```

### symbol() (inherited from IERC20Metadata)

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 499:56:50

**Signature:**
```solidity
///  @dev Returns the symbol of the token.
function symbol() external view returns (string memory);;
```

### decimals() (inherited from IERC20Metadata)

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 631:50:50

**Signature:**
```solidity
///  @dev Returns the decimals places of the token.
function decimals() external view returns (uint8);;
```
