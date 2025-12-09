# Function: mint(address,uint256)

**Contract**: [test/recon/mocks/MockERC4626Tester.sol/contract_MockERC4626Tester.md]

## Metadata

- **Contract**: MockERC4626Tester
- **Signature**: `mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 8186:89:73
- **Inherited From**: MockERC20

## Implementation

```solidity
function mint(address to, uint256 value) virtual public {
    _mint(to, value);
}
```

## Related Implementations

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 7079:471:73
- **Link**: `lib/setup-helpers/src/MockERC20.sol:ERC20:_mint(address,uint256)`

```solidity
function _mint(address to, uint256 amount) virtual internal {
    uint256 newTotalSupply = totalSupply + amount;
    if (newTotalSupply < totalSupply) revert MintOverflow(totalSupply, amount);
    totalSupply = newTotalSupply;
    unchecked {
        balanceOf[to] += amount;
    }
    emit Transfer(address(0), to, amount);
}
```

## State Variable Reads

- **totalSupply** (`uint256`)

## State Variable Writes

- **totalSupply** (`uint256`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20._mint(address,uint256) (NodeID: 1)
      💬 Args: [to, value]
      👁️  Def: internal
```
