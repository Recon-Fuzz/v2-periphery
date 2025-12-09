# Function: test_VaultBankManagement_Revert_ZeroChainId()

**Contract**: [test/draft/test/unit/SuperRegistry.t.sol/contract_SuperRegistryTest.md]

## Metadata

- **Contract**: SuperRegistryTest
- **Signature**: `test_VaultBankManagement_Revert_ZeroChainId()`
- **Visibility**: public
- **Source Range**: 4954:283:568

## Implementation

```solidity
/// @notice Tests reverting when adding vault bank with zero chain ID
function test_VaultBankManagement_Revert_ZeroChainId() public {
    address vaultBank = _deployAccount(0x20, "VaultBank");
    vm.prank(registryAdmin);
    vm.expectRevert(ISuperRegistry.INVALID_CHAIN_ID.selector);
    superRegistry.addVaultBank(0, vaultBank);
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

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperRegistry::addVaultBank(uint64,address)**

## State Variable Reads

- **registryAdmin** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperRegistryTest.test_VaultBankManagement_Revert_ZeroChainId() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0x20, "VaultBank"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests reverting when adding vault bank with zero chain ID
