# Function: erc7540_2(address)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `erc7540_2(address)`
- **Visibility**: public
- **Source Range**: 3278:619:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
/// @dev 7540-2	convertToShares(totalAssets) == totalSupply unless price is 0.0
function erc7540_2(address erc7540Target) virtual public returns (bool) {
    if (IERC7540Like(erc7540Target).convertToAssets(10 ** IShareLike(IERC7540Like(erc7540Target).share()).decimals()) == 0) return true;
    return _diff(IERC7540Like(erc7540Target).convertToShares(IERC7540Like(erc7540Target).totalAssets()), IShareLike(IERC7540Like(erc7540Target).share()).totalSupply()) <= MAX_ROUNDING_ERROR;
}
```

## Related Implementations

### _diff(uint256,uint256)

- **Kind**: internal
- **Source**: 3903:114:10
- **Link**: `lib/erc7540-reusable-properties/src/ERC7540Properties.sol:ERC7540Properties:_diff(uint256,uint256)`

```solidity
function _diff(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a > b) ? (a - b) : (b - a);
}
```

## External Calls

- **IERC7540Like::convertToAssets(uint256)**
- **IShareLike::decimals()**
- **IERC7540Like::share()**
- **IERC7540Like::convertToShares(uint256)**
- **IERC7540Like::totalAssets()**
- **IShareLike::totalSupply()**

## State Variable Reads

- **MAX_ROUNDING_ERROR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_2(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC7540Properties._diff(uint256,uint256) (NodeID: 1)
      💬 Args: [IERC7540Like(erc7540Target).convertToShares(IERC7540Like(erc7540Target).totalAssets()), IShareLike(IERC7540Like(erc7540Target).share()).totalSupply()]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev 7540-2	convertToShares(totalAssets) == totalSupply unless price is 0.0
