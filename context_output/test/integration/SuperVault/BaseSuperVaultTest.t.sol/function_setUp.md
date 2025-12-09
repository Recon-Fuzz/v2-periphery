# Function: setUp()

**Contract**: [test/integration/SuperVault/BaseSuperVaultTest.t.sol/contract_BaseSuperVaultTest.md]

## Metadata

- **Contract**: BaseSuperVaultTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 6047:6609:576

## Implementation

```solidity
function setUp() virtual override public {
    super.setUp();
    console2.log("--- SETUP BASE SUPERVAULT ---");
    vm.selectFork(FORKS[ETH]);
    accInstances = randomAccountInstances[ETH];
    assertEq(accInstances.length, ACCOUNT_COUNT);
    superGovernor = SuperGovernor(_getContract(ETH, SUPER_GOVERNOR_KEY));
    asset = IERC20Metadata(existingUnderlyingTokens[ETH][USDC_KEY]);
    vm.label(address(asset), "[ETH][USDC_KEY]");
    asset5115 = IERC20Metadata(CHAIN_1_SUSDE);
    vm.label(address(asset5115), "CHAIN_1_SUSDE");
    aggregator = SuperVaultAggregator(_getContract(ETH, SUPER_VAULT_AGGREGATOR_KEY));
    upToken = address(new MockUp(address(this)));
    oracleEthToUsd = ORACLE_ETH_TO_USD;
    oracleUsdToUp = address(new MockChainlinkOracle());
    oracleGasToEth = ORACLE_GAS_TO_ETH;
    mockFeedWithRealDataEthToUsd = new MockFeedWithRealData(oracleEthToUsd);
    mockFeedWithRealDataGasToEth = new MockFeedWithRealData(oracleGasToEth);
    superOracle = ISuperOracle(_getContract(ETH, SUPER_ORACLE_KEY));
    (address vaultAddr, address strategyAddr, address escrowAddr) = _deployVault("SV_USDC");
    assertEq(strategyAddr, globalSVStrategy, "SV STRATEGY NOT EQUAL TO PREDICTED");
    bytes32 root = _getMerkleRoot();
    console2.log("[DEBUG] Proposing global hooks root from explicitly generated tree");
    superGovernor.proposeGlobalHooksRoot(root);
    vm.warp(block.timestamp + 20 minutes);
    aggregator.executeGlobalHooksRootUpdate();
    accountEth = accountInstances[ETH].account;
    instanceOnEth = accountInstances[ETH];
    accInstances = randomAccountInstances[ETH];
    superExecutorOnEth = ISuperExecutor(_getContract(ETH, SUPER_EXECUTOR_KEY));
    superLedgerETH = ISuperLedger(_getContract(ETH, SUPER_LEDGER_KEY));
    oracle = ERC7540YieldSourceOracle(_getContract(ETH, ERC7540_YIELD_SOURCE_ORACLE_KEY));
    ecdsappsOracle = IECDSAPPSOracle(_getContract(ETH, ECDSAPPS_ORACLE_KEY));
    superGovernor.proposeActivePPSOracle(address(ecdsappsOracle));
    vm.warp(block.timestamp + 7 days);
    superGovernor.executeActivePPSOracleChange();
    address fluidVaultAddr = 0x9Fb7b4477576Fe5B32be4C1843aFB1e55F251B33;
    address aaveVaultAddr = 0x73edDFa87C71ADdC275c2b9890f5c3a8480bC9E6;
    vm.label(fluidVaultAddr, "FluidVault");
    vm.label(aaveVaultAddr, "AaveVault");
    fluidVault = IERC4626(fluidVaultAddr);
    aaveVault = IERC4626(aaveVaultAddr);
    pendleEthenaAddress = realVaultAddresses[ETH][ERC5115_VAULT_KEY][PENDLE_ETHENA_KEY][SUSDE_KEY];
    vm.label(pendleEthenaAddress, "PendleEthena");
    pendleEthena = IStandardizedYield(pendleEthenaAddress);
    vault = SuperVault(vaultAddr);
    strategy = SuperVaultStrategy(payable(strategyAddr));
    escrow = SuperVaultEscrow(escrowAddr);
    totalAssetHelper = new TotalAssetHelper();
    _setFeeConfig(100, TREASURY);
    vm.startPrank(MANAGER);
    strategy.manageYieldSource(address(fluidVault), _getContract(ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    strategy.manageYieldSource(address(aaveVault), _getContract(ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    strategy.manageYieldSource(address(pendleEthenaAddress), _getContract(ETH, ERC5115_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    vm.stopPrank();
    validator1PrivateKey = 0x20;
    validator2PrivateKey = 0x30;
    validator3PrivateKey = 0x40;
    superGovernor.setAddress(superGovernor.UP(), upToken);
    superGovernor.setAddress(superGovernor.UPKEEP_TOKEN(), upToken);
    superGovernor.setAddress(superGovernor.SUPER_ORACLE(), address(superOracle));
    mockUSD = new MockERC20("Mock USD", "USD", 6);
    address[] memory bases = new address[](3);
    bases[0] = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
    bases[1] = address(upToken);
    bases[2] = address(uint160(uint256(keccak256("GAS_QUOTE"))));
    address[] memory quotes = new address[](3);
    quotes[0] = address(840);
    quotes[1] = address(840);
    quotes[2] = address(uint160(uint256(keccak256("WEI_QUOTE"))));
    bytes32[] memory providers = new bytes32[](3);
    providers[0] = "CHAINLINK";
    providers[1] = "CHAINLINK";
    providers[2] = "CHAINLINK";
    address[] memory feeds = new address[](3);
    feeds[0] = address(mockFeedWithRealDataEthToUsd);
    feeds[1] = oracleUsdToUp;
    feeds[2] = address(mockFeedWithRealDataGasToEth);
    superOracle.queueOracleUpdate(bases, quotes, providers, feeds);
    vm.warp(block.timestamp + 2 weeks);
    superOracle.executeOracleUpdate();
    uint256[] memory maxStaleness = new uint256[](3);
    maxStaleness[0] = 1 days;
    maxStaleness[1] = 1 days;
    maxStaleness[2] = 1 days;
    superOracle.setFeedMaxStalenessBatch(feeds, maxStaleness);
    superGovernor.setGasInfo(address(ecdsappsOracle), 10_000);
    rootManager = 0x0C1fDfd6a1331a875EA013F3897fc8a76ada5DfC;
    yieldSource7540AddressETH_USDC = realVaultAddresses[ETH][ERC7540_FULLY_ASYNC_KEY][CENTRIFUGE_USDC_VAULT_KEY][USDC_KEY];
    vm.label(yieldSource7540AddressETH_USDC, "CentrifugeUSDCVault");
    centrifugeVault = IERC7540(yieldSource7540AddressETH_USDC);
}
```

## Related Implementations

### setUp()

- **Kind**: internal
- **Source**: 3820:584:545
- **Link**: `test/BaseTest.t.sol:BaseTest:setUp()`

```solidity
function setUp() virtual override public {
    super.setUp();
    deployPeripheryAccounts();
    PeripheryAddresses[] memory PA = new PeripheryAddresses[](chainIds.length);
    PA = _deployPeripheryContracts(PA);
    _updateTreasuryInSuperLedgerConfiguration();
    _configurePeripheryGovernor(PA);
    _registerPeripheryHooks(PA);
}
```

### setUp()

- **Kind**: internal
- **Source**: 17537:787:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:setUp()`

```solidity
function setUp() virtual public {
    deployAccounts();
    _preDeploymentSetup();
    mockRegistry = new MockRegistry();
    vm.label(address(mockRegistry), "MockRegistry");
    vm.makePersistent(address(mockRegistry));
    Addresses[] memory A = new Addresses[](chainIds.length);
    A = _deployContracts(A);
    A = _deployHooks(A);
    if (!skipAccountsCreation) {
        _initializeAccounts(ACCOUNT_COUNT);
    }
    _setupSuperLedger();
    _fundUnderlyingTokens(1e18);
}
```

### deployAccounts()

- **Kind**: internal
- **Source**: 649:378:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:deployAccounts()`

```solidity
function deployAccounts() public {
    TREASURY = _deployAccount(TREASURY_KEY, "TREASURY");
    SUPER_BUNDLER = _deployAccount(SUPER_BUNDLER_KEY, "SUPER_BUNDLER");
    ACROSS_RELAYER = _deployAccount(ACROSS_RELAYER_KEY, "ACROSS_RELAYER");
    vm.label(ACROSS_RELAYER, "ACROSS_RELAYER");
    vm.makePersistent(ACROSS_RELAYER);
}
```

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

### _preDeploymentSetup()

