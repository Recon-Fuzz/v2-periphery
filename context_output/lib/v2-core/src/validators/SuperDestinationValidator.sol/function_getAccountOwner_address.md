# Function: getAccountOwner(address)

**Contract**: [lib/v2-core/src/validators/SuperDestinationValidator.sol/contract_SuperDestinationValidator.md]

## Metadata

- **Contract**: SuperDestinationValidator
- **Signature**: `getAccountOwner(address)`
- **Visibility**: external
- **Source Range**: 2810:121:439
- **Inherited From**: SuperValidatorBase

## Implementation

```solidity
function getAccountOwner(address account) external view returns (address) {
    return _accountOwners[account];
}
```

## State Variable Reads

- **_accountOwners** (`mapping(address => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperValidatorBase.getAccountOwner(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
