# Function: calculateRefund(uint256,uint256,uint256,uint256)

**Contract**: [lib/v2-core/src/paymaster/SuperNativePaymaster.sol/contract_SuperNativePaymaster.md]

## Metadata

- **Contract**: SuperNativePaymaster
- **Signature**: `calculateRefund(uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1608:635:436

## Implementation

```solidity
/// @inheritdoc ISuperNativePaymaster
function calculateRefund(uint256 maxGasLimit, uint256 maxFeePerGas, uint256 actualGasCost, uint256 nodeOperatorPremium) public pure returns (uint256 refund) {
    if (nodeOperatorPremium > MAX_NODE_OPERATOR_PREMIUM) revert INVALID_NODE_OPERATOR_PREMIUM();
    uint256 costWithPremium = Math.mulDiv(actualGasCost, MAX_NODE_OPERATOR_PREMIUM + nodeOperatorPremium, MAX_NODE_OPERATOR_PREMIUM);
    uint256 maxCost = maxGasLimit * maxFeePerGas;
    if (costWithPremium < maxCost) {
        refund = maxCost - costWithPremium;
    }
}
```

## Related Implementations

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

- **MAX_NODE_OPERATOR_PREMIUM** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperNativePaymaster.calculateRefund(uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [actualGasCost, MAX_NODE_OPERATOR_PREMIUM + nodeOperatorPremium, MAX_NODE_OPERATOR_PREMIUM]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 2)
    │   💬 Args: [x, y]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 3)
        💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 4)
          💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 5)
            💬 Args: [condition]
            👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperNativePaymaster

### Interface Documentation

@notice Calculate the refund amount based on gas parameters
 @dev Takes into account node operator premium when calculating refunds
      Returns zero if the actual cost (with premium) exceeds the maximum cost
 @param maxGasLimit The maximum gas limit specified for the operation
 @param maxFeePerGas The maximum fee per gas specified for the operation
 @param actualGasCost The actual gas cost of the operation
 @param nodeOperatorPremium The premium percentage for the node operator (in basis points)
 @return refund The amount of native tokens to refund
