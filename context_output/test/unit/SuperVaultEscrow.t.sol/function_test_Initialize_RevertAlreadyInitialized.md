# Function: test_Initialize_RevertAlreadyInitialized()

**Contract**: [test/unit/SuperVaultEscrow.t.sol/contract_SuperVaultEscrowTest.md]

## Metadata

- **Contract**: SuperVaultEscrowTest
- **Signature**: `test_Initialize_RevertAlreadyInitialized()`
- **Visibility**: public
- **Source Range**: 1446:313:662

## Implementation

```solidity
/// @notice Tests that initialize reverts when already initialized
function test_Initialize_RevertAlreadyInitialized() public {
    escrow.initialize(vault);
    vm.expectRevert(ISuperVaultEscrow.ALREADY_INITIALIZED.selector);
    escrow.initialize(vault);
}
```

## External Calls

- **SuperVaultEscrow::initialize(address)**
- **Vm::expectRevert(bytes4)**

## State Variable Reads

- **escrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **vault** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTest.test_Initialize_RevertAlreadyInitialized() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that initialize reverts when already initialized
