# Function: maxMint(address)

**Contract**: [test/mocks/RuggableConvertVault.sol/contract_RuggableConvertVault.md]

## Metadata

- **Contract**: RuggableConvertVault
- **Signature**: `maxMint(address)`
- **Visibility**: public
- **Source Range**: 3742:106:608

## Implementation

```solidity
function maxMint(address) override public pure returns (uint256) {
    return type(uint256).max;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: RuggableConvertVault.maxMint(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the maximum amount of the Vault shares that can be minted for the receiver, through a mint call.
 - MUST return a limited value if receiver is subject to some mint limit.
 - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of shares that may be minted.
 - MUST NOT revert.
