# Function: redeem(uint256,address,address)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 6559:601:608

## Implementation

```solidity
function redeem(uint256 shares, address receiver, address owner) override public returns (uint256) {
    rugEnabled = false;
    uint256 assets = previewRedeem(shares);
    rugEnabled = true;
    if (msg.sender != owner) {
        uint256 allowed = allowance(owner, msg.sender);
        if (allowed != type(uint256).max) {
            _approve(owner, msg.sender, allowed - shares);
        }
    }
    _burn(owner, shares);
    _asset.safeTransfer(receiver, assets);
    emit RugPull("redeem", receiver, assets, assets);
    return assets;
}
```

## Related Implementations

### previewRedeem(uint256)

- **Kind**: internal
- **Source**: 4934:125:608
- **Link**: `test/mocks/RuggableConvertVault.sol:RuggableConvertVault:previewRedeem(uint256)`

```solidity
function previewRedeem(uint256 shares) override public view returns (uint256) {
    return convertToAssets(shares);
}
```

### convertToAssets(uint256)

- **Kind**: internal
- **Source**: 3061:560:608
- **Link**: `test/mocks/RuggableConvertVault.sol:RuggableConvertVault:convertToAssets(uint256)`

```solidity
function convertToAssets(uint256 shares) override public view returns (uint256) {
    uint256 supply = totalSupply();
    if (supply == 0) {
        return shares;
    }
    uint256 actualAssets = _asset.balanceOf(address(this));
    if (rugEnabled) {
        uint256 inflatedAssets = (actualAssets * (10_000 + rugPercentage)) / 10_000;
        return (shares * inflatedAssets) / supply;
    } else {
        return (shares * actualAssets) / supply;
    }
}
```

### totalSupply()

- **Kind**: internal
- **Source**: 2803:97:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:totalSupply()`

```solidity
/// @inheritdoc IERC20
function totalSupply() virtual public view returns (uint256) {
    return _totalSupply;
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

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 8630:128:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_approve(address,address,uint256)`

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

- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **rugEnabled** (`bool`)
- **rugPercentage** (`uint256`)
- **_totalSupply** (`uint256`)
- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **rugEnabled** (`bool`)
- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.redeem(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: RuggableConvertVault.previewRedeem(uint256) (NodeID: 1)
  │   💬 Args: [shares]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: RuggableConvertVault.convertToAssets(uint256) (NodeID: 2)
  │     💬 Args: [shares]
  │     👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC20.allowance(address,address) (NodeID: 4)
  │   💬 Args: [owner, msg.sender]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC20._approve(address,address,uint256) (NodeID: 5)
  │   💬 Args: [owner, msg.sender, allowed - shares]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC20._approve(address,address,uint256,bool) (NodeID: 6)
  │     💬 Args: [owner, spender, value, true]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 7)
      💬 Args: [owner, shares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 8)
        💬 Args: [account, address(0), value]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Burns exactly shares from owner and sends assets of underlying tokens to receiver.
 - MUST emit the Withdraw event.
 - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
   redeem execution, and are accounted for during redeem.
 - MUST revert if all of shares cannot be redeemed (due to withdrawal limit being reached, slippage, the owner
   not having enough shares, etc).
 NOTE: some implementations will require pre-requesting to the Vault before a withdrawal may be performed.
 Those methods should be performed separately.
