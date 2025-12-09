# Function: getPricePerShare(address)

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `getPricePerShare(address)`
- **Visibility**: external
- **Source Range**: 1752:162:640

## Implementation

```solidity
function getPricePerShare(address yieldSourceAddress) external view returns (uint256) {
    return MockERC5115Tester(yieldSourceAddress).exchangeRate();
}
```

## External Calls

- **MockERC5115Tester::exchangeRate()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.getPricePerShare(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Retrieves the current price per share in terms of the underlying asset
 @dev Core function for calculating yields and determining returns
 @param yieldSourceAddress The yield-bearing token address to get the price for
 @return pricePerShare The current price per share in underlying asset terms, scaled by decimals
