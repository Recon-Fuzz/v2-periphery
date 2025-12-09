# Function: test_CalculateIncentive_MaxValues()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `test_CalculateIncentive_MaxValues()`
- **Visibility**: public
- **Source Range**: 24014:1416:564

## Implementation

```solidity
function test_CalculateIncentive_MaxValues() public view {
    uint256[] memory allocationPreOperation = new uint256[](2);
    allocationPreOperation[0] = type(uint256).max / 2;
    allocationPreOperation[1] = type(uint256).max / 2;
    uint256[] memory allocationPostOperation = new uint256[](2);
    allocationPostOperation[0] = type(uint256).max / 3;
    allocationPostOperation[1] = (type(uint256).max / 3) * 2;
    uint256[] memory allocationTarget = new uint256[](2);
    allocationTarget[0] = type(uint256).max / 2;
    allocationTarget[1] = type(uint256).max / 2;
    uint256[] memory weights = new uint256[](2);
    weights[0] = PRECISION;
    weights[1] = PRECISION;
    uint256 totalAllocationPreOperation = type(uint256).max;
    uint256 totalAllocationPostOperation = type(uint256).max;
    uint256 totalAllocationTarget = type(uint256).max;
    uint256 energyToUSDExchangeRatio = PRECISION;
    calculator.calculateIncentive(allocationPreOperation, allocationPostOperation, allocationTarget, weights, totalAllocationPreOperation, totalAllocationPostOperation, totalAllocationTarget, energyToUSDExchangeRatio);
    assertTrue(true);
}
```

## Related Implementations

### assertTrue(bool)

- **Kind**: internal
- **Source**: 1764:124:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool)`

```solidity
function assertTrue(bool data) virtual internal pure {
    if (!data) {
        vm.assertTrue(data);
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
┌─ [0] ⚙️ FUNCTION: IncentiveCalculationContractTest.test_CalculateIncentive_MaxValues() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool) (NodeID: 1)
      💬 Args: [true]
      👁️  Def: internal
```
