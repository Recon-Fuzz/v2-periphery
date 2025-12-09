# Function: encode(address,uint256,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/ERC7579Helpers.sol/contract_ERC7579Helpers.md]

## Metadata

- **Contract**: ERC7579Helpers
- **Signature**: `encode(address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 20733:551:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice Encode a single ERC7579 Execution Transaction
///  @param target address the target
///  @param value uint256 the value
///  @param callData bytes the callData of the call
///  @return erc7579Tx bytes the encoded ERC7579 transaction
function encode(address target, uint256 value, bytes memory callData) virtual public pure returns (bytes memory erc7579Tx) {
    ModeCode mode = ModeLib.encode({callType: CALLTYPE_SINGLE, execType: EXECTYPE_DEFAULT, mode: MODE_DEFAULT, payload: ModePayload.wrap(bytes22(0))});
    bytes memory data = abi.encodePacked(target, value, callData);
    return abi.encodeCall(IERC7579Account.execute, (mode, data));
}
```

## Related Implementations

### encode(CallType,ExecType,ModeSelector,ModePayload)

- **Kind**: internal
- **Source**: 4337:376:150
- **Link**: `lib/v2-core/lib/modulekit/src/accounts/common/lib/ModeLib.sol:ModeLib:encode(CallType,ExecType,ModeSelector,ModePayload)`

```solidity
function encode(CallType callType, ExecType execType, ModeSelector mode, ModePayload payload) internal pure returns (ModeCode) {
    return ModeCode.wrap(bytes32(abi.encodePacked(callType, execType, bytes4(0), ModeSelector.unwrap(mode), payload)));
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HelperBase.encode(address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 1)
      💬 Args: [CALLTYPE_SINGLE, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Encode a single ERC7579 Execution Transaction
 @param target address the target
 @param value uint256 the value
 @param callData bytes the callData of the call
 @return erc7579Tx bytes the encoded ERC7579 transaction
