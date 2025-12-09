# Function: asset()

**Contract**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `asset()`
- **Visibility**: external
- **Source Range**: 577:86:589

## Implementation

```solidity
function asset() external view returns (address) {
    return address(this);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.asset() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
