# Function: setUp()

**Contract**: [test/unit/SuperGovernor.t.sol/contract_SuperGovernorTest.md]

## Metadata

- **Contract**: SuperGovernorTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2733:3726:659

## Implementation

```solidity
/// @notice Sets up the test environment before each test case.
function setUp() public {
    sGovernor = _deployAccount(0x1, "SuperGovernor");
    governor = _deployAccount(0x2, "Governor");
    guardian = _deployAccount(0x10, "Guardian");
    treasury = _deployAccount(0x3, "Treasury");
    oracleManager = _deployAccount(0x4, "OracleManager");
    user = _deployAccount(0x5, "User");
    hook1 = _deployAccount(0x6, "Hook1");
    hook2 = _deployAccount(0x7, "Hook2");
    fulfillHook1 = _deployAccount(0x8, "FulfillHook1");
    fulfillHook2 = _deployAccount(0x9, "FulfillHook2");
    validator1 = _deployAccount(0xA, "Validator1");
    validator2 = _deployAccount(0xB, "Validator2");
    ppsOracle1 = _deployAccount(0xC, "PPSOracle1");
    ppsOracle2 = _deployAccount(0xD, "PPSOracle2");
    newManager = _deployAccount(0xE, "NewManager");
    manager = _deployAccount(0xF, "Manager");
    upToken = new MockUp(address(this));
    superBank = _deployAccount(0x12, "SuperBank");
    asset = new MockERC20("Asset", "ASSET", 18);
    superGovernor = SuperGovernor(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(sGovernor, governor, governor, oracleManager, governor, guardian, treasury, false))})));
    address vaultImpl = address(SuperVault(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
    superVaultAggregator = address(SuperVaultAggregator(payable(VmContractHelper692(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(superGovernor), vaultImpl, strategyImpl, escrowImpl))}))));
    aggregator = SuperVaultAggregator(superVaultAggregator);
    (, address strategy, ) = ISuperVaultAggregator(superVaultAggregator).createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), mainManager: address(this), secondaryManagers: new address[](0), name: "SUP", symbol: "SUP", minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: address(this)})}));
    strategy1 = strategy;
    vm.startPrank(sGovernor);
    superGovernor.setAddress(SUPER_VAULT_AGGREGATOR, address(aggregator));
    superGovernor.setAddress(superGovernor.SUPER_BANK(), superBank);
    superGovernor.setAddress(superGovernor.UP(), address(upToken));
    superGovernor.setAddress(superGovernor.UPKEEP_TOKEN(), address(upToken));
    vm.stopPrank();
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
- **VmContractHelper692::deployCode(string)**
- **ISuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **Vm::startPrank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::SUPER_BANK()**
- **SuperGovernor::UP()**
- **SuperGovernor::UPKEEP_TOKEN()**
- **Vm::stopPrank()**

## State Variable Reads

- **sGovernor** (`address`)
- **governor** (`address`)
- **oracleManager** (`address`)
- **guardian** (`address`)
- **treasury** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **SUPER_VAULT_AGGREGATOR** (`bytes32`)
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **superBank** (`address`)
- **upToken** (`contract MockUp`) [test/mocks/MockUp.sol/contract_MockUp.md]

## State Variable Writes

- **sGovernor** (`address`)
- **governor** (`address`)
- **guardian** (`address`)
- **treasury** (`address`)
- **oracleManager** (`address`)
- **user** (`address`)
- **hook1** (`address`)
- **hook2** (`address`)
- **fulfillHook1** (`address`)
- **fulfillHook2** (`address`)
- **validator1** (`address`)
- **validator2** (`address`)
- **ppsOracle1** (`address`)
- **ppsOracle2** (`address`)
- **newManager** (`address`)
- **manager** (`address`)
- **upToken** (`contract MockUp`) [test/mocks/MockUp.sol/contract_MockUp.md]
- **superBank** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`address`)
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **strategy1** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperGovernorTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 1)
  │   💬 Args: [0x1, "SuperGovernor"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 2)
  │   💬 Args: [0x2, "Governor"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 3)
  │   💬 Args: [0x10, "Guardian"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 4)
  │   💬 Args: [0x3, "Treasury"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 5)
  │   💬 Args: [0x4, "OracleManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 6)
  │   💬 Args: [0x5, "User"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 7)
  │   💬 Args: [0x6, "Hook1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 8)
  │   💬 Args: [0x7, "Hook2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 9)
  │   💬 Args: [0x8, "FulfillHook1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 10)
  │   💬 Args: [0x9, "FulfillHook2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 11)
  │   💬 Args: [0xA, "Validator1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 12)
  │   💬 Args: [0xB, "Validator2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 13)
  │   💬 Args: [0xC, "PPSOracle1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 14)
  │   💬 Args: [0xD, "PPSOracle2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 15)
  │   💬 Args: [0xE, "NewManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 16)
  │   💬 Args: [0xF, "Manager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 17)
      💬 Args: [0x12, "SuperBank"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Sets up the test environment before each test case.
