# Interface: IERC7540Vault

## Metadata

- **Name**: IERC7540Vault
- **Type**: Interface
- **Path**: src/vendor/standards/ERC7540/IERC7540Vault.sol
- **Documentation**:  @title  IERC7540Vault
   @dev    This is the specific set of interfaces used by the SuperVaults

## Implements Interfaces

- **IERC7741** [src/vendor/standards/ERC7741/IERC7741.sol/interface_IERC7741.md]
- **IERC7540** [src/vendor/standards/ERC7540/IERC7540Vault.sol/interface_IERC7540.md]
- **IERC7540Redeem** [src/vendor/standards/ERC7540/IERC7540Vault.sol/interface_IERC7540Redeem.md]
- **IERC7540Deposit** [src/vendor/standards/ERC7540/IERC7540Vault.sol/interface_IERC7540Deposit.md]
- **IERC7540Operator** [src/vendor/standards/ERC7540/IERC7540Vault.sol/interface_IERC7540Operator.md]

## Events

### OperatorSet (inherited from IERC7540Operator)

```solidity
///  @dev The event emitted when an operator is set.
///  @param controller The address of the controller.
///  @param operator The address of the operator.
///  @param approved The approval status.
event OperatorSet(address indexed controller, address indexed operator, bool approved);
```

### DepositRequest (inherited from IERC7540Deposit)

```solidity
event DepositRequest(address indexed controller, address indexed owner, uint256 indexed requestId, address sender, uint256 assets);
```

### RedeemRequest (inherited from IERC7540Redeem)

```solidity
event RedeemRequest(address indexed controller, address indexed owner, uint256 indexed requestId, address sender, uint256 assets);
```

### DepositClaimable

```solidity
event DepositClaimable(address indexed controller, uint256 indexed requestId, uint256 assets, uint256 shares);
```

### RedeemClaimable

```solidity
event RedeemClaimable(address indexed controller, uint256 indexed requestId, uint256 assets, uint256 shares);
```

## Public/External Functions

### setOperator(address,bool) (inherited from IERC7540Operator)

- **Signature**: `setOperator(address,bool)`
- **Visibility**: external
- **Source Range**: 717:78:540

**Signature:**
```solidity
///  @dev Sets or removes an operator for the caller.
///  @param operator The address of the operator.
///  @param approved The approval status.
///  @return Whether the call was executed successfully or not
function setOperator(address operator, bool approved) external returns (bool);;
```

### isOperator(address,address) (inherited from IERC7540Operator)

- **Signature**: `isOperator(address,address)`
- **Visibility**: external
- **Source Range**: 1067:94:540

**Signature:**
```solidity
///  @dev Returns `true` if the `operator` is approved as an operator for an `controller`.
///  @param controller The address of the controller.
///  @param operator The address of the operator.
///  @return status The approval status
function isOperator(address controller, address operator) external view returns (bool status);;
```

### requestDeposit(uint256,address,address) (inherited from IERC7540Deposit)

- **Signature**: `requestDeposit(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 2175:112:540

**Signature:**
```solidity
///  @dev Transfers assets from sender into the Vault and submits a Request for asynchronous deposit.
///  - MUST support ERC-20 approve / transferFrom on asset as a deposit Request flow.
///  - MUST revert if all of assets cannot be requested for deposit.
///  - owner MUST be msg.sender unless some unspecified explicit approval is given by the caller,
///     approval of ERC-20 tokens from owner to sender is NOT enough.
///  @param assets the amount of deposit assets to transfer from owner
///  @param controller the controller of the request who will be able to operate the request
///  @param owner the source of the deposit assets
///  NOTE: most implementations will require pre-approval of the Vault with the Vault's underlying asset token.
function requestDeposit(uint256 assets, address controller, address owner) external returns (uint256 requestId);;
```

### pendingDepositRequest(uint256,address) (inherited from IERC7540Deposit)

- **Signature**: `pendingDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 2620:116:540

**Signature:**
```solidity
///  @dev Returns the amount of requested assets in Pending state.
///  - MUST NOT include any assets in Claimable state for deposit or mint.
///  - MUST NOT show any variations depending on the caller.
///  - MUST NOT revert unless due to integer overflow caused by an unreasonably large input.
function pendingDepositRequest(uint256 requestId, address controller) external view returns (uint256 pendingAssets);;
```

### claimableDepositRequest(uint256,address) (inherited from IERC7540Deposit)

