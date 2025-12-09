# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/tokens/OfframpTokensHook.sol/contract_OfframpTokensHook.md]

## Metadata

- **Contract**: OfframpTokensHook
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
- **Source**: 1281:1558:395
- **Link**: `lib/v2-core/src/hooks/tokens/OfframpTokensHook.sol:OfframpTokensHook:_buildHookExecutions(address,address,bytes)`

```solidity
function _buildHookExecutions(address, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    address to = BytesLib.toAddress(data, 0);
    bytes memory tokensData = BytesLib.slice(data, 20, data.length - 20);
    address[] memory tokens = abi.decode(tokensData, (address[]));
    tokens.insertionSort();
    tokens.uniquifySorted();
    uint256 tokensLen = tokens.length;
    uint256 executionIndex;
    executions = new Execution[](tokensLen);
    for (uint256 i; i < tokensLen; ++i) {
        address _token = tokens[i];
        uint256 balance = (_token == NATIVE_TOKEN) ? account.balance : IERC20(_token).balanceOf(account);
        if (balance == 0) continue;
        if (_token == NATIVE_TOKEN) {
            executions[executionIndex] = Execution({target: to, value: balance, callData: ""});
        } else {
            executions[executionIndex] = Execution({target: _token, value: 0, callData: abi.encodeCall(IERC20.transfer, (to, balance))});
        }
        executionIndex++;
    }
    assembly {
        mstore(executions, executionIndex)
    }
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

### insertionSort(address[])

- **Kind**: internal
- **Source**: 2133:100:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:insertionSort(address[])`

```solidity
/// @dev Sorts the array in-place with insertion sort.
function insertionSort(address[] memory a) internal pure {
    insertionSort(_toUints(a));
}
```

### insertionSort(uint256[])

- **Kind**: internal
- **Source**: 840:1020:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:insertionSort(uint256[])`

```solidity
/// @dev Sorts the array in-place with insertion sort.
function insertionSort(uint256[] memory a) internal pure {
    /// @solidity memory-safe-assembly
    assembly {
        let n := mload(a)
        mstore(a, 0)
        let h := add(a, shl(5, n))
        let w := not(0x1f)
        for {
            let i := add(a, 0x20)
        } 1 {} {
            i := add(i, 0x20)
            if gt(i, h) {
                break
            }
            let k := mload(i)
            let j := add(i, w)
            let v := mload(j)
            if iszero(gt(v, k)) {
                continue
            }
            for {} 1 {} {
                mstore(add(j, 0x20), v)
                j := add(j, w)
                v := mload(j)
                if iszero(gt(v, k)) {
                    break
                }
            }
            mstore(add(j, 0x20), k)
        }
        mstore(a, n)
    }
}
```

### _toUints(address[])

- **Kind**: internal
- **Source**: 28279:415:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:_toUints(address[])`

```solidity
/// @dev Reinterpret cast to an uint256 array.
function _toUints(address[] memory a) private pure returns (uint256[] memory casted) {
    /// @solidity memory-safe-assembly
    assembly {
        casted := a
    }
}
```

### uniquifySorted(address[])

- **Kind**: internal
- **Source**: 9420:102:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:uniquifySorted(address[])`

```solidity
/// @dev Removes duplicate elements from a ascendingly sorted memory array.
function uniquifySorted(address[] memory a) internal pure {
    uniquifySorted(_toUints(a));
}
```

### uniquifySorted(uint256[])

- **Kind**: internal
- **Source**: 8425:722:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:uniquifySorted(uint256[])`

```solidity
/// @dev Removes duplicate elements from a ascendingly sorted memory array.
function uniquifySorted(uint256[] memory a) internal pure {
    /// @solidity memory-safe-assembly
    assembly {
        if iszero(lt(mload(a), 2)) {
            let x := add(a, 0x20)
            let y := add(a, 0x40)
            let end := add(a, shl(5, add(mload(a), 1)))
            for {} 1 {} {
                if iszero(eq(mload(x), mload(y))) {
                    x := add(x, 0x20)
                    mstore(x, mload(y))
                }
                y := add(y, 0x20)
                if eq(y, end) {
                    break
                }
            }
            mstore(a, shr(5, sub(x, a)))
        }
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: OfframpTokensHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, 0]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 3)
    │   💬 Args: [data, 20, data.length - 20]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: LibSort.insertionSort(address[]) (NodeID: 4)
    │   💬 Args: [tokens]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: LibSort.insertionSort(uint256[]) (NodeID: 5)
    │     💬 Args: [_toUints(a)]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 6)
    │       💬 Args: [a]
    │       👁️  Def: private
    └─ [2] ⚙️ FUNCTION: LibSort.uniquifySorted(address[]) (NodeID: 7)
        💬 Args: [tokens]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: LibSort.uniquifySorted(uint256[]) (NodeID: 8)
          💬 Args: [_toUints(a)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 9)
            💬 Args: [a]
            👁️  Def: private
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
