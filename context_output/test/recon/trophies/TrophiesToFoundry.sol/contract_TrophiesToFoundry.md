# Contract: TrophiesToFoundry

## Metadata

- **Name**: TrophiesToFoundry
- **Type**: Contract
- **Path**: test/recon/trophies/TrophiesToFoundry.sol

## State Variables

### _actor (inherited from ActorManager)

```solidity
/// @notice The current actor being used
address private _actor
```

### _actors (inherited from ActorManager)

```solidity
/// @notice The list of all actors being used
EnumerableSet.AddressSet private _actors
```

### __asset (inherited from AssetManager)

```solidity
/// @notice The current target for this set of variables
address private __asset
```

### _assets (inherited from AssetManager)

```solidity
/// @notice The list of all assets being used
EnumerableSet.AddressSet private _assets
```

### __yieldSource (inherited from YieldManager)

```solidity
/// @notice The current target for this set of variables
address private __yieldSource
```

### __currentYieldSourceType (inherited from YieldManager)

```solidity
/// @notice The current yield source type
YieldSourceType private __currentYieldSourceType
```

### _yieldSources (inherited from YieldManager)

```solidity
/// @notice The list of all yield sources being used
EnumerableSet.AddressSet private _yieldSources
```

### VM_ADDRESS (inherited from CommonBase)

```solidity
/// @dev Cheat code address.
///  Calculated as `address(uint160(uint256(keccak256("hevm cheat code"))))`.
address internal constant VM_ADDRESS = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D
```

### CONSOLE (inherited from CommonBase)

```solidity
/// @dev console.sol and console2.sol work by executing a staticcall to this address.
///  Calculated as `address(uint160(uint88(bytes11("console.log"))))`.
address internal constant CONSOLE = 0x000000000000000000636F6e736F6c652e6c6f67
```

### CREATE2_FACTORY (inherited from CommonBase)

```solidity
/// @dev Used when deploying with create2.
///  Taken from https://github.com/Arachnid/deterministic-deployment-proxy.
address internal constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### DEFAULT_SENDER (inherited from CommonBase)

```solidity
/// @dev The default address for tx.origin and msg.sender.
///  Calculated as `address(uint160(uint256(keccak256("foundry default caller"))))`.
address internal constant DEFAULT_SENDER = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38
```

### DEFAULT_TEST_CONTRACT (inherited from CommonBase)

```solidity
/// @dev The address of the first contract `CREATE`d by a running test contract.
///  When running tests, each test contract is `CREATE`d by `DEFAULT_SENDER` with nonce 1.
///  Calculated as `VM.computeCreateAddress(VM.computeCreateAddress(DEFAULT_SENDER, 1), 1)`.
address internal constant DEFAULT_TEST_CONTRACT = 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
```

### MULTICALL3_ADDRESS (inherited from CommonBase)

```solidity
/// @dev Deterministic deployment address of the Multicall3 contract.
///  Taken from https://www.multicall3.com.
address internal constant MULTICALL3_ADDRESS = 0xcA11bde05977b3631167028862bE2a173976CA11
```

### SECP256K1_ORDER (inherited from CommonBase)

```solidity
/// @dev The order of the secp256k1 curve.
uint256 internal constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from CommonBase)

```solidity
uint256 internal constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### vm (inherited from CommonBase)

```solidity
Vm internal constant vm = Vm(VM_ADDRESS)
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### stdstore (inherited from CommonBase)

```solidity
StdStorage internal stdstore
```

### vm (inherited from StdAssertions)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### FAILED_SLOT (inherited from StdAssertions)

```solidity
bytes32 private constant FAILED_SLOT = bytes32("failed")
```

### _failed (inherited from StdAssertions)

```solidity
bool private _failed
```

### vm (inherited from StdChains)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### stdChainsInitialized (inherited from StdChains)

```solidity
bool private stdChainsInitialized
```

### chains (inherited from StdChains)

```solidity
mapping(string => Chain) private chains
```

### defaultRpcUrls (inherited from StdChains)

```solidity
mapping(string => string) private defaultRpcUrls
```

### idToAlias (inherited from StdChains)

```solidity
mapping(uint256 => string) private idToAlias
```

### fallbackToDefaultRpcUrls (inherited from StdChains)

```solidity
bool private fallbackToDefaultRpcUrls = true
```

### vm (inherited from StdCheatsSafe)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### UINT256_MAX (inherited from StdCheatsSafe)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### gasMeteringOff (inherited from StdCheatsSafe)

```solidity
bool private gasMeteringOff
```

### stdstore (inherited from StdCheats)

```solidity
StdStorage private stdstore
```

### vm (inherited from StdCheats)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### CONSOLE2_ADDRESS (inherited from StdCheats)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### _excludedContracts (inherited from StdInvariant)

```solidity
address[] private _excludedContracts
```

### _excludedSenders (inherited from StdInvariant)

```solidity
address[] private _excludedSenders
```

### _targetedContracts (inherited from StdInvariant)

```solidity
address[] private _targetedContracts
```

### _targetedSenders (inherited from StdInvariant)

```solidity
address[] private _targetedSenders
```

### _excludedArtifacts (inherited from StdInvariant)

```solidity
string[] private _excludedArtifacts
```

### _targetedArtifacts (inherited from StdInvariant)

```solidity
string[] private _targetedArtifacts
```

### _targetedArtifactSelectors (inherited from StdInvariant)

```solidity
FuzzArtifactSelector[] private _targetedArtifactSelectors
```

### _excludedSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _excludedSelectors
```

### _targetedSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _targetedSelectors
```

### _targetedInterfaces (inherited from StdInvariant)

```solidity
FuzzInterface[] private _targetedInterfaces
```

### multicall (inherited from StdUtils)

```solidity
IMulticall3 private constant multicall = IMulticall3(0xcA11bde05977b3631167028862bE2a173976CA11)
```

**IMulticall3**: [lib/forge-std/src/interfaces/IMulticall3.sol/interface_IMulticall3.md]

### vm (inherited from StdUtils)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### CONSOLE2_ADDRESS (inherited from StdUtils)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### INT256_MIN_ABS (inherited from StdUtils)

```solidity
uint256 private constant INT256_MIN_ABS = 57896044618658097711785492504343953926634992332820282019728792003956564819968
```

### SECP256K1_ORDER (inherited from StdUtils)

```solidity
uint256 private constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from StdUtils)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### CREATE2_FACTORY (inherited from StdUtils)

```solidity
address private constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### IS_TEST (inherited from Test)

```solidity
bool public IS_TEST = true
```

### DECIMALS (inherited from Setup)

```solidity
uint8 internal constant DECIMALS = 18
```

### asset (inherited from Setup)

```solidity
address internal asset
```

### feeRecipient (inherited from Setup)

```solidity
address internal feeRecipient = address(0xbeef)
```

### superGovernor (inherited from Setup)

```solidity
SuperGovernor internal superGovernor
```

**SuperGovernor**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

### superVault (inherited from Setup)

```solidity
SuperVault internal superVault
```

**SuperVault**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

### superVaultAggregator (inherited from Setup)

```solidity
UnsafeSuperVaultAggregator internal superVaultAggregator
```

**UnsafeSuperVaultAggregator**: [test/recon/helpers/UnsafeSuperVaultAggregator.sol/contract_UnsafeSuperVaultAggregator.md]

### superVaultEscrow (inherited from Setup)

```solidity
SuperVaultEscrow internal superVaultEscrow
```

