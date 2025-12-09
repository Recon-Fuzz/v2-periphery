# Function: test_ManageYieldSource_RevertsOnNonExistentSource_Update()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSource_RevertsOnNonExistentSource_Update()`
- **Visibility**: public
- **Source Range**: 118835:473:660

## Implementation

```solidity
/// @notice Tests manageYieldSource reverts when updating non-existent yield source
///  @dev Covers SuperVaultStrategy.sol:867 - YIELD_SOURCE_NOT_FOUND check in _updateYieldSourceOracle
function test_ManageYieldSource_RevertsOnNonExistentSource_Update() public {
    address nonExistentSource = address(0x9999);
    address newOracle = address(0xABCD);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.YIELD_SOURCE_NOT_FOUND.selector);
    strategy.manageYieldSource(nonExistentSource, newOracle, ISuperVaultStrategy.YieldSourceAction.UpdateOracle);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSource_RevertsOnNonExistentSource_Update() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests manageYieldSource reverts when updating non-existent yield source
 @dev Covers SuperVaultStrategy.sol:867 - YIELD_SOURCE_NOT_FOUND check in _updateYieldSourceOracle
