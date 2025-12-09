# Function: test_UpkeepDeposited_MultipleDepositors()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_UpkeepDeposited_MultipleDepositors()`
- **Visibility**: public
- **Source Range**: 143556:1195:661

## Implementation

```solidity
/// @notice Test: Multiple depositors emit correct depositor addresses
function test_UpkeepDeposited_MultipleDepositors() public {
    address depositor1 = _deployAccount(0x91, "Depositor1");
    address depositor2 = _deployAccount(0x90, "Depositor2");
    uint256 amount1 = 500e18;
    uint256 amount2 = 750e18;
    MockUp(upToken).mint(depositor1, amount1);
    vm.startPrank(depositor1);
    IERC20(upToken).approve(address(superVaultAggregator), amount1);
    vm.expectEmit(true, true, false, true);
    emit ISuperVaultAggregator.UpkeepDeposited(strategy, depositor1, amount1);
    superVaultAggregator.depositUpkeep(strategy, amount1);
    vm.stopPrank();
    MockUp(upToken).mint(depositor2, amount2);
    vm.startPrank(depositor2);
    IERC20(upToken).approve(address(superVaultAggregator), amount2);
    vm.expectEmit(true, true, false, true);
    emit ISuperVaultAggregator.UpkeepDeposited(strategy, depositor2, amount2);
    superVaultAggregator.depositUpkeep(strategy, amount2);
    vm.stopPrank();
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), amount1 + amount2);
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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **MockUp::mint(address,uint256)**
- **Vm::startPrank(address)**
- **IERC20::approve(address,uint256)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::depositUpkeep(address,uint256)**
- **Vm::stopPrank()**
- **SuperVaultAggregator::getUpkeepBalance(address)**

## State Variable Reads

- **upToken** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_UpkeepDeposited_MultipleDepositors() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x91, "Depositor1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x90, "Depositor2"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
      💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), amount1 + amount2]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test: Multiple depositors emit correct depositor addresses
