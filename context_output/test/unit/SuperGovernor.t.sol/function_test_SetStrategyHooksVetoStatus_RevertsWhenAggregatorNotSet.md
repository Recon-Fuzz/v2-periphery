# Function: test_SetStrategyHooksVetoStatus_RevertsWhenAggregatorNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_SetStrategyHooksVetoStatus_RevertsWhenAggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 43428:761:659

## Implementation

```solidity
/// @notice Tests setStrategyHooksRootVetoStatus reverts when aggregator is not set
///  @dev Covers SuperGovernor.sol:239-240 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
function test_SetStrategyHooksVetoStatus_RevertsWhenAggregatorNotSet() public {
    address freshSGovernor = _deployAccount(0xF9, "FreshSuperGovernor5");
    SuperGovernor freshGovernor = SuperGovernor(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(freshSGovernor, governor, governor, governor, governor, guardian, treasury, false))})));
    vm.prank(guardian);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    freshGovernor.setStrategyHooksRootVetoStatus(strategy1, true);
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
- **SuperGovernor::setStrategyHooksRootVetoStatus(address,bool)**

## State Variable Reads

- **governor** (`address`)
- **guardian** (`address`)
- **treasury** (`address`)
- **strategy1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_SetStrategyHooksVetoStatus_RevertsWhenAggregatorNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0xF9, "FreshSuperGovernor5"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests setStrategyHooksRootVetoStatus reverts when aggregator is not set
 @dev Covers SuperGovernor.sol:239-240 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
