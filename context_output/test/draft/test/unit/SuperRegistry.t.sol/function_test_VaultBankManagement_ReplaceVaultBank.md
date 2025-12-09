# Function: test_VaultBankManagement_ReplaceVaultBank()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_VaultBankManagement_ReplaceVaultBank()`
- **Visibility**: public
- **Source Range**: 2874:811:568

## Implementation

```solidity
/// @notice Tests replacing an existing vault bank for the same chain
function test_VaultBankManagement_ReplaceVaultBank() public {
    uint64 chainId = 1;
    address oldVaultBank = _deployAccount(0x20, "OldVaultBank");
    address newVaultBank = _deployAccount(0x21, "NewVaultBank");
    vm.prank(registryAdmin);
    superRegistry.addVaultBank(chainId, oldVaultBank);
    assertEq(superRegistry.getVaultBank(chainId), oldVaultBank, "Initial vault bank not set");
    vm.prank(registryAdmin);
    vm.expectEmit(true, true, false, false);
    emit ISuperRegistry.VaultBankAddressAdded(chainId, newVaultBank);
    superRegistry.addVaultBank(chainId, newVaultBank);
    assertEq(superRegistry.getVaultBank(chainId), newVaultBank, "Vault bank not replaced");
}
```

## Related Implementations

### _deployAccount(uint256,string)

- **Kind**: internal
- **Source**: 3858:217:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_deployAccount(uint256,string)`

```solidity
function _deployAccount(uint256 key_, string memory name_) internal returns (address) {
    address _user = vm.addr(key_);
    vm.deal(_user, LARGE);
    vm.label(_user, name_);
    return _user;
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **Vm::prank(address)**
- **SuperRegistry::addVaultBank(uint64,address)**
- **SuperRegistry::getVaultBank(uint64)**
- **Vm::expectEmit(bool,bool,bool,bool)**

## State Variable Reads

- **registryAdmin** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_VaultBankManagement_ReplaceVaultBank() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x20, "OldVaultBank"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x21, "NewVaultBank"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [superRegistry.getVaultBank(chainId), oldVaultBank, "Initial vault bank not set"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
      💬 Args: [superRegistry.getVaultBank(chainId), newVaultBank, "Vault bank not replaced"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests replacing an existing vault bank for the same chain
