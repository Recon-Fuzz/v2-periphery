# Function: test_SuperBank_distribute_TreasuryAmountGreaterThanZero()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_distribute_TreasuryAmountGreaterThanZero()`
- **Visibility**: public
- **Source Range**: 19994:1479:658

## Implementation

```solidity
/// @notice Tests distribute when treasuryAmount is greater than zero
///  @dev Covers SuperBank.sol:80 - if (treasuryAmount > 0) branch when treasuryAmount > 0
function test_SuperBank_distribute_TreasuryAmountGreaterThanZero() public {
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
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getFee(uint8)", uint8(FeeType.REVENUE_SHARE)), abi.encode(uint256(3000)));
    uint256 initialSupBalance = up.balanceOf(supToken);
    uint256 initialTreasuryBalance = up.balanceOf(treasury);
    superBank.distribute(upAmount);
    uint256 expectedSupAmount = 30 ether;
    uint256 expectedTreasuryAmount = 70 ether;
    assertEq(up.balanceOf(supToken), initialSupBalance + expectedSupAmount, "sUP token should receive 30%");
    assertEq(up.balanceOf(treasury), initialTreasuryBalance + expectedTreasuryAmount, "Treasury should receive 70%");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
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
- **Up::balanceOf(address)**
- **SuperBank::distribute(uint256)**

## State Variable Reads

- **sGovernor** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **up** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **treasury** (`address`)
- **admin** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_distribute_TreasuryAmountGreaterThanZero() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [up.balanceOf(supToken), initialSupBalance + expectedSupAmount, "sUP token should receive 30%"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [up.balanceOf(treasury), initialTreasuryBalance + expectedTreasuryAmount, "Treasury should receive 70%"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests distribute when treasuryAmount is greater than zero
 @dev Covers SuperBank.sol:80 - if (treasuryAmount > 0) branch when treasuryAmount > 0
