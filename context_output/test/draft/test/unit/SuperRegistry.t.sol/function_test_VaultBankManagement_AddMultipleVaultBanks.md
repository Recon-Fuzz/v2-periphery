# Function: test_VaultBankManagement_AddMultipleVaultBanks()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_VaultBankManagement_AddMultipleVaultBanks()`
- **Visibility**: public
- **Source Range**: 2154:640:568

## Implementation

```solidity
/// @notice Tests adding multiple vault banks for different chains
function test_VaultBankManagement_AddMultipleVaultBanks() public {
    uint64 chainId1 = 1;
    uint64 chainId2 = 137;
    address vaultBank1 = _deployAccount(0x20, "VaultBank1");
    address vaultBank2 = _deployAccount(0x21, "VaultBank2");
    vm.startPrank(registryAdmin);
    superRegistry.addVaultBank(chainId1, vaultBank1);
    superRegistry.addVaultBank(chainId2, vaultBank2);
    vm.stopPrank();
    assertEq(superRegistry.getVaultBank(chainId1), vaultBank1, "Chain 1 vault bank mismatch");
    assertEq(superRegistry.getVaultBank(chainId2), vaultBank2, "Chain 2 vault bank mismatch");
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

- **Vm::startPrank(address)**
- **SuperRegistry::addVaultBank(uint64,address)**
- **Vm::stopPrank()**
- **SuperRegistry::getVaultBank(uint64)**

## State Variable Reads

- **registryAdmin** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_VaultBankManagement_AddMultipleVaultBanks() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x20, "VaultBank1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x21, "VaultBank2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [superRegistry.getVaultBank(chainId1), vaultBank1, "Chain 1 vault bank mismatch"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
      💬 Args: [superRegistry.getVaultBank(chainId2), vaultBank2, "Chain 2 vault bank mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests adding multiple vault banks for different chains
