# Function: constructor(address,address)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `constructor(address,address)`
- **Visibility**: public
- **Source Range**: 1258:85:570

## Implementation

```solidity
constructor(address governor_, address registry_) VaultBank(governor_,registry_) {}
```

## Related Implementations

### (address,address)

- **Kind**: internal
- **Source**: 1625:249:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:constructor(address,address)`

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
┌─ [0] 🏗️ CONSTRUCTOR: TestVaultBank.constructor(address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: TestVaultBank
  └─ [1] 🏗️ CONSTRUCTOR: VaultBank.constructor(address,address) (NodeID: 1)
      💬 Args: [governor_, registry_]
      🏗️  Contract: VaultBank
```
