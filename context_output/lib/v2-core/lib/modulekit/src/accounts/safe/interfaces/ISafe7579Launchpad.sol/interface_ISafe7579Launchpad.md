# Interface: ISafe7579Launchpad

## Metadata

- **Name**: ISafe7579Launchpad
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafe7579Launchpad.sol

## Implements Interfaces

- **IAccount** [lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/interfaces/IAccount.sol/interface_IAccount.md]

## Structs

### InitData

```solidity
///  @notice The keccak256 hash of the EIP-712 InitData struct, representing the structure
struct InitData {
    address singleton;
    address[] owners;
    uint256 threshold;
    address setupTo;
    bytes setupData;
    ISafe7579 safe7579;
    ModuleInit[] validators;
    bytes callData;
}
```

## Public/External Functions

### initSafe7579(address,struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],address[],uint8)

- **Signature**: `initSafe7579(address,struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],address[],uint8)`
- **Visibility**: external
- **Source Range**: 957:253:177

**Signature:**
```solidity
///  This function is intended to be delegatecalled by the ISafe.setup function. It configures the
///  Safe7579 for the user for all module types except validators, which were initialized in the
///  validateUserOp function.
function initSafe7579(address safe7579, ModuleInit[] calldata executors, ModuleInit[] calldata fallbacks, ModuleInit[] calldata hooks, address[] calldata attesters, uint8 threshold) external;;
```

### addSafe7579(address,struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],address[],uint8)

- **Signature**: `addSafe7579(address,struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],struct ModuleInit[],address[],uint8)`
- **Visibility**: external
- **Source Range**: 1328:294:177

**Signature:**
```solidity
///  This function allows existing safe accounts to add the Safe7579 adapter to their account
function addSafe7579(address safe7579, ModuleInit[] calldata validators, ModuleInit[] calldata executors, ModuleInit[] calldata fallbacks, ModuleInit[] calldata hooks, address[] calldata attesters, uint8 threshold) external;;
```

### preValidationSetup(bytes32,address,bytes)

- **Signature**: `preValidationSetup(bytes32,address,bytes)`
- **Visibility**: external
- **Source Range**: 2047:91:177

**Signature:**
```solidity
///  SafeProxyFactory will create a SafeProxy and using this contract as the singleton
///  implementation and call this function to initialize the account.
///  will write initHash into SafeProxy storage
///  @param initHash will be calculated offchain using this.hash(InitData)
///  @param to optional parameter for a delegatecall
///  @param preInit optional parameter for a delegatecall
function preValidationSetup(bytes32 initHash, address to, bytes calldata preInit) external;;
```

### validateUserOp(struct PackedUserOperation,bytes32,uint256)

- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 3550:198:177

**Signature:**
```solidity
///  Upon creation of SafeProxy by SafeProxyFactory, EntryPoint invokes this function to verify
///  the transaction. It ensures that only this.setupSafe() can be called by EntryPoint during
///  execution. The function validates the hash of InitData in userOp.callData against the hash
///  stored in preValidationSetup. This function abides by ERC4337 storage restrictions, allowing
///  Safe7579 adapter initialization only in Validation Modules compliant with 4337. It installs
///  validators from InitData onto the Safe7579 adapter for the account. When called by EP, the
///  SafeProxy singleton address remains unupgraded to SafeSingleton, preventing
///  execTransactionFromModule by Safe7579 Adapter. Initialization of Validator Modules is
///  achieved through a direct call to onInstall(). This delegatecalled function initializes the
///  Validator Module with the correct msg.sender. Once all validator modules are set up, they can
///  be used to validate the userOp. Parameters include userOp (EntryPoint v0.7 userOp),
///  userOpHash, and missingAccountFunds representing the gas payment required.
///  @param userOp EntryPoint v0.7 userOp.
///  @param userOpHash hash of userOp
///  @param missingAccountFunds amount of gas that has to be paid
///  @return validationData 4337 packed validation data returned by the validator module
function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash, uint256 missingAccountFunds) external returns (uint256 validationData);;
```

### setupSafe(struct ISafe7579Launchpad.InitData)

- **Signature**: `setupSafe(struct ISafe7579Launchpad.InitData)`
- **Visibility**: external
- **Source Range**: 4522:56:177

**Signature:**
```solidity
///  During the execution phase of ERC4337, this function upgrades the SafeProxy to the actual
///  SafeSingleton implementation. Subsequently, it invokes the ISafe.setup() function to
///  initialize the Safe Account. The setup() function should ensure the completion of Safe7579
///  Adapter initialization with InitData.setupTo as address(this) and InitData.setupData encoding
///  the call to this.initSafe7579(). SafeProxy.setup() delegatecalls this function to install
///  executors, fallbacks, hooks, and registry configurations on the Safe7579 adapter. As this
///  occurs in the ERC4337 execution phase, storage restrictions are not applicable.
///  @param initData initData to initialize the Safe and Safe7579 Adapter
function setupSafe(InitData calldata initData) external;;
```

### getInitHash()

- **Signature**: `getInitHash()`
- **Visibility**: external
- **Source Range**: 4584:55:177

**Signature:**
```solidity
function getInitHash() external view returns (bytes32);;
```

### predictSafeAddress(address,address,bytes,bytes32,bytes)

- **Signature**: `predictSafeAddress(address,address,bytes,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 4891:259:177

**Signature:**
```solidity
///  Helper function that can be used offchain to predict the counterfactual Safe address.
///  @dev factoryInitializer is expected to be:
///  abi.encodeCall(Safe7579Launchpad.preValidationSetup, (initHash, to, callData));
function predictSafeAddress(address singleton, address safeProxyFactory, bytes memory creationCode, bytes32 salt, bytes memory factoryInitializer) external pure returns (address safeProxy);;
```

### hash(struct ISafe7579Launchpad.InitData)

- **Signature**: `hash(struct ISafe7579Launchpad.InitData)`
- **Visibility**: external
- **Source Range**: 5263:68:177

**Signature:**
```solidity
///  Create unique InitData hash. Using all params but excluding data.callData from hash
function hash(InitData memory data) external pure returns (bytes32);;
```
