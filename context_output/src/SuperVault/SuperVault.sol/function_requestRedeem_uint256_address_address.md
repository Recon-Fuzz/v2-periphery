# Function: requestRedeem(uint256,address,address)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `requestRedeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 8742:1013:510

## Implementation

```solidity
/// @inheritdoc IERC7540Redeem
///  @notice Once owner has authorized an operator, controller must be the owner
function requestRedeem(uint256 shares, address controller, address owner) external returns (uint256) {
    if (shares == 0) revert ZERO_AMOUNT();
    if ((owner == address(0)) || (controller == address(0))) revert ZERO_ADDRESS();
    _validateController(owner);
    if (balanceOf(owner) < shares) revert INVALID_AMOUNT();
    if (strategy.pendingCancelRedeemRequest(owner)) revert CANCELLATION_REDEEM_REQUEST_PENDING();
    if (controller != owner) revert CONTROLLER_MUST_EQUAL_OWNER();
    _approve(owner, escrow, shares);
    ISuperVaultEscrow(escrow).escrowShares(owner, shares);
    strategy.handleOperations7540(ISuperVaultStrategy.Operation.RedeemRequest, controller, address(0), shares);
    emit RedeemRequest(controller, owner, REQUEST_ID, msg.sender, shares);
    return REQUEST_ID;
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

### balanceOf(address)

- **Kind**: internal
- **Source**: 4035:171:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:balanceOf(address)`

```solidity
/// @inheritdoc IERC20
function balanceOf(address account) virtual public view returns (uint256) {
    ERC20Storage storage $ = _getERC20Storage();
    return $._balances[account];
}
```

### _getERC20Storage()

- **Kind**: internal
- **Source**: 1947:153:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_getERC20Storage()`

```solidity
function _getERC20Storage() private pure returns (ERC20Storage storage $) {
    assembly {
        $.slot := ERC20StorageLocation
    }
}
```

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 9905:128:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_approve(address,address,uint256)`

```solidity
///  @dev Sets `value` as the allowance of `spender` over the `owner`'s tokens.
///  This internal function is equivalent to `approve`, and can be used to
///  e.g. set automatic allowances for certain subsystems, etc.
///  Emits an {Approval} event.
///  Requirements:
///  - `owner` cannot be the zero address.
///  - `spender` cannot be the zero address.
///  Overrides to this logic should be done to the variant with an additional `bool emitEvent` argument.
function _approve(address owner, address spender, uint256 value) internal {
    _approve(owner, spender, value, true);
}
```

### _approve(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 10880:487:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_approve(address,address,uint256,bool)`

```solidity
///  @dev Variant of {_approve} with an optional flag to enable or disable the {Approval} event.
///  By default (when calling {_approve}) the flag is set to true. On the other hand, approval changes made by
///  `_spendAllowance` during the `transferFrom` operation set the flag to false. This saves gas by not emitting any
///  `Approval` event during `transferFrom` operations.
///  Anyone who wishes to continue emitting `Approval` events on the`transferFrom` operation can force the flag to
///  true using the following override:
///  ```solidity
///  function _approve(address owner, address spender, uint256 value, bool) internal virtual override {
///      super._approve(owner, spender, value, true);
///  }
///  ```
///  Requirements are the same as {_approve}.
function _approve(address owner, address spender, uint256 value, bool emitEvent) virtual internal {
    ERC20Storage storage $ = _getERC20Storage();
    if (owner == address(0)) {
        revert ERC20InvalidApprover(address(0));
    }
    if (spender == address(0)) {
        revert ERC20InvalidSpender(address(0));
    }
    $._allowances[owner][spender] = value;
    if (emitEvent) {
        emit Approval(owner, spender, value);
    }
}
```

## External Calls

- **ISuperVaultStrategy::pendingCancelRedeemRequest(address)**
- **ISuperVaultEscrow::escrowShares(address,uint256)**
- **ISuperVaultStrategy::handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256)**

## State Variable Reads

- **strategy** (`contract ISuperVaultStrategy`) [src/interfaces/SuperVault/ISuperVaultStrategy.sol/interface_ISuperVaultStrategy.md]
- **escrow** (`address`)
- **REQUEST_ID** (`uint256`)
- **isOperator** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault.requestRedeem(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperVault._validateController(address) (NodeID: 1)
  │   💬 Args: [owner]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperVault._isOperator(address,address) (NodeID: 2)
  │     💬 Args: [controller, msg.sender]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC20Upgradeable.balanceOf(address) (NodeID: 3)
  │   💬 Args: [owner]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC20Upgradeable._getERC20Storage() (NodeID: 4)
  │     💬 Args: [no args]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: ERC20Upgradeable._approve(address,address,uint256) (NodeID: 5)
      💬 Args: [owner, escrow, shares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20Upgradeable._approve(address,address,uint256,bool) (NodeID: 6)
        💬 Args: [owner, spender, value, true]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ERC20Upgradeable._getERC20Storage() (NodeID: 7)
          💬 Args: [no args]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IERC7540Redeem
 @notice Once owner has authorized an operator, controller must be the owner

### Interface Documentation

 @dev Assumes control of shares from sender into the Vault and submits a Request for asynchronous redeem.
 - MUST support a redeem Request flow where the control of shares is taken from sender directly
   where msg.sender has ERC-20 approval over the shares of owner.
 - MUST revert if all of shares cannot be requested for redeem.
 @param shares the amount of shares to be redeemed to transfer from owner
 @param controller the controller of the request who will be able to operate the request
 @param owner the source of the shares to be redeemed
 NOTE: most implementations will require pre-approval of the Vault with the Vault's share token.
