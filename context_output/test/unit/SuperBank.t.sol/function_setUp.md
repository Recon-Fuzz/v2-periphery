# Function: setUp()

**Contract**: [test/unit/SuperBank.t.sol/contract_SuperBankTest.md]

## Metadata

- **Contract**: SuperBankTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2965:2154:658

## Implementation

```solidity
function setUp() public {
    sGovernor = _deployAccount(0x1, "SuperGovernor");
    governor = _deployAccount(0x2, "Governor");
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
    admin = _deployAccount(0xE, "Admin");
    superGovernor = SuperGovernor(payable(VmContractHelper689(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(sGovernor, governor, governor, oracleManager, governor, governor, treasury, false))})));
    superBank = SuperBank(payable(VmContractHelper689(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperBank.sol:SuperBank", _args: encodeArgs442(DeployHelper442.FoundryPpConstructorArgs(address(superGovernor)))})));
    up = Up(payable(VmContractHelper689(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/UP/Up.sol:Up", _args: encodeArgs536(DeployHelper536.FoundryPpConstructorArgs(admin))})));
    underlying = CHAIN_1_USDC;
    odosRouter = new MockOdosRouterV2();
    vm.label(address(odosRouter), "OdosRouter");
    token = new MockERC20("Test Token", "TEST", 18);
    vm.label(address(token), "Test Token");
    vault = new Mock4626Vault(address(token), "Test Vault", "TSTV");
    vm.label(address(vault), "4626 vault");
    acrossV3Helper = new AcrossV3Helper();
    vm.label(address(acrossV3Helper), "Pigeon AcrossV3Helper");
    vm.allowCheatcodes(address(acrossV3Helper));
    vm.makePersistent(address(acrossV3Helper));
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

- **VmContractHelper689::deployCode(string,bytes)**
- **Vm::label(address,string)**
- **Vm::allowCheatcodes(address)**
- **Vm::makePersistent(address)**

## State Variable Reads

- **sGovernor** (`address`)
- **governor** (`address`)
- **oracleManager** (`address`)
- **treasury** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **admin** (`address`)
- **odosRouter** (`contract MockOdosRouterV2`) [lib/v2-core/test/mocks/MockOdosRouterV2.sol/contract_MockOdosRouterV2.md]
- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vault** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **acrossV3Helper** (`contract AcrossV3Helper`) [lib/v2-core/lib/pigeon/src/across/AcrossV3Helper.sol/contract_AcrossV3Helper.md]

## State Variable Writes

- **sGovernor** (`address`)
- **governor** (`address`)
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
- **admin** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superBank** (`contract SuperBank`) [src/SuperBank.sol/contract_SuperBank.md]
- **up** (`contract Up`) [src/UP/Up.sol/contract_Up.md]
- **underlying** (`address`)
- **odosRouter** (`contract MockOdosRouterV2`) [lib/v2-core/test/mocks/MockOdosRouterV2.sol/contract_MockOdosRouterV2.md]
- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vault** (`contract Mock4626Vault`) [test/mocks/Mock4626Vault.sol/contract_Mock4626Vault.md]
- **acrossV3Helper** (`contract AcrossV3Helper`) [lib/v2-core/lib/pigeon/src/across/AcrossV3Helper.sol/contract_AcrossV3Helper.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperBankTest.setUp() (NodeID: 0)
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
  │   💬 Args: [0x6, "Hook1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 7)
  │   💬 Args: [0x7, "Hook2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 8)
  │   💬 Args: [0x8, "FulfillHook1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 9)
  │   💬 Args: [0x9, "FulfillHook2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 10)
  │   💬 Args: [0xA, "Validator1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 11)
  │   💬 Args: [0xB, "Validator2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 12)
  │   💬 Args: [0xC, "PPSOracle1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 13)
  │   💬 Args: [0xD, "PPSOracle2"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 14)
      💬 Args: [0xE, "Admin"]
      👁️  Def: internal
```
