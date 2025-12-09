# Function: getTVL(address)

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `getTVL(address)`
- **Visibility**: external
- **Source Range**: 2470:303:640

## Implementation

```solidity
function getTVL(address yieldSourceAddress) external view returns (uint256) {
    uint256 totalShares = MockERC5115Tester(yieldSourceAddress).totalSupply();
    uint256 exchangeRate = MockERC5115Tester(yieldSourceAddress).exchangeRate();
    return (totalShares * exchangeRate) / 1e18;
}
```

## External Calls

- **MockERC5115Tester::totalSupply()**
- **MockERC5115Tester::exchangeRate()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.getTVL(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the total value locked across all users in a yield source
 @dev Critical for monitoring the size of each yield source in the system
 @param yieldSourceAddress The yield-bearing token address to check
 @return tvl The total value locked in the yield source, in underlying asset terms
