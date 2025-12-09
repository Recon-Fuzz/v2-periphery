# Function: balanceOf(address)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 2933:116:267
- **Inherited From**: ERC20

## Implementation

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
┌─ [0] ⚙️ FUNCTION: ERC20.balanceOf(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IERC20

### Interface Documentation

 @dev Returns the value of tokens owned by `account`.
