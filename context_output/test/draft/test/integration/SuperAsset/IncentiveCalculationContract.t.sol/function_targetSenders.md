# Function: targetSenders()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `targetSenders()`
- **Visibility**: public
- **Source Range**: 3684:133:17
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetSenders() public view returns (address[] memory targetedSenders_) {
    targetedSenders_ = _targetedSenders;
}
```

## State Variable Reads

- **_targetedSenders** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetSenders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
