# Function: transferFrom(address,address,uint256)

**Contract**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Metadata

- **Contract**: SuperVault
- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 5892:244:34
- **Inherited From**: ERC20Upgradeable

## Implementation

```solidity
///  @dev See {IERC20-transferFrom}.
///  Skips emitting an {Approval} event indicating an allowance update. This is not
///  required by the ERC. See {xref-ERC20-_approve-address-address-uint256-bool-}[_approve].
///  NOTE: Does not update the allowance if the current allowance
///  is the maximum `uint256`.
///  Requirements:
///  - `from` and `to` cannot be the zero address.
///  - `from` must have a balance of at least `value`.
///  - the caller must have allowance for ``from``'s tokens of at least
///  `value`.
function transferFrom(address from, address to, uint256 value) virtual public returns (bool) {
    address spender = _msgSender();
    _spendAllowance(from, spender, value);
    _transfer(from, to, value);
    return true;
}
```

## Related Implementations

### _msgSender()

- **Kind**: internal
- **Source**: 887:96:35
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol:ContextUpgradeable:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### _spendAllowance(address,address,uint256)

- **Kind**: internal
- **Source**: 11649:476:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_spendAllowance(address,address,uint256)`

```solidity
///  @dev Updates `owner`'s allowance for `spender` based on spent `value`.
///  Does not update the allowance value in case of infinite allowance.
///  Revert if not enough allowance is available.
///  Does not emit an {Approval} event.
function _spendAllowance(address owner, address spender, uint256 value) virtual internal {
    uint256 currentAllowance = allowance(owner, spender);
    if (currentAllowance < type(uint256).max) {
        if (currentAllowance < value) {
            revert ERC20InsufficientAllowance(spender, currentAllowance, value);
        }
        unchecked {
            _approve(owner, spender, currentAllowance - value, false);
        }
    }
}
```

### allowance(address,address)

- **Kind**: internal
- **Source**: 4612:195:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:allowance(address,address)`

```solidity
/// @inheritdoc IERC20
function allowance(address owner, address spender) virtual public view returns (uint256) {
    ERC20Storage storage $ = _getERC20Storage();
    return $._allowances[owner][spender];
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

### _transfer(address,address,uint256)

- **Kind**: internal
- **Source**: 6509:300:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_transfer(address,address,uint256)`

```solidity
///  @dev Moves a `value` amount of tokens from `from` to `to`.
///  This internal function is equivalent to {transfer}, and can be used to
///  e.g. implement automatic token fees, slashing mechanisms, etc.
///  Emits a {Transfer} event.
///  NOTE: This function is not virtual, {_update} should be overridden instead.
function _transfer(address from, address to, uint256 value) internal {
    if (from == address(0)) {
        revert ERC20InvalidSender(address(0));
    }
    if (to == address(0)) {
        revert ERC20InvalidReceiver(address(0));
    }
    _update(from, to, value);
}
```

### _update(address,address,uint256)

- **Kind**: internal
- **Source**: 7124:1170:34
- **Link**: `lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol:ERC20Upgradeable:_update(address,address,uint256)`

```solidity
///  @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
///  (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
///  this function.
///  Emits a {Transfer} event.
function _update(address from, address to, uint256 value) virtual internal {
    ERC20Storage storage $ = _getERC20Storage();
    if (from == address(0)) {
        $._totalSupply += value;
    } else {
        uint256 fromBalance = $._balances[from];
        if (fromBalance < value) {
            revert ERC20InsufficientBalance(from, fromBalance, value);
        }
        unchecked {
            $._balances[from] = fromBalance - value;
        }
    }
    if (to == address(0)) {
        unchecked {
            $._totalSupply -= value;
        }
    } else {
        unchecked {
            $._balances[to] += value;
        }
    }
    emit Transfer(from, to, value);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Upgradeable.transferFrom(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ContextUpgradeable._msgSender() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC20Upgradeable._spendAllowance(address,address,uint256) (NodeID: 2)
  │   💬 Args: [from, spender, value]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ERC20Upgradeable.allowance(address,address) (NodeID: 3)
  │ │   💬 Args: [owner, spender]
  │ │   👁️  Def: public
  │ │ └─ [3] ⚙️ FUNCTION: ERC20Upgradeable._getERC20Storage() (NodeID: 4)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: ERC20Upgradeable._approve(address,address,uint256,bool) (NodeID: 5)
  │     💬 Args: [owner, spender, currentAllowance - value, false]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: ERC20Upgradeable._getERC20Storage() (NodeID: 6)
  │       💬 Args: [no args]
  │       👁️  Def: private
  └─ [1] ⚙️ FUNCTION: ERC20Upgradeable._transfer(address,address,uint256) (NodeID: 7)
      💬 Args: [from, to, value]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20Upgradeable._update(address,address,uint256) (NodeID: 8)
        💬 Args: [from, to, value]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ERC20Upgradeable._getERC20Storage() (NodeID: 9)
          💬 Args: [no args]
          👁️  Def: private
```

## Documentation

### Function Documentation

 @dev See {IERC20-transferFrom}.
 Skips emitting an {Approval} event indicating an allowance update. This is not
 required by the ERC. See {xref-ERC20-_approve-address-address-uint256-bool-}[_approve].
 NOTE: Does not update the allowance if the current allowance
 is the maximum `uint256`.
 Requirements:
 - `from` and `to` cannot be the zero address.
 - `from` must have a balance of at least `value`.
 - the caller must have allowance for ``from``'s tokens of at least
 `value`.

### Interface Documentation

 @dev Moves a `value` amount of tokens from `from` to `to` using the
 allowance mechanism. `value` is then deducted from the caller's
 allowance.
 Returns a boolean value indicating whether the operation succeeded.
 Emits a {Transfer} event.
