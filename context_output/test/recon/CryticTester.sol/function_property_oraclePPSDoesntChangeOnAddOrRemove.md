# Function: property_oraclePPSDoesntChangeOnAddOrRemove()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_oraclePPSDoesntChangeOnAddOrRemove()`
- **Visibility**: public
- **Source Range**: 725:244:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: oracle PPS doesn't change on deposit/mint/redeem/withdraw
function property_oraclePPSDoesntChangeOnAddOrRemove() public {
    if ((_currentOp == OpType.ADD) || (_currentOp == OpType.REMOVE)) {
        eq(_before.oraclePPS, _after.oraclePPS, "deposit/withdrawal changes oracle PPS");
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
┌─ [0] ⚙️ FUNCTION: Properties.property_oraclePPSDoesntChangeOnAddOrRemove() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: CryticAsserts.eq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [_before.oraclePPS, _after.oraclePPS, "deposit/withdrawal changes oracle PPS"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: oracle PPS doesn't change on deposit/mint/redeem/withdraw
