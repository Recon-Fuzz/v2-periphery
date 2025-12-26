# Function: balanceOf(address)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 1158:115:95
- **Inherited From**: StakeManager

## Implementation

```solidity
/// @inheritdoc IStakeManager
function balanceOf(address account) public view returns (uint256) {
    return deposits[account].deposit;
}
```

## State Variable Reads

- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakeManager.balanceOf(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IStakeManager

### Interface Documentation

 Get account balance.
 @param account - The account to query.
 @return        - The deposit (for gas payment) of the account.
