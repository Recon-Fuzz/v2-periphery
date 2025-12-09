# Interface: IERC7540

## Metadata

- **Name**: IERC7540
- **Type**: Interface
- **Path**: src/vendor/vaults/7540/IERC7540.sol

## Implements Interfaces

- **IERC7575** [src/vendor/vaults/7540/IERC7540.sol/interface_IERC7575.md]

## Events

### Deposit (inherited from IERC7575)

```solidity
event Deposit(address indexed sender, address indexed owner, uint256 assets, uint256 shares);
```

### Withdraw (inherited from IERC7575)

```solidity
event Withdraw(address indexed sender, address indexed receiver, address indexed owner, uint256 assets, uint256 shares);
```

### DepositRequest

```solidity
event DepositRequest(address indexed controller, address indexed owner, uint256 indexed requestId, address sender, uint256 assets);
```

### RedeemRequest

```solidity
event RedeemRequest(address indexed controller, address indexed owner, uint256 indexed requestId, address sender, uint256 assets);
```

## Public/External Functions

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 12726:76:544

**Signature:**
```solidity
/// @notice Check if the contract supports an interface
///  @param interfaceId The selector of the interface to check
function supportsInterface(bytes4 interfaceId) external view returns (bool);;
```

### previewRedeem(uint256)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: external
- **Source Range**: 12958:78:544

**Signature:**
```solidity
/// @notice Preview the amount of assets that would be received for a given amount of shares
///  @param shares The amount of shares to redeem
function previewRedeem(uint256 shares) external view returns (uint256 assets);;
```

### pendingDepositRequest(uint256,address)

- **Signature**: `pendingDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 13208:102:544

**Signature:**
```solidity
/// @notice Check if a deposit request is pending
///  @param requestId The id of the request to check
///  @param controller The address of the controller
function pendingDepositRequest(uint256 requestId, address controller) external view returns (uint256);;
```

### pendingCancelDepositRequest(uint256,address)

- **Signature**: `pendingCancelDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 13495:105:544

**Signature:**
```solidity
/// @notice Check if a deposit request is pending cancellation
///  @param requestId The id of the request to check
///  @param controller The address of the controller
function pendingCancelDepositRequest(uint256 requestId, address controller) external view returns (bool);;
```

### pendingRedeemRequest(uint256,address)

- **Signature**: `pendingRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 13771:101:544

**Signature:**
```solidity
/// @notice Check if a redeem request is pending
///  @param requestId The id of the request to check
///  @param controller The address of the controller
function pendingRedeemRequest(uint256 requestId, address controller) external view returns (uint256);;
```

### claimableDepositRequest(uint256,address)

- **Signature**: `claimableDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 14074:104:544

**Signature:**
```solidity
/// @notice Get the amount of assets that can be claimed from a deposit request
///  @param requestId The id of the request to check
///  @param controller The address of the controller
function claimableDepositRequest(uint256 requestId, address controller) external view returns (uint256);;
```

### claimableRedeemRequest(uint256,address)

- **Signature**: `claimableRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 14379:103:544

**Signature:**
```solidity
/// @notice Get the amount of shares that can be claimed from a redeem request
///  @param requestId The id of the request to check
///  @param controller The address of the controller
function claimableRedeemRequest(uint256 requestId, address controller) external view returns (uint256);;
```

### pendingCancelRedeemRequest(uint256,address)

- **Signature**: `pendingCancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 14666:104:544

**Signature:**
```solidity
/// @notice Check if a redeem request is pending cancellation
///  @param requestId The id of the request to check
///  @param controller The address of the controller
function pendingCancelRedeemRequest(uint256 requestId, address controller) external view returns (bool);;
```

### deposit(uint256,address,address)

