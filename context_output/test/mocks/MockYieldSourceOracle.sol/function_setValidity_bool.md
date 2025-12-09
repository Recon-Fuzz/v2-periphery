# Function: setValidity(bool)

**Contract**: [test/mocks/MockYieldSourceOracle.sol/contract_MockYieldSourceOracle.md]

## Metadata

- **Contract**: MockYieldSourceOracle
- **Signature**: `setValidity(bool)`
- **Visibility**: external
- **Source Range**: 959:83:607

## Implementation

```solidity
function setValidity(bool _validity) external {
    validity = _validity;
}
```

## State Variable Writes

- **validity** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockYieldSourceOracle.setValidity(bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
