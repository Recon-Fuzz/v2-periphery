# Function: test_Energy_RevertOnMismatchedLengths()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `test_Energy_RevertOnMismatchedLengths()`
- **Visibility**: public
- **Source Range**: 2651:419:564

## Implementation

```solidity
function test_Energy_RevertOnMismatchedLengths() public {
    uint256[] memory currentAllocation = new uint256[](2);
    uint256[] memory allocationTarget = new uint256[](3);
    uint256[] memory weights = new uint256[](2);
    vm.expectRevert(IIncentiveCalculationContract.INVALID_ARRAY_LENGTH.selector);
    calculator.energy(currentAllocation, allocationTarget, weights, 1000e18, 1000e18);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **IncentiveCalculationContract::energy(uint256[],uint256[],uint256[],uint256,uint256)**

## State Variable Reads

- **calculator** (`contract IncentiveCalculationContract`) [test/draft/src/SuperAsset/IncentiveCalculationContract.sol/contract_IncentiveCalculationContract.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveCalculationContractTest.test_Energy_RevertOnMismatchedLengths() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
