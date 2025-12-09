# Function: mint(uint256,address)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 8185:380:270
- **Inherited From**: ERC4626

## Implementation

```solidity
/// @inheritdoc IERC4626
function mint(uint256 shares, address receiver) virtual public returns (uint256) {
    uint256 maxShares = maxMint(receiver);
    if (shares > maxShares) {
        revert ERC4626ExceededMaxMint(receiver, shares, maxShares);
    }
    uint256 assets = previewMint(shares);
    _deposit(_msgSender(), receiver, assets, shares);
    return assets;
}
```

## Related Implementations

### maxMint(address)

- **Kind**: internal
- **Source**: 6560:105:270
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol:ERC4626:maxMint(address)`

```solidity
/// @inheritdoc IERC4626
function maxMint(address) virtual public view returns (uint256) {
    return type(uint256).max;
}
```

### previewMint(uint256)

- **Kind**: internal
- **Source**: 7217:143:270
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol:ERC4626:previewMint(uint256)`

```solidity
/// @inheritdoc IERC4626
function previewMint(uint256 shares) virtual public view returns (uint256) {
    return _convertToAssets(shares, Math.Rounding.Ceil);
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

### _deposit(address,address,uint256,uint256)

- **Kind**: internal
- **Source**: 10191:841:270
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol:ERC4626:_deposit(address,address,uint256,uint256)`

```solidity
///  @dev Deposit/mint common workflow.
function _deposit(address caller, address receiver, uint256 assets, uint256 shares) virtual internal {
    SafeERC20.safeTransferFrom(IERC20(asset()), caller, address(this), assets);
    _mint(receiver, shares);
    emit Deposit(caller, receiver, assets, shares);
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

### safeTransferFrom(contract IERC20,address,address,uint256)

- **Kind**: internal
- **Source**: 1618:188:273
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol:SafeERC20:safeTransferFrom(contract IERC20,address,address,uint256)`

```solidity
///  @dev Transfer `value` amount of `token` from `from` to `to`, spending the approval given by `from` to the
///  calling contract. If `token` returns no value, non-reverting calls are assumed to be successful.
function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
    _callOptionalReturn(token, abi.encodeCall(token.transferFrom, (from, to, value)));
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

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 7362:208:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_mint(address,uint256)`

```solidity
///  @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
///  Relies on the `_update` mechanism
///  Emits a {Transfer} event with `from` set to the zero address.
///  NOTE: This function is not virtual, {_update} should be overridden instead.
function _mint(address account, uint256 value) internal {
    if (account == address(0)) {
        revert ERC20InvalidReceiver(address(0));
    }
    _update(address(0), account, value);
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

## State Variable Reads

- **_totalAssets** (`uint256`)
- **_totalSupply** (`uint256`)
- **_asset** (`address`)
- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626.mint(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC4626.maxMint(address) (NodeID: 1)
  │   💬 Args: [receiver]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC4626.previewMint(uint256) (NodeID: 2)
  │   💬 Args: [shares]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ERC4626._convertToAssets(uint256,enum Math.Rounding) (NodeID: 3)
  │     💬 Args: [shares, Math.Rounding.Ceil]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 4)
  │       💬 Args: [shares, totalAssets() + 1, totalSupply() + (10 ** _decimalsOffset()), rounding]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Mock4626Vault.totalAssets() (NodeID: 12)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: public
  │     ├─ [4] ⚙️ FUNCTION: ERC4626._decimalsOffset() (NodeID: 13)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 14)
  │     │   💬 Args: [no args]
  │     │   👁️  Def: public
  │     ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 5)
  │     │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 6)
  │     │     💬 Args: [rounding]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 7)
  │         💬 Args: [x, y, denominator]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 8)
  │       │   💬 Args: [x, y]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 9)
  │           💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 10)
  │             💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 11)
  │               💬 Args: [condition]
  │               👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC4626._deposit(address,address,uint256,uint256) (NodeID: 15)
      💬 Args: [_msgSender(), receiver, assets, shares]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Context._msgSender() (NodeID: 21)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SafeERC20.safeTransferFrom(contract IERC20,address,address,uint256) (NodeID: 16)
    │   💬 Args: [IERC20(asset()), caller, address(this), assets]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Mock4626Vault.asset() (NodeID: 18)
    │ │   💬 Args: [no args]
    │ │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: SafeERC20._callOptionalReturn(contract IERC20,bytes) (NodeID: 17)
    │     💬 Args: [token, abi.encodeCall(token.transferFrom, (from, to, value))]
    │     👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 19)
        💬 Args: [receiver, shares]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 20)
          💬 Args: [address(0), account, value]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IERC4626

### Interface Documentation

 @dev Mints exactly shares Vault shares to receiver by depositing amount of underlying tokens.
 - MUST emit the Deposit event.
 - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the mint
   execution, and are accounted for during mint.
 - MUST revert if all of shares cannot be minted (due to deposit limit being reached, slippage, the user not
   approving enough underlying tokens to the Vault contract, etc).
 NOTE: most implementations will require pre-approval of the Vault with the Vault’s underlying asset token.
