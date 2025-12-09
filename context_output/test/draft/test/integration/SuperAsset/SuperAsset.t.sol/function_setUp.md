# Function: setUp()

**Contract**: [test/draft/test/integration/SuperAsset/SuperAsset.t.sol/contract_SuperAssetTest.md]

## Metadata

- **Contract**: SuperAssetTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 4918:13624:565

## Implementation

```solidity
function setUp() public {
    admin = makeAddr("admin");
    manager = makeAddr("manager");
    user = makeAddr("user");
    user11 = makeAddr("user11");
    vm.startPrank(admin);
    superGovernor = SuperGovernor(payable(VmContractHelper529(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(admin, admin, admin, admin, admin, admin, makeAddr("treasury"), false))})));
    console.log("SuperGovernor deployed");
    deploySuperRegistry(admin, admin, makeAddr("prover"));
    console.log("SuperRegistry deployed");
    superGovernor.grantRole(superGovernor.SUPER_GOVERNOR_ROLE(), admin);
    superGovernor.grantRole(superGovernor.GOVERNOR_ROLE(), admin);
    superGovernor.grantRole(superGovernor.BANK_MANAGER_ROLE(), admin);
    console.log("SuperGovernor Roles Granted");
    address vaultImpl = address(SuperVault(payable(VmContractHelper529(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper529(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper529(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
    aggregator = SuperVaultAggregator(payable(VmContractHelper529(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(superGovernor), vaultImpl, strategyImpl, escrowImpl))})));
    superGovernor.setAddress(superGovernor.SUPER_VAULT_AGGREGATOR(), address(aggregator));
    MockERC20 primaryAsset = new MockERC20("Primary Asset", "PA", 18);
    underlyingToken1 = new MockERC20("Underlying Token1", "UTKN1", 18);
    tokenIn = new Mock4626Vault(address(underlyingToken1), "Vault Token", "vTKN");
    underlyingToken2 = new MockERC20("Underlying Token2", "UTKN2", 18);
    tokenOut = new Mock4626Vault(address(underlyingToken2), "Vault Token", "vTKN");
    underlyingToken6d = new MockERC20("Underlying Token 6d", "UTKN6D", 6);
    console.log("Mock tokens deployed");
    icc = new IncentiveCalculationContract();
    console.log("ICC deployed");
    mockFeedSuperAssetShares1 = new MockAggregator(1e8, 8);
    mockFeedSuperVault1Shares = new MockAggregator(1e8, 8);
    mockFeedSuperVault2Shares = new MockAggregator(1e8, 8);
    mockFeedPrimaryAsset = new MockAggregator(1e8, 8);
    mockFeed1 = new MockAggregator(1e8, 8);
    mockFeed2 = new MockAggregator(1e8, 8);
    mockFeed3 = new MockAggregator(1e8, 8);
    mockFeed4 = new MockAggregator(1e8, 8);
    mockFeed5 = new MockAggregator(1e8, 8);
    mockFeed6 = new MockAggregator(1e8, 8);
    mockFeed7 = new MockAggregator(1e8, 8);
    mockFeed8 = new MockAggregator(1e8, 8);
    mockFeed9 = new MockAggregator(1e8, 8);
    console.log("Mock feeds deployed");
    mockFeedSuperAssetShares1.setUpdatedAt(block.timestamp);
    mockFeedPrimaryAsset.setUpdatedAt(block.timestamp);
    mockFeed1.setUpdatedAt(block.timestamp);
    mockFeed2.setUpdatedAt(block.timestamp);
    mockFeed3.setUpdatedAt(block.timestamp);
    mockFeed4.setUpdatedAt(block.timestamp);
    mockFeed5.setUpdatedAt(block.timestamp);
    mockFeed6.setUpdatedAt(block.timestamp);
    mockFeed7.setUpdatedAt(block.timestamp);
    mockFeed8.setUpdatedAt(block.timestamp);
    mockFeed9.setUpdatedAt(block.timestamp);
    console.log("Feed timestamps updated");
    address[] memory bases = new address[](11);
    bases[0] = address(underlyingToken1);
    bases[1] = address(underlyingToken1);
    bases[2] = address(underlyingToken1);
    bases[3] = address(underlyingToken2);
    bases[4] = address(underlyingToken2);
    bases[5] = address(underlyingToken2);
    bases[6] = address(superAsset);
    bases[7] = address(primaryAsset);
    bases[8] = address(underlyingToken6d);
    bases[9] = address(underlyingToken6d);
    bases[10] = address(underlyingToken6d);
    address[] memory quotes = new address[](11);
    quotes[0] = USD;
    quotes[1] = USD;
    quotes[2] = USD;
    quotes[3] = USD;
    quotes[4] = USD;
    quotes[5] = USD;
    quotes[6] = USD;
    quotes[7] = USD;
    quotes[8] = USD;
    quotes[9] = USD;
    quotes[10] = USD;
    bytes32[] memory providers = new bytes32[](11);
    providers[0] = PROVIDER_1;
    providers[1] = PROVIDER_2;
    providers[2] = PROVIDER_3;
    providers[3] = PROVIDER_4;
    providers[4] = PROVIDER_5;
    providers[5] = PROVIDER_6;
    providers[6] = PROVIDER_SUPERASSET;
    providers[7] = PROVIDER_PRIMARY_ASSET;
    providers[8] = PROVIDER_1;
    providers[9] = PROVIDER_2;
    providers[10] = PROVIDER_3;
    address[] memory feeds = new address[](11);
    feeds[0] = address(mockFeed1);
    feeds[1] = address(mockFeed2);
    feeds[2] = address(mockFeed3);
    feeds[3] = address(mockFeed4);
    feeds[4] = address(mockFeed5);
    feeds[5] = address(mockFeed6);
    feeds[6] = address(mockFeedSuperAssetShares1);
    feeds[7] = address(mockFeedPrimaryAsset);
    feeds[8] = address(mockFeed7);
    feeds[9] = address(mockFeed8);
    feeds[10] = address(mockFeed9);
    factory = new SuperAssetFactory(address(superGovernor), address(superRegistry));
    console.log("Factory deployed");
    superRegistry.setAddress(superRegistry.SUPER_ASSET_FACTORY(), address(factory));
    superBank = SuperBank(payable(VmContractHelper529(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperBank.sol:SuperBank", _args: encodeArgs442(DeployHelper442.FoundryPpConstructorArgs(address(superGovernor)))})));
    superGovernor.setAddress(superGovernor.SUPER_BANK(), address(superBank));
    ISuperAssetFactory.AssetCreationParams memory params = ISuperAssetFactory.AssetCreationParams({name: "SuperAsset", symbol: "SA", swapFeeInPercentage: 100, swapFeeOutPercentage: 100, asset: address(primaryAsset), superAssetManager: admin, superAssetStrategist: admin, incentiveFundManager: admin, incentiveCalculationContract: address(icc), tokenInIncentive: address(tokenIn), tokenOutIncentive: address(tokenOut)});
    ledgerConfig = ISuperLedgerConfiguration(address(new SuperLedgerConfiguration()));
    yieldSourceOracle = new ERC4626YieldSourceOracle(address(ledgerConfig));
    superRegistry.addICCToWhitelist(address(icc));
    (address superAssetAddr, address incentiveFundAddr) = factory.createSuperAsset(params);
    vm.stopPrank();
    console.log("SuperAsset and IncentiveFund deployed via factory");
    superAsset = SuperAsset(superAssetAddr);
    incentiveFund = IncentiveFundContract(incentiveFundAddr);
    vm.prank(admin);
    incentiveFund.toggleIncentives(false);
    console.log("SuperAsset and IncentiveFund deployed via factory");
    bases[6] = address(superAsset);
    console.log("Trying to deploy SuperOracle");
    vm.startPrank(admin);
    oracle = SuperOracle(payable(VmContractHelper529(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/SuperOracle.sol:SuperOracle", _args: encodeArgs447(DeployHelper447.FoundryPpConstructorArgs(address(superGovernor), bases, quotes, providers, feeds))})));
    superGovernor.setAddress(superGovernor.SUPER_ORACLE(), address(oracle));
    superGovernor.setOracleMaxStaleness(2 weeks);
    console.log("Oracle deployed");
    superGovernor.setOracleFeedMaxStaleness(address(mockFeed1), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeed2), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeed3), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeed4), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeed5), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeed6), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeed7), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeed8), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeed9), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeedSuperAssetShares1), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeedSuperVault1Shares), 14 days);
    superGovernor.setOracleFeedMaxStaleness(address(mockFeedSuperVault2Shares), 14 days);
    vm.stopPrank();
    console.log("Feed staleness set");
    console.log("List of Token Addresses");
    console.log("tokenIn = ", address(tokenIn));
    console.log("tokenOut = ", address(tokenOut));
    console.log("underlyingToken1 = ", address(underlyingToken1));
    console.log("underlyingToken2 = ", address(underlyingToken2));
    console.log("superAsset = ", address(superAsset));
    console.log("primaryAsset = ", address(primaryAsset));
    console.log("---------------");
    vm.startPrank(admin);
    superAsset.whitelistVault(address(tokenIn), address(yieldSourceOracle));
    ISuperAsset.TokenData memory tokenData = superAsset.getTokenData(address(tokenIn));
    assertEq(tokenData.isSupportedUnderlyingVault, true, "Token In should be whitelisted");
    superAsset.whitelistERC20(address(underlyingToken1));
    tokenData = superAsset.getTokenData(address(underlyingToken1));
    assertEq(tokenData.isSupportedERC20, true, "Underlying Token 1 should be whitelisted");
    superAsset.whitelistVault(address(tokenOut), address(yieldSourceOracle));
    tokenData = superAsset.getTokenData(address(tokenOut));
    assertEq(tokenData.isSupportedUnderlyingVault, true, "Token Out should be whitelisted");
    superAsset.whitelistERC20(address(underlyingToken2));
    tokenData = superAsset.getTokenData(address(underlyingToken2));
    assertEq(tokenData.isSupportedERC20, true, "Underlying Token 2 should be whitelisted");
    superAsset.whitelistERC20(address(superAsset));
    vm.stopPrank();
    console.log("Start Minting");
    underlyingToken1.mint(user, 1000e18);
    underlyingToken2.mint(user, 1000e18);
    vm.startPrank(user);
    underlyingToken1.approve(address(tokenIn), 1000e18);
    tokenIn.deposit(1000e18, user);
    underlyingToken2.approve(address(tokenOut), 1000e18);
    tokenOut.deposit(1000e18, user);
    vm.stopPrank();
    assertGt(tokenIn.balanceOf(user), 0);
    assertGt(tokenOut.balanceOf(user), 0);
    underlyingToken1.mint(user11, 1000e18);
    underlyingToken2.mint(user11, 1000e18);
    vm.startPrank(user11);
    underlyingToken1.approve(address(tokenIn), 1000e18);
    tokenIn.deposit(1000e18, user11);
    underlyingToken2.approve(address(tokenOut), 1000e18);
    tokenOut.deposit(1000e18, user11);
    vm.stopPrank();
    assertGt(tokenIn.balanceOf(user11), 0);
    assertGt(tokenOut.balanceOf(user11), 0);
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

### deploySuperRegistry(address,address,address)

- **Kind**: internal
- **Source**: 754:202:572
- **Link**: `test/draft/test/utils/BaseTestSuperAsset.sol:BaseTestSuperAsset:deploySuperRegistry(address,address,address)`

```solidity
/// @notice Deploy SuperRegistry with the given admin addresses and prover
///  @param superRegistryAdmin_ The address for super registry admin role
///  @param registryAdmin_ The address for registry admin role
///  @param prover_ The prover address
function deploySuperRegistry(address superRegistryAdmin_, address registryAdmin_, address prover_) public {
    superRegistry = new SuperRegistry(superRegistryAdmin_, registryAdmin_, prover_);
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

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2487:171:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 14636:153:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right);
    }
}
```

## External Calls

- **Vm::startPrank(address)**
- **VmContractHelper529::deployCode(string,bytes)**
- **SuperGovernor::grantRole(bytes32,address)**
- **SuperGovernor::SUPER_GOVERNOR_ROLE()**
- **SuperGovernor::GOVERNOR_ROLE()**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **VmContractHelper529::deployCode(string)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::SUPER_VAULT_AGGREGATOR()**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperRegistry::setAddress(bytes32,address)**
- **SuperRegistry::SUPER_ASSET_FACTORY()**
- **SuperGovernor::SUPER_BANK()**
- **SuperRegistry::addICCToWhitelist(address)**
- **SuperAssetFactory::createSuperAsset(struct ISuperAssetFactory.AssetCreationParams)**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **IncentiveFundContract::toggleIncentives(bool)**
- **SuperGovernor::SUPER_ORACLE()**
- **SuperGovernor::setOracleMaxStaleness(uint256)**
- **SuperGovernor::setOracleFeedMaxStaleness(address,uint256)**
- **SuperAsset::whitelistVault(address,address)**
- **SuperAsset::getTokenData(address)**
- **SuperAsset::whitelistERC20(address)**
- **MockERC20::mint(address,uint256)**
- **MockERC20::approve(address,uint256)**
- **Mock4626Vault::deposit(uint256,address)**
- **Mock4626Vault::balanceOf(address)**

## State Variable Reads

- **admin** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **underlyingToken2** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockFeedSuperAssetShares1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeedPrimaryAsset** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed5** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed6** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed7** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed8** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed9** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **underlyingToken6d** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **USD** (`address`)
- **PROVIDER_1** (`bytes32`)
- **PROVIDER_2** (`bytes32`)
- **PROVIDER_3** (`bytes32`)
- **PROVIDER_4** (`bytes32`)
- **PROVIDER_5** (`bytes32`)
- **PROVIDER_6** (`bytes32`)
- **PROVIDER_SUPERASSET** (`bytes32`)
- **PROVIDER_PRIMARY_ASSET** (`bytes32`)
- **factory** (`contract SuperAssetFactory`) [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **icc** (`contract IncentiveCalculationContract`) [test/draft/src/SuperAsset/IncentiveCalculationContract.sol/contract_IncentiveCalculationContract.md]
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **tokenOut** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **ledgerConfig** (`contract ISuperLedgerConfiguration`) [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]
- **incentiveFund** (`contract IncentiveFundContract`) [test/draft/src/SuperAsset/IncentiveFundContract.sol/contract_IncentiveFundContract.md]
- **oracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeedSuperVault1Shares** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeedSuperVault2Shares** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **yieldSourceOracle** (`contract ERC4626YieldSourceOracle`) [lib/v2-core/src/accounting/oracles/ERC4626YieldSourceOracle.sol/contract_ERC4626YieldSourceOracle.md]
- **user** (`address`)
- **user11** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **admin** (`address`)
- **manager** (`address`)
- **user** (`address`)
- **user11** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **underlyingToken1** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **tokenIn** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **underlyingToken2** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **tokenOut** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **underlyingToken6d** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **icc** (`contract IncentiveCalculationContract`) [test/draft/src/SuperAsset/IncentiveCalculationContract.sol/contract_IncentiveCalculationContract.md]
- **mockFeedSuperAssetShares1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeedSuperVault1Shares** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeedSuperVault2Shares** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeedPrimaryAsset** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed1** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed2** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed4** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed5** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed6** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed7** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed8** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **mockFeed9** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **factory** (`contract SuperAssetFactory`) [test/draft/src/SuperAsset/SuperAssetFactory.sol/contract_SuperAssetFactory.md]
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **ledgerConfig** (`contract ISuperLedgerConfiguration`) [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]
- **yieldSourceOracle** (`contract ERC4626YieldSourceOracle`) [lib/v2-core/src/accounting/oracles/ERC4626YieldSourceOracle.sol/contract_ERC4626YieldSourceOracle.md]
- **superAsset** (`contract SuperAsset`) [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]
- **incentiveFund** (`contract IncentiveFundContract`) [test/draft/src/SuperAsset/IncentiveFundContract.sol/contract_IncentiveFundContract.md]
- **oracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAssetTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["admin"]
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
  │   💬 Args: ["user"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 6)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 7)
  │   💬 Args: ["user11"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 8)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 9)
  │   💬 Args: ["treasury"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 10)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 11)
  │   💬 Args: ["SuperGovernor deployed"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 12)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 13)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseTestSuperAsset.deploySuperRegistry(address,address,address) (NodeID: 14)
  │   💬 Args: [admin, admin, makeAddr("prover")]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 15)
  │     💬 Args: ["prover"]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 16)
  │       💬 Args: [name]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 17)
  │   💬 Args: ["SuperRegistry deployed"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 18)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 19)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 20)
  │   💬 Args: ["SuperGovernor Roles Granted"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 23)
  │   💬 Args: ["Mock tokens deployed"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 24)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 25)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 26)
  │   💬 Args: ["ICC deployed"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 27)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 28)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 29)
  │   💬 Args: ["Mock feeds deployed"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 30)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 31)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 32)
  │   💬 Args: ["Feed timestamps updated"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 33)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 34)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 35)
  │   💬 Args: ["Factory deployed"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 36)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 37)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 38)
  │   💬 Args: ["SuperAsset and IncentiveFund deployed via factory"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 39)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 40)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 41)
  │   💬 Args: ["SuperAsset and IncentiveFund deployed via factory"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 42)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 43)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 44)
  │   💬 Args: ["Trying to deploy SuperOracle"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 45)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 46)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 47)
  │   💬 Args: ["Oracle deployed"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 48)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 49)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 50)
  │   💬 Args: ["Feed staleness set"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 51)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 52)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 53)
  │   💬 Args: ["List of Token Addresses"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 54)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 55)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 56)
  │   💬 Args: ["tokenIn = ", address(tokenIn)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 57)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 58)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 59)
  │   💬 Args: ["tokenOut = ", address(tokenOut)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 60)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 61)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 62)
  │   💬 Args: ["underlyingToken1 = ", address(underlyingToken1)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 63)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 64)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 65)
  │   💬 Args: ["underlyingToken2 = ", address(underlyingToken2)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 66)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 67)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 68)
  │   💬 Args: ["superAsset = ", address(superAsset)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 69)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 70)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 71)
  │   💬 Args: ["primaryAsset = ", address(primaryAsset)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 72)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 73)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 74)
  │   💬 Args: ["---------------"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 75)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 76)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 77)
  │   💬 Args: [tokenData.isSupportedUnderlyingVault, true, "Token In should be whitelisted"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 78)
  │   💬 Args: [tokenData.isSupportedERC20, true, "Underlying Token 1 should be whitelisted"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 79)
  │   💬 Args: [tokenData.isSupportedUnderlyingVault, true, "Token Out should be whitelisted"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 80)
  │   💬 Args: [tokenData.isSupportedERC20, true, "Underlying Token 2 should be whitelisted"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 81)
  │   💬 Args: ["Start Minting"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 82)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 83)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 84)
  │   💬 Args: [tokenIn.balanceOf(user), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 85)
  │   💬 Args: [tokenOut.balanceOf(user), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 86)
  │   💬 Args: [tokenIn.balanceOf(user11), 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 87)
      💬 Args: [tokenOut.balanceOf(user11), 0]
      👁️  Def: internal
```
