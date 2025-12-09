# Function: test_ReturnAssets_RevertZeroAddress()

**Contract**: [test/unit/SuperVaultEscrow.t.sol/contract_SuperVaultEscrowTest.md]

## Metadata

- **Contract**: SuperVaultEscrowTest
- **Signature**: `test_ReturnAssets_RevertZeroAddress()`
- **Visibility**: public
- **Source Range**: 5298:310:662

## Implementation

```solidity
/// @notice Tests that returnAssets reverts when to address is zero
function test_ReturnAssets_RevertZeroAddress() public {
    escrow.initialize(vault);
    vm.prank(vault);
    vm.expectRevert(ISuperVaultEscrow.ZERO_ADDRESS.selector);
    escrow.returnAssets(address(0), 100);
}
```

## External Calls

- **SuperVaultEscrow::initialize(address)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultEscrow::returnAssets(address,uint256)**

## State Variable Reads

- **escrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **vault** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultEscrowTest.test_ReturnAssets_RevertZeroAddress() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests that returnAssets reverts when to address is zero
