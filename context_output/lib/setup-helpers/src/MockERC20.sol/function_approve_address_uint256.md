# Function: approve(address,uint256)

**Contract**: [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3072:211:73
- **Inherited From**: ERC20

## Implementation

```solidity
function approve(address spender, uint256 amount) virtual public returns (bool) {
    allowance[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}
```

## State Variable Writes

- **allowance** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.approve(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
