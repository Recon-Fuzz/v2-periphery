# Function: setUp()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 672:88:564

## Implementation

```solidity
function setUp() public {
    calculator = new IncentiveCalculationContract();
}
```

## State Variable Writes

- **calculator** (`contract IncentiveCalculationContract`) [test/draft/src/SuperAsset/IncentiveCalculationContract.sol/contract_IncentiveCalculationContract.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveCalculationContractTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
