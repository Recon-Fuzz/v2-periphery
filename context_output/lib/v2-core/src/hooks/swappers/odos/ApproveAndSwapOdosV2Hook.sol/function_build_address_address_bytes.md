# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/odos/ApproveAndSwapOdosV2Hook.sol/contract_ApproveAndSwapOdosV2Hook.md]

## Metadata

- **Contract**: ApproveAndSwapOdosV2Hook
- **Signature**: `build(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 5451:1084:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @dev Standard build pattern - MUST include preExecute first, postExecute last
///  @inheritdoc ISuperHook
function build(address prevHook, address account, bytes calldata hookData) virtual external view returns (Execution[] memory executions) {
    Execution[] memory hookExecutions = _buildHookExecutions(prevHook, account, hookData);
    executions = new Execution[](hookExecutions.length + 2);
    executions[0] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.preExecute, (prevHook, account, hookData))});
    for (uint256 i = 0; i < hookExecutions.length; i++) {
        executions[i + 1] = hookExecutions[i];
    }
    executions[executions.length - 1] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.postExecute, (prevHook, account, hookData))});
}
```

## Related Implementations

### _buildHookExecutions(address,address,bytes)

- **Kind**: internal
- **Source**: 2580:1913:388
- **Link**: `lib/v2-core/src/hooks/swappers/odos/ApproveAndSwapOdosV2Hook.sol:ApproveAndSwapOdosV2Hook:_buildHookExecutions(address,address,bytes)`

```solidity
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    HookParams memory params;
    uint256 pathDefinitionLength = BytesLib.toUint256(data, 157);
    params.pathDefinition = BytesLib.slice(data, 189, pathDefinitionLength);
    params.executor = BytesLib.toAddress(data, 189 + pathDefinitionLength);
    params.referralCode = BytesLib.toUint32(data, (189 + pathDefinitionLength) + 20);
    params.inputToken = BytesLib.toAddress(data, 0);
    params.inputAmount = BytesLib.toUint256(data, 20);
    bool usePrevHookAmount = _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
    if (usePrevHookAmount) {
        params.inputAmount = ISuperHookResult(prevHook).getOutAmount(account);
    }
    params.approveSpender = address(ODOS_ROUTER_V2);
    executions = new Execution[](4);
    executions[0] = Execution({target: params.inputToken, value: 0, callData: abi.encodeCall(IERC20.approve, (params.approveSpender, 0))});
    executions[1] = Execution({target: params.inputToken, value: 0, callData: abi.encodeCall(IERC20.approve, (params.approveSpender, params.inputAmount))});
    executions[2] = Execution({target: address(ODOS_ROUTER_V2), value: 0, callData: abi.encodeCall(IOdosRouterV2.swap, (_getSwapInfo(account, prevHook, data), params.pathDefinition, params.executor, params.referralCode))});
    executions[3] = Execution({target: params.inputToken, value: 0, callData: abi.encodeCall(IERC20.approve, (params.approveSpender, 0))});
}
```

### toUint256(bytes,uint256)

- **Kind**: internal
- **Source**: 14359:311:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint256(bytes,uint256)`

```solidity
function toUint256(bytes memory _bytes, uint256 _start) internal pure returns (uint256) {
    require(_bytes.length >= (_start + 32), "toUint256_outOfBounds");
    uint256 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x20), _start))
    }
    return tempUint;
}
```

### slice(bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 9250:2874:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:slice(bytes,uint256,uint256)`

```solidity
function slice(bytes memory _bytes, uint256 _start, uint256 _length) internal pure returns (bytes memory) {
    unchecked {
        require((_length + 31) >= _length, "slice_overflow");
    }
    require(_bytes.length >= (_start + _length), "slice_outOfBounds");
    bytes memory tempBytes;
    assembly {
        switch iszero(_length)
        case 0 {
            tempBytes := mload(0x40)
            let lengthmod := and(_length, 31)
            let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
            let end := add(mc, _length)
            for {
                let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
            } lt(mc, end) {
                mc := add(mc, 0x20)
                cc := add(cc, 0x20)
            } {
                mstore(mc, mload(cc))
            }
            mstore(tempBytes, _length)
            mstore(0x40, and(add(mc, 31), not(31)))
        }
        default {
            tempBytes := mload(0x40)
            mstore(tempBytes, 0)
            mstore(0x40, add(tempBytes, 0x20))
        }
    }
    return tempBytes;
}
```

### toAddress(bytes,uint256)

- **Kind**: internal
- **Source**: 12130:354:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toAddress(bytes,uint256)`

```solidity
function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
    require(_bytes.length >= (_start + 20), "toAddress_outOfBounds");
    address tempAddress;
    assembly {
        tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }
    return tempAddress;
}
```

### toUint32(bytes,uint256)

- **Kind**: internal
- **Source**: 13108:305:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint32(bytes,uint256)`

```solidity
function toUint32(bytes memory _bytes, uint256 _start) internal pure returns (uint32) {
    require(_bytes.length >= (_start + 4), "toUint32_outOfBounds");
    uint32 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x4), _start))
    }
    return tempUint;
}
```

### _decodeBool(bytes,uint256)

