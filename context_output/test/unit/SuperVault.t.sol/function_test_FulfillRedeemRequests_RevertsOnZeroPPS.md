# Function: test_FulfillRedeemRequests_RevertsOnZeroPPS()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_FulfillRedeemRequests_RevertsOnZeroPPS()`
- **Visibility**: public
- **Source Range**: 94963:1285:660

## Implementation

```solidity
/// @notice Tests fulfillRedeemRequests reverts when PPS is 0
///  @dev Covers SuperVaultStrategy.sol:333
function test_FulfillRedeemRequests_RevertsOnZeroPPS() public {
    address testUser = _deployAccount(0xABC, "TestUser");
    address[] memory controllers = new address[](1);
    controllers[0] = testUser;
    uint256[] memory totalAssetsOut = new uint256[](1);
    totalAssetsOut[0] = 100e18;
    bytes32 strategyDataSlot = bytes32(uint256(1));
    bytes32 ppsStorageSlot = keccak256(abi.encode(address(strategy), strategyDataSlot));
    uint256 currentPPS = strategy.getStoredPPS();
    assertGt(currentPPS, 0, "PPS should be initialized to a non-zero value");
    vm.store(address(superVaultAggregator), ppsStorageSlot, bytes32(uint256(0)));
    uint256 corruptedPPS = strategy.getStoredPPS();
    assertEq(corruptedPPS, 0, "PPS should be corrupted to 0");
    vm.prank(manager);
    vm.expectRevert(ISuperVaultStrategy.INVALID_PPS.selector);
    strategy.fulfillRedeemRequests(controllers, totalAssetsOut);
}
```

## Related Implementations

### _deployAccount(uint256,string)

- **Kind**: internal
- **Source**: 3858:217:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_deployAccount(uint256,string)`

```solidity
function _deployAccount(uint256 key_, string memory name_) internal returns (address) {
    address _user = vm.addr(key_);
    vm.deal(_user, LARGE);
    vm.label(_user, name_);
    return _user;
}
```

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

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

- **SuperVaultStrategy::getStoredPPS()**
- **Vm::store(address,bytes32,bytes32)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperVaultStrategy::fulfillRedeemRequests(address[],uint256[])**

## State Variable Reads

- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_FulfillRedeemRequests_RevertsOnZeroPPS() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xABC, "TestUser"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [currentPPS, 0, "PPS should be initialized to a non-zero value"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [corruptedPPS, 0, "PPS should be corrupted to 0"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests fulfillRedeemRequests reverts when PPS is 0
 @dev Covers SuperVaultStrategy.sol:333
