# Function: previewFees(address,address,uint256,uint256,uint256,uint256,uint256)

**Contract**: [lib/v2-core/src/accounting/SuperLedger.sol/contract_SuperLedger.md]

## Metadata

- **Contract**: SuperLedger
- **Signature**: `previewFees(address,address,uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4323:882:351
- **Inherited From**: BaseLedger

## Implementation

```solidity
/// @inheritdoc ISuperLedger
function previewFees(address user, address yieldSourceAddress, uint256 amountAssets, uint256 usedShares, uint256 feePercent, uint256 pps, uint256 decimals) public view returns (uint256 feeAmount) {
    (uint256 costBasis, uint256 updatedUsedShares) = calculateCostBasisView(user, yieldSourceAddress, usedShares);
    /// @dev if a user performs a deposit outside superform, his shares were truncated in L87. Likewise we use the
    ///  truncated shares to roll back to the original asset amount that belongs to an action done through superform
    ///  core v2
    if (usedShares != updatedUsedShares) {
        amountAssets = Math.mulDiv(updatedUsedShares, pps, 10 ** decimals);
    }
    feeAmount = _calculateFees(costBasis, amountAssets, feePercent);
}
```

## Related Implementations

### calculateCostBasisView(address,address,uint256)

- **Kind**: internal
- **Source**: 3628:656:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:calculateCostBasisView(address,address,uint256)`

```solidity
/// @inheritdoc ISuperLedger
function calculateCostBasisView(address user, address yieldSource, uint256 usedShares) public view returns (uint256 costBasis, uint256 shares) {
    uint256 accumulatorShares = usersAccumulatorShares[user][yieldSource];
    uint256 accumulatorCostBasis = usersAccumulatorCostBasis[user][yieldSource];
    if (usedShares > accumulatorShares) {
        usedShares = accumulatorShares;
    }
    costBasis = (usedShares > 0) ? Math.mulDiv(accumulatorCostBasis, usedShares, accumulatorShares) : 0;
    shares = usedShares;
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

### _calculateFees(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 10351:446:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:_calculateFees(uint256,uint256,uint256)`

```solidity
/// @notice Calculates performance fees based on realized profit
///  @dev Compares current asset value to cost basis to determine profit
///       Applies the fee percentage to any positive profit amount
///       Uses basis points (10,000 = 100%) for fee percentage
///  @param costBasis Original acquisition value of the shares
///  @param amountAssets Current value of the shares in asset terms
///  @param feePercent Fee percentage in basis points (e.g., 1000 = 10%)
///  @return feeAmount The calculated fee amount based on profit
function _calculateFees(uint256 costBasis, uint256 amountAssets, uint256 feePercent) virtual internal pure returns (uint256 feeAmount) {
    uint256 profit = (amountAssets > costBasis) ? (amountAssets - costBasis) : 0;
    if (profit > 0) {
        if (feePercent == 0) revert FEE_NOT_SET();
        feeAmount = Math.mulDiv(profit, feePercent, 10_000);
    }
}
```

## State Variable Reads

- **usersAccumulatorShares** (`mapping(address => mapping(address => uint256))`)
- **usersAccumulatorCostBasis** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseLedger.previewFees(address,address,uint256,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseLedger.calculateCostBasisView(address,address,uint256) (NodeID: 1)
  │   💬 Args: [user, yieldSourceAddress, usedShares]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 2)
  │     💬 Args: [accumulatorCostBasis, usedShares, accumulatorShares]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 3)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 4)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 5)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 6)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [updatedUsedShares, pps, 10 ** decimals]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 8)
  │ │   💬 Args: [x, y]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 9)
  │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 10)
  │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 11)
  │         💬 Args: [condition]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseLedger._calculateFees(uint256,uint256,uint256) (NodeID: 12)
      💬 Args: [costBasis, amountAssets, feePercent]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 13)
        💬 Args: [profit, feePercent, 10_000]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 14)
      │   💬 Args: [x, y]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 15)
          💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 16)
            💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 17)
              💬 Args: [condition]
              👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedger

### Interface Documentation

@notice Previews fees for a given amount of assets obtained from shares without modifying state
 @dev Used to estimate fees before executing a transaction
      Fee calculation: fee = (current_value - cost_basis) * fee_percent / 10_000
      Returns 0 if there is no profit (current_value <= cost_basis)
 @param user The user address whose fees are being calculated
 @param yieldSourceAddress The yield source address (e.g. aUSDC, cUSDC, etc.)
 @param amountAssets The amount of assets retrieved from shares (current value)
 @param usedShares The amount of shares used to obtain the assets
 @param feePercent The fee percentage in basis points (0-10000, where 10000 = 100%)
 @param pps The price per share at the time of outflow (in asset terms)
 @param decimals Decimal precision of the yield source
 @return feeAmount The amount of fee to be collected in the asset being withdrawn
