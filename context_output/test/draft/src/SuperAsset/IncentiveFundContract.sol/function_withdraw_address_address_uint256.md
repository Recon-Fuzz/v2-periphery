# Function: withdraw(address,address,uint256)

**Contract**: [test/draft/src/SuperAsset/IncentiveFundContract.sol/contract_IncentiveFundContract.md]

## Metadata

- **Contract**: IncentiveFundContract
- **Signature**: `withdraw(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 6105:319:547

## Implementation

```solidity
/// @inheritdoc IIncentiveFundContract
function withdraw(address receiver, address tokenOut, uint256 amount) external onlyManager() {
    _validateInput(receiver, amount);
    if (tokenOut == address(0)) revert ZERO_ADDRESS();
    IERC20(tokenOut).safeTransfer(receiver, amount);
    emit RebalanceWithdrawal(receiver, tokenOut, amount);
}
```

## Related Implementations

### _validateInput(address,uint256)

- **Kind**: internal
- **Source**: 6750:177:547
- **Link**: `test/draft/src/SuperAsset/IncentiveFundContract.sol:IncentiveFundContract:_validateInput(address,uint256)`

```solidity
function _validateInput(address user, uint256 amount) internal pure {
    if (user == address(0)) revert ZERO_ADDRESS();
    if (amount == 0) revert ZERO_AMOUNT();
}
```

### onlyManager()

- **Kind**: modifier
- **Source**: 1591:299:547
- **Link**: `test/draft/src/SuperAsset/IncentiveFundContract.sol:IncentiveFundContract:onlyManager()`

```solidity
modifier onlyManager() {
    ISuperAssetFactory factory = ISuperAssetFactory(superRegistry.getAddress(superRegistry.SUPER_ASSET_FACTORY()));
    address manager = factory.getIncentiveFundManager(address(superAsset));
    if (msg.sender != manager) revert UNAUTHORIZED();
    _;
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **superRegistry** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **superAsset** (`contract ISuperAsset`) [test/draft/src/interfaces/SuperAsset/ISuperAsset.sol/interface_ISuperAsset.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveFundContract.withdraw(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: IncentiveFundContract._validateInput(address,uint256) (NodeID: 1)
  │   💬 Args: [receiver, amount]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: IncentiveFundContract.onlyManager() (NodeID: 2)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IIncentiveFundContract

### Interface Documentation

@notice Withdraws tokens during rebalancing
 @param receiver Address to receive the tokens
 @param tokenOut Token to withdraw
 @param amount Amount to withdraw
