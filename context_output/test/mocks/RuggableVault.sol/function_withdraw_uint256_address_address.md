# Function: withdraw(uint256,address,address)

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 6013:960:609

## Implementation

```solidity
function withdraw(uint256 assets, address receiver, address owner) override public returns (uint256) {
    uint256 shares = previewWithdraw(assets);
    if (msg.sender != owner) {
        uint256 allowed = allowance(owner, msg.sender);
        if (allowed != type(uint256).max) {
            _approve(owner, msg.sender, allowed - shares);
        }
    }
    _burn(owner, shares);
    if (rugOnWithdraw) {
        uint256 ruggedAssets = calculateRuggedAmount(assets);
        uint256 actualAssets = assets - ruggedAssets;
        _asset.safeTransfer(receiver, actualAssets);
        emit RugPull("withdraw", receiver, assets, ruggedAssets);
        return shares;
    } else {
        _asset.safeTransfer(receiver, assets);
        return shares;
    }
}
```

## Related Implementations

### previewWithdraw(uint256)

- **Kind**: internal
- **Source**: 4080:289:609
- **Link**: `test/mocks/RuggableVault.sol:RuggableVault:previewWithdraw(uint256)`

```solidity
function previewWithdraw(uint256 assets) override public view returns (uint256) {
    uint256 supply = totalSupply();
    uint256 totalAssets_ = totalAssets();
    return ((supply == 0) || (totalAssets_ == 0)) ? assets : assets.mulDiv(supply, totalAssets_, Math.Rounding.Ceil);
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

### totalAssets()

- **Kind**: internal
- **Source**: 2524:117:609
- **Link**: `test/mocks/RuggableVault.sol:RuggableVault:totalAssets()`

```solidity
function totalAssets() override public view returns (uint256) {
    return _asset.balanceOf(address(this));
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:61
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

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
- **Source**: 32020:122:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

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
- **Source**: 1027:550:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

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
- **Source**: 1776:194:55
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

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
- **Source**: 5071:294:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

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

### calculateRuggedAmount(uint256)

- **Kind**: internal
- **Source**: 2136:132:609
- **Link**: `test/mocks/RuggableVault.sol:RuggableVault:calculateRuggedAmount(uint256)`

```solidity
function calculateRuggedAmount(uint256 amount) public view returns (uint256) {
    return (amount * rugPercentage) / 10_000;
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **rugOnWithdraw** (`bool`)
- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_totalSupply** (`uint256`)
- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_balances** (`mapping(address => uint256)`)
- **rugPercentage** (`uint256`)

## State Variable Writes

- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableVault.withdraw(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: RuggableVault.previewWithdraw(uint256) (NodeID: 1)
  │   💬 Args: [assets]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: RuggableVault.totalAssets() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 4)
  │     💬 Args: [assets, supply, totalAssets_, Math.Rounding.Ceil]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 5)
  │   │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 6)
  │   │     💬 Args: [rounding]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 7)
  │       💬 Args: [x, y, denominator]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 8)
  │     │   💬 Args: [x, y]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 9)
  │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 10)
  │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 11)
  │             💬 Args: [condition]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC20.allowance(address,address) (NodeID: 12)
  │   💬 Args: [owner, msg.sender]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC20._approve(address,address,uint256) (NodeID: 13)
  │   💬 Args: [owner, msg.sender, allowed - shares]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC20._approve(address,address,uint256,bool) (NodeID: 14)
  │     💬 Args: [owner, spender, value, true]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 15)
  │   💬 Args: [owner, shares]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 16)
  │     💬 Args: [account, address(0), value]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: RuggableVault.calculateRuggedAmount(uint256) (NodeID: 17)
      💬 Args: [assets]
      👁️  Def: public
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
