# Function: maxDeposit(address)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `maxDeposit(address)`
- **Visibility**: public
- **Source Range**: 6417:108:270
- **Inherited From**: ERC4626

## Implementation

```solidity
/// @inheritdoc IERC4626
function maxDeposit(address) virtual public view returns (uint256) {
    return type(uint256).max;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626.maxDeposit(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IERC4626

### Interface Documentation

 @dev Returns the maximum amount of the underlying asset that can be deposited into the Vault for the receiver,
 through a deposit call.
 - MUST return a limited value if receiver is subject to some deposit limit.
 - MUST return 2 ** 256 - 1 if there is no limit on the maximum amount of assets that may be deposited.
 - MUST NOT revert.
