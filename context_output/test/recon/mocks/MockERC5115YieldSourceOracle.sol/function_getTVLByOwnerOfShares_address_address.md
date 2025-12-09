# Function: getTVLByOwnerOfShares(address,address)

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `getTVLByOwnerOfShares(address,address)`
- **Visibility**: external
- **Source Range**: 2122:342:640

## Implementation

```solidity
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) external view returns (uint256) {
    uint256 shares = MockERC5115Tester(yieldSourceAddress).balanceOf(ownerOfShares);
    uint256 exchangeRate = MockERC5115Tester(yieldSourceAddress).exchangeRate();
    return (shares * exchangeRate) / 1e18;
}
```

## External Calls

- **MockERC5115Tester::balanceOf(address)**
- **MockERC5115Tester::exchangeRate()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.getTVLByOwnerOfShares(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Calculates the total value locked in a yield source by a specific owner
 @dev Used to track individual position sizes within the system
 @param yieldSourceAddress The yield-bearing token address to check
 @param ownerOfShares The address owning the yield-bearing tokens
 @return tvl The total value locked by the owner, in underlying asset terms
