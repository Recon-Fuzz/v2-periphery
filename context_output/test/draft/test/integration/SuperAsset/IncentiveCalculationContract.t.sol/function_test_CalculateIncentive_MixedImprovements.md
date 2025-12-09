# Function: test_CalculateIncentive_MixedImprovements()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `test_CalculateIncentive_MixedImprovements()`
- **Visibility**: public
- **Source Range**: 20229:2053:564

## Implementation

```solidity
function test_CalculateIncentive_MixedImprovements() public view {
    uint256[] memory allocationPreOperation = new uint256[](3);
    allocationPreOperation[0] = 400e18;
    allocationPreOperation[1] = 300e18;
    allocationPreOperation[2] = 300e18;
    uint256[] memory allocationPostOperation = new uint256[](3);
    allocationPostOperation[0] = 300e18;
    allocationPostOperation[1] = 400e18;
    allocationPostOperation[2] = 300e18;
    uint256[] memory allocationTarget = new uint256[](3);
    allocationTarget[0] = 300e18;
    allocationTarget[1] = 300e18;
    allocationTarget[2] = 400e18;
    uint256[] memory weights = new uint256[](3);
    weights[0] = PRECISION;
    weights[1] = PRECISION;
    weights[2] = 2 * PRECISION;
    uint256 totalAllocationPreOperation = 1000e18;
    uint256 totalAllocationPostOperation = 1000e18;
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
┌─ [0] ⚙️ FUNCTION: IncentiveCalculationContractTest.test_CalculateIncentive_MixedImprovements() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 1)
  │   💬 Args: [isSuccess, true, "isSuccess should be true"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256) (NodeID: 2)
      💬 Args: [incentive, 0]
      👁️  Def: internal
```
