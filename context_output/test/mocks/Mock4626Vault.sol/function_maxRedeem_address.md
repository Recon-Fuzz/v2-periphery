# Function: maxRedeem(address)

**Contract**: [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]

## Metadata

- **Contract**: Mock4626Vault
- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 6888:112:270
- **Inherited From**: ERC4626

## Implementation

```solidity
/// @inheritdoc IERC4626
function maxRedeem(address owner) virtual public view returns (uint256) {
    return balanceOf(owner);
}
```

## Related Implementations

### balanceOf(address)

- **Kind**: internal
- **Source**: 2933:116:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:balanceOf(address)`

```solidity
/// @inheritdoc IERC20
function balanceOf(address account) virtual public view returns (uint256) {
    return _balances[account];
}
```

## State Variable Reads

- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC4626.maxRedeem(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20.balanceOf(address) (NodeID: 1)
      💬 Args: [owner]
      👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IERC4626

### Interface Documentation

 @dev Returns the maximum amount of Vault shares that can be redeemed from the owner balance in the Vault,
 through a redeem call.
 - MUST return a limited value if owner is subject to some withdrawal limit or timelock.
 - MUST return balanceOf(owner) if owner is not subject to any withdrawal limit or timelock.
 - MUST NOT revert.
