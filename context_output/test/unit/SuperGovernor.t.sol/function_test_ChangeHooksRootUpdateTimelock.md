# Function: test_ChangeHooksRootUpdateTimelock()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ChangeHooksRootUpdateTimelock()`
- **Visibility**: public
- **Source Range**: 35177:274:659

## Implementation

```solidity
function test_ChangeHooksRootUpdateTimelock() public {
    vm.prank(sGovernor);
    superGovernor.changeHooksRootUpdateTimelock(100);
    uint256 timelock = aggregator.getHooksRootUpdateTimelock();
    assertEq(timelock, 100, "Timelock should be 100");
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

- **Vm::prank(address)**
- **SuperGovernor::changeHooksRootUpdateTimelock(uint256)**
- **SuperVaultAggregator::getHooksRootUpdateTimelock()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ChangeHooksRootUpdateTimelock() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [timelock, 100, "Timelock should be 100"]
      👁️  Def: internal
```
