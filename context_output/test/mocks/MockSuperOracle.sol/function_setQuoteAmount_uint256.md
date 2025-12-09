# Function: setQuoteAmount(uint256)

**Contract**: [test/mocks/MockSuperOracle.sol/contract_MockSuperOracle.md]

## Metadata

- **Contract**: MockSuperOracle
- **Signature**: `setQuoteAmount(uint256)`
- **Visibility**: external
- **Source Range**: 376:98:605

## Implementation

```solidity
function setQuoteAmount(uint256 _quoteAmount) external {
    quoteAmount = _quoteAmount;
}
```

## State Variable Writes

- **quoteAmount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracle.setQuoteAmount(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
