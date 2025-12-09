# Function: withdraw(uint256,address,address)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 8600:413:270
- **Inherited From**: ERC4626

## Implementation

```solidity
/// @inheritdoc IERC4626
function withdraw(uint256 assets, address receiver, address owner) virtual public returns (uint256) {
    uint256 maxAssets = maxWithdraw(owner);
    if (assets > maxAssets) {
        revert ERC4626ExceededMaxWithdraw(owner, assets, maxAssets);
    }
    uint256 shares = previewWithdraw(assets);
    _withdraw(_msgSender(), receiver, owner, assets, shares);
    return shares;
}
```

## Related Implementations

### maxWithdraw(address)

- **Kind**: internal
- **Source**: 6700:153:270
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol:ERC4626:maxWithdraw(address)`

```solidity
/// @inheritdoc IERC4626
function maxWithdraw(address owner) virtual public view returns (uint256) {
    return _convertToAssets(balanceOf(owner), Math.Rounding.Floor);
}
```

### _convertToAssets(uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 9914:213:270
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol:ERC4626:_convertToAssets(uint256,enum Math.Rounding)`

```solidity
///  @dev Internal conversion function (from shares to assets) with support for rounding direction.
function _convertToAssets(uint256 shares, Math.Rounding rounding) virtual internal view returns (uint256) {
    return shares.mulDiv(totalAssets() + 1, totalSupply() + (10 ** _decimalsOffset()), rounding);
}
```

### balanceOf(address)

- **Kind**: internal
- **Source**: 2933:116:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:balanceOf(address)`

```solidity
/// @inheritdoc IERC20
function balanceOf(address account) virtual public view returns (uint256) {
    return _balances[account];
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
}
```

### totalAssets()

- **Kind**: internal
- **Source**: 5278:171:585
- **Link**: `test/mocks/Mock4626Vault.sol:Mock4626Vault:totalAssets()`

```solidity
function totalAssets() override public view returns (uint256) {
    return _totalAssets;
}
```

### _decimalsOffset()

- **Kind**: internal
- **Source**: 12030:90:270
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol:ERC4626:_decimalsOffset()`

```solidity
function _decimalsOffset() virtual internal view returns (uint8) {
    return 0;
}
```

### totalSupply()