- **Kind**: internal
- **Source**: 71170:9367:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_preDeploymentSetup()`

```solidity
function _preDeploymentSetup() internal {
    mapping(uint64 => uint256) storage forks = FORKS;
    if (useLatestFork) {
        forks[ETH] = vm.createFork(ETHEREUM_RPC_URL);
        forks[OP] = vm.createFork(OPTIMISM_RPC_URL);
        forks[BASE] = vm.createFork(BASE_RPC_URL);
    } else {
        forks[ETH] = vm.createFork(ETHEREUM_RPC_URL, ETH_BLOCK);
        forks[OP] = vm.createFork(OPTIMISM_RPC_URL, OP_BLOCK);
        forks[BASE] = vm.createFork(BASE_RPC_URL, BASE_BLOCK);
    }
    mapping(uint64 => string) storage rpcURLs = RPC_URLS;
    rpcURLs[ETH] = ETHEREUM_RPC_URL;
    rpcURLs[OP] = OPTIMISM_RPC_URL;
    rpcURLs[BASE] = BASE_RPC_URL;
    mapping(uint64 => address) storage spokePoolV3AddressesMap = SPOKE_POOL_V3_ADDRESSES;
    spokePoolV3AddressesMap[ETH] = spokePoolV3Addresses[0];
    vm.label(spokePoolV3AddressesMap[ETH], "SpokePoolV3ETH");
    spokePoolV3AddressesMap[OP] = spokePoolV3Addresses[1];
    vm.label(spokePoolV3AddressesMap[OP], "SpokePoolV3OP");
    spokePoolV3AddressesMap[BASE] = spokePoolV3Addresses[2];
    vm.label(spokePoolV3AddressesMap[BASE], "SpokePoolV3BASE");
    mapping(uint64 => address) storage debridgeDlnSourceAddressesMap = DEBRIDGE_DLN_ADDRESSES;
    debridgeDlnSourceAddressesMap[ETH] = DEBRIDGE_DLN_SOURCE_ADDRESS;
    vm.label(debridgeDlnSourceAddressesMap[ETH], "DebridgeDlnSourceETH");
    debridgeDlnSourceAddressesMap[OP] = DEBRIDGE_DLN_SOURCE_ADDRESS;
    vm.label(debridgeDlnSourceAddressesMap[OP], "DebridgeDlnSourceOP");
    debridgeDlnSourceAddressesMap[BASE] = DEBRIDGE_DLN_SOURCE_ADDRESS;
    vm.label(debridgeDlnSourceAddressesMap[BASE], "DebridgeDlnSourceBASE");
    mapping(uint64 => address) storage debridgeDlnSourceAddressesDstMap = DEBRIDGE_DLN_ADDRESSES_DST;
    debridgeDlnSourceAddressesDstMap[ETH] = DEBRIDGE_DLN_DST;
    vm.label(debridgeDlnSourceAddressesDstMap[ETH], "DebridgeDlnDstETH");
    debridgeDlnSourceAddressesDstMap[OP] = DEBRIDGE_DLN_DST;
    vm.label(debridgeDlnSourceAddressesDstMap[OP], "DebridgeDlnDstOP");
    debridgeDlnSourceAddressesDstMap[BASE] = DEBRIDGE_DLN_DST;
    vm.label(debridgeDlnSourceAddressesDstMap[BASE], "DebridgeDlnDstBASE");
    mapping(uint64 => address) storage pendleRouters = PENDLE_ROUTERS;
    pendleRouters[ETH] = CHAIN_1_PENDLE_ROUTER;
    vm.label(pendleRouters[ETH], "PendleRouterETH");
    pendleRouters[OP] = CHAIN_10_PENDLE_ROUTER;
    vm.label(pendleRouters[OP], "PendleRouterOP");
    pendleRouters[BASE] = CHAIN_8453_PENDLE_ROUTER;
    vm.label(pendleRouters[BASE], "PendleRouterBASE");
    mapping(uint64 => address) storage spectraRouters = SPECTRA_ROUTERS;
    spectraRouters[ETH] = CHAIN_1_SPECTRA_ROUTER;
    vm.label(spectraRouters[ETH], "SpectraRouterETH");
    spectraRouters[OP] = CHAIN_10_SPECTRA_ROUTER;
    vm.label(spectraRouters[OP], "SpectraRouterOP");
    spectraRouters[BASE] = CHAIN_8453_SPECTRA_ROUTER;
    vm.label(spectraRouters[BASE], "SpectraRouterBASE");
    mapping(uint64 => address) storage pendleSwaps = PENDLE_SWAP;
    pendleSwaps[ETH] = CHAIN_1_PENDLE_SWAP;
    vm.label(pendleSwaps[ETH], "PendleSwapETH");
    pendleSwaps[OP] = CHAIN_10_PENDLE_SWAP;
    vm.label(pendleSwaps[OP], "PendleSwapOP");
    pendleSwaps[BASE] = CHAIN_8453_PENDLE_SWAP;
    vm.label(pendleSwaps[BASE], "PendleSwapBASE");
    mapping(uint64 => address) storage odosRouters = ODOS_ROUTER;
    odosRouters[ETH] = CHAIN_1_ODOS_ROUTER;
    vm.label(odosRouters[ETH], "OdosRouterETH");
    odosRouters[OP] = CHAIN_10_ODOS_ROUTER;
    vm.label(odosRouters[OP], "OdosRouterOP");
    odosRouters[BASE] = CHAIN_8453_ODOS_ROUTER;
    vm.label(odosRouters[BASE], "OdosRouterBASE");
    mapping(uint64 => address) storage nexusFactoryAddressesMap = NEXUS_FACTORY_ADDRESSES;
    nexusFactoryAddressesMap[ETH] = CHAIN_1_NEXUS_FACTORY;
    vm.label(nexusFactoryAddressesMap[ETH], "NexusFactoryETH");
    nexusFactoryAddressesMap[OP] = CHAIN_10_NEXUS_FACTORY;
    vm.label(nexusFactoryAddressesMap[OP], "NexusFactoryOP");
    nexusFactoryAddressesMap[BASE] = CHAIN_8453_NEXUS_FACTORY;
    vm.label(nexusFactoryAddressesMap[BASE], "NexusFactoryBASE");
    /// @dev Setup existingUnderlyingTokens
    existingUnderlyingTokens[ETH][DAI_KEY] = CHAIN_1_DAI;
    existingUnderlyingTokens[ETH][USDC_KEY] = CHAIN_1_USDC;
    existingUnderlyingTokens[ETH][WETH_KEY] = CHAIN_1_WETH;
    existingUnderlyingTokens[ETH][SUSDE_KEY] = CHAIN_1_SUSDE;
    existingUnderlyingTokens[ETH][USDE_KEY] = CHAIN_1_USDE;
    existingUnderlyingTokens[ETH][WST_ETH_KEY] = CHAIN_1_WST_ETH;
    existingUnderlyingTokens[OP][DAI_KEY] = CHAIN_10_DAI;
    existingUnderlyingTokens[OP][USDC_KEY] = CHAIN_10_USDC;
    existingUnderlyingTokens[OP][WETH_KEY] = CHAIN_10_WETH;
    existingUnderlyingTokens[OP][USDCE_KEY] = CHAIN_10_USDCE;
    existingUnderlyingTokens[ETH][GEAR_KEY] = CHAIN_1_GEAR;
    existingUnderlyingTokens[ETH][SUSDE_KEY] = CHAIN_1_SUSDE;
    existingUnderlyingTokens[BASE][DAI_KEY] = CHAIN_8453_DAI;
    existingUnderlyingTokens[BASE][USDC_KEY] = CHAIN_8453_USDC;
    existingUnderlyingTokens[BASE][WETH_KEY] = CHAIN_8453_WETH;
    /// @dev Setup realVaultAddresses
    mapping(uint64 => mapping(string => mapping(string => mapping(string => address)))) storage existingVaults = realVaultAddresses;
    /// @dev Ethereum 4626 vault addresses
    existingVaults[1][ERC4626_VAULT_KEY][AAVE_VAULT_KEY][USDC_KEY] = CHAIN_1_AAVE_VAULT;
    vm.label(existingVaults[ETH][ERC4626_VAULT_KEY][AAVE_VAULT_KEY][USDC_KEY], AAVE_VAULT_KEY);
    existingVaults[1][ERC4626_VAULT_KEY][FLUID_VAULT_KEY][USDC_KEY] = CHAIN_1_FLUID_VAULT;
    vm.label(existingVaults[ETH][ERC4626_VAULT_KEY][FLUID_VAULT_KEY][USDC_KEY], FLUID_VAULT_KEY);
    existingVaults[1][ERC4626_VAULT_KEY][EULER_VAULT_KEY][USDC_KEY] = CHAIN_1_EULER_VAULT;
    vm.label(existingVaults[ETH][ERC4626_VAULT_KEY][EULER_VAULT_KEY][USDC_KEY], EULER_VAULT_KEY);
    existingVaults[1][ERC4626_VAULT_KEY][MORPHO_VAULT_KEY][USDC_KEY] = CHAIN_1_MORPHO_VAULT;
    vm.label(existingVaults[ETH][ERC4626_VAULT_KEY][MORPHO_VAULT_KEY][USDC_KEY], MORPHO_VAULT_KEY);
    /// @dev Optimism 4626vault addresses
    existingVaults[10][ERC4626_VAULT_KEY][ALOE_USDC_VAULT_KEY][USDCE_KEY] = CHAIN_10_ALOE_USDC;
    vm.label(existingVaults[OP][ERC4626_VAULT_KEY][ALOE_USDC_VAULT_KEY][USDCE_KEY], ALOE_USDC_VAULT_KEY);
    existingVaults[1][ERC4626_VAULT_KEY][GEARBOX_VAULT_KEY][USDC_KEY] = CHAIN_1_GEARBOX_VAULT;
    vm.label(existingVaults[ETH][ERC4626_VAULT_KEY][GEARBOX_VAULT_KEY][USDC_KEY], GEARBOX_VAULT_KEY);
    /// @dev Staking real gearbox staking on mainnet
    existingVaults[ETH][STAKING_YIELD_SOURCE_ORACLE_KEY][GEARBOX_STAKING_KEY][GEAR_KEY] = CHAIN_1_GEARBOX_STAKING;
    vm.label(existingVaults[ETH][STAKING_YIELD_SOURCE_ORACLE_KEY][GEARBOX_STAKING_KEY][GEAR_KEY], "GearboxStaking");
    /// @dev Base 4626 vault addresses
    existingVaults[BASE][ERC4626_VAULT_KEY][MORPHO_GAUNTLET_USDC_PRIME_KEY][USDC_KEY] = CHAIN_8453_MORPHO_GAUNTLET_USDC_PRIME;
    vm.label(existingVaults[BASE][ERC4626_VAULT_KEY][MORPHO_GAUNTLET_USDC_PRIME_KEY][USDC_KEY], MORPHO_GAUNTLET_USDC_PRIME_KEY);
    existingVaults[BASE][ERC4626_VAULT_KEY][SPARK_USDC_VAULT_KEY][USDC_KEY] = CHAIN_8453_SPARK_USDC_VAULT;
    vm.label(existingVaults[BASE][ERC4626_VAULT_KEY][SPARK_USDC_VAULT_KEY][USDC_KEY], SPARK_USDC_VAULT_KEY);
    existingVaults[BASE][ERC4626_VAULT_KEY][MORPHO_GAUNTLET_WETH_CORE_KEY][WETH_KEY] = CHAIN_8453_MORPHO_GAUNTLET_WETH_CORE;
    vm.label(existingVaults[BASE][ERC4626_VAULT_KEY][MORPHO_GAUNTLET_WETH_CORE_KEY][WETH_KEY], MORPHO_GAUNTLET_WETH_CORE_KEY);
    existingVaults[BASE][ERC4626_VAULT_KEY][AAVE_BASE_WETH][WETH_KEY] = CHAIN_8453_MORPHO_GAUNTLET_WETH_CORE;
    vm.label(existingVaults[BASE][ERC4626_VAULT_KEY][AAVE_BASE_WETH][WETH_KEY], AAVE_BASE_WETH);
    /// @dev 7540 real centrifuge vaults on mainnet
    existingVaults[ETH][ERC7540_FULLY_ASYNC_KEY][CENTRIFUGE_USDC_VAULT_KEY][USDC_KEY] = CHAIN_1_CENTRIFUGE_USDC;
    vm.label(existingVaults[ETH][ERC7540_FULLY_ASYNC_KEY][CENTRIFUGE_USDC_VAULT_KEY][USDC_KEY], CENTRIFUGE_USDC_VAULT_KEY);
    /// @dev 5115 real pendle ethena vault on mainnet
    existingVaults[ETH][ERC5115_VAULT_KEY][PENDLE_ETHENA_KEY][SUSDE_KEY] = CHAIN_1_PENDLE_ETHENA;
    vm.label(existingVaults[ETH][ERC5115_VAULT_KEY][PENDLE_ETHENA_KEY][SUSDE_KEY], "PendleEthena");
    for (uint256 i = 0; i < chainIds.length; ++i) {
        vm.selectFork(FORKS[chainIds[i]]);
        (validatorSigners[chainIds[i]], validatorSignerPrivateKeys[chainIds[i]]) = makeAddrAndKey("The signer");
        vm.label(validatorSigners[chainIds[i]], "The signer");
    }
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

### _deployContracts(struct Addresses[])

- **Kind**: internal
- **Source**: 21896:6663:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_deployContracts(struct Addresses[])`

```solidity
function _deployContracts(Addresses[] memory A) internal returns (Addresses[] memory) {
    for (uint256 i = 0; i < chainIds.length; ++i) {
        vm.selectFork(FORKS[chainIds[i]]);
        address acrossV3Helper = address(new AcrossV3Helper());
        vm.allowCheatcodes(acrossV3Helper);
        vm.makePersistent(acrossV3Helper);
        contractAddresses[chainIds[i]][ACROSS_V3_HELPER_KEY] = acrossV3Helper;
        address debridgeHelper = address(new DebridgeHelper());
        vm.allowCheatcodes(debridgeHelper);
        vm.makePersistent(debridgeHelper);
        contractAddresses[chainIds[i]][DEBRIDGE_HELPER_KEY] = debridgeHelper;
        address debridgeDlnHelper = address(new DebridgeDlnHelper());
        vm.allowCheatcodes(debridgeDlnHelper);
        vm.makePersistent(debridgeDlnHelper);
        contractAddresses[chainIds[i]][DEBRIDGE_DLN_HELPER_KEY] = debridgeDlnHelper;
        A[i].superLedgerConfiguration = ISuperLedgerConfiguration(address(new SuperLedgerConfiguration{salt: SALT}()));
        vm.label(address(A[i].superLedgerConfiguration), SUPER_LEDGER_CONFIGURATION_KEY);
        contractAddresses[chainIds[i]][SUPER_LEDGER_CONFIGURATION_KEY] = address(A[i].superLedgerConfiguration);
        A[i].superNativePaymaster = new SuperNativePaymaster{salt: SALT}(IEntryPoint(ENTRYPOINT_ADDR));
        vm.label(address(A[i].superNativePaymaster), SUPER_NATIVE_PAYMASTER_KEY);
        contractAddresses[chainIds[i]][SUPER_NATIVE_PAYMASTER_KEY] = address(A[i].superNativePaymaster);
        A[i].superMerkleValidator = new SuperValidator();
        vm.label(address(A[i].superMerkleValidator), SUPER_MERKLE_VALIDATOR_KEY);
        contractAddresses[chainIds[i]][SUPER_MERKLE_VALIDATOR_KEY] = address(A[i].superMerkleValidator);
        A[i].superDestinationValidator = new SuperDestinationValidator{salt: SALT}();
        vm.label(address(A[i].superDestinationValidator), SUPER_DESTINATION_VALIDATOR_KEY);
        contractAddresses[chainIds[i]][SUPER_DESTINATION_VALIDATOR_KEY] = address(A[i].superDestinationValidator);
        A[i].superExecutor = ISuperExecutor(address(new SuperExecutor{salt: SALT}(address(A[i].superLedgerConfiguration))));
        vm.label(address(A[i].superExecutor), SUPER_EXECUTOR_KEY);
        contractAddresses[chainIds[i]][SUPER_EXECUTOR_KEY] = address(A[i].superExecutor);
        MockLockVault lockVault = new MockLockVault();
        vm.label(address(lockVault), "MockLockVault");
        A[i].mockTargetExecutor = new MockTargetExecutor{salt: SALT}(address(A[i].superLedgerConfiguration), address(lockVault));
        vm.label(address(A[i].mockTargetExecutor), MOCK_TARGET_EXECUTOR_KEY);
        contractAddresses[chainIds[i]][MOCK_TARGET_EXECUTOR_KEY] = address(A[i].mockTargetExecutor);
        A[i].superDestinationExecutor = ISuperExecutor(address(new SuperDestinationExecutor{salt: SALT}(address(A[i].superLedgerConfiguration), address(A[i].superDestinationValidator))));
        vm.label(address(A[i].superDestinationExecutor), SUPER_DESTINATION_EXECUTOR_KEY);
        contractAddresses[chainIds[i]][SUPER_DESTINATION_EXECUTOR_KEY] = address(A[i].superDestinationExecutor);
        A[i].superSenderCreator = new SuperSenderCreator{salt: SALT}();
        vm.label(address(A[i].superSenderCreator), SUPER_SENDER_CREATOR_KEY);
        contractAddresses[chainIds[i]][SUPER_SENDER_CREATOR_KEY] = address(A[i].superSenderCreator);
        A[i].acrossV3Adapter = new AcrossV3Adapter{salt: SALT}(SPOKE_POOL_V3_ADDRESSES[chainIds[i]], address(A[i].superDestinationExecutor));
        vm.label(address(A[i].acrossV3Adapter), ACROSS_V3_ADAPTER_KEY);
        contractAddresses[chainIds[i]][ACROSS_V3_ADAPTER_KEY] = address(A[i].acrossV3Adapter);
        A[i].debridgeAdapter = new DebridgeAdapter{salt: SALT}(DEBRIDGE_DLN_DST, address(A[i].superDestinationExecutor));
        vm.label(address(A[i].debridgeAdapter), DEBRIDGE_ADAPTER_KEY);
        contractAddresses[chainIds[i]][DEBRIDGE_ADAPTER_KEY] = address(A[i].debridgeAdapter);
        address[] memory allowedExecutors = new address[](3);
        allowedExecutors[0] = address(A[i].superExecutor);
        allowedExecutors[1] = address(A[i].superDestinationExecutor);
        A[i].superLedger = ISuperLedger(address(new SuperLedger{salt: SALT}(address(A[i].superLedgerConfiguration), allowedExecutors)));
        vm.label(address(A[i].superLedger), SUPER_LEDGER_KEY);
        contractAddresses[chainIds[i]][SUPER_LEDGER_KEY] = address(A[i].superLedger);
        A[i].erc1155Ledger = ISuperLedger(address(new ERC5115Ledger{salt: SALT}(address(A[i].superLedgerConfiguration), allowedExecutors)));
        vm.label(address(A[i].erc1155Ledger), ERC1155_LEDGER_KEY);
        contractAddresses[chainIds[i]][ERC1155_LEDGER_KEY] = address(A[i].erc1155Ledger);
        /// @dev action oracles
        A[i].erc4626YieldSourceOracle = new ERC4626YieldSourceOracle(address(A[i].superLedgerConfiguration));
        vm.label(address(A[i].erc4626YieldSourceOracle), ERC4626_YIELD_SOURCE_ORACLE_KEY);
        contractAddresses[chainIds[i]][ERC4626_YIELD_SOURCE_ORACLE_KEY] = address(A[i].erc4626YieldSourceOracle);
        A[i].erc5115YieldSourceOracle = new ERC5115YieldSourceOracle(address(A[i].superLedgerConfiguration));
        vm.label(address(A[i].erc5115YieldSourceOracle), ERC5115_YIELD_SOURCE_ORACLE_KEY);
        contractAddresses[chainIds[i]][ERC5115_YIELD_SOURCE_ORACLE_KEY] = address(A[i].erc5115YieldSourceOracle);
        A[i].erc7540YieldSourceOracle = new ERC7540YieldSourceOracle(address(A[i].superLedgerConfiguration));
        vm.label(address(A[i].erc7540YieldSourceOracle), ERC7540_YIELD_SOURCE_ORACLE_KEY);
        contractAddresses[chainIds[i]][ERC7540_YIELD_SOURCE_ORACLE_KEY] = address(A[i].erc7540YieldSourceOracle);
        A[i].stakingYieldSourceOracle = new StakingYieldSourceOracle(address(A[i].superLedgerConfiguration));
        vm.label(address(A[i].stakingYieldSourceOracle), STAKING_YIELD_SOURCE_ORACLE_KEY);
        contractAddresses[chainIds[i]][STAKING_YIELD_SOURCE_ORACLE_KEY] = address(A[i].stakingYieldSourceOracle);
    }
    return A;
}
```

### _deployHooks(struct Addresses[])

- **Kind**: internal
- **Source**: 28565:39633:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_deployHooks(struct Addresses[])`

```solidity
function _deployHooks(Addresses[] memory A) internal returns (Addresses[] memory) {
    if (DEBUG) console2.log("---------------- DEPLOYING HOOKS ----------------");
    for (uint256 i = 0; i < chainIds.length; ++i) {
        vm.selectFork(FORKS[chainIds[i]]);
        address[] memory hooksAddresses = new address[](50);
        A[i].approveErc20Hook = new ApproveERC20Hook{salt: SALT}();
        vm.label(address(A[i].approveErc20Hook), APPROVE_ERC20_HOOK_KEY);
        hookAddresses[chainIds[i]][APPROVE_ERC20_HOOK_KEY] = address(A[i].approveErc20Hook);
        hooks[chainIds[i]][APPROVE_ERC20_HOOK_KEY] = Hook(APPROVE_ERC20_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.None, address(A[i].approveErc20Hook), "");
        hooksByCategory[chainIds[i]][HookCategory.TokenApprovals].push(hooks[chainIds[i]][APPROVE_ERC20_HOOK_KEY]);
        hooksAddresses[0] = address(A[i].approveErc20Hook);
        A[i].transferErc20Hook = new TransferERC20Hook{salt: SALT}();
        vm.label(address(A[i].transferErc20Hook), TRANSFER_ERC20_HOOK_KEY);
        hookAddresses[chainIds[i]][TRANSFER_ERC20_HOOK_KEY] = address(A[i].transferErc20Hook);
        hooks[chainIds[i]][TRANSFER_ERC20_HOOK_KEY] = Hook(TRANSFER_ERC20_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.TokenApprovals, address(A[i].transferErc20Hook), "");
        hooksByCategory[chainIds[i]][HookCategory.TokenApprovals].push(hooks[chainIds[i]][TRANSFER_ERC20_HOOK_KEY]);
        hooksAddresses[1] = address(A[i].transferErc20Hook);
        A[i].deposit4626VaultHook = new Deposit4626VaultHook{salt: SALT}();
        vm.label(address(A[i].deposit4626VaultHook), DEPOSIT_4626_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][DEPOSIT_4626_VAULT_HOOK_KEY] = address(A[i].deposit4626VaultHook);
        hooks[chainIds[i]][DEPOSIT_4626_VAULT_HOOK_KEY] = Hook(DEPOSIT_4626_VAULT_HOOK_KEY, HookCategory.VaultDeposits, HookCategory.TokenApprovals, address(A[i].deposit4626VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultDeposits].push(hooks[chainIds[i]][DEPOSIT_4626_VAULT_HOOK_KEY]);
        hooksAddresses[2] = address(A[i].deposit4626VaultHook);
        A[i].approveAndDeposit4626VaultHook = new ApproveAndDeposit4626VaultHook{salt: SALT}();
        vm.label(address(A[i].approveAndDeposit4626VaultHook), APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY] = address(A[i].approveAndDeposit4626VaultHook);
        hooks[chainIds[i]][APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY] = Hook(APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.VaultDeposits, address(A[i].approveAndDeposit4626VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultDeposits].push(hooks[chainIds[i]][APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]);
        hooksAddresses[3] = address(A[i].approveAndDeposit4626VaultHook);
        A[i].redeem4626VaultHook = new Redeem4626VaultHook{salt: SALT}();
        vm.label(address(A[i].redeem4626VaultHook), REDEEM_4626_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][REDEEM_4626_VAULT_HOOK_KEY] = address(A[i].redeem4626VaultHook);
        hooks[chainIds[i]][REDEEM_4626_VAULT_HOOK_KEY] = Hook(REDEEM_4626_VAULT_HOOK_KEY, HookCategory.VaultWithdrawals, HookCategory.VaultDeposits, address(A[i].redeem4626VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultWithdrawals].push(hooks[chainIds[i]][REDEEM_4626_VAULT_HOOK_KEY]);
        hooksAddresses[4] = address(A[i].redeem4626VaultHook);
        A[i].deposit5115VaultHook = new Deposit5115VaultHook{salt: SALT}();
        vm.label(address(A[i].deposit5115VaultHook), DEPOSIT_5115_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][DEPOSIT_5115_VAULT_HOOK_KEY] = address(A[i].deposit5115VaultHook);
        hooks[chainIds[i]][DEPOSIT_5115_VAULT_HOOK_KEY] = Hook(DEPOSIT_5115_VAULT_HOOK_KEY, HookCategory.VaultDeposits, HookCategory.TokenApprovals, address(A[i].deposit5115VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultDeposits].push(hooks[chainIds[i]][DEPOSIT_5115_VAULT_HOOK_KEY]);
        hooksAddresses[5] = address(A[i].deposit5115VaultHook);
        A[i].approveAndDeposit5115VaultHook = new ApproveAndDeposit5115VaultHook{salt: SALT}();
        vm.label(address(A[i].approveAndDeposit5115VaultHook), APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY] = address(A[i].approveAndDeposit5115VaultHook);
        hooks[chainIds[i]][APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY] = Hook(APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.VaultDeposits, address(A[i].approveAndDeposit5115VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultDeposits].push(hooks[chainIds[i]][APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY]);
        hooksAddresses[6] = address(A[i].approveAndDeposit5115VaultHook);
        A[i].redeem5115VaultHook = new Redeem5115VaultHook{salt: SALT}();
        vm.label(address(A[i].redeem5115VaultHook), REDEEM_5115_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][REDEEM_5115_VAULT_HOOK_KEY] = address(A[i].redeem5115VaultHook);
        hooks[chainIds[i]][REDEEM_5115_VAULT_HOOK_KEY] = Hook(REDEEM_5115_VAULT_HOOK_KEY, HookCategory.VaultWithdrawals, HookCategory.VaultDeposits, address(A[i].redeem5115VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultWithdrawals].push(hooks[chainIds[i]][REDEEM_5115_VAULT_HOOK_KEY]);
        hooksAddresses[7] = address(A[i].redeem5115VaultHook);
        A[i].requestDeposit7540VaultHook = new RequestDeposit7540VaultHook{salt: SALT}();
        vm.label(address(A[i].requestDeposit7540VaultHook), REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY] = address(A[i].requestDeposit7540VaultHook);
        hooks[chainIds[i]][REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY] = Hook(REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY, HookCategory.VaultDeposits, HookCategory.TokenApprovals, address(A[i].requestDeposit7540VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultDeposits].push(hooks[chainIds[i]][REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY]);
        hooksAddresses[8] = address(A[i].requestDeposit7540VaultHook);
        A[i].approveAndRequestDeposit7540VaultHook = new ApproveAndRequestDeposit7540VaultHook{salt: SALT}();
        vm.label(address(A[i].approveAndRequestDeposit7540VaultHook), APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY] = address(A[i].approveAndRequestDeposit7540VaultHook);
        hooks[chainIds[i]][APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY] = Hook(APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.VaultDeposits, address(A[i].approveAndRequestDeposit7540VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultDeposits].push(hooks[chainIds[i]][APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY]);
        hooksAddresses[9] = address(A[i].approveAndRequestDeposit7540VaultHook);
        A[i].requestRedeem7540VaultHook = new RequestRedeem7540VaultHook{salt: SALT}();
        vm.label(address(A[i].requestRedeem7540VaultHook), REQUEST_REDEEM_7540_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][REQUEST_REDEEM_7540_VAULT_HOOK_KEY] = address(A[i].requestRedeem7540VaultHook);
        hooks[chainIds[i]][REQUEST_REDEEM_7540_VAULT_HOOK_KEY] = Hook(REQUEST_REDEEM_7540_VAULT_HOOK_KEY, HookCategory.VaultWithdrawals, HookCategory.VaultDeposits, address(A[i].requestRedeem7540VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultWithdrawals].push(hooks[chainIds[i]][REQUEST_REDEEM_7540_VAULT_HOOK_KEY]);
        hooksAddresses[10] = address(A[i].requestRedeem7540VaultHook);
        A[i].deposit7540VaultHook = new Deposit7540VaultHook{salt: SALT}();
        vm.label(address(A[i].deposit7540VaultHook), DEPOSIT_7540_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][DEPOSIT_7540_VAULT_HOOK_KEY] = address(A[i].deposit7540VaultHook);
        hooks[chainIds[i]][DEPOSIT_7540_VAULT_HOOK_KEY] = Hook(DEPOSIT_7540_VAULT_HOOK_KEY, HookCategory.VaultDeposits, HookCategory.TokenApprovals, address(A[i].deposit7540VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultDeposits].push(hooks[chainIds[i]][DEPOSIT_7540_VAULT_HOOK_KEY]);
        hooksAddresses[11] = address(A[i].deposit7540VaultHook);
        A[i].withdraw7540VaultHook = new Withdraw7540VaultHook{salt: SALT}();
        vm.label(address(A[i].withdraw7540VaultHook), WITHDRAW_7540_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][WITHDRAW_7540_VAULT_HOOK_KEY] = address(A[i].withdraw7540VaultHook);
        hooks[chainIds[i]][WITHDRAW_7540_VAULT_HOOK_KEY] = Hook(WITHDRAW_7540_VAULT_HOOK_KEY, HookCategory.VaultWithdrawals, HookCategory.VaultDeposits, address(A[i].withdraw7540VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultWithdrawals].push(hooks[chainIds[i]][WITHDRAW_7540_VAULT_HOOK_KEY]);
        hooksAddresses[12] = address(A[i].withdraw7540VaultHook);
        A[i].redeem7540VaultHook = new Redeem7540VaultHook{salt: SALT}();
        vm.label(address(A[i].redeem7540VaultHook), REDEEM_7540_VAULT_HOOK_KEY);
        hookAddresses[chainIds[i]][REDEEM_7540_VAULT_HOOK_KEY] = address(A[i].redeem7540VaultHook);
        hooks[chainIds[i]][REDEEM_7540_VAULT_HOOK_KEY] = Hook(REDEEM_7540_VAULT_HOOK_KEY, HookCategory.VaultWithdrawals, HookCategory.VaultDeposits, address(A[i].redeem7540VaultHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultWithdrawals].push(hooks[chainIds[i]][REDEEM_7540_VAULT_HOOK_KEY]);
        hooksAddresses[13] = address(A[i].redeem7540VaultHook);
        A[i].swap1InchHook = new Swap1InchHook{salt: SALT}(ONE_INCH_ROUTER);
        vm.label(address(A[i].swap1InchHook), SWAP_1INCH_HOOK_KEY);
        hookAddresses[chainIds[i]][SWAP_1INCH_HOOK_KEY] = address(A[i].swap1InchHook);
        hooks[chainIds[i]][SWAP_1INCH_HOOK_KEY] = Hook(SWAP_1INCH_HOOK_KEY, HookCategory.Swaps, HookCategory.TokenApprovals, address(A[i].swap1InchHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Swaps].push(hooks[chainIds[i]][SWAP_1INCH_HOOK_KEY]);
        hooksAddresses[14] = address(A[i].swap1InchHook);
        MockOdosRouterV2 odosRouter = new MockOdosRouterV2{salt: SALT}();
        mockOdosRouters[chainIds[i]] = address(odosRouter);
        vm.label(address(odosRouter), "MockOdosRouterV2");
        A[i].mockApproveAndSwapOdosHook = new MockApproveAndSwapOdosHook{salt: SALT}(address(odosRouter));
        vm.label(address(A[i].mockApproveAndSwapOdosHook), MOCK_APPROVE_AND_SWAP_ODOS_HOOK_KEY);
        hookAddresses[chainIds[i]][MOCK_APPROVE_AND_SWAP_ODOS_HOOK_KEY] = address(A[i].mockApproveAndSwapOdosHook);
        hooks[chainIds[i]][MOCK_APPROVE_AND_SWAP_ODOS_HOOK_KEY] = Hook(MOCK_APPROVE_AND_SWAP_ODOS_HOOK_KEY, HookCategory.Swaps, HookCategory.TokenApprovals, address(A[i].mockApproveAndSwapOdosHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Swaps].push(hooks[chainIds[i]][MOCK_APPROVE_AND_SWAP_ODOS_HOOK_KEY]);
        hooksAddresses[15] = address(A[i].mockApproveAndSwapOdosHook);
        A[i].mockSwapOdosHook = new MockSwapOdosHook{salt: SALT}(address(odosRouter));
        vm.label(address(A[i].mockSwapOdosHook), MOCK_SWAP_ODOS_HOOK_KEY);
        hookAddresses[chainIds[i]][MOCK_SWAP_ODOS_HOOK_KEY] = address(A[i].mockSwapOdosHook);
        hooks[chainIds[i]][MOCK_SWAP_ODOS_HOOK_KEY] = Hook(MOCK_SWAP_ODOS_HOOK_KEY, HookCategory.Swaps, HookCategory.TokenApprovals, address(A[i].mockSwapOdosHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Swaps].push(hooks[chainIds[i]][MOCK_SWAP_ODOS_HOOK_KEY]);
        hooksAddresses[16] = address(A[i].mockSwapOdosHook);
        A[i].approveAndSwapOdosHook = new ApproveAndSwapOdosV2Hook{salt: SALT}(ODOS_ROUTER[chainIds[i]]);
        vm.label(address(A[i].approveAndSwapOdosHook), APPROVE_AND_SWAP_ODOSV2_HOOK_KEY);
        hookAddresses[chainIds[i]][APPROVE_AND_SWAP_ODOSV2_HOOK_KEY] = address(A[i].approveAndSwapOdosHook);
        hooks[chainIds[i]][APPROVE_AND_SWAP_ODOSV2_HOOK_KEY] = Hook(APPROVE_AND_SWAP_ODOSV2_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.Swaps, address(A[i].approveAndSwapOdosHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Swaps].push(hooks[chainIds[i]][APPROVE_AND_SWAP_ODOSV2_HOOK_KEY]);
        hooksAddresses[17] = address(A[i].approveAndSwapOdosHook);
        A[i].swapOdosHook = new SwapOdosV2Hook{salt: SALT}(ODOS_ROUTER[chainIds[i]]);
        vm.label(address(A[i].swapOdosHook), SWAP_ODOSV2_HOOK_KEY);
        hookAddresses[chainIds[i]][SWAP_ODOSV2_HOOK_KEY] = address(A[i].swapOdosHook);
        hooks[chainIds[i]][SWAP_ODOSV2_HOOK_KEY] = Hook(SWAP_ODOSV2_HOOK_KEY, HookCategory.Swaps, HookCategory.TokenApprovals, address(A[i].swapOdosHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Swaps].push(hooks[chainIds[i]][SWAP_ODOSV2_HOOK_KEY]);
        hooksAddresses[18] = address(A[i].swapOdosHook);
        A[i].swapUniswapV4Hook = new SwapUniswapV4Hook{salt: SALT}(MAINNET_V4_POOL_MANAGER);
        vm.label(address(A[i].swapUniswapV4Hook), SWAP_UNISWAP_V4_HOOK_KEY);
        hookAddresses[chainIds[i]][SWAP_UNISWAP_V4_HOOK_KEY] = address(A[i].swapUniswapV4Hook);
        hooks[chainIds[i]][SWAP_UNISWAP_V4_HOOK_KEY] = Hook(SWAP_UNISWAP_V4_HOOK_KEY, HookCategory.Swaps, HookCategory.TokenApprovals, address(A[i].swapUniswapV4Hook), "");
        hooksByCategory[chainIds[i]][HookCategory.Swaps].push(hooks[chainIds[i]][SWAP_UNISWAP_V4_HOOK_KEY]);
        hooksAddresses[19] = address(A[i].swapUniswapV4Hook);
        A[i].acrossSendFundsAndExecuteOnDstHook = new AcrossSendFundsAndExecuteOnDstHook{salt: SALT}(SPOKE_POOL_V3_ADDRESSES[chainIds[i]], _getContract(chainIds[i], SUPER_MERKLE_VALIDATOR_KEY));
        vm.label(address(A[i].acrossSendFundsAndExecuteOnDstHook), ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY);
        hookAddresses[chainIds[i]][ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY] = address(A[i].acrossSendFundsAndExecuteOnDstHook);
        hooks[chainIds[i]][ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY] = Hook(ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY, HookCategory.Bridges, HookCategory.TokenApprovals, address(A[i].acrossSendFundsAndExecuteOnDstHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Bridges].push(hooks[chainIds[i]][ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY]);
        hooksAddresses[20] = address(A[i].acrossSendFundsAndExecuteOnDstHook);
        A[i].approveAndAcrossSendFundsAndExecuteOnDstHook = new ApproveAndAcrossSendFundsAndExecuteOnDstHook{salt: SALT}(SPOKE_POOL_V3_ADDRESSES[chainIds[i]], _getContract(chainIds[i], SUPER_MERKLE_VALIDATOR_KEY));
        vm.label(address(A[i].approveAndAcrossSendFundsAndExecuteOnDstHook), APPROVE_AND_ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY);
        hookAddresses[chainIds[i]][APPROVE_AND_ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY] = address(A[i].approveAndAcrossSendFundsAndExecuteOnDstHook);
        hooks[chainIds[i]][APPROVE_AND_ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY] = Hook(APPROVE_AND_ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY, HookCategory.Bridges, HookCategory.TokenApprovals, address(A[i].approveAndAcrossSendFundsAndExecuteOnDstHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Bridges].push(hooks[chainIds[i]][APPROVE_AND_ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY]);
        hooksAddresses[20] = address(A[i].approveAndAcrossSendFundsAndExecuteOnDstHook);
        A[i].deBridgeSendOrderAndExecuteOnDstHook = new DeBridgeSendOrderAndExecuteOnDstHook{salt: SALT}(DEBRIDGE_DLN_ADDRESSES[chainIds[i]], _getContract(chainIds[i], SUPER_MERKLE_VALIDATOR_KEY));
        vm.label(address(A[i].deBridgeSendOrderAndExecuteOnDstHook), DEBRIDGE_SEND_ORDER_AND_EXECUTE_ON_DST_HOOK_KEY);
        hookAddresses[chainIds[i]][DEBRIDGE_SEND_ORDER_AND_EXECUTE_ON_DST_HOOK_KEY] = address(A[i].deBridgeSendOrderAndExecuteOnDstHook);
        hooks[chainIds[i]][DEBRIDGE_SEND_ORDER_AND_EXECUTE_ON_DST_HOOK_KEY] = Hook(DEBRIDGE_SEND_ORDER_AND_EXECUTE_ON_DST_HOOK_KEY, HookCategory.Bridges, HookCategory.TokenApprovals, address(A[i].deBridgeSendOrderAndExecuteOnDstHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Bridges].push(hooks[chainIds[i]][DEBRIDGE_SEND_ORDER_AND_EXECUTE_ON_DST_HOOK_KEY]);
        hooksAddresses[21] = address(A[i].deBridgeSendOrderAndExecuteOnDstHook);
        A[i].deBridgeCancelOrderHook = new DeBridgeCancelOrderHook{salt: SALT}(DEBRIDGE_DLN_ADDRESSES_DST[chainIds[i]]);
        vm.label(address(A[i].deBridgeCancelOrderHook), DEBRIDGE_CANCEL_ORDER_HOOK_KEY);
        hookAddresses[chainIds[i]][DEBRIDGE_CANCEL_ORDER_HOOK_KEY] = address(A[i].deBridgeCancelOrderHook);
        hooks[chainIds[i]][DEBRIDGE_CANCEL_ORDER_HOOK_KEY] = Hook(DEBRIDGE_CANCEL_ORDER_HOOK_KEY, HookCategory.Bridges, HookCategory.TokenApprovals, address(A[i].deBridgeCancelOrderHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Bridges].push(hooks[chainIds[i]][DEBRIDGE_CANCEL_ORDER_HOOK_KEY]);
        hooksAddresses[22] = address(A[i].deBridgeCancelOrderHook);
        A[i].fluidClaimRewardHook = new FluidClaimRewardHook{salt: SALT}();
        vm.label(address(A[i].fluidClaimRewardHook), FLUID_CLAIM_REWARD_HOOK_KEY);
        hookAddresses[chainIds[i]][FLUID_CLAIM_REWARD_HOOK_KEY] = address(A[i].fluidClaimRewardHook);
        hooks[chainIds[i]][FLUID_CLAIM_REWARD_HOOK_KEY] = Hook(FLUID_CLAIM_REWARD_HOOK_KEY, HookCategory.Claims, HookCategory.None, address(A[i].fluidClaimRewardHook), "");
        hooksAddresses[23] = address(A[i].fluidClaimRewardHook);
        A[i].fluidStakeHook = new FluidStakeHook{salt: SALT}();
        vm.label(address(A[i].fluidStakeHook), FLUID_STAKE_HOOK_KEY);
        hookAddresses[chainIds[i]][FLUID_STAKE_HOOK_KEY] = address(A[i].fluidStakeHook);
        hooks[chainIds[i]][FLUID_STAKE_HOOK_KEY] = Hook(FLUID_STAKE_HOOK_KEY, HookCategory.Stakes, HookCategory.None, address(A[i].fluidStakeHook), "");
        hooksAddresses[24] = address(A[i].fluidStakeHook);
        A[i].approveAndFluidStakeHook = new ApproveAndFluidStakeHook{salt: SALT}();
        vm.label(address(A[i].approveAndFluidStakeHook), APPROVE_AND_FLUID_STAKE_HOOK_KEY);
        hookAddresses[chainIds[i]][APPROVE_AND_FLUID_STAKE_HOOK_KEY] = address(A[i].approveAndFluidStakeHook);
        hooks[chainIds[i]][APPROVE_AND_FLUID_STAKE_HOOK_KEY] = Hook(APPROVE_AND_FLUID_STAKE_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.Stakes, address(A[i].approveAndFluidStakeHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Stakes].push(hooks[chainIds[i]][APPROVE_AND_FLUID_STAKE_HOOK_KEY]);
        hooksAddresses[25] = address(A[i].approveAndFluidStakeHook);
        A[i].fluidUnstakeHook = new FluidUnstakeHook{salt: SALT}();
        vm.label(address(A[i].fluidUnstakeHook), FLUID_UNSTAKE_HOOK_KEY);
        hookAddresses[chainIds[i]][FLUID_UNSTAKE_HOOK_KEY] = address(A[i].fluidUnstakeHook);
        hooks[chainIds[i]][FLUID_UNSTAKE_HOOK_KEY] = Hook(FLUID_UNSTAKE_HOOK_KEY, HookCategory.Stakes, HookCategory.None, address(A[i].fluidUnstakeHook), "");
        hooksAddresses[26] = address(A[i].fluidUnstakeHook);
        A[i].gearboxClaimRewardHook = new GearboxClaimRewardHook{salt: SALT}();
        vm.label(address(A[i].gearboxClaimRewardHook), GEARBOX_CLAIM_REWARD_HOOK_KEY);
        hookAddresses[chainIds[i]][GEARBOX_CLAIM_REWARD_HOOK_KEY] = address(A[i].gearboxClaimRewardHook);
        hooks[chainIds[i]][GEARBOX_CLAIM_REWARD_HOOK_KEY] = Hook(GEARBOX_CLAIM_REWARD_HOOK_KEY, HookCategory.Claims, HookCategory.None, address(A[i].gearboxClaimRewardHook), "");
        hooksAddresses[27] = address(A[i].gearboxClaimRewardHook);
        A[i].gearboxStakeHook = new GearboxStakeHook{salt: SALT}();
        vm.label(address(A[i].gearboxStakeHook), GEARBOX_STAKE_HOOK_KEY);
        hookAddresses[chainIds[i]][GEARBOX_STAKE_HOOK_KEY] = address(A[i].gearboxStakeHook);
        hooks[chainIds[i]][GEARBOX_STAKE_HOOK_KEY] = Hook(GEARBOX_STAKE_HOOK_KEY, HookCategory.Stakes, HookCategory.VaultDeposits, address(A[i].gearboxStakeHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Stakes].push(hooks[chainIds[i]][GEARBOX_STAKE_HOOK_KEY]);
        hooksAddresses[28] = address(A[i].gearboxStakeHook);
        A[i].approveAndGearboxStakeHook = new ApproveAndGearboxStakeHook{salt: SALT}();
        vm.label(address(A[i].approveAndGearboxStakeHook), GEARBOX_APPROVE_AND_STAKE_HOOK_KEY);
        hookAddresses[chainIds[i]][GEARBOX_APPROVE_AND_STAKE_HOOK_KEY] = address(A[i].approveAndGearboxStakeHook);
        hooks[chainIds[i]][GEARBOX_APPROVE_AND_STAKE_HOOK_KEY] = Hook(GEARBOX_APPROVE_AND_STAKE_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.Stakes, address(A[i].approveAndGearboxStakeHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Stakes].push(hooks[chainIds[i]][GEARBOX_APPROVE_AND_STAKE_HOOK_KEY]);
        hooksAddresses[29] = address(A[i].approveAndGearboxStakeHook);
        A[i].gearboxUnstakeHook = new GearboxUnstakeHook{salt: SALT}();
        vm.label(address(A[i].gearboxUnstakeHook), GEARBOX_UNSTAKE_HOOK_KEY);
        hookAddresses[chainIds[i]][GEARBOX_UNSTAKE_HOOK_KEY] = address(A[i].gearboxUnstakeHook);
        hooks[chainIds[i]][GEARBOX_UNSTAKE_HOOK_KEY] = Hook(GEARBOX_UNSTAKE_HOOK_KEY, HookCategory.Claims, HookCategory.Stakes, address(A[i].gearboxUnstakeHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Claims].push(hooks[chainIds[i]][GEARBOX_UNSTAKE_HOOK_KEY]);
        hooksAddresses[30] = address(A[i].gearboxUnstakeHook);
        A[i].yearnClaimOneRewardHook = new YearnClaimOneRewardHook{salt: SALT}();
        vm.label(address(A[i].yearnClaimOneRewardHook), YEARN_CLAIM_ONE_REWARD_HOOK_KEY);
        hookAddresses[chainIds[i]][YEARN_CLAIM_ONE_REWARD_HOOK_KEY] = address(A[i].yearnClaimOneRewardHook);
        hooks[chainIds[i]][YEARN_CLAIM_ONE_REWARD_HOOK_KEY] = Hook(YEARN_CLAIM_ONE_REWARD_HOOK_KEY, HookCategory.Claims, HookCategory.Stakes, address(A[i].yearnClaimOneRewardHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Claims].push(hooks[chainIds[i]][YEARN_CLAIM_ONE_REWARD_HOOK_KEY]);
        hooksAddresses[31] = address(A[i].yearnClaimOneRewardHook);
        A[i].batchTransferFromHook = new BatchTransferFromHook{salt: SALT}(PERMIT2);
        vm.label(address(A[i].batchTransferFromHook), BATCH_TRANSFER_FROM_HOOK_KEY);
        hookAddresses[chainIds[i]][BATCH_TRANSFER_FROM_HOOK_KEY] = address(A[i].batchTransferFromHook);
        hooks[chainIds[i]][BATCH_TRANSFER_FROM_HOOK_KEY] = Hook(BATCH_TRANSFER_FROM_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.None, address(A[i].batchTransferFromHook), "");
        hooksByCategory[chainIds[i]][HookCategory.TokenApprovals].push(hooks[chainIds[i]][BATCH_TRANSFER_FROM_HOOK_KEY]);
        hooksAddresses[32] = address(A[i].batchTransferFromHook);
        /// @dev EXPERIMENTAL HOOKS FROM HERE ONWARDS
        A[i].ethenaCooldownSharesHook = new EthenaCooldownSharesHook{salt: SALT}();
        vm.label(address(A[i].ethenaCooldownSharesHook), ETHENA_COOLDOWN_SHARES_HOOK_KEY);
        hookAddresses[chainIds[i]][ETHENA_COOLDOWN_SHARES_HOOK_KEY] = address(A[i].ethenaCooldownSharesHook);
        hooksAddresses[33] = address(A[i].ethenaCooldownSharesHook);
        A[i].ethenaUnstakeHook = new EthenaUnstakeHook{salt: SALT}();
        vm.label(address(A[i].ethenaUnstakeHook), ETHENA_UNSTAKE_HOOK_KEY);
        hookAddresses[chainIds[i]][ETHENA_UNSTAKE_HOOK_KEY] = address(A[i].ethenaUnstakeHook);
        hooksAddresses[34] = address(A[i].ethenaUnstakeHook);
        A[i].spectraExchangeDepositHook = new SpectraExchangeDepositHook{salt: SALT}(SPECTRA_ROUTERS[chainIds[i]]);
        vm.label(address(A[i].spectraExchangeDepositHook), SPECTRA_EXCHANGE_DEPOSIT_HOOK_KEY);
        hookAddresses[chainIds[i]][SPECTRA_EXCHANGE_DEPOSIT_HOOK_KEY] = address(A[i].spectraExchangeDepositHook);
        hooksAddresses[35] = address(A[i].spectraExchangeDepositHook);
        A[i].spectraExchangeRedeemHook = new SpectraExchangeRedeemHook{salt: SALT}(SPECTRA_ROUTERS[chainIds[i]]);
        vm.label(address(A[i].spectraExchangeRedeemHook), SPECTRA_EXCHANGE_REDEEM_HOOK_KEY);
        hookAddresses[chainIds[i]][SPECTRA_EXCHANGE_REDEEM_HOOK_KEY] = address(A[i].spectraExchangeRedeemHook);
        hooksAddresses[36] = address(A[i].spectraExchangeRedeemHook);
        A[i].pendleRouterSwapHook = new PendleRouterSwapHook{salt: SALT}(PENDLE_ROUTERS[chainIds[i]]);
        vm.label(address(A[i].pendleRouterSwapHook), PENDLE_ROUTER_SWAP_HOOK_KEY);
        hookAddresses[chainIds[i]][PENDLE_ROUTER_SWAP_HOOK_KEY] = address(A[i].pendleRouterSwapHook);
        hooksAddresses[37] = address(A[i].pendleRouterSwapHook);
        A[i].pendleRouterRedeemHook = new PendleRouterRedeemHook{salt: SALT}(PENDLE_ROUTERS[chainIds[i]]);
        vm.label(address(A[i].pendleRouterRedeemHook), PENDLE_ROUTER_REDEEM_HOOK_KEY);
        hookAddresses[chainIds[i]][PENDLE_ROUTER_REDEEM_HOOK_KEY] = address(A[i].pendleRouterRedeemHook);
        hooks[chainIds[i]][PENDLE_ROUTER_REDEEM_HOOK_KEY] = Hook(PENDLE_ROUTER_REDEEM_HOOK_KEY, HookCategory.Swaps, HookCategory.None, address(A[i].pendleRouterRedeemHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Swaps].push(hooks[chainIds[i]][PENDLE_ROUTER_REDEEM_HOOK_KEY]);
        hooksAddresses[38] = address(A[i].pendleRouterRedeemHook);
        A[i].cancelDepositRequest7540Hook = new CancelDepositRequest7540Hook{salt: SALT}();
        vm.label(address(A[i].cancelDepositRequest7540Hook), CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY);
        hookAddresses[chainIds[i]][CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY] = address(A[i].cancelDepositRequest7540Hook);
        hooks[chainIds[i]][CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY] = Hook(CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY, HookCategory.VaultWithdrawals, HookCategory.VaultDeposits, address(A[i].cancelDepositRequest7540Hook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultWithdrawals].push(hooks[chainIds[i]][CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY]);
        hooksAddresses[39] = address(A[i].cancelDepositRequest7540Hook);
        A[i].cancelRedeemRequest7540Hook = new CancelRedeemRequest7540Hook{salt: SALT}();
        vm.label(address(A[i].cancelRedeemRequest7540Hook), CANCEL_REDEEM_REQUEST_7540_HOOK_KEY);
        hookAddresses[chainIds[i]][CANCEL_REDEEM_REQUEST_7540_HOOK_KEY] = address(A[i].cancelRedeemRequest7540Hook);
        hooks[chainIds[i]][CANCEL_REDEEM_REQUEST_7540_HOOK_KEY] = Hook(CANCEL_REDEEM_REQUEST_7540_HOOK_KEY, HookCategory.VaultWithdrawals, HookCategory.VaultDeposits, address(A[i].cancelRedeemRequest7540Hook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultWithdrawals].push(hooks[chainIds[i]][CANCEL_REDEEM_REQUEST_7540_HOOK_KEY]);
        hooksAddresses[40] = address(A[i].cancelRedeemRequest7540Hook);
        A[i].claimCancelDepositRequest7540Hook = new ClaimCancelDepositRequest7540Hook{salt: SALT}();
        vm.label(address(A[i].claimCancelDepositRequest7540Hook), CLAIM_CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY);
        hookAddresses[chainIds[i]][CLAIM_CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY] = address(A[i].claimCancelDepositRequest7540Hook);
        hooks[chainIds[i]][CLAIM_CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY] = Hook(CLAIM_CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY, HookCategory.VaultWithdrawals, HookCategory.VaultDeposits, address(A[i].claimCancelDepositRequest7540Hook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultWithdrawals].push(hooks[chainIds[i]][CLAIM_CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY]);
        hooksAddresses[41] = address(A[i].claimCancelDepositRequest7540Hook);
        A[i].claimCancelRedeemRequest7540Hook = new ClaimCancelRedeemRequest7540Hook{salt: SALT}();
        vm.label(address(A[i].claimCancelRedeemRequest7540Hook), CLAIM_CANCEL_REDEEM_REQUEST_7540_HOOK_KEY);
        hookAddresses[chainIds[i]][CLAIM_CANCEL_REDEEM_REQUEST_7540_HOOK_KEY] = address(A[i].claimCancelRedeemRequest7540Hook);
        hooks[chainIds[i]][CLAIM_CANCEL_REDEEM_REQUEST_7540_HOOK_KEY] = Hook(CLAIM_CANCEL_REDEEM_REQUEST_7540_HOOK_KEY, HookCategory.VaultWithdrawals, HookCategory.VaultDeposits, address(A[i].claimCancelRedeemRequest7540Hook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultWithdrawals].push(hooks[chainIds[i]][CLAIM_CANCEL_REDEEM_REQUEST_7540_HOOK_KEY]);
        hooksAddresses[42] = address(A[i].claimCancelRedeemRequest7540Hook);
        A[i].MorphoSupplyAndBorrowHook = new MorphoSupplyAndBorrowHook{salt: SALT}(MORPHO);
        vm.label(address(A[i].MorphoSupplyAndBorrowHook), MORPHO_BORROW_HOOK_KEY);
        hookAddresses[chainIds[i]][MORPHO_BORROW_HOOK_KEY] = address(A[i].MorphoSupplyAndBorrowHook);
        hooks[chainIds[i]][MORPHO_BORROW_HOOK_KEY] = Hook(MORPHO_BORROW_HOOK_KEY, HookCategory.Loans, HookCategory.None, address(A[i].MorphoSupplyAndBorrowHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Loans].push(hooks[chainIds[i]][MORPHO_BORROW_HOOK_KEY]);
        hooksAddresses[43] = address(A[i].MorphoSupplyAndBorrowHook);
        A[i].morphoRepayHook = new MorphoRepayHook{salt: SALT}(MORPHO);
        vm.label(address(A[i].morphoRepayHook), MORPHO_REPAY_HOOK_KEY);
        hookAddresses[chainIds[i]][MORPHO_REPAY_HOOK_KEY] = address(A[i].morphoRepayHook);
        hooks[chainIds[i]][MORPHO_REPAY_HOOK_KEY] = Hook(MORPHO_REPAY_HOOK_KEY, HookCategory.Loans, HookCategory.None, address(A[i].morphoRepayHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Loans].push(hooks[chainIds[i]][MORPHO_REPAY_HOOK_KEY]);
        hooksAddresses[44] = address(A[i].morphoRepayHook);
        A[i].morphoRepayAndWithdrawHook = new MorphoRepayAndWithdrawHook{salt: SALT}(MORPHO);
        vm.label(address(A[i].morphoRepayAndWithdrawHook), MORPHO_REPAY_AND_WITHDRAW_HOOK_KEY);
        hookAddresses[chainIds[i]][MORPHO_REPAY_AND_WITHDRAW_HOOK_KEY] = address(A[i].morphoRepayAndWithdrawHook);
        hooksAddresses[45] = address(A[i].morphoRepayAndWithdrawHook);
        A[i].offrampTokensHook = new OfframpTokensHook{salt: SALT}();
        vm.label(address(A[i].offrampTokensHook), OFFRAMP_TOKENS_HOOK_KEY);
        hookAddresses[chainIds[i]][OFFRAMP_TOKENS_HOOK_KEY] = address(A[i].offrampTokensHook);
        hooks[chainIds[i]][OFFRAMP_TOKENS_HOOK_KEY] = Hook(OFFRAMP_TOKENS_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.None, address(A[i].offrampTokensHook), "");
        hooksByCategory[chainIds[i]][HookCategory.TokenApprovals].push(hooks[chainIds[i]][OFFRAMP_TOKENS_HOOK_KEY]);
        hooksAddresses[46] = address(A[i].offrampTokensHook);
        A[i].mintSuperPositionsHook = new MintSuperPositionsHook{salt: SALT}();
        vm.label(address(A[i].mintSuperPositionsHook), MINT_SUPERPOSITIONS_HOOK_KEY);
        hookAddresses[chainIds[i]][MINT_SUPERPOSITIONS_HOOK_KEY] = address(A[i].mintSuperPositionsHook);
        hooks[chainIds[i]][MINT_SUPERPOSITIONS_HOOK_KEY] = Hook(MINT_SUPERPOSITIONS_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.None, address(A[i].mintSuperPositionsHook), "");
        hooksByCategory[chainIds[i]][HookCategory.VaultDeposits].push(hooks[chainIds[i]][MINT_SUPERPOSITIONS_HOOK_KEY]);
        hooksAddresses[47] = address(A[i].mintSuperPositionsHook);
        A[i].markRootAsUsedHook = new MarkRootAsUsedHook{salt: SALT}();
        vm.label(address(A[i].markRootAsUsedHook), MARK_ROOT_AS_USED_HOOK_KEY);
        hookAddresses[chainIds[i]][MARK_ROOT_AS_USED_HOOK_KEY] = address(A[i].markRootAsUsedHook);
        hooks[chainIds[i]][MARK_ROOT_AS_USED_HOOK_KEY] = Hook(MARK_ROOT_AS_USED_HOOK_KEY, HookCategory.TokenApprovals, HookCategory.None, address(A[i].markRootAsUsedHook), "");
        hooksByCategory[chainIds[i]][HookCategory.TokenApprovals].push(hooks[chainIds[i]][MARK_ROOT_AS_USED_HOOK_KEY]);
        hooksAddresses[48] = address(A[i].markRootAsUsedHook);
        A[i].merklClaimRewardHook = new MerklClaimRewardHook{salt: SALT}(MERKL_DISTRIBUTOR);
        vm.label(address(A[i].merklClaimRewardHook), MERKL_CLAIM_REWARD_HOOK_KEY);
        hookAddresses[chainIds[i]][MERKL_CLAIM_REWARD_HOOK_KEY] = address(A[i].merklClaimRewardHook);
        hooks[chainIds[i]][MERKL_CLAIM_REWARD_HOOK_KEY] = Hook(MERKL_CLAIM_REWARD_HOOK_KEY, HookCategory.Claims, HookCategory.None, address(A[i].merklClaimRewardHook), "");
        hooksByCategory[chainIds[i]][HookCategory.Claims].push(hooks[chainIds[i]][MERKL_CLAIM_REWARD_HOOK_KEY]);
        hooksAddresses[49] = address(A[i].merklClaimRewardHook);
        hookListPerChain[chainIds[i]] = hooksAddresses;
        _createHooksTree(chainIds[i], hooksAddresses);
        globalMerkleHooks = new address[](4);
        globalMerkleHooks[0] = address(A[i].approveAndDeposit4626VaultHook);
        globalMerkleHooks[1] = address(A[i].redeem4626VaultHook);
        globalMerkleHooks[2] = address(A[i].approveAndGearboxStakeHook);
        globalMerkleHooks[3] = address(A[i].gearboxUnstakeHook);
        globalMerkleHookNames = new string[](4);
        globalMerkleHookNames[0] = "APPROVE_AND_DEPOSIT_4626_VAULT_HOOK";
        globalMerkleHookNames[1] = "REDEEM_4626_VAULT_HOOK";
        globalMerkleHookNames[2] = "APPROVE_AND_GEARBOX_STAKE_HOOK";
        globalMerkleHookNames[3] = "GEARBOX_UNSTAKE_HOOK";
    }
    return A;
}
```

### log(string)

- **Kind**: internal
- **Source**: 6191:121:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 8891:133:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 8650:235:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### _getContract(uint64,string)

- **Kind**: internal
- **Source**: 20955:162:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_getContract(uint64,string)`

```solidity
function _getContract(uint64 chainId, string memory contractName) internal view returns (address) {
    return contractAddresses[chainId][contractName];
}
```

### _createHooksTree(uint64,address[])

- **Kind**: internal
- **Source**: 615:633:502
- **Link**: `lib/v2-core/test/utils/MerkleTreeHelper.sol:MerkleTreeHelper:_createHooksTree(uint64,address[])`

```solidity
function _createHooksTree(uint64 chainId, address[] memory hooksAddresses) internal returns (bytes32[][] memory proof, bytes32 root) {
    bytes32[] memory leaves = new bytes32[](hooksAddresses.length);
    for (uint256 i = 0; i < hooksAddresses.length; i++) {
        leaves[i] = keccak256(bytes.concat(keccak256(abi.encode(hooksAddresses[i]))));
    }
    hookLeavesPerChain[chainId] = leaves;
    (proof, root) = _createValidatorMerkleTree(hookLeavesPerChain[chainId]);
    hookProofsPerChain[chainId] = proof;
    hookRootPerChain[chainId] = root;
}
```

### _createValidatorMerkleTree(bytes32[])

- **Kind**: internal
- **Source**: 3159:1538:502
- **Link**: `lib/v2-core/test/utils/MerkleTreeHelper.sol:MerkleTreeHelper:_createValidatorMerkleTree(bytes32[])`

```solidity
function _createValidatorMerkleTree(bytes32[] memory leaves) internal pure returns (bytes32[][] memory proof, bytes32 root) {
    require(leaves.length > 0, "At least one leaf required");
    uint256 n = leaves.length;
    while ((n & (n - 1)) != 0) {
        n++;
    }
    bytes32[] memory nodes = new bytes32[](n);
    for (uint256 i = 0; i < leaves.length; i++) {
        nodes[i] = leaves[i];
    }
    for (uint256 i = leaves.length; i < n; i++) {
        nodes[i] = leaves[leaves.length - 1];
    }
    uint256 totalLevels = 1;
    while (n > 1) {
        n = n / 2;
        totalLevels++;
    }
    bytes32[][] memory tree = new bytes32[][](totalLevels);
    tree[0] = nodes;
    uint256 levelSize = nodes.length;
    uint256 level = 0;
    while (levelSize > 1) {
        levelSize /= 2;
        tree[level + 1] = new bytes32[](levelSize);
        for (uint256 i = 0; i < levelSize; i++) {
            tree[level + 1][i] = _sortAndHashPair(tree[level][2 * i], tree[level][(2 * i) + 1]);
        }
        level++;
    }
    root = tree[level][0];
    proof = new bytes32[][](leaves.length);
    for (uint256 i = 0; i < leaves.length; i++) {
        proof[i] = _generateProof(i, tree);
    }
    return (proof, root);
}
```

### _sortAndHashPair(bytes32,bytes32)

- **Kind**: internal
- **Source**: 2972:181:502
- **Link**: `lib/v2-core/test/utils/MerkleTreeHelper.sol:MerkleTreeHelper:_sortAndHashPair(bytes32,bytes32)`

```solidity
function _sortAndHashPair(bytes32 a, bytes32 b) internal pure returns (bytes32) {
    return (a < b) ? keccak256(abi.encodePacked(a, b)) : keccak256(abi.encodePacked(b, a));
}
```

### _generateProof(uint256,bytes32[][])

- **Kind**: internal
- **Source**: 4890:453:502
- **Link**: `lib/v2-core/test/utils/MerkleTreeHelper.sol:MerkleTreeHelper:_generateProof(uint256,bytes32[][])`

```solidity
function _generateProof(uint256 index, bytes32[][] memory tree) private pure returns (bytes32[] memory) {
    uint256 levels = tree.length;
    bytes32[] memory proof = new bytes32[](levels - 1);
    for (uint256 level = 0; level < (levels - 1); level++) {
        uint256 siblingIndex = index ^ 1;
        proof[level] = tree[level][siblingIndex];
        index /= 2;
    }
    return proof;
}
```

### _initializeAccounts(uint256)

- **Kind**: internal
- **Source**: 69179:1985:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_initializeAccounts(uint256)`

```solidity
function _initializeAccounts(uint256 count) internal {
    for (uint256 i = 0; i < chainIds.length; ++i) {
        vm.selectFork(FORKS[chainIds[i]]);
        string memory accountName = "SuperformAccount";
        AccountInstance memory instance = makeAccountInstance(keccak256(abi.encode(accountName)));
        accountInstances[chainIds[i]] = instance;
        instance.installModule({moduleTypeId: MODULE_TYPE_EXECUTOR, module: _getContract(chainIds[i], SUPER_EXECUTOR_KEY), data: ""});
        instance.installModule({moduleTypeId: MODULE_TYPE_EXECUTOR, module: _getContract(chainIds[i], SUPER_DESTINATION_EXECUTOR_KEY), data: ""});
        instance.installModule({moduleTypeId: MODULE_TYPE_VALIDATOR, module: _getContract(chainIds[i], SUPER_DESTINATION_VALIDATOR_KEY), data: abi.encode(validatorSigners[chainIds[i]])});
        instance.installModule({moduleTypeId: MODULE_TYPE_VALIDATOR, module: _getContract(chainIds[i], SUPER_MERKLE_VALIDATOR_KEY), data: abi.encode(validatorSigners[chainIds[i]])});
        vm.label(instance.account, accountName);
        for (uint256 j; j < count; ++j) {
            AccountInstance memory _instance = makeAccountInstance(keccak256(abi.encode(block.timestamp, j)));
            randomAccountInstances[chainIds[i]].push(_instance);
            _instance.installModule({moduleTypeId: MODULE_TYPE_EXECUTOR, module: _getContract(chainIds[i], "SuperExecutor"), data: ""});
            vm.label(_instance.account, "RandomAccount");
        }
    }
}
```

### makeAccountInstance(bytes32)

- **Kind**: internal
- **Source**: 11712:1136:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:makeAccountInstance(bytes32)`

```solidity
/// @notice Create an account instance with the provided salt
///  @param salt The salt used to create the account
///  @return instance The account instance
function makeAccountInstance(bytes32 salt) internal initializeModuleKit() returns (AccountInstance memory instance) {
    (AccountType env, address accountFactoryAddress, address accountHelper) = ModuleKitHelpers.getAccountEnv();
    IAccountFactory accountFactory = IAccountFactory(accountFactoryAddress);
    bytes memory initData = accountFactory.getInitData(address(_defaultValidator), "");
    address account = accountFactory.getAddress(salt, initData);
    bytes memory initCode = abi.encodePacked(address(accountFactory), abi.encodeCall(accountFactory.createAccount, (salt, initData)));
    label(address(account), toString(salt));
    deal(account, 10 ether);
    instance = _makeAccountInstance({salt: salt, accountType: env, helper: accountHelper, account: account, initCode: initCode, validator: address(_defaultValidator), accountFactory: address(accountFactory), sessionValidator: address(_defaultSessionValidator)});
}
```

### getAccountEnv()

- **Kind**: internal
- **Source**: 29353:871:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:getAccountEnv()`

```solidity
/// @notice Gets the account environment from storage
function getAccountEnv() internal view returns (AccountType env, address, address) {
    (bytes32 envHash, address factory, address helper) = getAccountEnvFromStorage();
    if (envHash == keccak256(abi.encodePacked(DEFAULT))) {
        return (AccountType.DEFAULT, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(SAFE))) {
        return (AccountType.SAFE, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(KERNEL))) {
        return (AccountType.KERNEL, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(CUSTOM))) {
        return (AccountType.CUSTOM, factory, helper);
    } else if (envHash == keccak256(abi.encodePacked(NEXUS))) {
        return (AccountType.NEXUS, factory, helper);
    } else {
        revert InvalidAccountType();
    }
}
```

### getAccountEnv()

- **Kind**: free-function
- **Source**: 3246:404:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getAccountEnv()`

```solidity
function getAccountEnv() view returns (bytes32 env, address factory, address helper) {
    bytes32 envSlot = keccak256("ModuleKit.AccountTypeSlot");
    bytes32 factorySlot = keccak256("ModuleKit.AccountFactorySlot");
    bytes32 helperSlot = keccak256("ModuleKit.HelperSlot");
    assembly {
        env := sload(envSlot)
        factory := sload(factorySlot)
        helper := sload(helperSlot)
    }
}
```

### label(address,string)

- **Kind**: free-function
- **Source**: 971:93:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:label(address,string)`

```solidity
function label(address _addr, string memory _label) {
    Vm(VM_ADDR).label(_addr, _label);
}
```

### toString(bytes32)

- **Kind**: free-function
- **Source**: 4142:208:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:toString(bytes32)`

```solidity
function toString(bytes32 input) pure returns (string memory) {
    bytes memory _bytes = new bytes(32);
    for (uint256 i = 0; i < 32; i++) {
        _bytes[i] = input[i];
    }
    return string(_bytes);
}
```

### deal(address,uint256)

- **Kind**: internal
- **Source**: 27055:91:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,uint256)`

```solidity
function deal(address to, uint256 give) virtual internal {
    vm.deal(to, give);
}
```

### _makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address)

- **Kind**: internal
- **Source**: 18993:828:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:_makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address)`

```solidity
/// @notice Create an account instance with the provided salt, account, init code, account
///          factory, validator, session validator, account type, and helper
///  @param salt The salt used to create the account
///  @param account The address of the account
///  @param initCode The init code used to create the account
///  @param accountFactory The address of the account factory
///  @param validator The address of the validator
///  @param sessionValidator The address of the session validator
///  @param accountType The type of the account
///  @param helper The address of the account helper
///  @return instance The account instance
function _makeAccountInstance(bytes32 salt, address account, bytes memory initCode, address accountFactory, address validator, address sessionValidator, AccountType accountType, address helper) internal view returns (AccountInstance memory instance) {
    instance = AccountInstance({accountType: accountType, accountHelper: helper, account: account, aux: auxiliary, salt: salt, defaultValidator: IERC7579Validator(validator), initCode: initCode, accountFactory: accountFactory, smartSession: ISmartSession(SMARTSESSION_ADDR), defaultSessionValidator: ISessionValidator(sessionValidator)});
}
```

### initializeModuleKit()

- **Kind**: modifier
- **Source**: 20107:202:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:initializeModuleKit()`

