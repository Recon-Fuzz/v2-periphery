# Function: crytic_erc7540_7_withdraw(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `crytic_erc7540_7_withdraw(uint256)`
- **Visibility**: public
- **Source Range**: 16612:208:630
- **Inherited From**: Properties

## Implementation

```solidity
function crytic_erc7540_7_withdraw(uint256 amt) public {
    actor = _getActor();
    t(erc7540_7_withdraw(address(superVault), amt), "ERC7540-7: withdraw should not revert when amount <= max");
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

### erc7540_7_withdraw(address,uint256)

- **Kind**: internal
- **Source**: 10392:551:10
- **Link**: `lib/erc7540-reusable-properties/src/ERC7540Properties.sol:ERC7540Properties:erc7540_7_withdraw(address,uint256)`

```solidity
function erc7540_7_withdraw(address erc7540Target, uint256 amt) virtual public returns (bool) {
    uint256 maxWithdraw = IERC7540Like(erc7540Target).maxWithdraw(actor);
    amt = between(amt, 0, maxWithdraw);
    if (amt == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).withdraw(amt, actor, actor) {
        return true;
    } catch {
        return false;
    }
}
```

### between(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 933:269:68
- **Link**: `lib/setup-helpers/lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:between(uint256,uint256,uint256)`

```solidity
function between(uint256 value, uint256 low, uint256 high) virtual override internal returns (uint256) {
    if ((value < low) || (value > high)) {
        uint256 ans = low + (value % ((high - low) + 1));
        return ans;
    }
    return value;
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
┌─ [0] ⚙️ FUNCTION: Properties.crytic_erc7540_7_withdraw(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.t(bool,string) (NodeID: 2)
      💬 Args: [erc7540_7_withdraw(address(superVault), amt), "ERC7540-7: withdraw should not revert when amount <= max"]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC7540Properties.erc7540_7_withdraw(address,uint256) (NodeID: 4)
    │   💬 Args: [address(superVault), amt]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 5)
    │     💬 Args: [amt, 0, maxWithdraw]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
        💬 Args: [b, reason]
        👁️  Def: internal
```