**SuperVaultEscrow**: [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

### superVaultStrategy (inherited from Setup)

```solidity
SuperVaultStrategy internal superVaultStrategy
```

**SuperVaultStrategy**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

### vaultImpl (inherited from Setup)

```solidity
SuperVault internal vaultImpl
```

**SuperVault**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

### strategyImpl (inherited from Setup)

```solidity
SuperVaultStrategy internal strategyImpl
```

**SuperVaultStrategy**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

### escrowImpl (inherited from Setup)

```solidity
SuperVaultEscrow internal escrowImpl
```

**SuperVaultEscrow**: [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

### merkleHelper (inherited from Setup)

```solidity
MerkleTestHelper internal merkleHelper
```

**MerkleTestHelper**: [test/recon/helpers/MerkleTestHelper.sol/contract_MerkleTestHelper.md]

### approveAndDeposit4626Hook (inherited from Setup)

```solidity
ApproveAndDeposit4626VaultHook internal approveAndDeposit4626Hook
```

**ApproveAndDeposit4626VaultHook**: [lib/v2-core/src/hooks/vaults/4626/ApproveAndDeposit4626VaultHook.sol/contract_ApproveAndDeposit4626VaultHook.md]

### deposit4626Hook (inherited from Setup)

```solidity
Deposit4626VaultHook internal deposit4626Hook
```

**Deposit4626VaultHook**: [lib/v2-core/src/hooks/vaults/4626/Deposit4626VaultHook.sol/contract_Deposit4626VaultHook.md]

### redeem4626Hook (inherited from Setup)

```solidity
Redeem4626VaultHook internal redeem4626Hook
```

**Redeem4626VaultHook**: [lib/v2-core/src/hooks/vaults/4626/Redeem4626VaultHook.sol/contract_Redeem4626VaultHook.md]

### approveAndDeposit5115Hook (inherited from Setup)

```solidity
ApproveAndDeposit5115VaultHook internal approveAndDeposit5115Hook
```

**ApproveAndDeposit5115VaultHook**: [lib/v2-core/src/hooks/vaults/5115/ApproveAndDeposit5115VaultHook.sol/contract_ApproveAndDeposit5115VaultHook.md]

### deposit5115Hook (inherited from Setup)

```solidity
Deposit5115VaultHook internal deposit5115Hook
```

**Deposit5115VaultHook**: [lib/v2-core/src/hooks/vaults/5115/Deposit5115VaultHook.sol/contract_Deposit5115VaultHook.md]

### redeem5115Hook (inherited from Setup)

```solidity
Redeem5115VaultHook internal redeem5115Hook
```

**Redeem5115VaultHook**: [lib/v2-core/src/hooks/vaults/5115/Redeem5115VaultHook.sol/contract_Redeem5115VaultHook.md]

### deposit7540Hook (inherited from Setup)

```solidity
Deposit7540VaultHook internal deposit7540Hook
```

**Deposit7540VaultHook**: [lib/v2-core/src/hooks/vaults/7540/Deposit7540VaultHook.sol/contract_Deposit7540VaultHook.md]

### redeem7540Hook (inherited from Setup)

```solidity
Redeem7540VaultHook internal redeem7540Hook
```

**Redeem7540VaultHook**: [lib/v2-core/src/hooks/vaults/7540/Redeem7540VaultHook.sol/contract_Redeem7540VaultHook.md]

### requestDeposit7540Hook (inherited from Setup)

```solidity
RequestDeposit7540VaultHook internal requestDeposit7540Hook
```

**RequestDeposit7540VaultHook**: [lib/v2-core/src/hooks/vaults/7540/RequestDeposit7540VaultHook.sol/contract_RequestDeposit7540VaultHook.md]

### requestRedeem7540Hook (inherited from Setup)

```solidity
RequestRedeem7540VaultHook internal requestRedeem7540Hook
```

**RequestRedeem7540VaultHook**: [lib/v2-core/src/hooks/vaults/7540/RequestRedeem7540VaultHook.sol/contract_RequestRedeem7540VaultHook.md]

### approveAndRequestDeposit7540Hook (inherited from Setup)

```solidity
ApproveAndRequestDeposit7540VaultHook internal approveAndRequestDeposit7540Hook
```

**ApproveAndRequestDeposit7540VaultHook**: [lib/v2-core/src/hooks/vaults/7540/ApproveAndRequestDeposit7540VaultHook.sol/contract_ApproveAndRequestDeposit7540VaultHook.md]

### cancelDepositRequest7540Hook (inherited from Setup)

```solidity
CancelDepositRequest7540Hook internal cancelDepositRequest7540Hook
```

**CancelDepositRequest7540Hook**: [lib/v2-core/src/hooks/vaults/7540/CancelDepositRequest7540Hook.sol/contract_CancelDepositRequest7540Hook.md]

### cancelRedeemRequest7540Hook (inherited from Setup)

```solidity
CancelRedeemRequest7540Hook internal cancelRedeemRequest7540Hook
```

**CancelRedeemRequest7540Hook**: [lib/v2-core/src/hooks/vaults/7540/CancelRedeemRequest7540Hook.sol/contract_CancelRedeemRequest7540Hook.md]

### claimCancelDepositRequest7540Hook (inherited from Setup)

```solidity
ClaimCancelDepositRequest7540Hook internal claimCancelDepositRequest7540Hook
```

**ClaimCancelDepositRequest7540Hook**: [lib/v2-core/src/hooks/vaults/7540/ClaimCancelDepositRequest7540Hook.sol/contract_ClaimCancelDepositRequest7540Hook.md]

### claimCancelRedeemRequest7540Hook (inherited from Setup)

```solidity
ClaimCancelRedeemRequest7540Hook internal claimCancelRedeemRequest7540Hook
```

**ClaimCancelRedeemRequest7540Hook**: [lib/v2-core/src/hooks/vaults/7540/ClaimCancelRedeemRequest7540Hook.sol/contract_ClaimCancelRedeemRequest7540Hook.md]

### withdraw7540Hook (inherited from Setup)

```solidity
Withdraw7540VaultHook internal withdraw7540Hook
```

**Withdraw7540VaultHook**: [lib/v2-core/src/hooks/vaults/7540/Withdraw7540VaultHook.sol/contract_Withdraw7540VaultHook.md]

### erc4626YieldSourceOracle (inherited from Setup)

```solidity
MockERC4626YieldSourceOracle internal erc4626YieldSourceOracle
```

**MockERC4626YieldSourceOracle**: [test/recon/mocks/MockERC4626YieldSourceOracle.sol/contract_MockERC4626YieldSourceOracle.md]

### erc5115YieldSourceOracle (inherited from Setup)

```solidity
MockERC5115YieldSourceOracle internal erc5115YieldSourceOracle
```

**MockERC5115YieldSourceOracle**: [test/recon/mocks/MockERC5115YieldSourceOracle.sol/contract_MockERC5115YieldSourceOracle.md]

### ECDSAPPSOracle (inherited from Setup)

```solidity
MockECDSAPPSOracle internal ECDSAPPSOracle
```

**MockECDSAPPSOracle**: [test/recon/mocks/MockECDSAPPSOracle.sol/contract_MockECDSAPPSOracle.md]

### erc4626YieldSource (inherited from Setup)

```solidity
address internal erc4626YieldSource
```

### erc5115YieldSource (inherited from Setup)

```solidity
address internal erc5115YieldSource
```

### erc7540YieldSource (inherited from Setup)

```solidity
address internal erc7540YieldSource
```

### hasUpdatedPPS (inherited from Setup)

```solidity
bool internal hasUpdatedPPS
```

### burnedMoreThanRequested (inherited from Setup)

```solidity
int256 internal burnedMoreThanRequested
```

### burnedLessThanRequested (inherited from Setup)

```solidity
int256 internal burnedLessThanRequested
```

### previewMintSharesGreater (inherited from Setup)

```solidity
int256 internal previewMintSharesGreater
```

### previewDepositSharesGreater (inherited from Setup)

```solidity
int256 internal previewDepositSharesGreater
```

### previewMintAssetsGreater (inherited from Setup)

```solidity
int256 internal previewMintAssetsGreater
```

### previewDepositAssetsGreater (inherited from Setup)

```solidity
int256 internal previewDepositAssetsGreater
```

### executeHooksClampedSuccess (inherited from Setup)

```solidity
bool internal executeHooksClampedSuccess
```

### executeHooksSuccess (inherited from Setup)

```solidity
bool internal executeHooksSuccess
```

### fulfillRedeemRequestsSuccess (inherited from Setup)

```solidity
bool internal fulfillRedeemRequestsSuccess
```

### hasDeployedNewVault (inherited from Setup)

```solidity
bool internal hasDeployedNewVault
```

### _before (inherited from BeforeAfter)

```solidity
Vars internal _before
```

### _after (inherited from BeforeAfter)

```solidity
Vars internal _after
```

### _currentOp (inherited from BeforeAfter)

```solidity
OpType internal _currentOp
```

### MAX_ROUNDING_ERROR (inherited from ERC7540Properties)

```solidity
uint256 public constant MAX_ROUNDING_ERROR = 10 ** 18
```

### actor (inherited from ERC7540Properties)

```solidity
address internal actor
```

## Structs

### ChainData (inherited from StdChains)

```solidity
struct ChainData {
    string name;
    uint256 chainId;
    string rpcUrl;
}
```

### Chain (inherited from StdChains)

```solidity
struct Chain {
    string name;
    uint256 chainId;
    string chainAlias;
    string rpcUrl;
}
```

### RawTx1559 (inherited from StdCheatsSafe)

```solidity
struct RawTx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    RawTx1559Detail txDetail;
    string opcode;
}
```

### RawTx1559Detail (inherited from StdCheatsSafe)

```solidity
struct RawTx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    bytes gas;
    bytes nonce;
    address to;
    bytes txType;
    bytes value;
}
```

### Tx1559 (inherited from StdCheatsSafe)

```solidity
struct Tx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    Tx1559Detail txDetail;
    string opcode;
}
```

### Tx1559Detail (inherited from StdCheatsSafe)

```solidity
struct Tx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    uint256 gas;
    uint256 nonce;
    address to;
    uint256 txType;
    uint256 value;
}
```

### TxLegacy (inherited from StdCheatsSafe)

```solidity
struct TxLegacy {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    string hash;
    string opcode;
    TxDetailLegacy transaction;
}
```

### TxDetailLegacy (inherited from StdCheatsSafe)

```solidity
struct TxDetailLegacy {
    AccessList[] accessList;
    uint256 chainId;
    bytes data;
    address from;
    uint256 gas;
    uint256 gasPrice;
    bytes32 hash;
    uint256 nonce;
    bytes1 opcode;
    bytes32 r;
    bytes32 s;
    uint256 txType;
    address to;
    uint8 v;
    uint256 value;
}
```

### AccessList (inherited from StdCheatsSafe)

```solidity
struct AccessList {
    address accessAddress;
    bytes32[] storageKeys;
}
```

### RawReceipt (inherited from StdCheatsSafe)

```solidity
struct RawReceipt {
    bytes32 blockHash;
    bytes blockNumber;
    address contractAddress;
    bytes cumulativeGasUsed;
    bytes effectiveGasPrice;
    address from;
    bytes gasUsed;
    RawReceiptLog[] logs;
    bytes logsBloom;
    bytes status;
    address to;
    bytes32 transactionHash;
    bytes transactionIndex;
}
```

### Receipt (inherited from StdCheatsSafe)

```solidity
struct Receipt {
    bytes32 blockHash;
    uint256 blockNumber;
    address contractAddress;
    uint256 cumulativeGasUsed;
    uint256 effectiveGasPrice;
    address from;
    uint256 gasUsed;
    ReceiptLog[] logs;
    bytes logsBloom;
    uint256 status;
    address to;
    bytes32 transactionHash;
    uint256 transactionIndex;
}
```

### EIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct EIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    Receipt[] receipts;
    uint256 timestamp;
    Tx1559[] transactions;
    TxReturn[] txReturns;
}
```

### RawEIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct RawEIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    RawReceipt[] receipts;
    TxReturn[] txReturns;
    uint256 timestamp;
    RawTx1559[] transactions;
}
```

### RawReceiptLog (inherited from StdCheatsSafe)

```solidity
struct RawReceiptLog {
    address logAddress;
    bytes32 blockHash;
    bytes blockNumber;
    bytes data;
    bytes logIndex;
    bool removed;
    bytes32[] topics;
    bytes32 transactionHash;
    bytes transactionIndex;
    bytes transactionLogIndex;
}
```

### ReceiptLog (inherited from StdCheatsSafe)

```solidity
struct ReceiptLog {
    address logAddress;
    bytes32 blockHash;
    uint256 blockNumber;
    bytes data;
    uint256 logIndex;
    bytes32[] topics;
    uint256 transactionIndex;
    uint256 transactionLogIndex;
    bool removed;
}
```

### TxReturn (inherited from StdCheatsSafe)

```solidity
struct TxReturn {
    string internalType;
    string value;
}
```

### Account (inherited from StdCheatsSafe)

```solidity
struct Account {
    address addr;
    uint256 key;
}
```

### FuzzSelector (inherited from StdInvariant)

```solidity
struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}
```

### FuzzArtifactSelector (inherited from StdInvariant)

```solidity
struct FuzzArtifactSelector {
    string artifact;
    bytes4[] selectors;
}
```

### FuzzInterface (inherited from StdInvariant)

```solidity
struct FuzzInterface {
    address addr;
    string[] artifacts;
}
```

### Vars (inherited from BeforeAfter)

```solidity
struct Vars {
    mapping(address => uint256) pendingUserAssets;
    mapping(address => uint256) claimableUserAssets;
    mapping(address => ISuperVaultStrategy.SuperVaultState) state;
    mapping(address => uint256) superVaultShares;
    uint256 oraclePPS;
    uint256 naivePPS;
    uint256 summedTotalShares;
    uint256 summedTotalAssets;
    uint256 strategyAssetBalance;
    uint256 summedPendingRedeem;
}
```

## Errors

### ActorNotSetup (inherited from ActorManager)

```solidity
error ActorNotSetup();
```

### ActorExists (inherited from ActorManager)

```solidity
error ActorExists();
```

### ActorNotAdded (inherited from ActorManager)

```solidity
error ActorNotAdded();
```

### DefaultActor (inherited from ActorManager)

```solidity
error DefaultActor();
```

### NotSetup (inherited from AssetManager)

```solidity
error NotSetup();
```

### Exists (inherited from AssetManager)

```solidity
error Exists();
```

### NotAdded (inherited from AssetManager)

```solidity
error NotAdded();
```

### YieldSourceNotSetup (inherited from YieldManager)

```solidity
error YieldSourceNotSetup();
```

### YieldSourceExists (inherited from YieldManager)

```solidity
error YieldSourceExists();
```

### YieldSourceNotAdded (inherited from YieldManager)

```solidity
error YieldSourceNotAdded();
```

### InvalidYieldSourceType (inherited from YieldManager)

```solidity
error InvalidYieldSourceType();
```

### EMPTY_ARRAYS (inherited from AssetAdjustmentHelper)

```solidity
error EMPTY_ARRAYS();
```

### ARRAY_LENGTH_MISMATCH (inherited from AssetAdjustmentHelper)

```solidity
error ARRAY_LENGTH_MISMATCH();
```

### ZERO_TOTAL_THEORETICAL (inherited from AssetAdjustmentHelper)

```solidity
error ZERO_TOTAL_THEORETICAL();
```

### INSUFFICIENT_AVAILABLE_ASSETS (inherited from AssetAdjustmentHelper)

```solidity
error INSUFFICIENT_AVAILABLE_ASSETS();
```

## Events

### log (inherited from StdAssertions)

```solidity
event log(string);
```

### logs (inherited from StdAssertions)

```solidity
event logs(bytes);
```

### log_address (inherited from StdAssertions)

```solidity
event log_address(address);
```

### log_bytes32 (inherited from StdAssertions)

```solidity
event log_bytes32(bytes32);
```

### log_int (inherited from StdAssertions)

```solidity
event log_int(int256);
```

### log_uint (inherited from StdAssertions)

```solidity
event log_uint(uint256);
```

### log_bytes (inherited from StdAssertions)

```solidity
event log_bytes(bytes);
```

### log_string (inherited from StdAssertions)

```solidity
event log_string(string);
```

### log_named_address (inherited from StdAssertions)

```solidity
event log_named_address(string key, address val);
```

### log_named_bytes32 (inherited from StdAssertions)

```solidity
event log_named_bytes32(string key, bytes32 val);
```

### log_named_decimal_int (inherited from StdAssertions)

```solidity
event log_named_decimal_int(string key, int256 val, uint256 decimals);
```

### log_named_decimal_uint (inherited from StdAssertions)

```solidity
event log_named_decimal_uint(string key, uint256 val, uint256 decimals);
```

### log_named_int (inherited from StdAssertions)

```solidity
event log_named_int(string key, int256 val);
```

### log_named_uint (inherited from StdAssertions)

```solidity
event log_named_uint(string key, uint256 val);
```

### log_named_bytes (inherited from StdAssertions)

```solidity
event log_named_bytes(string key, bytes val);
```

### log_named_string (inherited from StdAssertions)

```solidity
event log_named_string(string key, string val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(uint256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(int256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(address[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, uint256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, int256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, address[] val);
```

## Enums

### AddressType (inherited from StdCheatsSafe)

```solidity
enum AddressType {
    Payable,
    NonPayable,
    ZeroAddress,
    Precompile,
    ForgeAddress
}
```

## Public/External Functions

### setUp()

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 363:48:656
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() public;
```

### failed() (inherited from StdAssertions)

- **Signature**: `failed()`
- **Visibility**: public
- **Source Range**: 1306:195:12
- **Details**: [function_failed.md](./function_failed.md)

**Signature:**
```solidity
function failed() public view returns (bool);
```

### excludeArtifacts() (inherited from StdInvariant)

- **Signature**: `excludeArtifacts()`
- **Visibility**: public
- **Source Range**: 2459:141:17
- **Details**: [function_excludeArtifacts.md](./function_excludeArtifacts.md)

**Signature:**
```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_);
```

### excludeContracts() (inherited from StdInvariant)

- **Signature**: `excludeContracts()`
- **Visibility**: public
- **Source Range**: 2606:142:17
- **Details**: [function_excludeContracts.md](./function_excludeContracts.md)

**Signature:**
```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_);
```

### excludeSelectors() (inherited from StdInvariant)

- **Signature**: `excludeSelectors()`
- **Visibility**: public
- **Source Range**: 2754:147:17
- **Details**: [function_excludeSelectors.md](./function_excludeSelectors.md)

**Signature:**
```solidity
function excludeSelectors() public view returns (FuzzSelector[] memory excludedSelectors_);
```

### excludeSenders() (inherited from StdInvariant)

- **Signature**: `excludeSenders()`
- **Visibility**: public
- **Source Range**: 2907:134:17
- **Details**: [function_excludeSenders.md](./function_excludeSenders.md)

**Signature:**
```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_);
```

### targetArtifacts() (inherited from StdInvariant)

- **Signature**: `targetArtifacts()`
- **Visibility**: public
- **Source Range**: 3047:140:17
- **Details**: [function_targetArtifacts.md](./function_targetArtifacts.md)

**Signature:**
```solidity
function targetArtifacts() public view returns (string[] memory targetedArtifacts_);
```

### targetArtifactSelectors() (inherited from StdInvariant)

- **Signature**: `targetArtifactSelectors()`
- **Visibility**: public
- **Source Range**: 3193:186:17
- **Details**: [function_targetArtifactSelectors.md](./function_targetArtifactSelectors.md)

**Signature:**
```solidity
function targetArtifactSelectors() public view returns (FuzzArtifactSelector[] memory targetedArtifactSelectors_);
```

### targetContracts() (inherited from StdInvariant)

- **Signature**: `targetContracts()`
- **Visibility**: public
- **Source Range**: 3385:141:17
- **Details**: [function_targetContracts.md](./function_targetContracts.md)

**Signature:**
```solidity
function targetContracts() public view returns (address[] memory targetedContracts_);
```

### targetSelectors() (inherited from StdInvariant)

- **Signature**: `targetSelectors()`
- **Visibility**: public
- **Source Range**: 3532:146:17
- **Details**: [function_targetSelectors.md](./function_targetSelectors.md)

**Signature:**
```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_);
```

### targetSenders() (inherited from StdInvariant)

- **Signature**: `targetSenders()`
- **Visibility**: public
- **Source Range**: 3684:133:17
- **Details**: [function_targetSenders.md](./function_targetSenders.md)

**Signature:**
```solidity
function targetSenders() public view returns (address[] memory targetedSenders_);
```

### targetInterfaces() (inherited from StdInvariant)

- **Signature**: `targetInterfaces()`
- **Visibility**: public
- **Source Range**: 3823:151:17
- **Details**: [function_targetInterfaces.md](./function_targetInterfaces.md)

**Signature:**
```solidity
function targetInterfaces() public view returns (FuzzInterface[] memory targetedInterfaces_);
```

### _getRandomActor(uint256) (inherited from Setup)

- **Signature**: `_getRandomActor(uint256)`
- **Visibility**: public
- **Source Range**: 17946:176:631
- **Details**: [function__getRandomActor_uint256.md](./function__getRandomActor_uint256.md)

**Signature:**
```solidity
function _getRandomActor(uint256 entropy) public view returns (address);
```

### _sumStrategyAssets() (inherited from BeforeAfter)

- **Signature**: `_sumStrategyAssets()`
- **Visibility**: public
- **Source Range**: 4456:764:626
- **Details**: [function__sumStrategyAssets.md](./function__sumStrategyAssets.md)

**Signature:**
```solidity
function _sumStrategyAssets() public view returns (uint256);
```

### erc7540_1(address) (inherited from ERC7540Properties)

- **Signature**: `erc7540_1(address)`
- **Visibility**: public
- **Source Range**: 2667:521:10
- **Details**: [function_erc7540_1_address.md](./function_erc7540_1_address.md)

**Signature:**
```solidity
/// @dev 7540-1	convertToAssets(totalSupply) == totalAssets unless price is 0.0
function erc7540_1(address erc7540Target) virtual public returns (bool);
```

### erc7540_2(address) (inherited from ERC7540Properties)

- **Signature**: `erc7540_2(address)`
- **Visibility**: public
- **Source Range**: 3278:619:10
- **Details**: [function_erc7540_2_address.md](./function_erc7540_2_address.md)

**Signature:**
```solidity
/// @dev 7540-2	convertToShares(totalAssets) == totalSupply unless price is 0.0
function erc7540_2(address erc7540Target) virtual public returns (bool);
```

### erc7540_3(address) (inherited from ERC7540Properties)

- **Signature**: `erc7540_3(address)`
- **Visibility**: public
- **Source Range**: 4062:548:10
- **Details**: [function_erc7540_3_address.md](./function_erc7540_3_address.md)

**Signature:**
```solidity
/// @dev 7540-3	max* never reverts
function erc7540_3(address erc7540Target) virtual public returns (bool);
```

### erc7540_4_deposit(address,uint256) (inherited from ERC7540Properties)

- **Signature**: `erc7540_4_deposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 4702:802:10
- **Details**: [function_erc7540_4_deposit_address_uint256.md](./function_erc7540_4_deposit_address_uint256.md)

