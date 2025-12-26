# Function: transferFrom(address,address,uint256)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3604:538:196

## Implementation

```solidity
function transferFrom(address from, address to, uint256 amount) virtual override public returns (bool) {
    uint256 allowed = _allowance[from][msg.sender];
    if (allowed != (~uint256(0))) _allowance[from][msg.sender] = _sub(allowed, amount);
    _balanceOf[from] = _sub(_balanceOf[from], amount);
    _balanceOf[to] = _add(_balanceOf[to], amount);
    emit Transfer(from, to, amount);
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

- **_allowance** (`mapping(address => mapping(address => uint256))`)
- **_balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **_allowance** (`mapping(address => mapping(address => uint256))`)
- **_balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.transferFrom(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MockERC20._sub(uint256,uint256) (NodeID: 1)
  │   💬 Args: [allowed, amount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MockERC20._sub(uint256,uint256) (NodeID: 2)
  │   💬 Args: [_balanceOf[from], amount]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MockERC20._add(uint256,uint256) (NodeID: 3)
      💬 Args: [_balanceOf[to], amount]
      👁️  Def: internal
```
