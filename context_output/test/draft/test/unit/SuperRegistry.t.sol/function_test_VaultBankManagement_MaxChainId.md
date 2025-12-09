# Function: test_VaultBankManagement_MaxChainId()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_VaultBankManagement_MaxChainId()`
- **Visibility**: public
- **Source Range**: 6015:500:568

## Implementation

```solidity
/// @notice Tests edge case with maximum chain ID
function test_VaultBankManagement_MaxChainId() public {
    uint64 maxChainId = type(uint64).max;
    address vaultBank = _deployAccount(0x20, "MaxChainVaultBank");
    vm.prank(registryAdmin);
    vm.expectEmit(true, true, false, false);
    emit ISuperRegistry.VaultBankAddressAdded(maxChainId, vaultBank);
    superRegistry.addVaultBank(maxChainId, vaultBank);
    assertEq(superRegistry.getVaultBank(maxChainId), vaultBank, "Max chain ID vault bank mismatch");
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
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperRegistry::addVaultBank(uint64,address)**
- **SuperRegistry::getVaultBank(uint64)**

## State Variable Reads

- **registryAdmin** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_VaultBankManagement_MaxChainId() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x20, "MaxChainVaultBank"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 2)
      💬 Args: [superRegistry.getVaultBank(maxChainId), vaultBank, "Max chain ID vault bank mismatch"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests edge case with maximum chain ID
