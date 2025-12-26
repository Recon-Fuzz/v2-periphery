# Interface: IERC7540CancelRedeem

## Metadata

- **Name**: IERC7540CancelRedeem
- **Type**: Interface
- **Path**: lib/v2-core/src/vendor/standards/ERC7540/IERC7540Vault.sol

## Events

### CancelRedeemRequest

```solidity
event CancelRedeemRequest(address indexed controller, uint256 indexed requestId, address sender);
```

### CancelRedeemClaim

```solidity
event CancelRedeemClaim(address indexed receiver, address indexed controller, uint256 indexed requestId, address sender, uint256 shares);
```

## Public/External Functions

### cancelRedeemRequest(uint256,address)

- **Signature**: `cancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9438:77:469

**Signature:**
```solidity
///  @dev Submits a Request for cancelling the pending redeem Request
///  - controller MUST be msg.sender unless some unspecified explicit approval is given by the caller,
///     approval of ERC-20 tokens from controller to sender is NOT enough.
///  - MUST set pendingCancelRedeemRequest to `true` for the returned requestId after request
///  - MUST increase claimableCancelRedeemRequest for the returned requestId after fulfillment
///  - SHOULD be claimable using `claimCancelRedeemRequest`
///  Note: while `pendingCancelRedeemRequest` is `true`, `requestRedeem` cannot be called
function cancelRedeemRequest(uint256 requestId, address controller) external;;
```

### pendingCancelRedeemRequest(uint256,address)

- **Signature**: `pendingCancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9677:114:469

**Signature:**
```solidity
///  @dev Returns whether the redeem Request is pending cancelation
///  - MUST NOT show any variations depending on the caller.
function pendingCancelRedeemRequest(uint256 requestId, address controller) external view returns (bool isPending);;
```

### claimableCancelRedeemRequest(uint256,address)

- **Signature**: `claimableCancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9990:171:469

**Signature:**
```solidity
///  @dev Returns the amount of shares that were canceled from a redeem Request, and can now be claimed.
///  - MUST NOT show any variations depending on the caller.
function claimableCancelRedeemRequest(uint256 requestId, address controller) external view returns (uint256 claimableShares);;
```

### claimCancelRedeemRequest(uint256,address,address)

- **Signature**: `claimCancelRedeemRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 10657:171:469

**Signature:**
```solidity
///  @dev Claims the canceled redeem shares, and removes the pending cancelation Request
///  - controller MUST be msg.sender unless some unspecified explicit approval is given by the caller,
///     approval of ERC-20 tokens from controller to sender is NOT enough.
///  - MUST set pendingCancelRedeemRequest to `false` for the returned requestId after request
///  - MUST set claimableCancelRedeemRequest to 0 for the returned requestId after fulfillment
function claimCancelRedeemRequest(uint256 requestId, address receiver, address controller) external returns (uint256 shares);;
```
