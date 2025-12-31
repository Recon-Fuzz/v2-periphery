# Interface: IERC7540CancelDeposit

## Metadata

- **Name**: IERC7540CancelDeposit
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/standards/ERC7540/IERC7540Vault.sol

## Events

### CancelDepositRequest

```solidity
event CancelDepositRequest(address indexed controller, uint256 indexed requestId, address sender);
```

### CancelDepositClaim

```solidity
event CancelDepositClaim(address indexed receiver, address indexed controller, uint256 indexed requestId, address sender, uint256 assets);
```

## Public/External Functions

### cancelDepositRequest(uint256,address)

- **Signature**: `cancelDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 7069:78:469

**Signature:**
```solidity
///  @dev Submits a Request for cancelling the pending deposit Request
///  - controller MUST be msg.sender unless some unspecified explicit approval is given by the caller,
///     approval of ERC-20 tokens from controller to sender is NOT enough.
///  - MUST set pendingCancelDepositRequest to `true` for the returned requestId after request
///  - MUST increase claimableCancelDepositRequest for the returned requestId after fulfillment
///  - SHOULD be claimable using `claimCancelDepositRequest`
///  Note: while `pendingCancelDepositRequest` is `true`, `requestDeposit` cannot be called
function cancelDepositRequest(uint256 requestId, address controller) external;;
```

### pendingCancelDepositRequest(uint256,address)

- **Signature**: `pendingCancelDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 7310:161:469

**Signature:**
```solidity
///  @dev Returns whether the deposit Request is pending cancelation
///  - MUST NOT show any variations depending on the caller.
function pendingCancelDepositRequest(uint256 requestId, address controller) external view returns (bool isPending);;
```

### claimableCancelDepositRequest(uint256,address)

- **Signature**: `claimableCancelDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 7671:172:469

**Signature:**
```solidity
///  @dev Returns the amount of assets that were canceled from a deposit Request, and can now be claimed.
///  - MUST NOT show any variations depending on the caller.
function claimableCancelDepositRequest(uint256 requestId, address controller) external view returns (uint256 claimableAssets);;
```

### claimCancelDepositRequest(uint256,address,address)

- **Signature**: `claimCancelDepositRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 8342:172:469

**Signature:**
```solidity
///  @dev Claims the canceled deposit assets, and removes the pending cancelation Request
///  - controller MUST be msg.sender unless some unspecified explicit approval is given by the caller,
///     approval of ERC-20 tokens from controller to sender is NOT enough.
///  - MUST set pendingCancelDepositRequest to `false` for the returned requestId after request
///  - MUST set claimableCancelDepositRequest to 0 for the returned requestId after fulfillment
function claimCancelDepositRequest(uint256 requestId, address receiver, address controller) external returns (uint256 assets);;
```
