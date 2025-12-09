# Function: lock(address,address,address,uint256)

**Contract**: [lib/v2-core/test/mocks/MockLockVault.sol/contract_MockLockVault.md]

## Metadata

- **Contract**: MockLockVault
- **Signature**: `lock(address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 158:165:484

## Implementation

```solidity
function lock(address account, address token, address, uint256 amount) external {
    ERC20(token).transferFrom(account, address(this), amount);
}
```

## External Calls

- **ERC20::transferFrom(address,address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockLockVault.lock(address,address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
