# Function: batchDistributeRewardsToSuperBank(address[],uint256[])

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]

## Metadata

- **Contract**: TestVaultBank
- **Signature**: `batchDistributeRewardsToSuperBank(address[],uint256[])`
- **Visibility**: external
- **Source Range**: 4056:386:552
- **Inherited From**: VaultBank

## Implementation

```solidity
/// @inheritdoc IVaultBank
function batchDistributeRewardsToSuperBank(address[] memory rewards, uint256[] memory amounts) external onlyRelayer() {
    uint256 len = rewards.length;
    for (uint256 i; i < len; ++i) {
        _distributeRewardsToSuperBank(rewards[i], amounts[i]);
    }
    emit BatchDistributeRewardsToSuperBank(rewards, amounts);
}
```

## Related Implementations

### _distributeRewardsToSuperBank(address,uint256)

- **Kind**: internal
- **Source**: 6844:504:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:_distributeRewardsToSuperBank(address,uint256)`

```solidity
function _distributeRewardsToSuperBank(address token, uint256 amount) internal {
    address superBank = SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.SUPER_BANK());
    if (token == address(0)) {
        (bool success, ) = superBank.call{value: amount}("");
        if (!success) revert INVALID_VALUE();
    } else {
        IERC20(token).safeTransfer(superBank, amount);
    }
}
```

### onlyRelayer()

- **Kind**: modifier
- **Source**: 1880:118:552
- **Link**: `test/draft/src/VaultBank/VaultBank.sol:VaultBank:onlyRelayer()`

```solidity
modifier onlyRelayer() {
    if (!SUPER_REGISTRY.isRelayer(msg.sender)) revert INVALID_RELAYER();
    _;
}
```

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **SUPER_REGISTRY** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBank.batchDistributeRewardsToSuperBank(address[],uint256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: VaultBank._distributeRewardsToSuperBank(address,uint256) (NodeID: 1)
  │   💬 Args: [rewards[i], amounts[i]]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: VaultBank.onlyRelayer() (NodeID: 2)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IVaultBank

### Interface Documentation

@notice Batch distribute rewards to the super bank
 @param rewards The rewards to distribute
 @param amounts The amounts of the rewards
