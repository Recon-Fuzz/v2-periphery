# Function: onEtherReceived(bytes32,address,bytes)

**Contract**: [lib/v2-core/src/adapters/DebridgeAdapter.sol/contract_DebridgeAdapter.md]

## Metadata

- **Contract**: DebridgeAdapter
- **Signature**: `onEtherReceived(bytes32,address,bytes)`
- **Visibility**: external
- **Source Range**: 2443:1193:359

## Implementation

```solidity
/// @inheritdoc IExternalCallExecutor
function onEtherReceived(bytes32, address, bytes memory _payload) external payable onlyExternalCallAdapter() returns (bool callSucceeded, bytes memory callResult) {
    (bytes memory initData, bytes memory executorCalldata, address account, address[] memory dstTokens, uint256[] memory intentAmounts, bytes memory sigData) = _decodeMessage(_payload);
    (bool success, ) = account.call{value: address(this).balance}("");
    if (!success) revert ON_ETHER_RECEIVED_FAILED();
    _handleMessageReceived(address(0), initData, executorCalldata, account, dstTokens, intentAmounts, sigData);
    return (true, "");
}
```

## Related Implementations

### _decodeMessage(bytes)

- **Kind**: internal
- **Source**: 5675:508:359
- **Link**: `lib/v2-core/src/adapters/DebridgeAdapter.sol:DebridgeAdapter:_decodeMessage(bytes)`

```solidity
function _decodeMessage(bytes memory message) private pure returns (bytes memory initData, bytes memory executorCalldata, address account, address[] memory dstTokens, uint256[] memory intentAmounts, bytes memory sigData) {
    (initData, executorCalldata, account, dstTokens, intentAmounts, sigData) = abi.decode(message, (bytes, bytes, address, address[], uint256[], bytes));
}
```

### _handleMessageReceived(address,bytes,bytes,address,address[],uint256[],bytes)

- **Kind**: internal
- **Source**: 5042:627:359
- **Link**: `lib/v2-core/src/adapters/DebridgeAdapter.sol:DebridgeAdapter:_handleMessageReceived(address,bytes,bytes,address,address[],uint256[],bytes)`

```solidity
function _handleMessageReceived(address tokenSent, bytes memory initData, bytes memory executorCalldata, address account, address[] memory dstTokens, uint256[] memory intentAmounts, bytes memory sigData) private {
    SUPER_DESTINATION_EXECUTOR.processBridgedExecution(tokenSent, account, dstTokens, intentAmounts, initData, executorCalldata, sigData);
}
```

### onlyExternalCallAdapter()

- **Kind**: modifier
- **Source**: 2035:172:359
- **Link**: `lib/v2-core/src/adapters/DebridgeAdapter.sol:DebridgeAdapter:onlyExternalCallAdapter()`

```solidity
modifier onlyExternalCallAdapter() {
    if (msg.sender != IDlnDestination(DLN_DESTINATION).externalCallAdapter()) revert ONLY_EXTERNAL_CALL_ADAPTER();
    _;
}
```

## External Calls

- **unknown::unknown**

## State Variable Reads

- **SUPER_DESTINATION_EXECUTOR** (`contract ISuperDestinationExecutor`) [lib/v2-core/src/interfaces/ISuperDestinationExecutor.sol/interface_ISuperDestinationExecutor.md]
- **DLN_DESTINATION** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DebridgeAdapter.onEtherReceived(bytes32,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: DebridgeAdapter._decodeMessage(bytes) (NodeID: 1)
  │   💬 Args: [_payload]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: DebridgeAdapter._handleMessageReceived(address,bytes,bytes,address,address[],uint256[],bytes) (NodeID: 2)
  │   💬 Args: [address(0), initData, executorCalldata, account, dstTokens, intentAmounts, sigData]
  │   👁️  Def: private
  └─ [1] 🔒 MODIFIER: DebridgeAdapter.onlyExternalCallAdapter() (NodeID: 3)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IExternalCallExecutor

### Interface Documentation

 @notice Handles the receipt of Ether to the contract, then validates and executes a function call.
 @dev Only callable by the adapter. This function decodes the payload to extract execution data.
      If the function specified in the callData is prohibited, or the recipient contract is zero,
      all Ether is transferred to the fallback address.
      Otherwise, it attempts to execute the function call. Any remaining Ether is then transferred to the fallback
 address.
 @param _orderId The ID of the order that triggered this function.
 @param _fallbackAddress The address to receive any unspent Ether.
 @param _payload The encoded data containing the execution data.
 @return callSucceeded A boolean indicating whether the call was successful.
 @return callResult The data returned from the call.
