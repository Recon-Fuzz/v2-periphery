# Function: balanceOf(address)

**Contract**: [lib/v2-core/lib/modulekit/src/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 1446:116:196

## Implementation

```solidity
function balanceOf(address owner) override external view returns (uint256) {
    return _balanceOf[owner];
}
```

## State Variable Reads

- **_balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.balanceOf(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
