# Function: previewWithdraw(uint256)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 1722:117:585

## Implementation

```solidity
function previewWithdraw(uint256 shares) override public pure returns (uint256 assets) {
    return shares;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Mock4626Vault.previewWithdraw(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Allows an on-chain or off-chain user to simulate the effects of their withdrawal at the current block,
 given current on-chain conditions.
 - MUST return as close to and no fewer than the exact amount of Vault shares that would be burned in a withdraw
   call in the same transaction. I.e. withdraw should return the same or fewer shares as previewWithdraw if
   called
   in the same transaction.
 - MUST NOT account for withdrawal limits like those returned from maxWithdraw and should always act as though
   the withdrawal would be accepted, regardless if the user has enough shares, etc.
 - MUST be inclusive of withdrawal fees. Integrators should be aware of the existence of withdrawal fees.
 - MUST NOT revert.
 NOTE: any unfavorable discrepancy between convertToShares and previewWithdraw SHOULD be considered slippage in
 share price or some other type of condition, meaning the depositor will lose assets by depositing.
