# Function: getQuoteFromProvider(uint256,address,address,bytes32)

**Contract**: [test/mocks/MockSuperOracle.sol/contract_MockSuperOracle.md]

## Metadata

- **Contract**: MockSuperOracle
- **Signature**: `getQuoteFromProvider(uint256,address,address,bytes32)`
- **Visibility**: external
- **Source Range**: 679:318:605

## Implementation

```solidity
function getQuoteFromProvider(uint256, address, address, bytes32) external view returns (uint256, uint256, uint256, uint256) {
    if (providerRemoved) {
        revert("Provider removed");
    }
    return (quoteAmount, 0, 1, 1);
}
```

## State Variable Reads

- **providerRemoved** (`bool`)
- **quoteAmount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracle.getQuoteFromProvider(uint256,address,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
