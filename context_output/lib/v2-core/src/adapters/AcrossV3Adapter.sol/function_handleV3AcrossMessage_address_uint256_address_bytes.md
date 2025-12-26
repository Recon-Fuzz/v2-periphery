# Function: handleV3AcrossMessage(address,uint256,address,bytes)

**Contract**: [lib/v2-core/src/adapters/AcrossV3Adapter.sol/contract_AcrossV3Adapter.md]

## Metadata

- **Contract**: AcrossV3Adapter
- **Signature**: `handleV3AcrossMessage(address,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 1942:1629:358

## Implementation

```solidity
/// @inheritdoc IAcrossV3Receiver
function handleV3AcrossMessage(address tokenSent, uint256 amount, address, bytes memory message) override external {
    if (msg.sender != ACROSS_SPOKE_POOL) {
        revert INVALID_SENDER();
    }
    (bytes memory initData, bytes memory executorCalldata, address account, address[] memory dstTokens, uint256[] memory intentAmounts, bytes memory sigData) = abi.decode(message, (bytes, bytes, address, address[], uint256[], bytes));
    IERC20(tokenSent).safeTransfer(account, amount);
    SUPER_DESTINATION_EXECUTOR.processBridgedExecution(tokenSent, account, dstTokens, intentAmounts, initData, executorCalldata, sigData);
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **ISuperDestinationExecutor::processBridgedExecution(address,address,address[],uint256[],bytes,bytes,bytes)**

## State Variable Reads

- **ACROSS_SPOKE_POOL** (`address`)
- **SUPER_DESTINATION_EXECUTOR** (`contract ISuperDestinationExecutor`) [lib/v2-core/src/interfaces/ISuperDestinationExecutor.sol/interface_ISuperDestinationExecutor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AcrossV3Adapter.handleV3AcrossMessage(address,uint256,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IAcrossV3Receiver

### Interface Documentation

@notice Handle a message from the Across V3 bridge
 @param tokenSent The token sent
 @param amount The amount sent
 @param relayer The relayer
 @param message The message
