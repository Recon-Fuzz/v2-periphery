# Function: setUp()

**Contract**: [test/unit/MissingScenarios.t.sol/contract_MissingScenariosTest.md]

## Metadata

- **Contract**: MissingScenariosTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2610:4116:657

## Implementation

```solidity
/// @notice Sets up the test environment before each test case
function setUp() public {
    sGovernor = _deployAccount(0x1, "SuperGovernor");
    governor = _deployAccount(0x2, "Governor");
    treasury = _deployAccount(0x3, "Treasury");
    oracleManager = _deployAccount(0x4, "OracleManager");
    user = _deployAccount(0x5, "User");
    manager = _deployAccount(0x6, "Manager");
    superOracle = address(new MockSuperOracle(1e18));
    asset = new MockERC20("Asset", "ASSET", 18);
    superGovernor = SuperGovernor(payable(VmContractHelper684(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(sGovernor, governor, governor, oracleManager, governor, governor, treasury, false))})));
    address vaultImpl = address(SuperVault(payable(VmContractHelper684(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper684(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper684(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
    superVaultAggregator = SuperVaultAggregator(payable(VmContractHelper684(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(superGovernor), vaultImpl, strategyImpl, escrowImpl))})));
    ecdsaPPSOracle = ECDSAPPSOracle(payable(VmContractHelper684(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle", _args: encodeArgs478(DeployHelper478.FoundryPpConstructorArgs(address(superGovernor), "ECDSAPPSOracle", "1"))})));
    superBank = SuperBank(payable(VmContractHelper684(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperBank.sol:SuperBank", _args: encodeArgs442(DeployHelper442.FoundryPpConstructorArgs(address(superGovernor)))})));
    upToken = address(new MockUp(address(this)));
    vm.startPrank(sGovernor);
    superGovernor.setAddress(superGovernor.UP(), upToken);
    superGovernor.setAddress(superGovernor.UPKEEP_TOKEN(), upToken);
    superGovernor.setAddress(superGovernor.SUPER_BANK(), address(superBank));
    superGovernor.setAddress(superGovernor.SUPER_ORACLE(), superOracle);
    superGovernor.setAddress(superGovernor.SUPER_VAULT_AGGREGATOR(), address(superVaultAggregator));
    vm.stopPrank();
    vm.prank(manager);
    (address vaultAddress, address strategyAddress, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault", symbol: "TV", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    vault = SuperVault(vaultAddress);
    strategy = SuperVaultStrategy(payable(strategyAddress));
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

- **VmContractHelper684::deployCode(string,bytes)**
- **VmContractHelper684::deployCode(string)**
- **Vm::startPrank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::UP()**
- **SuperGovernor::UPKEEP_TOKEN()**
- **SuperGovernor::SUPER_BANK()**
- **SuperGovernor::SUPER_ORACLE()**
- **SuperGovernor::SUPER_VAULT_AGGREGATOR()**
- **Vm::stopPrank()**
- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**

## State Variable Reads

- **sGovernor** (`address`)
- **governor** (`address`)
- **oracleManager** (`address`)
- **treasury** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **upToken** (`address`)
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **superOracle** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]

## State Variable Writes

- **sGovernor** (`address`)
- **governor** (`address`)
- **treasury** (`address`)
- **oracleManager** (`address`)
- **user** (`address`)
- **manager** (`address`)
- **superOracle** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **ecdsaPPSOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **upToken** (`address`)
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MissingScenariosTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x1, "SuperGovernor"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x2, "Governor"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
  │   💬 Args: [0x3, "Treasury"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │   💬 Args: [0x4, "OracleManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 5)
  │   💬 Args: [0x5, "User"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 6)
      💬 Args: [0x6, "Manager"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Sets up the test environment before each test case
