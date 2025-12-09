# Function: setUp()

**Contract**: [test/integration/SuperVault/UpdatePPSUpkeepIntegration.t.sol/contract_UpdatePPSUpkeepIntegrationTest.md]

## Metadata

- **Contract**: UpdatePPSUpkeepIntegrationTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 3435:2997:583

## Implementation

```solidity
function setUp() public {
    vm.createSelectFork(vm.envString("ETHEREUM_RPC_URL"), FORK_BLOCK);
    deployer = makeAddr("deployer");
    manager = makeAddr("manager");
    treasury = makeAddr("treasury");
    validator1 = vm.addr(validator1PrivateKey);
    validator2 = vm.addr(validator2PrivateKey);
    vm.startPrank(deployer);
    upToken = new MockUp(deployer);
    governor = SuperGovernor(payable(VmContractHelper595(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(deployer, deployer, deployer, deployer, deployer, deployer, treasury, false))})));
    address vaultImpl = address(SuperVault(payable(VmContractHelper595(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(governor)))}))));
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper595(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(governor)))}))));
    address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper595(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
    aggregator = SuperVaultAggregator(payable(VmContractHelper595(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(governor), vaultImpl, strategyImpl, escrowImpl))})));
    fixedPriceOracle = FixedPriceOracle(payable(VmContractHelper595(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/FixedPriceOracle.sol:FixedPriceOracle", _args: encodeArgs594(DeployHelper594.FoundryPpConstructorArgs(INITIAL_UP_PRICE, UP_PRICE_DECIMALS, deployer))})));
    _deploySuperOracle();
    ecdsaOracle = ECDSAPPSOracle(payable(VmContractHelper595(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle", _args: encodeArgs478(DeployHelper478.FoundryPpConstructorArgs(address(governor), "ECDSAPPS", "1"))})));
    _configureGovernor();
    _createVaultAndStrategy();
    vm.stopPrank();
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

### _deploySuperOracle()

- **Kind**: internal
- **Source**: 6438:1271:583
- **Link**: `test/integration/SuperVault/UpdatePPSUpkeepIntegration.t.sol:UpdatePPSUpkeepIntegrationTest:_deploySuperOracle()`

```solidity
function _deploySuperOracle() internal {
    address[] memory bases = new address[](3);
    address[] memory quotes = new address[](3);
    bytes32[] memory providers = new bytes32[](3);
    address[] memory feeds = new address[](3);
    bases[0] = GAS_QUOTE;
    quotes[0] = WEI_QUOTE;
    providers[0] = PROVIDER_CHAINLINK;
    feeds[0] = ORACLE_GAS_TO_ETH;
    bases[1] = NATIVE_TOKEN;
    quotes[1] = USD_TOKEN;
    providers[1] = PROVIDER_CHAINLINK;
    feeds[1] = ORACLE_ETH_USD_MAINNET;
    bases[2] = address(upToken);
    quotes[2] = USD_TOKEN;
    providers[2] = PROVIDER_SUPERFORM;
    feeds[2] = address(fixedPriceOracle);
    superOracle = SuperOracle(payable(VmContractHelper595(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracle.sol:SuperOracle", _args: encodeArgs447(DeployHelper447.FoundryPpConstructorArgs(address(governor), bases, quotes, providers, feeds))})));
}
```

### _configureGovernor()

- **Kind**: internal
- **Source**: 7715:2032:583
- **Link**: `test/integration/SuperVault/UpdatePPSUpkeepIntegration.t.sol:UpdatePPSUpkeepIntegrationTest:_configureGovernor()`

```solidity
function _configureGovernor() internal {
    governor.setAddress(governor.SUPER_VAULT_AGGREGATOR(), address(aggregator));
    governor.setAddress(governor.SUPER_ORACLE(), address(superOracle));
    governor.setAddress(governor.UP(), address(upToken));
    governor.setAddress(governor.UPKEEP_TOKEN(), address(upToken));
    address[] memory validators = new address[](2);
    validators[0] = validator1;
    validators[1] = validator2;
    bytes[] memory publicKeys = new bytes[](2);
    publicKeys[0] = "";
    publicKeys[1] = "";
    governor.setValidatorConfig(1, validators, publicKeys, 2, "");
    governor.setGasInfo(address(ecdsaOracle), GAS_PER_ENTRY);
    governor.proposeActivePPSOracle(address(ecdsaOracle));
    vm.warp(block.timestamp + 7 days);
    governor.executeActivePPSOracleChange();
    governor.proposeUpkeepPaymentsChange(true);
    vm.warp(block.timestamp + 8 days);
    governor.executeUpkeepPaymentsChange();
    governor.setOracleMaxStaleness(30 days);
    address[] memory feeds = new address[](3);
    feeds[0] = ORACLE_GAS_TO_ETH;
    feeds[1] = ORACLE_ETH_USD_MAINNET;
    feeds[2] = address(fixedPriceOracle);
    uint256[] memory staleness = new uint256[](3);
    staleness[0] = 30 days;
    staleness[1] = 30 days;
    staleness[2] = 30 days;
    governor.setOracleFeedMaxStalenessBatch(feeds, staleness);
}
```

### _createVaultAndStrategy()

- **Kind**: internal
- **Source**: 9753:735:583
- **Link**: `test/integration/SuperVault/UpdatePPSUpkeepIntegration.t.sol:UpdatePPSUpkeepIntegrationTest:_createVaultAndStrategy()`

```solidity
function _createVaultAndStrategy() internal {
    address usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    (, address strat, ) = aggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: usdc, name: "Test Vault", symbol: "TV", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: treasury})}));
    strategy = strat;
}
```

## External Calls

- **Vm::createSelectFork(string,uint256)**
- **Vm::envString(string)**
- **Vm::addr(uint256)**
- **Vm::startPrank(address)**
- **VmContractHelper595::deployCode(string,bytes)**
- **VmContractHelper595::deployCode(string)**
- **Vm::stopPrank()**

## State Variable Reads

- **FORK_BLOCK** (`uint256`)
- **validator1PrivateKey** (`uint256`)
- **validator2PrivateKey** (`uint256`)
- **deployer** (`address`)
- **treasury** (`address`)
- **governor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **INITIAL_UP_PRICE** (`int256`)
- **UP_PRICE_DECIMALS** (`uint8`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **GAS_QUOTE** (`address`)
- **WEI_QUOTE** (`address`)
- **PROVIDER_CHAINLINK** (`bytes32`)
- **ORACLE_GAS_TO_ETH** (`address`)
- **NATIVE_TOKEN** (`address`)
- **USD_TOKEN** (`address`)
- **ORACLE_ETH_USD_MAINNET** (`address`)
- **upToken** (`contract MockUp`) [test/mocks/MockUp.sol/contract_MockUp.md]
- **PROVIDER_SUPERFORM** (`bytes32`)
- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **validator1** (`address`)
- **validator2** (`address`)
- **ecdsaOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **GAS_PER_ENTRY** (`uint256`)
- **manager** (`address`)

## State Variable Writes

- **deployer** (`address`)
- **manager** (`address`)
- **treasury** (`address`)
- **validator1** (`address`)
- **validator2** (`address`)
- **upToken** (`contract MockUp`) [test/mocks/MockUp.sol/contract_MockUp.md]
- **governor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **ecdsaOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["deployer"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 3)
  │   💬 Args: ["manager"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 4)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 5)
  │   💬 Args: ["treasury"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 6)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._deploySuperOracle() (NodeID: 7)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._configureGovernor() (NodeID: 8)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationTest._createVaultAndStrategy() (NodeID: 9)
      💬 Args: [no args]
      👁️  Def: internal
```
