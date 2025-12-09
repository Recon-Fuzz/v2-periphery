# Function: setUp()

**Contract**: [test/unit/SuperVaultAggregator.t.sol/contract_SuperVaultAggregatorTest.md]

## Metadata

- **Contract**: SuperVaultAggregatorTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2531:4322:661

## Implementation

```solidity
/// @notice Sets up the test environment before each test case.
function setUp() public {
    sGovernor = _deployAccount(0x1, "SuperGovernor");
    governor = _deployAccount(0x2, "Governor");
    treasury = _deployAccount(0x3, "Treasury");
    oracleManager = _deployAccount(0x4, "OracleManager");
    user = _deployAccount(0x5, "User");
    manager = _deployAccount(0x6, "Manager");
    secondaryManager = _deployAccount(0x7, "SecondaryManager");
    protectedKeeper1 = _deployAccount(0x8, "ProtectedKeeper1");
    protectedKeeper2 = _deployAccount(0x9, "ProtectedKeeper2");
    normalKeeper1 = _deployAccount(0xA, "NormalKeeper1");
    normalKeeper2 = _deployAccount(0xB, "NormalKeeper2");
    superOracle = address(new MockSuperOracle(1e18));
    gasOracle = address(new MockAggregator(1e8, 8));
    asset = new MockERC20("Asset", "ASSET", 18);
    superGovernor = SuperGovernor(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(sGovernor, governor, governor, oracleManager, governor, governor, treasury, false))})));
    address vaultImpl = address(SuperVault(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
    superVaultAggregator = SuperVaultAggregator(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(superGovernor), vaultImpl, strategyImpl, escrowImpl))})));
    ecdsaPPSOracle = ECDSAPPSOracle(payable(VmContractHelper703(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/oracles/ECDSAPPSOracle.sol:ECDSAPPSOracle", _args: encodeArgs478(DeployHelper478.FoundryPpConstructorArgs(address(superGovernor), "ECDSAPPSOracle", "1"))})));
    vm.prank(manager);
    (, address strategyAddress, ) = superVaultAggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: address(asset), name: "Test Vault", symbol: "TV", mainManager: manager, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 300, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: manager})}));
    strategy = strategyAddress;
    vm.prank(manager);
    superVaultAggregator.addSecondaryManager(strategy, secondaryManager);
    upToken = address(new MockUp(address(this)));
    superBank = makeAddr("superBank");
    vm.startPrank(sGovernor);
    superGovernor.setAddress(superGovernor.UP(), upToken);
    superGovernor.setAddress(superGovernor.UPKEEP_TOKEN(), upToken);
    superGovernor.setAddress(superGovernor.SUPER_BANK(), superBank);
    superGovernor.setAddress(superGovernor.SUPER_ORACLE(), superOracle);
    superGovernor.setAddress(superGovernor.SUPER_VAULT_AGGREGATOR(), address(superVaultAggregator));
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

## External Calls

- **VmContractHelper703::deployCode(string,bytes)**
- **VmContractHelper703::deployCode(string)**
- **Vm::prank(address)**
- **SuperVaultAggregator::createVault(struct ISuperVaultAggregator.VaultCreationParams)**
- **SuperVaultAggregator::addSecondaryManager(address,address)**
- **Vm::startPrank(address)**
- **SuperGovernor::setAddress(bytes32,address)**
- **SuperGovernor::UP()**
- **SuperGovernor::UPKEEP_TOKEN()**
- **SuperGovernor::SUPER_BANK()**
- **SuperGovernor::SUPER_ORACLE()**
- **SuperGovernor::SUPER_VAULT_AGGREGATOR()**
- **Vm::stopPrank()**

## State Variable Reads

- **sGovernor** (`address`)
- **governor** (`address`)
- **oracleManager** (`address`)
- **treasury** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **manager** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **strategy** (`address`)
- **secondaryManager** (`address`)
- **upToken** (`address`)
- **superBank** (`address`)
- **superOracle** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **sGovernor** (`address`)
- **governor** (`address`)
- **treasury** (`address`)
- **oracleManager** (`address`)
- **user** (`address`)
- **manager** (`address`)
- **secondaryManager** (`address`)
- **protectedKeeper1** (`address`)
- **protectedKeeper2** (`address`)
- **normalKeeper1** (`address`)
- **normalKeeper2** (`address`)
- **superOracle** (`address`)
- **gasOracle** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **ecdsaPPSOracle** (`contract ECDSAPPSOracle`) [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]
- **strategy** (`address`)
- **upToken** (`address`)
- **superBank** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregatorTest.setUp() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 6)
  │   💬 Args: [0x6, "Manager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 7)
  │   💬 Args: [0x7, "SecondaryManager"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 8)
  │   💬 Args: [0x8, "ProtectedKeeper1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 9)
  │   💬 Args: [0x9, "ProtectedKeeper2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 10)
  │   💬 Args: [0xA, "NormalKeeper1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 11)
  │   💬 Args: [0xB, "NormalKeeper2"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 12)
      💬 Args: ["superBank"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 13)
        💬 Args: [name]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Sets up the test environment before each test case.
