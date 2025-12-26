# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/vaults/7540/SetOperator7540Hook.sol/contract_SetOperator7540Hook.md]

## Metadata

- **Contract**: SetOperator7540Hook
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
- **Source**: 2052:808:414
- **Link**: `lib/v2-core/src/hooks/vaults/7540/SetOperator7540Hook.sol:SetOperator7540Hook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
///  @dev Creates a single execution calling vault.setOperator(operator, approved)
function _buildHookExecutions(address, address, bytes calldata data) override internal pure returns (Execution[] memory executions) {
    address vault = BytesLib.toAddress(data, VAULT_POSITION);
    address operator = BytesLib.toAddress(data, OPERATOR_POSITION);
    bool approved = _decodeBool(data, APPROVED_POSITION);
    if (vault == address(0)) revert ADDRESS_NOT_VALID();
    if (operator == address(0)) revert ADDRESS_NOT_VALID();
    executions = new Execution[](1);
    executions[0] = Execution({target: vault, value: 0, callData: abi.encodeCall(IERC7540.setOperator, (operator, approved))});
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

## External Calls

- **ISuperHookResult::getOutAmount(address)**
- **IAcrossSpokePoolV3::wrappedNativeToken()**
- **ISuperSignatureStorage::retrieveSignatureData(address)**

## State Variable Reads

- **VAULT_POSITION** (`uint256`)
- **OPERATOR_POSITION** (`uint256`)
- **APPROVED_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SetOperator7540Hook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, VAULT_POSITION]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │   💬 Args: [data, OPERATOR_POSITION]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 4)
        💬 Args: [data, APPROVED_POSITION]
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
