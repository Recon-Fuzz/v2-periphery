# Interface: IERC7540Deposit

## Metadata

- **Name**: IERC7540Deposit
- **Type**: Interface
- **Path**: src/vendor/standards/ERC7540/IERC7540Vault.sol

## Implements Interfaces

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

### DepositRequest

```solidity
event DepositRequest(address indexed controller, address indexed owner, uint256 indexed requestId, address sender, uint256 assets);
```

## Public/External Functions

### requestDeposit(uint256,address,address)

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

### pendingDepositRequest(uint256,address)

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

### claimableDepositRequest(uint256,address)

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

### deposit(uint256,address,address)

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

### mint(uint256,address,address)

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
