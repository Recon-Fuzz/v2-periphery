# Function: setTokenOutIncentive(address)

**Contract**: [test/draft/src/SuperAsset/IncentiveFundContract.sol/contract_IncentiveFundContract.md]

## Metadata

- **Contract**: IncentiveFundContract
- **Signature**: `setTokenOutIncentive(address)`
- **Visibility**: external
- **Source Range**: 3504:392:547

## Implementation

```solidity
/// @inheritdoc IIncentiveFundContract
function setTokenOutIncentive(address token) external onlyManager() {
    if (token == address(0)) revert ZERO_ADDRESS();
    bool isWhitelisted = superRegistry.isWhitelistedIncentiveToken(token);
    if (isWhitelisted) {
        tokenOutIncentive = token;
    } else {
        revert TOKEN_NOT_WHITELISTED();
    }
    emit SettlementTokenInSet(token);
}
```

## Related Implementations

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

- **ISuperRegistry::isWhitelistedIncentiveToken(address)**

## State Variable Reads

- **superRegistry** (`contract ISuperRegistry`) [test/draft/src/interfaces/ISuperRegistry.sol/interface_ISuperRegistry.md]
- **superAsset** (`contract ISuperAsset`) [test/draft/src/interfaces/SuperAsset/ISuperAsset.sol/interface_ISuperAsset.md]

## State Variable Writes

- **tokenOutIncentive** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IncentiveFundContract.setTokenOutIncentive(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: IncentiveFundContract.onlyManager() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IIncentiveFundContract

### Interface Documentation

@notice Sets the token for outgoing incentives
 @param token Address of the token
