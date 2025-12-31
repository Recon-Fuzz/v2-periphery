# Function: distribute(uint256)

**Contract**: [src/SuperBank.sol/contract_SuperBank.md]

## Metadata

- **Contract**: SuperBank
- **Signature**: `distribute(uint256)`
- **Visibility**: external
- **Source Range**: 1698:1522:508

## Implementation

```solidity
/// @inheritdoc ISuperBank
function distribute(uint256 upAmount) external onlyBankManager() {
    if (upAmount == 0) revert ZERO_AMOUNT();
    ISuperGovernor gov = SUPER_GOVERNOR;
    address upToken = gov.getAddress(gov.UP());
    if (IERC20(upToken).balanceOf(address(this)) < upAmount) revert INVALID_UP_AMOUNT_TO_DISTRIBUTE();
    uint256 revenueShare = gov.getFee(FeeType.REVENUE_SHARE);
    if (revenueShare > BPS_PRECISION) revert INVALID_REVENUE_SHARE();
    address supStrategyVault = gov.getAddress(gov.SUP_STRATEGY());
    address treasury = gov.getAddress(gov.TREASURY());
    uint256 supAmount = upAmount.mulDiv(revenueShare, BPS_PRECISION, Math.Rounding.Ceil);
    uint256 treasuryAmount = upAmount - supAmount;
    if (supAmount > 0) {
        IERC20(upToken).safeTransfer(supStrategyVault, supAmount);
    }
    if (treasuryAmount > 0) {
        IERC20(upToken).safeTransfer(treasury, treasuryAmount);
    }
    emit RevenueDistributed(upToken, supStrategyVault, treasury, supAmount, treasuryAmount);
}
```

## Related Implementations

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

### onlyBankManager()

- **Kind**: modifier
- **Source**: 1064:73:508
- **Link**: `src/SuperBank.sol:SuperBank:onlyBankManager()`

```solidity
modifier onlyBankManager() {
    _onlyBankManager();
    _;
}
```

### _onlyBankManager()

- **Kind**: internal
- **Source**: 1143:214:508
- **Link**: `src/SuperBank.sol:SuperBank:_onlyBankManager()`

```solidity
function _onlyBankManager() internal view {
    if (!IAccessControl(address(SUPER_GOVERNOR)).hasRole(SUPER_GOVERNOR.BANK_MANAGER_ROLE(), msg.sender)) {
        revert INVALID_BANK_MANAGER();
    }
}
```

## External Calls

- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::UP()**
- **IERC20::balanceOf(address)**
- **ISuperGovernor::getFee(enum FeeType)**
- **ISuperGovernor::SUP_STRATEGY()**
- **ISuperGovernor::TREASURY()**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IAccessControl::hasRole(bytes32,address)**
- **ISuperGovernor::BANK_MANAGER_ROLE()**

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **BPS_PRECISION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBank.distribute(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 1)
  │   💬 Args: [upAmount, revenueShare, BPS_PRECISION, Math.Rounding.Ceil]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 2)
  │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 3)
  │ │     💬 Args: [rounding]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 4)
  │     💬 Args: [x, y, denominator]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 5)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 6)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 7)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 8)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperBank.onlyBankManager() (NodeID: 9)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: SuperBank._onlyBankManager() (NodeID: 10)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperBank

### Interface Documentation

@notice Distributes UP tokens based on governance-agreed revenue share.
 @dev Transfers X% (REVENUE_SHARE) of UP tokens to sUP, and the remainder to Superform Treasury.
 @param upAmount The amount of UP tokens to distribute.
