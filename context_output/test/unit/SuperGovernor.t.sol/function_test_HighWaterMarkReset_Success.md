# Function: test_HighWaterMarkReset_Success()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HighWaterMarkReset_Success()`
- **Visibility**: public
- **Source Range**: 29870:397:659

## Implementation

```solidity
/// @notice Tests resetting the high-water mark PPS to the current PPS
function test_HighWaterMarkReset_Success() public {
    vm.prank(sGovernor);
    superGovernor.resetHighWaterMark(strategy1);
    uint256 newHwmPps = SuperVaultStrategy(payable(strategy1)).vaultHwmPps();
    uint256 currentPPS = SuperVaultStrategy(payable(strategy1)).getStoredPPS();
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

- **Vm::prank(address)**
- **SuperGovernor::resetHighWaterMark(address)**
- **SuperVaultStrategy::vaultHwmPps()**
- **SuperVaultStrategy::getStoredPPS()**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **strategy1** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HighWaterMarkReset_Success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [newHwmPps, currentPPS, "High Water Mark should be reset to current PPS"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests resetting the high-water mark PPS to the current PPS
