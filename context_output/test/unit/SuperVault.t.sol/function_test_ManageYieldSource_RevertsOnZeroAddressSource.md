# Function: test_ManageYieldSource_RevertsOnZeroAddressSource()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSource_RevertsOnZeroAddressSource()`
- **Visibility**: public
- **Source Range**: 116026:391:660

## Implementation

```solidity
/// @notice Tests manageYieldSource reverts when adding with source = address(0)
///  @dev Covers SuperVaultStrategy.sol:853 - ZERO_ADDRESS check in _addYieldSource
function test_ManageYieldSource_RevertsOnZeroAddressSource() public {
    address oracleAddr = address(0x5678);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.ZERO_ADDRESS.selector);
    strategy.manageYieldSource(address(0), oracleAddr, ISuperVaultStrategy.YieldSourceAction.Add);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSource_RevertsOnZeroAddressSource() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests manageYieldSource reverts when adding with source = address(0)
 @dev Covers SuperVaultStrategy.sol:853 - ZERO_ADDRESS check in _addYieldSource
