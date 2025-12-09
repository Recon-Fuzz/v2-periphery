# Function: test_VaultBankManagement_AccessControl()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_VaultBankManagement_AccessControl()`
- **Visibility**: public
- **Source Range**: 3775:1099:568

## Implementation

```solidity
/// @notice Tests access control - only REGISTRY_ADMIN_ROLE can add vault banks
function test_VaultBankManagement_AccessControl() public {
    uint64 chainId = 1;
    address vaultBank = _deployAccount(0x20, "VaultBank");
    vm.prank(user);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, user, REGISTRY_ADMIN_ROLE));
    superRegistry.addVaultBank(chainId, vaultBank);
    vm.prank(superRegistryAdmin);
    vm.expectRevert(abi.encodeWithSelector(IAccessControl.AccessControlUnauthorizedAccount.selector, superRegistryAdmin, REGISTRY_ADMIN_ROLE));
    superRegistry.addVaultBank(chainId, vaultBank);
    vm.prank(registryAdmin);
    superRegistry.addVaultBank(chainId, vaultBank);
    assertEq(superRegistry.getVaultBank(chainId), vaultBank, "Registry admin should be able to add vault bank");
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
- **Vm::expectRevert(bytes)**
- **SuperRegistry::addVaultBank(uint64,address)**
- **SuperRegistry::getVaultBank(uint64)**

## State Variable Reads

- **user** (`address`)
- **REGISTRY_ADMIN_ROLE** (`bytes32`)
- **superRegistryAdmin** (`address`)
- **registryAdmin** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_VaultBankManagement_AccessControl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x20, "VaultBank"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [superRegistry.getVaultBank(chainId), vaultBank, "Registry admin should be able to add vault bank"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests access control - only REGISTRY_ADMIN_ROLE can add vault banks
