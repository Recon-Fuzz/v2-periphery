# Function: setUp()

**Contract**: [test/unit/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2131:3461:660

## Implementation

```solidity
/// @notice Sets up the test environment before each test case
function setUp() public {
    sGovernor = _deployAccount(0x1, "SuperGovernor");
    governor = _deployAccount(0x2, "Governor");
    treasury = _deployAccount(0x3, "Treasury");
    user = _deployAccount(0x4, "User");
    manager = _deployAccount(0x5, "Manager");
    superOracle = address(new MockSuperOracle(1e18));
    asset = new MockERC20("Asset", "ASSET", 18);
    superGovernor = SuperGovernor(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(sGovernor, governor, governor, governor, governor, governor, treasury, false))})));
    address vaultImpl = address(SuperVault(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVault.sol:SuperVault", _args: encodeArgs470(DeployHelper470.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address strategyImpl = address(SuperVaultStrategy(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultStrategy.sol:SuperVaultStrategy", _args: encodeArgs472(DeployHelper472.FoundryPpConstructorArgs(address(superGovernor)))}))));
    address escrowImpl = address(SuperVaultEscrow(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultEscrow.sol:SuperVaultEscrow"}))));
    superVaultAggregator = SuperVaultAggregator(payable(VmContractHelper702(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator", _args: encodeArgs474(DeployHelper474.FoundryPpConstructorArgs(address(superGovernor), vaultImpl, strategyImpl, escrowImpl))})));
    upToken = address(new MockUp(address(this)));
    superBank = makeAddr("superBank");
    vm.startPrank(sGovernor);
    superGovernor.setAddress(superGovernor.UP(), upToken);
    superGovernor.setAddress(superGovernor.UPKEEP_TOKEN(), upToken);
    superGovernor.setAddress(superGovernor.SUPER_BANK(), superBank);
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

- **VmContractHelper702::deployCode(string,bytes)**
- **VmContractHelper702::deployCode(string)**
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
- **treasury** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **upToken** (`address`)
- **superBank** (`address`)
- **superOracle** (`address`)
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **manager** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **sGovernor** (`address`)
- **governor** (`address`)
- **treasury** (`address`)
- **user** (`address`)
- **manager** (`address`)
- **superOracle** (`address`)
- **asset** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superVaultAggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **upToken** (`address`)
- **superBank** (`address`)
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.setUp() (NodeID: 0)
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
  │   💬 Args: [0x4, "User"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 5)
  │   💬 Args: [0x5, "Manager"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 6)
      💬 Args: ["superBank"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 7)
        💬 Args: [name]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Sets up the test environment before each test case
