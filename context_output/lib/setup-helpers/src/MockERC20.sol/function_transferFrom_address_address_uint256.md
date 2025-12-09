# Function: transferFrom(address,address,uint256)

**Contract**: [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3830:834:73
- **Inherited From**: ERC20

## Implementation

```solidity
function transferFrom(address from, address to, uint256 amount) virtual public returns (bool) {
    uint256 allowed = allowance[from][msg.sender];
    uint256 fromBalance = balanceOf[from];
    if (allowed != type(uint256).max) {
        if (allowed < amount) revert InsufficientAllowance(from, msg.sender, allowed, amount);
        allowance[from][msg.sender] = allowed - amount;
    }
    if (fromBalance < amount) revert InsufficientBalance(from, fromBalance, amount);
    balanceOf[from] = fromBalance - amount;
    unchecked {
        balanceOf[to] += amount;
    }
    emit Transfer(from, to, amount);
    return true;
}
```

## State Variable Reads

- **allowance** (`mapping(address => mapping(address => uint256))`)
- **balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **allowance** (`mapping(address => mapping(address => uint256))`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.transferFrom(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