- **Signature**: `deposit(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 15287:105:544

**Signature:**
```solidity
/// @notice Mints amount of shares by claiming the controller's request
///  @dev sender must be the controller or an operator approved by the controller
///  @param assets The amount of assets to deposit
///  @param receiver The address of the receiver
///  @param controller The address of the controller
function deposit(uint256 assets, address receiver, address controller) external returns (uint256 shares);;
```

### mint(uint256,address,address)

- **Signature**: `mint(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 15653:102:544

**Signature:**
```solidity
/// @notice Mint exact amount of shares into the vault by claiming the controller's request
///  @param shares The amount of shares to mint
///  @param receiver The address of the receiver
///  @param controller The address of the controller
function mint(uint256 shares, address receiver, address controller) external returns (uint256 assets);;
```

### withdraw(uint256,address,address)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 16006:101:544

**Signature:**
```solidity
/// @notice Burn shares from the vault and sends exact amount of assets to the receiver
///  @param assets The amount of assets to withdraw
///  @param receiver The address of the receiver
///  @param owner The address of the owner
function withdraw(uint256 assets, address receiver, address owner) external returns (uint256 shares);;
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 16347:99:544

**Signature:**
```solidity
/// @notice Burns exact shares from the vault and sends assets to the receiver
///  @param shares The amount of shares to redeem
///  @param receiver The address of the receiver
///  @param owner The address of the owner
function redeem(uint256 shares, address receiver, address owner) external returns (uint256 assets);;
```

### requestDeposit(uint256,address,address)

- **Signature**: `requestDeposit(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 16652:112:544

**Signature:**
```solidity
/// @notice Request a deposit of assets
///  @param assets The amount of assets to deposit
///  @param controller The address of the controller
///  @param owner The address of the owner
function requestDeposit(uint256 assets, address controller, address owner) external returns (uint256 requestId);;
```

### requestRedeem(uint256,address,address)

- **Signature**: `requestRedeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 16968:111:544

**Signature:**
```solidity
/// @notice Request a redeem of shares
///  @param shares The amount of shares to redeem
///  @param controller The address of the controller
///  @param owner The address of the owner
function requestRedeem(uint256 shares, address controller, address owner) external returns (uint256 requestId);;
```

### cancelDepositRequest(uint256,address)

- **Signature**: `cancelDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 17239:78:544

**Signature:**
```solidity
/// @notice Cancel a deposit request
///  @param requestId The id of the request to cancel
///  @param controller The address of the controller
function cancelDepositRequest(uint256 requestId, address controller) external;;
```

### claimCancelDepositRequest(uint256,address,address)

- **Signature**: `claimCancelDepositRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 17626:172:544

**Signature:**
```solidity
/// @notice Claims the canceled deposit assets, and removes the pending cancelation Request
///  @dev sender must be the controller
///  @param requestId The id of the request to claim
///  @param receiver The address of the receiver
///  @param controller The address of the controller
function claimCancelDepositRequest(uint256 requestId, address receiver, address controller) external returns (uint256 assets);;
```

### cancelRedeemRequest(uint256,address)

- **Signature**: `cancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 17957:77:544

**Signature:**
```solidity
/// @notice Cancel a redeem request
///  @param requestId The id of the request to cancel
///  @param controller The address of the controller
function cancelRedeemRequest(uint256 requestId, address controller) external;;
```

### claimCancelRedeemRequest(uint256,address,address)

- **Signature**: `claimCancelRedeemRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 18342:171:544

**Signature:**
```solidity
/// @notice Claims the canceled redeem shares, and removes the pending cancelation Request
///  @dev sender must be the controller
///  @param requestId The id of the request to claim
///  @param receiver The address of the receiver
///  @param controller The address of the controller
function claimCancelRedeemRequest(uint256 requestId, address receiver, address controller) external returns (uint256 shares);;
```

### poolId()

- **Signature**: `poolId()`
- **Visibility**: external
- **Source Range**: 18551:49:544

**Signature:**
```solidity
/// @notice Get the pool id
function poolId() external view returns (uint64);;
```

### trancheId()

- **Signature**: `trancheId()`
- **Visibility**: external
- **Source Range**: 18641:53:544

**Signature:**
```solidity
/// @notice Get the tranche id
function trancheId() external view returns (bytes16);;
```

### setOperator(address,bool)

- **Signature**: `setOperator(address,bool)`
- **Visibility**: external
- **Source Range**: 18885:78:544

**Signature:**
```solidity
function setOperator(address operator, bool approved) external returns (bool);;
```

### isOperator(address,address)

- **Signature**: `isOperator(address,address)`
- **Visibility**: external
- **Source Range**: 18968:94:544

**Signature:**
```solidity
function isOperator(address controller, address operator) external view returns (bool status);;
```

### asset() (inherited from IERC7575)

- **Signature**: `asset()`
- **Visibility**: external
- **Source Range**: 539:67:544

**Signature:**
```solidity
///  @dev Returns the address of the underlying token used for the Vault for accounting, depositing, and withdrawing.
///  - MUST be an ERC-20 token contract.
///  - MUST NOT revert.
function asset() external view returns (address assetTokenAddress);;
```

### share() (inherited from IERC7575)

- **Signature**: `share()`
- **Visibility**: external
- **Source Range**: 755:67:544

**Signature:**
```solidity
///  @dev Returns the address of the share token
///  - MUST be an ERC-20 token contract.
///  - MUST NOT revert.
function share() external view returns (address shareTokenAddress);;
```

### convertToShares(uint256) (inherited from IERC7575)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: external
- **Source Range**: 1553:80:544

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

### convertToAssets(uint256) (inherited from IERC7575)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: external
- **Source Range**: 2364:80:544

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

### totalAssets() (inherited from IERC7575)

- **Signature**: `totalAssets()`
- **Visibility**: external
- **Source Range**: 2741:74:544

**Signature:**
```solidity
///  @dev Returns the total amount of the underlying asset that is “managed” by Vault.
///  - SHOULD include any compounding that occurs from yield.
///  - MUST be inclusive of any fees that are charged against assets in the Vault.
///  - MUST NOT revert.
function totalAssets() external view returns (uint256 totalManagedAssets);;
```

### maxDeposit(address) (inherited from IERC7575)

- **Signature**: `maxDeposit(address)`
- **Visibility**: external
- **Source Range**: 3212:80:544

**Signature:**
```solidity
///  @dev Returns the maximum amount of the underlying asset that can be deposited into the Vault for the receiver,
///  through a deposit call.
///  - MUST return a limited value if receiver is subject to some deposit limit.
///  - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of assets that may be deposited.
///  - MUST NOT revert.
function maxDeposit(address receiver) external view returns (uint256 maxAssets);;
```

### previewDeposit(uint256) (inherited from IERC7575)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: external
- **Source Range**: 4315:79:544

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

### deposit(uint256,address) (inherited from IERC7575)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: external
- **Source Range**: 5056:85:544

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

### maxMint(address) (inherited from IERC7575)

- **Signature**: `maxMint(address)`
- **Visibility**: external
- **Source Range**: 5493:77:544

**Signature:**
```solidity
///  @dev Returns the maximum amount of the Vault shares that can be minted for the receiver, through a mint call.
///  - MUST return a limited value if receiver is subject to some mint limit.
///  - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of shares that may be minted.
///  - MUST NOT revert.
function maxMint(address receiver) external view returns (uint256 maxShares);;
```

### previewMint(uint256) (inherited from IERC7575)

- **Signature**: `previewMint(uint256)`
- **Visibility**: external
- **Source Range**: 6565:76:544

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

### mint(uint256,address) (inherited from IERC7575)

- **Signature**: `mint(uint256,address)`
- **Visibility**: external
- **Source Range**: 7294:82:544

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

### maxWithdraw(address) (inherited from IERC7575)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: external
- **Source Range**: 7680:78:544

**Signature:**
```solidity
///  @dev Returns the maximum amount of the underlying asset that can be withdrawn from the owner balance in the
///  Vault, through a withdraw call.
///  - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
///  - MUST NOT revert.
function maxWithdraw(address owner) external view returns (uint256 maxAssets);;
```

### previewWithdraw(uint256) (inherited from IERC7575)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: external
- **Source Range**: 8803:80:544

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

### maxRedeem(address) (inherited from IERC7575)

- **Signature**: `maxRedeem(address)`
- **Visibility**: external
- **Source Range**: 10057:76:544

**Signature:**
```solidity
///  @dev Returns the maximum amount of Vault shares that can be redeemed from the owner balance in the Vault,
///  through a redeem call.
///  - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
///  - MUST return balanceOf(owner) if owner is not subject to any withdrawal limit or timelock.
///  - MUST NOT revert.
function maxRedeem(address owner) external view returns (uint256 maxShares);;
```
