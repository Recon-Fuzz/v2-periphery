# Function: test_ProposeWithdrawUpkeep_Success()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ProposeWithdrawUpkeep_Success()`
- **Visibility**: public
- **Source Range**: 172259:964:661

## Implementation

```solidity
/// @notice Tests successful upkeep withdrawal proposal
function test_ProposeWithdrawUpkeep_Success() public {
    uint256 upkeepAmount = 1000e18;
    MockUp(upToken).mint(manager, upkeepAmount);
    vm.startPrank(manager);
    IERC20(upToken).approve(address(superVaultAggregator), upkeepAmount);
    superVaultAggregator.depositUpkeep(strategy, upkeepAmount);
    vm.expectEmit(true, true, false, true);
    emit ISuperVaultAggregator.UpkeepWithdrawalProposed(strategy, manager, upkeepAmount, block.timestamp + 24 hours);
    superVaultAggregator.proposeWithdrawUpkeep(strategy);
    vm.stopPrank();
    (uint256 amount, uint256 effectiveTime) = superVaultAggregator.pendingUpkeepWithdrawals(strategy);
    assertEq(amount, upkeepAmount, "Amount should match balance");
    assertEq(effectiveTime, block.timestamp + 24 hours, "Effective time should be 24h later");
}
```

## Related Implementations

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
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultAggregator::proposeWithdrawUpkeep(address)**
- **Vm::stopPrank()**
- **SuperVaultAggregator::pendingUpkeepWithdrawals(address)**

## State Variable Reads

- **upToken** (`address`)
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ProposeWithdrawUpkeep_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [amount, upkeepAmount, "Amount should match balance"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [effectiveTime, block.timestamp + 24 hours, "Effective time should be 24h later"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests successful upkeep withdrawal proposal
