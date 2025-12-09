# Function: claimUpkeep(uint256)

**Contract**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

## Metadata

- **Contract**: UnsafeSuperVaultAggregator
- **Signature**: `claimUpkeep(uint256)`
- **Visibility**: external
- **Source Range**: 15286:666:634

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function claimUpkeep(uint256 amount) external {
    if (msg.sender != address(SUPER_GOVERNOR)) {
        revert CALLER_NOT_AUTHORIZED();
    }
    if (claimableUpkeep < amount) revert INSUFFICIENT_UPKEEP();
    claimableUpkeep -= amount;
    address upkeepToken = SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.UPKEEP_TOKEN());
    address _superBank = _getSuperBank();
    IERC20(upkeepToken).safeTransfer(_superBank, amount);
    emit UpkeepClaimed(_superBank, amount);
}
```

## Related Implementations

### _getSuperBank()

- **Kind**: internal
- **Source**: 55057:135:634
- **Link**: `test/recon/helpers/UnsafeSuperVaultAggregator.sol:UnsafeSuperVaultAggregator:_getSuperBank()`

```solidity
///  @dev Internal function to return the `SuperBank` address
///  @return superBank The superBank address
function _getSuperBank() internal view returns (address) {
    return SUPER_GOVERNOR.getAddress(SUPER_GOVERNOR.SUPER_BANK());
}
```

## External Calls

- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::UPKEEP_TOKEN()**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **claimableUpkeep** (`uint256`)

## State Variable Writes

- **claimableUpkeep** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UnsafeSuperVaultAggregator.claimUpkeep(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: UnsafeSuperVaultAggregator._getSuperBank() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Claims upkeep tokens from the contract
 @param amount Amount of upkeep tokens to claim
