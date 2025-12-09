# Function: test_ManageYieldSources_RevertsOnZeroLength()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSources_RevertsOnZeroLength()`
- **Visibility**: public
- **Source Range**: 113036:577:660

## Implementation

```solidity
/// @notice Tests manageYieldSources reverts when sources array is empty
///  @dev Covers SuperVaultStrategy.sol:477
function test_ManageYieldSources_RevertsOnZeroLength() public {
    address[] memory sources = new address[](0);
    address[] memory oracles = new address[](0);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](0);
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.ZERO_LENGTH.selector);
    strategy.manageYieldSources(sources, oracles, actionTypes);
}
```

## External Calls

- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])**

## State Variable Reads

- **manager** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSources_RevertsOnZeroLength() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests manageYieldSources reverts when sources array is empty
 @dev Covers SuperVaultStrategy.sol:477
