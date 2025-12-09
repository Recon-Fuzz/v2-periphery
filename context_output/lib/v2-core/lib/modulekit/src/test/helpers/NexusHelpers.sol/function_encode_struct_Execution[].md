# Function: encode(struct Execution[])

**Contract**: [lib/v2-core/lib/modulekit/src/test/helpers/NexusHelpers.sol/contract_NexusHelpers.md]

## Metadata

- **Contract**: NexusHelpers
- **Signature**: `encode(struct Execution[])`
- **Visibility**: public
- **Source Range**: 21481:444:235
- **Inherited From**: HelperBase

## Implementation

```solidity
/// @notice Encode a batch of ERC7579 Execution Transactions
///  @param executions Execution[] the array of executions
///  @return erc7579Tx bytes the encoded ERC7579 transaction
function encode(Execution[] memory executions) virtual public pure returns (bytes memory erc7579Tx) {
    ModeCode mode = ModeLib.encode({callType: CALLTYPE_BATCH, execType: EXECTYPE_DEFAULT, mode: MODE_DEFAULT, payload: ModePayload.wrap(bytes22(0))});
    return abi.encodeCall(IERC7579Account.execute, (mode, abi.encode(executions)));
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
┌─ [0] ⚙️ FUNCTION: HelperBase.encode(struct Execution[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ModeLib.encode(CallType,ExecType,ModeSelector,ModePayload) (NodeID: 1)
      💬 Args: [CALLTYPE_BATCH, EXECTYPE_DEFAULT, MODE_DEFAULT, ModePayload.wrap(bytes22(0))]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Encode a batch of ERC7579 Execution Transactions
 @param executions Execution[] the array of executions
 @return erc7579Tx bytes the encoded ERC7579 transaction