- **Kind**: internal
- **Source**: 11462:126:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_decodeBool(bytes,uint256)`

```solidity
/// @notice Decodes a boolean value from a byte array at the specified offset
///  @dev Helper function for extracting boolean values from packed data
///       Used when parsing hook-specific data parameters
///  @param data The byte array containing the encoded data
///  @param offset The position in the array to read from
///  @return The decoded boolean value (true if byte is non-zero)
function _decodeBool(bytes memory data, uint256 offset) internal pure returns (bool) {
    return data[offset] != 0;
}
```

### _getSwapInfo(address,address,bytes)

- **Kind**: internal
- **Source**: 6482:1074:388
- **Link**: `lib/v2-core/src/hooks/swappers/odos/ApproveAndSwapOdosV2Hook.sol:ApproveAndSwapOdosV2Hook:_getSwapInfo(address,address,bytes)`

```solidity
function _getSwapInfo(address account, address prevHook, bytes memory data) private view returns (IOdosRouterV2.swapTokenInfo memory) {
    address inputToken = BytesLib.toAddress(data, 0);
    uint256 inputAmount = BytesLib.toUint256(data, 20);
    address inputReceiver = BytesLib.toAddress(data, 52);
    address outputToken = BytesLib.toAddress(data, 72);
    uint256 outputQuote = BytesLib.toUint256(data, 92);
    uint256 outputAmount = BytesLib.toUint256(data, 124);
    bool usePrevHookAmount = _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
    if (usePrevHookAmount) {
        uint256 _prevAmount = inputAmount;
        inputAmount = ISuperHookResult(prevHook).getOutAmount(account);
        outputAmount = HookDataUpdater.getUpdatedOutputAmount(inputAmount, _prevAmount, outputAmount);
    }
    return IOdosRouterV2.swapTokenInfo(inputToken, inputAmount, inputReceiver, outputToken, outputQuote, outputAmount, account);
}
```

### getUpdatedOutputAmount(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 210:851:433
- **Link**: `lib/v2-core/src/libraries/HookDataUpdater.sol:HookDataUpdater:getUpdatedOutputAmount(uint256,uint256,uint256)`

```solidity
function getUpdatedOutputAmount(uint256 amount, uint256 _prevAmount, uint256 outputAmount) internal pure returns (uint256) {
    if (_prevAmount == 0) return outputAmount;
    if (amount != _prevAmount) {
        if (amount > _prevAmount) {
            uint256 percentIncrease = Math.mulDiv(amount - _prevAmount, PRECISION, _prevAmount);
            outputAmount = outputAmount + Math.mulDiv(outputAmount, percentIncrease, PRECISION);
        } else {
            uint256 percentDecrease = Math.mulDiv(_prevAmount - amount, PRECISION, _prevAmount);
            uint256 decreaseAmount = Math.mulDiv(outputAmount, percentDecrease, PRECISION);
            outputAmount = outputAmount - decreaseAmount;
        }
    }
    return outputAmount;
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

- **USE_PREV_HOOK_AMOUNT_POSITION** (`uint256`)
- **ODOS_ROUTER_V2** (`contract IOdosRouterV2`) [lib/v2-core/src/vendor/odos/IOdosRouterV2.sol/interface_IOdosRouterV2.md]
- **PRECISION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ApproveAndSwapOdosV2Hook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, 157]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 3)
    │   💬 Args: [data, 189, pathDefinitionLength]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
    │   💬 Args: [data, 189 + pathDefinitionLength]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint32(bytes,uint256) (NodeID: 5)
    │   💬 Args: [data, (189 + pathDefinitionLength) + 20]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 6)
    │   💬 Args: [data, 0]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 7)
    │   💬 Args: [data, 20]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 8)
    │   💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ApproveAndSwapOdosV2Hook._getSwapInfo(address,address,bytes) (NodeID: 9)
        💬 Args: [account, prevHook, data]
        👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 10)
      │   💬 Args: [data, 0]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 11)
      │   💬 Args: [data, 20]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 12)
      │   💬 Args: [data, 52]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 13)
      │   💬 Args: [data, 72]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 14)
      │   💬 Args: [data, 92]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 15)
      │   💬 Args: [data, 124]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 16)
      │   💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: HookDataUpdater.getUpdatedOutputAmount(uint256,uint256,uint256) (NodeID: 17)
          💬 Args: [inputAmount, _prevAmount, outputAmount]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 18)
        │   💬 Args: [amount - _prevAmount, PRECISION, _prevAmount]
        │   👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 19)
        │ │   💬 Args: [x, y]
        │ │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 20)
        │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
        │     👁️  Def: internal
        │   └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 21)
        │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
        │       👁️  Def: internal
        │     └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 22)
        │         💬 Args: [condition]
        │         👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 23)
        │   💬 Args: [outputAmount, percentIncrease, PRECISION]
        │   👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 24)
        │ │   💬 Args: [x, y]
        │ │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 25)
        │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
        │     👁️  Def: internal
        │   └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 26)
        │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
        │       👁️  Def: internal
        │     └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 27)
        │         💬 Args: [condition]
        │         👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 28)
        │   💬 Args: [_prevAmount - amount, PRECISION, _prevAmount]
        │   👁️  Def: internal
        │ ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 29)
        │ │   💬 Args: [x, y]
        │ │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 30)
        │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
        │     👁️  Def: internal
        │   └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 31)
        │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
        │       👁️  Def: internal
        │     └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 32)
        │         💬 Args: [condition]
        │         👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 33)
            💬 Args: [outputAmount, percentDecrease, PRECISION]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 34)
          │   💬 Args: [x, y]
          │   👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 35)
              💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 36)
                💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
                👁️  Def: internal
              └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 37)
                  💬 Args: [condition]
                  👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Standard build pattern - MUST include preExecute first, postExecute last
 @inheritdoc ISuperHook

### Interface Documentation

@notice Builds the execution array for the hook operation
 @dev This is the core method where hooks define their on-chain interactions
      The returned executions are a sequence of contract calls to perform
      No state changes should occur in this method
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account to perform executions for (usually an ERC7579 account)
 @param data The hook-specific parameters and configuration data
 @return executions Array of Execution structs defining calls to make