- **Kind**: internal
- **Source**: 2803:97:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:totalSupply()`

```solidity
/// @inheritdoc IERC20
function totalSupply() virtual public view returns (uint256) {
    return _totalSupply;
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

```solidity
///  @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
function toUint(bool b) internal pure returns (uint256 u) {
    assembly ("memory-safe") {
        u := iszero(iszero(b))
    }
}
```

### unsignedRoundsUp(enum Math.Rounding)

- **Kind**: internal
- **Source**: 32020:122:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

```solidity
///  @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
///  denominator == 0.
///  Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
///  Uniswap Labs also under MIT license.
function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
    unchecked {
        (uint256 high, uint256 low) = mul512(x, y);
        if (high == 0) {
            return low / denominator;
        }
        if (denominator <= high) {
            Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
        }
        uint256 remainder;
        assembly ("memory-safe") {
            remainder := mulmod(x, y, denominator)
            high := sub(high, gt(remainder, low))
            low := sub(low, remainder)
        }
        uint256 twos = denominator & (0 - denominator);
        assembly ("memory-safe") {
            denominator := div(denominator, twos)
            low := div(low, twos)
            twos := add(div(sub(0, twos), twos), 1)
        }
        low |= high * twos;
        uint256 inverse = (3 * denominator) ^ 2;
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        result = low * inverse;
        return result;
    }
}
```

### mul512(uint256,uint256)

- **Kind**: internal
- **Source**: 1027:550:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

```solidity
///  @dev Return the 512-bit multiplication of two uint256.
///  The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
function mul512(uint256 a, uint256 b) internal pure returns (uint256 high, uint256 low) {
    assembly ("memory-safe") {
        let mm := mulmod(a, b, not(0))
        low := mul(a, b)
        high := sub(sub(mm, low), lt(mm, low))
    }
}
```

### panic(uint256)

- **Kind**: internal
- **Source**: 1776:194:281
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

```solidity
/// @dev Reverts with a panic code. Recommended to use with
///  the internal constants with predefined codes.
function panic(uint256 code) internal pure {
    assembly ("memory-safe") {
        mstore(0x00, 0x4e487b71)
        mstore(0x20, code)
        revert(0x1c, 0x24)
    }
}
```

### ternary(bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5071:294:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

```solidity
///  @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
///  IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
///  However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
///  one branch when needed, making this function more expensive.
function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
    unchecked {
        return b ^ ((a ^ b) * SafeCast.toUint(condition));
    }
}
```

### previewWithdraw(uint256)

- **Kind**: internal
- **Source**: 1722:117:585
- **Link**: `test/mocks/Mock4626Vault.sol:Mock4626Vault:previewWithdraw(uint256)`

```solidity
function previewWithdraw(uint256 shares) override public pure returns (uint256 assets) {
    return shares;
}
```

### _withdraw(address,address,address,uint256,uint256)

- **Kind**: internal
- **Source**: 11099:925:270
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol:ERC4626:_withdraw(address,address,address,uint256,uint256)`

```solidity
///  @dev Withdraw/redeem common workflow.
function _withdraw(address caller, address receiver, address owner, uint256 assets, uint256 shares) virtual internal {
    if (caller != owner) {
        _spendAllowance(owner, caller, shares);
    }
    _burn(owner, shares);
    SafeERC20.safeTransfer(IERC20(asset()), receiver, assets);
    emit Withdraw(caller, receiver, owner, assets, shares);
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 656:96:277
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### _spendAllowance(address,address,uint256)

- **Kind**: internal
- **Source**: 10319:476:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_spendAllowance(address,address,uint256)`

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
- **Source**: 3455:140:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:allowance(address,address)`

```solidity
/// @inheritdoc IERC20
function allowance(address owner, address spender) virtual public view returns (uint256) {
    return _allowances[owner][spender];
}
```

### _approve(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 9605:432:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_approve(address,address,uint256,bool)`

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
- **Source**: 7888:206:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_burn(address,uint256)`

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
- **Source**: 5912:1107:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_update(address,address,uint256)`

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

### safeTransfer(contract IERC20,address,uint256)

- **Kind**: internal
- **Source**: 1219:160:273
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol:SafeERC20:safeTransfer(contract IERC20,address,uint256)`

```solidity
///  @dev Transfer `value` amount of `token` from the calling contract to `to`. If `token` returns no value,
///  non-reverting calls are assumed to be successful.
function safeTransfer(IERC20 token, address to, uint256 value) internal {
    _callOptionalReturn(token, abi.encodeCall(token.transfer, (to, value)));
}
```

### asset()

- **Kind**: internal
- **Source**: 1089:86:585
- **Link**: `test/mocks/Mock4626Vault.sol:Mock4626Vault:asset()`

```solidity
function asset() override public view returns (address) {
    return _asset;
}
```

### _callOptionalReturn(contract IERC20,bytes)

- **Kind**: internal
- **Source**: 8370:720:273
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol:SafeERC20:_callOptionalReturn(contract IERC20,bytes)`

```solidity
///  @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
///  on the return value: the return value is optional (but if data is returned, it must not be false).
///  @param token The token targeted by the call.
///  @param data The call data (encoded using abi.encode or one of its variants).
///  This is a variant of {_callOptionalReturnBool} that reverts if call fails to meet the requirements.
function _callOptionalReturn(IERC20 token, bytes memory data) private {
    uint256 returnSize;
    uint256 returnValue;
    assembly ("memory-safe") {
        let success := call(gas(), token, 0, add(data, 0x20), mload(data), 0, 0x20)
        if iszero(success) {
            let ptr := mload(0x40)
            returndatacopy(ptr, 0, returndatasize())
            revert(ptr, returndatasize())
        }
        returnSize := returndatasize()
        returnValue := mload(0)
    }
    if ((returnSize == 0) ? (address(token).code.length == 0) : (returnValue != 1)) {
        revert SafeERC20FailedOperation(address(token));
    }
}
```

## State Variable Reads

- **_balances** (`mapping(address => uint256)`)
- **_totalAssets** (`uint256`)
- **_totalSupply** (`uint256`)
- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_asset** (`address`)

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626.withdraw(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC4626.maxWithdraw(address) (NodeID: 1)
  │   💬 Args: [owner]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC4626._convertToAssets(uint256,enum Math.Rounding) (NodeID: 2)
  │     💬 Args: [balanceOf(owner), Math.Rounding.Floor]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: ERC20.balanceOf(address) (NodeID: 14)
  │   │   💬 Args: [owner]
  │   │   👁️  Def: public
  │   └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 3)
  │       💬 Args: [shares, totalAssets() + 1, totalSupply() + (10 ** _decimalsOffset()), rounding]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Mock4626Vault.totalAssets() (NodeID: 11)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: public
  │     ├─ [4] ⚙️ FUNCTION: ERC4626._decimalsOffset() (NodeID: 12)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 13)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: public
  │     ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 4)
  │     │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 5)
  │     │     💬 Args: [rounding]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 6)
  │         💬 Args: [x, y, denominator]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 7)
  │       │   💬 Args: [x, y]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 8)
  │           💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 9)
  │             💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 10)
  │               💬 Args: [condition]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Mock4626Vault.previewWithdraw(uint256) (NodeID: 15)
  │   💬 Args: [assets]
  │   👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC4626._withdraw(address,address,address,uint256,uint256) (NodeID: 16)
      💬 Args: [_msgSender(), receiver, owner, assets, shares]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 25)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC20._spendAllowance(address,address,uint256) (NodeID: 17)
    │   💬 Args: [owner, caller, shares]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: ERC20.allowance(address,address) (NodeID: 18)
    │ │   💬 Args: [owner, spender]
    │ │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: ERC20._approve(address,address,uint256,bool) (NodeID: 19)
    │     💬 Args: [owner, spender, currentAllowance - value, false]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 20)
    │   💬 Args: [owner, shares]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 21)
    │     💬 Args: [account, address(0), value]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SafeERC20.safeTransfer(contract IERC20,address,uint256) (NodeID: 22)
        💬 Args: [IERC20(asset()), receiver, assets]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Mock4626Vault.asset() (NodeID: 24)
      │   💬 Args: [no args]
      │   👁️  Def: public
      └─ [3] ⚙️ FUNCTION: SafeERC20._callOptionalReturn(contract IERC20,bytes) (NodeID: 23)
          💬 Args: [token, abi.encodeCall(token.transfer, (to, value))]
          👁️  Def: private
```

## Documentation

### Function Documentation

@inheritdoc IERC4626

### Interface Documentation

 @dev Burns shares from owner and sends exactly assets of underlying tokens to receiver.
 - MUST emit the Withdraw event.
 - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the
   withdraw execution, and are accounted for during withdraw.
 - MUST revert if all of assets cannot be withdrawn (due to withdrawal limit being reached, slippage, the owner
   not having enough shares, etc).
 Note that some implementations will require pre-requesting to the Vault before a withdrawal may be performed.
 Those methods should be performed separately.
