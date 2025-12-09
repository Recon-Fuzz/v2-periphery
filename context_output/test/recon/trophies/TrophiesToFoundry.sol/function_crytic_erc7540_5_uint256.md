# Function: crytic_erc7540_5(uint256)

**Contract**: [test/recon/trophies/TrophiesToFoundry.sol/contract_TrophiesToFoundry.md]

## Metadata

- **Contract**: TrophiesToFoundry
- **Signature**: `crytic_erc7540_5(uint256)`
- **Visibility**: public
- **Source Range**: 16343:263:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property 7540-5: requestRedeem reverts if the share balance is less than amount
function crytic_erc7540_5(uint256 shares) public {
    actor = _getActor();
    t(erc7540_5(address(superVault), address(superVault), shares), "ERC7540-5: requestRedeem should revert if insufficient share balance");
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

### t(bool,string)

- **Kind**: internal
- **Source**: 822:105:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:t(bool,string)`

```solidity
function t(bool b, string memory reason) virtual override internal {
    assertTrue(b, reason);
}
```

### erc7540_5(address,address,uint256)

- **Kind**: internal
- **Source**: 7838:739:10
- **Link**: `lib/erc7540-reusable-properties/src/ERC7540Properties.sol:ERC7540Properties:erc7540_5(address,address,uint256)`

```solidity
/// @dev 7540-5	requestRedeem reverts if the share balance is less than amount
function erc7540_5(address erc7540Target, address shareToken, uint256 shares) virtual public returns (bool) {
    if (shares == 0) {
        return true;
    }
    uint256 actualBal = IShareLike(shareToken).balanceOf(actor);
    uint256 balWeWillUse = actualBal + shares;
    if (balWeWillUse == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).requestRedeem(balWeWillUse, actor, actor, "") {
        return false;
    } catch {
        return true;
    }
}
```

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
    }
}
```

## State Variable Reads

- **_actor** (`address`)
- **actor** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.crytic_erc7540_5(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.t(bool,string) (NodeID: 2)
      💬 Args: [erc7540_5(address(superVault), address(superVault), shares), "ERC7540-5: requestRedeem should revert if insufficient share balance"]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC7540Properties.erc7540_5(address,address,uint256) (NodeID: 4)
    │   💬 Args: [address(superVault), address(superVault), shares]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
        💬 Args: [b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property 7540-5: requestRedeem reverts if the share balance is less than amount
