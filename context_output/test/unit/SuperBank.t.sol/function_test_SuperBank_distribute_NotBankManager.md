# Function: test_SuperBank_distribute_NotBankManager()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_distribute_NotBankManager()`
- **Visibility**: public
- **Source Range**: 6217:314:658

## Implementation

```solidity
/// @notice Tests distribute reverts when caller is not bank manager
///  @dev Covers SuperBank.sol:36-37 - access control check in _onlyBankManager
function test_SuperBank_distribute_NotBankManager() public {
    vm.startPrank(user);
    vm.expectRevert(ISuperBank.INVALID_BANK_MANAGER.selector);
    superBank.distribute(100 ether);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperBank::distribute(uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_distribute_NotBankManager() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests distribute reverts when caller is not bank manager
 @dev Covers SuperBank.sol:36-37 - access control check in _onlyBankManager
