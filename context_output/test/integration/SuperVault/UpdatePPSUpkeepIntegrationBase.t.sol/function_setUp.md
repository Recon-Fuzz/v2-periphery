# Function: setUp()

**Contract**: [test/integration/SuperVault/UpdatePPSUpkeepIntegrationBase.t.sol/contract_UpdatePPSUpkeepIntegrationBaseTest.md]

## Metadata

- **Contract**: UpdatePPSUpkeepIntegrationBaseTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 4589:3907:584

## Implementation

```solidity
function setUp() public {
    vm.createSelectFork(vm.envString("BASE_RPC_URL"), FORK_BLOCK);
    deployer = makeAddr("deployer");
    manager = makeAddr("manager");
    treasury = makeAddr("treasury");
    validator1 = vm.addr(validator1PrivateKey);
    validator2 = vm.addr(validator2PrivateKey);
    vm.startPrank(deployer);
    governor = SuperGovernor(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(deployer, deployer, deployer, deployer, deployer, deployer, treasury, false))})));
    address vaultImpl = address(SuperVault(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(governor)))}))));
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(governor)))}))));
    address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
    aggregator = SuperVaultAggregator(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(governor), vaultImpl, strategyImpl, escrowImpl))})));
    superBank = SuperBank(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperBank.sol:SuperBank", _args: encodeArgs442(DeployHelper442.FoundryPpConstructorArgs(address(governor)))})));
    fixedPriceOracle = FixedPriceOracle(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/FixedPriceOracle.sol:FixedPriceOracle", _args: encodeArgs594(DeployHelper594.FoundryPpConstructorArgs(INITIAL_WETH_PRICE, WETH_PRICE_DECIMALS, deployer))})));
    gasPriceOracle = FixedPriceOracle(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/FixedPriceOracle.sol:FixedPriceOracle", _args: encodeArgs594(DeployHelper594.FoundryPpConstructorArgs(GAS_PRICE_GWEI, GAS_PRICE_DECIMALS, deployer))})));
    _deploySuperOracle();
    ecdsaOracle = ECDSAPPSOracle(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle", _args: encodeArgs478(DeployHelper478.FoundryPpConstructorArgs(address(governor), "ECDSAPPS", "1"))})));
    _configureGovernor();
    _createVaultAndStrategy();
    transferHook = new TransferERC20Hook();
    governor.registerHook(address(transferHook));
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
- **Source**: 8502:1386:584
- **Link**: `test/integration/SuperVault/UpdatePPSUpkeepIntegrationBase.t.sol:UpdatePPSUpkeepIntegrationBaseTest:_deploySuperOracle()`

```solidity
function _deploySuperOracle() internal {
    address[] memory bases = new address[](3);
    address[] memory quotes = new address[](3);
    bytes32[] memory providers = new bytes32[](3);
    address[] memory feeds = new address[](3);
    bases[0] = GAS_QUOTE;
    quotes[0] = WEI_QUOTE;
    providers[0] = PROVIDER_SUPERFORM;
    feeds[0] = address(gasPriceOracle);
    bases[1] = NATIVE_TOKEN;
    quotes[1] = USD_TOKEN;
    providers[1] = PROVIDER_CHAINLINK;
    feeds[1] = ORACLE_ETH_USD_BASE;
    bases[2] = WETH_BASE;
    quotes[2] = USD_TOKEN;
    providers[2] = PROVIDER_SUPERFORM;
    feeds[2] = address(fixedPriceOracle);
    superOracle = SuperOracleL2(payable(VmContractHelper597(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracleL2.sol:SuperOracleL2", _args: encodeArgs596(DeployHelper596.FoundryPpConstructorArgs(address(governor), bases, quotes, providers, feeds))})));
}
```

### _configureGovernor()

- **Kind**: internal
- **Source**: 9894:2742:584
- **Link**: `test/integration/SuperVault/UpdatePPSUpkeepIntegrationBase.t.sol:UpdatePPSUpkeepIntegrationBaseTest:_configureGovernor()`

```solidity
function _configureGovernor() internal {
    governor.setAddress(governor.SUPER_VAULT_AGGREGATOR(), address(aggregator));
    governor.setAddress(governor.SUPER_ORACLE(), address(superOracle));
    {
        address[] memory dataOracles = new address[](3);
        dataOracles[0] = address(gasPriceOracle);
        dataOracles[1] = ORACLE_ETH_USD_BASE;
        dataOracles[2] = address(fixedPriceOracle);
        address[] memory uptimeOracles = new address[](3);
        uptimeOracles[0] = ORACLE_SEQUENCER_UPTIME_BASE;
        uptimeOracles[1] = ORACLE_SEQUENCER_UPTIME_BASE;
        uptimeOracles[2] = ORACLE_SEQUENCER_UPTIME_BASE;
        uint256[] memory gracePeriods = new uint256[](3);
        gracePeriods[0] = 3600;
        gracePeriods[1] = 3600;
        gracePeriods[2] = 3600;
        governor.batchSetOracleUptimeFeed(dataOracles, uptimeOracles, gracePeriods);
    }
    governor.setAddress(governor.SUPER_BANK(), address(superBank));
    governor.setAddress(governor.UPKEEP_TOKEN(), WETH_BASE);
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
    address[] memory feedAddresses = new address[](3);
    feedAddresses[0] = address(gasPriceOracle);
    feedAddresses[1] = ORACLE_ETH_USD_BASE;
    feedAddresses[2] = address(fixedPriceOracle);
    uint256[] memory staleness = new uint256[](3);
    staleness[0] = 30 days;
    staleness[1] = 30 days;
    staleness[2] = 30 days;
    governor.setOracleFeedMaxStalenessBatch(feedAddresses, staleness);
}
```

### _createVaultAndStrategy()

- **Kind**: internal
- **Source**: 12642:687:584
- **Link**: `test/integration/SuperVault/UpdatePPSUpkeepIntegrationBase.t.sol:UpdatePPSUpkeepIntegrationBaseTest:_createVaultAndStrategy()`

```solidity
function _createVaultAndStrategy() internal {
    (, address strat, ) = aggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: USDC_BASE, name: "Test Vault Base", symbol: "TVB", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: treasury})}));
    strategy = strat;
}
```

## External Calls

- **Vm::createSelectFork(string,uint256)**
- **Vm::envString(string)**
- **Vm::addr(uint256)**
- **Vm::startPrank(address)**
- **VmContractHelper597::deployCode(string,bytes)**
- **VmContractHelper597::deployCode(string)**
- **SuperGovernor::registerHook(address)**
- **Vm::stopPrank()**

## State Variable Reads

- **FORK_BLOCK** (`uint256`)
- **validator1PrivateKey** (`uint256`)
- **validator2PrivateKey** (`uint256`)
- **deployer** (`address`)
- **treasury** (`address`)
- **governor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **INITIAL_WETH_PRICE** (`int256`)
- **WETH_PRICE_DECIMALS** (`uint8`)
- **GAS_PRICE_GWEI** (`int256`)
- **GAS_PRICE_DECIMALS** (`uint8`)
- **transferHook** (`contract TransferERC20Hook`) [lib/v2-core/src/hooks/tokens/erc20/TransferERC20Hook.sol/contract_TransferERC20Hook.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **GAS_QUOTE** (`address`)
- **WEI_QUOTE** (`address`)
- **PROVIDER_SUPERFORM** (`bytes32`)
- **gasPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **NATIVE_TOKEN** (`address`)
- **USD_TOKEN** (`address`)
- **PROVIDER_CHAINLINK** (`bytes32`)
- **ORACLE_ETH_USD_BASE** (`address`)
- **WETH_BASE** (`address`)
- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **superOracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **ORACLE_SEQUENCER_UPTIME_BASE** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **validator1** (`address`)
- **validator2** (`address`)
- **ecdsaOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **GAS_PER_ENTRY** (`uint256`)
- **USDC_BASE** (`address`)
- **manager** (`address`)

## State Variable Writes

- **deployer** (`address`)
- **manager** (`address`)
- **treasury** (`address`)
- **validator1** (`address`)
- **validator2** (`address`)
- **governor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **fixedPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **gasPriceOracle** (`contract FixedPriceOracle`) [src/oracles/FixedPriceOracle.sol/contract_FixedPriceOracle.md]
- **ecdsaOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **transferHook** (`contract TransferERC20Hook`) [lib/v2-core/src/hooks/tokens/erc20/TransferERC20Hook.sol/contract_TransferERC20Hook.md]
- **superOracle** (`contract SuperOracleL2`) [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]
- **strategy** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationBaseTest.setUp() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationBaseTest._deploySuperOracle() (NodeID: 7)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationBaseTest._configureGovernor() (NodeID: 8)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: UpdatePPSUpkeepIntegrationBaseTest._createVaultAndStrategy() (NodeID: 9)
      💬 Args: [no args]
      👁️  Def: internal
```
