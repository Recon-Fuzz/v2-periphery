# Function: property_cancelDoesntChangeTotalSupply()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_cancelDoesntChangeTotalSupply()`
- **Visibility**: public
- **Source Range**: 3735:315:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: cancelRedeem should never alter the supply of SuperVault tokens
function property_cancelDoesntChangeTotalSupply() public {
    if (_currentOp == OpType.CANCEL) {
        eq(_before.summedTotalShares, _after.summedTotalShares, "cancelRedeem should never alter the supply of SuperVault tokens");
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
┌─ [0] ⚙️ FUNCTION: Properties.property_cancelDoesntChangeTotalSupply() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: CryticAsserts.eq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [_before.summedTotalShares, _after.summedTotalShares, "cancelRedeem should never alter the supply of SuperVault tokens"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: cancelRedeem should never alter the supply of SuperVault tokens