```solidity
/// @dev Initialize the module kit with the provided environment if it has not been initialized
modifier initializeModuleKit() {
    if (!isInit[block.chainid]) {
        string memory _env = envOr("ACCOUNT_TYPE", DEFAULT);
        _initializeModuleKit(_env);
    }
    _;
}
```

### envOr(string,string)

- **Kind**: internal
- **Source**: 4081:166:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:envOr(string,string)`

```solidity
function envOr(string memory name, string memory defaultValue) public view returns (string memory value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

### _initializeModuleKit(string)

- **Kind**: internal
- **Source**: 8404:2950:233
- **Link**: `lib/v2-core/lib/modulekit/src/test/RhinestoneModuleKit.sol:RhinestoneModuleKit:_initializeModuleKit(string)`

```solidity
/// @notice Initialize the module kit with the provided environment, deploy the factories,
///          helpers, and validators, and stake them on the entrypoint
function _initializeModuleKit(string memory _env) internal {
    super.init();
    isInit[block.chainid] = true;
    writeFactory(address(new ERC7579Factory()), DEFAULT);
    writeFactory(address(new SafeFactory()), SAFE);
    writeFactory(address(new KernelFactory()), KERNEL);
    writeFactory(address(new NexusFactory()), NEXUS);
    writeFactory(address(new ERC7579Factory()), CUSTOM);
    writeHelper(address(new ERC7579Helpers()), DEFAULT);
    writeHelper(address(new SafeHelpers()), SAFE);
    writeHelper(address(new KernelHelpers()), KERNEL);
    writeHelper(address(new NexusHelpers()), NEXUS);
    writeHelper(address(new ERC7579Helpers()), CUSTOM);
    IAccountFactory safeFactory = IAccountFactory(getFactory(SAFE));
    IAccountFactory kernelFactory = IAccountFactory(getFactory(KERNEL));
    IAccountFactory erc7579Factory = IAccountFactory(getFactory(DEFAULT));
    IAccountFactory nexusFactory = IAccountFactory(getFactory(NEXUS));
    IAccountFactory customFactory = IAccountFactory(getFactory(CUSTOM));
    safeFactory.init();
    kernelFactory.init();
    erc7579Factory.init();
    nexusFactory.init();
    customFactory.init();
    label(address(safeFactory), "SafeFactory");
    label(address(kernelFactory), "KernelFactory");
    label(address(erc7579Factory), "ERC7579Factory");
    label(address(nexusFactory), "NexusFactory");
    label(address(customFactory), "CustomFactory");
    deal(address(safeFactory), 10 ether);
    deal(address(kernelFactory), 10 ether);
    deal(address(erc7579Factory), 10 ether);
    deal(address(nexusFactory), 10 ether);
    deal(address(customFactory), 10 ether);
    prank(address(safeFactory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    prank(address(kernelFactory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    prank(address(erc7579Factory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    prank(address(nexusFactory));
    IStakeManager(ENTRYPOINT_ADDR).addStake{value: 10 ether}(100_000);
    ModuleKitHelpers.setAccountEnv(_env);
    IAccountFactory accountFactory = IAccountFactory(getFactory(_env));
    label(address(accountFactory), "AccountFactory");
    _defaultValidator = new MockValidator();
    label(address(_defaultValidator), "DefaultValidator");
    _defaultSessionValidator = new MockStatelessValidator();
    label(address(_defaultSessionValidator), "SessionValidator");
}
```

### init()

- **Kind**: internal
- **Source**: 1861:543:231
- **Link**: `lib/v2-core/lib/modulekit/src/test/Auxiliary.sol:AuxiliaryFactory:init()`

```solidity
/// @notice Initializes and labels all the auxiliary contracts.
function init() virtual internal {
    auxiliary.mockFactory = new MockFactory();
    label(address(auxiliary.mockFactory), "Mock Factory");
    auxiliary.gasSimulation = new UserOpGasLog();
    auxiliary.entrypoint = etchEntrypoint();
    label(address(auxiliary.entrypoint), "EntryPoint");
    auxiliary.registry = etchRegistry();
    label(address(auxiliary.registry), "ERC7484Registry");
    auxiliary.smartSession = etchSmartSessions();
    label(address(auxiliary.smartSession), "SmartSession");
}
```

### etchEntrypoint()

- **Kind**: free-function
- **Source**: 1312:297:187
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol:etchEntrypoint()`

```solidity
function etchEntrypoint() returns (IEntryPoint) {
    address payable entryPoint = payable(address(new EntryPointSimulationsPatch()));
    etch(ENTRYPOINT_ADDR, entryPoint.code);
    EntryPointSimulationsPatch(payable(ENTRYPOINT_ADDR)).init(entryPoint);
    return IEntryPoint(ENTRYPOINT_ADDR);
}
```

### etch(address,bytes)

- **Kind**: free-function
- **Source**: 859:110:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:etch(address,bytes)`

```solidity
function etch(address target, bytes memory runtimeBytecode) {
    Vm(VM_ADDR).etch(target, runtimeBytecode);
}
```

### etchRegistry()

- **Kind**: free-function
- **Source**: 357:176:189
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/predeploy/Registry.sol:etchRegistry()`

```solidity
function etchRegistry() returns (IERC7484) {
    address _registry = address(new MockRegistry());
    etch(REGISTRY_ADDR, _registry.code);
    return IERC7484(REGISTRY_ADDR);
}
```

### etchSmartSessions()

- **Kind**: free-function
- **Source**: 378:172:186
- **Link**: `lib/v2-core/lib/modulekit/src/deployment/precompiles/SmartSessionsPrecompiles.sol:etchSmartSessions()`

```solidity
function etchSmartSessions() returns (ISmartSession) {
    etch(address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE);
    return ISmartSession(SMARTSESSION_ADDR);
}
```

### writeFactory(address,string)

- **Kind**: free-function
- **Source**: 4416:204:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeFactory(address,string)`

```solidity
function writeFactory(address factory, string memory factoryType) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", factoryType, "FactorySlot"));
    assembly {
        sstore(slot, factory)
    }
}
```

### writeHelper(address,string)

- **Kind**: free-function
- **Source**: 5007:198:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeHelper(address,string)`

```solidity
function writeHelper(address helper, string memory helperType) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", helperType, "HelperSlot"));
    assembly {
        sstore(slot, helper)
    }
}
```

### getFactory(string)

- **Kind**: free-function
- **Source**: 4622:217:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getFactory(string)`

```solidity
function getFactory(string memory factoryType) view returns (address factory) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", factoryType, "FactorySlot"));
    assembly {
        factory := sload(slot)
    }
}
```

### prank(address)

- **Kind**: free-function
- **Source**: 1619:63:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:prank(address)`

```solidity
function prank(address _addr) {
    Vm(VM_ADDR).prank(_addr);
}
```

### setAccountEnv(string)

- **Kind**: internal
- **Source**: 26858:87:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:setAccountEnv(string)`

```solidity
/// @notice Sets the account type in storage from a string
///  @param env The string to set
function setAccountEnv(string memory env) internal {
    _setAccountEnv(env);
}
```

### _setAccountEnv(string)

- **Kind**: internal
- **Source**: 28352:937:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:_setAccountEnv(string)`

```solidity
/// @notice Sets the account type in storage from a string
function _setAccountEnv(string memory env) private {
    address factory = getFactory(env);
    address helper = getHelperFromStorage(env);
    if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(DEFAULT))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(SAFE))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(KERNEL))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(CUSTOM))) {
        writeAccountEnv(env, factory, helper);
    } else if (keccak256(abi.encodePacked(env)) == keccak256(abi.encodePacked(NEXUS))) {
        writeAccountEnv(env, factory, helper);
    } else {
        revert InvalidAccountType();
    }
}
```

### getHelper(string)

- **Kind**: free-function
- **Source**: 5207:211:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getHelper(string)`

```solidity
function getHelper(string memory helperType) view returns (address helper) {
    bytes32 slot = keccak256(abi.encode("ModuleKit.", helperType, "HelperSlot"));
    assembly {
        helper := sload(slot)
    }
}
```

### writeAccountEnv(string,address,address)

- **Kind**: free-function
- **Source**: 2791:453:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeAccountEnv(string,address,address)`

```solidity
function writeAccountEnv(string memory env, address factory, address helper) {
    bytes32 envSlot = keccak256("ModuleKit.AccountTypeSlot");
    bytes32 factorySlot = keccak256("ModuleKit.AccountFactorySlot");
    bytes32 helperSlot = keccak256("ModuleKit.HelperSlot");
    bytes32 envHash = keccak256(abi.encodePacked(env));
    assembly {
        sstore(envSlot, envHash)
        sstore(factorySlot, factory)
        sstore(helperSlot, helper)
    }
}
```

### installModule(struct AccountInstance,uint256,address,bytes)

- **Kind**: internal
- **Source**: 9158:632:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:installModule(struct AccountInstance,uint256,address,bytes)`

```solidity
/// @notice Installs a module on an account by generating a userOp and sending it to the
///          entrypoint
///  @param instance AccountInstance struct containing the account and accountHelper
///  @param moduleTypeId The type of the module to install
///  @param module The address of the module to install
///  @param data Arbitrary data that may be required on the module during `onInstall`
///          initialization
///  @return userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
function installModule(AccountInstance memory instance, uint256 moduleTypeId, address module, bytes memory data) internal returns (UserOpData memory userOpData) {
    preEnvHook();
    userOpData = instance.getInstallModuleOps(moduleTypeId, module, data, address(instance.defaultValidator));
    userOpData = userOpData.signDefault();
    userOpData.entrypoint = instance.aux.entrypoint;
    userOpData.execUserOps();
}
```

### preEnvHook()

- **Kind**: internal
- **Source**: 7549:199:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:preEnvHook()`

```solidity
/// @notice A hook used to initiate state diff recording before installing a module
function preEnvHook() internal {
    if (envOr("COMPLIANCE", false) || getStorageCompliance()) {
        vmStartStateDiffRecording();
    }
}
```

### getStorageCompliance()

- **Kind**: free-function
- **Source**: 2450:172:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getStorageCompliance()`

```solidity
function getStorageCompliance() view returns (bool value) {
    bytes32 slot = keccak256("ModuleKit.StorageCompliance");
    assembly {
        value := sload(slot)
    }
}
```

### envOr(string,bool)

- **Kind**: internal
- **Source**: 4355:148:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:envOr(string,bool)`

```solidity
function envOr(string memory name, bool defaultValue) public view returns (bool value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

### startStateDiffRecording()

- **Kind**: internal
- **Source**: 4253:96:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:startStateDiffRecording()`

```solidity
function startStateDiffRecording() public {
    Vm(VM_ADDR).startStateDiffRecording();
}
```

### getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address)

- **Kind**: internal
- **Source**: 14540:566:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address)`

```solidity
/// @notice Generates a userOp to install a module on an account
///  @param instance AccountInstance struct containing the account and accountHelper
///  @param module The address of the module to install
///  @param initData Arbitrary data that may be required on the module during `onInstall`
///          initialization
///  @param txValidator The address of the transaction validator
///  @return userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
function getInstallModuleOps(AccountInstance memory instance, uint256 moduleType, address module, bytes memory initData, address txValidator) internal returns (UserOpData memory userOpData) {
    (userOpData.userOp, userOpData.userOpHash) = HelperBase(instance.accountHelper).configModuleUserOp(instance, moduleType, module, initData, true, txValidator);
    userOpData.entrypoint = instance.aux.entrypoint;
}
```

### signDefault(struct UserOpData)

- **Kind**: internal
- **Source**: 33955:186:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:signDefault(struct UserOpData)`

```solidity
/// @notice Adds a default signature to a UserOpData struct
///  @param userOpData UserOpData struct with the default signature added
function signDefault(UserOpData memory userOpData) internal pure returns (UserOpData memory) {
    userOpData.userOp.signature = "DEFAULT SIGNATURE";
    return userOpData;
}
```

### execUserOps(struct UserOpData)

- **Kind**: internal
- **Source**: 3413:243:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:execUserOps(struct UserOpData)`

```solidity
/// @notice Executes userOps on the entrypoint
///  @param userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
///  @return ExecutionReturnData struct containing the logs from the execution
function execUserOps(UserOpData memory userOpData) internal returns (ExecutionReturnData memory) {
    return ERC4337Helpers.exec4337(userOpData.userOp, userOpData.entrypoint);
}
```

### exec4337(struct PackedUserOperation,contract IEntryPoint)

- **Kind**: internal
- **Source**: 5908:333:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:exec4337(struct PackedUserOperation,contract IEntryPoint)`

```solidity
function exec4337(PackedUserOperation memory userOp, IEntryPoint onEntryPoint) internal returns (ExecutionReturnData memory logs) {
    PackedUserOperation[] memory userOps = new PackedUserOperation[](1);
    userOps[0] = userOp;
    return exec4337(userOps, onEntryPoint);
}
```

### exec4337(struct PackedUserOperation[],contract IEntryPoint)

- **Kind**: internal
- **Source**: 1486:4373:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:exec4337(struct PackedUserOperation[],contract IEntryPoint)`

```solidity
function exec4337(PackedUserOperation[] memory userOps, IEntryPoint onEntryPoint) internal returns (ExecutionReturnData memory executionData) {
    ExecutionContext memory ctx = ExecutionContext({isExpectRevert: getExpectRevert(), beneficiary: payable(address(0x69)), userOpCalldata: "", success: false, returnData: ""});
    if (envOr("SIMULATE", false) || getSimulateUserOp()) {
        bool simulationSuccess = userOps[0].simulateUserOp(address(onEntryPoint));
        if (ctx.isExpectRevert == 0) {
            require(simulationSuccess, "UserOperation simulation failed");
        }
    }
    recordLogs();
    ctx.userOpCalldata = abi.encodeCall(IEntryPoint.handleOps, (userOps, ctx.beneficiary));
    (ctx.success, ctx.returnData) = address(onEntryPoint).call(ctx.userOpCalldata);
    if (ctx.isExpectRevert == 0) {
        require(ctx.success, "UserOperation execution failed");
    } else if ((ctx.isExpectRevert == 2) && (!ctx.success)) {
        checkRevertMessage(ctx.returnData);
    }
    VmSafe.Log[] memory logs = getRecordedLogs();
    executionData = ExecutionReturnData(logs);
    uint256 totalUserOpGas = 0;
    for (uint256 i; i < logs.length; i++) {
        if (logs[i].topics[0] == 0x49628fd1471006c1482da88028e9ce4dbb080b815c9b0344d39e5a8e6ec1419f) {
            (uint256 nonce, bool userOpSuccess, , uint256 actualGasUsed) = abi.decode(logs[i].data, (uint256, bool, uint256, uint256));
            totalUserOpGas = actualGasUsed;
            if (!userOpSuccess) {
                bytes32 userOpHash = logs[i].topics[1];
                if (ctx.isExpectRevert == 0) {
                    bytes memory revertReason = getUserOpRevertReason(logs, userOpHash);
                    address account = address(bytes20(logs[i].topics[2]));
                    revert UserOperationReverted(userOpHash, account, getLabel(account), nonce, revertReason);
                } else {
                    if (ctx.isExpectRevert == 2) {
                        checkRevertMessage(getUserOpRevertReason(logs, userOpHash));
                    }
                    clearExpectRevert();
                }
            }
        } else if (logs[i].topics[0] == 0xd21d0b289f126c4b473ea641963e766833c2f13866e4ff480abd787c100ef123) {
            (uint256 moduleType, address module) = abi.decode(logs[i].data, (uint256, address));
            writeInstalledModule(InstalledModule(moduleType, module), logs[i].emitter);
        } else if (logs[i].topics[0] == 0x341347516a9de374859dfda710fa4828b2d48cb57d4fbe4c1149612b8e02276e) {
            (uint256 moduleType, address module) = abi.decode(logs[i].data, (uint256, address));
            InstalledModule[] memory installedModules = getInstalledModules(logs[i].emitter);
            for (uint256 j; j < installedModules.length; j++) {
                if ((installedModules[j].moduleAddress == module) && (installedModules[j].moduleType == moduleType)) {
                    removeInstalledModule(j, logs[i].emitter);
                    break;
                }
            }
        }
    }
    string memory gasIdentifier = getGasIdentifier();
    if ((envOr("GAS", false) && (bytes(gasIdentifier).length > 0)) && (bytes(gasIdentifier).length < 50)) {
        calculateGas(userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas);
    }
    for (uint256 i; i < userOps.length; i++) {
        emit ModuleKitLogs.ModuleKit_Exec4337(userOps[i].sender);
    }
}
```

### getExpectRevert()

- **Kind**: free-function
- **Source**: 588:163:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getExpectRevert()`

```solidity
function getExpectRevert() view returns (uint256 value) {
    bytes32 slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        value := sload(slot)
    }
}
```

### getSimulateUserOp()

- **Kind**: free-function
- **Source**: 1949:166:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getSimulateUserOp()`

```solidity
function getSimulateUserOp() view returns (bool value) {
    bytes32 slot = keccak256("ModuleKit.SimulateUserOp");
    assembly {
        value := sload(slot)
    }
}
```

### simulateUserOp(struct PackedUserOperation,address)

- **Kind**: internal
- **Source**: 1279:1591:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:simulateUserOp(struct PackedUserOperation,address)`

```solidity
///  Simulates a UserOperation and validates the ERC-4337 rules
///  @dev This function will revert if the UserOperation is invalid
///  @dev If the simulation fails, the rules might not be checked correctly so simulationSuccess
///  should be handled accordingly
///  @dev This function is used for v0.7 ERC-4337
///  @param userOp The PackedUserOperation to simulate
///  @param onEntryPoint The address of the entry point to simulate the UserOperation on
///  @return simulationSuccess True if the simulation was successful, false otherwise
function simulateUserOp(PackedUserOperation memory userOp, address onEntryPoint) internal returns (bool simulationSuccess) {
    _preSimulation();
    bytes memory epCallData = abi.encodeCall(IEntryPointSimulations.simulateValidation, (userOp));
    bytes memory returnData;
    (simulationSuccess, returnData) = address(onEntryPoint).call(epCallData);
    if (!simulationSuccess) {
        return simulationSuccess;
    }
    IEntryPointSimulations.ValidationResult memory result = abi.decode(returnData, (IEntryPointSimulations.ValidationResult));
    if (result.returnInfo.accountValidationData != 0) {
        bool sigFailed = (result.returnInfo.accountValidationData & 1) == 1;
        if (sigFailed) {
            simulationSuccess = false;
        }
    }
    UserOperationDetails memory userOpDetails = UserOperationDetails({entryPoint: onEntryPoint, sender: userOp.sender, initCode: userOp.initCode, paymasterAndData: userOp.paymasterAndData});
    _postSimulation(userOpDetails);
}
```

### _preSimulation()

- **Kind**: internal
- **Source**: 4794:514:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:_preSimulation()`

```solidity
///  Pre-simulation setup
function _preSimulation() internal {
    uint256 snapShotId = snapshotState();
    bytes32 snapShotSlot = keccak256(abi.encodePacked("Simulator.SnapshotId"));
    assembly {
        sstore(snapShotSlot, snapShotId)
    }
    startMappingRecording();
    startDebugTraceRecording();
}
```

### snapshotState()

- **Kind**: free-function
- **Source**: 394:86:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:snapshotState()`

```solidity
function snapshotState() returns (uint256) {
    return Vm(VM_ADDR).snapshotState();
}
```

### startMappingRecording()

- **Kind**: free-function
- **Source**: 579:77:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:startMappingRecording()`

```solidity
function startMappingRecording() {
    Vm(VM_ADDR).startMappingRecording();
}
```

### startDebugTraceRecording()

- **Kind**: free-function
- **Source**: 961:83:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:startDebugTraceRecording()`

```solidity
function startDebugTraceRecording() {
    Vm(VM_ADDR).startDebugTraceRecording();
}
```

### _postSimulation(struct UserOperationDetails)

- **Kind**: internal
- **Source**: 5436:688:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:_postSimulation(struct UserOperationDetails)`

```solidity
///  Post-simulation validation
///  @param userOpDetails The UserOperationDetails to validate
function _postSimulation(UserOperationDetails memory userOpDetails) internal {
    VmSafe.DebugStep[] memory debugTrace = stopAndReturnDebugTraceRecording();
    ERC4337SpecsParser.parseValidation(userOpDetails, debugTrace);
    stopMappingRecording();
    uint256 snapShotId;
    bytes32 snapShotSlot = keccak256(abi.encodePacked("Simulator.SnapshotId"));
    assembly {
        snapShotId := sload(snapShotSlot)
    }
    revertToState(snapShotId);
}
```

### stopAndReturnDebugTraceRecording()

- **Kind**: free-function
- **Source**: 1046:148:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:stopAndReturnDebugTraceRecording()`

```solidity
function stopAndReturnDebugTraceRecording() returns (VmSafe.DebugStep[] memory steps) {
    return Vm(VM_ADDR).stopAndReturnDebugTraceRecording();
}
```

### parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[])

- **Kind**: internal
- **Source**: 1656:1779:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[])`

```solidity
///  Parses and validates the ERC-4337 rules
///  @param userOpDetails The UserOperationDetails to validate
///  @param debugTrace A trace of used opcodes, stack and memory to validate
function parseValidation(UserOperationDetails memory userOpDetails, VmSafe.DebugStep[] memory debugTrace) internal {
    Entities memory entities = getEntities(userOpDetails);
    (VmSafe.DebugStep[] memory filteredUserOpSteps, VmSafe.DebugStep[] memory filteredPaymasterUserOpSteps) = filterDebugTrace(debugTrace, entities, userOpDetails.entryPoint);
    validateBannedOpcodes(filteredUserOpSteps, entities);
    validateBannedOpcodes(filteredPaymasterUserOpSteps, entities);
    validateOutOfGas(filteredUserOpSteps);
    validateOutOfGas(filteredPaymasterUserOpSteps);
    validateBannedStorageLocations(filteredUserOpSteps, entities, userOpDetails);
    validateBannedStorageLocations(filteredPaymasterUserOpSteps, entities, userOpDetails);
    validateCalls(filteredUserOpSteps, entities, userOpDetails.entryPoint);
    validateCalls(filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint);
    validateExtOpcodes(filteredUserOpSteps, entities);
    validateExtOpcodes(filteredPaymasterUserOpSteps, entities);
    validateCreate(filteredUserOpSteps, entities, userOpDetails);
    validateCreate(filteredPaymasterUserOpSteps, entities, userOpDetails);
}
```

### getEntities(struct UserOperationDetails)

- **Kind**: internal
- **Source**: 25300:1252:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:getEntities(struct UserOperationDetails)`

```solidity
///  Returns the entities of the UserOperation
///  @param userOpDetails The UserOperationDetails to get the entities of
///  @return entities The entities of the UserOperation
function getEntities(UserOperationDetails memory userOpDetails) internal view returns (Entities memory entities) {
    address factory;
    if (userOpDetails.initCode.length > 20) {
        bytes memory initCode = userOpDetails.initCode;
        assembly {
            factory := mload(add(initCode, 20))
        }
    }
    address paymaster;
    if (userOpDetails.paymasterAndData.length > 20) {
        bytes memory paymasterAndData = userOpDetails.paymasterAndData;
        assembly {
            paymaster := mload(add(paymasterAndData, 20))
        }
    }
    address aggregator;
    entities = Entities({account: userOpDetails.sender, factory: factory, isFactoryStaked: isStaked(factory, userOpDetails.entryPoint), paymaster: paymaster, isPaymasterStaked: isStaked(paymaster, userOpDetails.entryPoint), aggregator: aggregator, isAggregatorStaked: isStaked(aggregator, userOpDetails.entryPoint)});
}
```

### isStaked(address,address)

- **Kind**: internal
- **Source**: 28211:470:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isStaked(address,address)`

