# Function: test_SuperBank_distribute_RevenueShareLargeValue()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_distribute_RevenueShareLargeValue()`
- **Visibility**: public
- **Source Range**: 12079:1012:658

## Implementation

```solidity
/// @notice Tests distribute reverts with large revenueShare value
///  @dev Covers SuperBank.sol:65 - tests with significantly higher value than BPS_PRECISION
function test_SuperBank_distribute_RevenueShareLargeValue() public {
    address supToken = address(0xF);
    vm.startPrank(sGovernor);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), address(this));
    superGovernor.setAddress(superGovernor.UP(), address(up));
    superGovernor.setAddress(superGovernor.SUP_STRATEGY(), supToken);
    superGovernor.setAddress(superGovernor.TREASURY(), treasury);
    vm.stopPrank();
    vm.warp(block.timestamp + (4 * 365 days));
    uint256 upAmount = 100 ether;
    vm.startPrank(admin);
    up.mint(address(superBank), upAmount);
    vm.stopPrank();
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getFee(uint8)", uint8(FeeType.REVENUE_SHARE)), abi.encode(uint256(100_000)));
    vm.expectRevert(ISuperBank.INVALID_REVENUE_SHARE.selector);
    superBank.distribute(upAmount);
}
```

## External Calls

- **Vm::startPrank(address)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::UP()**
- **SuperGovernor::SUP_STRATEGY()**
- **SuperGovernor::TREASURY()**
- **Vm::stopPrank()**
- **Vm::warp(uint256)**
- **Up::mint(address,uint256)**
- **Vm::mockCall(address,bytes,bytes)**
- **Vm::expectRevert(bytes4)**
- **SuperBank::distribute(uint256)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **up** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **treasury** (`address`)
- **admin** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_distribute_RevenueShareLargeValue() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@notice Tests distribute reverts with large revenueShare value
 @dev Covers SuperBank.sol:65 - tests with significantly higher value than BPS_PRECISION
