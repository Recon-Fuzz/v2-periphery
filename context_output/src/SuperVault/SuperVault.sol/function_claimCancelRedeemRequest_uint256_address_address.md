# Function: claimCancelRedeemRequest(uint256,address,address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `claimCancelRedeemRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 10252:756:510

## Implementation

```solidity
/// @inheritdoc IERC7540CancelRedeem
function claimCancelRedeemRequest(uint256, address receiver, address controller) external returns (uint256 shares) {
    if ((receiver == address(0)) || (controller == address(0))) revert ZERO_ADDRESS();
    _validateControllerAndReceiver(controller, receiver);
    shares = strategy.claimableCancelRedeemRequest(controller);
    strategy.handleOperations7540(ISuperVaultStrategy.Operation.ClaimCancelRedeem, controller, address(0), 0);
    ISuperVaultEscrow(escrow).returnShares(receiver, shares);
    emit CancelRedeemClaim(receiver, controller, REQUEST_ID, msg.sender, shares);
}
```

## Related Implementations

### _validateControllerAndReceiver(address,address)

- **Kind**: internal
- **Source**: 23533:464:510
- **Link**: `src/SuperVault/SuperVault.sol:SuperVault:_validateControllerAndReceiver(address,address)`

```solidity
/// @notice Validates controller authorization and enforces operator receiver restrictions
///  @dev Controllers can set any receiver; operators must set receiver == controller
///  @param controller The controller address to validate authorization for
///  @param receiver The receiver address to validate against operator restrictions
function _validateControllerAndReceiver(address controller, address receiver) internal view {
    if (controller == msg.sender) return;
    if (!_isOperator(controller, msg.sender)) revert INVALID_CONTROLLER();
    if (receiver != controller) revert RECEIVER_MUST_EQUAL_CONTROLLER();
}
```

### _isOperator(address,address)

- **Kind**: internal
- **Source**: 24003:144:510
- **Link**: `src/SuperVault/SuperVault.sol:SuperVault:_isOperator(address,address)`

```solidity
function _isOperator(address controller, address operator) internal view returns (bool) {
    return isOperator[controller][operator];
}
```

## External Calls

- **ISuperVaultStrategy::claimableCancelRedeemRequest(address)**
- **ISuperVaultStrategy::handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256)**
- **ISuperVaultEscrow::returnShares(address,uint256)**

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]
- **escrow** (`address`)
- **REQUEST_ID** (`uint256`)
- **isOperator** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.claimCancelRedeemRequest(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperVault._validateControllerAndReceiver(address,address) (NodeID: 1)
      💬 Args: [controller, receiver]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperVault._isOperator(address,address) (NodeID: 2)
        💬 Args: [controller, msg.sender]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC7540CancelRedeem

### Interface Documentation

 @dev Claims the canceled redeem shares, and removes the pending cancelation Request
 - controller MUST be msg.sender unless some unspecified explicit approval is given by the caller,
    approval of ERC-20 tokens from controller to sender is NOT enough.
 - MUST set pendingCancelRedeemRequest to `false` for the returned requestId after request
 - MUST set claimableCancelRedeemRequest to 0 for the returned requestId after fulfillment
