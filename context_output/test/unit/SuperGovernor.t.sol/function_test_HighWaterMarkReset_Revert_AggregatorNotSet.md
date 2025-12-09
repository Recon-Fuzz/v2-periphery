# Function: test_HighWaterMarkReset_Revert_AggregatorNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_HighWaterMarkReset_Revert_AggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 28979:810:659

## Implementation

```solidity
/// @notice Tests resetting the high-water mark PPS to the current PPS when the aggregator is not set
function test_HighWaterMarkReset_Revert_AggregatorNotSet() public {
    address freshSGovernor = _deployAccount(0xFF, "FreshSuperGovernor");
    SuperGovernor freshGovernor = SuperGovernor(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(freshSGovernor, governor, governor, governor, governor, governor, treasury, false))})));
    vm.prank(freshSGovernor);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    freshGovernor.resetHighWaterMark(strategy1);
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
- **SuperGovernor::resetHighWaterMark(address)**

## State Variable Reads

- **governor** (`address`)
- **treasury** (`address`)
- **strategy1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_HighWaterMarkReset_Revert_AggregatorNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0xFF, "FreshSuperGovernor"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests resetting the high-water mark PPS to the current PPS when the aggregator is not set
