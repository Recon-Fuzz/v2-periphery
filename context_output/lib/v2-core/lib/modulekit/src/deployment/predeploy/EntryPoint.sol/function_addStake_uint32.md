# Function: addStake(uint32)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `addStake(uint32)`
- **Visibility**: public
- **Source Range**: 2325:706:95
- **Inherited From**: StakeManager

## Implementation

```solidity
///  Add to the account's stake - amount and delay
///  any pending unstake is first cancelled.
///  @param unstakeDelaySec The new lock duration before the deposit can be withdrawn.
function addStake(uint32 unstakeDelaySec) public payable {
    DepositInfo storage info = deposits[msg.sender];
    require(unstakeDelaySec > 0, "must specify unstake delay");
    require(unstakeDelaySec >= info.unstakeDelaySec, "cannot decrease unstake time");
    uint256 stake = info.stake + msg.value;
    require(stake > 0, "no stake specified");
    require(stake <= type(uint112).max, "stake overflow");
    deposits[msg.sender] = DepositInfo(info.deposit, true, uint112(stake), unstakeDelaySec, 0);
    emit StakeLocked(msg.sender, stake, unstakeDelaySec);
}
```

## State Variable Reads

- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## State Variable Writes

- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakeManager.addStake(uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 Add to the account's stake - amount and delay
 any pending unstake is first cancelled.
 @param unstakeDelaySec The new lock duration before the deposit can be withdrawn.

### Interface Documentation

 Add to the account's stake - amount and delay
 any pending unstake is first cancelled.
 @param _unstakeDelaySec - The new lock duration before the deposit can be withdrawn.
