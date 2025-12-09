# Function: test_CalculateIncentive_DifferentTotalAllocations()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `test_CalculateIncentive_DifferentTotalAllocations()`
- **Visibility**: public
- **Source Range**: 11471:1591:564

## Implementation

```solidity
function test_CalculateIncentive_DifferentTotalAllocations() public view {
    uint256[] memory allocationPreOperation = new uint256[](2);
    allocationPreOperation[0] = 600e18;
    allocationPreOperation[1] = 400e18;
    uint256[] memory allocationPostOperation = new uint256[](2);
    allocationPostOperation[0] = 1200e18;
    allocationPostOperation[1] = 800e18;
    uint256[] memory allocationTarget = new uint256[](2);
    allocationTarget[0] = 500e18;
    allocationTarget[1] = 500e18;
    uint256[] memory weights = new uint256[](2);
    weights[0] = PRECISION;
    weights[1] = PRECISION;
    uint256 totalAllocationPreOperation = 1000e18;
    uint256 totalAllocationPostOperation = 2000e18;
    uint256 totalAllocationTarget = 1000e18;
    uint256 energyToUSDExchangeRatio = PRECISION;
    (int256 incentive, bool isSuccess) = calculator.calculateIncentive(allocationPreOperation, allocationPostOperation, allocationTarget, weights, totalAllocationPreOperation, totalAllocationPostOperation, totalAllocationTarget, energyToUSDExchangeRatio);
    assertEq(isSuccess, true, "isSuccess should be true");
    assertEq(incentive, 0);
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

### assertEq(int256,int256)

- **Kind**: internal
- **Source**: 3346:151:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256)`

```solidity
function assertEq(int256 left, int256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

## External Calls

- **IncentiveCalculationContract::calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256)**

## State Variable Reads

- **PRECISION** (`uint256`)
- **calculator** (`contract IncentiveCalculationContract`) [test/draft/src/SuperAsset/IncentiveCalculationContract.sol/contract_IncentiveCalculationContract.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveCalculationContractTest.test_CalculateIncentive_DifferentTotalAllocations() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [isSuccess, true, "isSuccess should be true"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256) (NodeID: 2)
      💬 Args: [incentive, 0]
      👁️  Def: internal
```
