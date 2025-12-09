# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol/contract_Swap1InchHook.md]

## Metadata

- **Contract**: Swap1InchHook
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
- **Source**: 2733:1000:387
- **Link**: `lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol:Swap1InchHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    address dstToken = address(bytes20(data[:20]));
    address dstReceiver = address(bytes20(data[20:40]));
    uint256 value = uint256(bytes32(data[40:USE_PREV_HOOK_AMOUNT_POSITION]));
    bool usePrevHookAmount = _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
    bytes calldata txData_ = data[73:];
    bytes memory updatedTxData = _validateTxData(dstToken, dstReceiver, prevHook, account, usePrevHookAmount, txData_);
    executions = new Execution[](1);
    executions[0] = Execution({target: address(AGGREGATION_ROUTER), value: (usePrevHookAmount && (value > 0)) ? ISuperHookResult(prevHook).getOutAmount(account) : value, callData: usePrevHookAmount ? updatedTxData : txData_});
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

### _validateTxData(address,address,address,address,bool,bytes)

- **Kind**: internal
- **Source**: 6433:1287:387
- **Link**: `lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol:Swap1InchHook:_validateTxData(address,address,address,address,bool,bytes)`

```solidity
function _validateTxData(address dstToken, address dstReceiver, address prevHook, address account, bool usePrevHookAmount, bytes calldata txData_) private view returns (bytes memory updatedTxData) {
    bytes4 selector = bytes4(txData_[:4]);
    if (selector == I1InchAggregationRouterV6.unoswapTo.selector) {
        /// @dev support UNISWAP_V2, UNISWAP_V3, CURVE and all uniswap-based forks
        updatedTxData = _validateUnoswap(txData_[4:], dstReceiver, dstToken, prevHook, account, usePrevHookAmount);
    } else if (selector == I1InchAggregationRouterV6.swap.selector) {
        /// @dev support for generic router call
        updatedTxData = _validateGenericSwap(txData_[4:], dstReceiver, dstToken, prevHook, account, usePrevHookAmount);
    } else if (selector == I1InchAggregationRouterV6.clipperSwapTo.selector) {
        updatedTxData = _validateClipperSwap(txData_[4:], dstReceiver, dstToken, prevHook, account, usePrevHookAmount);
    } else {
        revert INVALID_SELECTOR();
    }
    if (updatedTxData.length > 0) {
        updatedTxData = bytes.concat(selector, updatedTxData);
    }
}
```

### _validateUnoswap(bytes,address,address,address,address,bool)

- **Kind**: internal
- **Source**: 7726:3070:387
- **Link**: `lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol:Swap1InchHook:_validateUnoswap(bytes,address,address,address,address,bool)`

```solidity
function _validateUnoswap(bytes calldata txData_, address receiver, address toToken, address prevHook, address account, bool usePrevHookAmount) private view returns (bytes memory updatedTxData) {
    (Address to, Address token, uint256 amount, uint256 minReturn, Address dex) = abi.decode(txData_, (Address, Address, uint256, uint256, Address));
    address dstToken;
    ProtocolLib.Protocol protocol = dex.protocol();
    if (protocol == ProtocolLib.Protocol.Curve) {
        uint256 selectorOffset = (Address.unwrap(dex) >> _CURVE_TO_COINS_SELECTOR_OFFSET) & _CURVE_TO_COINS_SELECTOR_MASK;
        uint256 dstTokenIndex = (Address.unwrap(dex) >> _CURVE_TO_COINS_ARG_OFFSET) & _CURVE_TO_COINS_ARG_MASK;
        uint128 dstTokenIndex128 = dstTokenIndex.toUint128();
        if (selectorOffset == 0) {
            dstToken = ICurvePool(dex.get()).base_coins(dstTokenIndex);
        } else if (selectorOffset == 4) {
            dstToken = ICurvePool(dex.get()).coins(int256(uint256(dstTokenIndex128)).toInt128());
        } else if (selectorOffset == 8) {
            dstToken = ICurvePool(dex.get()).coins(dstTokenIndex);
        } else if (selectorOffset == 12) {
            dstToken = ICurvePool(dex.get()).underlying_coins(int256(uint256(dstTokenIndex128)).toInt128());
        } else if (selectorOffset == 16) {
            dstToken = ICurvePool(dex.get()).underlying_coins(dstTokenIndex);
        } else {
            revert INVALID_SELECTOR_OFFSET();
        }
    } else {
        address token0 = IUniswapPair(dex.get()).token0();
        address token1 = IUniswapPair(dex.get()).token1();
        address fromToken = token.get();
        if (token0 == fromToken) {
            dstToken = token1;
        } else if (token1 == fromToken) {
            dstToken = token0;
        } else {
            revert INVALID_TOKEN_PAIR();
        }
    }
    /// @dev remap of WETH to Native if unwrapWeth flag is true
    if (dex.shouldUnwrapWeth()) {
        dstToken = NATIVE;
    }
    if (usePrevHookAmount) {
        uint256 _prevAmount = amount;
        amount = ISuperHookResult(prevHook).getOutAmount(account);
        minReturn = HookDataUpdater.getUpdatedOutputAmount(amount, _prevAmount, minReturn);
    }
    if (amount == 0) {
        revert INVALID_INPUT_AMOUNT();
    }
    if (minReturn == 0) {
        revert INVALID_OUTPUT_AMOUNT();
    }
    if (toToken != dstToken) {
        revert INVALID_DESTINATION_TOKEN();
    }
    address dstReceiver = to.get();
    if (dstReceiver != receiver) {
        revert INVALID_RECEIVER();
    }
    if (usePrevHookAmount) {
        updatedTxData = abi.encode(to, token, amount, minReturn, dex);
    }
}
```

### protocol(Address)

- **Kind**: internal
- **Source**: 2713:226:440
- **Link**: `lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol:ProtocolLib:protocol(Address)`

```solidity
function protocol(Address self) internal pure returns (Protocol) {
    return Protocol((Address.unwrap(self) >> _PROTOCOL_OFFSET));
}
```

### toUint128(uint256)

- **Kind**: internal
- **Source**: 9264:218:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint128(uint256)`

