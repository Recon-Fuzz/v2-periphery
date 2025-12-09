# Function: test_ResetHighWaterMark_Success()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `test_ResetHighWaterMark_Success()`
- **Visibility**: public
- **Source Range**: 43679:610:661

## Implementation

```solidity
/// @notice Tests that resetHighWaterMark succeeds when strategy is valid address
function test_ResetHighWaterMark_Success() public {
    vm.startPrank(address(superGovernor));
    vm.expectEmit(true, true, true, true);
    emit ISuperVaultAggregator.HighWaterMarkReset(strategy, SuperVaultStrategy(payable(strategy)).getStoredPPS());
    superVaultAggregator.resetHighWaterMark(strategy);
    vm.stopPrank();
    uint256 newHwmPps = SuperVaultStrategy(payable(strategy)).vaultHwmPps();
    uint256 currentPPS = SuperVaultStrategy(payable(strategy)).getStoredPPS();
    assertEq(newHwmPps, currentPPS, "High Water Mark should be reset to current PPS");
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

- **Vm::startPrank(address)**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperVaultStrategy::getStoredPPS()**
- **SuperVaultAggregator::resetHighWaterMark(address)**
- **Vm::stopPrank()**
- **SuperVaultStrategy::vaultHwmPps()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.test_ResetHighWaterMark_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [newHwmPps, currentPPS, "High Water Mark should be reset to current PPS"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that resetHighWaterMark succeeds when strategy is valid address
