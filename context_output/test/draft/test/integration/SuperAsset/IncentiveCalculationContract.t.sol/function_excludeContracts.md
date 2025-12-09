# Function: excludeContracts()

**Contract**: [test/draft/test/integration/SuperAsset/IncentiveCalculationContract.t.sol/contract_IncentiveCalculationContractTest.md]

## Metadata

- **Contract**: IncentiveCalculationContractTest
- **Signature**: `excludeContracts()`
- **Visibility**: public
- **Source Range**: 2606:142:17
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_) {
    excludedContracts_ = _excludedContracts;
}
```

## State Variable Reads

- **_excludedContracts** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeContracts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
