# Function: returnShares(address,uint256)

**Contract**: [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

## Metadata

- **Contract**: SuperVaultEscrow
- **Signature**: `returnShares(address,uint256)`
- **Visibility**: external
- **Source Range**: 2191:212:512

## Implementation

```solidity
/// @inheritdoc ISuperVaultEscrow
function returnShares(address to, uint256 amount) external onlyVault() {
    if (amount == 0) revert ZERO_AMOUNT();
    IERC20(vault).safeTransfer(to, amount);
    emit SharesReturned(to, amount);
}
```

## Related Implementations

### onlyVault()

- **Kind**: modifier
- **Source**: 1015:61:512
- **Link**: `src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow:onlyVault()`

```solidity
modifier onlyVault() {
    _onlyVault();
    _;
}
```

### _onlyVault()

- **Kind**: internal
- **Source**: 1082:99:512
- **Link**: `src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow:_onlyVault()`

```solidity
function _onlyVault() internal view {
    if (msg.sender != vault) revert UNAUTHORIZED();
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **vault** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrow.returnShares(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: SuperVaultEscrow.onlyVault() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: SuperVaultEscrow._onlyVault() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultEscrow

### Interface Documentation

@notice Return shares from escrow to user during redeem cancellation
 @param to The address to return shares to
 @param amount The amount of shares to return
