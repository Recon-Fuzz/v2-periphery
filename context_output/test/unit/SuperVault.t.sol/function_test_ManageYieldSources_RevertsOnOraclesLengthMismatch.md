# Function: test_ManageYieldSources_RevertsOnOraclesLengthMismatch()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_ManageYieldSources_RevertsOnOraclesLengthMismatch()`
- **Visibility**: public
- **Source Range**: 113763:900:660

## Implementation

```solidity
/// @notice Tests manageYieldSources reverts when oracles array length doesn't match sources
///  @dev Covers SuperVaultStrategy.sol:478
function test_ManageYieldSources_RevertsOnOraclesLengthMismatch() public {
    address[] memory sources = new address[](2);
    sources[0] = address(0x1);
    sources[1] = address(0x2);
    address[] memory oracles = new address[](1);
    oracles[0] = address(0x3);
    ISuperVaultStrategy.YieldSourceAction[] memory actionTypes = new ISuperVaultStrategy.YieldSourceAction[](2);
    actionTypes[0] = ISuperVaultStrategy.YieldSourceAction.UpdateOracle;
    actionTypes[1] = ISuperVaultStrategy.YieldSourceAction.UpdateOracle;
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_ARRAY_LENGTH.selector);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_ManageYieldSources_RevertsOnOraclesLengthMismatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests manageYieldSources reverts when oracles array length doesn't match sources
 @dev Covers SuperVaultStrategy.sol:478
