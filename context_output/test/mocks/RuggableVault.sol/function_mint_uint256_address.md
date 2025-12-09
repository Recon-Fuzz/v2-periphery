# Function: mint(uint256,address)

**Contract**: [test/mocks/RuggableVault.sol/contract_RuggableVault.md]

## Metadata

- **Contract**: RuggableVault
- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 5267:740:609

## Implementation

```solidity
function mint(uint256 shares, address receiver) override public returns (uint256) {
    uint256 assets = previewMint(shares);
    _asset.safeTransferFrom(msg.sender, address(this), assets);
    if (rugOnDeposit) {
        uint256 ruggedShares = calculateRuggedAmount(shares);
        uint256 actualShares = shares - ruggedShares;
        _mint(receiver, actualShares);
        emit RugPull("mint", receiver, shares, ruggedShares);
        return assets;
    } else {
        _mint(receiver, shares);
        return assets;
    }
}
```

## Related Implementations

### previewMint(uint256)

- **Kind**: internal
- **Source**: 3789:285:609
- **Link**: `test/mocks/RuggableVault.sol:RuggableVault:previewMint(uint256)`

```solidity
function previewMint(uint256 shares) override public view returns (uint256) {
    uint256 supply = totalSupply();
    uint256 totalAssets_ = totalAssets();
    return ((supply == 0) || (totalAssets_ == 0)) ? shares : shares.mulDiv(totalAssets_, supply, Math.Rounding.Ceil);
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

### calculateRuggedAmount(uint256)

- **Kind**: internal
- **Source**: 2136:132:609
- **Link**: `test/mocks/RuggableVault.sol:RuggableVault:calculateRuggedAmount(uint256)`

```solidity
function calculateRuggedAmount(uint256 amount) public view returns (uint256) {
    return (amount * rugPercentage) / 10_000;
}
```

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 7362:208:48
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_mint(address,uint256)`

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

- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**

## State Variable Reads

- **_asset** (`contract IERC20`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **rugOnDeposit** (`bool`)
- **_totalSupply** (`uint256`)
- **rugPercentage** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableVault.mint(uint256,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: RuggableVault.previewMint(uint256) (NodeID: 1)
  │   💬 Args: [shares]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: RuggableVault.totalAssets() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 4)
  │     💬 Args: [shares, totalAssets_, supply, Math.Rounding.Ceil]
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
  ├─ [1] ⚙️ FUNCTION: RuggableVault.calculateRuggedAmount(uint256) (NodeID: 12)
  │   💬 Args: [shares]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 13)
  │   💬 Args: [receiver, actualShares]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 14)
  │     💬 Args: [address(0), account, value]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 15)
      💬 Args: [receiver, shares]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 16)
        💬 Args: [address(0), account, value]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Mints exactly shares Vault shares to receiver by depositing amount of underlying tokens.
 - MUST emit the Deposit event.
 - MAY support an additional flow in which the underlying tokens are owned by the Vault contract before the mint
   execution, and are accounted for during mint.
 - MUST revert if all of shares cannot be minted (due to deposit limit being reached, slippage, the user not
   approving enough underlying tokens to the Vault contract, etc).
 NOTE: most implementations will require pre-approval of the Vault with the Vault’s underlying asset token.
