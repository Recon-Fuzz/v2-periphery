# Function: test_CalculateIncentive_ExtremeExchangeRatio()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `test_CalculateIncentive_ExtremeExchangeRatio()`
- **Visibility**: public
- **Source Range**: 18680:1543:564

## Implementation

```solidity
function test_CalculateIncentive_ExtremeExchangeRatio() public view {
    uint256[] memory allocationPreOperation = new uint256[](2);
    allocationPreOperation[0] = 600e18;
    allocationPreOperation[1] = 400e18;
    uint256[] memory allocationPostOperation = new uint256[](2);
    allocationPostOperation[0] = 500e18;
    allocationPostOperation[1] = 500e18;
    uint256[] memory allocationTarget = new uint256[](2);
    allocationTarget[0] = 500e18;
    allocationTarget[1] = 500e18;
    uint256[] memory weights = new uint256[](2);
    weights[0] = PRECISION;
    weights[1] = PRECISION;
    uint256 totalAllocationPreOperation = 1000e18;
    uint256 totalAllocationPostOperation = 1000e18;
    uint256 totalAllocationTarget = 1000e18;
    uint256 extremeRatio = type(uint256).max / (200 * PRECISION);
    (int256 incentive, bool isSuccess) = calculator.calculateIncentive(allocationPreOperation, allocationPostOperation, allocationTarget, weights, totalAllocationPreOperation, totalAllocationPostOperation, totalAllocationTarget, extremeRatio);
    assertEq(isSuccess, true, "isSuccess should be true");
    assertTrue(incentive > 0);
    assertEq(incentive, int256(Math.mulDiv(200 * PRECISION, extremeRatio, PRECISION)));
}
```

## Related Implementations

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2487:171:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1764:124:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    if (!data) {
        vm.assertTrue(data);
    }
}
```

### assertEq(int256,int256)

- **Kind**: internal
- **Source**: 3346:151:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256)`

```solidity
function assertEq(int256 left, int256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
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

## External Calls

- **IncentiveCalculationContract::calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256)**

## State Variable Reads

- **PRECISION** (`uint256`)
- **calculator** (`contract IncentiveCalculationContract`) [test/draft/src/SuperAsset/IncentiveCalculationContract.sol/contract_IncentiveCalculationContract.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveCalculationContractTest.test_CalculateIncentive_ExtremeExchangeRatio() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [isSuccess, true, "isSuccess should be true"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 2)
  │   💬 Args: [incentive > 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256) (NodeID: 3)
      💬 Args: [incentive, int256(Math.mulDiv(200 * PRECISION, extremeRatio, PRECISION))]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 4)
        💬 Args: [200 * PRECISION, extremeRatio, PRECISION]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 5)
      │   💬 Args: [x, y]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 6)
          💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 7)
            💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 8)
              💬 Args: [condition]
              👁️  Def: internal
```
