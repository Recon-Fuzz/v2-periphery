# Function: test_ExecuteChangePrimaryManager()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ExecuteChangePrimaryManager()`
- **Visibility**: public
- **Source Range**: 80897:2967:661

## Implementation

```solidity
/// @notice Tests that executeChangePrimaryManager removes old primary manager and sets new primary manager and fee recipient
function test_ExecuteChangePrimaryManager() public {
    address[] memory secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    address currentManager = superVaultAggregator.getMainManager(strategy);
    address newPrimaryManager = _deployAccount(0x12, "NewManager");
    vm.startPrank(secondaryManagers[0]);
    superVaultAggregator.proposeChangePrimaryManager(strategy, newPrimaryManager, treasury);
    vm.warp(block.timestamp + 1 weeks);
    superVaultAggregator.executeChangePrimaryManager(strategy);
    vm.stopPrank();
    secondaryManagers = superVaultAggregator.getSecondaryManagers(strategy);
    assertEq(secondaryManagers.length, 0, "Should have 0 secondary managers");
    currentManager = superVaultAggregator.getMainManager(strategy);
    assertEq(currentManager, newPrimaryManager, "New manager should be set");
    address newSecondaryManager = _deployAccount(0x13, "NewSecondaryManager");
    vm.prank(currentManager);
    superVaultAggregator.addSecondaryManager(strategy, newSecondaryManager);
    address nextPrimaryManager = _deployAccount(0x14, "NextManager");
    vm.startPrank(newSecondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, nextPrimaryManager, treasury);
    vm.warp(block.timestamp + 1 weeks);
    vm.expectEmit(true, true, false, false);
    emit ISuperVaultAggregator.PrimaryManagerChanged(strategy, newPrimaryManager, nextPrimaryManager, treasury);
    superVaultAggregator.executeChangePrimaryManager(strategy);
    vm.stopPrank();
    vm.startPrank(nextPrimaryManager);
    newSecondaryManager = _deployAccount(0x15, "NewSecondaryManager");
    superVaultAggregator.addSecondaryManager(strategy, newSecondaryManager);
    superVaultAggregator.addSecondaryManager(strategy, _deployAccount(0x16, "NewSecondaryManager"));
    vm.stopPrank();
    address thirdPrimaryManager = _deployAccount(0x17, "ThirdPrimaryManager");
    vm.startPrank(newSecondaryManager);
    superVaultAggregator.proposeChangePrimaryManager(strategy, thirdPrimaryManager, treasury);
    vm.warp(block.timestamp + 1 weeks);
    vm.expectEmit(true, true, false, false);
    emit ISuperVaultAggregator.PrimaryManagerChanged(strategy, nextPrimaryManager, thirdPrimaryManager, treasury);
    superVaultAggregator.executeChangePrimaryManager(strategy);
    vm.stopPrank();
    address newFeeRecipient = ISuperVaultStrategy(strategy).getConfigInfo().recipient;
    assertEq(newFeeRecipient, treasury, "Fee recipient should be set to treasury");
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

## External Calls

- **SuperVaultAggregator::getSecondaryManagers(address)**
- **SuperVaultAggregator::getMainManager(address)**
- **Vm::startPrank(address)**
- **SuperVaultAggregator::proposeChangePrimaryManager(address,address,address)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeChangePrimaryManager(address)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **ISuperVaultStrategy::getConfigInfo()**

## State Variable Reads

- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **treasury** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ExecuteChangePrimaryManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x12, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [secondaryManagers.length, 0, "Should have 0 secondary managers"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │   💬 Args: [currentManager, newPrimaryManager, "New manager should be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │   💬 Args: [0x13, "NewSecondaryManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 5)
  │   💬 Args: [0x14, "NextManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 6)
  │   💬 Args: [0x15, "NewSecondaryManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 7)
  │   💬 Args: [0x16, "NewSecondaryManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 8)
  │   💬 Args: [0x17, "ThirdPrimaryManager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 9)
      💬 Args: [newFeeRecipient, treasury, "Fee recipient should be set to treasury"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that executeChangePrimaryManager removes old primary manager and sets new primary manager and fee recipient
