# Function: postOp(enum IPaymaster.PostOpMode,bytes,uint256,uint256)

**Contract**: [lib/v2-core/src/paymaster/SuperNativePaymaster.sol/contract_SuperNativePaymaster.md]

## Metadata

- **Contract**: SuperNativePaymaster
- **Signature**: `postOp(enum IPaymaster.PostOpMode,bytes,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2630:298:442
- **Inherited From**: BasePaymaster

## Implementation

```solidity
/// @inheritdoc IPaymaster
function postOp(PostOpMode mode, bytes calldata context, uint256 actualGasCost, uint256 actualUserOpFeePerGas) override external {
    _requireFromEntryPoint();
    _postOp(mode, context, actualGasCost, actualUserOpFeePerGas);
}
```

## Related Implementations

### _requireFromEntryPoint()

- **Kind**: internal
- **Source**: 4603:135:442
- **Link**: `lib/v2-core/src/vendor/account-abstraction/BasePaymaster.sol:BasePaymaster:_requireFromEntryPoint()`

```solidity
///  Validate the call is made from a valid entrypoint
function _requireFromEntryPoint() virtual internal {
    require(msg.sender == address(entryPoint), "Sender not EntryPoint");
}
```

### _postOp(enum IPaymaster.PostOpMode,bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 6850:1179:436
- **Link**: `lib/v2-core/src/paymaster/SuperNativePaymaster.sol:SuperNativePaymaster:_postOp(enum IPaymaster.PostOpMode,bytes,uint256,uint256)`

```solidity
/// @notice Handle the post-operation logic.
///          Executes userOp and gives back refund to the userOp.sender if userOp.sender has overpaid for execution.
///  @dev Verified to be called only through the entryPoint.
///       If subclass returns a non-empty context from validatePaymasterUserOp, it must also implement this method.
///                                     Now this is the 2nd call, after user's op was deliberately reverted.
///  @param context The context value returned by validatePaymasterUserOp.
///  @param actualGasCost The actual gas used so far (without this postOp call).
function _postOp(PostOpMode, bytes calldata context, uint256 actualGasCost, uint256) virtual override internal {
    (address sender, uint256 maxFeePerGas, uint256 maxPriorityFeePerGas, uint256 maxGasLimit, uint256 nodeOperatorPremium, uint256 postOpGas) = abi.decode(context, (address, uint256, uint256, uint256, uint256, uint256));
    uint256 price = _getPriceFee(maxFeePerGas, maxPriorityFeePerGas);
    actualGasCost += (postOpGas * price);
    uint256 refund = calculateRefund(maxGasLimit, maxFeePerGas, actualGasCost, nodeOperatorPremium);
    if (refund > 0) {
        uint256 deposit = entryPoint.getDepositInfo(address(this)).deposit;
        uint256 refundAmount = (refund > deposit) ? deposit : refund;
        entryPoint.withdrawTo(payable(sender), refundAmount);
        emit SuperNativePaymasterRefund(sender, refundAmount, refund);
    }
    emit SuperNativePaymasterPostOp(context);
}
```

### _getPriceFee(uint256,uint256)

- **Kind**: internal
- **Source**: 8382:360:436
- **Link**: `lib/v2-core/src/paymaster/SuperNativePaymaster.sol:SuperNativePaymaster:_getPriceFee(uint256,uint256)`

```solidity
function _getPriceFee(uint256 maxFeePerGas, uint256 maxPriorityFeePerGas) private view returns (uint256) {
    if (maxFeePerGas == maxPriorityFeePerGas) {
        return maxFeePerGas;
    }
    return Math.min(maxFeePerGas, maxPriorityFeePerGas + block.basefee);
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 5617:111:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return ternary(a < b, a, b);
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

### calculateRefund(uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1608:635:436
- **Link**: `lib/v2-core/src/paymaster/SuperNativePaymaster.sol:SuperNativePaymaster:calculateRefund(uint256,uint256,uint256,uint256)`

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

## State Variable Reads

- **entryPoint** (`contract IEntryPoint`) [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IEntryPoint.sol/interface_IEntryPoint.md]
- **MAX_NODE_OPERATOR_PREMIUM** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasePaymaster.postOp(enum IPaymaster.PostOpMode,bytes,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BasePaymaster._requireFromEntryPoint() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperNativePaymaster._postOp(enum IPaymaster.PostOpMode,bytes,uint256,uint256) (NodeID: 2)
      💬 Args: [mode, context, actualGasCost, actualUserOpFeePerGas]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperNativePaymaster._getPriceFee(uint256,uint256) (NodeID: 3)
    │   💬 Args: [maxFeePerGas, maxPriorityFeePerGas]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 4)
    │     💬 Args: [maxFeePerGas, maxPriorityFeePerGas + block.basefee]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 5)
    │       💬 Args: [a < b, a, b]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 6)
    │         💬 Args: [condition]
    │         👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperNativePaymaster.calculateRefund(uint256,uint256,uint256,uint256) (NodeID: 7)
        💬 Args: [maxGasLimit, maxFeePerGas, actualGasCost, nodeOperatorPremium]
        👁️  Def: public
      └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 8)
          💬 Args: [actualGasCost, MAX_NODE_OPERATOR_PREMIUM + nodeOperatorPremium, MAX_NODE_OPERATOR_PREMIUM]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 9)
        │   💬 Args: [x, y]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 10)
            💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 11)
              💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 12)
                💬 Args: [condition]
                👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IPaymaster

### Interface Documentation

 Post-operation handler.
 Must verify sender is the entryPoint.
 @param mode          - Enum with the following options:
                        opSucceeded - User operation succeeded.
                        opReverted  - User op reverted. The paymaster still has to pay for gas.
                        postOpReverted - never passed in a call to postOp().
 @param context       - The context value returned by validatePaymasterUserOp
 @param actualGasCost - Actual gas used so far (without this postOp call).
 @param actualUserOpFeePerGas - the gas price this UserOp pays. This value is based on the UserOp's maxFeePerGas
                        and maxPriorityFee (and basefee)
                        It is not the same as tx.gasprice, which is what the bundler pays.
