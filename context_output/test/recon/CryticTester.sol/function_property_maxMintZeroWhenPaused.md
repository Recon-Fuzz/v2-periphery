# Function: property_maxMintZeroWhenPaused()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `property_maxMintZeroWhenPaused()`
- **Visibility**: public
- **Source Range**: 2913:319:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property: maxMint should be 0 when aggregator is paused
function property_maxMintZeroWhenPaused() public {
    bool paused = superVaultAggregator.isStrategyPaused(address(superVaultStrategy));
    uint256 maxMint = superVault.maxMint(_getActor());
    if (paused) {
        eq(maxMint, 0, "actor has nonzero maxMint when strategy is paused");
    }
}
```

## Related Implementations

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:70
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

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

## External Calls

- **UnsafeSuperVaultAggregator::isStrategyPaused(address)**
- **SuperVault::maxMint(address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.property_maxMintZeroWhenPaused() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CryticAsserts.eq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [maxMint, 0, "actor has nonzero maxMint when strategy is paused"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: maxMint should be 0 when aggregator is paused
