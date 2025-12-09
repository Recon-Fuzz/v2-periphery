# Function: property_comparePreviewDepositAndConvertToShares(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_comparePreviewDepositAndConvertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 7989:423:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: convertToShares is >= previewDepositShares (equivalent without fees)
function property_comparePreviewDepositAndConvertToShares(uint256 assets) public {
    uint256 previewDepositShares = superVault.previewDeposit(assets);
    uint256 convertToShares = superVault.convertToShares(assets);
    gte(convertToShares, previewDepositShares, "convertToShares is higher than or equal to previewDepositShares (equivalent without fees)");
}
```

## Related Implementations

### gte(uint256,uint256,string)

- **Kind**: internal
- **Source**: 347:182:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:gte(uint256,uint256,string)`

```solidity
function gte(uint256 a, uint256 b, string memory reason) virtual override internal {
    if (!(a >= b)) {
        emit Log(reason);
        assert(false);
    }
}
```

## External Calls

- **SuperVault::previewDeposit(uint256)**
- **SuperVault::convertToShares(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_comparePreviewDepositAndConvertToShares(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: CryticAsserts.gte(uint256,uint256,string) (NodeID: 1)
      💬 Args: [convertToShares, previewDepositShares, "convertToShares is higher than or equal to previewDepositShares (equivalent without fees)"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: convertToShares is >= previewDepositShares (equivalent without fees)
