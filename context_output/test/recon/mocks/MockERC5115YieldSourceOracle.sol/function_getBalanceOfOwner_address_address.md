# Function: getBalanceOfOwner(address,address)

**Contract**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC5115YieldSourceOracle
- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: external
- **Source Range**: 1920:196:640

## Implementation

```solidity
function getBalanceOfOwner(address yieldSourceAddress, address ownerOfShares) external view returns (uint256) {
    return MockERC5115Tester(yieldSourceAddress).balanceOf(ownerOfShares);
}
```

## External Calls

- **MockERC5115Tester::balanceOf(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC5115YieldSourceOracle.getBalanceOfOwner(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Gets the share balance of a specific owner in a yield source
 @dev Returns raw share balance without converting to underlying assets
      Used to track participation in the system and for accounting
 @param yieldSourceAddress The yield-bearing token address
 @param ownerOfShares The address to check the balance for
 @return balance The number of yield-bearing tokens owned by the address
