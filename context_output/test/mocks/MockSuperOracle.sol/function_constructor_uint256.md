# Function: constructor(uint256)

**Contract**: [test/mocks/MockSuperOracle.sol/contract_MockSuperOracle.md]

## Metadata

- **Contract**: MockSuperOracle
- **Signature**: `constructor(uint256)`
- **Visibility**: public
- **Source Range**: 293:77:605

## Implementation

```solidity
constructor(uint256 _quoteAmount) {
    quoteAmount = _quoteAmount;
}
```

## State Variable Writes

- **quoteAmount** (`uint256`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockSuperOracle.constructor(uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockSuperOracle
```
