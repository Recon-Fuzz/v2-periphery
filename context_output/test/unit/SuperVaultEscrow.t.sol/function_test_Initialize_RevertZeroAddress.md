# Function: test_Initialize_RevertZeroAddress()

**Contract**: [test/unit/SuperVaultEscrow.t.sol/contract_SuperVaultEscrowTest.md]

## Metadata

- **Contract**: SuperVaultEscrowTest
- **Signature**: `test_Initialize_RevertZeroAddress()`
- **Visibility**: public
- **Source Range**: 1205:164:662

## Implementation

```solidity
/// @notice Tests that initialize reverts when called with zero address
function test_Initialize_RevertZeroAddress() public {
    vm.expectRevert(ISuperVaultEscrow.ZERO_ADDRESS.selector);
    escrow.initialize(address(0));
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **SuperVaultEscrow::initialize(address)**

## State Variable Reads

- **escrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTest.test_Initialize_RevertZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that initialize reverts when called with zero address
