# Function: approve(address,uint256)

**Contract**: [test/recon/mocks/MockERC5115Tester.sol/contract_MockERC5115Tester.md]

## Metadata

- **Contract**: MockERC5115Tester
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
