# Function: property_totalSharesDontDecreaseOnRedemptionRequest()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_totalSharesDontDecreaseOnRedemptionRequest()`
- **Visibility**: public
- **Source Range**: 1693:317:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: requestRedeem should never reduce SuperVault shares
function property_totalSharesDontDecreaseOnRedemptionRequest() public {
    if (_currentOp == OpType.REQUEST) {
        eq(_before.summedTotalShares, _after.summedTotalShares, "requestRedeem should never reduce SuperVault shares");
    }
}
```

## Related Implementations

### eq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 909:181:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:eq(uint256,uint256,string)`

```solidity
function eq(uint256 a, uint256 b, string memory reason) virtual override internal {
    if (!(a == b)) {
        emit Log(reason);
        assert(false);
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_totalSharesDontDecreaseOnRedemptionRequest() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: CryticAsserts.eq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [_before.summedTotalShares, _after.summedTotalShares, "requestRedeem should never reduce SuperVault shares"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: requestRedeem should never reduce SuperVault shares
