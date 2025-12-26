# Function: depositTo(address)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `depositTo(address)`
- **Visibility**: public
- **Source Range**: 1935:179:95
- **Inherited From**: StakeManager

## Implementation

```solidity
///  Add to the deposit of the given account.
///  @param account - The account to add to.
function depositTo(address account) virtual public payable {
    uint256 newDeposit = _incrementDeposit(account, msg.value);
    emit Deposited(account, newDeposit);
}
```

## Call Tree

```
No call tree available
```

## Documentation

### Function Documentation

 Add to the deposit of the given account.
 @param account - The account to add to.

### Interface Documentation

 Add to the deposit of the given account.
 @param account - The account to add to.
