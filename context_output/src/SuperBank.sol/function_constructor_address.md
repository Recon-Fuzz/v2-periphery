# Function: constructor(address)

**Contract**: [src/SuperBank.sol/contract_SuperBank.md]

## Metadata

- **Contract**: SuperBank
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 890:168:508

## Implementation

```solidity
constructor(address superGovernor_) {
    if (superGovernor_ == address(0)) revert INVALID_ADDRESS();
    SUPER_GOVERNOR = ISuperGovernor(superGovernor_);
}
```

## State Variable Writes

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperBank.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperBank
```
