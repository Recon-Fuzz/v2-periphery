# Function: doomsday_previewMintEquivalence(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
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
- **Source**: 695:121:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:eq(uint256,uint256,string)`

```solidity
function eq(uint256 a, uint256 b, string memory reason) virtual override internal {
    assertEq(a, b, reason);
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperVault::previewMint(uint256)**
- **Vm::prank(address)**
- **SuperVault::mint(uint256,address)**

## State Variable Reads

- **_actor** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

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
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.eq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [previewMintAssets, assetsActualMint, "previewMint and mint equivalence"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
        💬 Args: [a, b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property: previewMint and mint equivalence
