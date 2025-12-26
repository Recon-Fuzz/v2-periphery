# Function: getDepositInfo(address)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `getDepositInfo(address)`
- **Visibility**: public
- **Source Range**: 595:142:95
- **Inherited From**: StakeManager

## Implementation

```solidity
/// @inheritdoc IStakeManager
function getDepositInfo(address account) public view returns (DepositInfo memory info) {
    return deposits[account];
}
```

## State Variable Reads

- **deposits** (`mapping(address => struct IStakeManager.DepositInfo)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StakeManager.getDepositInfo(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IStakeManager

### Interface Documentation

 Get deposit info.
 @param account - The account to query.
 @return info   - Full deposit information of given account.
