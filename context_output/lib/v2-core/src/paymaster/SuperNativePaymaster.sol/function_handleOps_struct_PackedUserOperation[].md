# Function: handleOps(struct PackedUserOperation[])

**Contract**: [lib/v2-core/src/paymaster/SuperNativePaymaster.sol/contract_SuperNativePaymaster.md]

## Metadata

- **Contract**: SuperNativePaymaster
- **Signature**: `handleOps(struct PackedUserOperation[])`
- **Visibility**: public
- **Source Range**: 2479:736:436

## Implementation

```solidity
/// @inheritdoc ISuperNativePaymaster
function handleOps(PackedUserOperation[] calldata ops) public payable {
    uint256 balance = address(this).balance;
    if (balance > 0) {
        (bool success, ) = payable(address(entryPoint)).call{value: balance}("");
        if (!success) revert INSUFFICIENT_BALANCE();
    }
    entryPoint.handleOps(ops, payable(msg.sender));
    uint256 withdrawnAmount = entryPoint.getDepositInfo(address(this)).deposit;
    entryPoint.withdrawTo(payable(msg.sender), withdrawnAmount);
    emit UserOperationsHandled(msg.sender, ops.length, balance, withdrawnAmount);
}
```

## External Calls

- **unknown::unknown**
- **IEntryPoint::handleOps(struct PackedUserOperation[],address payable)**
- **IEntryPoint::getDepositInfo(address)**
- **IEntryPoint::withdrawTo(address payable,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperNativePaymaster.handleOps(struct PackedUserOperation[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc ISuperNativePaymaster

### Interface Documentation

@notice Handle a batch of user operations
 @dev Forwards the operations to the EntryPoint contract with funding
      Sends the paymaster's balance to the EntryPoint to cover operation costs
      Called by a bundler or gateway contract to process operations
 @param ops Array of packed user operations to execute
