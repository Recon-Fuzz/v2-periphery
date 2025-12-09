# Function: superVaultEscrow_initialize(address)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `superVaultEscrow_initialize(address)`
- **Visibility**: public
- **Source Range**: 784:132:652
- **Inherited From**: SuperVaultEscrowTargets

## Implementation

```solidity
function superVaultEscrow_initialize(address vaultAddress) public asActor() {
    superVaultEscrow.initialize(vaultAddress);
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

- **SuperVaultEscrow::initialize(address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTargets.superVaultEscrow_initialize(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
