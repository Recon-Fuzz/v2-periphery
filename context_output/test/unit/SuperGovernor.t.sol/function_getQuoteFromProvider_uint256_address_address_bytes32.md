# Function: getQuoteFromProvider(uint256,address,address,bytes32)

**Contract**: [test/unit/SuperGovernor.t.sol/contract_MockSuperOracleForStaleness.md]

## Metadata

- **Contract**: MockSuperOracleForStaleness
- **Signature**: `getQuoteFromProvider(uint256,address,address,bytes32)`
- **Visibility**: external
- **Source Range**: 135787:296:659

## Implementation

```solidity
/// @notice Mock implementation of getQuoteFromProvider for _convertGasToUp testing
function getQuoteFromProvider(uint256 amount, address, address, bytes32) external pure returns (uint256, uint256, uint256, uint256) {
    return (amount, 0, 0, 0);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracleForStaleness.getQuoteFromProvider(uint256,address,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Mock implementation of getQuoteFromProvider for _convertGasToUp testing
