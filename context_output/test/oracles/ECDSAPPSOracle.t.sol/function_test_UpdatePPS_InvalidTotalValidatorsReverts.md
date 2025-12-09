# Function: test_UpdatePPS_InvalidTotalValidatorsReverts()

**Contract**: [test/oracles/ECDSAPPSOracle.t.sol/contract_ECDSAPPSOracleTest.md]

## Metadata

- **Contract**: ECDSAPPSOracleTest
- **Signature**: `test_UpdatePPS_InvalidTotalValidatorsReverts()`
- **Visibility**: public
- **Source Range**: 27993:3616:622

## Implementation

```solidity
/// @notice Tests that updatePPS reverts when there are no validators configured
///  @dev Covers ECDSAPPSOracle.sol:97 - if (cachedTotalValidators == 0) revert INVALID_TOTAL_VALIDATORS()
function test_UpdatePPS_InvalidTotalValidatorsReverts() public {
    address freshGovernor = _deployAccount(0xFFF, "FreshGovernor");
    SuperGovernor noValidatorGovernor = SuperGovernor(payable(VmContractHelper620(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(freshGovernor, freshGovernor, freshGovernor, freshGovernor, freshGovernor, freshGovernor, TREASURY, false))})));
    address vaultImpl = address(SuperVault(payable(VmContractHelper620(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(noValidatorGovernor)))}))));
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper620(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(noValidatorGovernor)))}))));
    address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper620(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
    SuperVaultAggregator freshAggregator = SuperVaultAggregator(payable(VmContractHelper620(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(noValidatorGovernor), vaultImpl, strategyImpl, escrowImpl))})));
    ECDSAPPSOracle freshOracle = ECDSAPPSOracle(payable(VmContractHelper620(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle", _args: encodeArgs478(DeployHelper478.FoundryPpConstructorArgs(address(noValidatorGovernor), ECDSAPPS_ORACLE_KEY, ECDSAPPS_ORACLE_VERSION))})));
    vm.startPrank(freshGovernor);
    noValidatorGovernor.grantRole(noValidatorGovernor.SUPER_GOVERNOR_ROLE(), freshGovernor);
    noValidatorGovernor.setAddress(noValidatorGovernor.SUPER_VAULT_AGGREGATOR(), address(freshAggregator));
    noValidatorGovernor.proposeActivePPSOracle(address(freshOracle));
    vm.warp(block.timestamp + 7 days);
    noValidatorGovernor.executeActivePPSOracleChange();
    vm.stopPrank();
    address[] memory strategies = new address[](1);
    strategies[0] = address(svStrategy);
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = new bytes[](1);
    proofsArray[0][0] = abi.encodePacked(bytes32(0));
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = PPS;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = block.timestamp;
    vm.expectRevert(IECDSAPPSOracle.INVALID_TOTAL_VALIDATORS.selector);
    freshOracle.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
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

- **VmContractHelper620::deployCode(string,bytes)**
- **VmContractHelper620::deployCode(string)**
- **Vm::startPrank(address)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::SUPER_GOVERNOR_ROLE()**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::SUPER_VAULT_AGGREGATOR()**
- **SuperGovernor::proposeActivePPSOracle(address)**
- **Vm::warp(uint256)**
- **SuperGovernor::executeActivePPSOracleChange()**
- **Vm::stopPrank()**
- **Vm::expectRevert(bytes4)**
- **ECDSAPPSOracle::updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)**

## State Variable Reads

- **svStrategy** (`address`)
- **PPS** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ECDSAPPSOracleTest.test_UpdatePPS_InvalidTotalValidatorsReverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
      💬 Args: [0xFFF, "FreshGovernor"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Tests that updatePPS reverts when there are no validators configured
 @dev Covers ECDSAPPSOracle.sol:97 - if (cachedTotalValidators == 0) revert INVALID_TOTAL_VALIDATORS()
