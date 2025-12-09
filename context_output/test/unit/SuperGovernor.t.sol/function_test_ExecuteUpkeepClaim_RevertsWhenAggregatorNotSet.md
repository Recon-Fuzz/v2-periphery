# Function: test_ExecuteUpkeepClaim_RevertsWhenAggregatorNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ExecuteUpkeepClaim_RevertsWhenAggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 46500:887:659

## Implementation

```solidity
/// @notice Tests executeUpkeepClaim reverts when aggregator is not set
///  @dev Covers SuperGovernor.sol:513 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
function test_ExecuteUpkeepClaim_RevertsWhenAggregatorNotSet() public {
    address freshSGovernor = _deployAccount(0xF7, "FreshSuperGovernor6");
    address freshGovernor2 = _deployAccount(0xF6, "FreshGovernor2");
    SuperGovernor freshGovernor = SuperGovernor(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(freshSGovernor, freshGovernor2, freshGovernor2, freshGovernor2, freshGovernor2, guardian, treasury, false))})));
    uint256 claimAmount = 1000;
    vm.prank(freshGovernor2);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    freshGovernor.executeUpkeepClaim(claimAmount);
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

## External Calls

- **VmContractHelper692::deployCode(string,bytes)**
- **Vm::prank(address)**
- **Vm::expectRevert(bytes4)**
- **SuperGovernor::executeUpkeepClaim(uint256)**

## State Variable Reads

- **guardian** (`address`)
- **treasury** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ExecuteUpkeepClaim_RevertsWhenAggregatorNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xF7, "FreshSuperGovernor6"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [0xF6, "FreshGovernor2"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests executeUpkeepClaim reverts when aggregator is not set
 @dev Covers SuperGovernor.sol:513 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
