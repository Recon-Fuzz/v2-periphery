# Function: getTVLByOwnerOfSharesMultiple(address[],address[][])

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `getTVLByOwnerOfSharesMultiple(address[],address[][])`
- **Visibility**: external
- **Source Range**: 3168:810:640

## Implementation

```solidity
function getTVLByOwnerOfSharesMultiple(address[] memory yieldSourceAddresses, address[][] memory ownersOfShares) external view returns (uint256[][] memory) {
    uint256[][] memory result = new uint256[][](yieldSourceAddresses.length);
    for (uint256 i = 0; i < yieldSourceAddresses.length; i++) {
        result[i] = new uint256[](ownersOfShares[i].length);
        uint256 exchangeRate = MockERC5115Tester(yieldSourceAddresses[i]).exchangeRate();
        for (uint256 j = 0; j < ownersOfShares[i].length; j++) {
            uint256 shares = MockERC5115Tester(yieldSourceAddresses[i]).balanceOf(ownersOfShares[i][j]);
            result[i][j] = (shares * exchangeRate) / 1e18;
        }
    }
    return result;
}
```

## External Calls

- **MockERC5115Tester::exchangeRate()**
- **MockERC5115Tester::balanceOf(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.getTVLByOwnerOfSharesMultiple(address[],address[][]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Batch version of getTVLByOwnerOfShares for multiple yield sources and owners
 @dev Efficiently calculates TVL for multiple owners across multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @param ownersOfShares 2D array where each sub-array contains owner addresses for a yield source
 @return userTvls 2D array of TVL values for each owner in each yield source
