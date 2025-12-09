# Function: getQuote(uint256,address,address)

**Contract**: [test/mocks/MockSuperOracle.sol/contract_MockSuperOracle.md]

## Metadata

- **Contract**: MockSuperOracle
- **Signature**: `getQuote(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 480:112:605

## Implementation

```solidity
function getQuote(uint256, address, address) external view returns (uint256) {
    return quoteAmount;
}
```

## State Variable Reads

- **quoteAmount** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockSuperOracle.getQuote(uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Returns the value of `baseAmount` of `base` in `quote` terms.
 @dev MUST round down towards 0.
 MUST revert with `OracleUnsupportedPair` if not capable to provide data for the specified `base` and `quote`
 pair.
 MUST revert with `OracleUntrustedData` if not capable to provide data within a degree of confidence publicly
 specified.
 @param baseAmount The amount of `base` to convert.
 @param base The asset that the user needs to know the value for.
 @param quote The asset in which the user needs to value the base.
 @return quoteAmount The value of `baseAmount` of `base` in `quote` terms
