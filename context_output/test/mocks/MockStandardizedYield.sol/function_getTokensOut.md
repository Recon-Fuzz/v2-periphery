# Function: getTokensOut()

**Contract**: [test/mocks/MockStandardizedYield.sol/contract_MockStandardizedYield.md]

## Metadata

- **Contract**: MockStandardizedYield
- **Signature**: `getTokensOut()`
- **Visibility**: external
- **Source Range**: 1884:98:603

## Implementation

```solidity
function getTokensOut() external view returns (address[] memory) {
    return tokensOut;
}
```

## State Variable Reads

- **tokensOut** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStandardizedYield.getTokensOut() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
