# Function: crytic_erc7540_5(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
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
- **Source**: 1096:159:67
- **Link**: `lib/setup-helpers/lib/chimera/src/CryticAsserts.sol:CryticAsserts:t(bool,string)`

```solidity
function t(bool b, string memory reason) virtual override internal {
    if (!b) {
        emit Log(reason);
        assert(false);
    }
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

## State Variable Reads

- **_actor** (`address`)
- **actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Properties.crytic_erc7540_5(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CryticAsserts.t(bool,string) (NodeID: 2)
      💬 Args: [erc7540_5(address(superVault), address(superVault), shares), "ERC7540-5: requestRedeem should revert if insufficient share balance"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC7540Properties.erc7540_5(address,address,uint256) (NodeID: 3)
        💬 Args: [address(superVault), address(superVault), shares]
        👁️  Def: public
```

## Documentation

### Function Documentation

@dev Property 7540-5: requestRedeem reverts if the share balance is less than amount
