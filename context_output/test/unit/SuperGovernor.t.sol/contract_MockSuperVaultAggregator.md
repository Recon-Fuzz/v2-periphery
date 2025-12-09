# Contract: MockSuperVaultAggregator

## Metadata

- **Name**: MockSuperVaultAggregator
- **Type**: Contract
- **Path**: test/unit/SuperGovernor.t.sol
- **Documentation**: @notice Mock SuperVaultAggregator for testing executeUpkeepClaim delegation

## State Variables

### _claimUpkeepCalled

```solidity
bool private _claimUpkeepCalled
```

### _lastClaimAmount

```solidity
uint256 private _lastClaimAmount
```

## Public/External Functions

### claimUpkeep(uint256)

- **Signature**: `claimUpkeep(uint256)`
- **Visibility**: external
- **Source Range**: 136710:123:659
- **Details**: [function_claimUpkeep_uint256.md](./function_claimUpkeep_uint256.md)

**Signature:**
```solidity
function claimUpkeep(uint256 amount) external;
```

### claimUpkeepCalled()

- **Signature**: `claimUpkeepCalled()`
- **Visibility**: external
- **Source Range**: 136839:100:659
- **Details**: [function_claimUpkeepCalled.md](./function_claimUpkeepCalled.md)

**Signature:**
```solidity
function claimUpkeepCalled() external view returns (bool);
```

### lastClaimAmount()

- **Signature**: `lastClaimAmount()`
- **Visibility**: external
- **Source Range**: 136945:99:659
- **Details**: [function_lastClaimAmount.md](./function_lastClaimAmount.md)

**Signature:**
```solidity
function lastClaimAmount() external view returns (uint256);
```
