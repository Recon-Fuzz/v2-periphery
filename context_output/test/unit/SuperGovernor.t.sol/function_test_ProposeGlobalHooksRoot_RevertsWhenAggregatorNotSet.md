# Function: test_ProposeGlobalHooksRoot_RevertsWhenAggregatorNotSet()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_ProposeGlobalHooksRoot_RevertsWhenAggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 38439:1010:659

## Implementation

```solidity
/// @notice Tests proposeGlobalHooksRoot reverts when aggregator is not set
///  @dev Covers SuperGovernor.sol:221-222 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
function test_ProposeGlobalHooksRoot_RevertsWhenAggregatorNotSet() public {
    address freshSGovernor = _deployAccount(0xFD, "FreshSuperGovernor3");
    address freshGovernor2 = _deployAccount(0xFC, "FreshGovernor");
    SuperGovernor freshGovernor = SuperGovernor(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(freshSGovernor, freshGovernor2, freshGovernor2, freshGovernor2, freshGovernor2, guardian, treasury, false))})));
    bytes32 newRoot = keccak256("new global hooks root");
    vm.prank(freshGovernor2);
    vm.expectRevert(ISuperGovernor.CONTRACT_NOT_FOUND.selector);
    freshGovernor.proposeGlobalHooksRoot(newRoot);
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
- **SuperGovernor::proposeGlobalHooksRoot(bytes32)**

## State Variable Reads

- **guardian** (`address`)
- **treasury** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_ProposeGlobalHooksRoot_RevertsWhenAggregatorNotSet() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0xFD, "FreshSuperGovernor3"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
      💬 Args: [0xFC, "FreshGovernor"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests proposeGlobalHooksRoot reverts when aggregator is not set
 @dev Covers SuperGovernor.sol:221-222 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