```solidity
///  Returns whether the entity is staked
///  @param entity The entity to check
///  @return isEntityStaked Whether the entity is staked
function isStaked(address entity, address entryPoint) internal view returns (bool isEntityStaked) {
    IStakeManager.DepositInfo memory deposit = IStakeManager(entryPoint).getDepositInfo(entity);
    isEntityStaked = (deposit.stake >= MIN_STAKE_VALUE) && (deposit.unstakeDelaySec >= MIN_UNSTAKE_DELAY);
}
```

### filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 6062:2998:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Filter debug trace, we are interested in the following debug traces:
///  - Entrypoint -> validateUserOp
///  - Entrypoint - validatePaymasterUserOp
///  @param debugTrace The debug trace to filter
///  @param entities The entities of the userOp
///  @param entryPoint The entryPoint address
///  @return filteredUserOpSteps The filtered debug steps
///  @return filteredPaymasterUserOpSteps The filtered debug steps
function filterDebugTrace(VmSafe.DebugStep[] memory debugTrace, Entities memory entities, address entryPoint) private pure returns (VmSafe.DebugStep[] memory, VmSafe.DebugStep[] memory) {
    VmSafe.DebugStep[] memory filteredUserOpSteps = new VmSafe.DebugStep[](debugTrace.length);
    VmSafe.DebugStep[] memory filteredPaymasterUserOpSteps = new VmSafe.DebugStep[](debugTrace.length);
    uint256 filteredUserOpStepsLength;
    uint256 filteredPaymasterUserOpStepsLength;
    uint256 startDepth = 0;
    for (uint256 i; i < debugTrace.length; i++) {
        if (debugTrace[i].contractAddr == entryPoint) {
            startDepth = debugTrace[i].depth;
            break;
        }
    }
    address currentContractAddr;
    for (uint256 i = 0; i < debugTrace.length; i++) {
        if ((debugTrace[i].depth == startDepth) && (debugTrace[i].contractAddr == entryPoint)) {
            if ((debugTrace[i].opcode == 0xF1) || (debugTrace[i].opcode == 0xFA)) {
                currentContractAddr = address(uint160(uint256(debugTrace[i].stack[1])));
            }
            continue;
        }
        if (debugTrace[i].depth > startDepth) {
            if (currentContractAddr == entities.account) {
                filteredUserOpSteps[filteredUserOpStepsLength++] = debugTrace[i];
            } else if (currentContractAddr == entities.paymaster) {
                filteredPaymasterUserOpSteps[filteredPaymasterUserOpStepsLength++] = debugTrace[i];
            }
        }
    }
    assembly {
        mstore(filteredUserOpSteps, filteredUserOpStepsLength)
        mstore(filteredPaymasterUserOpSteps, filteredPaymasterUserOpStepsLength)
    }
    return (filteredUserOpSteps, filteredPaymasterUserOpSteps);
}
```

### validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)

- **Kind**: internal
- **Source**: 3559:2043:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)`

```solidity
///  Validates that no banned opcodes are used
///  @param debugTrace The debug trace to validate
function validateBannedOpcodes(VmSafe.DebugStep[] memory debugTrace, Entities memory entities) internal pure {
    for (uint256 i; i < debugTrace.length; i++) {
        if (isForbiddenOpcode(debugTrace[i].opcode)) {
            if (debugTrace[i].opcode == 0x5A) {
                if (((i + 1) >= debugTrace.length) || ((((debugTrace[i + 1].opcode != 0xF1) && (debugTrace[i + 1].opcode != 0xF4)) && (debugTrace[i + 1].opcode != 0xF2)) && (debugTrace[i + 1].opcode != 0xFA))) {
                    revert InvalidOpcode(debugTrace[i].contractAddr, 0x5A);
                }
            } else if (((debugTrace[i].opcode == 0x31) || (debugTrace[i].opcode == 0x47)) && isEntityAndStaked(entities, debugTrace[i].contractAddr)) {
                continue;
            } else {
                revert InvalidOpcode(debugTrace[i].contractAddr, debugTrace[i].opcode);
            }
        }
    }
}
```

### isForbiddenOpcode(uint8)

- **Kind**: internal
- **Source**: 29220:729:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isForbiddenOpcode(uint8)`

```solidity
///  Checks if the opcode is a forbidden opcode
///  @param opcode The opcode to check
///  @return isForbidden Whether the opcode is forbidden
function isForbiddenOpcode(uint8 opcode) private pure returns (bool isForbidden) {
    return ((((((((((((((opcode == 0x3A) || (opcode == 0x45)) || (opcode == 0x44)) || (opcode == 0x42)) || (opcode == 0x48)) || (opcode == 0x40)) || (opcode == 0x43)) || (opcode == 0x47)) || (opcode == 0x31)) || (opcode == 0x32)) || (opcode == 0x5A)) || (opcode == 0xF0)) || (opcode == 0x41)) || (opcode == 0xFE)) || (opcode == 0xFF);
}
```

### isEntityAndStaked(struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 26835:634:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isEntityAndStaked(struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Returns whether something is an entity and is staked
///  @param entities The entities of the UserOperation
///  @param toCheck The address to check
///  @return addressIsEntityAndStaked Whether the address is an entity and is staked
function isEntityAndStaked(Entities memory entities, address toCheck) internal pure returns (bool addressIsEntityAndStaked) {
    if (toCheck == entities.account) {
        addressIsEntityAndStaked = true;
    } else if (toCheck == entities.factory) {
        addressIsEntityAndStaked = entities.isFactoryStaked;
    } else if (toCheck == entities.paymaster) {
        addressIsEntityAndStaked = entities.isPaymasterStaked;
    } else if (toCheck == entities.aggregator) {
        addressIsEntityAndStaked = entities.isAggregatorStaked;
    }
}
```

### validateOutOfGas(struct VmSafe.DebugStep[])

- **Kind**: internal
- **Source**: 9203:345:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateOutOfGas(struct VmSafe.DebugStep[])`

```solidity
///  Validate that the simulation does not revert with Out of Gas
///  @param debugTrace The debug trace to validate
function validateOutOfGas(VmSafe.DebugStep[] memory debugTrace) internal pure {
    for (uint256 i; i < debugTrace.length; i++) {
        if (debugTrace[i].isOutOfGas) {
            revert("[OP-020] Simulation reverts with Out of Gas");
        }
    }
}
```

### validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)

- **Kind**: internal
- **Source**: 9851:4230:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)`

```solidity
///  Validates that no banned storage locations are accessed
///  @param debugTrace The debug trace to validate
///  @param entities  The entities of the userOp
///  @param userOpDetails The UserOperationDetails to validate
function validateBannedStorageLocations(VmSafe.DebugStep[] memory debugTrace, Entities memory entities, UserOperationDetails memory userOpDetails) internal {
    for (uint256 i; i < debugTrace.length; i++) {
        VmSafe.DebugStep memory currentStep = debugTrace[i];
        if ((((currentStep.opcode != 0x54) && (currentStep.opcode != 0x55)) && (currentStep.opcode != 0x5C)) && (currentStep.opcode != 0x5D)) {
            continue;
        }
        address currentAccessAccount = currentStep.contractAddr;
        bytes32 currentSlot = bytes32(uint256(currentStep.stack[0]));
        bool notEntity = !isEntity(entities, currentAccessAccount);
        if (currentAccessAccount == entities.account) {
            continue;
        }
        /// Access to associated storage of the account in an external (non-entity) contract
        bool accountAlreadyExists = (entities.account.code.length != 0) || ((currentAccessAccount == userOpDetails.entryPoint) && (entities.account != address(0)));
        bool isFactoryStaked = entities.isFactoryStaked;
        if ((notEntity && isAssociatedStorage(currentSlot, currentAccessAccount, entities.account)) && (accountAlreadyExists || isFactoryStaked)) {
            continue;
        }
        if (entities.isFactoryStaked || entities.isPaymasterStaked) {
            if (((currentAccessAccount == entities.factory) && entities.isFactoryStaked) || ((currentAccessAccount == entities.paymaster) && entities.isPaymasterStaked)) {
                continue;
            } else if (notEntity && ((isAssociatedStorage(currentSlot, currentAccessAccount, entities.factory) && entities.isFactoryStaked) || (isAssociatedStorage(currentSlot, currentAccessAccount, entities.paymaster) && entities.isPaymasterStaked))) {
                continue;
            } else if (notEntity && ((currentStep.opcode == 0x54) || (currentStep.opcode == 0x5C))) {
                continue;
            }
        }
        bool isWrite = (currentStep.opcode == 0x55) || (currentStep.opcode == 0x5D);
        revert InvalidStorageLocation(currentAccessAccount, getLabel(currentAccessAccount), currentSlot, isWrite ? bytes32(uint256(currentStep.stack[1])) : bytes32(0), isWrite);
    }
}
```

### isEntity(struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 27643:388:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isEntity(struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Returns wether something is an entity
///  @param entities The entities of the UserOperation
///  @param toCheck The address to check
function isEntity(Entities memory entities, address toCheck) internal pure returns (bool addressIsEntity) {
    if ((((toCheck == entities.account) || (toCheck == entities.factory)) || (toCheck == entities.paymaster)) || (toCheck == entities.aggregator)) {
        addressIsEntity = true;
    }
}
```

### isAssociatedStorage(bytes32,address,address)

- **Kind**: internal
- **Source**: 20836:774:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isAssociatedStorage(bytes32,address,address)`

```solidity
///  Returns whether the current storage slot matches a specific entity
///  @param currentSlot The current storage slot
///  @param currentAccessAccount The contract address of the current access
///  @param entity The entity to check
///  @return isAssociated Whether the current storage slot matches a specific entity
function isAssociatedStorage(bytes32 currentSlot, address currentAccessAccount, address entity) internal returns (bool isAssociated) {
    if (slotMatchesEntity(currentSlot, entity)) {
        isAssociated = true;
    } else {
        (bool found, bytes32 key) = getMappingParent(currentAccessAccount, currentSlot);
        if (found) {
            if (slotMatchesEntity(key, entity)) {
                isAssociated = true;
            }
        }
    }
}
```

### slotMatchesEntity(bytes32,address)

- **Kind**: internal
- **Source**: 23408:355:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:slotMatchesEntity(bytes32,address)`

```solidity
///  Returns whether the current storage slot matches an entity
///  @param slot The current storage slot
///  @param entity The entity to check
///  @return _ Whether the current storage slot matches an entity
function slotMatchesEntity(bytes32 slot, address entity) internal pure returns (bool) {
    if (slot == bytes32(0)) {
        return false;
    }
    return slot == bytes32(uint256(uint160(entity)));
}
```

### getMappingParent(address,bytes32)

- **Kind**: internal
- **Source**: 24067:1014:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:getMappingParent(address,bytes32)`

```solidity
///  Returns the parent of the current storage slot
///  @param currentAccessAccount The contract address of the current access
///  @param currentSlot The current storage slot
///  @return found Whether the parent was found
///  @return key The parent slot
function getMappingParent(address currentAccessAccount, bytes32 currentSlot) internal returns (bool found, bytes32 key) {
    (bool _found, bytes32 _key, ) = getMappingKeyAndParentOf(currentAccessAccount, currentSlot);
    if (_found) {
        found = _found;
        key = _key;
    } else {
        for (uint256 k = 1; (k <= 128) && (k <= uint256(currentSlot)); k++) {
            (_found, _key, ) = getMappingKeyAndParentOf(currentAccessAccount, bytes32(uint256(currentSlot) - k));
            if (_found) {
                found = _found;
                key = _key;
                break;
            }
        }
    }
}
```

### getMappingKeyAndParentOf(address,bytes32)

- **Kind**: free-function
- **Source**: 735:163:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:getMappingKeyAndParentOf(address,bytes32)`

```solidity
function getMappingKeyAndParentOf(address target, bytes32 slot) returns (bool, bytes32, bytes32) {
    return Vm(VM_ADDR).getMappingKeyAndParentOf(target, slot);
}
```

### getLabel(address)

- **Kind**: free-function
- **Source**: 289:103:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:getLabel(address)`

```solidity
function getLabel(address addr) view returns (string memory) {
    return Vm(VM_ADDR).getLabel(addr);
}
```

### validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 14362:2479:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Validates *CALL operations in the trace (CALL, DELEGATECALL, CALLCODE, STATICCALL)
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
///  @param entryPoint The EntryPoint contract address
function validateCalls(VmSafe.DebugStep[] memory debugSteps, Entities memory entities, address entryPoint) internal view {
    for (uint256 i = 0; i < debugSteps.length; i++) {
        uint8 op = debugSteps[i].opcode;
        if ((((op != 0xF1) && (op != 0xF2)) && (op != 0xF4)) && (op != 0xFA)) {
            continue;
        }
        address targetAddr = address(uint160(uint256(debugSteps[i].stack[1])));
        uint256 value = ((op == 0xF1) || (op == 0xF2)) ? uint256(debugSteps[i].stack[2]) : 0;
        bytes memory callData = debugSteps[i].memoryInput;
        if (((targetAddr.code.length == 0) && (!isPrecompile(targetAddr))) && (targetAddr != entities.account)) {
            revert("[OP-041] Cannot *CALL addresses without code");
        }
        bool callerIsAccount = debugSteps[i].contractAddr == entities.account;
        bool callerIsFactory = debugSteps[i].contractAddr == entities.factory;
        bool calleeIsEntryPoint = targetAddr == entryPoint;
        if (value > 0) {
            if (!((callerIsAccount || callerIsFactory) && calleeIsEntryPoint)) {
                revert("[OP-061] Cannot use value except from account or factory to EntryPoint");
            }
        }
        if (calleeIsEntryPoint) {
            bytes4 selector;
            if (callData.length >= 4) {
                selector = bytes4(abi.encodePacked(callData[0], callData[1], callData[2], callData[3]));
            }
            if (!(((callerIsAccount || callerIsFactory) && (selector == bytes4(0xb760faf9))) || (callerIsAccount && (callData.length == 0)))) {
                revert("[OP-052] Cannot call EntryPoint except depositTo from factory or account");
            }
        }
    }
}
```

### isPrecompile(address)

- **Kind**: internal
- **Source**: 28874:160:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isPrecompile(address)`

```solidity
///  Returns whether the address is a precompile
///  @param target The address to check
///  @return isPrecompile Whether the address is a precompile
function isPrecompile(address target) internal pure returns (bool) {
    return (uint256(uint160(target)) <= 0x09) || (uint256(uint160(target)) == 0x100);
}
```

### validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)

- **Kind**: internal
- **Source**: 17061:862:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)`

```solidity
///  Validates EXT* operations in the trace (EXTCODESIZE, EXTCODEHASH, EXTCODECOPY)
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
function validateExtOpcodes(VmSafe.DebugStep[] memory debugSteps, Entities memory entities) internal view {
    for (uint256 i = 0; i < debugSteps.length; i++) {
        uint8 op = debugSteps[i].opcode;
        if (((op != 0x3B) && (op != 0x3C)) && (op != 0x3F)) {
            continue;
        }
        address targetAddr = address(uint160(uint256(debugSteps[i].stack[0])));
        if (((targetAddr.code.length == 0) && (!isPrecompile(targetAddr))) && (targetAddr != entities.account)) {
            revert("[OP-041] EXT* opcodes cannot access addresses without code");
        }
    }
}
```

### validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)

- **Kind**: internal
- **Source**: 18178:1122:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)`

```solidity
///  Validates CREATE operations in the trace
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
///  @param userOpDetails The UserOperationDetails containing initCode
function validateCreate(VmSafe.DebugStep[] memory debugSteps, Entities memory entities, UserOperationDetails memory userOpDetails) internal pure {
    uint256 createCount = 0;
    for (uint256 i = 0; i < debugSteps.length; i++) {
        if (debugSteps[i].opcode == 0xF5) {
            createCount++;
            if (userOpDetails.initCode.length == 0) {
                revert("[OP-031] CREATE2 not allowed without initCode");
            }
            if (createCount > 1) {
                revert("[OP-031] Multiple CREATE2 operations not allowed");
            }
            address createdAddr = address(uint160(uint256(debugSteps[i].stack[0])));
            if (createdAddr != entities.account) {
                revert("[OP-031] CREATE2 must deploy the account contract");
            }
        }
    }
}
```

### stopMappingRecording()

- **Kind**: free-function
- **Source**: 658:75:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:stopMappingRecording()`

```solidity
function stopMappingRecording() {
    Vm(VM_ADDR).stopMappingRecording();
}
```

### revertToState(uint256)

- **Kind**: free-function
- **Source**: 482:95:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:revertToState(uint256)`

```solidity
function revertToState(uint256 id) returns (bool) {
    return Vm(VM_ADDR).revertToState(id);
}
```

### recordLogs()

- **Kind**: free-function
- **Source**: 1458:55:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:recordLogs()`

```solidity
function recordLogs() {
    Vm(VM_ADDR).recordLogs();
}
```

### checkRevertMessage(bytes)

- **Kind**: internal
- **Source**: 6800:719:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:checkRevertMessage(bytes)`

```solidity
function checkRevertMessage(bytes memory actualReason) internal view {
    bytes memory revertMessage = getExpectRevertMessage();
    if (actualReason.length >= 4) {
        bytes4 actual = bytes4(actualReason);
        bytes4 expected = bytes4(revertMessage);
        if (actual == bytes4(0x65c8fd4d)) {
            return parseFailedOpWithRevert(actualReason, revertMessage);
        } else if (actual != expected) {
            revert InvalidRevertMessageBytes(revertMessage, actualReason);
        }
        return;
    }
    if (revertMessage.length != actualReason.length) {
        revert InvalidRevertMessageBytes(revertMessage, actualReason);
    }
}
```

### getExpectRevertMessage()

- **Kind**: free-function
- **Source**: 753:180:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getExpectRevertMessage()`

```solidity
function getExpectRevertMessage() view returns (bytes memory data) {
    bytes32 slot = keccak256("ModuleKit.ExpectMessageSlot");
    assembly {
        data := sload(slot)
    }
}
```

### parseFailedOpWithRevert(bytes,bytes)

- **Kind**: internal
- **Source**: 7525:1258:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:parseFailedOpWithRevert(bytes,bytes)`

```solidity
function parseFailedOpWithRevert(bytes memory actualReason, bytes memory revertMessage) internal pure {
    uint256 bytesOffset;
    assembly {
        let ptr := add(actualReason, 0x20)
        ptr := add(ptr, 0x04)
        ptr := add(ptr, 0x40)
        bytesOffset := mload(ptr)
    }
    bytes memory actual;
    assembly {
        let ptr := add(actualReason, 0x20)
        ptr := add(ptr, 0x04)
        ptr := add(ptr, bytesOffset)
        let innerLength := mload(ptr)
        actual := mload(0x40)
        mstore(actual, innerLength)
        let srcPtr := add(ptr, 0x20)
        let destPtr := add(actual, 0x20)
        mstore(destPtr, mload(srcPtr))
        mstore(0x40, add(add(actual, 0x20), innerLength))
    }
    if (revertMessage.length == 4) {
        bytes4 expected = bytes4(revertMessage);
        if (expected != bytes4(actual)) {
            revert InvalidRevertMessage(expected, bytes4(actual));
        }
    } else {
        if (keccak256(actual) != keccak256(revertMessage)) {
            revert InvalidRevertMessageBytes(revertMessage, actual);
        }
    }
}
```

### getRecordedLogs()

- **Kind**: free-function
- **Source**: 1515:102:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:getRecordedLogs()`

```solidity
function getRecordedLogs() returns (VmSafe.Log[] memory) {
    return Vm(VM_ADDR).getRecordedLogs();
}
```

### getUserOpRevertReason(struct VmSafe.Log[],bytes32)

- **Kind**: internal
- **Source**: 6247:547:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:getUserOpRevertReason(struct VmSafe.Log[],bytes32)`

```solidity
function getUserOpRevertReason(VmSafe.Log[] memory logs, bytes32 userOpHash) internal pure returns (bytes memory revertReason) {
    for (uint256 i; i < logs.length; i++) {
        if ((logs[i].topics[0] == 0x1c4fada7374c0a9ee8841fc38afe82932dc0f8e69012e927f061a8bae611a201) && (logs[i].topics[1] == userOpHash)) {
            (, revertReason) = abi.decode(logs[i].data, (uint256, bytes));
        }
    }
}
```

### getLabel(address)

- **Kind**: free-function
- **Source**: 1066:103:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:getLabel(address)`

```solidity
function getLabel(address addr) view returns (string memory) {
    return Vm(VM_ADDR).getLabel(addr);
}
```

### clearExpectRevert()

- **Kind**: free-function
- **Source**: 935:230:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:clearExpectRevert()`

```solidity
function clearExpectRevert() {
    bytes32 slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        sstore(slot, 0)
    }
    slot = keccak256("ModuleKit.ExpectMessageSlot");
    assembly {
        sstore(slot, 0)
    }
}
```

### writeInstalledModule(struct InstalledModule,address)

- **Kind**: free-function
- **Source**: 6700:1960:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeInstalledModule(struct InstalledModule,address)`

```solidity
// Failed to render writeInstalledModule(struct InstalledModule,address) implementation (FunctionDefinition#96186). Check logs for details.
```

### getInstalledModules(address)

- **Kind**: free-function
- **Source**: 10596:2115:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getInstalledModules(address)`

```solidity
function getInstalledModules(address account) view returns (InstalledModule[] memory modules) {
    bytes32 lengthSlot = keccak256(abi.encode("ModuleKit.InstalledModuleSlot.", keccak256(abi.encodePacked(account))));
    bytes32 headSlot = keccak256(abi.encode("ModuleKit.InstalledModuleHead.", keccak256(abi.encodePacked(account))));
    assembly {
        let length := sload(lengthSlot)
        let structSize := 0x40
        let size := mul(length, structSize)
        let totalSize := add(add(size, 0x40), mul(0x20, length))
        let freeMemoryPtr := mload(0x40)
        modules := freeMemoryPtr
        mstore(modules, length)
        mstore(0x40, add(freeMemoryPtr, totalSize))
        let storageLocation := sload(headSlot)
        for {
            let i := 0
        } lt(i, length) {
            i := add(i, 1)
        } {
            let structLocation := add(add(freeMemoryPtr, add(0x40, mul(i, structSize))), mul(0x20, length))
            let moduleType := sload(storageLocation)
            let moduleAddress := sload(add(storageLocation, 0x20))
            mstore(add(freeMemoryPtr, add(0x20, mul(i, 0x20))), structLocation)
            mstore(structLocation, moduleType)
            mstore(add(structLocation, 0x20), moduleAddress)
            storageLocation := sload(add(storageLocation, 0x60))
        }
    }
}
```

### removeInstalledModule(uint256,address)

- **Kind**: free-function
- **Source**: 8701:1838:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:removeInstalledModule(uint256,address)`

```solidity
function removeInstalledModule(uint256 index, address account) {
    bytes32 lengthSlot = keccak256(abi.encode("ModuleKit.InstalledModuleSlot.", keccak256(abi.encodePacked(account))));
    bytes32 headSlot = keccak256(abi.encode("ModuleKit.InstalledModuleHead.", keccak256(abi.encodePacked(account))));
    bytes32 tailSlot = keccak256(abi.encode("ModuleKit.InstalledModuleTail.", keccak256(abi.encodePacked(account))));
    assembly {
        let length := sload(lengthSlot)
        let elementSlot := sload(headSlot)
        if lt(index, length) {
            for {
                let i := 0
            } lt(i, index) {
                i := add(i, 1)
            } {
                elementSlot := sload(add(elementSlot, 0x60))
            }
            let prevSlot := sload(add(elementSlot, 0x40))
            let nextSlot := sload(add(elementSlot, 0x60))
            sstore(add(prevSlot, 0x60), nextSlot)
            sstore(add(nextSlot, 0x40), prevSlot)
            if eq(elementSlot, sload(headSlot)) {
                sstore(headSlot, nextSlot)
            }
            if eq(elementSlot, sload(tailSlot)) {
                sstore(tailSlot, prevSlot)
            }
            sstore(elementSlot, 0)
            sstore(add(elementSlot, 0x20), 0)
            sstore(add(elementSlot, 0x40), 0)
            sstore(add(elementSlot, 0x60), 0)
            sstore(lengthSlot, sub(length, 1))
        }
    }
}
```

### getGasIdentifier()

- **Kind**: free-function
- **Source**: 1476:151:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getGasIdentifier()`

```solidity
function getGasIdentifier() view returns (string memory id) {
    bytes32 slot = keccak256("ModuleKit.GasIdentifierSlot");
    id = readString(slot);
}
```

### readString(bytes32)

- **Kind**: free-function
- **Source**: 13545:742:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:readString(bytes32)`

```solidity
function readString(bytes32 slot) view returns (string memory) {
    uint256 length;
    assembly {
        length := sload(slot)
    }
    bytes memory strBytes = new bytes(length);
    for (uint256 i = 0; i < length; i += 32) {
        bytes32 charSlot = keccak256(abi.encodePacked(slot, i / 32));
        bytes32 data;
        assembly {
            data := sload(charSlot)
        }
        for (uint256 j = 0; (j < 32) && ((i + j) < length); j++) {
            strBytes[i + j] = bytes1(uint8(uint256(data >> (248 - (j * 8)))));
        }
    }
    return string(strBytes);
}
```

### calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256)

- **Kind**: internal
- **Source**: 8789:510:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256)`

```solidity
function calculateGas(PackedUserOperation[] memory userOps, IEntryPoint onEntryPoint, address beneficiary, string memory gasIdentifier, uint256 totalUserOpGas) internal {
    bytes memory userOpCalldata = abi.encodeWithSelector(onEntryPoint.handleOps.selector, userOps, beneficiary);
    GasParser.parseAndWriteGas(userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas);
}
```

### parseAndWriteGas(bytes,address,string,address,uint256)

- **Kind**: internal
- **Source**: 243:1164:246
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasParser.sol:GasParser:parseAndWriteGas(bytes,address,string,address,uint256)`

```solidity
function parseAndWriteGas(bytes memory userOpCalldata, address entrypoint, string memory gasIdentifier, address sender, uint256 totalUserOpGas) internal {
    string memory fileName = string.concat("./gas_calculations/", gasIdentifier, ".json");
    GasCalculations memory gasCalculations = GasCalculations({creation: GasDebug(entrypoint).getGasConsumed(sender, 0), validation: GasDebug(entrypoint).getGasConsumed(sender, 1), execution: GasDebug(entrypoint).getGasConsumed(sender, 2), total: totalUserOpGas, arbitrum: getArbitrumL1Gas(userOpCalldata), opStack: getOpStackL1Gas(userOpCalldata)});
    GasCalculations memory prevGasCalculations;
    if (exists(fileName)) {
        string memory fileContent = readFile(fileName);
        prevGasCalculations = parsePrevGasReport(fileContent);
    }
    string memory finalJson = formatGasToWrite(gasIdentifier, prevGasCalculations, gasCalculations);
    writeJson(finalJson, fileName);
    writeGasIdentifier("");
}
```

### getArbitrumL1Gas(bytes)

- **Kind**: free-function
- **Source**: 1197:185:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getArbitrumL1Gas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata on Arbitrum L1.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata on Arbitrum L1.
function getArbitrumL1Gas(bytes memory data) pure returns (uint256 calldataGas) {
    bytes memory compressed = LibZip.flzCompress(data);
    calldataGas = getCallDataGas(compressed);
}
```

### flzCompress(bytes)

- **Kind**: internal
- **Source**: 1102:3958:322
- **Link**: `lib/v2-core/lib/solady/src/utils/LibZip.sol:LibZip:flzCompress(bytes)`

```solidity
/// @dev Returns the compressed `data`.
function flzCompress(bytes memory data) internal pure returns (bytes memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        function ms8 (d_, v_) -> _d {
            mstore8(d_, v_)
            _d := add(d_, 1)
        }
        function u24 (p_) -> _u {
            _u := mload(p_)
            _u := or(shl(16, byte(2, _u)), or(shl(8, byte(1, _u)), byte(0, _u)))
        }
        function cmp (p_, q_, e_) -> _l {
            for {
                e_ := sub(e_, q_)
            } lt(_l, e_) {
                _l := add(_l, 1)
            } {
                e_ := mul(iszero(byte(0, xor(mload(add(p_, _l)), mload(add(q_, _l))))), e_)
            }
        }
        function literals (runs_, src_, dest_) -> _o {
            for {
                _o := dest_
            } iszero(lt(runs_, 0x20)) {
                runs_ := sub(runs_, 0x20)
            } {
                mstore(ms8(_o, 31), mload(src_))
                _o := add(_o, 0x21)
                src_ := add(src_, 0x20)
            }
            if iszero(runs_) {
                leave
            }
            mstore(ms8(_o, sub(runs_, 1)), mload(src_))
            _o := add(1, add(_o, runs_))
        }
        function mt (l_, d_, o_) -> _o {
            for {
                d_ := sub(d_, 1)
            } iszero(lt(l_, 263)) {
                l_ := sub(l_, 262)
            } {
                o_ := ms8(ms8(ms8(o_, add(224, shr(8, d_))), 253), and(0xff, d_))
            }
            if iszero(lt(l_, 7)) {
                _o := ms8(ms8(ms8(o_, add(224, shr(8, d_))), sub(l_, 7)), and(0xff, d_))
                leave
            }
            _o := ms8(ms8(o_, add(shl(5, l_), shr(8, d_))), and(0xff, d_))
        }
        function setHash (i_, v_) {
            let p_ := add(mload(0x40), shl(2, i_))
            mstore(p_, xor(mload(p_), shl(224, xor(shr(224, mload(p_)), v_))))
        }
        function getHash (i_) -> _h {
            _h := shr(224, mload(add(mload(0x40), shl(2, i_))))
        }
        function hash (v_) -> _r {
            _r := and(shr(19, mul(2654435769, v_)), 0x1fff)
        }
        function setNextHash (ip_, ipStart_) -> _ip {
            setHash(hash(u24(ip_)), sub(ip_, ipStart_))
            _ip := add(ip_, 1)
        }
        result := mload(0x40)
        calldatacopy(result, calldatasize(), 0x8000)
        let op := add(result, 0x8000)
        let a := add(data, 0x20)
        let ipStart := a
        let ipLimit := sub(add(ipStart, mload(data)), 13)
        for {
            let ip := add(2, a)
        } lt(ip, ipLimit) {} {
            let r := 0
            let d := 0
            for {} 1 {} {
                let s := u24(ip)
                let h := hash(s)
                r := add(ipStart, getHash(h))
                setHash(h, sub(ip, ipStart))
                d := sub(ip, r)
                if iszero(lt(ip, ipLimit)) {
                    break
                }
                ip := add(ip, 1)
                if iszero(gt(d, 0x1fff)) {
                    if eq(s, u24(r)) {
                        break
                    }
                }
            }
            if iszero(lt(ip, ipLimit)) {
                break
            }
            ip := sub(ip, 1)
            if gt(ip, a) {
                op := literals(sub(ip, a), a, op)
            }
            let l := cmp(add(r, 3), add(ip, 3), add(ipLimit, 9))
            op := mt(l, d, op)
            ip := setNextHash(setNextHash(add(ip, l), ipStart), ipStart)
            a := ip
        }
        let end := sub(literals(sub(add(ipStart, mload(data)), a), a, op), 0x7fe0)
        let o := add(result, 0x20)
        mstore(result, sub(end, o))
        for {} iszero(gt(o, end)) {
            o := add(o, 0x20)
        } {
            mstore(o, mload(add(o, 0x7fe0)))
        }
        mstore(end, 0)
        mstore(0x40, add(end, 0x20))
    }
}
```

### getCallDataGas(bytes)

- **Kind**: free-function
- **Source**: 768:254:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getCallDataGas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata.
function getCallDataGas(bytes memory data) pure returns (uint256 calldataGas) {
    for (uint256 i = 0; i < data.length; i++) {
        if (data[i] == 0x00) {
            calldataGas += 4;
        } else {
            calldataGas += 16;
        }
    }
}
```

### getOpStackL1Gas(bytes)

- **Kind**: free-function
- **Source**: 1555:300:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getOpStackL1Gas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata on OpStack L1.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata on OpStack L1.
function getOpStackL1Gas(bytes memory data) pure returns (uint256 calldataGas) {
    uint256 opStackConstant = 2028;
    UD60x18 opStackScalar = ud(0.684e18);
    calldataGas = intoUint256(PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)) + opStackConstant;
}
```

### ud(uint256)

- **Kind**: free-function
- **Source**: 3445:86:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:ud(uint256)`

```solidity
/// @notice Alias for {wrap}.
function ud(uint256 x) pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### intoUint256(UD60x18)

- **Kind**: free-function
- **Source**: 2647:97:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:intoUint256(UD60x18)`

```solidity
/// @notice Casts a UD60x18 number into uint128.
///  @dev This is basically an alias for {unwrap}.
function intoUint256(UD60x18 x) pure returns (uint256 result) {
    result = UD60x18.unwrap(x);
}
```

### intoUD60x18(uint256)

- **Kind**: internal
- **Source**: 3135:112:109
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/casting/Uint256.sol:PRBMathCastingUint256:intoUD60x18(uint256)`

```solidity
/// @notice Casts a uint256 number to UD60x18.
function intoUD60x18(uint256 x) internal pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### mul(UD60x18,UD60x18)

- **Kind**: free-function
- **Source**: 18914:128:137
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Math.sol:mul(UD60x18,UD60x18)`

```solidity
/// @notice Multiplies two UD60x18 numbers together, returning a new UD60x18 number.
///  @dev Uses {Common.mulDiv} to enable overflow-safe multiplication and division.
///  Notes:
///  - Refer to the notes in {Common.mulDiv}.
///  Requirements:
///  - Refer to the requirements in {Common.mulDiv}.
///  @dev See the documentation in {Common.mulDiv18}.
///  @param x The multiplicand as a UD60x18 number.
///  @param y The multiplier as a UD60x18 number.
///  @return result The product as a UD60x18 number.
///  @custom:smtchecker abstract-function-nondet
function mul(UD60x18 x, UD60x18 y) pure returns (UD60x18 result) {
    result = wrap(Common.mulDiv18(x.unwrap(), y.unwrap()));
}
```

### wrap(uint256)

- **Kind**: free-function
- **Source**: 3865:88:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:wrap(uint256)`

```solidity
/// @notice Wraps a uint256 number into the UD60x18 value type.
function wrap(uint256 x) pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### mulDiv18(uint256,uint256)

