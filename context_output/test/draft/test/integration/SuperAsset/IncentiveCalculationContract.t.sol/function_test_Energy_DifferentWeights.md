# Function: test_Energy_DifferentWeights()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `test_Energy_DifferentWeights()`
- **Visibility**: public
- **Source Range**: 3076:978:564

## Implementation

```solidity
function test_Energy_DifferentWeights() public view {
    uint256[] memory currentAllocation = new uint256[](2);
    currentAllocation[0] = 600e18;
    currentAllocation[1] = 400e18;
    uint256[] memory allocationTarget = new uint256[](2);
    allocationTarget[0] = 500e18;
    allocationTarget[1] = 500e18;
    uint256[] memory weights = new uint256[](2);
    weights[0] = 2 * PRECISION;
    weights[1] = PRECISION;
    uint256 totalCurrentAllocation = 1000e18;
    uint256 totalAllocationTarget = 1000e18;
    (uint256 energy, bool isSuccess) = calculator.energy(currentAllocation, allocationTarget, weights, totalCurrentAllocation, totalAllocationTarget);
    assertEq(isSuccess, true, "isSuccess should be true");
    assertEq(energy, 300 * PRECISION);
}
```

## Related Implementations

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2487:171:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
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

- **IncentiveCalculationContract::energy(uint256[],uint256[],uint256[],uint256,uint256)**

## State Variable Reads

- **PRECISION** (`uint256`)
- **calculator** (`contract IncentiveCalculationContract`) [test/draft/src/SuperAsset/IncentiveCalculationContract.sol/contract_IncentiveCalculationContract.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveCalculationContractTest.test_Energy_DifferentWeights() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [isSuccess, true, "isSuccess should be true"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [energy, 300 * PRECISION]
      👁️  Def: internal
```
