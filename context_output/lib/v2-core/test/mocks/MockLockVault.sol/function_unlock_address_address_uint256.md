# Function: unlock(address,address,uint256)

**Contract**: [lib/v2-core/test/mocks/MockLockVault.sol/contract_MockLockVault.md]

## Metadata

- **Contract**: MockLockVault
- **Signature**: `unlock(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 329:128:484

## Implementation

```solidity
function unlock(address account, address token, uint256 amount) external {
    ERC20(token).transfer(account, amount);
}
```

## External Calls

- **ERC20::transfer(address,uint256)**

## Native Transfers

- **unknown** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockLockVault.unlock(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
