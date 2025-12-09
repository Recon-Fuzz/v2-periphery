# Function: transferFrom(address,address,uint256)

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 4680:244:48
- **Inherited From**: ERC20

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
- **Source**: 656:96:52
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### _spendAllowance(address,address,uint256)

- **Kind**: internal
- **Source**: 10319:476:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_spendAllowance(address,address,uint256)`

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
- **Source**: 3455:140:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:allowance(address,address)`

```solidity
/// @inheritdoc IERC20
function allowance(address owner, address spender) virtual public view returns (uint256) {
    return _allowances[owner][spender];
}
```

### _approve(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 9605:432:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_approve(address,address,uint256,bool)`

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
    if (owner == address(0)) {
        revert ERC20InvalidApprover(address(0));
    }
    if (spender == address(0)) {
        revert ERC20InvalidSpender(address(0));
    }
    _allowances[owner][spender] = value;
    if (emitEvent) {
        emit Approval(owner, spender, value);
    }
}
```

### _transfer(address,address,uint256)

- **Kind**: internal
- **Source**: 5297:300:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_transfer(address,address,uint256)`

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
- **Source**: 5912:1107:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_update(address,address,uint256)`

```solidity
///  @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
///  (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
///  this function.
///  Emits a {Transfer} event.
function _update(address from, address to, uint256 value) virtual internal {
    if (from == address(0)) {
        _totalSupply += value;
    } else {
        uint256 fromBalance = _balances[from];
        if (fromBalance < value) {
            revert ERC20InsufficientBalance(from, fromBalance, value);
        }
        unchecked {
            _balances[from] = fromBalance - value;
        }
    }
    if (to == address(0)) {
        unchecked {
            _totalSupply -= value;
        }
    } else {
        unchecked {
            _balances[to] += value;
        }
    }
    emit Transfer(from, to, value);
}
```

## State Variable Reads

- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.transferFrom(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Context._msgSender() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC20._spendAllowance(address,address,uint256) (NodeID: 2)
  │   💬 Args: [from, spender, value]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ERC20.allowance(address,address) (NodeID: 3)
  │ │   💬 Args: [owner, spender]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC20._approve(address,address,uint256,bool) (NodeID: 4)
  │     💬 Args: [owner, spender, currentAllowance - value, false]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._transfer(address,address,uint256) (NodeID: 5)
      💬 Args: [from, to, value]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 6)
        💬 Args: [from, to, value]
        👁️  Def: internal
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
