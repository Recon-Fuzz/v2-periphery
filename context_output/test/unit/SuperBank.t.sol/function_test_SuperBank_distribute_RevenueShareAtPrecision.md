# Function: test_SuperBank_distribute_RevenueShareAtPrecision()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `test_SuperBank_distribute_RevenueShareAtPrecision()`
- **Visibility**: public
- **Source Range**: 10381:1525:658

## Implementation

```solidity
/// @notice Tests distribute succeeds when revenueShare equals BPS_PRECISION
///  @dev Covers SuperBank.sol:65 - boundary condition where revenueShare == BPS_PRECISION (10,000)
function test_SuperBank_distribute_RevenueShareAtPrecision() public {
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
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getFee(uint8)", uint8(FeeType.REVENUE_SHARE)), abi.encode(uint256(10_000)));
    uint256 expectedSupAmount = upAmount;
    uint256 expectedTreasuryAmount = 0;
    vm.expectEmit(true, true, true, true);
    emit ISuperBank.RevenueDistributed(address(up), supToken, treasury, expectedSupAmount, expectedTreasuryAmount);
    superBank.distribute(upAmount);
    assertEq(up.balanceOf(supToken), expectedSupAmount, "sUP token should receive 100% of distribution");
    assertEq(up.balanceOf(treasury), expectedTreasuryAmount, "Treasury should receive 0%");
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
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperBank::distribute(uint256)**
- **Up::balanceOf(address)**

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
┌─ [0] ⚙️ FUNCTION: SuperBankTest.test_SuperBank_distribute_RevenueShareAtPrecision() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [up.balanceOf(supToken), expectedSupAmount, "sUP token should receive 100% of distribution"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [up.balanceOf(treasury), expectedTreasuryAmount, "Treasury should receive 0%"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests distribute succeeds when revenueShare equals BPS_PRECISION
 @dev Covers SuperBank.sol:65 - boundary condition where revenueShare == BPS_PRECISION (10,000)
