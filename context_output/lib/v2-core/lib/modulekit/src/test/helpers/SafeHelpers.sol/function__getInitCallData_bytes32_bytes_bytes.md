# Function: _getInitCallData(bytes32,bytes,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/SafeHelpers.sol/contract_SafeHelpers.md]

## Metadata

- **Contract**: SafeHelpers
- **Signature**: `_getInitCallData(bytes32,bytes,bytes)`
- **Visibility**: public
- **Source Range**: 19200:877:238

## Implementation

```solidity
/// @notice Gets the initCode and callData for a new account instance
///  @param salt bytes32 the salt for the account instance
///  @param originalInitCode bytes the original initCode for the account instance
///  @param erc4337CallData bytes the callData for the ERC4337 call
function _getInitCallData(bytes32 salt, bytes memory originalInitCode, bytes memory erc4337CallData) public pure returns (bytes memory initCode, bytes memory callData) {
    address factory;
    assembly {
        factory := mload(add(originalInitCode, 20))
    }
    bytes memory initData2 = LibBytes.slice(originalInitCode, 120, originalInitCode.length);
    ISafe7579Launchpad.InitData memory initData = abi.decode(initData2, (ISafe7579Launchpad.InitData));
    initData.callData = erc4337CallData;
    initCode = abi.encodePacked(factory, abi.encodeCall(SafeFactory.createAccount, (salt, abi.encode(initData))));
    callData = abi.encodeCall(ISafe7579Launchpad.setupSafe, (initData));
}
```

## Related Implementations

### slice(bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 19213:1115:320
- **Link**: `lib/v2-core/lib/solady/src/utils/LibBytes.sol:LibBytes:slice(bytes,uint256,uint256)`

```solidity
/// @dev Returns a copy of `subject` sliced from `start` to `end` (exclusive).
///  `start` and `end` are byte offsets.
function slice(bytes memory subject, uint256 start, uint256 end) internal pure returns (bytes memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        let l := mload(subject)
        if iszero(gt(l, end)) {
            end := l
        }
        if iszero(gt(l, start)) {
            start := l
        }
        if lt(start, end) {
            result := mload(0x40)
            let n := sub(end, start)
            let i := add(subject, start)
            let w := not(0x1f)
            for {
                let j := and(add(n, 0x1f), w)
            } 1 {} {
                mstore(add(result, j), mload(add(i, j)))
                j := add(j, w)
                if iszero(j) {
                    break
                }
            }
            let o := add(add(result, 0x20), n)
            mstore(o, 0)
            mstore(0x40, add(o, 0x20))
            mstore(result, n)
        }
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeHelpers._getInitCallData(bytes32,bytes,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: LibBytes.slice(bytes,uint256,uint256) (NodeID: 1)
      💬 Args: [originalInitCode, 120, originalInitCode.length]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Gets the initCode and callData for a new account instance
 @param salt bytes32 the salt for the account instance
 @param originalInitCode bytes the original initCode for the account instance
 @param erc4337CallData bytes the callData for the ERC4337 call
