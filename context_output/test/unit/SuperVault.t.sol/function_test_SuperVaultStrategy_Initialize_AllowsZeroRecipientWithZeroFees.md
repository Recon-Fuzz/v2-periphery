# Function: test_SuperVaultStrategy_Initialize_AllowsZeroRecipientWithZeroFees()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_SuperVaultStrategy_Initialize_AllowsZeroRecipientWithZeroFees()`
- **Visibility**: public
- **Source Range**: 48381:1616:660

## Implementation

```solidity
/// @notice Tests SuperVaultStrategy initialize allows address(0) recipient when both fees are 0
///  @dev This is allowed because recipient can be configured later via fee config update
function test_SuperVaultStrategy_Initialize_AllowsZeroRecipientWithZeroFees() public {
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    ISuperVaultStrategy.FeeConfig memory feeConfig = ISuperVaultStrategy.FeeConfig({performanceFeeBps: 0, managementFeeBps: 0, recipient: address(0)});
    bytes memory initData = abi.encodeWithSelector(SuperVaultStrategy.initialize.selector, address(vault), feeConfig);
    address proxyAddress = address(new ERC1967Proxy(strategyImpl, initData));
    assertTrue(proxyAddress != address(0), "Proxy should be deployed successfully");
    ISuperVaultStrategy.FeeConfig memory configResult = ISuperVaultStrategy(payable(proxyAddress)).getConfigInfo();
    assertEq(configResult.performanceFeeBps, 0, "Performance fee should be 0");
    assertEq(configResult.managementFeeBps, 0, "Management fee should be 0");
    assertEq(configResult.recipient, address(0), "Recipient should be address(0)");
}
```

## Related Implementations

### assertTrue(bool,string)

- **Kind**: internal
- **Source**: 1894:148:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertTrue(bool,string)`

```solidity
function assertTrue(bool data, string memory err) virtual internal pure {
    if (!data) {
        vm.assertTrue(data, err);
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

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **VmContractHelper702::deployCode(string,bytes)**
- **ISuperVaultStrategy::getConfigInfo()**

## State Variable Reads

- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_SuperVaultStrategy_Initialize_AllowsZeroRecipientWithZeroFees() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertTrue(bool,string) (NodeID: 1)
  │   💬 Args: [proxyAddress != address(0), "Proxy should be deployed successfully"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [configResult.performanceFeeBps, 0, "Performance fee should be 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [configResult.managementFeeBps, 0, "Management fee should be 0"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
      💬 Args: [configResult.recipient, address(0), "Recipient should be address(0)"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests SuperVaultStrategy initialize allows address(0) recipient when both fees are 0
 @dev This is allowed because recipient can be configured later via fee config update
