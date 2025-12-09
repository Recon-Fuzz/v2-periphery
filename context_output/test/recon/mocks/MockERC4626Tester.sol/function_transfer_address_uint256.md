# Function: transfer(address,uint256)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3289:535:73
- **Inherited From**: ERC20

## Implementation

```solidity
function transfer(address to, uint256 amount) virtual public returns (bool) {
    uint256 fromBalance = balanceOf[msg.sender];
    if (fromBalance < amount) revert InsufficientBalance(msg.sender, fromBalance, amount);
    balanceOf[msg.sender] = fromBalance - amount;
    unchecked {
        balanceOf[to] += amount;
    }
    emit Transfer(msg.sender, to, amount);
    return true;
}
```

## State Variable Reads

- **balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.transfer(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
