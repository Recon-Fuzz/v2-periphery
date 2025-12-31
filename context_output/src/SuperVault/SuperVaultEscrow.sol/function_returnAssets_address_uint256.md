# Function: returnAssets(address,uint256)

**Contract**: [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

## Metadata

- **Contract**: SuperVaultEscrow
- **Signature**: `returnAssets(address,uint256)`
- **Visibility**: external
- **Source Range**: 2447:283:512

## Implementation

```solidity
/// @inheritdoc ISuperVaultEscrow
function returnAssets(address to, uint256 amount) external onlyVault() {
    if (amount == 0) revert ZERO_AMOUNT();
    if (to == address(0)) revert ZERO_ADDRESS();
    IERC20(IERC4626(vault).asset()).safeTransfer(to, amount);
    emit AssetsReturned(to, amount);
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
- **IERC4626::asset()**

## State Variable Reads

- **vault** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrow.returnAssets(address,uint256) (NodeID: 0)
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

@notice Return assets from escrow to vault during deposit cancellation
 @param to The address to return assets to
 @param amount The amount of assets to return
