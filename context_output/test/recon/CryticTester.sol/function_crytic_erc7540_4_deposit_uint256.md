# Function: crytic_erc7540_4_deposit(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `crytic_erc7540_4_deposit(uint256)`
- **Visibility**: public
- **Source Range**: 15431:201:630
- **Inherited From**: Properties

## Implementation

```solidity
/// @dev Property 7540-4: claiming more than max always reverts
function crytic_erc7540_4_deposit(uint256 amt) public {
    actor = _getActor();
    t(erc7540_4_deposit(address(superVault), amt), "ERC7540-4: deposit with more than max should revert");
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

### erc7540_4_deposit(address,uint256)

- **Kind**: internal
- **Source**: 4702:802:10
- **Link**: `lib/erc7540-reusable-properties/src/ERC7540Properties.sol:ERC7540Properties:erc7540_4_deposit(address,uint256)`

```solidity
/// @dev 7540-4 claiming more than max always reverts
function erc7540_4_deposit(address erc7540Target, uint256 amt) virtual public returns (bool) {
    if (amt == 0) {
        return true;
    }
    uint256 maxDep = IERC7540Like(erc7540Target).maxDeposit(actor);
    /// @custom:audit No Revert is proven by erc7540_5
    uint256 sum = maxDep + amt;
    if (sum == 0) {
        return true;
    }
    try IERC7540Like(erc7540Target).deposit(maxDep + amt, actor) {
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
┌─ [0] ⚙️ FUNCTION: Properties.crytic_erc7540_4_deposit(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: CryticAsserts.t(bool,string) (NodeID: 2)
      💬 Args: [erc7540_4_deposit(address(superVault), amt), "ERC7540-4: deposit with more than max should revert"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC7540Properties.erc7540_4_deposit(address,uint256) (NodeID: 3)
        💬 Args: [address(superVault), amt]
        👁️  Def: public
```

## Documentation

### Function Documentation

@dev Property 7540-4: claiming more than max always reverts
