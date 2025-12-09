# Function: calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256)

**Contract**: [test/draft/src/SuperAsset/IncentiveCalculationContract.sol/contract_IncentiveCalculationContract.md]

## Metadata

- **Contract**: IncentiveCalculationContract
- **Signature**: `calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2272:1780:546

## Implementation

```solidity
/// @inheritdoc IIncentiveCalculationContract
function calculateIncentive(uint256[] memory allocationPreOperation, uint256[] memory allocationPostOperation, uint256[] memory allocationTarget, uint256[] memory weights, uint256 totalAllocationPreOperation, uint256 totalAllocationPostOperation, uint256 totalAllocationTarget, uint256 energyToUSDExchangeRatio) public pure returns (int256 incentiveUSD, bool isSuccess) {
    if ((allocationPreOperation.length != allocationPostOperation.length) || (allocationPreOperation.length != allocationTarget.length)) {
        revert INVALID_ARRAY_LENGTH();
    }
    uint256 energyBefore;
    uint256 energyAfter;
    bool _isSuccess;
    (energyBefore, _isSuccess) = energy(allocationPreOperation, allocationTarget, weights, totalAllocationPreOperation, totalAllocationTarget);
    if (!_isSuccess) {
        return (0, false);
    }
    (energyAfter, _isSuccess) = energy(allocationPostOperation, allocationTarget, weights, totalAllocationPostOperation, totalAllocationTarget);
    if (!_isSuccess) {
        return (0, false);
    }
    int256 energyDiff = int256(energyBefore) - int256(energyAfter);
    if (energyDiff >= 0) {
        incentiveUSD = int256(Math.mulDiv(uint256(energyDiff), energyToUSDExchangeRatio, PRECISION));
    } else {
        incentiveUSD = -int256(Math.mulDiv(uint256(-energyDiff), energyToUSDExchangeRatio, PRECISION));
    }
    return (incentiveUSD, true);
}
```

## Related Implementations

### energy(uint256[],uint256[],uint256[],uint256,uint256)

- **Kind**: internal
- **Source**: 668:1548:546
- **Link**: `test/draft/src/SuperAsset/IncentiveCalculationContract.sol:IncentiveCalculationContract:energy(uint256[],uint256[],uint256[],uint256,uint256)`

```solidity
/// @inheritdoc IIncentiveCalculationContract
function energy(uint256[] memory currentAllocation, uint256[] memory allocationTarget, uint256[] memory weights, uint256 totalCurrentAllocation, uint256 totalAllocationTarget) public pure returns (uint256 res, bool isSuccess) {
    if ((currentAllocation.length != allocationTarget.length) || (currentAllocation.length != weights.length)) {
        revert INVALID_ARRAY_LENGTH();
    }
    if ((totalCurrentAllocation == 0) || (totalAllocationTarget == 0)) {
        return (0, false);
    }
    uint256 length = currentAllocation.length;
    for (uint256 i; i < length; i++) {
        uint256 _currentAllocation = Math.mulDiv(currentAllocation[i], PERC, totalCurrentAllocation);
        uint256 _targetAllocation = Math.mulDiv(allocationTarget[i], PERC, totalAllocationTarget);
        int256 diff = int256(_currentAllocation) - int256(_targetAllocation);
        uint256 diff2 = Math.mulDiv(uint256(diff * diff), 1, PRECISION);
        res += Math.mulDiv(diff2, weights[i], PRECISION);
    }
    return (res, true);
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

## State Variable Reads

- **PRECISION** (`uint256`)
- **PERC** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveCalculationContract.calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: IncentiveCalculationContract.energy(uint256[],uint256[],uint256[],uint256,uint256) (NodeID: 1)
  │   💬 Args: [allocationPreOperation, allocationTarget, weights, totalAllocationPreOperation, totalAllocationTarget]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [currentAllocation[i], PERC, totalCurrentAllocation]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 3)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 4)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 5)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 6)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 7)
  │ │   💬 Args: [allocationTarget[i], PERC, totalAllocationTarget]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 8)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 9)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 10)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 11)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 12)
  │ │   💬 Args: [uint256(diff * diff), 1, PRECISION]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 13)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 14)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 15)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 16)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 17)
  │     💬 Args: [diff2, weights[i], PRECISION]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 18)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 19)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 20)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 21)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: IncentiveCalculationContract.energy(uint256[],uint256[],uint256[],uint256,uint256) (NodeID: 22)
  │   💬 Args: [allocationPostOperation, allocationTarget, weights, totalAllocationPostOperation, totalAllocationTarget]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 23)
  │ │   💬 Args: [currentAllocation[i], PERC, totalCurrentAllocation]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 24)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 25)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 26)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 27)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 28)
  │ │   💬 Args: [allocationTarget[i], PERC, totalAllocationTarget]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 29)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 30)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 31)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 32)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 33)
  │ │   💬 Args: [uint256(diff * diff), 1, PRECISION]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 34)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 35)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 36)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 37)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 38)
  │     💬 Args: [diff2, weights[i], PRECISION]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 39)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 40)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 41)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 42)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 43)
  │   💬 Args: [uint256(energyDiff), energyToUSDExchangeRatio, PRECISION]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 44)
  │ │   💬 Args: [x, y]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 45)
  │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 46)
  │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 47)
  │         💬 Args: [condition]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 48)
      💬 Args: [uint256(-energyDiff), energyToUSDExchangeRatio, PRECISION]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 49)
    │   💬 Args: [x, y]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 50)
        💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 51)
          💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 52)
            💬 Args: [condition]
            👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IIncentiveCalculationContract

### Interface Documentation

@notice Calculates the incentive.
 @param allocationPreOperation The allocation before the operation.
 @param allocationPostOperation The allocation after the operation.
 @param allocationTarget The target allocation.
 @param weights The weights for each allocation in the energy calculation.
 @param totalAllocationPreOperation The total allocation before the operation.
 @param totalAllocationPostOperation The total allocation after the operation.
 @param totalAllocationTarget The total target allocation.
 @param energyToUSDExchangeRatio The ratio to convert energy units to USD (scaled by PRECISION).
 @return incentiveUSD The calculated incentive in USD (scaled by PRECISION).
 @return isSuccess A boolean indicating whether the calculation was successful.