- **Kind**: free-function
- **Source**: 19680:819:107
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/Common.sol:mulDiv18(uint256,uint256)`

```solidity
/// @notice Calculates x*y÷1e18 with 512-bit precision.
///  @dev A variant of {mulDiv} with constant folding, i.e. in which the denominator is hard coded to 1e18.
///  Notes:
///  - The body is purposely left uncommented; to understand how this works, see the documentation in {mulDiv}.
///  - The result is rounded toward zero.
///  - We take as an axiom that the result cannot be `MAX_UINT256` when x and y solve the following system of equations:
///  $$
///  \begin{cases}
///      x * y = MAX\_UINT256 * UNIT \\
///      (x * y) \% UNIT \geq \frac{UNIT}{2}
///  \end{cases}
///  $$
///  Requirements:
///  - Refer to the requirements in {mulDiv}.
///  - The result must fit in uint256.
///  @param x The multiplicand as an unsigned 60.18-decimal fixed-point number.
///  @param y The multiplier as an unsigned 60.18-decimal fixed-point number.
///  @return result The result as an unsigned 60.18-decimal fixed-point number.
///  @custom:smtchecker abstract-function-nondet
function mulDiv18(uint256 x, uint256 y) pure returns (uint256 result) {
    uint256 prod0;
    uint256 prod1;
    assembly ("memory-safe") {
        let mm := mulmod(x, y, not(0))
        prod0 := mul(x, y)
        prod1 := sub(sub(mm, prod0), lt(mm, prod0))
    }
    if (prod1 == 0) {
        unchecked {
            return prod0 / UNIT;
        }
    }
    if (prod1 >= UNIT) {
        revert PRBMath_MulDiv18_Overflow(x, y);
    }
    uint256 remainder;
    assembly ("memory-safe") {
        remainder := mulmod(x, y, UNIT)
        result := mul(or(div(sub(prod0, remainder), UNIT_LPOTD), mul(sub(prod1, gt(remainder, prod0)), add(div(sub(0, UNIT_LPOTD), UNIT_LPOTD), 1))), UNIT_INVERSE)
    }
}
```

### unwrap(UD60x18)

- **Kind**: free-function
- **Source**: 3707:92:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:unwrap(UD60x18)`

```solidity
/// @notice Unwraps a UD60x18 number into uint256.
function unwrap(UD60x18 x) pure returns (uint256 result) {
    result = UD60x18.unwrap(x);
}
```

### exists(string)

- **Kind**: free-function
- **Source**: 3719:96:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:exists(string)`

```solidity
function exists(string memory path) view returns (bool) {
    return Vm(VM_ADDR).exists(path);
}
```

### readFile(string)

- **Kind**: free-function
- **Source**: 3608:109:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:readFile(string)`

```solidity
function readFile(string memory path) view returns (string memory) {
    return Vm(VM_ADDR).readFile(path);
}
```

### parsePrevGasReport(string)

- **Kind**: free-function
- **Source**: 2023:722:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:parsePrevGasReport(string)`

```solidity
/// @notice Parse the previous gas report from a file.
///  @param fileContent The content of the file.
///  @return prevGasCalculations The previous gas calculations.
function parsePrevGasReport(string memory fileContent) pure returns (GasCalculations memory prevGasCalculations) {
    prevGasCalculations.total = parseUintFromASCII(parseJson(fileContent, ".Total"));
    prevGasCalculations.creation = parseUintFromASCII(parseJson(fileContent, ".Phases.Creation"));
    prevGasCalculations.validation = parseUintFromASCII(parseJson(fileContent, ".Phases.Validation"));
    prevGasCalculations.execution = parseUintFromASCII(parseJson(fileContent, ".Phases.Execution"));
    prevGasCalculations.arbitrum = parseUintFromASCII(parseJson(fileContent, ".Calldata.Arbitrum"));
    prevGasCalculations.opStack = parseUintFromASCII(parseJson(fileContent, ".Calldata.OP-Stack"));
}
```

### parseUintFromASCII(bytes)

- **Kind**: free-function
- **Source**: 2865:632:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:parseUintFromASCII(bytes)`

```solidity
/// @notice Parse a uint256 from ASCII.
///  @param ascii The ASCII to be parsed.
///  @return _ret The parsed uint256.
function parseUintFromASCII(bytes memory ascii) pure returns (uint256 _ret) {
    bytes memory prevTotal;
    uint256 offset = (ascii.length > 32) ? 32 : 0;
    for (uint256 i; i < ascii.length; i++) {
        if (ascii[i] == 0x28) {
            break;
        } else {
            if (i >= offset) {
                prevTotal = abi.encodePacked(prevTotal, ascii[i]);
            }
        }
    }
    uint256 j = 1;
    for (uint256 i = prevTotal.length - 1; i > 0; i--) {
        if ((uint8(prevTotal[i]) >= 48) && (uint8(prevTotal[i]) <= 57)) {
            _ret += (uint8(prevTotal[i]) - 48) * j;
            j *= 10;
        }
    }
}
```

### parseJson(string,string)

- **Kind**: free-function
- **Source**: 4352:134:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:parseJson(string,string)`

```solidity
function parseJson(string memory json, string memory key) pure returns (bytes memory) {
    return Vm(VM_ADDR).parseJson(json, key);
}
```

### formatGasToWrite(string,struct GasCalculations,struct GasCalculations)

- **Kind**: internal
- **Source**: 1413:2033:246
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasParser.sol:GasParser:formatGasToWrite(string,struct GasCalculations,struct GasCalculations)`

```solidity
function formatGasToWrite(string memory gasIdentifier, GasCalculations memory prevGasCalculations, GasCalculations memory gasCalculations) internal returns (string memory finalJson) {
    string memory jsonObj = string(abi.encodePacked(gasIdentifier));
    serializeString(jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total}));
    string memory phasesObj = "phases";
    serializeString(phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation}));
    serializeString(phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation}));
    string memory phasesOutput = serializeString(phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution}));
    string memory l2sObj = "l2s";
    serializeString(l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack}));
    string memory l2sOutput = serializeString(l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum}));
    serializeString(jsonObj, "Phases", phasesOutput);
    finalJson = serializeString(jsonObj, "Calldata", l2sOutput);
}
```

### serializeString(string,string,string)

- **Kind**: free-function
- **Source**: 3290:213:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:serializeString(string,string,string)`

```solidity
function serializeString(string memory objectKey, string memory valueKey, string memory value) returns (string memory json) {
    return Vm(VM_ADDR).serializeString(objectKey, valueKey, value);
}
```

### formatGasValue(uint256,uint256)

- **Kind**: free-function
- **Source**: 3669:445:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:formatGasValue(uint256,uint256)`

```solidity
/// @notice Format the gas value.
///  @param prevValue The previous gas value.
///  @param newValue The new gas value.
///  @return formattedValue The formatted gas value.
function formatGasValue(uint256 prevValue, uint256 newValue) pure returns (string memory formattedValue) {
    if (prevValue == 0) {
        formattedValue = string.concat(formatGas(int256(newValue)), " gas");
    } else {
        formattedValue = string.concat(formatGas(int256(newValue)), " gas (diff: ", formatGas(int256(newValue) - int256(prevValue)), ")");
    }
}
```

### formatGas(int256)

- **Kind**: free-function
- **Source**: 4268:455:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:formatGas(int256)`

```solidity
/// @notice Format the gas value with underscores for readability.
///  @param value The gas value to be formatted.
///  @return The formatted gas value.
function formatGas(int256 value) pure returns (string memory) {
    string memory str = toString(value);
    bytes memory bStr = bytes(str);
    bytes memory result = new bytes(bStr.length + ((bStr.length - 1) / 3));
    uint256 j = result.length;
    for (uint256 i = 0; i < bStr.length; i++) {
        if ((i > 0) && ((i % 3) == 0)) {
            result[--j] = "_";
        }
        result[--j] = bStr[(bStr.length - i) - 1];
    }
    return string(result);
}
```

### toString(int256)

- **Kind**: free-function
- **Source**: 3924:104:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:toString(int256)`

```solidity
function toString(int256 input) pure returns (string memory) {
    return Vm(VM_ADDR).toString(input);
}
```

### writeJson(string,string)

- **Kind**: free-function
- **Source**: 3505:101:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:writeJson(string,string)`

```solidity
function writeJson(string memory json, string memory path) {
    Vm(VM_ADDR).writeJson(json, path);
}
```

### writeGasIdentifier(string)

- **Kind**: free-function
- **Source**: 1337:137:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeGasIdentifier(string)`

```solidity
function writeGasIdentifier(string memory id) {
    bytes32 slot = keccak256("ModuleKit.GasIdentifierSlot");
    writeString(slot, id);
}
```

### writeString(bytes32,string)

- **Kind**: free-function
- **Source**: 12883:660:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeString(bytes32,string)`

```solidity
function writeString(bytes32 slot, string memory value) {
    bytes memory strBytes = bytes(value);
    uint256 length = strBytes.length;
    assembly {
        sstore(slot, length)
    }
    for (uint256 i = 0; i < length; i += 32) {
        bytes32 data;
        for (uint256 j = 0; (j < 32) && ((i + j) < length); j++) {
            data |= bytes32(uint256(uint8(strBytes[i + j])) << (248 - (j * 8)));
        }
        bytes32 charSlot = keccak256(abi.encodePacked(slot, i / 32));
        assembly {
            sstore(charSlot, data)
        }
    }
}
```

### _setupSuperLedger()

- **Kind**: internal
- **Source**: 81133:2333:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_setupSuperLedger()`

```solidity
function _setupSuperLedger() internal {
    console2.log("------ base test MANAGER", MANAGER);
    for (uint256 i; i < chainIds.length; ++i) {
        vm.selectFork(FORKS[chainIds[i]]);
        vm.startPrank(MANAGER);
        console2.log("------ A", MANAGER);
        ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[] memory configs = new ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[](4);
        configs[0] = ISuperLedgerConfiguration.YieldSourceOracleConfigArgs({yieldSourceOracle: _getContract(chainIds[i], ERC4626_YIELD_SOURCE_ORACLE_KEY), feePercent: 100, feeRecipient: TREASURY, ledger: _getContract(chainIds[i], SUPER_LEDGER_KEY)});
        configs[1] = ISuperLedgerConfiguration.YieldSourceOracleConfigArgs({yieldSourceOracle: _getContract(chainIds[i], ERC7540_YIELD_SOURCE_ORACLE_KEY), feePercent: 100, feeRecipient: TREASURY, ledger: _getContract(chainIds[i], SUPER_LEDGER_KEY)});
        configs[2] = ISuperLedgerConfiguration.YieldSourceOracleConfigArgs({yieldSourceOracle: _getContract(chainIds[i], ERC5115_YIELD_SOURCE_ORACLE_KEY), feePercent: 100, feeRecipient: TREASURY, ledger: _getContract(chainIds[i], ERC1155_LEDGER_KEY)});
        configs[3] = ISuperLedgerConfiguration.YieldSourceOracleConfigArgs({yieldSourceOracle: _getContract(chainIds[i], STAKING_YIELD_SOURCE_ORACLE_KEY), feePercent: 100, feeRecipient: TREASURY, ledger: _getContract(chainIds[i], SUPER_LEDGER_KEY)});
        bytes32[] memory salts = new bytes32[](4);
        salts[0] = bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY));
        salts[1] = bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY));
        salts[2] = bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY));
        salts[3] = bytes32(bytes(STAKING_YIELD_SOURCE_ORACLE_KEY));
        ISuperLedgerConfiguration(_getContract(chainIds[i], SUPER_LEDGER_CONFIGURATION_KEY)).setYieldSourceOracles(salts, configs);
        vm.stopPrank();
    }
}
```

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
}
```

### _fundUnderlyingTokens(uint256)

- **Kind**: internal
- **Source**: 80543:584:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_fundUnderlyingTokens(uint256)`

```solidity
function _fundUnderlyingTokens(uint256 amount) internal {
    for (uint256 j = 0; j < underlyingTokens.length; ++j) {
        for (uint256 i = 0; i < chainIds.length; ++i) {
            vm.selectFork(FORKS[chainIds[i]]);
            address token = existingUnderlyingTokens[chainIds[i]][underlyingTokens[j]];
            if (token != address(0)) {
                deal(token, accountInstances[chainIds[i]].account, amount * (10 ** IERC20Metadata(token).decimals()));
            }
        }
    }
}
```

### deal(address,address,uint256)

- **Kind**: internal
- **Source**: 27270:117:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256)`

```solidity
function deal(address token, address to, uint256 give) virtual internal {
    deal(token, to, give, false);
}
```

### deal(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 27666:837:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256,bool)`

```solidity
function deal(address token, address to, uint256 give, bool adjust) virtual internal {
    (, bytes memory balData) = token.staticcall(abi.encodeWithSelector(0x70a08231, to));
    uint256 prevBal = abi.decode(balData, (uint256));
    stdstore.target(token).sig(0x70a08231).with_key(to).checked_write(give);
    if (adjust) {
        (, bytes memory totSupData) = token.staticcall(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));
        if (give < prevBal) {
            totSup -= (prevBal - give);
        } else {
            totSup += (give - prevBal);
        }
        stdstore.target(token).sig(0x18160ddd).checked_write(totSup);
    }
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13254:156:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    return stdStorageSafe.target(self, _target);
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 6743:156:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    self._target = _target;
    return self;
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 13416:143:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    return stdStorageSafe.sig(self, _sig);
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 6905:143:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    self._sig = _sig;
    return self;
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13721:152:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    return stdStorageSafe.with_key(self, who);
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 7396:179:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    self._keys.push(bytes32(uint256(uint160(who))));
    return self;
}
```

### checked_write(struct StdStorage,uint256)

- **Kind**: internal
- **Source**: 14942:120:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,uint256)`

```solidity
function checked_write(StdStorage storage self, uint256 amt) internal {
    checked_write(self, bytes32(amt));
}
```

### checked_write(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 15434:1484:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,bytes32)`

```solidity
function checked_write(StdStorage storage self, bytes32 set) internal {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = stdStorageSafe.getCallParams(self);
    if (!self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        find(self, false);
    }
    FindData storage data = self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    if ((data.offsetLeft + data.offsetRight) > 0) {
        uint256 maxVal = 2 ** (256 - (data.offsetLeft + data.offsetRight));
        require(uint256(set) < maxVal, string(abi.encodePacked("stdStorage find(StdStorage): Packed slot. We can't fit value greater than ", vm.toString(maxVal))));
    }
    bytes32 curVal = vm.load(who, bytes32(data.slot));
    bytes32 valToSet = stdStorageSafe.getUpdatedSlotValue(curVal, uint256(set), data.offsetLeft, data.offsetRight);
    vm.store(who, bytes32(data.slot), valToSet);
    (bool success, bytes32 callResult) = stdStorageSafe.callTarget(self);
    if ((!success) || (callResult != set)) {
        vm.store(who, bytes32(data.slot), curVal);
        revert("stdStorage find(StdStorage): Failed to write value.");
    }
    clear(self);
}
```

### getCallParams(struct StdStorage)

- **Kind**: internal
- **Source**: 953:236:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getCallParams(struct StdStorage)`

```solidity
function getCallParams(StdStorage storage self) internal view returns (bytes memory) {
    if (self._calldata.length == 0) {
        return flatten(self._keys);
    } else {
        return self._calldata;
    }
}
```

### flatten(bytes32[])

- **Kind**: internal
- **Source**: 11182:393:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:flatten(bytes32[])`

```solidity
function flatten(bytes32[] memory b) private pure returns (bytes memory) {
    bytes memory result = new bytes(b.length * 32);
    for (uint256 i = 0; i < b.length; i++) {
        bytes32 k = b[i];
        /// @solidity memory-safe-assembly
        assembly {
            mstore(add(result, add(32, mul(32, i))), k)
        }
    }
    return result;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 13107:141:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:find(struct StdStorage,bool)`

```solidity
function find(StdStorage storage self, bool _clear) internal returns (uint256) {
    return stdStorageSafe.find(self, _clear).slot;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 4245:2492:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:find(struct StdStorage,bool)`

```solidity
/// @notice find an arbitrary storage slot given a function sig, input data, address of the contract and a value to check against
function find(StdStorage storage self, bool _clear) internal returns (FindData storage) {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = getCallParams(self);
    if (self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        if (_clear) {
            clear(self);
        }
        return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    }
    vm.record();
    (, bytes32 callResult) = callTarget(self);
    (bytes32[] memory reads, ) = vm.accesses(address(who));
    if (reads.length == 0) {
        revert("stdStorage find(StdStorage): No storage use detected for target.");
    } else {
        for (uint256 i = reads.length; (--i) >= 0; ) {
            bytes32 prev = vm.load(who, reads[i]);
            if (prev == bytes32(0)) {
                emit WARNING_UninitedSlot(who, uint256(reads[i]));
            }
            if (!checkSlotMutatesCall(self, reads[i])) {
                continue;
            }
            (uint256 offsetLeft, uint256 offsetRight) = (0, 0);
            if (self._enable_packed_slots) {
                bool found;
                (found, offsetLeft, offsetRight) = findOffsets(self, reads[i]);
                if (!found) {
                    continue;
                }
            }
            uint256 curVal = (uint256(prev) & getMaskByOffsets(offsetLeft, offsetRight)) >> offsetRight;
            if (uint256(callResult) != curVal) {
                continue;
            }
            emit SlotFound(who, fsig, keccak256(abi.encodePacked(params, field_depth)), uint256(reads[i]));
            self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))] = FindData(uint256(reads[i]), offsetLeft, offsetRight, true);
            break;
        }
    }
    require(self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found, "stdStorage find(StdStorage): Slot(s) not found.");
    if (_clear) {
        clear(self);
    }
    return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 11581:239:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    delete self._target;
    delete self._sig;
    delete self._keys;
    delete self._depth;
    delete self._enable_packed_slots;
    delete self._calldata;
}
```

### callTarget(struct StdStorage)

- **Kind**: internal
- **Source**: 1251:339:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:callTarget(struct StdStorage)`

```solidity
function callTarget(StdStorage storage self) internal view returns (bool, bytes32) {
    bytes memory cd = abi.encodePacked(self._sig, getCallParams(self));
    (bool success, bytes memory rdat) = self._target.staticcall(cd);
    bytes32 result = bytesToBytes32(rdat, 32 * self._depth);
    return (success, result);
}
```

### bytesToBytes32(bytes,uint256)

- **Kind**: internal
- **Source**: 10872:304:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:bytesToBytes32(bytes,uint256)`

```solidity
function bytesToBytes32(bytes memory b, uint256 offset) private pure returns (bytes32) {
    bytes32 out;
    uint256 max = (b.length > 32) ? 32 : b.length;
    for (uint256 i = 0; i < max; i++) {
        out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
}
```

### checkSlotMutatesCall(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 1847:546:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:checkSlotMutatesCall(struct StdStorage,bytes32)`

```solidity
function checkSlotMutatesCall(StdStorage storage self, bytes32 slot) internal returns (bool) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool success, bytes32 prevReturnValue) = callTarget(self);
    bytes32 testVal = (prevReturnValue == bytes32(0)) ? bytes32(UINT256_MAX) : bytes32(0);
    vm.store(self._target, slot, testVal);
    (, bytes32 newReturnValue) = callTarget(self);
    vm.store(self._target, slot, prevSlotValue);
    return (success && (prevReturnValue != newReturnValue));
}
```

### findOffsets(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 3076:534:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffsets(struct StdStorage,bytes32)`

```solidity
function findOffsets(StdStorage storage self, bytes32 slot) internal returns (bool, uint256, uint256) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool foundLeft, uint256 offsetLeft) = findOffset(self, slot, true);
    (bool foundRight, uint256 offsetRight) = findOffset(self, slot, false);
    vm.store(self._target, slot, prevSlotValue);
    return (foundLeft && foundRight, offsetLeft, offsetRight);
}
```

### findOffset(struct StdStorage,bytes32,bool)

- **Kind**: internal
- **Source**: 2556:514:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffset(struct StdStorage,bytes32,bool)`

```solidity
function findOffset(StdStorage storage self, bytes32 slot, bool left) internal returns (bool, uint256) {
    for (uint256 offset = 0; offset < 256; offset++) {
        uint256 valueToPut = left ? (1 << (255 - offset)) : (1 << offset);
        vm.store(self._target, slot, bytes32(valueToPut));
        (bool success, bytes32 data) = callTarget(self);
        if (success && (uint256(data) > 0)) {
            return (true, offset);
        }
    }
    return (false, 0);
}
```

### getMaskByOffsets(uint256,uint256)

- **Kind**: internal
- **Source**: 12013:376:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getMaskByOffsets(uint256,uint256)`

```solidity
function getMaskByOffsets(uint256 offsetLeft, uint256 offsetRight) internal pure returns (uint256 mask) {
    assembly {
        mask := shl(offsetRight, sub(shl(sub(256, add(offsetRight, offsetLeft)), 1), 1))
    }
}
```

### getUpdatedSlotValue(bytes32,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 12451:300:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getUpdatedSlotValue(bytes32,uint256,uint256,uint256)`

```solidity
function getUpdatedSlotValue(bytes32 curValue, uint256 varValue, uint256 offsetLeft, uint256 offsetRight) internal pure returns (bytes32 newValue) {
    return bytes32((uint256(curValue) & (~getMaskByOffsets(offsetLeft, offsetRight))) | (varValue << offsetRight));
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 14700:92:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    stdStorageSafe.clear(self);
}
```

### deployPeripheryAccounts()

- **Kind**: internal
- **Source**: 374:286:667
- **Link**: `test/utils/PeripheryHelpers.sol:PeripheryHelpers:deployPeripheryAccounts()`

```solidity
function deployPeripheryAccounts() public {
    SV_MANAGER = _deployAccount(MANAGER_KEY, "SV_MANAGER");
    EMERGENCY_ADMIN = _deployAccount(EMERGENCY_ADMIN_KEY, "EMERGENCY_ADMIN");
    VALIDATOR = _deployAccount(VALIDATOR_KEY, "VALIDATOR");
}
```

### _deployPeripheryContracts(struct PeripheryAddresses[])

- **Kind**: internal
- **Source**: 4596:8531:545
- **Link**: `test/BaseTest.t.sol:BaseTest:_deployPeripheryContracts(struct PeripheryAddresses[])`

```solidity
function _deployPeripheryContracts(PeripheryAddresses[] memory PA) internal returns (PeripheryAddresses[] memory) {
    for (uint256 i = 0; i < chainIds.length; ++i) {
        vm.selectFork(FORKS[chainIds[i]]);
        PA[i].superGovernor = SuperGovernor(payable(VmContractHelper499(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _salt: SALT, _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(address(this), address(this), address(this), address(this), address(this), address(this), TREASURY, false))})));
        vm.label(address(PA[i].superGovernor), SUPER_GOVERNOR_KEY);
        contractAddresses[chainIds[i]][SUPER_GOVERNOR_KEY] = address(PA[i].superGovernor);
        PA[i].superBank = SuperBank(payable(VmContractHelper499(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperBank.sol:SuperBank", _salt: SALT, _args: encodeArgs442(DeployHelper442.FoundryPpConstructorArgs(address(PA[i].superGovernor)))})));
        vm.label(address(PA[i].superBank), SUPER_BANK_KEY);
        contractAddresses[chainIds[i]][SUPER_BANK_KEY] = address(PA[i].superBank);
        TREASURY = address(PA[i].superBank);
        PA[i].oracleRegistry = SuperOracle(payable(VmContractHelper499(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracle.sol:SuperOracle", _salt: SALT, _args: encodeArgs447(DeployHelper447.FoundryPpConstructorArgs(address(this), new address[](0), new address[](0), new bytes32[](0), new address[](0)))})));
        vm.label(address(PA[i].oracleRegistry), SUPER_ORACLE_KEY);
        contractAddresses[chainIds[i]][SUPER_ORACLE_KEY] = address(PA[i].oracleRegistry);
        PA[i].ecdsappsOracle = ECDSAPPSOracle(payable(VmContractHelper499(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle", _args: encodeArgs478(DeployHelper478.FoundryPpConstructorArgs(address(PA[i].superGovernor), ECDSAPPS_ORACLE_KEY, ECDSAPPS_ORACLE_VERSION))})));
        vm.label(address(PA[i].ecdsappsOracle), ECDSAPPS_ORACLE_KEY);
        contractAddresses[chainIds[i]][ECDSAPPS_ORACLE_KEY] = address(PA[i].ecdsappsOracle);
        address vaultImpl = address(SuperVault(payable(VmContractHelper499(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(PA[i].superGovernor)))}))));
        address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper499(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(PA[i].superGovernor)))}))));
        address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper499(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
        PA[i].superVaultAggregator = SuperVaultAggregator(payable(VmContractHelper499(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(PA[i].superGovernor), vaultImpl, strategyImpl, escrowImpl))})));
        vm.label(address(PA[i].superVaultAggregator), SUPER_VAULT_AGGREGATOR_KEY);
        contractAddresses[chainIds[i]][SUPER_VAULT_AGGREGATOR_KEY] = address(PA[i].superVaultAggregator);
        if (chainIds[i] == ETH) {
            /// @dev set any new sv addresses here
            address aggregator = address(PA[i].superVaultAggregator);
            globalSVStrategy = SuperVaultAggregator(aggregator).STRATEGY_IMPLEMENTATION().predictDeterministicAddress(keccak256(abi.encode(SV_MANAGER, existingUnderlyingTokens[ETH][USDC_KEY], "SuperVault", "SV_USDC", uint256(0))), aggregator);
            globalSVGearStrategy = SuperVaultAggregator(aggregator).STRATEGY_IMPLEMENTATION().predictDeterministicAddress(keccak256(abi.encode(SV_MANAGER, existingUnderlyingTokens[ETH][USDC_KEY], "SuperVault", "svGearbox", uint256(1))), aggregator);
            globalRuggableVault = SuperVaultAggregator(aggregator).STRATEGY_IMPLEMENTATION().predictDeterministicAddress(keccak256(abi.encode(SV_MANAGER, existingUnderlyingTokens[ETH][USDC_KEY], "SuperVault", "SV_USDC_RUG", uint256(1))), aggregator);
            globalSV5115Strategy = SuperVaultAggregator(aggregator).STRATEGY_IMPLEMENTATION().predictDeterministicAddress(keccak256(abi.encode(SV_MANAGER, CHAIN_1_SUSDE, "SuperVault", "sv5115", uint256(1))), aggregator);
            PA[i].mockETHReceiver = new MockETHReceiver{salt: SALT}(existingUnderlyingTokens[ETH][USDC_KEY]);
            vm.label(address(PA[i].mockETHReceiver), "MOCK_ETH_RECEIVER");
            contractAddresses[ETH]["MOCK_ETH_RECEIVER"] = address(PA[i].mockETHReceiver);
            PA[i].mockNativeETHHook = new MockNativeETHHook{salt: SALT}(address(PA[i].mockETHReceiver));
            vm.label(address(PA[i].mockNativeETHHook), "MOCK_NATIVE_ETH_HOOK");
            contractAddresses[ETH]["MOCK_NATIVE_ETH_HOOK"] = address(PA[i].mockNativeETHHook);
            PA[i].approveAndSwapOdosHook = new ApproveAndSwapOdosV2Hook{salt: keccak256(abi.encodePacked(PERIPHERY_HOOKS_SALT))}(CHAIN_1_ODOS_ROUTER);
            vm.label(address(PA[i].approveAndSwapOdosHook), "ApproveAndSwapOdosV2Hook");
            contractAddresses[ETH][APPROVE_AND_SWAP_ODOSV2_HOOK_KEY] = address(PA[i].approveAndSwapOdosHook);
            approveAndSwapOdosHookAddressETH = address(PA[i].approveAndSwapOdosHook);
            _predictTestVaultAddresses();
        }
        PA[i].superGovernor.setActivePPSOracle(address(PA[i].ecdsappsOracle));
        address[] memory validators = new address[](1);
        validators[0] = VALIDATOR;
        bytes[] memory validatorPublicKeys = new bytes[](1);
        validatorPublicKeys[0] = "";
        PA[i].superGovernor.setValidatorConfig(1, validators, validatorPublicKeys, 1, "");
    }
    return PA;
}
```

### _predictTestVaultAddresses()

- **Kind**: internal
- **Source**: 13301:3505:545
- **Link**: `test/BaseTest.t.sol:BaseTest:_predictTestVaultAddresses()`

```solidity
/// @notice Predicts CREATE2 addresses for test vaults used in integration tests
///  @dev Uses Create2.deploy() method for consistent prediction and deployment
function _predictTestVaultAddresses() internal {
    address deployer = address(this);
    address assetAddress = existingUnderlyingTokens[ETH][USDC_KEY];
    test1_DynamicAllocation_MockVault = _predictMock4626VaultAddress(deployer, assetAddress, "New Vault", "NV", TEST_SALT);
    test3_UnderlyingVaults_StressTest = _predictRuggableVaultAddress(deployer, assetAddress, "Ruggable Vault", "RUG", true, true, 10, TEST_SALT);
    test6_yieldAccumulation_vault1 = _predictMock4626VaultAddress(deployer, assetAddress, "Mock4626Vault 3%", "MV3", TEST_SALT);
    test6_yieldAccumulation_vault2 = _predictMock4626VaultAddress(deployer, assetAddress, "Mock4626Vault 5%", "MV5", TEST_SALT);
    test6_yieldAccumulation_vault3 = _predictMock4626VaultAddress(deployer, assetAddress, "Mock4626Vault 10%", "MV10", TEST_SALT);
    test6_yieldAccumulation_WithRebalancing_vault1 = _predictMock4626VaultAddress(deployer, assetAddress, "Mock Vault 3%", "MV3", TEST_SALT);
    test6_yieldAccumulation_WithRebalancing_vault2 = _predictMock4626VaultAddress(deployer, assetAddress, "Mock Vault 5%", "MV5", TEST_SALT);
    test6_yieldAccumulation_WithRebalancing_vault3 = _predictMock4626VaultAddress(deployer, assetAddress, "Mock Vault 10%", "MV10", TEST_SALT);
    test10_RuggableVault_Deposit = _predictRuggableVaultAddress(deployer, assetAddress, "Ruggable Vault", "RUG", true, false, 5000, TEST_SALT);
    test10_RuggableVault_Withdraw = _predictRuggableVaultAddress(deployer, assetAddress, "Ruggable Vault", "RUG", false, true, 5000, TEST_SALT);
    test10_RuggableVault_Withdraw_ConvertDistortion = _predictRuggableConvertVaultAddress(deployer, assetAddress, "Ruggable Convert Vault", "RUGC", 5000, true, TEST_SALT);
    test11_Allocate_NewYieldSource = _predictMock4626VaultAddress(deployer, assetAddress, "New Vault", "NV", TEST_SALT);
    test1_SuperVault_5115_ReAllocateFrom4626To5115_Vault1 = _predictMock4626VaultAddress(deployer, assetAddress, "SuperVault 5115 ReAllocateFrom4626To5115 Vault1", "SV5115R1", TEST_SALT);
    test2_SuperVault_5115_ReAllocateFrom4626To5115_Vault2 = _predictMock4626VaultAddress(deployer, assetAddress, "SuperVault 5115 ReAllocateFrom4626To5115 Vault2", "SV5115R2", TEST_SALT);
}
```

### _predictMock4626VaultAddress(address,address,string,string,string)

- **Kind**: internal
- **Source**: 17182:551:545
- **Link**: `test/BaseTest.t.sol:BaseTest:_predictMock4626VaultAddress(address,address,string,string,string)`

```solidity
/// @notice Predicts CREATE2 address for Mock4626Vault using same method as Create2.deploy()
function _predictMock4626VaultAddress(address deployer, address asset, string memory name, string memory symbol, string memory salt) internal pure returns (address) {
    bytes memory bytecode = abi.encodePacked(type(Mock4626Vault).creationCode, abi.encode(asset, name, symbol));
    bytes32 bytecodeHash = keccak256(bytecode);
    bytes32 saltHash = keccak256(abi.encodePacked(salt));
    return Create2.computeAddress(saltHash, bytecodeHash, deployer);
}
```

### computeAddress(bytes32,bytes32,address)