```solidity
///  @dev Returns the downcasted uint128 from uint256, reverting on
///  overflow (when the input is greater than largest uint128).
///  Counterpart to Solidity's `uint128` operator.
///  Requirements:
///  - input must fit into 128 bits
function toUint128(uint256 value) internal pure returns (uint128) {
    if (value > type(uint128).max) {
        revert SafeCastOverflowedUintDowncast(128, value);
    }
    return uint128(value);
}
```

### get(Address)

- **Kind**: internal
- **Source**: 852:135:440
- **Link**: `lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol:AddressLib:get(Address)`

```solidity
///  @notice Returns the address representation of a uint256.
///  @param a The uint256 value to convert to an address.
///  @return The address representation of the provided uint256 value.
function get(Address a) internal pure returns (address) {
    return address(uint160(Address.unwrap(a) & _LOW_160_BIT_MASK));
}
```

### toInt128(int256)

- **Kind**: internal
- **Source**: 25892:224:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toInt128(int256)`

```solidity
///  @dev Returns the downcasted int128 from int256, reverting on
///  overflow (when the input is less than smallest int128 or
///  greater than largest int128).
///  Counterpart to Solidity's `int128` operator.
///  Requirements:
///  - input must fit into 128 bits
function toInt128(int256 value) internal pure returns (int128 downcasted) {
    downcasted = int128(value);
    if (downcasted != value) {
        revert SafeCastOverflowedIntDowncast(128, value);
    }
}
```

### shouldUnwrapWeth(Address)

- **Kind**: internal
- **Source**: 2945:124:440
- **Link**: `lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol:ProtocolLib:shouldUnwrapWeth(Address)`

```solidity
function shouldUnwrapWeth(Address self) internal pure returns (bool) {
    return self.getFlag(_WETH_UNWRAP_FLAG);
}
```

### getFlag(Address,uint256)

- **Kind**: internal
- **Source**: 1278:126:440
- **Link**: `lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol:AddressLib:getFlag(Address,uint256)`

```solidity
///  @notice Checks if a given flag is set for the provided address.
///  @param a The address to check for the flag.
///  @param flag The flag to check for in the provided address.
///  @return True if the provided flag is set in the address, false otherwise.
function getFlag(Address a, uint256 flag) internal pure returns (bool) {
    return (Address.unwrap(a) & flag) != 0;
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

### _validateGenericSwap(bytes,address,address,address,address,bool)

- **Kind**: internal
- **Source**: 10802:1411:387
- **Link**: `lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol:Swap1InchHook:_validateGenericSwap(bytes,address,address,address,address,bool)`

```solidity
function _validateGenericSwap(bytes calldata txData_, address receiver, address toToken, address prevHook, address account, bool usePrevHookAmount) private view returns (bytes memory updatedTxData) {
    (IAggregationExecutor executor, I1InchAggregationRouterV6.SwapDescription memory desc, bytes memory data) = abi.decode(txData_, (IAggregationExecutor, I1InchAggregationRouterV6.SwapDescription, bytes));
    if ((desc.flags & _PARTIAL_FILL) != 0) {
        revert PARTIAL_FILL_NOT_ALLOWED();
    }
    if (address(desc.dstToken) != toToken) {
        revert INVALID_DESTINATION_TOKEN();
    }
    if (desc.dstReceiver != receiver) {
        revert INVALID_RECEIVER();
    }
    if (usePrevHookAmount) {
        uint256 _prevAmount = desc.amount;
        desc.amount = ISuperHookResult(prevHook).getOutAmount(account);
        desc.minReturnAmount = HookDataUpdater.getUpdatedOutputAmount(desc.amount, _prevAmount, desc.minReturnAmount);
    }
    if (desc.amount == 0) {
        revert INVALID_INPUT_AMOUNT();
    }
    if (desc.minReturnAmount == 0) {
        revert INVALID_OUTPUT_AMOUNT();
    }
    if (usePrevHookAmount) {
        updatedTxData = abi.encode(executor, desc, data);
    }
}
```

### _validateClipperSwap(bytes,address,address,address,address,bool)

- **Kind**: internal
- **Source**: 12219:1987:387
- **Link**: `lib/v2-core/src/hooks/swappers/1inch/Swap1InchHook.sol:Swap1InchHook:_validateClipperSwap(bytes,address,address,address,address,bool)`

```solidity
function _validateClipperSwap(bytes calldata txData_, address receiver, address toToken, address prevHook, address account, bool usePrevHookAmount) private view returns (bytes memory updatedTxData) {
    (, address recipient, , IERC20 dstToken, uint256 inputAmount, uint256 outputAmount, , , ) = abi.decode(txData_, (IClipperExchange, address, Address, IERC20, uint256, uint256, uint256, bytes32, bytes32));
    if (recipient != receiver) {
        revert INVALID_RECEIVER();
    }
    if (address(dstToken) != toToken) {
        revert INVALID_DESTINATION_TOKEN();
    }
    if (usePrevHookAmount) {
        uint256 _prevAmount = inputAmount;
        inputAmount = ISuperHookResult(prevHook).getOutAmount(account);
        outputAmount = HookDataUpdater.getUpdatedOutputAmount(inputAmount, _prevAmount, outputAmount);
    }
    if (inputAmount == 0) {
        revert INVALID_INPUT_AMOUNT();
    }
    if (outputAmount == 0) {
        revert INVALID_OUTPUT_AMOUNT();
    }
    if (usePrevHookAmount) {
        updatedTxData = txData_;
        assembly {
            mstore(add(updatedTxData, add(0x20, 128)), inputAmount)
            mstore(add(updatedTxData, add(0x20, 160)), outputAmount)
        }
    }
}
```

## State Variable Reads

- **USE_PREV_HOOK_AMOUNT_POSITION** (`uint256`)
- **AGGREGATION_ROUTER** (`contract I1InchAggregationRouterV6`) [lib/v2-core/src/vendor/1inch/I1InchAggregationRouterV6.sol/interface_I1InchAggregationRouterV6.md]
- **NATIVE** (`address`)
- **_PROTOCOL_OFFSET** (`uint256`)
- **_LOW_160_BIT_MASK** (`uint256`)
- **_WETH_UNWRAP_FLAG** (`uint256`)
- **PRECISION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Swap1InchHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Swap1InchHook._validateTxData(address,address,address,address,bool,bytes) (NodeID: 3)
        💬 Args: [dstToken, dstReceiver, prevHook, account, usePrevHookAmount, txData_]
        👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: Swap1InchHook._validateUnoswap(bytes,address,address,address,address,bool) (NodeID: 4)
      │   💬 Args: [txData_[4:], dstReceiver, dstToken, prevHook, account, usePrevHookAmount]
      │   👁️  Def: private
      │ ├─ [4] ⚙️ FUNCTION: ProtocolLib.protocol(Address) (NodeID: 5)
      │ │   💬 Args: [dex]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 6)
      │ │   💬 Args: [dstTokenIndex]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 7)
      │ │   💬 Args: [dex]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 8)
      │ │   💬 Args: [dex]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 9)
      │ │   💬 Args: [int256(uint256(dstTokenIndex128))]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 10)
      │ │   💬 Args: [dex]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 11)
      │ │   💬 Args: [dex]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 12)
      │ │   💬 Args: [int256(uint256(dstTokenIndex128))]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 13)
      │ │   💬 Args: [dex]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 14)
      │ │   💬 Args: [dex]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 15)
      │ │   💬 Args: [dex]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 16)
      │ │   💬 Args: [token]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: ProtocolLib.shouldUnwrapWeth(Address) (NodeID: 17)
      │ │   💬 Args: [dex]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: AddressLib.getFlag(Address,uint256) (NodeID: 18)
      │ │     💬 Args: [self, _WETH_UNWRAP_FLAG]
      │ │     👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: HookDataUpdater.getUpdatedOutputAmount(uint256,uint256,uint256) (NodeID: 19)
      │ │   💬 Args: [amount, _prevAmount, minReturn]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 20)
      │ │ │   💬 Args: [amount - _prevAmount, PRECISION, _prevAmount]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 21)
      │ │ │ │   💬 Args: [x, y]
      │ │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 22)
      │ │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │ │ │     👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 23)
      │ │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │ │ │       👁️  Def: internal
      │ │ │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 24)
      │ │ │         💬 Args: [condition]
      │ │ │         👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 25)
      │ │ │   💬 Args: [outputAmount, percentIncrease, PRECISION]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 26)
      │ │ │ │   💬 Args: [x, y]
      │ │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 27)
      │ │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │ │ │     👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 28)
      │ │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │ │ │       👁️  Def: internal
      │ │ │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 29)
      │ │ │         💬 Args: [condition]
      │ │ │         👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 30)
      │ │ │   💬 Args: [_prevAmount - amount, PRECISION, _prevAmount]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 31)
      │ │ │ │   💬 Args: [x, y]
      │ │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 32)
      │ │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │ │ │     👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 33)
      │ │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │ │ │       👁️  Def: internal
      │ │ │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 34)
      │ │ │         💬 Args: [condition]
      │ │ │         👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 35)
      │ │     💬 Args: [outputAmount, percentDecrease, PRECISION]
      │ │     👁️  Def: internal
      │ │   ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 36)
      │ │   │   💬 Args: [x, y]
      │ │   │   👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 37)
      │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │ │       👁️  Def: internal
      │ │     └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 38)
      │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │ │         👁️  Def: internal
      │ │       └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 39)
      │ │           💬 Args: [condition]
      │ │           👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: AddressLib.get(Address) (NodeID: 40)
      │     💬 Args: [to]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Swap1InchHook._validateGenericSwap(bytes,address,address,address,address,bool) (NodeID: 41)
      │   💬 Args: [txData_[4:], dstReceiver, dstToken, prevHook, account, usePrevHookAmount]
      │   👁️  Def: private
      │ └─ [4] ⚙️ FUNCTION: HookDataUpdater.getUpdatedOutputAmount(uint256,uint256,uint256) (NodeID: 42)
      │     💬 Args: [desc.amount, _prevAmount, desc.minReturnAmount]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 43)
      │   │   💬 Args: [amount - _prevAmount, PRECISION, _prevAmount]
      │   │   👁️  Def: internal
      │   │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 44)
      │   │ │   💬 Args: [x, y]
      │   │ │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 45)
      │   │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │   │     👁️  Def: internal
      │   │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 46)
      │   │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │   │       👁️  Def: internal
      │   │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 47)
      │   │         💬 Args: [condition]
      │   │         👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 48)
      │   │   💬 Args: [outputAmount, percentIncrease, PRECISION]
      │   │   👁️  Def: internal
      │   │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 49)
      │   │ │   💬 Args: [x, y]
      │   │ │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 50)
      │   │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │   │     👁️  Def: internal
      │   │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 51)
      │   │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │   │       👁️  Def: internal
      │   │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 52)
      │   │         💬 Args: [condition]
      │   │         👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 53)
      │   │   💬 Args: [_prevAmount - amount, PRECISION, _prevAmount]
      │   │   👁️  Def: internal
      │   │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 54)
      │   │ │   💬 Args: [x, y]
      │   │ │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 55)
      │   │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │   │     👁️  Def: internal
      │   │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 56)
      │   │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │   │       👁️  Def: internal
      │   │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 57)
      │   │         💬 Args: [condition]
      │   │         👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 58)
      │       💬 Args: [outputAmount, percentDecrease, PRECISION]
      │       👁️  Def: internal
      │     ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 59)
      │     │   💬 Args: [x, y]
      │     │   👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 60)
      │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │         👁️  Def: internal
      │       └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 61)
      │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │           👁️  Def: internal
      │         └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 62)
      │             💬 Args: [condition]
      │             👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Swap1InchHook._validateClipperSwap(bytes,address,address,address,address,bool) (NodeID: 63)
          💬 Args: [txData_[4:], dstReceiver, dstToken, prevHook, account, usePrevHookAmount]
          👁️  Def: private
        └─ [4] ⚙️ FUNCTION: HookDataUpdater.getUpdatedOutputAmount(uint256,uint256,uint256) (NodeID: 64)
            💬 Args: [inputAmount, _prevAmount, outputAmount]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 65)
          │   💬 Args: [amount - _prevAmount, PRECISION, _prevAmount]
          │   👁️  Def: internal
          │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 66)
          │ │   💬 Args: [x, y]
          │ │   👁️  Def: internal
          │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 67)
          │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
          │     👁️  Def: internal
          │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 68)
          │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
          │       👁️  Def: internal
          │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 69)
          │         💬 Args: [condition]
          │         👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 70)
          │   💬 Args: [outputAmount, percentIncrease, PRECISION]
          │   👁️  Def: internal
          │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 71)
          │ │   💬 Args: [x, y]
          │ │   👁️  Def: internal
          │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 72)
          │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
          │     👁️  Def: internal
          │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 73)
          │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
          │       👁️  Def: internal
          │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 74)
          │         💬 Args: [condition]
          │         👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 75)
          │   💬 Args: [_prevAmount - amount, PRECISION, _prevAmount]
          │   👁️  Def: internal
          │ ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 76)
          │ │   💬 Args: [x, y]
          │ │   👁️  Def: internal
          │ └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 77)
          │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
          │     👁️  Def: internal
          │   └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 78)
          │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
          │       👁️  Def: internal
          │     └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 79)
          │         💬 Args: [condition]
          │         👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 80)
              💬 Args: [outputAmount, percentDecrease, PRECISION]
              👁️  Def: internal
            ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 81)
            │   💬 Args: [x, y]
            │   👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 82)
                💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
                👁️  Def: internal
              └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 83)
                  💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
                  👁️  Def: internal
                └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 84)
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
