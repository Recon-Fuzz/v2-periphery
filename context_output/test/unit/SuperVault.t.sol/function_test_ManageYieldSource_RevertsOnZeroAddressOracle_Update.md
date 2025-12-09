# Function: test_ManageYieldSource_RevertsOnZeroAddressOracle_Update()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSource_RevertsOnZeroAddressOracle_Update()`
- **Visibility**: public
- **Source Range**: 118008:627:660

## Implementation

```solidity
/// @notice Tests manageYieldSource reverts when updating with oracle = address(0)
///  @dev Covers SuperVaultStrategy.sol:865 - ZERO_ADDRESS check in _updateYieldSourceOracle
function test_ManageYieldSource_RevertsOnZeroAddressOracle_Update() public {
    address yieldSourceAddr = address(0x1234);
    address oracleAddr = address(0x5678);
    vm.prank(manager);
    strategy.manageYieldSource(yieldSourceAddr, oracleAddr, ISuperVaultStrategy.YieldSourceAction.Add);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.ZERO_ADDRESS.selector);
    strategy.manageYieldSource(yieldSourceAddr, address(0), ISuperVaultStrategy.YieldSourceAction.UpdateOracle);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSource_RevertsOnZeroAddressOracle_Update() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests manageYieldSource reverts when updating with oracle = address(0)
 @dev Covers SuperVaultStrategy.sol:865 - ZERO_ADDRESS check in _updateYieldSourceOracle
