# Function: test_UpkeepDeposited_EmitsCorrectDepositor()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_UpkeepDeposited_EmitsCorrectDepositor()`
- **Visibility**: public
- **Source Range**: 141186:825:661

## Implementation

```solidity
/// @notice Test: UpkeepDeposited event is emitted with correct depositor
function test_UpkeepDeposited_EmitsCorrectDepositor() public {
    uint256 depositAmount = 1000e18;
    address depositor = _deployAccount(0x93, "Depositor");
    MockUp(upToken).mint(depositor, depositAmount);
    vm.startPrank(depositor);
    IERC20(upToken).approve(address(superVaultAggregator), depositAmount);
    vm.expectEmit(true, true, false, true);
    emit ISuperVaultAggregator.UpkeepDeposited(strategy, depositor, depositAmount);
    superVaultAggregator.depositUpkeep(strategy, depositAmount);
    vm.stopPrank();
    assertEq(superVaultAggregator.getUpkeepBalance(strategy), depositAmount);
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
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_UpkeepDeposited_EmitsCorrectDepositor() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x93, "Depositor"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [superVaultAggregator.getUpkeepBalance(strategy), depositAmount]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Test: UpkeepDeposited event is emitted with correct depositor