**Signature:**
```solidity
/// @dev 7540-4 claiming more than max always reverts
function erc7540_4_deposit(address erc7540Target, uint256 amt) virtual public returns (bool);
```

### erc7540_4_mint(address,uint256) (inherited from ERC7540Properties)

- **Signature**: `erc7540_4_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 5510:725:10
- **Details**: [function_erc7540_4_mint_address_uint256.md](./function_erc7540_4_mint_address_uint256.md)

**Signature:**
```solidity
function erc7540_4_mint(address erc7540Target, uint256 amt) virtual public returns (bool);
```

### erc7540_4_withdraw(address,uint256) (inherited from ERC7540Properties)

- **Signature**: `erc7540_4_withdraw(address,uint256)`
- **Visibility**: public
- **Source Range**: 6241:738:10
- **Details**: [function_erc7540_4_withdraw_address_uint256.md](./function_erc7540_4_withdraw_address_uint256.md)

**Signature:**
```solidity
function erc7540_4_withdraw(address erc7540Target, uint256 amt) virtual public returns (bool);
```

### erc7540_4_redeem(address,uint256) (inherited from ERC7540Properties)

- **Signature**: `erc7540_4_redeem(address,uint256)`
- **Visibility**: public
- **Source Range**: 6985:732:10
- **Details**: [function_erc7540_4_redeem_address_uint256.md](./function_erc7540_4_redeem_address_uint256.md)

**Signature:**
```solidity
function erc7540_4_redeem(address erc7540Target, uint256 amt) virtual public returns (bool);
```

### erc7540_5(address,address,uint256) (inherited from ERC7540Properties)

- **Signature**: `erc7540_5(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 7838:739:10
- **Details**: [function_erc7540_5_address_address_uint256.md](./function_erc7540_5_address_address_uint256.md)

**Signature:**
```solidity
/// @dev 7540-5	requestRedeem reverts if the share balance is less than amount
function erc7540_5(address erc7540Target, address shareToken, uint256 shares) virtual public returns (bool);
```

### erc7540_6(address) (inherited from ERC7540Properties)

- **Signature**: `erc7540_6(address)`
- **Visibility**: public
- **Source Range**: 8627:553:10
- **Details**: [function_erc7540_6_address.md](./function_erc7540_6_address.md)

**Signature:**
```solidity
/// @dev 7540-6	preview* always reverts
function erc7540_6(address erc7540Target) virtual public returns (bool);
```

### erc7540_7_deposit(address,uint256) (inherited from ERC7540Properties)

- **Signature**: `erc7540_7_deposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 9292:564:10
- **Details**: [function_erc7540_7_deposit_address_uint256.md](./function_erc7540_7_deposit_address_uint256.md)

**Signature:**
```solidity
/// @dev 7540-7 if max[method] > 0, then [method] (max) should not revert
function erc7540_7_deposit(address erc7540Target, uint256 amt) virtual public returns (bool);
```

### erc7540_7_mint(address,uint256) (inherited from ERC7540Properties)

- **Signature**: `erc7540_7_mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 9862:524:10
- **Details**: [function_erc7540_7_mint_address_uint256.md](./function_erc7540_7_mint_address_uint256.md)

**Signature:**
```solidity
function erc7540_7_mint(address erc7540Target, uint256 amt) virtual public returns (bool);
```

### erc7540_7_withdraw(address,uint256) (inherited from ERC7540Properties)

- **Signature**: `erc7540_7_withdraw(address,uint256)`
- **Visibility**: public
- **Source Range**: 10392:551:10
- **Details**: [function_erc7540_7_withdraw_address_uint256.md](./function_erc7540_7_withdraw_address_uint256.md)

**Signature:**
```solidity
function erc7540_7_withdraw(address erc7540Target, uint256 amt) virtual public returns (bool);
```

### erc7540_7_redeem(address,uint256) (inherited from ERC7540Properties)

- **Signature**: `erc7540_7_redeem(address,uint256)`
- **Visibility**: public
- **Source Range**: 10949:538:10
- **Details**: [function_erc7540_7_redeem_address_uint256.md](./function_erc7540_7_redeem_address_uint256.md)

**Signature:**
```solidity
function erc7540_7_redeem(address erc7540Target, uint256 amt) virtual public returns (bool);
```

### property_oraclePPSDoesntChangeOnAddOrRemove() (inherited from Properties)

- **Signature**: `property_oraclePPSDoesntChangeOnAddOrRemove()`
- **Visibility**: public
- **Source Range**: 725:244:630
- **Details**: [function_property_oraclePPSDoesntChangeOnAddOrRemove.md](./function_property_oraclePPSDoesntChangeOnAddOrRemove.md)

**Signature:**
```solidity
/// @dev Property: oracle PPS doesn't change on deposit/mint/redeem/withdraw
function property_oraclePPSDoesntChangeOnAddOrRemove() public;
```

### property_maxRedeemMaxWithdrawSymmetry() (inherited from Properties)

- **Signature**: `property_maxRedeemMaxWithdrawSymmetry()`
- **Visibility**: public
- **Source Range**: 1052:560:630
- **Details**: [function_property_maxRedeemMaxWithdrawSymmetry.md](./function_property_maxRedeemMaxWithdrawSymmetry.md)

**Signature:**
```solidity
/// @dev Property: maxRedeem and maxWithdraw should always be equivalent
function property_maxRedeemMaxWithdrawSymmetry() public;
```

### property_totalSharesDontDecreaseOnRedemptionRequest() (inherited from Properties)

- **Signature**: `property_totalSharesDontDecreaseOnRedemptionRequest()`
- **Visibility**: public
- **Source Range**: 1693:317:630
- **Details**: [function_property_totalSharesDontDecreaseOnRedemptionRequest.md](./function_property_totalSharesDontDecreaseOnRedemptionRequest.md)

**Signature:**
```solidity
/// @dev Property: requestRedeem should never reduce SuperVault shares
function property_totalSharesDontDecreaseOnRedemptionRequest() public;
```

### property_shareSolvency() (inherited from Properties)

- **Signature**: `property_shareSolvency()`
- **Visibility**: public
- **Source Range**: 2107:178:630
- **Details**: [function_property_shareSolvency.md](./function_property_shareSolvency.md)

**Signature:**
```solidity
/// @dev Property: `SuperVault::totalSupply` == SUM(user balances) + balanceOf(escrow)
function property_shareSolvency() public;
```

### property_escrowBalance() (inherited from Properties)

- **Signature**: `property_escrowBalance()`
- **Visibility**: public
- **Source Range**: 2373:465:630
- **Details**: [function_property_escrowBalance.md](./function_property_escrowBalance.md)

**Signature:**
```solidity
/// @dev Property: balanceOf(escrow) >= SUM(controllers.pendingRedeemRequest)
function property_escrowBalance() public;
```

### property_maxMintZeroWhenPaused() (inherited from Properties)

- **Signature**: `property_maxMintZeroWhenPaused()`
- **Visibility**: public
- **Source Range**: 2913:319:630
- **Details**: [function_property_maxMintZeroWhenPaused.md](./function_property_maxMintZeroWhenPaused.md)

**Signature:**
```solidity
/// @dev Property: maxMint should be 0 when aggregator is paused
function property_maxMintZeroWhenPaused() public;
```

### property_maxDepositZeroWhenPaused() (inherited from Properties)

- **Signature**: `property_maxDepositZeroWhenPaused()`
- **Visibility**: public
- **Source Range**: 3308:334:630
- **Details**: [function_property_maxDepositZeroWhenPaused.md](./function_property_maxDepositZeroWhenPaused.md)

**Signature:**
```solidity
/// @dev Property: maxDeposit should be 0 when strategy is paused
function property_maxDepositZeroWhenPaused() public;
```

### property_cancelDoesntChangeTotalSupply() (inherited from Properties)

- **Signature**: `property_cancelDoesntChangeTotalSupply()`
- **Visibility**: public
- **Source Range**: 3735:315:630
- **Details**: [function_property_cancelDoesntChangeTotalSupply.md](./function_property_cancelDoesntChangeTotalSupply.md)

**Signature:**
```solidity
/// @dev Property: cancelRedeem should never alter the supply of SuperVault tokens
function property_cancelDoesntChangeTotalSupply() public;
```

### property_assetBacking() (inherited from Properties)

- **Signature**: `property_assetBacking()`
- **Visibility**: public
- **Source Range**: 4120:242:630
- **Details**: [function_property_assetBacking.md](./function_property_assetBacking.md)

**Signature:**
```solidity
/// @dev Property: if totalSupply > 0, then totalAssets > 0
function property_assetBacking() public;
```

### property_totalAssets() (inherited from Properties)

- **Signature**: `property_totalAssets()`
- **Visibility**: public
- **Source Range**: 4424:408:630
- **Details**: [function_property_totalAssets.md](./function_property_totalAssets.md)

**Signature:**
```solidity
/// @dev Property: SUM(shares) * PPS == totalAssets
function property_totalAssets() public;
```

### property_avgPPSDoesntDecrease() (inherited from Properties)

- **Signature**: `property_avgPPSDoesntDecrease()`
- **Visibility**: public
- **Source Range**: 4976:560:630
- **Details**: [function_property_avgPPSDoesntDecrease.md](./function_property_avgPPSDoesntDecrease.md)

**Signature:**
```solidity
/// @dev Property: When a user requests a redemption and the PPS is >= the user PPS, user averageRequestPPS must not
///  decrease
function property_avgPPSDoesntDecrease() public;
```

### property_previewEquivalenceFromShares(uint256) (inherited from Properties)

- **Signature**: `property_previewEquivalenceFromShares(uint256)`
- **Visibility**: public
- **Source Range**: 5622:672:630
- **Details**: [function_property_previewEquivalenceFromShares_uint256.md](./function_property_previewEquivalenceFromShares_uint256.md)

**Signature:**
```solidity
/// @dev Property: previewMint and previewDeposit equivalence (from shares)
function property_previewEquivalenceFromShares(uint256 shares) public;
```

### property_previewEquivalenceFromAssets(uint256) (inherited from Properties)

- **Signature**: `property_previewEquivalenceFromAssets(uint256)`
- **Visibility**: public
- **Source Range**: 6380:897:630
- **Details**: [function_property_previewEquivalenceFromAssets_uint256.md](./function_property_previewEquivalenceFromAssets_uint256.md)

**Signature:**
```solidity
/// @dev Property: previewMint and previewDeposit equivalence (from assets)
function property_previewEquivalenceFromAssets(uint256 assets) public;
```

### property_comparePreviewMintAndConvertToAssets(uint256) (inherited from Properties)

- **Signature**: `property_comparePreviewMintAndConvertToAssets(uint256)`
- **Visibility**: public
- **Source Range**: 7340:551:630
- **Details**: [function_property_comparePreviewMintAndConvertToAssets_uint256.md](./function_property_comparePreviewMintAndConvertToAssets_uint256.md)

**Signature:**
```solidity
/// @dev Property: previewMint is >= convertToAssets
function property_comparePreviewMintAndConvertToAssets(uint256 shares) public;
```

### property_comparePreviewDepositAndConvertToShares(uint256) (inherited from Properties)

- **Signature**: `property_comparePreviewDepositAndConvertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 7989:423:630
- **Details**: [function_property_comparePreviewDepositAndConvertToShares_uint256.md](./function_property_comparePreviewDepositAndConvertToShares_uint256.md)

**Signature:**
```solidity
/// @dev Property: convertToShares is >= previewDepositShares (equivalent without fees)
function property_comparePreviewDepositAndConvertToShares(uint256 assets) public;
```

### property_sumOfClaimable() (inherited from Properties)

- **Signature**: `property_sumOfClaimable()`
- **Visibility**: public
- **Source Range**: 8699:650:630
- **Details**: [function_property_sumOfClaimable.md](./function_property_sumOfClaimable.md)

**Signature:**
```solidity
/// @dev Property: After all redemptions are processed, the sum of all claimable is <= balance available
function property_sumOfClaimable() public;
```

### property_sumOfAssetsMaxWithdrawable() (inherited from Properties)

- **Signature**: `property_sumOfAssetsMaxWithdrawable()`
- **Visibility**: public
- **Source Range**: 9472:426:630
- **Details**: [function_property_sumOfAssetsMaxWithdrawable.md](./function_property_sumOfAssetsMaxWithdrawable.md)

**Signature:**
```solidity
/// @dev Property: If the sum of assets in SuperVaultStrategy and yield strategies is 0, maxWithdraw should be 0
function property_sumOfAssetsMaxWithdrawable() public;
```

### property_avgPPSMonotonicity() (inherited from Properties)

- **Signature**: `property_avgPPSMonotonicity()`
- **Visibility**: public
- **Source Range**: 10021:626:630
- **Details**: [function_property_avgPPSMonotonicity.md](./function_property_avgPPSMonotonicity.md)

**Signature:**
```solidity
/// @dev Property: averageWithdrawPrice should never decrease when new redemptions are fulfilled at a higher PPS
function property_avgPPSMonotonicity() public;
```

### property_fulfillOnlyBurnsRequestedAmount() (inherited from Properties)

- **Signature**: `property_fulfillOnlyBurnsRequestedAmount()`
- **Visibility**: public
- **Source Range**: 10754:760:630
- **Details**: [function_property_fulfillOnlyBurnsRequestedAmount.md](./function_property_fulfillOnlyBurnsRequestedAmount.md)

**Signature:**
```solidity
/// @dev Property: redemptions only burn the requested amount of shares (within tolerance range)
function property_fulfillOnlyBurnsRequestedAmount() public;
```

### setpreviewAssetsGreater(uint256) (inherited from Properties)

- **Signature**: `setpreviewAssetsGreater(uint256)`
- **Visibility**: public
- **Source Range**: 11550:438:630
- **Details**: [function_setpreviewAssetsGreater_uint256.md](./function_setpreviewAssetsGreater_uint256.md)

**Signature:**
```solidity
/// Optimization Setters
function setpreviewAssetsGreater(uint256 shares) public;
```

### setPreviewSharesGreater(uint256) (inherited from Properties)

- **Signature**: `setPreviewSharesGreater(uint256)`
- **Visibility**: public
- **Source Range**: 11994:500:630
- **Details**: [function_setPreviewSharesGreater_uint256.md](./function_setPreviewSharesGreater_uint256.md)

**Signature:**
```solidity
function setPreviewSharesGreater(uint256 assets) public;
```

### optimize_maxDustAccumulation() (inherited from Properties)

- **Signature**: `optimize_maxDustAccumulation()`
- **Visibility**: public
- **Source Range**: 12629:564:630
- **Details**: [function_optimize_maxDustAccumulation.md](./function_optimize_maxDustAccumulation.md)

**Signature:**
```solidity
/// @dev Optimize the difference between the amount of assets in the system and claimable assets
function optimize_maxDustAccumulation() public view returns (int256);
```

### optimize_moreClaimableThanHeldDifference() (inherited from Properties)

- **Signature**: `optimize_moreClaimableThanHeldDifference()`
- **Visibility**: public
- **Source Range**: 13300:586:630
- **Details**: [function_optimize_moreClaimableThanHeldDifference.md](./function_optimize_moreClaimableThanHeldDifference.md)

**Signature:**
```solidity
/// @dev Optimize the difference between the amount of claimable assets and assets in the system
function optimize_moreClaimableThanHeldDifference() public view returns (int256);
```

### optimize_burnMoreThanRequestedInRedemption() (inherited from Properties)

- **Signature**: `optimize_burnMoreThanRequestedInRedemption()`
- **Visibility**: public
- **Source Range**: 13892:130:630
- **Details**: [function_optimize_burnMoreThanRequestedInRedemption.md](./function_optimize_burnMoreThanRequestedInRedemption.md)

**Signature:**
```solidity
function optimize_burnMoreThanRequestedInRedemption() public view returns (int256);
```

### optimize_burnLessThanRequestedInRedemption() (inherited from Properties)

- **Signature**: `optimize_burnLessThanRequestedInRedemption()`
- **Visibility**: public
- **Source Range**: 14028:130:630
- **Details**: [function_optimize_burnLessThanRequestedInRedemption.md](./function_optimize_burnLessThanRequestedInRedemption.md)

**Signature:**
```solidity
function optimize_burnLessThanRequestedInRedemption() public view returns (int256);
```

### optimize_assetBackingDifference() (inherited from Properties)

- **Signature**: `optimize_assetBackingDifference()`
- **Visibility**: public
- **Source Range**: 14164:340:630
- **Details**: [function_optimize_assetBackingDifference.md](./function_optimize_assetBackingDifference.md)

**Signature:**
```solidity
function optimize_assetBackingDifference() public view returns (int256);
```

### crytic_erc7540_1() (inherited from Properties)

- **Signature**: `crytic_erc7540_1()`
- **Visibility**: public
- **Source Range**: 14681:179:630
- **Details**: [function_crytic_erc7540_1.md](./function_crytic_erc7540_1.md)

**Signature:**
```solidity
/// @dev Property 7540-1: convertToAssets(totalSupply) == totalAssets unless price is 0.0
function crytic_erc7540_1() public;
```

### crytic_erc7540_2() (inherited from Properties)

- **Signature**: `crytic_erc7540_2()`
- **Visibility**: public
- **Source Range**: 14960:179:630
- **Details**: [function_crytic_erc7540_2.md](./function_crytic_erc7540_2.md)

**Signature:**
```solidity
/// @dev Property 7540-2: convertToShares(totalAssets) == totalSupply unless price is 0.0
function crytic_erc7540_2() public;
```

### crytic_erc7540_3() (inherited from Properties)

- **Signature**: `crytic_erc7540_3()`
- **Visibility**: public
- **Source Range**: 15194:163:630
- **Details**: [function_crytic_erc7540_3.md](./function_crytic_erc7540_3.md)

**Signature:**
```solidity
/// @dev Property 7540-3: max* never reverts
function crytic_erc7540_3() public;
```

### crytic_erc7540_4_deposit(uint256) (inherited from Properties)

- **Signature**: `crytic_erc7540_4_deposit(uint256)`
- **Visibility**: public
- **Source Range**: 15431:201:630
- **Details**: [function_crytic_erc7540_4_deposit_uint256.md](./function_crytic_erc7540_4_deposit_uint256.md)

**Signature:**
```solidity
/// @dev Property 7540-4: claiming more than max always reverts
function crytic_erc7540_4_deposit(uint256 amt) public;
```

### crytic_erc7540_4_mint(uint256) (inherited from Properties)

- **Signature**: `crytic_erc7540_4_mint(uint256)`
- **Visibility**: public
- **Source Range**: 15638:192:630
- **Details**: [function_crytic_erc7540_4_mint_uint256.md](./function_crytic_erc7540_4_mint_uint256.md)

**Signature:**
```solidity
function crytic_erc7540_4_mint(uint256 amt) public;
```

### crytic_erc7540_4_withdraw(uint256) (inherited from Properties)

- **Signature**: `crytic_erc7540_4_withdraw(uint256)`
- **Visibility**: public
- **Source Range**: 15836:204:630
- **Details**: [function_crytic_erc7540_4_withdraw_uint256.md](./function_crytic_erc7540_4_withdraw_uint256.md)

**Signature:**
```solidity
function crytic_erc7540_4_withdraw(uint256 amt) public;
```

### crytic_erc7540_4_redeem(uint256) (inherited from Properties)

- **Signature**: `crytic_erc7540_4_redeem(uint256)`
- **Visibility**: public
- **Source Range**: 16046:198:630
- **Details**: [function_crytic_erc7540_4_redeem_uint256.md](./function_crytic_erc7540_4_redeem_uint256.md)

**Signature:**
```solidity
function crytic_erc7540_4_redeem(uint256 amt) public;
```

### crytic_erc7540_5(uint256) (inherited from Properties)

- **Signature**: `crytic_erc7540_5(uint256)`
- **Visibility**: public
- **Source Range**: 16343:263:630
- **Details**: [function_crytic_erc7540_5_uint256.md](./function_crytic_erc7540_5_uint256.md)

**Signature:**
```solidity
/// @dev Property 7540-5: requestRedeem reverts if the share balance is less than amount
function crytic_erc7540_5(uint256 shares) public;
```

### crytic_erc7540_7_withdraw(uint256) (inherited from Properties)

- **Signature**: `crytic_erc7540_7_withdraw(uint256)`
- **Visibility**: public
- **Source Range**: 16612:208:630
- **Details**: [function_crytic_erc7540_7_withdraw_uint256.md](./function_crytic_erc7540_7_withdraw_uint256.md)

**Signature:**
```solidity
function crytic_erc7540_7_withdraw(uint256 amt) public;
```

### crytic_erc7540_7_redeem(uint256) (inherited from Properties)

- **Signature**: `crytic_erc7540_7_redeem(uint256)`
- **Visibility**: public
- **Source Range**: 17035:774:630
- **Details**: [function_crytic_erc7540_7_redeem_uint256.md](./function_crytic_erc7540_7_redeem_uint256.md)

**Signature:**
```solidity
function crytic_erc7540_7_redeem(uint256 amt) public;
```

### superVaultStrategy_executeHooks(struct ISuperVaultStrategy.ExecuteArgs) (inherited from AdminTargets)

- **Signature**: `superVaultStrategy_executeHooks(struct ISuperVaultStrategy.ExecuteArgs)`
- **Visibility**: public
- **Source Range**: 1234:232:646
- **Details**: [function_superVaultStrategy_executeHooks_struct_ISuperVaultStrategy.ExecuteArgs.md](./function_superVaultStrategy_executeHooks_struct_ISuperVaultStrategy.ExecuteArgs.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function superVaultStrategy_executeHooks(ISuperVaultStrategy.ExecuteArgs memory args) public payable asAdmin();
```

### superVaultAggregator_changePrimaryManager(address,address,address) (inherited from AdminTargets)

- **Signature**: `superVaultAggregator_changePrimaryManager(address,address,address)`
- **Visibility**: public
- **Source Range**: 2845:296:646
- **Details**: [function_superVaultAggregator_changePrimaryManager_address_address_address.md](./function_superVaultAggregator_changePrimaryManager_address_address_address.md)

**Signature:**
```solidity
/// @dev removed because we're bypassing hook validation
function superVaultAggregator_changePrimaryManager(address strategy, address newManager, address feeRecipient) public asAdmin();
```

### superVaultStrategy_fulfillRedeemRequests(uint256,address[]) (inherited from AdminTargets)

- **Signature**: `superVaultStrategy_fulfillRedeemRequests(uint256,address[])`
- **Visibility**: public
- **Source Range**: 3241:676:646
- **Details**: [function_superVaultStrategy_fulfillRedeemRequests_uint256_address[].md](./function_superVaultStrategy_fulfillRedeemRequests_uint256_address[].md)

**Signature:**
```solidity
/// @dev Property: superVaultStrategy does not incur loss on fulfillment
function superVaultStrategy_fulfillRedeemRequests(uint256 redeemShares, address[] memory controllers) public updateGhostsWithOpType(OpType.FULFILL);
```

### superVaultStrategy_fulfillRedeemRequests_WithLoss(uint256,uint256,address[]) (inherited from AdminTargets)

- **Signature**: `superVaultStrategy_fulfillRedeemRequests_WithLoss(uint256,uint256,address[])`
- **Visibility**: public
- **Source Range**: 4073:748:646
- **Details**: [function_superVaultStrategy_fulfillRedeemRequests_WithLoss_uint256_uint256_address[].md](./function_superVaultStrategy_fulfillRedeemRequests_WithLoss_uint256_uint256_address[].md)

**Signature:**
```solidity
/// @dev Same as superVaultStrategy_fulfillRedeemRequests but with lowered exepectedAssetsOrSharesOut so that hook
///  execution goes through
function superVaultStrategy_fulfillRedeemRequests_WithLoss(uint256 lossOnWithdraw, uint256 redeemShares, address[] memory controllers) public;
```

### doomsday_previewDepositEquivalence(uint256) (inherited from DoomsdayTargets)

- **Signature**: `doomsday_previewDepositEquivalence(uint256)`
- **Visibility**: public
- **Source Range**: 964:357:647
- **Details**: [function_doomsday_previewDepositEquivalence_uint256.md](./function_doomsday_previewDepositEquivalence_uint256.md)

**Signature:**
```solidity
/// @dev Property: previewDeposit and deposit equivalence
function doomsday_previewDepositEquivalence(uint256 assets) public;
```

### doomsday_previewMintEquivalence(uint256) (inherited from DoomsdayTargets)

- **Signature**: `doomsday_previewMintEquivalence(uint256)`
- **Visibility**: public
- **Source Range**: 1383:330:647
- **Details**: [function_doomsday_previewMintEquivalence_uint256.md](./function_doomsday_previewMintEquivalence_uint256.md)

**Signature:**
```solidity
/// @dev Property: previewMint and mint equivalence
function doomsday_previewMintEquivalence(uint256 shares) public;
```

### doomsday_mintRedeemSymmetrical(uint256) (inherited from DoomsdayTargets)

- **Signature**: `doomsday_mintRedeemSymmetrical(uint256)`
- **Visibility**: public
- **Source Range**: 1781:2482:647
- **Details**: [function_doomsday_mintRedeemSymmetrical_uint256.md](./function_doomsday_mintRedeemSymmetrical_uint256.md)

**Signature:**
```solidity
/// @dev Property: mint/redeem doesn't cause loss to user
function doomsday_mintRedeemSymmetrical(uint256 sharesToMint) public;
```

### doomsday_depositWithdrawSymmetrical(uint256) (inherited from DoomsdayTargets)

- **Signature**: `doomsday_depositWithdrawSymmetrical(uint256)`
- **Visibility**: public
- **Source Range**: 4336:2409:647
- **Details**: [function_doomsday_depositWithdrawSymmetrical_uint256.md](./function_doomsday_depositWithdrawSymmetrical_uint256.md)

**Signature:**
```solidity
/// @dev Property: deposit/withdraw doesn't cause loss to user
function doomsday_depositWithdrawSymmetrical(uint256 assetsToDeposit) public;
```

### doomsday_maxRedeemResetsAfterFullRedemption(uint256) (inherited from DoomsdayTargets)

- **Signature**: `doomsday_maxRedeemResetsAfterFullRedemption(uint256)`
- **Visibility**: public
- **Source Range**: 6880:1594:647
- **Details**: [function_doomsday_maxRedeemResetsAfterFullRedemption_uint256.md](./function_doomsday_maxRedeemResetsAfterFullRedemption_uint256.md)

**Signature:**
```solidity
/// @dev Property: maxRedeem is reset to 0 after full redemption
///  @dev Property: redeeming maxRedeem shouldn't revert
function doomsday_maxRedeemResetsAfterFullRedemption(uint256 sharesToMint) public stateless();
```

### doomsday_maxWithdrawResetsAfterFullWithdrawal(uint256) (inherited from DoomsdayTargets)

- **Signature**: `doomsday_maxWithdrawResetsAfterFullWithdrawal(uint256)`
- **Visibility**: public
- **Source Range**: 8551:1562:647
- **Details**: [function_doomsday_maxWithdrawResetsAfterFullWithdrawal_uint256.md](./function_doomsday_maxWithdrawResetsAfterFullWithdrawal_uint256.md)

**Signature:**
```solidity
/// @dev Property: maxWithdraw is reset to 0 after full withdrawal
function doomsday_maxWithdrawResetsAfterFullWithdrawal(uint256 assetsToDeposit) public;
```

### doomsday_fulfillDoesntOverRedeemMultipleActors(uint256[3],uint256[3]) (inherited from DoomsdayTargets)

- **Signature**: `doomsday_fulfillDoesntOverRedeemMultipleActors(uint256[3],uint256[3])`
- **Visibility**: public
- **Source Range**: 10219:2582:647
- **Details**: [function_doomsday_fulfillDoesntOverRedeemMultipleActors_uint256[3]_uint256[3].md](./function_doomsday_fulfillDoesntOverRedeemMultipleActors_uint256[3]_uint256[3].md)

**Signature:**
```solidity
/// @dev Property: fulfillRedeemRequests doesn't redeem more than requested for multiple actors
function doomsday_fulfillDoesntOverRedeemMultipleActors(uint256[3] memory sharesToMint, uint256[3] memory actorIndexes) public stateless();
```

### doomsday_primaryManagerAlwaysChangeable() (inherited from DoomsdayTargets)

- **Signature**: `doomsday_primaryManagerAlwaysChangeable()`
- **Visibility**: public
- **Source Range**: 12910:758:647
- **Details**: [function_doomsday_primaryManagerAlwaysChangeable.md](./function_doomsday_primaryManagerAlwaysChangeable.md)

**Signature:**
```solidity
/// @dev Property: primary manager can always be replaced by governance via `changePrimaryManager`
function doomsday_primaryManagerAlwaysChangeable() public;
```

### doomsday_allUsersCanWithdraw() (inherited from DoomsdayTargets)

- **Signature**: `doomsday_allUsersCanWithdraw()`
- **Visibility**: public
- **Source Range**: 14094:789:647
- **Details**: [function_doomsday_allUsersCanWithdraw.md](./function_doomsday_allUsersCanWithdraw.md)

**Signature:**
```solidity
/// @dev Property: all users can withdraw (solvency)
function doomsday_allUsersCanWithdraw() public;
```

### doomsday_cannotClaimMoreThanRequested(uint256) (inherited from DoomsdayTargets)

- **Signature**: `doomsday_cannotClaimMoreThanRequested(uint256)`
- **Visibility**: public
- **Source Range**: 14956:1307:647
- **Details**: [function_doomsday_cannotClaimMoreThanRequested_uint256.md](./function_doomsday_cannotClaimMoreThanRequested_uint256.md)

**Signature:**
```solidity
/// @dev Property: Claiming more than requested always reverts
function doomsday_cannotClaimMoreThanRequested(uint256 shares) public asActor();
```

### _executeRedeemRequestsArgs(uint256) (inherited from DoomsdayTargets)

- **Signature**: `_executeRedeemRequestsArgs(uint256)`
- **Visibility**: public
- **Source Range**: 17167:3147:647
- **Details**: [function__executeRedeemRequestsArgs_uint256.md](./function__executeRedeemRequestsArgs_uint256.md)

**Signature:**
```solidity
/// @dev Helper function to clamp the values for the function call
function _executeRedeemRequestsArgs(uint256 redeemAmount) public view returns (ISuperVaultStrategy.ExecuteArgs memory executeArgs, address[] memory controllers);
```

### switchActor(uint256) (inherited from ManagersTargets)

- **Signature**: `switchActor(uint256)`
- **Visibility**: public
- **Source Range**: 757:96:648
- **Details**: [function_switchActor_uint256.md](./function_switchActor_uint256.md)

**Signature:**
```solidity
/// @dev Start acting as another actor
///  @dev Update ghosts here to make global property checks not fail falsely
function switchActor(uint256 entropy) public updateGhosts();
```

### switch_asset(uint256) (inherited from ManagersTargets)

- **Signature**: `switch_asset(uint256)`
- **Visibility**: public
- **Source Range**: 897:84:648
- **Details**: [function_switch_asset_uint256.md](./function_switch_asset_uint256.md)

**Signature:**
```solidity
/// @dev Starts using a new asset
function switch_asset(uint256 entropy) public;
```

### add_new_asset(uint8) (inherited from ManagersTargets)

- **Signature**: `add_new_asset(uint8)`
- **Visibility**: public
- **Source Range**: 1086:144:648
- **Details**: [function_add_new_asset_uint8.md](./function_add_new_asset_uint8.md)

**Signature:**
```solidity
/// @dev Deploy a new token and add it to the list of assets, then set it as the current asset
function add_new_asset(uint8 decimals) public returns (address);
```

### switch_vault(uint256) (inherited from ManagersTargets)

- **Signature**: `switch_vault(uint256)`
- **Visibility**: public
- **Source Range**: 1384:84:648
- **Details**: [function_switch_vault_uint256.md](./function_switch_vault_uint256.md)

**Signature:**
```solidity
/// @dev Switches the current vault based on the entropy
///  @param entropy The entropy to choose a random vault in the array for switching
function switch_vault(uint256 entropy) public;
```

### add_new_vault() (inherited from ManagersTargets)

- **Signature**: `add_new_vault()`
- **Visibility**: public
- **Source Range**: 1605:78:648
- **Details**: [function_add_new_vault.md](./function_add_new_vault.md)

**Signature:**
```solidity
/// @dev Deploy a new vault using the current asset and add it to the list of vaults,
///  then set it as the current vault
function add_new_vault() public;
```

### asset_approve(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_approve(address,uint128)`
- **Visibility**: public
- **Source Range**: 2009:139:648
- **Details**: [function_asset_approve_address_uint128.md](./function_asset_approve_address_uint128.md)

**Signature:**
```solidity
/// @dev Approve to arbitrary address, uses Actor by default
///  NOTE: You're almost always better off setting approvals in `Setup`
function asset_approve(address to, uint128 amt) public updateGhosts() asActor();
```

### asset_mint(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_mint(address,uint128)`
- **Visibility**: public
- **Source Range**: 2253:133:648
- **Details**: [function_asset_mint_address_uint128.md](./function_asset_mint_address_uint128.md)

**Signature:**
```solidity
/// @dev Mint to arbitrary address, uses owner by default, even though MockERC20 doesn't check
function asset_mint(address to, uint128 amt) public updateGhosts() asAdmin();
```

### mockERC4626YieldSourceOracle_setValidAsset(address,bool) (inherited from OracleTargets)

- **Signature**: `mockERC4626YieldSourceOracle_setValidAsset(address,bool)`
- **Visibility**: public
- **Source Range**: 707:241:649
- **Details**: [function_mockERC4626YieldSourceOracle_setValidAsset_address_bool.md](./function_mockERC4626YieldSourceOracle_setValidAsset_address_bool.md)

**Signature:**
```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function mockERC4626YieldSourceOracle_setValidAsset(address asset, bool isValid) public asActor();
```

### mockERC5115YieldSourceOracle_setValidAsset(address,bool) (inherited from OracleTargets)

- **Signature**: `mockERC5115YieldSourceOracle_setValidAsset(address,bool)`
- **Visibility**: public
- **Source Range**: 954:241:649
- **Details**: [function_mockERC5115YieldSourceOracle_setValidAsset_address_bool.md](./function_mockERC5115YieldSourceOracle_setValidAsset_address_bool.md)

**Signature:**
```solidity
function mockERC5115YieldSourceOracle_setValidAsset(address asset, bool isValid) public asActor();
```

### ECDSAPPSOracle_updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs) (inherited from OracleTargets)

- **Signature**: `ECDSAPPSOracle_updatePPS(struct IECDSAPPSOracle.UpdatePPSArgs)`
- **Visibility**: public
- **Source Range**: 1290:184:649
- **Details**: [function_ECDSAPPSOracle_updatePPS_struct_IECDSAPPSOracle.UpdatePPSArgs.md](./function_ECDSAPPSOracle_updatePPS_struct_IECDSAPPSOracle.UpdatePPSArgs.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function ECDSAPPSOracle_updatePPS(IECDSAPPSOracle.UpdatePPSArgs memory args) public asActor();
```

### superVault_approve(address,uint256) (inherited from SuperVaultTargets)

- **Signature**: `superVault_approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 756:126:654
- **Details**: [function_superVault_approve_address_uint256.md](./function_superVault_approve_address_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function superVault_approve(address spender, uint256 value) public asActor();
```

### superVault_burnShares(uint256) (inherited from SuperVaultTargets)

- **Signature**: `superVault_burnShares(uint256)`
- **Visibility**: public
- **Source Range**: 888:108:654
- **Details**: [function_superVault_burnShares_uint256.md](./function_superVault_burnShares_uint256.md)

**Signature:**
```solidity
function superVault_burnShares(uint256 amount) public asActor();
```

### superVault_cancelRedeem() (inherited from SuperVaultTargets)

- **Signature**: `superVault_cancelRedeem()`
- **Visibility**: public
- **Source Range**: 1288:1624:654
- **Details**: [function_superVault_cancelRedeem.md](./function_superVault_cancelRedeem.md)

**Signature:**
```solidity
/// @dev Property: pendingRedeemRequest should be 0 after a user calls cancelRedeem
///  @dev Property: averageRequestPPS should be 0 after a user calls cancelRedeem
///  @dev Property: user shouldn't receive more than convertToAssets(pendingRedeemRequest) after cancelRedeem
function superVault_cancelRedeem() public updateGhostsWithOpType(OpType.CANCEL);
```

### superVault_deposit(uint256) (inherited from SuperVaultTargets)

- **Signature**: `superVault_deposit(uint256)`
- **Visibility**: public
- **Source Range**: 3016:432:654
- **Details**: [function_superVault_deposit_uint256.md](./function_superVault_deposit_uint256.md)

**Signature:**
```solidity
/// @dev Property: previewDeposit returns the correct amounts compared to executing a deposit
function superVault_deposit(uint256 assets) public updateGhostsWithOpType(OpType.ADD);
```

### superVault_mint(uint256) (inherited from SuperVaultTargets)

- **Signature**: `superVault_mint(uint256)`
- **Visibility**: public
- **Source Range**: 3546:413:654
- **Details**: [function_superVault_mint_uint256.md](./function_superVault_mint_uint256.md)

**Signature:**
```solidity
/// @dev Property: previewMint returns the correct amounts compared to executing a mint
function superVault_mint(uint256 shares) public updateGhostsWithOpType(OpType.ADD);
```

### superVault_invalidateNonce(bytes32) (inherited from SuperVaultTargets)

- **Signature**: `superVault_invalidateNonce(bytes32)`
- **Visibility**: public
- **Source Range**: 3965:116:654
- **Details**: [function_superVault_invalidateNonce_bytes32.md](./function_superVault_invalidateNonce_bytes32.md)

**Signature:**
```solidity
function superVault_invalidateNonce(bytes32 nonce) public asActor();
```

### superVault_redeem(uint256) (inherited from SuperVaultTargets)

- **Signature**: `superVault_redeem(uint256)`
- **Visibility**: public
- **Source Range**: 4087:178:654
- **Details**: [function_superVault_redeem_uint256.md](./function_superVault_redeem_uint256.md)

**Signature:**
```solidity
function superVault_redeem(uint256 shares) public updateGhostsWithOpType(OpType.REMOVE) asActor();
```

### superVault_withdraw(uint256) (inherited from SuperVaultTargets)

- **Signature**: `superVault_withdraw(uint256)`
- **Visibility**: public
- **Source Range**: 4271:182:654
- **Details**: [function_superVault_withdraw_uint256.md](./function_superVault_withdraw_uint256.md)

**Signature:**
```solidity
function superVault_withdraw(uint256 assets) public updateGhostsWithOpType(OpType.REMOVE) asActor();
```

### superVault_requestRedeem(uint256) (inherited from SuperVaultTargets)

- **Signature**: `superVault_requestRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 4459:193:654
- **Details**: [function_superVault_requestRedeem_uint256.md](./function_superVault_requestRedeem_uint256.md)

**Signature:**
```solidity
function superVault_requestRedeem(uint256 shares) public updateGhostsWithOpType(OpType.REQUEST) asActor();
```

### superVault_setOperator(uint256,bool) (inherited from SuperVaultTargets)

- **Signature**: `superVault_setOperator(uint256,bool)`
- **Visibility**: public
- **Source Range**: 4658:213:654
- **Details**: [function_superVault_setOperator_uint256_bool.md](./function_superVault_setOperator_uint256_bool.md)

**Signature:**
```solidity
function superVault_setOperator(uint256 entropy, bool approved) public asActor();
```

### superVault_transfer(uint256,uint256) (inherited from SuperVaultTargets)

- **Signature**: `superVault_transfer(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4993:548:654
- **Details**: [function_superVault_transfer_uint256_uint256.md](./function_superVault_transfer_uint256_uint256.md)

**Signature:**
```solidity
/// @dev Propery: _update should never revert
function superVault_transfer(uint256 entropy, uint256 value) public updateGhostsWithOpType(OpType.TRANSFER);
```

### superVault_transferFrom(uint256,uint256,uint256) (inherited from SuperVaultTargets)

- **Signature**: `superVault_transferFrom(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 5663:850:654
- **Details**: [function_superVault_transferFrom_uint256_uint256_uint256.md](./function_superVault_transferFrom_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// @dev Propery: _update should never revert
function superVault_transferFrom(uint256 entropyFrom, uint256 entropyTo, uint256 value) public updateGhostsWithOpType(OpType.TRANSFER);
```

### superVaultAggregator_addSecondaryManager(address,address) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_addSecondaryManager(address,address)`
- **Visibility**: public
- **Source Range**: 708:198:651
- **Details**: [function_superVaultAggregator_addSecondaryManager_address_address.md](./function_superVaultAggregator_addSecondaryManager_address_address.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function superVaultAggregator_addSecondaryManager(address strategy, address manager) public asActor();
```

### superVaultAggregator_claimUpkeep(uint256) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_claimUpkeep(uint256)`
- **Visibility**: public
- **Source Range**: 1593:130:651
- **Details**: [function_superVaultAggregator_claimUpkeep_uint256.md](./function_superVaultAggregator_claimUpkeep_uint256.md)

**Signature:**
```solidity
/// @dev irrelevant for testing because we're bypassing hook validation
function superVaultAggregator_claimUpkeep(uint256 amount) public asActor();
```

### superVaultAggregator_createVault(struct ISuperVaultAggregator.VaultCreationParams) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_createVault(struct ISuperVaultAggregator.VaultCreationParams)`
- **Visibility**: public
- **Source Range**: 1729:498:651
- **Details**: [function_superVaultAggregator_createVault_struct_ISuperVaultAggregator.VaultCreationParams.md](./function_superVaultAggregator_createVault_struct_ISuperVaultAggregator.VaultCreationParams.md)

**Signature:**
```solidity
function superVaultAggregator_createVault(ISuperVaultAggregator.VaultCreationParams memory params) public asActor();
```

### superVaultAggregator_depositUpkeep(uint256) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_depositUpkeep(uint256)`
- **Visibility**: public
- **Source Range**: 2233:147:651
- **Details**: [function_superVaultAggregator_depositUpkeep_uint256.md](./function_superVaultAggregator_depositUpkeep_uint256.md)

**Signature:**
```solidity
function superVaultAggregator_depositUpkeep(uint256 amount) public asActor();
```

### superVaultAggregator_executeChangePrimaryManager(address) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_executeChangePrimaryManager(address)`
- **Visibility**: public
- **Source Range**: 2386:180:651
- **Details**: [function_superVaultAggregator_executeChangePrimaryManager_address.md](./function_superVaultAggregator_executeChangePrimaryManager_address.md)

**Signature:**
```solidity
function superVaultAggregator_executeChangePrimaryManager(address strategy) public asActor();
```

### superVaultAggregator_proposeChangePrimaryManager(address,address,address) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_proposeChangePrimaryManager(address,address,address)`
- **Visibility**: public
- **Source Range**: 3141:310:651
- **Details**: [function_superVaultAggregator_proposeChangePrimaryManager_address_address_address.md](./function_superVaultAggregator_proposeChangePrimaryManager_address_address_address.md)

**Signature:**
```solidity
/// @dev removed because only callable by oracle
function superVaultAggregator_proposeChangePrimaryManager(address strategy, address newManager, address feeRecipient) public asActor();
```

### superVaultAggregator_cancelChangePrimaryManager(address) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_cancelChangePrimaryManager(address)`
- **Visibility**: public
- **Source Range**: 3457:178:651
- **Details**: [function_superVaultAggregator_cancelChangePrimaryManager_address.md](./function_superVaultAggregator_cancelChangePrimaryManager_address.md)

**Signature:**
```solidity
function superVaultAggregator_cancelChangePrimaryManager(address strategy) public asActor();
```

### superVaultAggregator_removeSecondaryManager(address,address) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_removeSecondaryManager(address,address)`
- **Visibility**: public
- **Source Range**: 3934:204:651
- **Details**: [function_superVaultAggregator_removeSecondaryManager_address_address.md](./function_superVaultAggregator_removeSecondaryManager_address_address.md)

**Signature:**
```solidity
/// @dev removed because we're bypassing hook validation
function superVaultAggregator_removeSecondaryManager(address strategy, address manager) public asActor();
```

### superVaultAggregator_updateDeviationThreshold(address,uint256) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_updateDeviationThreshold(address,uint256)`
- **Visibility**: public
- **Source Range**: 4144:266:651
- **Details**: [function_superVaultAggregator_updateDeviationThreshold_address_uint256.md](./function_superVaultAggregator_updateDeviationThreshold_address_uint256.md)

**Signature:**
```solidity
function superVaultAggregator_updateDeviationThreshold(address strategy, uint256 deviationThreshold_) public asActor();
```

### superVaultAggregator_proposeWithdrawUpkeep(address) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_proposeWithdrawUpkeep(address)`
- **Visibility**: public
- **Source Range**: 4416:168:651
- **Details**: [function_superVaultAggregator_proposeWithdrawUpkeep_address.md](./function_superVaultAggregator_proposeWithdrawUpkeep_address.md)

**Signature:**
```solidity
function superVaultAggregator_proposeWithdrawUpkeep(address strategy) public asActor();
```

### superVaultAggregator_executeWithdrawUpkeep(address) (inherited from SuperVaultAggregatorTargets)

- **Signature**: `superVaultAggregator_executeWithdrawUpkeep(address)`
- **Visibility**: public
- **Source Range**: 4590:168:651
- **Details**: [function_superVaultAggregator_executeWithdrawUpkeep_address.md](./function_superVaultAggregator_executeWithdrawUpkeep_address.md)

**Signature:**
```solidity
function superVaultAggregator_executeWithdrawUpkeep(address strategy) public asActor();
```

### superVaultEscrow_escrowShares(address,uint256) (inherited from SuperVaultEscrowTargets)

- **Signature**: `superVaultEscrow_escrowShares(address,uint256)`
- **Visibility**: public
- **Source Range**: 634:144:652
- **Details**: [function_superVaultEscrow_escrowShares_address_uint256.md](./function_superVaultEscrow_escrowShares_address_uint256.md)

**Signature:**
```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
///  AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function superVaultEscrow_escrowShares(address from, uint256 amount) public asActor();
```

### superVaultEscrow_initialize(address) (inherited from SuperVaultEscrowTargets)

- **Signature**: `superVaultEscrow_initialize(address)`
- **Visibility**: public
- **Source Range**: 784:132:652
- **Details**: [function_superVaultEscrow_initialize_address.md](./function_superVaultEscrow_initialize_address.md)

**Signature:**
```solidity
function superVaultEscrow_initialize(address vaultAddress) public asActor();
```

### superVaultEscrow_returnShares(address,uint256) (inherited from SuperVaultEscrowTargets)

- **Signature**: `superVaultEscrow_returnShares(address,uint256)`
- **Visibility**: public
- **Source Range**: 922:140:652
- **Details**: [function_superVaultEscrow_returnShares_address_uint256.md](./function_superVaultEscrow_returnShares_address_uint256.md)

**Signature:**
```solidity
function superVaultEscrow_returnShares(address to, uint256 amount) public asActor();
```

### superVaultStrategy_executeVaultFeeConfigUpdate() (inherited from SuperVaultStrategyTargets)

- **Signature**: `superVaultStrategy_executeVaultFeeConfigUpdate()`
- **Visibility**: public
- **Source Range**: 730:138:653
- **Details**: [function_superVaultStrategy_executeVaultFeeConfigUpdate.md](./function_superVaultStrategy_executeVaultFeeConfigUpdate.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function superVaultStrategy_executeVaultFeeConfigUpdate() public asActor();
```

### superVaultStrategy_handleOperations4626Deposit(address,uint256) (inherited from SuperVaultStrategyTargets)

- **Signature**: `superVaultStrategy_handleOperations4626Deposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 874:222:653
- **Details**: [function_superVaultStrategy_handleOperations4626Deposit_address_uint256.md](./function_superVaultStrategy_handleOperations4626Deposit_address_uint256.md)

**Signature:**
```solidity
function superVaultStrategy_handleOperations4626Deposit(address controller, uint256 assetsGross) public asActor();
```

### superVaultStrategy_handleOperations4626Mint(address,uint256,uint256,uint256) (inherited from SuperVaultStrategyTargets)

- **Signature**: `superVaultStrategy_handleOperations4626Mint(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1102:350:653
- **Details**: [function_superVaultStrategy_handleOperations4626Mint_address_uint256_uint256_uint256.md](./function_superVaultStrategy_handleOperations4626Mint_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function superVaultStrategy_handleOperations4626Mint(address controller, uint256 sharesNet, uint256 assetsGross, uint256 assetsNet) public asActor();
```

### superVaultStrategy_handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256) (inherited from SuperVaultStrategyTargets)

- **Signature**: `superVaultStrategy_handleOperations7540(enum ISuperVaultStrategy.Operation,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1458:352:653
- **Details**: [function_superVaultStrategy_handleOperations7540_enum_ISuperVaultStrategy.Operation_address_address_uint256.md](./function_superVaultStrategy_handleOperations7540_enum_ISuperVaultStrategy.Operation_address_address_uint256.md)

**Signature:**
```solidity
function superVaultStrategy_handleOperations7540(ISuperVaultStrategy.Operation operation, address controller, address receiver, uint256 amount) public asActor();
```

### superVaultStrategy_manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction) (inherited from SuperVaultStrategyTargets)

- **Signature**: `superVaultStrategy_manageYieldSource(address,address,enum ISuperVaultStrategy.YieldSourceAction)`
- **Visibility**: public
- **Source Range**: 1816:254:653
- **Details**: [function_superVaultStrategy_manageYieldSource_address_address_enum_ISuperVaultStrategy.YieldSourceAction.md](./function_superVaultStrategy_manageYieldSource_address_address_enum_ISuperVaultStrategy.YieldSourceAction.md)

**Signature:**
```solidity
function superVaultStrategy_manageYieldSource(address source, address oracle, ISuperVaultStrategy.YieldSourceAction actionType) public asActor();
```

### superVaultStrategy_manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[]) (inherited from SuperVaultStrategyTargets)

- **Signature**: `superVaultStrategy_manageYieldSources(address[],address[],enum ISuperVaultStrategy.YieldSourceAction[])`
- **Visibility**: public
- **Source Range**: 2076:289:653
- **Details**: [function_superVaultStrategy_manageYieldSources_address[]_address[]_enum_ISuperVaultStrategy.YieldSourceAction[].md](./function_superVaultStrategy_manageYieldSources_address[]_address[]_enum_ISuperVaultStrategy.YieldSourceAction[].md)

**Signature:**
```solidity
function superVaultStrategy_manageYieldSources(address[] memory sources, address[] memory oracles, ISuperVaultStrategy.YieldSourceAction[] memory actionTypes) public asActor();
```

### superVaultStrategy_proposeVaultFeeConfigUpdate(uint256,uint256,address) (inherited from SuperVaultStrategyTargets)

- **Signature**: `superVaultStrategy_proposeVaultFeeConfigUpdate(uint256,uint256,address)`
- **Visibility**: public
- **Source Range**: 2371:330:653
- **Details**: [function_superVaultStrategy_proposeVaultFeeConfigUpdate_uint256_uint256_address.md](./function_superVaultStrategy_proposeVaultFeeConfigUpdate_uint256_uint256_address.md)

**Signature:**
```solidity
function superVaultStrategy_proposeVaultFeeConfigUpdate(uint256 performanceFeeBps, uint256 managementFeeBps, address recipient) public asActor();
```

### superGovernor_proposeFee(enum FeeType,uint256) (inherited from SuperGovernorTargets)

- **Signature**: `superGovernor_proposeFee(enum FeeType,uint256)`
- **Visibility**: public
- **Source Range**: 485:160:650
- **Details**: [function_superGovernor_proposeFee_enum_FeeType_uint256.md](./function_superGovernor_proposeFee_enum_FeeType_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function superGovernor_proposeFee(FeeType feeType, uint256 value) public asAdmin();
```

### superGovernor_executeFeeUpdate(enum FeeType) (inherited from SuperGovernorTargets)

- **Signature**: `superGovernor_executeFeeUpdate(enum FeeType)`
- **Visibility**: public
- **Source Range**: 651:128:650
- **Details**: [function_superGovernor_executeFeeUpdate_enum_FeeType.md](./function_superGovernor_executeFeeUpdate_enum_FeeType.md)

**Signature:**
```solidity
function superGovernor_executeFeeUpdate(FeeType feeType) public asAdmin();
```

### superGovernor_proposeMinStaleness(uint256) (inherited from SuperGovernorTargets)

- **Signature**: `superGovernor_proposeMinStaleness(uint256)`
- **Visibility**: public
- **Source Range**: 785:164:650
- **Details**: [function_superGovernor_proposeMinStaleness_uint256.md](./function_superGovernor_proposeMinStaleness_uint256.md)

**Signature:**
```solidity
function superGovernor_proposeMinStaleness(uint256 newMinStaleness) public asAdmin();
```

### superGovernor_executeMinStalenessChange() (inherited from SuperGovernorTargets)

- **Signature**: `superGovernor_executeMinStalenessChange()`
- **Visibility**: public
- **Source Range**: 955:124:650
- **Details**: [function_superGovernor_executeMinStalenessChange.md](./function_superGovernor_executeMinStalenessChange.md)

**Signature:**
```solidity
function superGovernor_executeMinStalenessChange() public asAdmin();
```

### superGovernor_executeUpkeepClaim(uint256) (inherited from SuperGovernorTargets)

- **Signature**: `superGovernor_executeUpkeepClaim(uint256)`
- **Visibility**: public
- **Source Range**: 1085:130:650
- **Details**: [function_superGovernor_executeUpkeepClaim_uint256.md](./function_superGovernor_executeUpkeepClaim_uint256.md)

**Signature:**
```solidity
function superGovernor_executeUpkeepClaim(uint256 amount) public asAdmin();
```

### superGovernor_proposeUpkeepPaymentsChange(bool) (inherited from SuperGovernorTargets)

- **Signature**: `superGovernor_proposeUpkeepPaymentsChange(bool)`
- **Visibility**: public
- **Source Range**: 1221:161:650
- **Details**: [function_superGovernor_proposeUpkeepPaymentsChange_bool.md](./function_superGovernor_proposeUpkeepPaymentsChange_bool.md)

**Signature:**
```solidity
function superGovernor_proposeUpkeepPaymentsChange(bool enabled) public asAdmin();
```

### superGovernor_executeUpkeepPaymentsChange() (inherited from SuperGovernorTargets)

- **Signature**: `superGovernor_executeUpkeepPaymentsChange()`
- **Visibility**: public
- **Source Range**: 1388:128:650
- **Details**: [function_superGovernor_executeUpkeepPaymentsChange.md](./function_superGovernor_executeUpkeepPaymentsChange.md)

**Signature:**
```solidity
function superGovernor_executeUpkeepPaymentsChange() public asAdmin();
```

### superGovernor_proposeGlobalHooksRoot(bytes32) (inherited from SuperGovernorTargets)

- **Signature**: `superGovernor_proposeGlobalHooksRoot(bytes32)`
- **Visibility**: public
- **Source Range**: 1522:154:650
- **Details**: [function_superGovernor_proposeGlobalHooksRoot_bytes32.md](./function_superGovernor_proposeGlobalHooksRoot_bytes32.md)

**Signature:**
```solidity
function superGovernor_proposeGlobalHooksRoot(bytes32 newRoot) public asAdmin();
```

### yieldSource_approve(address,uint256) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 977:591:655
- **Details**: [function_yieldSource_approve_address_uint256.md](./function_yieldSource_approve_address_uint256.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
///  ERC20 functions (available across all types as they inherit from MockERC20) ///
function yieldSource_approve(address spender, uint256 value) public asActor();
```

### yieldSource_setDecimalsOffset(uint8) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_setDecimalsOffset(uint8)`
- **Visibility**: public
- **Source Range**: 1574:430:655
- **Details**: [function_yieldSource_setDecimalsOffset_uint8.md](./function_yieldSource_setDecimalsOffset_uint8.md)

**Signature:**
```solidity
function yieldSource_setDecimalsOffset(uint8 targetDecimalsOffset) public asActor();
```

### yieldSource_transfer(address,uint256) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 2010:575:655
- **Details**: [function_yieldSource_transfer_address_uint256.md](./function_yieldSource_transfer_address_uint256.md)

**Signature:**
```solidity
function yieldSource_transfer(address to, uint256 value) public asActor();
```

### yieldSource_transferFrom(address,address,uint256) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 2591:623:655
- **Details**: [function_yieldSource_transferFrom_address_address_uint256.md](./function_yieldSource_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function yieldSource_transferFrom(address from, address to, uint256 value) public asActor();
```

### yieldSource_deposit(uint256,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_deposit(uint256,address)`
- **Visibility**: public
- **Source Range**: 3276:491:655
- **Details**: [function_yieldSource_deposit_uint256_address.md](./function_yieldSource_deposit_uint256_address.md)

**Signature:**
```solidity
/// Core Vault Functions (ERC4626/ERC4626-like) ///
function yieldSource_deposit(uint256 assets, address receiver) public asActor();
```

### yieldSource_mint(uint256,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 3773:511:655
- **Details**: [function_yieldSource_mint_uint256_address.md](./function_yieldSource_mint_uint256_address.md)

**Signature:**
```solidity
function yieldSource_mint(uint256 shares, address receiver) public asActor();
```

### yieldSource_withdraw(uint256,address,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 4290:556:655
- **Details**: [function_yieldSource_withdraw_uint256_address_address.md](./function_yieldSource_withdraw_uint256_address_address.md)

**Signature:**
```solidity
function yieldSource_withdraw(uint256 assets, address receiver, address owner) public asActor();
```

### yieldSource_redeem(uint256,address,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 4852:570:655
- **Details**: [function_yieldSource_redeem_uint256_address_address.md](./function_yieldSource_redeem_uint256_address_address.md)

**Signature:**
```solidity
function yieldSource_redeem(uint256 shares, address receiver, address owner) public asActor();
```

### yieldSource_deposit5115(address,address,uint256,uint256,bool) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_deposit5115(address,address,uint256,uint256,bool)`
- **Visibility**: public
- **Source Range**: 5467:575:655
- **Details**: [function_yieldSource_deposit5115_address_address_uint256_uint256_bool.md](./function_yieldSource_deposit5115_address_address_uint256_uint256_bool.md)

**Signature:**
```solidity
/// ERC5115-specific functions ///
function yieldSource_deposit5115(address receiver, address tokenIn, uint256 amountTokenToDeposit, uint256 minSharesOut, bool depositFromInternalBalance) public asActor();
```

### yieldSource_redeem5115(address,uint256,address,uint256,bool) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_redeem5115(address,uint256,address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 6048:567:655
- **Details**: [function_yieldSource_redeem5115_address_uint256_address_uint256_bool.md](./function_yieldSource_redeem5115_address_uint256_address_uint256_bool.md)

**Signature:**
```solidity
function yieldSource_redeem5115(address receiver, uint256 amountSharesToRedeem, address tokenOut, uint256 minTokenOut, bool burnFromInternalBalance) public asActor();
```

### yieldSource_setOperator(address,bool) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_setOperator(address,bool)`
- **Visibility**: public
- **Source Range**: 6660:346:655
- **Details**: [function_yieldSource_setOperator_address_bool.md](./function_yieldSource_setOperator_address_bool.md)

**Signature:**
```solidity
/// ERC7540-specific functions ///
function yieldSource_setOperator(address operator, bool approved) public asActor();
```

### yieldSource_requestDeposit(uint256,address,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_requestDeposit(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 7012:377:655
- **Details**: [function_yieldSource_requestDeposit_uint256_address_address.md](./function_yieldSource_requestDeposit_uint256_address_address.md)

**Signature:**
```solidity
function yieldSource_requestDeposit(uint256 assets, address controller, address owner) public asActor();
```

### yieldSource_requestRedeem(uint256,address,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_requestRedeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 7395:375:655
- **Details**: [function_yieldSource_requestRedeem_uint256_address_address.md](./function_yieldSource_requestRedeem_uint256_address_address.md)

**Signature:**
```solidity
function yieldSource_requestRedeem(uint256 shares, address controller, address owner) public asActor();
```

### yieldSource_cancelDepositRequest(uint256,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_cancelDepositRequest(uint256,address)`
- **Visibility**: public
- **Source Range**: 7776:373:655
- **Details**: [function_yieldSource_cancelDepositRequest_uint256_address.md](./function_yieldSource_cancelDepositRequest_uint256_address.md)

**Signature:**
```solidity
function yieldSource_cancelDepositRequest(uint256 requestId, address controller) public asActor();
```

### yieldSource_cancelRedeemRequest(uint256,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_cancelRedeemRequest(uint256,address)`
- **Visibility**: public
- **Source Range**: 8155:371:655
- **Details**: [function_yieldSource_cancelRedeemRequest_uint256_address.md](./function_yieldSource_cancelRedeemRequest_uint256_address.md)

**Signature:**
```solidity
function yieldSource_cancelRedeemRequest(uint256 requestId, address controller) public asActor();
```

### yieldSource_claimCancelDepositRequest(uint256,address,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_claimCancelDepositRequest(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 8532:461:655
- **Details**: [function_yieldSource_claimCancelDepositRequest_uint256_address_address.md](./function_yieldSource_claimCancelDepositRequest_uint256_address_address.md)

**Signature:**
```solidity
function yieldSource_claimCancelDepositRequest(uint256 requestId, address receiver, address controller) public asActor();
```

### yieldSource_claimCancelRedeemRequest(uint256,address,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_claimCancelRedeemRequest(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 8999:459:655
- **Details**: [function_yieldSource_claimCancelRedeemRequest_uint256_address_address.md](./function_yieldSource_claimCancelRedeemRequest_uint256_address_address.md)

**Signature:**
```solidity
function yieldSource_claimCancelRedeemRequest(uint256 requestId, address receiver, address controller) public asActor();
```

### yieldSource_deposit7540(uint256,address,address) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_deposit7540(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 9464:373:655
- **Details**: [function_yieldSource_deposit7540_uint256_address_address.md](./function_yieldSource_deposit7540_uint256_address_address.md)

**Signature:**
```solidity
function yieldSource_deposit7540(uint256 assets, address receiver, address controller) public asActor();
```

### yieldSource_setRevertBehavior4626(uint8,uint8) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_setRevertBehavior4626(uint8,uint8)`
- **Visibility**: public
- **Source Range**: 9897:399:655
- **Details**: [function_yieldSource_setRevertBehavior4626_uint8_uint8.md](./function_yieldSource_setRevertBehavior4626_uint8_uint8.md)

**Signature:**
```solidity
/// Testing-specific functions (ERC4626 only) ///
function yieldSource_setRevertBehavior4626(uint8 functionType, uint8 revertType) public asActor();
```

### yieldSource_setRevertBehavior5115(uint8) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_setRevertBehavior5115(uint8)`
- **Visibility**: public
- **Source Range**: 10356:355:655
- **Details**: [function_yieldSource_setRevertBehavior5115_uint8.md](./function_yieldSource_setRevertBehavior5115_uint8.md)

**Signature:**
```solidity
/// Testing-specific functions (ERC5115 only) ///
function yieldSource_setRevertBehavior5115(uint8 revertType) public asActor();
```

### yieldSource_simulateLoss(uint256) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_simulateLoss(uint256)`
- **Visibility**: public
- **Source Range**: 10766:579:655
- **Details**: [function_yieldSource_simulateLoss_uint256.md](./function_yieldSource_simulateLoss_uint256.md)

**Signature:**
```solidity
/// Common yield manipulation functions ///
function yieldSource_simulateLoss(uint256 lossAmount) public;
```

### yieldSource_simulateGain(uint256) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_simulateGain(uint256)`
- **Visibility**: public
- **Source Range**: 11351:579:655
- **Details**: [function_yieldSource_simulateGain_uint256.md](./function_yieldSource_simulateGain_uint256.md)

**Signature:**
```solidity
function yieldSource_simulateGain(uint256 gainAmount) public;
```

### yieldSource_setLossOnWithdraw(uint256) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_setLossOnWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 11936:623:655
- **Details**: [function_yieldSource_setLossOnWithdraw_uint256.md](./function_yieldSource_setLossOnWithdraw_uint256.md)

**Signature:**
```solidity
function yieldSource_setLossOnWithdraw(uint256 lossOnWithdraw) public asActor();
```

### yieldSource_switchToERC4626() (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_switchToERC4626()`
- **Visibility**: public
- **Source Range**: 12611:126:655
- **Details**: [function_yieldSource_switchToERC4626.md](./function_yieldSource_switchToERC4626.md)

**Signature:**
```solidity
/// Yield source management functions ///
function yieldSource_switchToERC4626() public;
```

### yieldSource_switchToERC5115() (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_switchToERC5115()`
- **Visibility**: public
- **Source Range**: 12743:127:655
- **Details**: [function_yieldSource_switchToERC5115.md](./function_yieldSource_switchToERC5115.md)

**Signature:**
```solidity
function yieldSource_switchToERC5115() public;
```

### yieldSource_switchToERC7540() (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_switchToERC7540()`
- **Visibility**: public
- **Source Range**: 12876:126:655
- **Details**: [function_yieldSource_switchToERC7540.md](./function_yieldSource_switchToERC7540.md)

**Signature:**
```solidity
function yieldSource_switchToERC7540() public;
```

### yieldSource_switchRandom(uint256) (inherited from YieldSourceTargets)

- **Signature**: `yieldSource_switchRandom(uint256)`
- **Visibility**: public
- **Source Range**: 13008:170:655
- **Details**: [function_yieldSource_switchRandom_uint256.md](./function_yieldSource_switchRandom_uint256.md)

**Signature:**
```solidity
function yieldSource_switchRandom(uint256 entropy) public;
```
