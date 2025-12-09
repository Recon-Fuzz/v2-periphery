# Function: erc7540_1(address)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `erc7540_1(address)`
- **Visibility**: public
- **Source Range**: 2667:521:10
- **Inherited From**: ERC7540Properties

## Implementation

```solidity
/// @dev 7540-1	convertToAssets(totalSupply) == totalAssets unless price is 0.0
function erc7540_1(address erc7540Target) virtual public returns (bool) {
    if (IERC7540Like(erc7540Target).convertToAssets(10 ** IShareLike(IERC7540Like(erc7540Target).share()).decimals()) == 0) return true;
    return IERC7540Like(erc7540Target).convertToAssets(IShareLike(IERC7540Like(erc7540Target).share()).totalSupply()) == IERC7540Like(erc7540Target).totalAssets();
}
```

## External Calls

- **IERC7540Like::convertToAssets(uint256)**
- **IShareLike::decimals()**
- **IERC7540Like::share()**
- **IShareLike::totalSupply()**
- **IERC7540Like::totalAssets()**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC7540Properties.erc7540_1(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev 7540-1	convertToAssets(totalSupply) == totalAssets unless price is 0.0
