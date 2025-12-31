# Function: transfer(address,uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3310:288:196

## Implementation

```solidity
function transfer(address to, uint256 amount) virtual override public returns (bool) {
    _balanceOf[msg.sender] = _sub(_balanceOf[msg.sender], amount);
    _balanceOf[to] = _add(_balanceOf[to], amount);
    emit Transfer(msg.sender, to, amount);
    return true;
}
```

## Related Implementations

### _sub(uint256,uint256)

- **Kind**: internal
- **Source**: 7242:154:196
- **Link**: `lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol:MockERC20:_sub(uint256,uint256)`

```solidity
function _sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(a >= b, "ERC20: subtraction underflow");
    return a - b;
}
```

### _add(uint256,uint256)

- **Kind**: internal
- **Source**: 7063:173:196
- **Link**: `lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol:MockERC20:_add(uint256,uint256)`

```solidity
function _add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "ERC20: addition overflow");
    return c;
}
```

## State Variable Reads

- **_balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **_balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.transfer(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MockERC20._sub(uint256,uint256) (NodeID: 1)
  │   💬 Args: [_balanceOf[msg.sender], amount]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MockERC20._add(uint256,uint256) (NodeID: 2)
      💬 Args: [_balanceOf[to], amount]
      👁️  Def: internal
```
