# Function: getTVLMultiple(address[])

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `getTVLMultiple(address[])`
- **Visibility**: external
- **Source Range**: 3984:531:640

## Implementation

```solidity
function getTVLMultiple(address[] memory yieldSourceAddresses) external view returns (uint256[] memory) {
    uint256[] memory tvls = new uint256[](yieldSourceAddresses.length);
    for (uint256 i = 0; i < yieldSourceAddresses.length; i++) {
        uint256 totalShares = MockERC5115Tester(yieldSourceAddresses[i]).totalSupply();
        uint256 exchangeRate = MockERC5115Tester(yieldSourceAddresses[i]).exchangeRate();
        tvls[i] = (totalShares * exchangeRate) / 1e18;
    }
    return tvls;
}
```

## External Calls

- **MockERC5115Tester::totalSupply()**
- **MockERC5115Tester::exchangeRate()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.getTVLMultiple(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Batch version of getTVL for multiple yield sources
 @dev Efficiently calculates total TVL across multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @return tvls Array containing the total TVL for each yield source
