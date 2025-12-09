# Function: test_ManageYieldSource_RevertsOnZeroAddressOracle_Add()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSource_RevertsOnZeroAddressOracle_Add()`
- **Visibility**: public
- **Source Range**: 116595:405:660

## Implementation

```solidity
/// @notice Tests manageYieldSource reverts when adding with oracle = address(0)
///  @dev Covers SuperVaultStrategy.sol:853 - ZERO_ADDRESS check in _addYieldSource
function test_ManageYieldSource_RevertsOnZeroAddressOracle_Add() public {
    address yieldSourceAddr = address(0x1234);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.ZERO_ADDRESS.selector);
    strategy.manageYieldSource(yieldSourceAddr, address(0), ISuperVaultStrategy.YieldSourceAction.Add);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSource_RevertsOnZeroAddressOracle_Add() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests manageYieldSource reverts when adding with oracle = address(0)
 @dev Covers SuperVaultStrategy.sol:853 - ZERO_ADDRESS check in _addYieldSource
