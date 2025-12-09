# Function: test_ManageYieldSource_RevertsOnNonExistentSource_Remove()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSource_RevertsOnNonExistentSource_Remove()`
- **Visibility**: public
- **Source Range**: 119502:423:660

## Implementation

```solidity
/// @notice Tests manageYieldSource reverts when removing non-existent yield source
///  @dev Covers SuperVaultStrategy.sol:876 - YIELD_SOURCE_NOT_FOUND check in _removeYieldSource
function test_ManageYieldSource_RevertsOnNonExistentSource_Remove() public {
    address nonExistentSource = address(0x9999);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.YIELD_SOURCE_NOT_FOUND.selector);
    strategy.manageYieldSource(nonExistentSource, address(0), ISuperVaultStrategy.YieldSourceAction.Remove);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSource_RevertsOnNonExistentSource_Remove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests manageYieldSource reverts when removing non-existent yield source
 @dev Covers SuperVaultStrategy.sol:876 - YIELD_SOURCE_NOT_FOUND check in _removeYieldSource
