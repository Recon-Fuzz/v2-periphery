# Function: doomsday_previewMintEquivalence(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `doomsday_previewMintEquivalence(uint256)`
- **Visibility**: public
- **Source Range**: 1383:330:647
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Property: previewMint and mint equivalence
function doomsday_previewMintEquivalence(uint256 shares) public {
    uint256 previewMintAssets = superVault.previewMint(shares);
    vm.prank(_getActor());
    uint256 assetsActualMint = superVault.mint(shares, _getActor());
    eq(previewMintAssets, assetsActualMint, "previewMint and mint equivalence");
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

- **SuperVault::previewMint(uint256)**
- **Vm::prank(address)**
- **SuperVault::mint(uint256,address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets.doomsday_previewMintEquivalence(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CryticAsserts.eq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [previewMintAssets, assetsActualMint, "previewMint and mint equivalence"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: previewMint and mint equivalence