- **Signature**: `claimableDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 3087:166:540

**Signature:**
```solidity
///  @dev Returns the amount of requested assets in Claimable state for the controller to deposit or mint.
///  - MUST NOT include any assets in Pending state.
///  - MUST NOT show any variations depending on the caller.
///  - MUST NOT revert unless due to integer overflow caused by an unreasonably large input.
function claimableDepositRequest(uint256 requestId, address controller) external view returns (uint256 claimableAssets);;
```

### deposit(uint256,address,address) (inherited from IERC7540Deposit)

- **Signature**: `deposit(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 3521:105:540

**Signature:**
```solidity
///  @dev Mints shares Vault shares to receiver by claiming the Request of the controller.
///  - MUST emit the Deposit event.
///  - controller MUST equal msg.sender unless the controller has approved the msg.sender as an operator.
function deposit(uint256 assets, address receiver, address controller) external returns (uint256 shares);;
```

### mint(uint256,address,address) (inherited from IERC7540Deposit)

- **Signature**: `mint(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 3902:102:540

**Signature:**
```solidity
///  @dev Mints exactly shares Vault shares to receiver by claiming the Request of the controller.
///  - MUST emit the Deposit event.
///  - controller MUST equal msg.sender unless the controller has approved the msg.sender as an operator.
function mint(uint256 shares, address receiver, address controller) external returns (uint256 assets);;
```

### requestRedeem(uint256,address,address) (inherited from IERC7540Redeem)

- **Signature**: `requestRedeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 4940:111:540

**Signature:**
```solidity
///  @dev Assumes control of shares from sender into the Vault and submits a Request for asynchronous redeem.
///  - MUST support a redeem Request flow where the control of shares is taken from sender directly
///    where msg.sender has ERC-20 approval over the shares of owner.
///  - MUST revert if all of shares cannot be requested for redeem.
///  @param shares the amount of shares to be redeemed to transfer from owner
///  @param controller the controller of the request who will be able to operate the request
///  @param owner the source of the shares to be redeemed
///  NOTE: most implementations will require pre-approval of the Vault with the Vault's share token.
function requestRedeem(uint256 shares, address controller, address owner) external returns (uint256 requestId);;
```

### pendingRedeemRequest(uint256,address) (inherited from IERC7540Redeem)

- **Signature**: `pendingRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 5387:115:540

**Signature:**
```solidity
///  @dev Returns the amount of requested shares in Pending state.
///  - MUST NOT include any shares in Claimable state for redeem or withdraw.
///  - MUST NOT show any variations depending on the caller.
///  - MUST NOT revert unless due to integer overflow caused by an unreasonably large input.
function pendingRedeemRequest(uint256 requestId, address controller) external view returns (uint256 pendingShares);;
```

### claimableRedeemRequest(uint256,address) (inherited from IERC7540Redeem)

- **Signature**: `claimableRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 5879:165:540

**Signature:**
```solidity
///  @dev Returns the amount of requested shares in Claimable state for the controller to redeem or withdraw.
///  - MUST NOT include any shares in Pending state for redeem or withdraw.
///  - MUST NOT show any variations depending on the caller.
///  - MUST NOT revert unless due to integer overflow caused by an unreasonably large input.
function claimableRedeemRequest(uint256 requestId, address controller) external view returns (uint256 claimableShares);;
```

### authorizeOperator(address,address,bool,bytes32,uint256,bytes) (inherited from IERC7741)

- **Signature**: `authorizeOperator(address,address,bool,bytes32,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 272:231:542

**Signature:**
```solidity
///  @dev Grants or revokes permissions for `operator` to manage Requests on behalf of the
///       `msg.sender`, using an [EIP-712](./eip-712.md) signature.
function authorizeOperator(address controller, address operator, bool approved, bytes32 nonce, uint256 deadline, bytes memory signature) external returns (bool);;
```

### invalidateNonce(bytes32) (inherited from IERC7741)

- **Signature**: `invalidateNonce(bytes32)`
- **Visibility**: external
- **Source Range**: 596:49:542

**Signature:**
```solidity
///  @dev Revokes the given `nonce` for `msg.sender` as the `owner`.
function invalidateNonce(bytes32 nonce) external;;
```

### authorizations(address,bytes32) (inherited from IERC7741)

- **Signature**: `authorizations(address,bytes32)`
- **Visibility**: external
- **Source Range**: 749:93:542

**Signature:**
```solidity
///  @dev Returns whether the given `nonce` has been used for the `controller`.
function authorizations(address controller, bytes32 nonce) external view returns (bool used);;
```

### DOMAIN_SEPARATOR() (inherited from IERC7741)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 1148:60:542

**Signature:**
```solidity
///  @dev Returns the `DOMAIN_SEPARATOR` as defined according to EIP-712. The `DOMAIN_SEPARATOR
///       should be unique to the contract and chain to prevent replay attacks from other domains,
///       and satisfy the requirements of EIP-712, but is otherwise unconstrained.
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```
