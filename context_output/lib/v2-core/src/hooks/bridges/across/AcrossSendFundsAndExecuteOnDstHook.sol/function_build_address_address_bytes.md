# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/bridges/across/AcrossSendFundsAndExecuteOnDstHook.sol/contract_AcrossSendFundsAndExecuteOnDstHook.md]

## Metadata

- **Contract**: AcrossSendFundsAndExecuteOnDstHook
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
- **Source**: 3648:4473:366
- **Link**: `lib/v2-core/src/hooks/bridges/across/AcrossSendFundsAndExecuteOnDstHook.sol:AcrossSendFundsAndExecuteOnDstHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    if (data.length < 217) revert DATA_NOT_VALID();
    AcrossV3DepositAndExecuteData memory acrossV3DepositAndExecuteData;
    acrossV3DepositAndExecuteData.value = BytesLib.toUint256(data, 0);
    acrossV3DepositAndExecuteData.recipient = BytesLib.toAddress(data, 32);
    acrossV3DepositAndExecuteData.inputToken = BytesLib.toAddress(data, 52);
    acrossV3DepositAndExecuteData.outputToken = BytesLib.toAddress(data, 72);
    acrossV3DepositAndExecuteData.inputAmount = BytesLib.toUint256(data, 92);
    acrossV3DepositAndExecuteData.outputAmount = BytesLib.toUint256(data, 124);
    acrossV3DepositAndExecuteData.destinationChainId = BytesLib.toUint256(data, 156);
    acrossV3DepositAndExecuteData.exclusiveRelayer = BytesLib.toAddress(data, 188);
    acrossV3DepositAndExecuteData.fillDeadlineOffset = BytesLib.toUint32(data, 208);
    acrossV3DepositAndExecuteData.exclusivityPeriod = BytesLib.toUint32(data, 212);
    acrossV3DepositAndExecuteData.usePrevHookAmount = _decodeBool(data, USE_PREV_HOOK_AMOUNT_POSITION);
    acrossV3DepositAndExecuteData.destinationMessage = BytesLib.slice(data, 217, data.length - 217);
    if (acrossV3DepositAndExecuteData.usePrevHookAmount) {
        uint256 outAmount = ISuperHookResult(prevHook).getOutAmount(account);
        if ((acrossV3DepositAndExecuteData.inputAmount > 0) && (acrossV3DepositAndExecuteData.outputAmount > 0)) {
            acrossV3DepositAndExecuteData.outputAmount = Math.mulDiv(acrossV3DepositAndExecuteData.outputAmount, outAmount, acrossV3DepositAndExecuteData.inputAmount);
        }
        acrossV3DepositAndExecuteData.inputAmount = outAmount;
        if ((acrossV3DepositAndExecuteData.inputToken == address(IAcrossSpokePoolV3(SPOKE_POOL_V3).wrappedNativeToken())) && (acrossV3DepositAndExecuteData.value != 0)) {
            acrossV3DepositAndExecuteData.value = outAmount;
        }
    }
    if (acrossV3DepositAndExecuteData.inputAmount == 0) revert AMOUNT_NOT_VALID();
    if (acrossV3DepositAndExecuteData.recipient == address(0)) {
        revert ADDRESS_NOT_VALID();
    }
    if (acrossV3DepositAndExecuteData.destinationMessage.length > 0) {
        bytes memory signature = ISuperSignatureStorage(VALIDATOR).retrieveSignatureData(account);
        (bytes memory initData, bytes memory executorCalldata, address _account, address[] memory dstTokens, uint256[] memory intentAmounts) = abi.decode(acrossV3DepositAndExecuteData.destinationMessage, (bytes, bytes, address, address[], uint256[]));
        acrossV3DepositAndExecuteData.destinationMessage = abi.encode(initData, executorCalldata, _account, dstTokens, intentAmounts, signature);
    }
    executions = new Execution[](1);
    executions[0] = Execution({target: SPOKE_POOL_V3, value: acrossV3DepositAndExecuteData.value, callData: abi.encodeCall(IAcrossSpokePoolV3.depositV3Now, (account, acrossV3DepositAndExecuteData.recipient, acrossV3DepositAndExecuteData.inputToken, acrossV3DepositAndExecuteData.outputToken, acrossV3DepositAndExecuteData.inputAmount, acrossV3DepositAndExecuteData.outputAmount, acrossV3DepositAndExecuteData.destinationChainId, acrossV3DepositAndExecuteData.exclusiveRelayer, acrossV3DepositAndExecuteData.fillDeadlineOffset, acrossV3DepositAndExecuteData.exclusivityPeriod, acrossV3DepositAndExecuteData.destinationMessage))});
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
- **SPOKE_POOL_V3** (`address`)
- **VALIDATOR** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AcrossSendFundsAndExecuteOnDstHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, 0]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │   💬 Args: [data, 32]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
    │   💬 Args: [data, 52]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 5)
    │   💬 Args: [data, 72]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 6)
    │   💬 Args: [data, 92]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 7)
    │   💬 Args: [data, 124]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 8)
    │   💬 Args: [data, 156]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 9)
    │   💬 Args: [data, 188]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint32(bytes,uint256) (NodeID: 10)
    │   💬 Args: [data, 208]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint32(bytes,uint256) (NodeID: 11)
    │   💬 Args: [data, 212]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 12)
    │   💬 Args: [data, USE_PREV_HOOK_AMOUNT_POSITION]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 13)
    │   💬 Args: [data, 217, data.length - 217]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 14)
        💬 Args: [acrossV3DepositAndExecuteData.outputAmount, outAmount, acrossV3DepositAndExecuteData.inputAmount]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 15)
      │   💬 Args: [x, y]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 16)
          💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 17)
            💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 18)
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
