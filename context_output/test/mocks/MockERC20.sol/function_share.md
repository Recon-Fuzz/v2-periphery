# Function: share()

**Contract**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

## Metadata

- **Contract**: MockERC20
- **Signature**: `share()`
- **Visibility**: external
- **Source Range**: 735:86:589

## Implementation

```solidity
function share() external view returns (address) {
    return address(this);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20.share() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
