# Function: withdraw(uint256,address,address)

**Contract**: [test/mocks/MockETHReceiver.sol/contract_MockETHReceiver.md]

## Metadata

- **Contract**: MockETHReceiver
- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 3579:373:590

## Implementation

```solidity
function withdraw(uint256 assets, address receiver, address owner) override external returns (uint256) {
    if (msg.sender != owner) {
        _spendAllowance(owner, msg.sender, assets);
    }
    _burn(owner, assets);
    USDC.transfer(receiver, assets);
    emit Withdraw(msg.sender, receiver, owner, assets, assets);
    return assets;
}
```

## Related Implementations

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

### _burn(address,uint256)

- **Kind**: internal
- **Source**: 7888:206:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_burn(address,uint256)`

```solidity
///  @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
///  Relies on the `_update` mechanism.
///  Emits a {Transfer} event with `to` set to the zero address.
///  NOTE: This function is not virtual, {_update} should be overridden instead
function _burn(address account, uint256 value) internal {
    if (account == address(0)) {
        revert ERC20InvalidSender(address(0));
    }
    _update(account, address(0), value);
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

## External Calls

- **IERC20::transfer(address,uint256)**

## Native Transfers

- **USDC** (state variable) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Reads

- **USDC** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockETHReceiver.withdraw(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ERC20._spendAllowance(address,address,uint256) (NodeID: 1)
  │   💬 Args: [owner, msg.sender, assets]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ERC20.allowance(address,address) (NodeID: 2)
  │ │   💬 Args: [owner, spender]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC20._approve(address,address,uint256,bool) (NodeID: 3)
  │     💬 Args: [owner, spender, currentAllowance - value, false]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 4)
      💬 Args: [owner, assets]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 5)
        💬 Args: [account, address(0), value]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Burns shares from owner and sends exactly assets of underlying tokens to receiver.
 - MUST emit the Withdraw event.
 - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
   withdraw execution, and are accounted for during withdraw.
 - MUST revert if all of assets cannot be withdrawn (due to withdrawal limit being reached, slippage, the owner
   not having enough shares, etc).
 Note that some implementations will require pre-requesting to the Vault before a withdrawal may be performed.
 Those methods should be performed separately.
