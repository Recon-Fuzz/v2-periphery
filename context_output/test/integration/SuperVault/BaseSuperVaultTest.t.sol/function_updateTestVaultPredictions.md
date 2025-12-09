# Function: updateTestVaultPredictions()

**Contract**: [test/integration/SuperVault/BaseSuperVaultTest.t.sol/contract_BaseSuperVaultTest.md]

## Metadata

- **Contract**: BaseSuperVaultTest
- **Signature**: `updateTestVaultPredictions()`
- **Visibility**: public
- **Source Range**: 16989:90:545
- **Inherited From**: BaseTest

## Implementation

```solidity
/// @notice Updates test vault predictions with the correct deployer address
///  @dev Should be called from test contracts where address(this) gives the actual deployer
function updateTestVaultPredictions() public {
    _predictTestVaultAddresses();
}
```

## Related Implementations

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

## State Variable Reads

- **TEST_SALT** (`string`)

## State Variable Writes

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseTest.updateTestVaultPredictions() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BaseTest._predictTestVaultAddresses() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 2)
    │   💬 Args: [deployer, assetAddress, "New Vault", "NV", TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 3)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictRuggableVaultAddress(address,address,string,string,bool,bool,uint256,string) (NodeID: 4)
    │   💬 Args: [deployer, assetAddress, "Ruggable Vault", "RUG", true, true, 10, TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 5)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 6)
    │   💬 Args: [deployer, assetAddress, "Mock4626Vault 3%", "MV3", TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 7)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 8)
    │   💬 Args: [deployer, assetAddress, "Mock4626Vault 5%", "MV5", TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 9)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 10)
    │   💬 Args: [deployer, assetAddress, "Mock4626Vault 10%", "MV10", TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 11)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 12)
    │   💬 Args: [deployer, assetAddress, "Mock Vault 3%", "MV3", TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 13)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 14)
    │   💬 Args: [deployer, assetAddress, "Mock Vault 5%", "MV5", TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 15)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 16)
    │   💬 Args: [deployer, assetAddress, "Mock Vault 10%", "MV10", TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 17)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictRuggableVaultAddress(address,address,string,string,bool,bool,uint256,string) (NodeID: 18)
    │   💬 Args: [deployer, assetAddress, "Ruggable Vault", "RUG", true, false, 5000, TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 19)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictRuggableVaultAddress(address,address,string,string,bool,bool,uint256,string) (NodeID: 20)
    │   💬 Args: [deployer, assetAddress, "Ruggable Vault", "RUG", false, true, 5000, TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 21)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictRuggableConvertVaultAddress(address,address,string,string,uint256,bool,string) (NodeID: 22)
    │   💬 Args: [deployer, assetAddress, "Ruggable Convert Vault", "RUGC", 5000, true, TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 23)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 24)
    │   💬 Args: [deployer, assetAddress, "New Vault", "NV", TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 25)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 26)
    │   💬 Args: [deployer, assetAddress, "SuperVault 5115 ReAllocateFrom4626To5115 Vault1", "SV5115R1", TEST_SALT]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 27)
    │     💬 Args: [saltHash, bytecodeHash, deployer]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseTest._predictMock4626VaultAddress(address,address,string,string,string) (NodeID: 28)
        💬 Args: [deployer, assetAddress, "SuperVault 5115 ReAllocateFrom4626To5115 Vault2", "SV5115R2", TEST_SALT]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Create2.computeAddress(bytes32,bytes32,address) (NodeID: 29)
          💬 Args: [saltHash, bytecodeHash, deployer]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@notice Updates test vault predictions with the correct deployer address
 @dev Should be called from test contracts where address(this) gives the actual deployer
