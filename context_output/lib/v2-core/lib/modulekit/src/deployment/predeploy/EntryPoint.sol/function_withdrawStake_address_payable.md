# Function: withdrawStake(address payable)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `withdrawStake(address payable)`
- **Visibility**: external
- **Source Range**: 3786:684:95
- **Inherited From**: StakeManager

## Implementation

```solidity
///  Withdraw from the (unlocked) stake.
///  Must first call unlockStake and wait for the unstakeDelay to pass.
///  @param withdrawAddress - The address to send withdrawn value.
function withdrawStake(address payable withdrawAddress) external {
    DepositInfo storage info = deposits[msg.sender];
    uint256 stake = info.stake;
    require(stake > 0, "No stake to withdraw");
    require(info.withdrawTime > 0, "must call unlockStake() first");
    require(info.withdrawTime <= block.timestamp, "Stake withdrawal is not due");
    info.unstakeDelaySec = 0;
    info.withdrawTime = 0;
    info.stake = 0;
    emit StakeWithdrawn(msg.sender, withdrawAddress, stake);
    (bool success, ) = withdrawAddress.call{value: stake}("");
    require(success, "failed to withdraw stake");
}
```

## External Calls

- **unknown::unknown**

## State Variable Reads

- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakeManager.withdrawStake(address payable) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 Withdraw from the (unlocked) stake.
 Must first call unlockStake and wait for the unstakeDelay to pass.
 @param withdrawAddress - The address to send withdrawn value.

### Interface Documentation

 Withdraw from the (unlocked) stake.
 Must first call unlockStake and wait for the unstakeDelay to pass.
 @param withdrawAddress - The address to send withdrawn value.
