# Function: setUp()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 3957:2624:570

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
    yieldSourceOracleId = bytes32(keccak256(abi.encodePacked("YieldSourceOracleId", address(this))));
    vm.chainId(CURRENT_CHAIN_ID);
    mockProver = new MockCrossL2ProverV2();
    superGovernor = SuperGovernor(payable(VmContractHelper545(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(sGovernor, governor, governor, oracleManager, governor, governor, treasury, false))})));
    superRegistry = new SuperRegistry(governor, governor, address(mockProver));
    vaultBank = new TestVaultBank(address(superGovernor), address(superRegistry));
    vm.startPrank(governor);
    superRegistry.addVaultBank(uint64(block.chainid), address(vaultBank));
    superRegistry.addVaultBank(uint64(DST_CHAIN_ID), address(vaultBank));
    vm.stopPrank();
    bytes32 bankManagerRole = superGovernor.BANK_MANAGER_ROLE();
    address testContractAddress = address(this);
    console.log("Test contract address:", testContractAddress);
    vm.startPrank(sGovernor);
    superGovernor.grantRole(bankManagerRole, testContractAddress);
    vm.stopPrank();
    console.log("Test contract address:", address(this));
    console.log("VaultBank address:", address(vaultBank));
    token = new MockERC20("Token", "TKN", 18);
    otherToken = new MockERC20("OtherToken", "OTH", 18);
    vaultBankSp = new VaultBankSuperPosition("VaultBankSuperPosition", "VBS", 18, yieldSourceOracleId);
    mockHook = new MockHook(ISuperHook.HookType.NONACCOUNTING, address(token));
    vm.prank(governor);
    superGovernor.registerHook(address(mockHook));
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

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
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

## External Calls

- **Vm::chainId(uint256)**
- **VmContractHelper545::deployCode(string,bytes)**
- **Vm::startPrank(address)**
- **SuperRegistry::addVaultBank(uint64,address)**
- **Vm::stopPrank()**
- **SuperGovernor::BANK_MANAGER_ROLE()**
- **SuperGovernor::grantRole(bytes32,address)**
- **Vm::prank(address)**
- **SuperGovernor::registerHook(address)**

## State Variable Reads

- **CURRENT_CHAIN_ID** (`uint64`)
- **sGovernor** (`address`)
- **governor** (`address`)
- **oracleManager** (`address`)
- **treasury** (`address`)
- **mockProver** (`contract MockCrossL2ProverV2`) [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **DST_CHAIN_ID** (`uint64`)
- **yieldSourceOracleId** (`bytes32`)
- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]

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
- **yieldSourceOracleId** (`bytes32`)
- **mockProver** (`contract MockCrossL2ProverV2`) [test/draft/test/mocks/MockCrossL2ProverV2.sol/contract_MockCrossL2ProverV2.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **otherToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vaultBankSp** (`contract VaultBankSuperPosition`) [test/draft/src/VaultBank/VaultBankSuperPosition.sol/contract_VaultBankSuperPosition.md]
- **mockHook** (`contract MockHook`) [test/mocks/MockHook.sol/contract_MockHook.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.setUp() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: Helpers._deployAccount(uint256,string) (NodeID: 14)
  │   💬 Args: [0xE, "Admin"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 15)
  │   💬 Args: ["Test contract address:", testContractAddress]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 16)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 17)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 18)
  │   💬 Args: ["Test contract address:", address(this)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 21)
      💬 Args: ["VaultBank address:", address(vaultBank)]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 22)
        💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 23)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```
