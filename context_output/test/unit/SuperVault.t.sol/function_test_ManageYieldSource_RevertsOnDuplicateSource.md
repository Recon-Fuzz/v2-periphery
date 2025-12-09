# Function: test_ManageYieldSource_RevertsOnDuplicateSource()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSource_RevertsOnDuplicateSource()`
- **Visibility**: public
- **Source Range**: 117191:628:660

## Implementation

```solidity
/// @notice Tests manageYieldSource reverts when adding duplicate yield source
///  @dev Covers SuperVaultStrategy.sol:854 - YIELD_SOURCE_ALREADY_EXISTS check in _addYieldSource
function test_ManageYieldSource_RevertsOnDuplicateSource() public {
    address yieldSourceAddr = address(0x1234);
    address oracleAddr = address(0x5678);
    vm.prank(manager);
    strategy.manageYieldSource(yieldSourceAddr, oracleAddr, ISuperVaultStrategy.YieldSourceAction.Add);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.YIELD_SOURCE_ALREADY_EXISTS.selector);
    strategy.manageYieldSource(yieldSourceAddr, oracleAddr, ISuperVaultStrategy.YieldSourceAction.Add);
}
```

## External Calls

- **Vm::prank(address)**
- **SuperVaultStrategy::manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSource_RevertsOnDuplicateSource() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests manageYieldSource reverts when adding duplicate yield source
 @dev Covers SuperVaultStrategy.sol:854 - YIELD_SOURCE_ALREADY_EXISTS check in _addYieldSource
