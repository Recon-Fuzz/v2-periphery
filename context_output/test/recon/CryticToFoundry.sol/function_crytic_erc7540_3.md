# Function: crytic_erc7540_3()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `crytic_erc7540_3()`
- **Visibility**: public
- **Source Range**: 15194:163:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property 7540-3: max* never reverts
function crytic_erc7540_3() public {
    actor = _getActor();
    t(erc7540_3(address(superVault)), "ERC7540-3: max* functions should never revert");
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

### erc7540_3(address)

- **Kind**: internal
- **Source**: 4062:548:10
- **Link**: `lib/erc7540-reusable-properties/src/ERC7540Properties.sol:ERC7540Properties:erc7540_3(address)`

```solidity
/// @dev 7540-3	max* never reverts
function erc7540_3(address erc7540Target) virtual public returns (bool) {
    try IERC7540Like(erc7540Target).maxDeposit(actor) {} catch {
        return false;
    }
    try IERC7540Like(erc7540Target).maxMint(actor) {} catch {
        return false;
    }
    try IERC7540Like(erc7540Target).maxRedeem(actor) {} catch {
        return false;
    }
    try IERC7540Like(erc7540Target).maxWithdraw(actor) {} catch {
        return false;
    }
    return true;
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
┌─ [0] ⚙️ FUNCTION: Properties.crytic_erc7540_3() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FoundryAsserts.t(bool,string) (NodeID: 2)
      💬 Args: [erc7540_3(address(superVault)), "ERC7540-3: max* functions should never revert"]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ERC7540Properties.erc7540_3(address) (NodeID: 4)
    │   💬 Args: [address(superVault)]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 3)
        💬 Args: [b, reason]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Property 7540-3: max* never reverts
