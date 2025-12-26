# Function: unlockStake()

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `unlockStake()`
- **Visibility**: external
- **Source Range**: 3170:408:95
- **Inherited From**: StakeManager

## Implementation

```solidity
///  Attempt to unlock the stake.
///  The value can be withdrawn (using withdrawStake) after the unstake delay.
function unlockStake() external {
    DepositInfo storage info = deposits[msg.sender];
    require(info.unstakeDelaySec != 0, "not staked");
    require(info.staked, "already unstaking");
    uint48 withdrawTime = uint48(block.timestamp) + info.unstakeDelaySec;
    info.withdrawTime = withdrawTime;
    info.staked = false;
    emit StakeUnlocked(msg.sender, withdrawTime);
}
```

## State Variable Reads

- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakeManager.unlockStake() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 Attempt to unlock the stake.
 The value can be withdrawn (using withdrawStake) after the unstake delay.

### Interface Documentation

 Attempt to unlock the stake.
 The value can be withdrawn (using withdrawStake) after the unstake delay.
