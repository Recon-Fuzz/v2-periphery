# Function: property_fulfillOnlyBurnsRequestedAmount()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_fulfillOnlyBurnsRequestedAmount()`
- **Visibility**: public
- **Source Range**: 10754:760:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: redemptions only burn the requested amount of shares (within tolerance range)
function property_fulfillOnlyBurnsRequestedAmount() public {
    if (_currentOp == OpType.FULFILL) {
        uint256 pendingRedeemDelta = _before.summedPendingRedeem - _after.summedPendingRedeem;
        uint256 totalSupplyDelta = _before.summedTotalShares - _after.summedTotalShares;
        if (totalSupplyDelta < pendingRedeemDelta) {
            gte(totalSupplyDelta, pendingRedeemDelta, "burned less than requested beyond tolerance");
        } else {
            lte(totalSupplyDelta, pendingRedeemDelta, "burned more than requested beyond tolerance");
        }
    }
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

### lte(uint256,uint256,string)

- **Kind**: internal
- **Source**: 721:182:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:lte(uint256,uint256,string)`

```solidity
function lte(uint256 a, uint256 b, string memory reason) virtual override internal {
    if (!(a <= b)) {
        emit Log(reason);
        assert(false);
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_fulfillOnlyBurnsRequestedAmount() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: CryticAsserts.gte(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [totalSupplyDelta, pendingRedeemDelta, "burned less than requested beyond tolerance"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CryticAsserts.lte(uint256,uint256,string) (NodeID: 2)
      💬 Args: [totalSupplyDelta, pendingRedeemDelta, "burned more than requested beyond tolerance"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: redemptions only burn the requested amount of shares (within tolerance range)
