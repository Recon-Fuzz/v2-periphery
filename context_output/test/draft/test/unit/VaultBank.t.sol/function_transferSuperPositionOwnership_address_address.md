# Function: transferSuperPositionOwnership(address,address)

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `transferSuperPositionOwnership(address,address)`
- **Visibility**: external
- **Source Range**: 6142:178:552
- **Inherited From**: VaultBank

## Implementation

```solidity
function transferSuperPositionOwnership(address superPos, address newOwner) external onlyBankManager() {
    VaultBankSuperPosition(superPos).transferOwnership(newOwner);
}
```

## Related Implementations

### onlyBankManager()

- **Kind**: modifier
- **Source**: 2004:210:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:onlyBankManager()`

```solidity
modifier onlyBankManager() {
    if (!IAccessControl(address(SUPER_GOVERNOR)).hasRole(SUPER_GOVERNOR.BANK_MANAGER_ROLE(), msg.sender)) {
        revert INVALID_BANK_MANAGER();
    }
    _;
}
```

## External Calls

- **VaultBankSuperPosition::transferOwnership(address)**

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBank.transferSuperPositionOwnership(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: VaultBank.onlyBankManager() (NodeID: 1)
      💬 Args: [no args]
```
