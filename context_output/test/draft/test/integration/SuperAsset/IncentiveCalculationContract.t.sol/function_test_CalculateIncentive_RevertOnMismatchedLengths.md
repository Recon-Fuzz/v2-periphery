# Function: test_CalculateIncentive_RevertOnMismatchedLengths()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `test_CalculateIncentive_RevertOnMismatchedLengths()`
- **Visibility**: public
- **Source Range**: 9006:673:564

## Implementation

```solidity
function test_CalculateIncentive_RevertOnMismatchedLengths() public {
    uint256[] memory allocationPreOperation = new uint256[](2);
    uint256[] memory allocationPostOperation = new uint256[](3);
    uint256[] memory allocationTarget = new uint256[](2);
    uint256[] memory weights = new uint256[](2);
    vm.expectRevert(IIncentiveCalculationContract.INVALID_ARRAY_LENGTH.selector);
    calculator.calculateIncentive(allocationPreOperation, allocationPostOperation, allocationTarget, weights, 1000e18, 1000e18, 1000e18, PRECISION);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **IncentiveCalculationContract::calculateIncentive(uint256[],uint256[],uint256[],uint256[],uint256,uint256,uint256,uint256)**

## State Variable Reads

- **calculator** (`contract IncentiveCalculationContract`) [test/draft/src/SuperAsset/IncentiveCalculationContract.sol/contract_IncentiveCalculationContract.md]
- **PRECISION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveCalculationContractTest.test_CalculateIncentive_RevertOnMismatchedLengths() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
