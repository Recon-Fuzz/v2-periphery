# Function: setTokensIn(address[])

**Contract**: [test/mocks/MockStandardizedYield.sol/contract_MockStandardizedYield.md]

## Metadata

- **Contract**: MockStandardizedYield
- **Signature**: `setTokensIn(address[])`
- **Visibility**: external
- **Source Range**: 1783:95:603

## Implementation

```solidity
function setTokensIn(address[] memory _tokensIn) external {
    tokensIn = _tokensIn;
}
```

## State Variable Writes

- **tokensIn** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStandardizedYield.setTokensIn(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
