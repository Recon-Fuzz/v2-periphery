# Function: getTVLByOwnerOfSharesMultiple(address[],address[][])

**Contract**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

## Metadata

- **Contract**: ERC7540YieldSourceOracle
- **Signature**: `getTVLByOwnerOfSharesMultiple(address[],address[][])`
- **Visibility**: external
- **Source Range**: 5599:959:354
- **Inherited From**: AbstractYieldSourceOracle

## Implementation

```solidity
/// @inheritdoc IYieldSourceOracle
function getTVLByOwnerOfSharesMultiple(address[] memory yieldSourceAddresses, address[][] memory ownersOfShares) external view returns (uint256[][] memory userTvls) {
    uint256 length = yieldSourceAddresses.length;
    if (length != ownersOfShares.length) revert ARRAY_LENGTH_MISMATCH();
    userTvls = new uint256[][](length);
    for (uint256 i; i < length; ++i) {
        address yieldSource = yieldSourceAddresses[i];
        address[] memory owners = ownersOfShares[i];
        uint256 ownersLength = owners.length;
        userTvls[i] = new uint256[](ownersLength);
        for (uint256 j; j < ownersLength; ++j) {
            uint256 userTvl = getTVLByOwnerOfShares(yieldSource, owners[j]);
            userTvls[i][j] = userTvl;
        }
    }
}
```

## Related Implementations

### getTVLByOwnerOfShares(address,address)

- **Kind**: internal
- **Source**: 3060:386:498
- **Link**: `lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol:ERC7540YieldSourceOracle:getTVLByOwnerOfShares(address,address)`

```solidity
/// @inheritdoc AbstractYieldSourceOracle
function getTVLByOwnerOfShares(address yieldSourceAddress, address ownerOfShares) override public view returns (uint256) {
    uint256 shares = IERC20(IERC7540(yieldSourceAddress).share()).balanceOf(ownerOfShares);
    if (shares == 0) return 0;
    return IERC7540(yieldSourceAddress).convertToAssets(shares);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AbstractYieldSourceOracle.getTVLByOwnerOfSharesMultiple(address[],address[][]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ERC7540YieldSourceOracle.getTVLByOwnerOfShares(address,address) (NodeID: 1)
      💬 Args: [yieldSource, owners[j]]
      👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IYieldSourceOracle

### Interface Documentation

@notice Batch version of getTVLByOwnerOfShares for multiple yield sources and owners
 @dev Efficiently calculates TVL for multiple owners across multiple yield sources
 @param yieldSourceAddresses Array of yield-bearing token addresses
 @param ownersOfShares 2D array where each sub-array contains owner addresses for a yield source
 @return userTvls 2D array of TVL values for each owner in each yield source
