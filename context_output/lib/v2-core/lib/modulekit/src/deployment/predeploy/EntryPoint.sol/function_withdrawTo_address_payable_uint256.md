# Function: withdrawTo(address payable,uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `withdrawTo(address payable,uint256)`
- **Visibility**: external
- **Source Range**: 4651:496:95
- **Inherited From**: StakeManager

## Implementation

```solidity
///  Withdraw from the deposit.
///  @param withdrawAddress - The address to send withdrawn value.
///  @param withdrawAmount  - The amount to withdraw.
function withdrawTo(address payable withdrawAddress, uint256 withdrawAmount) external {
    DepositInfo storage info = deposits[msg.sender];
    require(withdrawAmount <= info.deposit, "Withdraw amount too large");
    info.deposit = info.deposit - withdrawAmount;
    emit Withdrawn(msg.sender, withdrawAddress, withdrawAmount);
    (bool success, ) = withdrawAddress.call{value: withdrawAmount}("");
    require(success, "failed to withdraw");
}
```

## External Calls

- **unknown::unknown**

## State Variable Reads

- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakeManager.withdrawTo(address payable,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 Withdraw from the deposit.
 @param withdrawAddress - The address to send withdrawn value.
 @param withdrawAmount  - The amount to withdraw.

### Interface Documentation

 Withdraw from the deposit.
 @param withdrawAddress - The address to send withdrawn value.
 @param withdrawAmount  - The amount to withdraw.
