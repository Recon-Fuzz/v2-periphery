# Function: superVault_invalidateNonce(bytes32)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `superVault_invalidateNonce(bytes32)`
- **Visibility**: public
- **Source Range**: 3965:116:654
- **Inherited From**: SuperVaultTargets

## Implementation

```solidity
function superVault_invalidateNonce(bytes32 nonce) public asActor() {
    superVault.invalidateNonce(nonce);
}
```

## Related Implementations

### asActor()

- **Kind**: modifier
- **Source**: 5892:77:631
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
}
```

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

## External Calls

- **SuperVault::invalidateNonce(bytes32)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTargets.superVault_invalidateNonce(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
