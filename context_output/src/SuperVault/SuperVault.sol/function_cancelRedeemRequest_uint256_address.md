# Function: cancelRedeemRequest(uint256,address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `cancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9802:403:510

## Implementation

```solidity
/// @inheritdoc IERC7540CancelRedeem
function cancelRedeemRequest(uint256, address controller) external {
    _validateController(controller);
    strategy.handleOperations7540(ISuperVaultStrategy.Operation.CancelRedeemRequest, controller, address(0), 0);
    emit CancelRedeemRequest(controller, REQUEST_ID, msg.sender);
}
```

## Related Implementations

### _validateController(address)

- **Kind**: internal
- **Source**: 23000:177:510
- **Link**: `src/SuperVault/SuperVault.sol:SuperVault:_validateController(address)`

```solidity
/// @notice Validates that the caller is authorized to act on behalf of the controller
///  @dev Enforces ERC7540Operator pattern: either direct call from controller or authorized operator
///  @dev Operators must be authorized via setOperator() or authorizeOperator() (EIP-712 signature)
///  @dev Used in redemption flows to prevent unauthorized claims
///  @param controller The controller address to validate authorization for
///  @dev Reverts with INVALID_CONTROLLER if:
///       - caller is not the controller AND
///       - caller is not an authorized operator for the controller
function _validateController(address controller) internal view {
    if ((controller != msg.sender) && (!_isOperator(controller, msg.sender))) revert INVALID_CONTROLLER();
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

- **ISuperVaultStrategy::handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256)**

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]
- **REQUEST_ID** (`uint256`)
- **isOperator** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.cancelRedeemRequest(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperVault._validateController(address) (NodeID: 1)
      💬 Args: [controller]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperVault._isOperator(address,address) (NodeID: 2)
        💬 Args: [controller, msg.sender]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC7540CancelRedeem

### Interface Documentation

 @dev Submits a Request for cancelling the pending redeem Request
 - controller MUST be msg.sender unless some unspecified explicit approval is given by the caller,
    approval of ERC-20 tokens from controller to sender is NOT enough.
 - MUST set pendingCancelRedeemRequest to `true` for the returned requestId after request
 - MUST increase claimableCancelRedeemRequest for the returned requestId after fulfillment
 - SHOULD be claimable using `claimCancelRedeemRequest`
 Note: while `pendingCancelRedeemRequest` is `true`, `requestRedeem` cannot be called
