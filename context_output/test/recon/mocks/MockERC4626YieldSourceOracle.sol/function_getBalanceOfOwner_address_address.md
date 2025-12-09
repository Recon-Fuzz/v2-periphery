# Function: getBalanceOfOwner(address,address)

**Contract**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

## Metadata

- **Contract**: MockERC4626YieldSourceOracle
- **Signature**: `getBalanceOfOwner(address,address)`
- **Visibility**: external
- **Source Range**: 1701:187:638

## Implementation

```solidity
function getBalanceOfOwner(address yieldSourceAddress, address ownerOfShares) external view returns (uint256) {
    return IERC4626(yieldSourceAddress).balanceOf(ownerOfShares);
}
```

## External Calls

- **IERC4626::balanceOf(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC4626YieldSourceOracle.getBalanceOfOwner(address,address) (NodeID: 0)
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
