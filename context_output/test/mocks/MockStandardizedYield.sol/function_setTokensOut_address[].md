# Function: setTokensOut(address[])

**Contract**: [test/mocks/MockStandardizedYield.sol/contract_MockStandardizedYield.md]

## Metadata

- **Contract**: MockStandardizedYield
- **Signature**: `setTokensOut(address[])`
- **Visibility**: external
- **Source Range**: 1988:99:603

## Implementation

```solidity
function setTokensOut(address[] memory _tokensOut) external {
    tokensOut = _tokensOut;
}
```

## State Variable Writes

- **tokensOut** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStandardizedYield.setTokensOut(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
