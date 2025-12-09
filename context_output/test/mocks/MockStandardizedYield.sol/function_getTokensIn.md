# Function: getTokensIn()

**Contract**: [test/mocks/MockStandardizedYield.sol/contract_MockStandardizedYield.md]

## Metadata

- **Contract**: MockStandardizedYield
- **Signature**: `getTokensIn()`
- **Visibility**: external
- **Source Range**: 1681:96:603

## Implementation

```solidity
function getTokensIn() external view returns (address[] memory) {
    return tokensIn;
}
```

## State Variable Reads

- **tokensIn** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStandardizedYield.getTokensIn() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
