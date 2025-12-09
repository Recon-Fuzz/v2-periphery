# Function: approve(address,uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3083:221:196

## Implementation

```solidity
function approve(address spender, uint256 amount) virtual override public returns (bool) {
    _allowance[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}
```

## State Variable Writes

- **_allowance** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.approve(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Interface Documentation

@notice Sets `amount` as the allowance of `spender` over the caller's tokens.
 @dev Be aware of front-running risks: https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
