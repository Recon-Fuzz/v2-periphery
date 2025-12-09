# Function: test_GovernanceTakeover_CanWithdrawForfeitedUpkeep()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_GovernanceTakeover_CanWithdrawForfeitedUpkeep()`
- **Visibility**: public
- **Source Range**: 180970:1627:661

## Implementation

```solidity
/// @notice Tests that governance can withdraw forfeited upkeep after takeover
function test_GovernanceTakeover_CanWithdrawForfeitedUpkeep() public {
    uint256 upkeepAmount = 1000e18;
    address governanceManager = address(superGovernor);
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    vm.stopPrank();
    vm.prank(address(superGovernor));
    superVaultAggregator.changePrimaryManager(strategy, governanceManager, treasury);
    assertEq(superVaultAggregator.getMainManager(strategy), governanceManager, "Governance should be manager");
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount, "Forfeited upkeep should remain");
    vm.prank(governanceManager);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.warp((block.timestamp + 24 hours) + 1);
    uint256 govBalBefore = IERC20(upToken).balanceOf(governanceManager);
    superVaultAggregator.executeWithdrawUpkeep(strategy);
    assertEq(IERC20(upToken).balanceOf(governanceManager), govBalBefore + upkeepAmount, "Governance should receive forfeited upkeep");
}
```

## Related Implementations

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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **MockUp::mint(address,uint256)**
- **Vm::startPrank(address)**
- **IERC20::approve(address,uint256)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperVaultAggregator::changePrimaryManager(address,address,address)**
- **SuperVaultAggregator::getMainManager(address)**
- **SuperVaultAggregator::getUpkeepBalance(address)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **Vm::warp(uint256)**
- **IERC20::balanceOf(address)**
- **SuperVaultAggregator::executeWithdrawUpkeep(address)**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_GovernanceTakeover_CanWithdrawForfeitedUpkeep() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1)
  │   💬 Args: [superVaultAggregator.getMainManager(strategy), governanceManager, "Governance should be manager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), upkeepAmount, "Forfeited upkeep should remain"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [IERC20(upToken).balanceOf(governanceManager), govBalBefore + upkeepAmount, "Governance should receive forfeited upkeep"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that governance can withdraw forfeited upkeep after takeover
