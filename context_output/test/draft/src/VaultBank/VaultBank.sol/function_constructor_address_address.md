# Function: constructor(address,address)

**Contract**: [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]

## Metadata

- **Contract**: VaultBank
- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1625:249:552

## Implementation

```solidity
constructor(address governor_, address registry_) {
    if ((governor_ == address(0)) || (registry_ == address(0))) revert INVALID_VALUE();
    SUPER_GOVERNOR = ISuperGovernor(governor_);
    SUPER_REGISTRY = ISuperRegistry(registry_);
}
```

## State Variable Writes

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **SUPER_REGISTRY** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: VaultBank.constructor(address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: VaultBank
```
