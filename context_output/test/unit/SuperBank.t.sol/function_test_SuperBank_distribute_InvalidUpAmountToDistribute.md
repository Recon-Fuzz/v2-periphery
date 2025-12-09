# Function: test_SuperBank_distribute_InvalidUpAmountToDistribute()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_distribute_InvalidUpAmountToDistribute()`
- **Visibility**: public
- **Source Range**: 6832:597:658

## Implementation

```solidity
function test_SuperBank_distribute_InvalidUpAmountToDistribute() public {
    vm.startPrank(sGovernor);
    vm.stopPrank();
    vm.startPrank(sGovernor);
    superGovernor.grantRole(keccak256("BANK_MANAGER_ROLE"), address(this));
    superGovernor.setAddress(keccak256("UP"), address(up));
    superGovernor.setAddress(keccak256("SUP"), address(this));
    superGovernor.setAddress(keccak256("TREASURY"), address(treasury));
    vm.stopPrank();
    vm.expectRevert(ISuperBank.INVALID_UP_AMOUNT_TO_DISTRIBUTE.selector);
    superBank.distribute(1e6);
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::stopPrank()**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **Vm::expectRevert(bytes4)**
- **SuperBank::distribute(uint256)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **up** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **treasury** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_distribute_InvalidUpAmountToDistribute() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
