# Function: test_OracleUpdateManagement_CancelOracleProviderRemoval()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `test_OracleUpdateManagement_CancelOracleProviderRemoval()`
- **Visibility**: public
- **Source Range**: 117552:1930:659

## Implementation

```solidity
function test_OracleUpdateManagement_CancelOracleProviderRemoval() public {
    address[] memory bases = new address[](1);
    bases[0] = address(asset);
    address[] memory quotes = new address[](1);
    quotes[0] = address(asset);
    bytes32 provider1 = bytes32(keccak256("Provider 1"));
    bytes32[] memory providers = new bytes32[](1);
    providers[0] = provider1;
    address[] memory feeds = new address[](1);
    feeds[0] = makeAddr("feed1");
    SuperOracle superOracle = SuperOracle(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracle.sol:SuperOracle", _args: encodeArgs447(DeployHelper447.FoundryPpConstructorArgs(address(superGovernor), bases, quotes, providers, feeds))})));
    bytes32 oracleKey = superGovernor.SUPER_ORACLE();
    vm.prank(sGovernor);
    superGovernor.setAddress(oracleKey, address(superOracle));
    bytes32[] memory providersToRemove = new bytes32[](1);
    providersToRemove[0] = provider1;
    vm.prank(address(superGovernor));
    superOracle.queueProviderRemoval(providersToRemove);
    bytes32[] memory activeProvidersBefore = superOracle.getActiveProviders();
    assertEq(activeProvidersBefore.length, 1, "Should have 1 provider before cancellation");
    vm.prank(oracleManager);
    vm.expectEmit(true, false, false, false);
    emit ISuperOracle.ProviderRemovalCancelled(providersToRemove);
    superGovernor.cancelOracleProviderRemoval();
    bytes32[] memory activeProvidersAfter = superOracle.getActiveProviders();
    assertEq(activeProvidersAfter.length, 1, "Should still have 1 provider after cancellation");
}
```

## Related Implementations

### makeAddr(string)

- **Kind**: internal
- **Source**: 20760:125:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20479:242:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
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

- **VmContractHelper692::deployCode(string,bytes)**
- **SuperGovernor::SUPER_ORACLE()**
- **Vm::prank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperOracle::queueProviderRemoval(bytes32[])**
- **SuperOracle::getActiveProviders()**
- **Vm::expectEmit(bool,bool,bool,bool)**
- **SuperGovernor::cancelOracleProviderRemoval()**

## State Variable Reads

- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **sGovernor** (`address`)
- **oracleManager** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.test_OracleUpdateManagement_CancelOracleProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["feed1"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [activeProvidersBefore.length, 1, "Should have 1 provider before cancellation"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
      💬 Args: [activeProvidersAfter.length, 1, "Should still have 1 provider after cancellation"]
      👁️  Def: internal
```