- **Kind**: internal
- **Source**: 2669:1794:53
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Create2.sol:Create2:computeAddress(bytes32,bytes32,address)`

```solidity
///  @dev Returns the address where a contract will be stored if deployed via {deploy} from a contract located at
///  `deployer`. If `deployer` is this contract's address, returns the same value as {computeAddress}.
function computeAddress(bytes32 salt, bytes32 bytecodeHash, address deployer) internal pure returns (address addr) {
    assembly ("memory-safe") {
        let ptr := mload(0x40)
        mstore(add(ptr, 0x40), bytecodeHash)
        mstore(add(ptr, 0x20), salt)
        mstore(ptr, deployer)
        let start := add(ptr, 0x0b)
        mstore8(start, 0xff)
        addr := and(keccak256(start, 85), 0xffffffffffffffffffffffffffffffffffffffff)
    }
}
```

### _predictRuggableVaultAddress(address,address,string,string,bool,bool,uint256,string)

- **Kind**: internal
- **Source**: 17836:714:545
- **Link**: `test/BaseTest.t.sol:BaseTest:_predictRuggableVaultAddress(address,address,string,string,bool,bool,uint256,string)`

```solidity
/// @notice Predicts CREATE2 address for RuggableVault using same method as Create2.deploy()
function _predictRuggableVaultAddress(address deployer, address asset, string memory name, string memory symbol, bool rugOnDeposit, bool rugOnWithdraw, uint256 rugPercentage, string memory salt) internal pure returns (address) {
    bytes memory bytecode = abi.encodePacked(type(RuggableVault).creationCode, abi.encode(asset, name, symbol, rugOnDeposit, rugOnWithdraw, rugPercentage));
    bytes32 bytecodeHash = keccak256(bytecode);
    bytes32 saltHash = keccak256(abi.encodePacked(salt));
    return Create2.computeAddress(saltHash, bytecodeHash, deployer);
}
```

### _predictRuggableConvertVaultAddress(address,address,string,string,uint256,bool,string)

- **Kind**: internal
- **Source**: 18660:669:545
- **Link**: `test/BaseTest.t.sol:BaseTest:_predictRuggableConvertVaultAddress(address,address,string,string,uint256,bool,string)`

```solidity
/// @notice Predicts CREATE2 address for RuggableConvertVault using same method as Create2.deploy()
function _predictRuggableConvertVaultAddress(address deployer, address asset, string memory name, string memory symbol, uint256 rugPercentage, bool rugEnabled, string memory salt) internal pure returns (address) {
    bytes memory bytecode = abi.encodePacked(type(RuggableConvertVault).creationCode, abi.encode(asset, name, symbol, rugPercentage, rugEnabled));
    bytes32 bytecodeHash = keccak256(bytecode);
    bytes32 saltHash = keccak256(abi.encodePacked(salt));
    return Create2.computeAddress(saltHash, bytecodeHash, deployer);
}
```

### _updateTreasuryInSuperLedgerConfiguration()

- **Kind**: internal
- **Source**: 28871:3592:545
- **Link**: `test/BaseTest.t.sol:BaseTest:_updateTreasuryInSuperLedgerConfiguration()`

```solidity
function _updateTreasuryInSuperLedgerConfiguration() internal {
    for (uint256 i = 0; i < chainIds.length; ++i) {
        vm.selectFork(FORKS[chainIds[i]]);
        bytes32[] memory yieldSourceOracleIds = new bytes32[](4);
        yieldSourceOracleIds[0] = keccak256(abi.encodePacked(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER));
        yieldSourceOracleIds[1] = keccak256(abi.encodePacked(bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER));
        yieldSourceOracleIds[2] = keccak256(abi.encodePacked(bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER));
        yieldSourceOracleIds[3] = keccak256(abi.encodePacked(bytes32(bytes(STAKING_YIELD_SOURCE_ORACLE_KEY)), MANAGER));
        ISuperLedgerConfiguration.YieldSourceOracleConfig[] memory currentConfigs = ISuperLedgerConfiguration(_getContract(chainIds[i], SUPER_LEDGER_CONFIGURATION_KEY)).getYieldSourceOracleConfigs(yieldSourceOracleIds);
        ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[] memory newConfigs = new ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[](4);
        newConfigs[0] = ISuperLedgerConfiguration.YieldSourceOracleConfigArgs({yieldSourceOracle: currentConfigs[0].yieldSourceOracle, feePercent: currentConfigs[0].feePercent, feeRecipient: TREASURY, ledger: currentConfigs[0].ledger});
        newConfigs[1] = ISuperLedgerConfiguration.YieldSourceOracleConfigArgs({yieldSourceOracle: currentConfigs[1].yieldSourceOracle, feePercent: currentConfigs[1].feePercent, feeRecipient: TREASURY, ledger: currentConfigs[1].ledger});
        newConfigs[2] = ISuperLedgerConfiguration.YieldSourceOracleConfigArgs({yieldSourceOracle: currentConfigs[2].yieldSourceOracle, feePercent: currentConfigs[2].feePercent, feeRecipient: TREASURY, ledger: currentConfigs[2].ledger});
        newConfigs[3] = ISuperLedgerConfiguration.YieldSourceOracleConfigArgs({yieldSourceOracle: currentConfigs[3].yieldSourceOracle, feePercent: currentConfigs[3].feePercent, feeRecipient: TREASURY, ledger: currentConfigs[3].ledger});
        vm.startPrank(MANAGER);
        ISuperLedgerConfiguration(_getContract(chainIds[i], SUPER_LEDGER_CONFIGURATION_KEY)).proposeYieldSourceOracleConfig(yieldSourceOracleIds, newConfigs);
        vm.stopPrank();
        vm.warp((block.timestamp + 1 weeks) + 1);
        vm.startPrank(MANAGER);
        ISuperLedgerConfiguration(_getContract(chainIds[i], SUPER_LEDGER_CONFIGURATION_KEY)).acceptYieldSourceOracleConfigProposal(yieldSourceOracleIds);
        vm.stopPrank();
    }
}
```

### _configurePeripheryGovernor(struct PeripheryAddresses[])

- **Kind**: internal
- **Source**: 19335:453:545
- **Link**: `test/BaseTest.t.sol:BaseTest:_configurePeripheryGovernor(struct PeripheryAddresses[])`

```solidity
function _configurePeripheryGovernor(PeripheryAddresses[] memory PA) internal {
    for (uint256 i = 0; i < chainIds.length; ++i) {
        vm.selectFork(FORKS[chainIds[i]]);
        SuperGovernor superGovernor = PA[i].superGovernor;
        superGovernor.setAddress(superGovernor.SUPER_VAULT_AGGREGATOR(), address(PA[i].superVaultAggregator));
        superGovernor.setAddress(superGovernor.TREASURY(), TREASURY);
    }
}
```

### _registerPeripheryHooks(struct PeripheryAddresses[])

- **Kind**: internal
- **Source**: 19971:8362:545
- **Link**: `test/BaseTest.t.sol:BaseTest:_registerPeripheryHooks(struct PeripheryAddresses[])`

```solidity
///  @notice Registers periphery-specific hooks with the governor
///  @param PA Array of PeripheryAddresses structs containing periphery contract addresses
function _registerPeripheryHooks(PeripheryAddresses[] memory PA) internal {
    if (DEBUG) console2.log("---------------- REGISTERING PERIPHERY HOOKS ----------------");
    for (uint256 i = 0; i < chainIds.length; ++i) {
        vm.selectFork(FORKS[chainIds[i]]);
        SuperGovernor superGovernor = PA[i].superGovernor;
        console2.log("Registering periphery hooks for chain", chainIds[i]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][DEPOSIT_4626_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][REDEEM_4626_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][DEPOSIT_5115_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][DEPOSIT_7540_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][REDEEM_5115_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][WITHDRAW_7540_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][REDEEM_7540_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][REQUEST_REDEEM_7540_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][APPROVE_ERC20_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][TRANSFER_ERC20_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][DEPOSIT_7540_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][WITHDRAW_7540_VAULT_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][SWAP_1INCH_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][SWAP_ODOSV2_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][APPROVE_AND_SWAP_ODOSV2_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][FLUID_CLAIM_REWARD_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][FLUID_STAKE_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][APPROVE_AND_FLUID_STAKE_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][FLUID_UNSTAKE_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][GEARBOX_CLAIM_REWARD_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][GEARBOX_STAKE_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][GEARBOX_APPROVE_AND_STAKE_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][GEARBOX_UNSTAKE_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][YEARN_CLAIM_ONE_REWARD_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][CANCEL_REDEEM_REQUEST_7540_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][CLAIM_CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][CLAIM_CANCEL_REDEEM_REQUEST_7540_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][MINT_SUPERPOSITIONS_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][MERKL_CLAIM_REWARD_HOOK_KEY]);
        if (chainIds[i] == ETH) {
            superGovernor.registerHook(address(PA[i].mockNativeETHHook));
            superGovernor.registerHook(address(PA[i].approveAndSwapOdosHook));
            globalMerkleHooksPeriphery = new address[](16);
            globalMerkleHooksPeriphery[0] = hookAddresses[chainIds[i]][DEPOSIT_4626_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[1] = hookAddresses[chainIds[i]][REDEEM_4626_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[2] = hookAddresses[chainIds[i]][DEPOSIT_5115_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[3] = hookAddresses[chainIds[i]][REDEEM_5115_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[4] = hookAddresses[chainIds[i]][APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[5] = hookAddresses[chainIds[i]][APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[6] = hookAddresses[chainIds[i]][APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[7] = hookAddresses[chainIds[i]][DEPOSIT_7540_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[8] = address(PA[i].mockNativeETHHook);
            globalMerkleHooksPeriphery[9] = hookAddresses[chainIds[i]][GEARBOX_APPROVE_AND_STAKE_HOOK_KEY];
            globalMerkleHooksPeriphery[10] = hookAddresses[chainIds[i]][GEARBOX_UNSTAKE_HOOK_KEY];
            globalMerkleHooksPeriphery[11] = hookAddresses[chainIds[i]][WITHDRAW_7540_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[12] = hookAddresses[chainIds[i]][REDEEM_7540_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[13] = hookAddresses[chainIds[i]][REQUEST_REDEEM_7540_VAULT_HOOK_KEY];
            globalMerkleHooksPeriphery[14] = hookAddresses[chainIds[i]][MERKL_CLAIM_REWARD_HOOK_KEY];
            globalMerkleHooksPeriphery[15] = address(PA[i].approveAndSwapOdosHook);
            globalMerkleHookNamesPeriphery = new string[](16);
            globalMerkleHookNamesPeriphery[0] = "DEPOSIT_4626_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[1] = "REDEEM_4626_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[2] = "DEPOSIT_5115_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[3] = "REDEEM_5115_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[4] = "APPROVE_AND_DEPOSIT_4626_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[5] = "APPROVE_AND_DEPOSIT_5115_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[6] = "APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[7] = "DEPOSIT_7540_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[8] = "MOCK_NATIVE_ETH_HOOK";
            globalMerkleHookNamesPeriphery[9] = "APPROVE_AND_GEARBOX_STAKE_HOOK";
            globalMerkleHookNamesPeriphery[10] = "GEARBOX_UNSTAKE_HOOK";
            globalMerkleHookNamesPeriphery[11] = "WITHDRAW_7540_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[12] = "REDEEM_7540_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[13] = "REQUEST_REDEEM_7540_VAULT_HOOK";
            globalMerkleHookNamesPeriphery[14] = "MERKL_CLAIM_REWARD_HOOK";
            globalMerkleHookNamesPeriphery[15] = "APPROVE_AND_SWAP_ODOSV2_HOOK";
        }
        superGovernor.registerHook(hookAddresses[chainIds[i]][ETHENA_COOLDOWN_SHARES_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][ETHENA_UNSTAKE_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][MORPHO_BORROW_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][MORPHO_REPAY_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][MORPHO_REPAY_AND_WITHDRAW_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][PENDLE_ROUTER_REDEEM_HOOK_KEY]);
        superGovernor.registerHook(hookAddresses[chainIds[i]][OFFRAMP_TOKENS_HOOK_KEY]);
    }
}
```

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2664:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right);
    }
}
```

### _deployVault(string)

- **Kind**: internal
- **Source**: 16658:225:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deployVault(string)`

```solidity
///  @notice Deploys a new SuperVault with default configuration
///  @param _superVaultSymbol The symbol for the SuperVault
///  @return vaultAddr The address of the deployed SuperVault
///  @return strategyAddr The address of the deployed SuperVaultStrategy
///  @return escrowAddr The address of the deployed SuperVaultEscrow
function _deployVault(string memory _superVaultSymbol) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    return _deployVault(address(asset), _superVaultSymbol);
}
```

### _deployVault(address,string)

- **Kind**: internal
- **Source**: 13311:1259:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deployVault(address,string)`

```solidity
///  @notice Deploys a new SuperVault with default configuration
///  @return vaultAddr The address of the deployed SuperVault
///  @return strategyAddr The address of the deployed SuperVaultStrategy
///  @return escrowAddr The address of the deployed SuperVaultEscrow
function _deployVault(address _asset, string memory _superVaultSymbol) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    vm.startPrank(SV_MANAGER);
    (vaultAddr, strategyAddr, escrowAddr) = aggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: _asset, name: "SuperVault", symbol: _superVaultSymbol, mainManager: MANAGER, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 1 weeks, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: address(this)})}));
    vm.label(vaultAddr, string.concat("SuperVault ", _superVaultSymbol));
    vm.label(strategyAddr, string.concat("SuperVaultStrategy ", _superVaultSymbol));
    vm.label(escrowAddr, string.concat("SuperVaultEscrow ", _superVaultSymbol));
    vm.stopPrank();
    return (vaultAddr, strategyAddr, escrowAddr);
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

### _getMerkleRoot()

- **Kind**: internal
- **Source**: 2026:392:672
- **Link**: `test/utils/merkle/helper/MerkleReader.sol:MerkleReader:_getMerkleRoot()`

```solidity
///  @notice Get the Merkle root from the jsGeneratedRoot file
///  @return root The Merkle root
function _getMerkleRoot() internal view returns (bytes32 root) {
    LocalVars memory v;
    string memory rootFilePath = string.concat(vm.projectRoot(), basePathForRoot, ".json");
    v.rootJson = vm.readFile(rootFilePath);
    v.encodedRoot = vm.parseJson(v.rootJson, ".root");
    root = abi.decode(v.encodedRoot, (bytes32));
    console2.logBytes32(root);
}
```

### logBytes32(bytes32)

- **Kind**: internal
- **Source**: 5820:123:26
- **Link**: `lib/forge-std/src/console.sol:console:logBytes32(bytes32)`

```solidity
function logBytes32(bytes32 p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(bytes32)", p0));
}
```

### _setFeeConfig(uint256,address)

- **Kind**: internal
- **Source**: 106029:304:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_setFeeConfig(uint256,address)`

```solidity
function _setFeeConfig(uint256 feePercent, address feeRecipient) internal {
    vm.startPrank(MANAGER);
    strategy.proposeVaultFeeConfigUpdate(feePercent, 0, feeRecipient);
    vm.warp(block.timestamp + 1 weeks);
    strategy.executeVaultFeeConfigUpdate();
    vm.stopPrank();
}
```

## External Calls

- **Vm::selectFork(uint256)**
- **Vm::label(address,string)**
- **SuperGovernor::proposeGlobalHooksRoot(bytes32)**
- **Vm::warp(uint256)**
- **SuperVaultAggregator::executeGlobalHooksRootUpdate()**
- **SuperGovernor::proposeActivePPSOracle(address)**
- **SuperGovernor::executeActivePPSOracleChange()**
- **Vm::startPrank(address)**
- **SuperVaultStrategy::manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)**
- **Vm::stopPrank()**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::UP()**
- **SuperGovernor::UPKEEP_TOKEN()**
- **SuperGovernor::SUPER_ORACLE()**
- **ISuperOracle::queueOracleUpdate(address[],address[],bytes32[],address[])**
- **ISuperOracle::executeOracleUpdate()**
- **ISuperOracle::setFeedMaxStalenessBatch(address[],uint256[])**
- **SuperGovernor::setGasInfo(address,uint256)**

## State Variable Reads

- **accInstances** (`struct AccountInstance[]`)
- **asset** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **asset5115** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **oracleEthToUsd** (`address`)
- **oracleGasToEth** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **ecdsappsOracle** (`contract IECDSAPPSOracle`) [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]
- **pendleEthenaAddress** (`address`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **fluidVault** (`contract IERC4626`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
- **aaveVault** (`contract IERC4626`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
- **upToken** (`address`)
- **superOracle** (`contract ISuperOracle`) [src/interfaces/oracles/ISuperOracle.sol/interface_ISuperOracle.md]
- **mockFeedWithRealDataEthToUsd** (`contract MockFeedWithRealData`) [test/mocks/MockFeedWithRealData.sol/contract_MockFeedWithRealData.md]
- **oracleUsdToUp** (`address`)
- **mockFeedWithRealDataGasToEth** (`contract MockFeedWithRealData`) [test/mocks/MockFeedWithRealData.sol/contract_MockFeedWithRealData.md]
- **yieldSource7540AddressETH_USDC** (`address`)
- **mockRegistry** (`contract MockRegistry`) [lib/v2-core/test/mocks/MockRegistry.sol/contract_MockRegistry.md]
- **chainIds** (`uint64[]`)
- **skipAccountsCreation** (`bool`)
- **ACROSS_RELAYER** (`address`)
- **FORKS** (`mapping(uint64 => uint256)`)
- **useLatestFork** (`bool`)
- **ETHEREUM_RPC_URL** (`string`)
- **OPTIMISM_RPC_URL** (`string`)
- **BASE_RPC_URL** (`string`)
- **RPC_URLS** (`mapping(uint64 => string)`)
- **SPOKE_POOL_V3_ADDRESSES** (`mapping(uint64 => address)`)
- **spokePoolV3Addresses** (`address[]`)
- **DEBRIDGE_DLN_ADDRESSES** (`mapping(uint64 => address)`)
- **DEBRIDGE_DLN_ADDRESSES_DST** (`mapping(uint64 => address)`)
- **PENDLE_ROUTERS** (`mapping(uint64 => address)`)
- **SPECTRA_ROUTERS** (`mapping(uint64 => address)`)
- **PENDLE_SWAP** (`mapping(uint64 => address)`)
- **ODOS_ROUTER** (`mapping(uint64 => address)`)
- **NEXUS_FACTORY_ADDRESSES** (`mapping(uint64 => address)`)
- **realVaultAddresses** (`mapping(uint64 => mapping(string => mapping(string => mapping(string => address))))`)
- **validatorSigners** (`mapping(uint64 => address)`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **SALT** (`bytes32`)
- **DEBUG** (`bool`)
- **hooks** (`mapping(uint64 => mapping(string => struct BaseTest.Hook))`)
- **contractAddresses** (`mapping(uint64 => mapping(string => address))`)
- **hookLeavesPerChain** (`mapping(uint64 => bytes32[])`)
- **_defaultValidator** (`contract MockValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]
- **_defaultSessionValidator** (`contract MockStatelessValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]
- **isInit** (`mapping(uint256 => bool)`)
- **VM_ADDR** (`address`)
- **auxiliary** (`struct Auxiliary`)
- **MIN_STAKE_VALUE** (`uint256`)
- **MIN_UNSTAKE_DELAY** (`uint256`)
- **underlyingTokens** (`string[]`)
- **existingUnderlyingTokens** (`mapping(uint64 => mapping(string => address))`)
- **accountInstances** (`mapping(uint64 => struct AccountInstance)`)
- **stdstore** (`struct StdStorage`)
- **UINT256_MAX** (`uint256`)
- **PERIPHERY_HOOKS_SALT** (`string`)
- **TEST_SALT** (`string`)
- **basePathForRoot** (`string`)

## State Variable Writes

- **accInstances** (`struct AccountInstance[]`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **asset** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **asset5115** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **upToken** (`address`)
- **oracleEthToUsd** (`address`)
- **oracleUsdToUp** (`address`)
- **oracleGasToEth** (`address`)
- **mockFeedWithRealDataEthToUsd** (`contract MockFeedWithRealData`) [test/mocks/MockFeedWithRealData.sol/contract_MockFeedWithRealData.md]
- **mockFeedWithRealDataGasToEth** (`contract MockFeedWithRealData`) [test/mocks/MockFeedWithRealData.sol/contract_MockFeedWithRealData.md]
- **superOracle** (`contract ISuperOracle`) [src/interfaces/oracles/ISuperOracle.sol/interface_ISuperOracle.md]
- **accountEth** (`address`)
- **instanceOnEth** (`struct AccountInstance`)
- **superExecutorOnEth** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **superLedgerETH** (`contract ISuperLedger`) [lib/v2-core/src/interfaces/accounting/ISuperLedger.sol/interface_ISuperLedger.md]
- **oracle** (`contract ERC7540YieldSourceOracle`) [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]
- **ecdsappsOracle** (`contract IECDSAPPSOracle`) [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]
- **fluidVault** (`contract IERC4626`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
- **aaveVault** (`contract IERC4626`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
- **pendleEthenaAddress** (`address`)
- **pendleEthena** (`contract IStandardizedYield`) [lib/v2-core/src/vendor/pendle/IStandardizedYield.sol/interface_IStandardizedYield.md]
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **escrow** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **totalAssetHelper** (`contract TotalAssetHelper`) [test/integration/SuperVault/TotalAssetHelper.sol/contract_TotalAssetHelper.md]
- **validator1PrivateKey** (`uint256`)
- **validator2PrivateKey** (`uint256`)
- **validator3PrivateKey** (`uint256`)
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **rootManager** (`address`)
- **yieldSource7540AddressETH_USDC** (`address`)
- **centrifugeVault** (`contract IERC7540`) [lib/v2-core/src/vendor/vaults/7540/IERC7540.sol/interface_IERC7540.md]
- **mockRegistry** (`contract MockRegistry`) [lib/v2-core/test/mocks/MockRegistry.sol/contract_MockRegistry.md]
- **TREASURY** (`address`)
- **SUPER_BUNDLER** (`address`)
- **ACROSS_RELAYER** (`address`)
- **existingUnderlyingTokens** (`mapping(uint64 => mapping(string => address))`)
- **validatorSigners** (`mapping(uint64 => address)`)
- **validatorSignerPrivateKeys** (`mapping(uint64 => uint256)`)
- **contractAddresses** (`mapping(uint64 => mapping(string => address))`)
- **chainIds** (`uint64[]`)
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)
- **hooks** (`mapping(uint64 => mapping(string => struct BaseTest.Hook))`)
- **hooksByCategory** (`mapping(uint64 => mapping(enum BaseTest.HookCategory => struct BaseTest.Hook[]))`)
- **mockOdosRouters** (`mapping(uint64 => address)`)
- **hookListPerChain** (`mapping(uint64 => address[])`)
- **globalMerkleHooks** (`address[]`)
- **globalMerkleHookNames** (`string[]`)
- **hookLeavesPerChain** (`mapping(uint64 => bytes32[])`)
- **hookProofsPerChain** (`mapping(uint64 => bytes32[][])`)
- **hookRootPerChain** (`mapping(uint64 => bytes32)`)
- **accountInstances** (`mapping(uint64 => struct AccountInstance)`)
- **randomAccountInstances** (`mapping(uint64 => struct AccountInstance[])`)
- **isInit** (`mapping(uint256 => bool)`)
- **_defaultValidator** (`contract MockValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]
- **_defaultSessionValidator** (`contract MockStatelessValidator`) [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]
- **auxiliary** (`struct Auxiliary`)
- **SV_MANAGER** (`address`)
- **EMERGENCY_ADMIN** (`address`)
- **VALIDATOR** (`address`)
- **globalSVStrategy** (`address`)
- **globalSVGearStrategy** (`address`)
- **globalRuggableVault** (`address`)
- **globalSV5115Strategy** (`address`)
- **approveAndSwapOdosHookAddressETH** (`address`)
- **test1_DynamicAllocation_MockVault** (`address`)
- **test3_UnderlyingVaults_StressTest** (`address`)
- **test6_yieldAccumulation_vault1** (`address`)
- **test6_yieldAccumulation_vault2** (`address`)
- **test6_yieldAccumulation_vault3** (`address`)
- **test6_yieldAccumulation_WithRebalancing_vault1** (`address`)
- **test6_yieldAccumulation_WithRebalancing_vault2** (`address`)
- **test6_yieldAccumulation_WithRebalancing_vault3** (`address`)
- **test10_RuggableVault_Deposit** (`address`)
- **test10_RuggableVault_Withdraw** (`address`)
- **test10_RuggableVault_Withdraw_ConvertDistortion** (`address`)
- **test11_Allocate_NewYieldSource** (`address`)
- **test1_SuperVault_5115_ReAllocateFrom4626To5115_Vault1** (`address`)
- **test2_SuperVault_5115_ReAllocateFrom4626To5115_Vault2** (`address`)
- **globalMerkleHooksPeriphery** (`address[]`)
- **globalMerkleHookNamesPeriphery** (`string[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseSuperVaultTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BaseTest.setUp() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: BaseTest.setUp() (NodeID: 2)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: Helpers.deployAccounts() (NodeID: 3)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: public
  │ │ │ ├─ [4] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │ │ │ │   💬 Args: [TREASURY_KEY, "TREASURY"]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 5)
  │ │ │ │   💬 Args: [SUPER_BUNDLER_KEY, "SUPER_BUNDLER"]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 6)
  │ │ │     💬 Args: [ACROSS_RELAYER_KEY, "ACROSS_RELAYER"]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._preDeploymentSetup() (NodeID: 7)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 8)
  │ │ │     💬 Args: ["The signer"]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._deployContracts(struct Addresses[]) (NodeID: 9)
  │ │ │   💬 Args: [A]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._deployHooks(struct Addresses[]) (NodeID: 10)
  │ │ │   💬 Args: [A]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 11)
  │ │ │ │   💬 Args: ["---------------- DEPLOYING HOOKS ----------------"]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 12)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 13)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 14)
  │ │ │ │   💬 Args: [chainIds[i], SUPER_MERKLE_VALIDATOR_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 15)
  │ │ │ │   💬 Args: [chainIds[i], SUPER_MERKLE_VALIDATOR_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 16)
  │ │ │ │   💬 Args: [chainIds[i], SUPER_MERKLE_VALIDATOR_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: MerkleTreeHelper._createHooksTree(uint64,address[]) (NodeID: 17)
  │ │ │     💬 Args: [chainIds[i], hooksAddresses]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: MerkleTreeHelper._createValidatorMerkleTree(bytes32[]) (NodeID: 18)
  │ │ │       💬 Args: [hookLeavesPerChain[chainId]]
  │ │ │       👁️  Def: internal
  │ │ │     ├─ [6] ⚙️ FUNCTION: MerkleTreeHelper._sortAndHashPair(bytes32,bytes32) (NodeID: 19)
  │ │ │     │   💬 Args: [tree[level][2 * i], tree[level][(2 * i) + 1]]
  │ │ │     │   👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: MerkleTreeHelper._generateProof(uint256,bytes32[][]) (NodeID: 20)
  │ │ │         💬 Args: [i, tree]
  │ │ │         👁️  Def: private
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._initializeAccounts(uint256) (NodeID: 21)
  │ │ │   💬 Args: [ACCOUNT_COUNT]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: RhinestoneModuleKit.makeAccountInstance(bytes32) (NodeID: 22)
  │ │ │ │   💬 Args: [keccak256(abi.encode(accountName))]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getAccountEnv() (NodeID: 23)
  │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Unknown.getAccountEnv() (NodeID: 24)
  │ │ │ │ │     💬 Args: [no args]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 25)
  │ │ │ │ │   💬 Args: [address(account), toString(salt)]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Unknown.toString(bytes32) (NodeID: 26)
  │ │ │ │ │     💬 Args: [salt]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 27)
  │ │ │ │ │   💬 Args: [account, 10 ether]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: RhinestoneModuleKit._makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address) (NodeID: 28)
  │ │ │ │ │   💬 Args: [salt, env, accountHelper, account, initCode, address(_defaultValidator), address(accountFactory), address(_defaultSessionValidator)]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] 🔒 MODIFIER: RhinestoneModuleKit.initializeModuleKit() (NodeID: 29)
  │ │ │ │     💬 Args: [no args]
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: Helpers.envOr(string,string) (NodeID: 30)
  │ │ │ │   │   💬 Args: ["ACCOUNT_TYPE", DEFAULT]
  │ │ │ │   │   👁️  Def: public
  │ │ │ │   └─ [6] ⚙️ FUNCTION: RhinestoneModuleKit._initializeModuleKit(string) (NodeID: 31)
  │ │ │ │       💬 Args: [_env]
  │ │ │ │       👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: AuxiliaryFactory.init() (NodeID: 32)
  │ │ │ │     │   💬 Args: [no args]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 33)
  │ │ │ │     │ │   💬 Args: [address(auxiliary.mockFactory), "Mock Factory"]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.etchEntrypoint() (NodeID: 34)
  │ │ │ │     │ │   💬 Args: [no args]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ │ └─ [9] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 35)
  │ │ │ │     │ │     💬 Args: [ENTRYPOINT_ADDR, entryPoint.code]
  │ │ │ │     │ │     👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 36)
  │ │ │ │     │ │   💬 Args: [address(auxiliary.entrypoint), "EntryPoint"]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.etchRegistry() (NodeID: 37)
  │ │ │ │     │ │   💬 Args: [no args]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ │ └─ [9] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 38)
  │ │ │ │     │ │     💬 Args: [REGISTRY_ADDR, _registry.code]
  │ │ │ │     │ │     👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 39)
  │ │ │ │     │ │   💬 Args: [address(auxiliary.registry), "ERC7484Registry"]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.etchSmartSessions() (NodeID: 40)
  │ │ │ │     │ │   💬 Args: [no args]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ │ └─ [9] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 41)
  │ │ │ │     │ │     💬 Args: [address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE]
  │ │ │ │     │ │     👁️  Def: internal
  │ │ │ │     │ └─ [8] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 42)
  │ │ │ │     │     💬 Args: [address(auxiliary.smartSession), "SmartSession"]
  │ │ │ │     │     👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 43)
  │ │ │ │     │   💬 Args: [address(new ERC7579Factory()), DEFAULT]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 44)
  │ │ │ │     │   💬 Args: [address(new SafeFactory()), SAFE]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 45)
  │ │ │ │     │   💬 Args: [address(new KernelFactory()), KERNEL]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 46)
  │ │ │ │     │   💬 Args: [address(new NexusFactory()), NEXUS]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 47)
  │ │ │ │     │   💬 Args: [address(new ERC7579Factory()), CUSTOM]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 48)
  │ │ │ │     │   💬 Args: [address(new ERC7579Helpers()), DEFAULT]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 49)
  │ │ │ │     │   💬 Args: [address(new SafeHelpers()), SAFE]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 50)
  │ │ │ │     │   💬 Args: [address(new KernelHelpers()), KERNEL]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 51)
  │ │ │ │     │   💬 Args: [address(new NexusHelpers()), NEXUS]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 52)
  │ │ │ │     │   💬 Args: [address(new ERC7579Helpers()), CUSTOM]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 53)
  │ │ │ │     │   💬 Args: [SAFE]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 54)
  │ │ │ │     │   💬 Args: [KERNEL]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 55)
  │ │ │ │     │   💬 Args: [DEFAULT]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 56)
  │ │ │ │     │   💬 Args: [NEXUS]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 57)
  │ │ │ │     │   💬 Args: [CUSTOM]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 58)
  │ │ │ │     │   💬 Args: [address(safeFactory), "SafeFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 59)
  │ │ │ │     │   💬 Args: [address(kernelFactory), "KernelFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 60)
  │ │ │ │     │   💬 Args: [address(erc7579Factory), "ERC7579Factory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 61)
  │ │ │ │     │   💬 Args: [address(nexusFactory), "NexusFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 62)
  │ │ │ │     │   💬 Args: [address(customFactory), "CustomFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 63)
  │ │ │ │     │   💬 Args: [address(safeFactory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 64)
  │ │ │ │     │   💬 Args: [address(kernelFactory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 65)
  │ │ │ │     │   💬 Args: [address(erc7579Factory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 66)
  │ │ │ │     │   💬 Args: [address(nexusFactory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 67)
  │ │ │ │     │   💬 Args: [address(customFactory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 68)
  │ │ │ │     │   💬 Args: [address(safeFactory)]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 69)
  │ │ │ │     │   💬 Args: [address(kernelFactory)]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 70)
  │ │ │ │     │   💬 Args: [address(erc7579Factory)]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 71)
  │ │ │ │     │   💬 Args: [address(nexusFactory)]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: ModuleKitHelpers.setAccountEnv(string) (NodeID: 72)
  │ │ │ │     │   💬 Args: [_env]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     │ └─ [8] ⚙️ FUNCTION: ModuleKitHelpers._setAccountEnv(string) (NodeID: 73)
  │ │ │ │     │     💬 Args: [env]
  │ │ │ │     │     👁️  Def: private
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 74)
  │ │ │ │     │   │   💬 Args: [env]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.getHelper(string) (NodeID: 75)
  │ │ │ │     │   │   💬 Args: [env]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 76)
  │ │ │ │     │   │   💬 Args: [env, factory, helper]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 77)
  │ │ │ │     │   │   💬 Args: [env, factory, helper]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 78)
  │ │ │ │     │   │   💬 Args: [env, factory, helper]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 79)
  │ │ │ │     │   │   💬 Args: [env, factory, helper]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   └─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 80)
  │ │ │ │     │       💬 Args: [env, factory, helper]
  │ │ │ │     │       👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 81)
  │ │ │ │     │   💬 Args: [_env]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 82)
  │ │ │ │     │   💬 Args: [address(accountFactory), "AccountFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 83)
  │ │ │ │     │   💬 Args: [address(_defaultValidator), "DefaultValidator"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     └─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 84)
  │ │ │ │         💬 Args: [address(_defaultSessionValidator), "SessionValidator"]
  │ │ │ │         👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: ModuleKitHelpers.installModule(struct AccountInstance,uint256,address,bytes) (NodeID: 85)
  │ │ │ │   💬 Args: [instance, MODULE_TYPE_EXECUTOR, _getContract(chainIds[i], SUPER_EXECUTOR_KEY), ""]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 275)
  │ │ │ │ │   💬 Args: [chainIds[i], SUPER_EXECUTOR_KEY]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.preEnvHook() (NodeID: 86)
  │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ ├─ [6] ⚙️ FUNCTION: Unknown.getStorageCompliance() (NodeID: 87)
  │ │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ ├─ [6] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 88)
  │ │ │ │ │ │   💬 Args: ["COMPLIANCE", false]
  │ │ │ │ │ │   👁️  Def: public
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Helpers.startStateDiffRecording() (NodeID: 89)
  │ │ │ │ │     💬 Args: [no args]
  │ │ │ │ │     👁️  Def: public
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address) (NodeID: 90)
  │ │ │ │ │   💬 Args: [instance, moduleTypeId, module, data, address(instance.defaultValidator)]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.signDefault(struct UserOpData) (NodeID: 91)
  │ │ │ │ │   💬 Args: [userOpData]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 92)
  │ │ │ │     💬 Args: [userOpData]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 93)
  │ │ │ │       💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │ │ │       👁️  Def: internal
  │ │ │ │     └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 94)
  │ │ │ │         💬 Args: [userOps, onEntryPoint]
  │ │ │ │         👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 95)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 96)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 97)
  │ │ │ │       │   💬 Args: ["SIMULATE", false]
  │ │ │ │       │   👁️  Def: public
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 98)
  │ │ │ │       │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 99)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 100)
  │ │ │ │       │ │ │   💬 Args: [no args]
  │ │ │ │       │ │ │   👁️  Def: internal
  │ │ │ │       │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 101)
  │ │ │ │       │ │ │   💬 Args: [no args]
  │ │ │ │       │ │ │   👁️  Def: internal
  │ │ │ │       │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 102)
  │ │ │ │       │ │     💬 Args: [no args]
  │ │ │ │       │ │     👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 103)
  │ │ │ │       │     💬 Args: [userOpDetails]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 104)
  │ │ │ │       │   │   💬 Args: [no args]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 105)
  │ │ │ │       │   │   💬 Args: [userOpDetails, debugTrace]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 106)
  │ │ │ │       │   │ │   💬 Args: [userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 107)
  │ │ │ │       │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 108)
  │ │ │ │       │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 109)
  │ │ │ │       │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 110)
  │ │ │ │       │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: private
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 111)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 112)
  │ │ │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │ │       │   │ │ │   👁️  Def: private
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 113)
  │ │ │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 114)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 115)
  │ │ │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │ │       │   │ │ │   👁️  Def: private
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 116)
  │ │ │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 117)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 118)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 119)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 120)
  │ │ │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 121)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 122)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 123)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 124)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 125)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 126)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 127)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 128)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 129)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 130)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 131)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 132)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 133)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 134)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 135)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 136)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 137)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 138)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 139)
  │ │ │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 140)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 141)
  │ │ │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 142)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 143)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 144)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 145)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 146)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 147)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 148)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 149)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 150)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 151)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 152)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 153)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 154)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 155)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 156)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 157)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 158)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 159)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 160)
  │ │ │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 161)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 162)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 163)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 164)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 165)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 166)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 167)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 168)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 169)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 170)
  │ │ │ │       │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │     👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 171)
  │ │ │ │       │   │   💬 Args: [no args]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 172)
  │ │ │ │       │       💬 Args: [snapShotId]
  │ │ │ │       │       👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 173)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 174)
  │ │ │ │       │   💬 Args: [ctx.returnData]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 175)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 176)
  │ │ │ │       │     💬 Args: [actualReason, revertMessage]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 177)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 178)
  │ │ │ │       │   💬 Args: [logs, userOpHash]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 179)
  │ │ │ │       │   💬 Args: [account]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 180)
  │ │ │ │       │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 183)
  │ │ │ │       │ │   💬 Args: [logs, userOpHash]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 181)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 182)
  │ │ │ │       │     💬 Args: [actualReason, revertMessage]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 184)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 185)
  │ │ │ │       │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 186)
  │ │ │ │       │   💬 Args: [logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 187)
  │ │ │ │       │   💬 Args: [j, logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 188)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 189)
  │ │ │ │       │     💬 Args: [slot]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 190)
  │ │ │ │       │   💬 Args: ["GAS", false]
  │ │ │ │       │   👁️  Def: public
  │ │ │ │       └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 191)
  │ │ │ │           💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │ │ │           👁️  Def: internal
  │ │ │ │         └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 192)
  │ │ │ │             💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │ │ │             👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 193)
  │ │ │ │           │   💬 Args: [userOpCalldata]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 194)
  │ │ │ │           │ │   💬 Args: [data]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 195)
  │ │ │ │           │     💬 Args: [compressed]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 196)
  │ │ │ │           │   💬 Args: [userOpCalldata]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 197)
  │ │ │ │           │ │   💬 Args: [0.684e18]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 198)
  │ │ │ │           │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 199)
  │ │ │ │           │   │   💬 Args: [getCallDataGas(data)]
  │ │ │ │           │   │   👁️  Def: internal
  │ │ │ │           │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 200)
  │ │ │ │           │   │     💬 Args: [data]
  │ │ │ │           │   │     👁️  Def: internal
  │ │ │ │           │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 201)
  │ │ │ │           │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │ │ │           │       👁️  Def: internal
  │ │ │ │           │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 202)
  │ │ │ │           │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │ │ │           │         👁️  Def: internal
  │ │ │ │           │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 203)
  │ │ │ │           │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │ │ │           │           👁️  Def: internal
  │ │ │ │           │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 204)
  │ │ │ │           │         │   💬 Args: [x]
  │ │ │ │           │         │   👁️  Def: internal
  │ │ │ │           │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 205)
  │ │ │ │           │             💬 Args: [y]
  │ │ │ │           │             👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 206)
  │ │ │ │           │   💬 Args: [fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 207)
  │ │ │ │           │   💬 Args: [fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 208)
  │ │ │ │           │   💬 Args: [fileContent]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 209)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 210)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Total"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 211)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 212)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 213)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 214)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 215)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 216)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 217)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 218)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 219)
  │ │ │ │           │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 220)
  │ │ │ │           │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │ │ │           │       👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 221)
  │ │ │ │           │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 222)
  │ │ │ │           │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 223)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 224)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 225)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 226)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 227)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 228)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 229)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 230)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 231)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 232)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 233)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 234)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 235)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 236)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 237)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 238)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 239)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 240)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 241)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 242)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 243)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 244)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 245)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 246)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 247)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 248)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 249)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 250)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 251)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 252)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 253)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 254)
  │ │ │ │           │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 255)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 256)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 257)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 258)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 259)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 260)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 261)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 262)
  │ │ │ │           │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 263)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 264)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 265)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 266)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 267)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 268)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 269)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 270)
  │ │ │ │           │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 271)
  │ │ │ │           │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 272)
  │ │ │ │           │   💬 Args: [finalJson, fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 273)
  │ │ │ │               💬 Args: [""]
  │ │ │ │               👁️  Def: internal
  │ │ │ │             └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 274)
  │ │ │ │                 💬 Args: [slot, id]
  │ │ │ │                 👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: ModuleKitHelpers.installModule(struct AccountInstance,uint256,address,bytes) (NodeID: 276)
  │ │ │ │   💬 Args: [instance, MODULE_TYPE_EXECUTOR, _getContract(chainIds[i], SUPER_DESTINATION_EXECUTOR_KEY), ""]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 466)
  │ │ │ │ │   💬 Args: [chainIds[i], SUPER_DESTINATION_EXECUTOR_KEY]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.preEnvHook() (NodeID: 277)
  │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ ├─ [6] ⚙️ FUNCTION: Unknown.getStorageCompliance() (NodeID: 278)
  │ │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ ├─ [6] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 279)
  │ │ │ │ │ │   💬 Args: ["COMPLIANCE", false]
  │ │ │ │ │ │   👁️  Def: public
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Helpers.startStateDiffRecording() (NodeID: 280)
  │ │ │ │ │     💬 Args: [no args]
  │ │ │ │ │     👁️  Def: public
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address) (NodeID: 281)
  │ │ │ │ │   💬 Args: [instance, moduleTypeId, module, data, address(instance.defaultValidator)]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.signDefault(struct UserOpData) (NodeID: 282)
  │ │ │ │ │   💬 Args: [userOpData]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 283)
  │ │ │ │     💬 Args: [userOpData]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 284)
  │ │ │ │       💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │ │ │       👁️  Def: internal
  │ │ │ │     └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 285)
  │ │ │ │         💬 Args: [userOps, onEntryPoint]
  │ │ │ │         👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 286)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 287)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 288)
  │ │ │ │       │   💬 Args: ["SIMULATE", false]
  │ │ │ │       │   👁️  Def: public
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 289)
  │ │ │ │       │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 290)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 291)
  │ │ │ │       │ │ │   💬 Args: [no args]
  │ │ │ │       │ │ │   👁️  Def: internal
  │ │ │ │       │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 292)
  │ │ │ │       │ │ │   💬 Args: [no args]
  │ │ │ │       │ │ │   👁️  Def: internal
  │ │ │ │       │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 293)
  │ │ │ │       │ │     💬 Args: [no args]
  │ │ │ │       │ │     👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 294)
  │ │ │ │       │     💬 Args: [userOpDetails]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 295)
  │ │ │ │       │   │   💬 Args: [no args]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 296)
  │ │ │ │       │   │   💬 Args: [userOpDetails, debugTrace]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 297)
  │ │ │ │       │   │ │   💬 Args: [userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 298)
  │ │ │ │       │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 299)
  │ │ │ │       │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 300)
  │ │ │ │       │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 301)
  │ │ │ │       │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: private
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 302)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 303)
  │ │ │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │ │       │   │ │ │   👁️  Def: private
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 304)
  │ │ │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 305)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 306)
  │ │ │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │ │       │   │ │ │   👁️  Def: private
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 307)
  │ │ │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 308)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 309)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 310)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 311)
  │ │ │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 312)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 313)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 314)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 315)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 316)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 317)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 318)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 319)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 320)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 321)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 322)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 323)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 324)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 325)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 326)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 327)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 328)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 329)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 330)
  │ │ │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 331)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 332)
  │ │ │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 333)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 334)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 335)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 336)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 337)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 338)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 339)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 340)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 341)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 342)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 343)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 344)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 345)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 346)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 347)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 348)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 349)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 350)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 351)
  │ │ │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 352)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 353)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 354)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 355)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 356)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 357)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 358)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 359)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 360)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 361)
  │ │ │ │       │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │     👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 362)
  │ │ │ │       │   │   💬 Args: [no args]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 363)
  │ │ │ │       │       💬 Args: [snapShotId]
  │ │ │ │       │       👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 364)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 365)
  │ │ │ │       │   💬 Args: [ctx.returnData]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 366)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 367)
  │ │ │ │       │     💬 Args: [actualReason, revertMessage]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 368)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 369)
  │ │ │ │       │   💬 Args: [logs, userOpHash]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 370)
  │ │ │ │       │   💬 Args: [account]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 371)
  │ │ │ │       │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 374)
  │ │ │ │       │ │   💬 Args: [logs, userOpHash]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 372)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 373)
  │ │ │ │       │     💬 Args: [actualReason, revertMessage]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 375)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 376)
  │ │ │ │       │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 377)
  │ │ │ │       │   💬 Args: [logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 378)
  │ │ │ │       │   💬 Args: [j, logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 379)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 380)
  │ │ │ │       │     💬 Args: [slot]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 381)
  │ │ │ │       │   💬 Args: ["GAS", false]
  │ │ │ │       │   👁️  Def: public
  │ │ │ │       └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 382)
  │ │ │ │           💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │ │ │           👁️  Def: internal
  │ │ │ │         └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 383)
  │ │ │ │             💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │ │ │             👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 384)
  │ │ │ │           │   💬 Args: [userOpCalldata]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 385)
  │ │ │ │           │ │   💬 Args: [data]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 386)
  │ │ │ │           │     💬 Args: [compressed]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 387)
  │ │ │ │           │   💬 Args: [userOpCalldata]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 388)
  │ │ │ │           │ │   💬 Args: [0.684e18]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 389)
  │ │ │ │           │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 390)
  │ │ │ │           │   │   💬 Args: [getCallDataGas(data)]
  │ │ │ │           │   │   👁️  Def: internal
  │ │ │ │           │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 391)
  │ │ │ │           │   │     💬 Args: [data]
  │ │ │ │           │   │     👁️  Def: internal
  │ │ │ │           │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 392)
  │ │ │ │           │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │ │ │           │       👁️  Def: internal
  │ │ │ │           │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 393)
  │ │ │ │           │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │ │ │           │         👁️  Def: internal
  │ │ │ │           │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 394)
  │ │ │ │           │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │ │ │           │           👁️  Def: internal
  │ │ │ │           │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 395)
  │ │ │ │           │         │   💬 Args: [x]
  │ │ │ │           │         │   👁️  Def: internal
  │ │ │ │           │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 396)
  │ │ │ │           │             💬 Args: [y]
  │ │ │ │           │             👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 397)
  │ │ │ │           │   💬 Args: [fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 398)
  │ │ │ │           │   💬 Args: [fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 399)
  │ │ │ │           │   💬 Args: [fileContent]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 400)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 401)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Total"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 402)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 403)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 404)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 405)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 406)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 407)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 408)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 409)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 410)
  │ │ │ │           │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 411)
  │ │ │ │           │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │ │ │           │       👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 412)
  │ │ │ │           │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 413)
  │ │ │ │           │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 414)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 415)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 416)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 417)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 418)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 419)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 420)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 421)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 422)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 423)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 424)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 425)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 426)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 427)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 428)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 429)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 430)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 431)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 432)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 433)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 434)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 435)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 436)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 437)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 438)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 439)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 440)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 441)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 442)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 443)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 444)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 445)
  │ │ │ │           │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 446)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 447)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 448)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 449)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 450)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 451)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 452)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 453)
  │ │ │ │           │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 454)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 455)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 456)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 457)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 458)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 459)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 460)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 461)
  │ │ │ │           │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 462)
  │ │ │ │           │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 463)
  │ │ │ │           │   💬 Args: [finalJson, fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 464)
  │ │ │ │               💬 Args: [""]
  │ │ │ │               👁️  Def: internal
  │ │ │ │             └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 465)
  │ │ │ │                 💬 Args: [slot, id]
  │ │ │ │                 👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: ModuleKitHelpers.installModule(struct AccountInstance,uint256,address,bytes) (NodeID: 467)
  │ │ │ │   💬 Args: [instance, MODULE_TYPE_VALIDATOR, _getContract(chainIds[i], SUPER_DESTINATION_VALIDATOR_KEY), abi.encode(validatorSigners[chainIds[i]])]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 657)
  │ │ │ │ │   💬 Args: [chainIds[i], SUPER_DESTINATION_VALIDATOR_KEY]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.preEnvHook() (NodeID: 468)
  │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ ├─ [6] ⚙️ FUNCTION: Unknown.getStorageCompliance() (NodeID: 469)
  │ │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ ├─ [6] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 470)
  │ │ │ │ │ │   💬 Args: ["COMPLIANCE", false]
  │ │ │ │ │ │   👁️  Def: public
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Helpers.startStateDiffRecording() (NodeID: 471)
  │ │ │ │ │     💬 Args: [no args]
  │ │ │ │ │     👁️  Def: public
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address) (NodeID: 472)
  │ │ │ │ │   💬 Args: [instance, moduleTypeId, module, data, address(instance.defaultValidator)]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.signDefault(struct UserOpData) (NodeID: 473)
  │ │ │ │ │   💬 Args: [userOpData]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 474)
  │ │ │ │     💬 Args: [userOpData]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 475)
  │ │ │ │       💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │ │ │       👁️  Def: internal
  │ │ │ │     └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 476)
  │ │ │ │         💬 Args: [userOps, onEntryPoint]
  │ │ │ │         👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 477)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 478)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 479)
  │ │ │ │       │   💬 Args: ["SIMULATE", false]
  │ │ │ │       │   👁️  Def: public
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 480)
  │ │ │ │       │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 481)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 482)
  │ │ │ │       │ │ │   💬 Args: [no args]
  │ │ │ │       │ │ │   👁️  Def: internal
  │ │ │ │       │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 483)
  │ │ │ │       │ │ │   💬 Args: [no args]
  │ │ │ │       │ │ │   👁️  Def: internal
  │ │ │ │       │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 484)
  │ │ │ │       │ │     💬 Args: [no args]
  │ │ │ │       │ │     👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 485)
  │ │ │ │       │     💬 Args: [userOpDetails]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 486)
  │ │ │ │       │   │   💬 Args: [no args]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 487)
  │ │ │ │       │   │   💬 Args: [userOpDetails, debugTrace]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 488)
  │ │ │ │       │   │ │   💬 Args: [userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 489)
  │ │ │ │       │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 490)
  │ │ │ │       │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 491)
  │ │ │ │       │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 492)
  │ │ │ │       │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: private
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 493)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 494)
  │ │ │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │ │       │   │ │ │   👁️  Def: private
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 495)
  │ │ │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 496)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 497)
  │ │ │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │ │       │   │ │ │   👁️  Def: private
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 498)
  │ │ │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 499)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 500)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 501)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 502)
  │ │ │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 503)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 504)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 505)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 506)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 507)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 508)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 509)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 510)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 511)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 512)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 513)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 514)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 515)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 516)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 517)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 518)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 519)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 520)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 521)
  │ │ │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 522)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 523)
  │ │ │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 524)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 525)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 526)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 527)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 528)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 529)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 530)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 531)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 532)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 533)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 534)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 535)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 536)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 537)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 538)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 539)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 540)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 541)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 542)
  │ │ │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 543)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 544)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 545)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 546)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 547)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 548)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 549)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 550)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 551)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 552)
  │ │ │ │       │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │     👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 553)
  │ │ │ │       │   │   💬 Args: [no args]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 554)
  │ │ │ │       │       💬 Args: [snapShotId]
  │ │ │ │       │       👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 555)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 556)
  │ │ │ │       │   💬 Args: [ctx.returnData]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 557)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 558)
  │ │ │ │       │     💬 Args: [actualReason, revertMessage]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 559)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 560)
  │ │ │ │       │   💬 Args: [logs, userOpHash]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 561)
  │ │ │ │       │   💬 Args: [account]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 562)
  │ │ │ │       │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 565)
  │ │ │ │       │ │   💬 Args: [logs, userOpHash]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 563)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 564)
  │ │ │ │       │     💬 Args: [actualReason, revertMessage]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 566)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 567)
  │ │ │ │       │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 568)
  │ │ │ │       │   💬 Args: [logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 569)
  │ │ │ │       │   💬 Args: [j, logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 570)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 571)
  │ │ │ │       │     💬 Args: [slot]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 572)
  │ │ │ │       │   💬 Args: ["GAS", false]
  │ │ │ │       │   👁️  Def: public
  │ │ │ │       └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 573)
  │ │ │ │           💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │ │ │           👁️  Def: internal
  │ │ │ │         └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 574)
  │ │ │ │             💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │ │ │             👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 575)
  │ │ │ │           │   💬 Args: [userOpCalldata]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 576)
  │ │ │ │           │ │   💬 Args: [data]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 577)
  │ │ │ │           │     💬 Args: [compressed]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 578)
  │ │ │ │           │   💬 Args: [userOpCalldata]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 579)
  │ │ │ │           │ │   💬 Args: [0.684e18]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 580)
  │ │ │ │           │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 581)
  │ │ │ │           │   │   💬 Args: [getCallDataGas(data)]
  │ │ │ │           │   │   👁️  Def: internal
  │ │ │ │           │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 582)
  │ │ │ │           │   │     💬 Args: [data]
  │ │ │ │           │   │     👁️  Def: internal
  │ │ │ │           │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 583)
  │ │ │ │           │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │ │ │           │       👁️  Def: internal
  │ │ │ │           │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 584)
  │ │ │ │           │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │ │ │           │         👁️  Def: internal
  │ │ │ │           │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 585)
  │ │ │ │           │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │ │ │           │           👁️  Def: internal
  │ │ │ │           │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 586)
  │ │ │ │           │         │   💬 Args: [x]
  │ │ │ │           │         │   👁️  Def: internal
  │ │ │ │           │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 587)
  │ │ │ │           │             💬 Args: [y]
  │ │ │ │           │             👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 588)
  │ │ │ │           │   💬 Args: [fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 589)
  │ │ │ │           │   💬 Args: [fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 590)
  │ │ │ │           │   💬 Args: [fileContent]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 591)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 592)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Total"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 593)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 594)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 595)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 596)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 597)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 598)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 599)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 600)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 601)
  │ │ │ │           │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 602)
  │ │ │ │           │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │ │ │           │       👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 603)
  │ │ │ │           │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 604)
  │ │ │ │           │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 605)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 606)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 607)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 608)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 609)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 610)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 611)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 612)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 613)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 614)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 615)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 616)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 617)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 618)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 619)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 620)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 621)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 622)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 623)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 624)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 625)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 626)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 627)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 628)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 629)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 630)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 631)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 632)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 633)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 634)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 635)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 636)
  │ │ │ │           │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 637)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 638)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 639)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 640)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 641)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 642)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 643)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 644)
  │ │ │ │           │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 645)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 646)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 647)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 648)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 649)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 650)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 651)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 652)
  │ │ │ │           │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 653)
  │ │ │ │           │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 654)
  │ │ │ │           │   💬 Args: [finalJson, fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 655)
  │ │ │ │               💬 Args: [""]
  │ │ │ │               👁️  Def: internal
  │ │ │ │             └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 656)
  │ │ │ │                 💬 Args: [slot, id]
  │ │ │ │                 👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: ModuleKitHelpers.installModule(struct AccountInstance,uint256,address,bytes) (NodeID: 658)
  │ │ │ │   💬 Args: [instance, MODULE_TYPE_VALIDATOR, _getContract(chainIds[i], SUPER_MERKLE_VALIDATOR_KEY), abi.encode(validatorSigners[chainIds[i]])]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 848)
  │ │ │ │ │   💬 Args: [chainIds[i], SUPER_MERKLE_VALIDATOR_KEY]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.preEnvHook() (NodeID: 659)
  │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ ├─ [6] ⚙️ FUNCTION: Unknown.getStorageCompliance() (NodeID: 660)
  │ │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ ├─ [6] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 661)
  │ │ │ │ │ │   💬 Args: ["COMPLIANCE", false]
  │ │ │ │ │ │   👁️  Def: public
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Helpers.startStateDiffRecording() (NodeID: 662)
  │ │ │ │ │     💬 Args: [no args]
  │ │ │ │ │     👁️  Def: public
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address) (NodeID: 663)
  │ │ │ │ │   💬 Args: [instance, moduleTypeId, module, data, address(instance.defaultValidator)]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.signDefault(struct UserOpData) (NodeID: 664)
  │ │ │ │ │   💬 Args: [userOpData]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 665)
  │ │ │ │     💬 Args: [userOpData]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 666)
  │ │ │ │       💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │ │ │       👁️  Def: internal
  │ │ │ │     └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 667)
  │ │ │ │         💬 Args: [userOps, onEntryPoint]
  │ │ │ │         👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 668)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 669)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 670)
  │ │ │ │       │   💬 Args: ["SIMULATE", false]
  │ │ │ │       │   👁️  Def: public
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 671)
  │ │ │ │       │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 672)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 673)
  │ │ │ │       │ │ │   💬 Args: [no args]
  │ │ │ │       │ │ │   👁️  Def: internal
  │ │ │ │       │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 674)
  │ │ │ │       │ │ │   💬 Args: [no args]
  │ │ │ │       │ │ │   👁️  Def: internal
  │ │ │ │       │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 675)
  │ │ │ │       │ │     💬 Args: [no args]
  │ │ │ │       │ │     👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 676)
  │ │ │ │       │     💬 Args: [userOpDetails]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 677)
  │ │ │ │       │   │   💬 Args: [no args]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 678)
  │ │ │ │       │   │   💬 Args: [userOpDetails, debugTrace]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 679)
  │ │ │ │       │   │ │   💬 Args: [userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 680)
  │ │ │ │       │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 681)
  │ │ │ │       │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 682)
  │ │ │ │       │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 683)
  │ │ │ │       │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: private
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 684)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 685)
  │ │ │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │ │       │   │ │ │   👁️  Def: private
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 686)
  │ │ │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 687)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 688)
  │ │ │ │       │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │ │       │   │ │ │   👁️  Def: private
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 689)
  │ │ │ │       │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 690)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 691)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 692)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 693)
  │ │ │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 694)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 695)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 696)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 697)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 698)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 699)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 700)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 701)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 702)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 703)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 704)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 705)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 706)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 707)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 708)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 709)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 710)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 711)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 712)
  │ │ │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 713)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 714)
  │ │ │ │       │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 715)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 716)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 717)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 718)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 719)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 720)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 721)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 722)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 723)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 724)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 725)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 726)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 727)
  │ │ │ │       │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │ │       │   │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 728)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 729)
  │ │ │ │       │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 730)
  │ │ │ │       │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │ │       │   │ │ │ │ │   👁️  Def: internal
  │ │ │ │       │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 731)
  │ │ │ │       │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │ │       │   │ │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 732)
  │ │ │ │       │   │ │ │     💬 Args: [key, entity]
  │ │ │ │       │   │ │ │     👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 733)
  │ │ │ │       │   │ │     💬 Args: [currentAccessAccount]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 734)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 735)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 736)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 737)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 738)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 739)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 740)
  │ │ │ │       │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 741)
  │ │ │ │       │   │ │     💬 Args: [targetAddr]
  │ │ │ │       │   │ │     👁️  Def: internal
  │ │ │ │       │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 742)
  │ │ │ │       │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │ │   👁️  Def: internal
  │ │ │ │       │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 743)
  │ │ │ │       │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │ │       │   │     👁️  Def: internal
  │ │ │ │       │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 744)
  │ │ │ │       │   │   💬 Args: [no args]
  │ │ │ │       │   │   👁️  Def: internal
  │ │ │ │       │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 745)
  │ │ │ │       │       💬 Args: [snapShotId]
  │ │ │ │       │       👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 746)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 747)
  │ │ │ │       │   💬 Args: [ctx.returnData]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 748)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 749)
  │ │ │ │       │     💬 Args: [actualReason, revertMessage]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 750)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 751)
  │ │ │ │       │   💬 Args: [logs, userOpHash]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 752)
  │ │ │ │       │   💬 Args: [account]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 753)
  │ │ │ │       │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 756)
  │ │ │ │       │ │   💬 Args: [logs, userOpHash]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 754)
  │ │ │ │       │ │   💬 Args: [no args]
  │ │ │ │       │ │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 755)
  │ │ │ │       │     💬 Args: [actualReason, revertMessage]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 757)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 758)
  │ │ │ │       │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 759)
  │ │ │ │       │   💬 Args: [logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 760)
  │ │ │ │       │   💬 Args: [j, logs[i].emitter]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 761)
  │ │ │ │       │   💬 Args: [no args]
  │ │ │ │       │   👁️  Def: internal
  │ │ │ │       │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 762)
  │ │ │ │       │     💬 Args: [slot]
  │ │ │ │       │     👁️  Def: internal
  │ │ │ │       ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 763)
  │ │ │ │       │   💬 Args: ["GAS", false]
  │ │ │ │       │   👁️  Def: public
  │ │ │ │       └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 764)
  │ │ │ │           💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │ │ │           👁️  Def: internal
  │ │ │ │         └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 765)
  │ │ │ │             💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │ │ │             👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 766)
  │ │ │ │           │   💬 Args: [userOpCalldata]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 767)
  │ │ │ │           │ │   💬 Args: [data]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 768)
  │ │ │ │           │     💬 Args: [compressed]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 769)
  │ │ │ │           │   💬 Args: [userOpCalldata]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 770)
  │ │ │ │           │ │   💬 Args: [0.684e18]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 771)
  │ │ │ │           │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 772)
  │ │ │ │           │   │   💬 Args: [getCallDataGas(data)]
  │ │ │ │           │   │   👁️  Def: internal
  │ │ │ │           │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 773)
  │ │ │ │           │   │     💬 Args: [data]
  │ │ │ │           │   │     👁️  Def: internal
  │ │ │ │           │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 774)
  │ │ │ │           │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │ │ │           │       👁️  Def: internal
  │ │ │ │           │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 775)
  │ │ │ │           │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │ │ │           │         👁️  Def: internal
  │ │ │ │           │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 776)
  │ │ │ │           │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │ │ │           │           👁️  Def: internal
  │ │ │ │           │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 777)
  │ │ │ │           │         │   💬 Args: [x]
  │ │ │ │           │         │   👁️  Def: internal
  │ │ │ │           │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 778)
  │ │ │ │           │             💬 Args: [y]
  │ │ │ │           │             👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 779)
  │ │ │ │           │   💬 Args: [fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 780)
  │ │ │ │           │   💬 Args: [fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 781)
  │ │ │ │           │   💬 Args: [fileContent]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 782)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 783)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Total"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 784)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 785)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 786)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 787)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 788)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 789)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 790)
  │ │ │ │           │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 791)
  │ │ │ │           │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 792)
  │ │ │ │           │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 793)
  │ │ │ │           │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │ │ │           │       👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 794)
  │ │ │ │           │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 795)
  │ │ │ │           │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 796)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 797)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 798)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 799)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 800)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 801)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 802)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 803)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 804)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 805)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 806)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 807)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 808)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 809)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 810)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 811)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 812)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 813)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 814)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 815)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 816)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 817)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 818)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 819)
  │ │ │ │           │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 820)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 821)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 822)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 823)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 824)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 825)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 826)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 827)
  │ │ │ │           │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 828)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 829)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 830)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 831)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 832)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 833)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 834)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 835)
  │ │ │ │           │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 836)
  │ │ │ │           │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │ │ │           │ │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 837)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 838)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 839)
  │ │ │ │           │ │   │   💬 Args: [int256(newValue)]
  │ │ │ │           │ │   │   👁️  Def: internal
  │ │ │ │           │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 840)
  │ │ │ │           │ │   │     💬 Args: [value]
  │ │ │ │           │ │   │     👁️  Def: internal
  │ │ │ │           │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 841)
  │ │ │ │           │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │ │           │ │       👁️  Def: internal
  │ │ │ │           │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 842)
  │ │ │ │           │ │         💬 Args: [value]
  │ │ │ │           │ │         👁️  Def: internal
  │ │ │ │           │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 843)
  │ │ │ │           │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │ │ │           │ │   👁️  Def: internal
  │ │ │ │           │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 844)
  │ │ │ │           │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │ │ │           │     👁️  Def: internal
  │ │ │ │           ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 845)
  │ │ │ │           │   💬 Args: [finalJson, fileName]
  │ │ │ │           │   👁️  Def: internal
  │ │ │ │           └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 846)
  │ │ │ │               💬 Args: [""]
  │ │ │ │               👁️  Def: internal
  │ │ │ │             └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 847)
  │ │ │ │                 💬 Args: [slot, id]
  │ │ │ │                 👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: RhinestoneModuleKit.makeAccountInstance(bytes32) (NodeID: 849)
  │ │ │ │   💬 Args: [keccak256(abi.encode(block.timestamp, j))]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getAccountEnv() (NodeID: 850)
  │ │ │ │ │   💬 Args: [no args]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Unknown.getAccountEnv() (NodeID: 851)
  │ │ │ │ │     💬 Args: [no args]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 852)
  │ │ │ │ │   💬 Args: [address(account), toString(salt)]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: Unknown.toString(bytes32) (NodeID: 853)
  │ │ │ │ │     💬 Args: [salt]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 854)
  │ │ │ │ │   💬 Args: [account, 10 ether]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: RhinestoneModuleKit._makeAccountInstance(bytes32,address,bytes,address,address,address,enum AccountType,address) (NodeID: 855)
  │ │ │ │ │   💬 Args: [salt, env, accountHelper, account, initCode, address(_defaultValidator), address(accountFactory), address(_defaultSessionValidator)]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] 🔒 MODIFIER: RhinestoneModuleKit.initializeModuleKit() (NodeID: 856)
  │ │ │ │     💬 Args: [no args]
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: Helpers.envOr(string,string) (NodeID: 857)
  │ │ │ │   │   💬 Args: ["ACCOUNT_TYPE", DEFAULT]
  │ │ │ │   │   👁️  Def: public
  │ │ │ │   └─ [6] ⚙️ FUNCTION: RhinestoneModuleKit._initializeModuleKit(string) (NodeID: 858)
  │ │ │ │       💬 Args: [_env]
  │ │ │ │       👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: AuxiliaryFactory.init() (NodeID: 859)
  │ │ │ │     │   💬 Args: [no args]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 860)
  │ │ │ │     │ │   💬 Args: [address(auxiliary.mockFactory), "Mock Factory"]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.etchEntrypoint() (NodeID: 861)
  │ │ │ │     │ │   💬 Args: [no args]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ │ └─ [9] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 862)
  │ │ │ │     │ │     💬 Args: [ENTRYPOINT_ADDR, entryPoint.code]
  │ │ │ │     │ │     👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 863)
  │ │ │ │     │ │   💬 Args: [address(auxiliary.entrypoint), "EntryPoint"]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.etchRegistry() (NodeID: 864)
  │ │ │ │     │ │   💬 Args: [no args]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ │ └─ [9] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 865)
  │ │ │ │     │ │     💬 Args: [REGISTRY_ADDR, _registry.code]
  │ │ │ │     │ │     👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 866)
  │ │ │ │     │ │   💬 Args: [address(auxiliary.registry), "ERC7484Registry"]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ ├─ [8] ⚙️ FUNCTION: Unknown.etchSmartSessions() (NodeID: 867)
  │ │ │ │     │ │   💬 Args: [no args]
  │ │ │ │     │ │   👁️  Def: internal
  │ │ │ │     │ │ └─ [9] ⚙️ FUNCTION: Unknown.etch(address,bytes) (NodeID: 868)
  │ │ │ │     │ │     💬 Args: [address(SMARTSESSION_ADDR), SMART_SESSION_DEPLOYED_BYTECODE]
  │ │ │ │     │ │     👁️  Def: internal
  │ │ │ │     │ └─ [8] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 869)
  │ │ │ │     │     💬 Args: [address(auxiliary.smartSession), "SmartSession"]
  │ │ │ │     │     👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 870)
  │ │ │ │     │   💬 Args: [address(new ERC7579Factory()), DEFAULT]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 871)
  │ │ │ │     │   💬 Args: [address(new SafeFactory()), SAFE]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 872)
  │ │ │ │     │   💬 Args: [address(new KernelFactory()), KERNEL]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 873)
  │ │ │ │     │   💬 Args: [address(new NexusFactory()), NEXUS]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeFactory(address,string) (NodeID: 874)
  │ │ │ │     │   💬 Args: [address(new ERC7579Factory()), CUSTOM]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 875)
  │ │ │ │     │   💬 Args: [address(new ERC7579Helpers()), DEFAULT]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 876)
  │ │ │ │     │   💬 Args: [address(new SafeHelpers()), SAFE]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 877)
  │ │ │ │     │   💬 Args: [address(new KernelHelpers()), KERNEL]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 878)
  │ │ │ │     │   💬 Args: [address(new NexusHelpers()), NEXUS]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.writeHelper(address,string) (NodeID: 879)
  │ │ │ │     │   💬 Args: [address(new ERC7579Helpers()), CUSTOM]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 880)
  │ │ │ │     │   💬 Args: [SAFE]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 881)
  │ │ │ │     │   💬 Args: [KERNEL]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 882)
  │ │ │ │     │   💬 Args: [DEFAULT]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 883)
  │ │ │ │     │   💬 Args: [NEXUS]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 884)
  │ │ │ │     │   💬 Args: [CUSTOM]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 885)
  │ │ │ │     │   💬 Args: [address(safeFactory), "SafeFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 886)
  │ │ │ │     │   💬 Args: [address(kernelFactory), "KernelFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 887)
  │ │ │ │     │   💬 Args: [address(erc7579Factory), "ERC7579Factory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 888)
  │ │ │ │     │   💬 Args: [address(nexusFactory), "NexusFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 889)
  │ │ │ │     │   💬 Args: [address(customFactory), "CustomFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 890)
  │ │ │ │     │   💬 Args: [address(safeFactory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 891)
  │ │ │ │     │   💬 Args: [address(kernelFactory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 892)
  │ │ │ │     │   💬 Args: [address(erc7579Factory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 893)
  │ │ │ │     │   💬 Args: [address(nexusFactory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 894)
  │ │ │ │     │   💬 Args: [address(customFactory), 10 ether]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 895)
  │ │ │ │     │   💬 Args: [address(safeFactory)]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 896)
  │ │ │ │     │   💬 Args: [address(kernelFactory)]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 897)
  │ │ │ │     │   💬 Args: [address(erc7579Factory)]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.prank(address) (NodeID: 898)
  │ │ │ │     │   💬 Args: [address(nexusFactory)]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: ModuleKitHelpers.setAccountEnv(string) (NodeID: 899)
  │ │ │ │     │   💬 Args: [_env]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     │ └─ [8] ⚙️ FUNCTION: ModuleKitHelpers._setAccountEnv(string) (NodeID: 900)
  │ │ │ │     │     💬 Args: [env]
  │ │ │ │     │     👁️  Def: private
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 901)
  │ │ │ │     │   │   💬 Args: [env]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.getHelper(string) (NodeID: 902)
  │ │ │ │     │   │   💬 Args: [env]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 903)
  │ │ │ │     │   │   💬 Args: [env, factory, helper]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 904)
  │ │ │ │     │   │   💬 Args: [env, factory, helper]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 905)
  │ │ │ │     │   │   💬 Args: [env, factory, helper]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   ├─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 906)
  │ │ │ │     │   │   💬 Args: [env, factory, helper]
  │ │ │ │     │   │   👁️  Def: internal
  │ │ │ │     │   └─ [9] ⚙️ FUNCTION: Unknown.writeAccountEnv(string,address,address) (NodeID: 907)
  │ │ │ │     │       💬 Args: [env, factory, helper]
  │ │ │ │     │       👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.getFactory(string) (NodeID: 908)
  │ │ │ │     │   💬 Args: [_env]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 909)
  │ │ │ │     │   💬 Args: [address(accountFactory), "AccountFactory"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     ├─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 910)
  │ │ │ │     │   💬 Args: [address(_defaultValidator), "DefaultValidator"]
  │ │ │ │     │   👁️  Def: internal
  │ │ │ │     └─ [7] ⚙️ FUNCTION: Unknown.label(address,string) (NodeID: 911)
  │ │ │ │         💬 Args: [address(_defaultSessionValidator), "SessionValidator"]
  │ │ │ │         👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.installModule(struct AccountInstance,uint256,address,bytes) (NodeID: 912)
  │ │ │     💬 Args: [_instance, MODULE_TYPE_EXECUTOR, _getContract(chainIds[i], "SuperExecutor"), ""]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1102)
  │ │ │   │   💬 Args: [chainIds[i], "SuperExecutor"]
  │ │ │   │   👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.preEnvHook() (NodeID: 913)
  │ │ │   │   💬 Args: [no args]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ ├─ [6] ⚙️ FUNCTION: Unknown.getStorageCompliance() (NodeID: 914)
  │ │ │   │ │   💬 Args: [no args]
  │ │ │   │ │   👁️  Def: internal
  │ │ │   │ ├─ [6] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 915)
  │ │ │   │ │   💬 Args: ["COMPLIANCE", false]
  │ │ │   │ │   👁️  Def: public
  │ │ │   │ └─ [6] ⚙️ FUNCTION: Helpers.startStateDiffRecording() (NodeID: 916)
  │ │ │   │     💬 Args: [no args]
  │ │ │   │     👁️  Def: public
  │ │ │   ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.getInstallModuleOps(struct AccountInstance,uint256,address,bytes,address) (NodeID: 917)
  │ │ │   │   💬 Args: [instance, moduleTypeId, module, data, address(instance.defaultValidator)]
  │ │ │   │   👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: ModuleKitHelpers.signDefault(struct UserOpData) (NodeID: 918)
  │ │ │   │   💬 Args: [userOpData]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 919)
  │ │ │       💬 Args: [userOpData]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 920)
  │ │ │         💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 921)
  │ │ │           💬 Args: [userOps, onEntryPoint]
  │ │ │           👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 922)
  │ │ │         │   💬 Args: [no args]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 923)
  │ │ │         │   💬 Args: [no args]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 924)
  │ │ │         │   💬 Args: ["SIMULATE", false]
  │ │ │         │   👁️  Def: public
  │ │ │         ├─ [8] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 925)
  │ │ │         │   💬 Args: [userOps[0], address(onEntryPoint)]
  │ │ │         │   👁️  Def: internal
  │ │ │         │ ├─ [9] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 926)
  │ │ │         │ │   💬 Args: [no args]
  │ │ │         │ │   👁️  Def: internal
  │ │ │         │ │ ├─ [10] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 927)
  │ │ │         │ │ │   💬 Args: [no args]
  │ │ │         │ │ │   👁️  Def: internal
  │ │ │         │ │ ├─ [10] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 928)
  │ │ │         │ │ │   💬 Args: [no args]
  │ │ │         │ │ │   👁️  Def: internal
  │ │ │         │ │ └─ [10] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 929)
  │ │ │         │ │     💬 Args: [no args]
  │ │ │         │ │     👁️  Def: internal
  │ │ │         │ └─ [9] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 930)
  │ │ │         │     💬 Args: [userOpDetails]
  │ │ │         │     👁️  Def: internal
  │ │ │         │   ├─ [10] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 931)
  │ │ │         │   │   💬 Args: [no args]
  │ │ │         │   │   👁️  Def: internal
  │ │ │         │   ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 932)
  │ │ │         │   │   💬 Args: [userOpDetails, debugTrace]
  │ │ │         │   │   👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 933)
  │ │ │         │   │ │   💬 Args: [userOpDetails]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 934)
  │ │ │         │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 935)
  │ │ │         │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 936)
  │ │ │         │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │ │ │         │   │ │     👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 937)
  │ │ │         │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │ │ │         │   │ │   👁️  Def: private
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 938)
  │ │ │         │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 939)
  │ │ │         │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │         │   │ │ │   👁️  Def: private
  │ │ │         │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 940)
  │ │ │         │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │         │   │ │     👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 941)
  │ │ │         │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 942)
  │ │ │         │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │ │ │         │   │ │ │   👁️  Def: private
  │ │ │         │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 943)
  │ │ │         │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │ │ │         │   │ │     👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 944)
  │ │ │         │   │ │   💬 Args: [filteredUserOpSteps]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 945)
  │ │ │         │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 946)
  │ │ │         │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 947)
  │ │ │         │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 948)
  │ │ │         │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 949)
  │ │ │         │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 950)
  │ │ │         │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 951)
  │ │ │         │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 952)
  │ │ │         │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │         │   │ │ │ │     👁️  Def: internal
  │ │ │         │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 953)
  │ │ │         │   │ │ │     💬 Args: [key, entity]
  │ │ │         │   │ │ │     👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 954)
  │ │ │         │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 955)
  │ │ │         │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 956)
  │ │ │         │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 957)
  │ │ │         │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 958)
  │ │ │         │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │         │   │ │ │ │     👁️  Def: internal
  │ │ │         │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 959)
  │ │ │         │   │ │ │     💬 Args: [key, entity]
  │ │ │         │   │ │ │     👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 960)
  │ │ │         │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 961)
  │ │ │         │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 962)
  │ │ │         │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 963)
  │ │ │         │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 964)
  │ │ │         │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │         │   │ │ │ │     👁️  Def: internal
  │ │ │         │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 965)
  │ │ │         │   │ │ │     💬 Args: [key, entity]
  │ │ │         │   │ │ │     👁️  Def: internal
  │ │ │         │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 966)
  │ │ │         │   │ │     💬 Args: [currentAccessAccount]
  │ │ │         │   │ │     👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 967)
  │ │ │         │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 968)
  │ │ │         │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 969)
  │ │ │         │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 970)
  │ │ │         │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 971)
  │ │ │         │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 972)
  │ │ │         │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 973)
  │ │ │         │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │         │   │ │ │ │     👁️  Def: internal
  │ │ │         │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 974)
  │ │ │         │   │ │ │     💬 Args: [key, entity]
  │ │ │         │   │ │ │     👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 975)
  │ │ │         │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 976)
  │ │ │         │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 977)
  │ │ │         │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 978)
  │ │ │         │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 979)
  │ │ │         │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │         │   │ │ │ │     👁️  Def: internal
  │ │ │         │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 980)
  │ │ │         │   │ │ │     💬 Args: [key, entity]
  │ │ │         │   │ │ │     👁️  Def: internal
  │ │ │         │   │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 981)
  │ │ │         │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │ │ │         │   │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 982)
  │ │ │         │   │ │ │ │   💬 Args: [currentSlot, entity]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ ├─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 983)
  │ │ │         │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ ├─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 984)
  │ │ │         │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │ │ │         │   │ │ │ │ │   👁️  Def: internal
  │ │ │         │   │ │ │ │ └─ [14] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 985)
  │ │ │         │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │ │ │         │   │ │ │ │     👁️  Def: internal
  │ │ │         │   │ │ │ └─ [13] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 986)
  │ │ │         │   │ │ │     💬 Args: [key, entity]
  │ │ │         │   │ │ │     👁️  Def: internal
  │ │ │         │   │ │ └─ [12] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 987)
  │ │ │         │   │ │     💬 Args: [currentAccessAccount]
  │ │ │         │   │ │     👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 988)
  │ │ │         │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 989)
  │ │ │         │   │ │     💬 Args: [targetAddr]
  │ │ │         │   │ │     👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 990)
  │ │ │         │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 991)
  │ │ │         │   │ │     💬 Args: [targetAddr]
  │ │ │         │   │ │     👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 992)
  │ │ │         │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 993)
  │ │ │         │   │ │     💬 Args: [targetAddr]
  │ │ │         │   │ │     👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 994)
  │ │ │         │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 995)
  │ │ │         │   │ │     💬 Args: [targetAddr]
  │ │ │         │   │ │     👁️  Def: internal
  │ │ │         │   │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 996)
  │ │ │         │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │ │ │         │   │ │   👁️  Def: internal
  │ │ │         │   │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 997)
  │ │ │         │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │ │ │         │   │     👁️  Def: internal
  │ │ │         │   ├─ [10] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 998)
  │ │ │         │   │   💬 Args: [no args]
  │ │ │         │   │   👁️  Def: internal
  │ │ │         │   └─ [10] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 999)
  │ │ │         │       💬 Args: [snapShotId]
  │ │ │         │       👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 1000)
  │ │ │         │   💬 Args: [no args]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 1001)
  │ │ │         │   💬 Args: [ctx.returnData]
  │ │ │         │   👁️  Def: internal
  │ │ │         │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 1002)
  │ │ │         │ │   💬 Args: [no args]
  │ │ │         │ │   👁️  Def: internal
  │ │ │         │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 1003)
  │ │ │         │     💬 Args: [actualReason, revertMessage]
  │ │ │         │     👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 1004)
  │ │ │         │   💬 Args: [no args]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 1005)
  │ │ │         │   💬 Args: [logs, userOpHash]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 1006)
  │ │ │         │   💬 Args: [account]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 1007)
  │ │ │         │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │ │ │         │   👁️  Def: internal
  │ │ │         │ ├─ [9] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 1010)
  │ │ │         │ │   💬 Args: [logs, userOpHash]
  │ │ │         │ │   👁️  Def: internal
  │ │ │         │ ├─ [9] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 1008)
  │ │ │         │ │   💬 Args: [no args]
  │ │ │         │ │   👁️  Def: internal
  │ │ │         │ └─ [9] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 1009)
  │ │ │         │     💬 Args: [actualReason, revertMessage]
  │ │ │         │     👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 1011)
  │ │ │         │   💬 Args: [no args]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 1012)
  │ │ │         │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 1013)
  │ │ │         │   💬 Args: [logs[i].emitter]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 1014)
  │ │ │         │   💬 Args: [j, logs[i].emitter]
  │ │ │         │   👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 1015)
  │ │ │         │   💬 Args: [no args]
  │ │ │         │   👁️  Def: internal
  │ │ │         │ └─ [9] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 1016)
  │ │ │         │     💬 Args: [slot]
  │ │ │         │     👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 1017)
  │ │ │         │   💬 Args: ["GAS", false]
  │ │ │         │   👁️  Def: public
  │ │ │         └─ [8] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 1018)
  │ │ │             💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │ │ │             👁️  Def: internal
  │ │ │           └─ [9] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 1019)
  │ │ │               💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │ │ │               👁️  Def: internal
  │ │ │             ├─ [10] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 1020)
  │ │ │             │   💬 Args: [userOpCalldata]
  │ │ │             │   👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 1021)
  │ │ │             │ │   💬 Args: [data]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ └─ [11] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 1022)
  │ │ │             │     💬 Args: [compressed]
  │ │ │             │     👁️  Def: internal
  │ │ │             ├─ [10] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 1023)
  │ │ │             │   💬 Args: [userOpCalldata]
  │ │ │             │   👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 1024)
  │ │ │             │ │   💬 Args: [0.684e18]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ └─ [11] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 1025)
  │ │ │             │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │ │ │             │     👁️  Def: internal
  │ │ │             │   ├─ [12] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 1026)
  │ │ │             │   │   💬 Args: [getCallDataGas(data)]
  │ │ │             │   │   👁️  Def: internal
  │ │ │             │   │ └─ [13] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 1027)
  │ │ │             │   │     💬 Args: [data]
  │ │ │             │   │     👁️  Def: internal
  │ │ │             │   └─ [12] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 1028)
  │ │ │             │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │ │ │             │       👁️  Def: internal
  │ │ │             │     └─ [13] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 1029)
  │ │ │             │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │ │ │             │         👁️  Def: internal
  │ │ │             │       └─ [14] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 1030)
  │ │ │             │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │ │ │             │           👁️  Def: internal
  │ │ │             │         ├─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 1031)
  │ │ │             │         │   💬 Args: [x]
  │ │ │             │         │   👁️  Def: internal
  │ │ │             │         └─ [15] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 1032)
  │ │ │             │             💬 Args: [y]
  │ │ │             │             👁️  Def: internal
  │ │ │             ├─ [10] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 1033)
  │ │ │             │   💬 Args: [fileName]
  │ │ │             │   👁️  Def: internal
  │ │ │             ├─ [10] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 1034)
  │ │ │             │   💬 Args: [fileName]
  │ │ │             │   👁️  Def: internal
  │ │ │             ├─ [10] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 1035)
  │ │ │             │   💬 Args: [fileContent]
  │ │ │             │   👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1036)
  │ │ │             │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1037)
  │ │ │             │ │     💬 Args: [fileContent, ".Total"]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1038)
  │ │ │             │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1039)
  │ │ │             │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1040)
  │ │ │             │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1041)
  │ │ │             │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1042)
  │ │ │             │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1043)
  │ │ │             │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1044)
  │ │ │             │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1045)
  │ │ │             │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ └─ [11] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 1046)
  │ │ │             │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │ │ │             │     👁️  Def: internal
  │ │ │             │   └─ [12] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 1047)
  │ │ │             │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │ │ │             │       👁️  Def: internal
  │ │ │             ├─ [10] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 1048)
  │ │ │             │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │ │ │             │   👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1049)
  │ │ │             │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1050)
  │ │ │             │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1051)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1052)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1053)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1054)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1055)
  │ │ │             │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │             │ │       👁️  Def: internal
  │ │ │             │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1056)
  │ │ │             │ │         💬 Args: [value]
  │ │ │             │ │         👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1057)
  │ │ │             │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1058)
  │ │ │             │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1059)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1060)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1061)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1062)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1063)
  │ │ │             │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │             │ │       👁️  Def: internal
  │ │ │             │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1064)
  │ │ │             │ │         💬 Args: [value]
  │ │ │             │ │         👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1065)
  │ │ │             │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1066)
  │ │ │             │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1067)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1068)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1069)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1070)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1071)
  │ │ │             │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │             │ │       👁️  Def: internal
  │ │ │             │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1072)
  │ │ │             │ │         💬 Args: [value]
  │ │ │             │ │         👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1073)
  │ │ │             │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1074)
  │ │ │             │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1075)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1076)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1077)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1078)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1079)
  │ │ │             │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │             │ │       👁️  Def: internal
  │ │ │             │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1080)
  │ │ │             │ │         💬 Args: [value]
  │ │ │             │ │         👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1081)
  │ │ │             │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1082)
  │ │ │             │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1083)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1084)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1085)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1086)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1087)
  │ │ │             │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │             │ │       👁️  Def: internal
  │ │ │             │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1088)
  │ │ │             │ │         💬 Args: [value]
  │ │ │             │ │         👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1089)
  │ │ │             │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ │ └─ [12] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 1090)
  │ │ │             │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │ │ │             │ │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1091)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1092)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   ├─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1093)
  │ │ │             │ │   │   💬 Args: [int256(newValue)]
  │ │ │             │ │   │   👁️  Def: internal
  │ │ │             │ │   │ └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1094)
  │ │ │             │ │   │     💬 Args: [value]
  │ │ │             │ │   │     👁️  Def: internal
  │ │ │             │ │   └─ [13] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 1095)
  │ │ │             │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │ │ │             │ │       👁️  Def: internal
  │ │ │             │ │     └─ [14] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 1096)
  │ │ │             │ │         💬 Args: [value]
  │ │ │             │ │         👁️  Def: internal
  │ │ │             │ ├─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1097)
  │ │ │             │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │ │ │             │ │   👁️  Def: internal
  │ │ │             │ └─ [11] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 1098)
  │ │ │             │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │ │ │             │     👁️  Def: internal
  │ │ │             ├─ [10] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 1099)
  │ │ │             │   💬 Args: [finalJson, fileName]
  │ │ │             │   👁️  Def: internal
  │ │ │             └─ [10] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 1100)
  │ │ │                 💬 Args: [""]
  │ │ │                 👁️  Def: internal
  │ │ │               └─ [11] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 1101)
  │ │ │                   💬 Args: [slot, id]
  │ │ │                   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._setupSuperLedger() (NodeID: 1103)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,address) (NodeID: 1104)
  │ │ │ │   💬 Args: ["------ base test MANAGER", MANAGER]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1105)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1106)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,address) (NodeID: 1107)
  │ │ │ │   💬 Args: ["------ A", MANAGER]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1108)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1109)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1110)
  │ │ │ │   💬 Args: [chainIds[i], ERC4626_YIELD_SOURCE_ORACLE_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1111)
  │ │ │ │   💬 Args: [chainIds[i], SUPER_LEDGER_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1112)
  │ │ │ │   💬 Args: [chainIds[i], ERC7540_YIELD_SOURCE_ORACLE_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1113)
  │ │ │ │   💬 Args: [chainIds[i], SUPER_LEDGER_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1114)
  │ │ │ │   💬 Args: [chainIds[i], ERC5115_YIELD_SOURCE_ORACLE_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1115)
  │ │ │ │   💬 Args: [chainIds[i], ERC1155_LEDGER_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1116)
  │ │ │ │   💬 Args: [chainIds[i], STAKING_YIELD_SOURCE_ORACLE_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1117)
  │ │ │ │   💬 Args: [chainIds[i], SUPER_LEDGER_KEY]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1118)
  │ │ │     💬 Args: [chainIds[i], SUPER_LEDGER_CONFIGURATION_KEY]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest._fundUnderlyingTokens(uint256) (NodeID: 1119)
  │ │     💬 Args: [1e18]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 1120)
  │ │       💬 Args: [token, accountInstances[chainIds[i]].account, amount * (10 ** IERC20Metadata(token).decimals())]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 1121)
  │ │         💬 Args: [token, to, give, false]
  │ │         👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 1122)
  │ │       │   💬 Args: [stdstore, token]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 1123)
  │ │       │     💬 Args: [self, _target]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 1124)
  │ │       │   💬 Args: [stdstore.target(token), 0x70a08231]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 1125)
  │ │       │     💬 Args: [self, _sig]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 1126)
  │ │       │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 1127)
  │ │       │     💬 Args: [self, who]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 1128)
  │ │       │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 1129)
  │ │       │     💬 Args: [self, bytes32(amt)]
  │ │       │     👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1130)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1131)
  │ │       │   │     💬 Args: [self._keys]
  │ │       │   │     👁️  Def: private
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 1132)
  │ │       │   │   💬 Args: [self, false]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 1133)
  │ │       │   │     💬 Args: [self, _clear]
  │ │       │   │     👁️  Def: internal
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1134)
  │ │       │   │   │   💬 Args: [self]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1135)
  │ │       │   │   │     💬 Args: [self._keys]
  │ │       │   │   │     👁️  Def: private
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 1136)
  │ │       │   │   │   💬 Args: [self]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1137)
  │ │       │   │   │   💬 Args: [self]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1138)
  │ │       │   │   │ │   💬 Args: [self]
  │ │       │   │   │ │   👁️  Def: internal
  │ │       │   │   │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1139)
  │ │       │   │   │ │     💬 Args: [self._keys]
  │ │       │   │   │ │     👁️  Def: private
  │ │       │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1140)
  │ │       │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │   │     👁️  Def: private
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 1141)
  │ │       │   │   │   💬 Args: [self, reads[i]]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1142)
  │ │       │   │   │ │   💬 Args: [self]
  │ │       │   │   │ │   👁️  Def: internal
  │ │       │   │   │ │ ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1143)
  │ │       │   │   │ │ │   💬 Args: [self]
  │ │       │   │   │ │ │   👁️  Def: internal
  │ │       │   │   │ │ │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1144)
  │ │       │   │   │ │ │     💬 Args: [self._keys]
  │ │       │   │   │ │ │     👁️  Def: private
  │ │       │   │   │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1145)
  │ │       │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │   │ │     👁️  Def: private
  │ │       │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1146)
  │ │       │   │   │     💬 Args: [self]
  │ │       │   │   │     👁️  Def: internal
  │ │       │   │   │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1147)
  │ │       │   │   │   │   💬 Args: [self]
  │ │       │   │   │   │   👁️  Def: internal
  │ │       │   │   │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1148)
  │ │       │   │   │   │     💬 Args: [self._keys]
  │ │       │   │   │   │     👁️  Def: private
  │ │       │   │   │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1149)
  │ │       │   │   │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │   │       👁️  Def: private
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 1150)
  │ │       │   │   │   💬 Args: [self, reads[i]]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 1151)
  │ │       │   │   │ │   💬 Args: [self, slot, true]
  │ │       │   │   │ │   👁️  Def: internal
  │ │       │   │   │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1152)
  │ │       │   │   │ │     💬 Args: [self]
  │ │       │   │   │ │     👁️  Def: internal
  │ │       │   │   │ │   ├─ [13] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1153)
  │ │       │   │   │ │   │   💬 Args: [self]
  │ │       │   │   │ │   │   👁️  Def: internal
  │ │       │   │   │ │   │ └─ [14] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1154)
  │ │       │   │   │ │   │     💬 Args: [self._keys]
  │ │       │   │   │ │   │     👁️  Def: private
  │ │       │   │   │ │   └─ [13] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1155)
  │ │       │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │       │   │   │ │       👁️  Def: private
  │ │       │   │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 1156)
  │ │       │   │   │     💬 Args: [self, slot, false]
  │ │       │   │   │     👁️  Def: internal
  │ │       │   │   │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1157)
  │ │       │   │   │       💬 Args: [self]
  │ │       │   │   │       👁️  Def: internal
  │ │       │   │   │     ├─ [13] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1158)
  │ │       │   │   │     │   💬 Args: [self]
  │ │       │   │   │     │   👁️  Def: internal
  │ │       │   │   │     │ └─ [14] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1159)
  │ │       │   │   │     │     💬 Args: [self._keys]
  │ │       │   │   │     │     👁️  Def: private
  │ │       │   │   │     └─ [13] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1160)
  │ │       │   │   │         💬 Args: [rdat, 32 * self._depth]
  │ │       │   │   │         👁️  Def: private
  │ │       │   │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 1161)
  │ │       │   │   │   💬 Args: [offsetLeft, offsetRight]
  │ │       │   │   │   👁️  Def: internal
  │ │       │   │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 1162)
  │ │       │   │       💬 Args: [self]
  │ │       │   │       👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 1163)
  │ │       │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 1164)
  │ │       │   │     💬 Args: [offsetLeft, offsetRight]
  │ │       │   │     👁️  Def: internal
  │ │       │   ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1165)
  │ │       │   │   💬 Args: [self]
  │ │       │   │   👁️  Def: internal
  │ │       │   │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1166)
  │ │       │   │ │   💬 Args: [self]
  │ │       │   │ │   👁️  Def: internal
  │ │       │   │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1167)
  │ │       │   │ │     💬 Args: [self._keys]
  │ │       │   │ │     👁️  Def: private
  │ │       │   │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1168)
  │ │       │   │     💬 Args: [rdat, 32 * self._depth]
  │ │       │   │     👁️  Def: private
  │ │       │   └─ [8] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 1169)
  │ │       │       💬 Args: [self]
  │ │       │       👁️  Def: internal
  │ │       │     └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 1170)
  │ │       │         💬 Args: [self]
  │ │       │         👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 1171)
  │ │       │   💬 Args: [stdstore, token]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 1172)
  │ │       │     💬 Args: [self, _target]
  │ │       │     👁️  Def: internal
  │ │       ├─ [6] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 1173)
  │ │       │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │ │       │   👁️  Def: internal
  │ │       │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 1174)
  │ │       │     💬 Args: [self, _sig]
  │ │       │     👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 1175)
  │ │           💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 1176)
  │ │             💬 Args: [self, bytes32(amt)]
  │ │             👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1177)
  │ │           │   💬 Args: [self]
  │ │           │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1178)
  │ │           │     💬 Args: [self._keys]
  │ │           │     👁️  Def: private
  │ │           ├─ [8] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 1179)
  │ │           │   💬 Args: [self, false]
  │ │           │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 1180)
  │ │           │     💬 Args: [self, _clear]
  │ │           │     👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1181)
  │ │           │   │   💬 Args: [self]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1182)
  │ │           │   │     💬 Args: [self._keys]
  │ │           │   │     👁️  Def: private
  │ │           │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 1183)
  │ │           │   │   💬 Args: [self]
  │ │           │   │   👁️  Def: internal
  │ │           │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1184)
  │ │           │   │   💬 Args: [self]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1185)
  │ │           │   │ │   💬 Args: [self]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1186)
  │ │           │   │ │     💬 Args: [self._keys]
  │ │           │   │ │     👁️  Def: private
  │ │           │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1187)
  │ │           │   │     💬 Args: [rdat, 32 * self._depth]
  │ │           │   │     👁️  Def: private
  │ │           │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 1188)
  │ │           │   │   💬 Args: [self, reads[i]]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1189)
  │ │           │   │ │   💬 Args: [self]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1190)
  │ │           │   │ │ │   💬 Args: [self]
  │ │           │   │ │ │   👁️  Def: internal
  │ │           │   │ │ │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1191)
  │ │           │   │ │ │     💬 Args: [self._keys]
  │ │           │   │ │ │     👁️  Def: private
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1192)
  │ │           │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │           │   │ │     👁️  Def: private
  │ │           │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1193)
  │ │           │   │     💬 Args: [self]
  │ │           │   │     👁️  Def: internal
  │ │           │   │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1194)
  │ │           │   │   │   💬 Args: [self]
  │ │           │   │   │   👁️  Def: internal
  │ │           │   │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1195)
  │ │           │   │   │     💬 Args: [self._keys]
  │ │           │   │   │     👁️  Def: private
  │ │           │   │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1196)
  │ │           │   │       💬 Args: [rdat, 32 * self._depth]
  │ │           │   │       👁️  Def: private
  │ │           │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 1197)
  │ │           │   │   💬 Args: [self, reads[i]]
  │ │           │   │   👁️  Def: internal
  │ │           │   │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 1198)
  │ │           │   │ │   💬 Args: [self, slot, true]
  │ │           │   │ │   👁️  Def: internal
  │ │           │   │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1199)
  │ │           │   │ │     💬 Args: [self]
  │ │           │   │ │     👁️  Def: internal
  │ │           │   │ │   ├─ [13] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1200)
  │ │           │   │ │   │   💬 Args: [self]
  │ │           │   │ │   │   👁️  Def: internal
  │ │           │   │ │   │ └─ [14] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1201)
  │ │           │   │ │   │     💬 Args: [self._keys]
  │ │           │   │ │   │     👁️  Def: private
  │ │           │   │ │   └─ [13] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1202)
  │ │           │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │           │   │ │       👁️  Def: private
  │ │           │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 1203)
  │ │           │   │     💬 Args: [self, slot, false]
  │ │           │   │     👁️  Def: internal
  │ │           │   │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1204)
  │ │           │   │       💬 Args: [self]
  │ │           │   │       👁️  Def: internal
  │ │           │   │     ├─ [13] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1205)
  │ │           │   │     │   💬 Args: [self]
  │ │           │   │     │   👁️  Def: internal
  │ │           │   │     │ └─ [14] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1206)
  │ │           │   │     │     💬 Args: [self._keys]
  │ │           │   │     │     👁️  Def: private
  │ │           │   │     └─ [13] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1207)
  │ │           │   │         💬 Args: [rdat, 32 * self._depth]
  │ │           │   │         👁️  Def: private
  │ │           │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 1208)
  │ │           │   │   💬 Args: [offsetLeft, offsetRight]
  │ │           │   │   👁️  Def: internal
  │ │           │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 1209)
  │ │           │       💬 Args: [self]
  │ │           │       👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 1210)
  │ │           │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │           │   👁️  Def: internal
  │ │           │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 1211)
  │ │           │     💬 Args: [offsetLeft, offsetRight]
  │ │           │     👁️  Def: internal
  │ │           ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 1212)
  │ │           │   💬 Args: [self]
  │ │           │   👁️  Def: internal
  │ │           │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 1213)
  │ │           │ │   💬 Args: [self]
  │ │           │ │   👁️  Def: internal
  │ │           │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 1214)
  │ │           │ │     💬 Args: [self._keys]
  │ │           │ │     👁️  Def: private
  │ │           │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 1215)
  │ │           │     💬 Args: [rdat, 32 * self._depth]
  │ │           │     👁️  Def: private
  │ │           └─ [8] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 1216)
  │ │               💬 Args: [self]
  │ │               👁️  Def: internal
  │ │             └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 1217)
  │ │                 💬 Args: [self]
  │ │                 👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: PeripheryHelpers.deployPeripheryAccounts() (NodeID: 1218)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1219)
  │ │ │   💬 Args: [MANAGER_KEY, "SV_MANAGER"]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1220)
  │ │ │   💬 Args: [EMERGENCY_ADMIN_KEY, "EMERGENCY_ADMIN"]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1221)
  │ │     💬 Args: [VALIDATOR_KEY, "VALIDATOR"]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._deployPeripheryContracts(struct PeripheryAddresses[]) (NodeID: 1222)
  │ │   💬 Args: [PA]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest._predictTestVaultAddresses() (NodeID: 1223)
  │ │     💬 Args: [no args]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1224)
  │ │   │   💬 Args: [deployer, assetAddress, "New Vault", "NV", TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1225)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictRuggableVaultAddress(address,address,string,string,bool,bool,uint256,string) (NodeID: 1226)
  │ │   │   💬 Args: [deployer, assetAddress, "Ruggable Vault", "RUG", true, true, 10, TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1227)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1228)
  │ │   │   💬 Args: [deployer, assetAddress, "Mock4626Vault 3%", "MV3", TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1229)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1230)
  │ │   │   💬 Args: [deployer, assetAddress, "Mock4626Vault 5%", "MV5", TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1231)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1232)
  │ │   │   💬 Args: [deployer, assetAddress, "Mock4626Vault 10%", "MV10", TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1233)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1234)
  │ │   │   💬 Args: [deployer, assetAddress, "Mock Vault 3%", "MV3", TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1235)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1236)
  │ │   │   💬 Args: [deployer, assetAddress, "Mock Vault 5%", "MV5", TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1237)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1238)
  │ │   │   💬 Args: [deployer, assetAddress, "Mock Vault 10%", "MV10", TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1239)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictRuggableVaultAddress(address,address,string,string,bool,bool,uint256,string) (NodeID: 1240)
  │ │   │   💬 Args: [deployer, assetAddress, "Ruggable Vault", "RUG", true, false, 5000, TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1241)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictRuggableVaultAddress(address,address,string,string,bool,bool,uint256,string) (NodeID: 1242)
  │ │   │   💬 Args: [deployer, assetAddress, "Ruggable Vault", "RUG", false, true, 5000, TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1243)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictRuggableConvertVaultAddress(address,address,string,string,uint256,bool,string) (NodeID: 1244)
  │ │   │   💬 Args: [deployer, assetAddress, "Ruggable Convert Vault", "RUGC", 5000, true, TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1245)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1246)
  │ │   │   💬 Args: [deployer, assetAddress, "New Vault", "NV", TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1247)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1248)
  │ │   │   💬 Args: [deployer, assetAddress, "SuperVault 5115 ReAllocateFrom4626To5115 Vault1", "SV5115R1", TEST_SALT]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1249)
  │ │   │     💬 Args: [saltHash, bytecodeHash, deployer]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 1250)
  │ │       💬 Args: [deployer, assetAddress, "SuperVault 5115 ReAllocateFrom4626To5115 Vault2", "SV5115R2", TEST_SALT]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 1251)
  │ │         💬 Args: [saltHash, bytecodeHash, deployer]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._updateTreasuryInSuperLedgerConfiguration() (NodeID: 1252)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1253)
  │ │ │   💬 Args: [chainIds[i], SUPER_LEDGER_CONFIGURATION_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1254)
  │ │ │   💬 Args: [chainIds[i], SUPER_LEDGER_CONFIGURATION_KEY]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1255)
  │ │     💬 Args: [chainIds[i], SUPER_LEDGER_CONFIGURATION_KEY]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._configurePeripheryGovernor(struct PeripheryAddresses[]) (NodeID: 1256)
  │ │   💬 Args: [PA]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseTest._registerPeripheryHooks(struct PeripheryAddresses[]) (NodeID: 1257)
  │     💬 Args: [PA]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string) (NodeID: 1258)
  │   │   💬 Args: ["---------------- REGISTERING PERIPHERY HOOKS ----------------"]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1259)
  │   │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1260)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1261)
  │       💬 Args: ["Registering periphery hooks for chain", chainIds[i]]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1262)
  │         💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1263)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1264)
  │   💬 Args: ["--- SETUP BASE SUPERVAULT ---"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1265)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1266)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1267)
  │   💬 Args: [accInstances.length, ACCOUNT_COUNT]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1268)
  │   💬 Args: [ETH, SUPER_GOVERNOR_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1269)
  │   💬 Args: [ETH, SUPER_VAULT_AGGREGATOR_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1270)
  │   💬 Args: [ETH, SUPER_ORACLE_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._deployVault(string) (NodeID: 1271)
  │   💬 Args: ["SV_USDC"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._deployVault(address,string) (NodeID: 1272)
  │     💬 Args: [address(asset), _superVaultSymbol]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 1273)
  │   💬 Args: [strategyAddr, globalSVStrategy, "SV STRATEGY NOT EQUAL TO PREDICTED"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MerkleReader._getMerkleRoot() (NodeID: 1274)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.logBytes32(bytes32) (NodeID: 1275)
  │     💬 Args: [root]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1276)
  │       💬 Args: [abi.encodeWithSignature("log(bytes32)", p0)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1277)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 1278)
  │   💬 Args: ["[DEBUG] Proposing global hooks root from explicitly generated tree"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 1279)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 1280)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1281)
  │   💬 Args: [ETH, SUPER_EXECUTOR_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1282)
  │   💬 Args: [ETH, SUPER_LEDGER_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1283)
  │   💬 Args: [ETH, ERC7540_YIELD_SOURCE_ORACLE_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1284)
  │   💬 Args: [ETH, ECDSAPPS_ORACLE_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._setFeeConfig(uint256,address) (NodeID: 1285)
  │   💬 Args: [100, TREASURY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1286)
  │   💬 Args: [ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1287)
  │   💬 Args: [ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 1288)
      💬 Args: [ETH, ERC5115_YIELD_SOURCE_ORACLE_KEY]
      👁️  Def: internal
```
