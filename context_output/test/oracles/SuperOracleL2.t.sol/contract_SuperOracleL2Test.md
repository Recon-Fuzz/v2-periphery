# Contract: SuperOracleL2Test

## Metadata

- **Name**: SuperOracleL2Test
- **Type**: Contract
- **Path**: test/oracles/SuperOracleL2.t.sol

## State Variables

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

### owner

```solidity
address public owner
```

### user

```solidity
address public user
```

### oracle

```solidity
SuperOracleL2 public oracle
```

**SuperOracleL2**: [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

### dataFeed

```solidity
MockAggregator public dataFeed
```

**MockAggregator**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

### uptimeFeed

```solidity
MockL2Sequencer public uptimeFeed
```

**MockL2Sequencer**: [test/mocks/MockL2Sequencer.sol/contract_MockL2Sequencer.md]

### baseToken

```solidity
MockERC20 public baseToken
```

**MockERC20**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

### quoteToken

```solidity
MockERC20 public quoteToken
```

**MockERC20**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

### CHAINLINK_PROVIDER

```solidity
bytes32 public constant CHAINLINK_PROVIDER = keccak256("CHAINLINK")
```

### PRICE_DECIMALS

```solidity
uint256 public constant PRICE_DECIMALS = 8
```

### INITIAL_PRICE

```solidity
uint256 public constant INITIAL_PRICE = 2000 * (10 ** PRICE_DECIMALS)
```

### GRACE_PERIOD

```solidity
uint256 public constant GRACE_PERIOD = 3600
```

### DEFAULT_STALENESS

```solidity
uint256 public constant DEFAULT_STALENESS = 86_400
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

### UptimeFeedSet

```solidity
event UptimeFeedSet(address indexed dataOracle, address indexed uptimeOracle);
```

### GracePeriodSet

```solidity
event GracePeriodSet(address indexed uptimeOracle, uint256 gracePeriod);
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
- **Source Range**: 1357:2170:625
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() public;
```

### test_Constructor()

- **Signature**: `test_Constructor()`
- **Visibility**: public
- **Source Range**: 3715:588:625
- **Details**: [function_test_Constructor.md](./function_test_Constructor.md)

**Signature:**
```solidity
function test_Constructor() public view;
```

### test_Constructor_NulledInput_Reverts()

- **Signature**: `test_Constructor_NulledInput_Reverts()`
- **Visibility**: public
- **Source Range**: 4309:754:625
- **Details**: [function_test_Constructor_NulledInput_Reverts.md](./function_test_Constructor_NulledInput_Reverts.md)

**Signature:**
```solidity
function test_Constructor_NulledInput_Reverts() public;
```

### test_SetUptimeFeed()

- **Signature**: `test_SetUptimeFeed()`
- **Visibility**: public
- **Source Range**: 5253:921:625
- **Details**: [function_test_SetUptimeFeed.md](./function_test_SetUptimeFeed.md)

**Signature:**
```solidity
function test_SetUptimeFeed() public;
```

### test_SetUptimeFeed_OnlyOwner()

- **Signature**: `test_SetUptimeFeed_OnlyOwner()`
- **Visibility**: public
- **Source Range**: 6180:661:625
- **Details**: [function_test_SetUptimeFeed_OnlyOwner.md](./function_test_SetUptimeFeed_OnlyOwner.md)

**Signature:**
```solidity
function test_SetUptimeFeed_OnlyOwner() public;
```

### test_SetUptimeFeed_ZeroAddressReverts()

- **Signature**: `test_SetUptimeFeed_ZeroAddressReverts()`
- **Visibility**: public
- **Source Range**: 6847:787:625
- **Details**: [function_test_SetUptimeFeed_ZeroAddressReverts.md](./function_test_SetUptimeFeed_ZeroAddressReverts.md)

**Signature:**
```solidity
function test_SetUptimeFeed_ZeroAddressReverts() public;
```

### test_SetUptimeFeed_GracePeriodTooLow_Reverts()

- **Signature**: `test_SetUptimeFeed_GracePeriodTooLow_Reverts()`
- **Visibility**: public
- **Source Range**: 7640:1619:625
- **Details**: [function_test_SetUptimeFeed_GracePeriodTooLow_Reverts.md](./function_test_SetUptimeFeed_GracePeriodTooLow_Reverts.md)

**Signature:**
```solidity
function test_SetUptimeFeed_GracePeriodTooLow_Reverts() public;
```

### test_BatchSetUptimeFeed_RevertsOnEmptyArray()

- **Signature**: `test_BatchSetUptimeFeed_RevertsOnEmptyArray()`
- **Visibility**: public
- **Source Range**: 9419:491:625
- **Details**: [function_test_BatchSetUptimeFeed_RevertsOnEmptyArray.md](./function_test_BatchSetUptimeFeed_RevertsOnEmptyArray.md)

**Signature:**
```solidity
/// @notice Tests batchSetUptimeFeed reverts with empty arrays
///  @dev Covers SuperOracleL2.sol:61 - if (length == 0) revert ZERO_ARRAY_LENGTH()
function test_BatchSetUptimeFeed_RevertsOnEmptyArray() public;
```

### test_BatchSetUptimeFeed_RevertsOnUptimeOraclesMismatch()

- **Signature**: `test_BatchSetUptimeFeed_RevertsOnUptimeOraclesMismatch()`
- **Visibility**: public
- **Source Range**: 10101:713:625
- **Details**: [function_test_BatchSetUptimeFeed_RevertsOnUptimeOraclesMismatch.md](./function_test_BatchSetUptimeFeed_RevertsOnUptimeOraclesMismatch.md)

**Signature:**
```solidity
/// @notice Tests batchSetUptimeFeed reverts when uptimeOracles array length doesn't match
///  @dev Covers SuperOracleL2.sol:62-63 - array length mismatch check (uptimeOracles)
function test_BatchSetUptimeFeed_RevertsOnUptimeOraclesMismatch() public;
```

### test_BatchSetUptimeFeed_RevertsOnGracePeriodsMismatch()

- **Signature**: `test_BatchSetUptimeFeed_RevertsOnGracePeriodsMismatch()`
- **Visibility**: public
- **Source Range**: 11003:720:625
- **Details**: [function_test_BatchSetUptimeFeed_RevertsOnGracePeriodsMismatch.md](./function_test_BatchSetUptimeFeed_RevertsOnGracePeriodsMismatch.md)

**Signature:**
```solidity
/// @notice Tests batchSetUptimeFeed reverts when gracePeriods array length doesn't match
///  @dev Covers SuperOracleL2.sol:62-63 - array length mismatch check (gracePeriods)
function test_BatchSetUptimeFeed_RevertsOnGracePeriodsMismatch() public;
```

### test_BatchSetUptimeFeed_RevertsOnBothArraysMismatch()

- **Signature**: `test_BatchSetUptimeFeed_RevertsOnBothArraysMismatch()`
- **Visibility**: public
- **Source Range**: 11897:766:625
- **Details**: [function_test_BatchSetUptimeFeed_RevertsOnBothArraysMismatch.md](./function_test_BatchSetUptimeFeed_RevertsOnBothArraysMismatch.md)

**Signature:**
```solidity
/// @notice Tests batchSetUptimeFeed reverts when both arrays have mismatched lengths
///  @dev Covers SuperOracleL2.sol:62-63 - both conditions in OR statement
function test_BatchSetUptimeFeed_RevertsOnBothArraysMismatch() public;
```

### test_BatchSetUptimeFeed_SucceedsWithMultipleEntries()

- **Signature**: `test_BatchSetUptimeFeed_SucceedsWithMultipleEntries()`
- **Visibility**: public
- **Source Range**: 12822:1624:625
- **Details**: [function_test_BatchSetUptimeFeed_SucceedsWithMultipleEntries.md](./function_test_BatchSetUptimeFeed_SucceedsWithMultipleEntries.md)

**Signature:**
```solidity
/// @notice Tests batchSetUptimeFeed succeeds with multiple valid entries
///  @dev Tests loop iteration through multiple valid entries (line 66)
function test_BatchSetUptimeFeed_SucceedsWithMultipleEntries() public;
```

### test_BatchSetUptimeFeed_WithMinimumGracePeriod()

- **Signature**: `test_BatchSetUptimeFeed_WithMinimumGracePeriod()`
- **Visibility**: public
- **Source Range**: 14613:585:625
- **Details**: [function_test_BatchSetUptimeFeed_WithMinimumGracePeriod.md](./function_test_BatchSetUptimeFeed_WithMinimumGracePeriod.md)

**Signature:**
```solidity
/// @notice Tests batchSetUptimeFeed with exactly MIN_GRACE_PERIOD_TIME boundary
///  @dev Tests boundary condition for grace period validation (line 70)
function test_BatchSetUptimeFeed_WithMinimumGracePeriod() public;
```

### test_BatchSetUptimeFeed_WithGracePeriodBelowMinimum()

- **Signature**: `test_BatchSetUptimeFeed_WithGracePeriodBelowMinimum()`
- **Visibility**: public
- **Source Range**: 15358:634:625
- **Details**: [function_test_BatchSetUptimeFeed_WithGracePeriodBelowMinimum.md](./function_test_BatchSetUptimeFeed_WithGracePeriodBelowMinimum.md)

**Signature:**
```solidity
/// @notice Tests batchSetUptimeFeed with grace period just below minimum
///  @dev Tests boundary condition for grace period validation (line 70)
function test_BatchSetUptimeFeed_WithGracePeriodBelowMinimum() public;
```

### test_BatchSetUptimeFeed_EmitsEvents()

- **Signature**: `test_BatchSetUptimeFeed_EmitsEvents()`
- **Visibility**: public
- **Source Range**: 16143:1082:625
- **Details**: [function_test_BatchSetUptimeFeed_EmitsEvents.md](./function_test_BatchSetUptimeFeed_EmitsEvents.md)

**Signature:**
```solidity
/// @notice Tests batchSetUptimeFeed event emissions
///  @dev Verifies UptimeFeedSet and GracePeriodSet events are emitted (lines 77-78)
function test_BatchSetUptimeFeed_EmitsEvents() public;
```

### test_BatchSetUptimeFeed_UpdatesExistingMappings()

- **Signature**: `test_BatchSetUptimeFeed_UpdatesExistingMappings()`
- **Visibility**: public
- **Source Range**: 17369:1013:625
- **Details**: [function_test_BatchSetUptimeFeed_UpdatesExistingMappings.md](./function_test_BatchSetUptimeFeed_UpdatesExistingMappings.md)

**Signature:**
```solidity
/// @notice Tests batchSetUptimeFeed can update existing mappings
///  @dev Verifies that calling again overwrites previous values
function test_BatchSetUptimeFeed_UpdatesExistingMappings() public;
```

### test_GetQuote_SequencerUp()

- **Signature**: `test_GetQuote_SequencerUp()`
- **Visibility**: public
- **Source Range**: 18769:607:625
- **Details**: [function_test_GetQuote_SequencerUp.md](./function_test_GetQuote_SequencerUp.md)

**Signature:**
```solidity
function test_GetQuote_SequencerUp() public;
```

### test_GetQuote_SequencerDown_Reverts()

- **Signature**: `test_GetQuote_SequencerDown_Reverts()`
- **Visibility**: public
- **Source Range**: 19382:931:625
- **Details**: [function_test_GetQuote_SequencerDown_Reverts.md](./function_test_GetQuote_SequencerDown_Reverts.md)

**Signature:**
```solidity
function test_GetQuote_SequencerDown_Reverts() public;
```

### test_GetQuote_GracePeriodNotOver_Reverts()

- **Signature**: `test_GetQuote_GracePeriodNotOver_Reverts()`
- **Visibility**: public
- **Source Range**: 20319:1068:625
- **Details**: [function_test_GetQuote_GracePeriodNotOver_Reverts.md](./function_test_GetQuote_GracePeriodNotOver_Reverts.md)

**Signature:**
```solidity
function test_GetQuote_GracePeriodNotOver_Reverts() public;
```

### test_GetQuote_NoUptimeFeed_Reverts()

- **Signature**: `test_GetQuote_NoUptimeFeed_Reverts()`
- **Visibility**: public
- **Source Range**: 21393:1158:625
- **Details**: [function_test_GetQuote_NoUptimeFeed_Reverts.md](./function_test_GetQuote_NoUptimeFeed_Reverts.md)

**Signature:**
```solidity
function test_GetQuote_NoUptimeFeed_Reverts() public;
```

### test_GetQuote_StaleFeed_Reverts()

- **Signature**: `test_GetQuote_StaleFeed_Reverts()`
- **Visibility**: public
- **Source Range**: 22557:723:625
- **Details**: [function_test_GetQuote_StaleFeed_Reverts.md](./function_test_GetQuote_StaleFeed_Reverts.md)

**Signature:**
```solidity
function test_GetQuote_StaleFeed_Reverts() public;
```

### test_GetQuote_NegativePrice_Reverts()

- **Signature**: `test_GetQuote_NegativePrice_Reverts()`
- **Visibility**: public
- **Source Range**: 23286:697:625
- **Details**: [function_test_GetQuote_NegativePrice_Reverts.md](./function_test_GetQuote_NegativePrice_Reverts.md)

**Signature:**
```solidity
function test_GetQuote_NegativePrice_Reverts() public;
```

### test_PriceChangeReflected()

- **Signature**: `test_PriceChangeReflected()`
- **Visibility**: public
- **Source Range**: 24169:840:625
- **Details**: [function_test_PriceChangeReflected.md](./function_test_PriceChangeReflected.md)

**Signature:**
```solidity
function test_PriceChangeReflected() public;
```

### test_DefaultGracePeriod()

- **Signature**: `test_DefaultGracePeriod()`
- **Visibility**: public
- **Source Range**: 25015:1848:625
- **Details**: [function_test_DefaultGracePeriod.md](./function_test_DefaultGracePeriod.md)

**Signature:**
```solidity
function test_DefaultGracePeriod() public;
```

### test_GetQuoteFromOracle_RevertsOnNegativeAnswerWithRevertOnError()

- **Signature**: `test_GetQuoteFromOracle_RevertsOnNegativeAnswerWithRevertOnError()`
- **Visibility**: public
- **Source Range**: 27303:648:625
- **Details**: [function_test_GetQuoteFromOracle_RevertsOnNegativeAnswerWithRevertOnError.md](./function_test_GetQuoteFromOracle_RevertsOnNegativeAnswerWithRevertOnError.md)

**Signature:**
```solidity
/// @notice Tests _getQuoteFromOracle reverts with ORACLE_UNTRUSTED_DATA when answer <= 0 and revertOnError = true
///  @dev Covers SuperOracleL2.sol:136 - if (revertOnError) revert ORACLE_UNTRUSTED_DATA() with negative answer
function test_GetQuoteFromOracle_RevertsOnNegativeAnswerWithRevertOnError() public;
```

### test_GetQuoteFromOracle_RevertsOnZeroAnswerWithRevertOnError()

- **Signature**: `test_GetQuoteFromOracle_RevertsOnZeroAnswerWithRevertOnError()`
- **Visibility**: public
- **Source Range**: 28149:527:625
- **Details**: [function_test_GetQuoteFromOracle_RevertsOnZeroAnswerWithRevertOnError.md](./function_test_GetQuoteFromOracle_RevertsOnZeroAnswerWithRevertOnError.md)

**Signature:**
```solidity
/// @notice Tests _getQuoteFromOracle reverts with ORACLE_UNTRUSTED_DATA when answer = 0 and revertOnError = true
///  @dev Covers SuperOracleL2.sol:136 - boundary case with answer = 0
function test_GetQuoteFromOracle_RevertsOnZeroAnswerWithRevertOnError() public;
```

### test_GetQuoteFromOracle_RevertsOnStaleDataWithRevertOnError()

- **Signature**: `test_GetQuoteFromOracle_RevertsOnStaleDataWithRevertOnError()`
- **Visibility**: public
- **Source Range**: 28882:711:625
- **Details**: [function_test_GetQuoteFromOracle_RevertsOnStaleDataWithRevertOnError.md](./function_test_GetQuoteFromOracle_RevertsOnStaleDataWithRevertOnError.md)

**Signature:**
```solidity
/// @notice Tests _getQuoteFromOracle reverts with ORACLE_UNTRUSTED_DATA when data is stale and revertOnError = true
///  @dev Covers SuperOracleL2.sol:136 - if (revertOnError) with stale data
function test_GetQuoteFromOracle_RevertsOnStaleDataWithRevertOnError() public;
```

### test_GetQuoteFromOracle_ReturnsZeroOnNegativeAnswerWithoutRevert()

- **Signature**: `test_GetQuoteFromOracle_ReturnsZeroOnNegativeAnswerWithoutRevert()`
- **Visibility**: public
- **Source Range**: 29779:2498:625
- **Details**: [function_test_GetQuoteFromOracle_ReturnsZeroOnNegativeAnswerWithoutRevert.md](./function_test_GetQuoteFromOracle_ReturnsZeroOnNegativeAnswerWithoutRevert.md)

**Signature:**
```solidity
/// @notice Tests _getQuoteFromOracle returns 0 when answer <= 0 and revertOnError = false
///  @dev Covers SuperOracleL2.sol:137 - return 0 path when revertOnError = false
function test_GetQuoteFromOracle_ReturnsZeroOnNegativeAnswerWithoutRevert() public;
```

### test_GetQuoteFromOracle_ReturnsZeroOnStaleDataWithoutRevert()

- **Signature**: `test_GetQuoteFromOracle_ReturnsZeroOnStaleDataWithoutRevert()`
- **Visibility**: public
- **Source Range**: 32454:2418:625
- **Details**: [function_test_GetQuoteFromOracle_ReturnsZeroOnStaleDataWithoutRevert.md](./function_test_GetQuoteFromOracle_ReturnsZeroOnStaleDataWithoutRevert.md)

**Signature:**
```solidity
/// @notice Tests _getQuoteFromOracle returns 0 when data is stale and revertOnError = false
///  @dev Covers SuperOracleL2.sol:137 - return 0 path with stale data
function test_GetQuoteFromOracle_ReturnsZeroOnStaleDataWithoutRevert() public;
```

### test_GetQuoteFromOracle_SucceedsAtExactStalenessLimit()

- **Signature**: `test_GetQuoteFromOracle_SucceedsAtExactStalenessLimit()`
- **Visibility**: public
- **Source Range**: 35051:756:625
- **Details**: [function_test_GetQuoteFromOracle_SucceedsAtExactStalenessLimit.md](./function_test_GetQuoteFromOracle_SucceedsAtExactStalenessLimit.md)

**Signature:**
```solidity
/// @notice Tests boundary case where updatedAt is exactly at the staleness limit
///  @dev Tests boundary of line 135 condition: block.timestamp - updatedAt > limit
function test_GetQuoteFromOracle_SucceedsAtExactStalenessLimit() public;
```

### test_GetQuoteFromOracle_SucceedsWithAnswerOne()

- **Signature**: `test_GetQuoteFromOracle_SucceedsWithAnswerOne()`
- **Visibility**: public
- **Source Range**: 35968:727:625
- **Details**: [function_test_GetQuoteFromOracle_SucceedsWithAnswerOne.md](./function_test_GetQuoteFromOracle_SucceedsWithAnswerOne.md)

**Signature:**
```solidity
/// @notice Tests _getQuoteFromOracle with answer = 1 (just above zero, should succeed)
///  @dev Tests boundary of line 135 condition: answer <= 0
function test_GetQuoteFromOracle_SucceedsWithAnswerOne() public;
```

### test_CatchBlock_RevertsOnDecimalsFailWithRevertOnError()

- **Signature**: `test_CatchBlock_RevertsOnDecimalsFailWithRevertOnError()`
- **Visibility**: public
- **Source Range**: 37124:2001:625
- **Details**: [function_test_CatchBlock_RevertsOnDecimalsFailWithRevertOnError.md](./function_test_CatchBlock_RevertsOnDecimalsFailWithRevertOnError.md)

**Signature:**
```solidity
/// @notice Tests catch block reverts with ORACLE_DECIMALS_CALL_FAIL when decimals() fails and revertOnError = true
///  @dev Covers SuperOracleL2.sol:154 - if (revertOnError) revert ORACLE_DECIMALS_CALL_FAIL(oracle)
function test_CatchBlock_RevertsOnDecimalsFailWithRevertOnError() public;
```

### test_CatchBlock_ReturnsZeroOnDecimalsFailWithoutRevert()

- **Signature**: `test_CatchBlock_ReturnsZeroOnDecimalsFailWithoutRevert()`
- **Visibility**: public
- **Source Range**: 39303:2784:625
- **Details**: [function_test_CatchBlock_ReturnsZeroOnDecimalsFailWithoutRevert.md](./function_test_CatchBlock_ReturnsZeroOnDecimalsFailWithoutRevert.md)

**Signature:**
```solidity
/// @notice Tests catch block returns 0 when decimals() fails and revertOnError = false
///  @dev Covers SuperOracleL2.sol:155 - return 0 when revertOnError = false
function test_CatchBlock_ReturnsZeroOnDecimalsFailWithoutRevert() public;
```

### test_CatchBlock_InsufficientGasDetection()

- **Signature**: `test_CatchBlock_InsufficientGasDetection()`
- **Visibility**: public
- **Source Range**: 42377:2372:625
- **Details**: [function_test_CatchBlock_InsufficientGasDetection.md](./function_test_CatchBlock_InsufficientGasDetection.md)

**Signature:**
```solidity
/// @notice Tests catch block detects insufficient gas before external call
///  @dev Covers SuperOracleL2.sol:153 - if (gasleft() <= gasBefore / 64) revert INSUFFICIENT_GAS_FOR_EXTERNAL_CALL()
///  @dev This is difficult to test reliably due to gas accounting complexities
function test_CatchBlock_InsufficientGasDetection() public;
```

### test_CatchBlock_BothRevertOnErrorPaths()

- **Signature**: `test_CatchBlock_BothRevertOnErrorPaths()`
- **Visibility**: public
- **Source Range**: 44895:2348:625
- **Details**: [function_test_CatchBlock_BothRevertOnErrorPaths.md](./function_test_CatchBlock_BothRevertOnErrorPaths.md)

**Signature:**
```solidity
/// @notice Tests that catch block properly handles both revertOnError paths
///  @dev Comprehensive test covering lines 154 and 155
function test_CatchBlock_BothRevertOnErrorPaths() public;
```

### test_UptimeFeedLatestRoundDataReverts_ReturnsZeroWithoutRevert()

- **Signature**: `test_UptimeFeedLatestRoundDataReverts_ReturnsZeroWithoutRevert()`
- **Visibility**: public
- **Source Range**: 47638:2708:625
- **Details**: [function_test_UptimeFeedLatestRoundDataReverts_ReturnsZeroWithoutRevert.md](./function_test_UptimeFeedLatestRoundDataReverts_ReturnsZeroWithoutRevert.md)

**Signature:**
```solidity
/// @notice Tests that uptime feed latestRoundData() revert is caught and returns 0 when revertOnError=false
///  @dev Covers the new try/catch block around uptime feed's latestRoundData() call
function test_UptimeFeedLatestRoundDataReverts_ReturnsZeroWithoutRevert() public;
```

### test_UptimeFeedLatestRoundDataReverts_RevertsWithRevertOnError()

- **Signature**: `test_UptimeFeedLatestRoundDataReverts_RevertsWithRevertOnError()`
- **Visibility**: public
- **Source Range**: 50524:1052:625
- **Details**: [function_test_UptimeFeedLatestRoundDataReverts_RevertsWithRevertOnError.md](./function_test_UptimeFeedLatestRoundDataReverts_RevertsWithRevertOnError.md)

**Signature:**
```solidity
/// @notice Tests that uptime feed latestRoundData() revert causes revert when revertOnError=true
///  @dev Covers ORACLE_ROUND_DATA_CALL_FAIL error for uptime feed
function test_UptimeFeedLatestRoundDataReverts_RevertsWithRevertOnError() public;
```

### test_DataOracleLatestRoundDataReverts_ReturnsZeroWithoutRevert()

- **Signature**: `test_DataOracleLatestRoundDataReverts_ReturnsZeroWithoutRevert()`
- **Visibility**: public
- **Source Range**: 51783:2680:625
- **Details**: [function_test_DataOracleLatestRoundDataReverts_ReturnsZeroWithoutRevert.md](./function_test_DataOracleLatestRoundDataReverts_ReturnsZeroWithoutRevert.md)

**Signature:**
```solidity
/// @notice Tests that data oracle latestRoundData() revert is caught and returns 0 when revertOnError=false
///  @dev Covers the new try/catch block around data oracle's latestRoundData() call
function test_DataOracleLatestRoundDataReverts_ReturnsZeroWithoutRevert() public;
```

### test_DataOracleLatestRoundDataReverts_RevertsWithRevertOnError()

- **Signature**: `test_DataOracleLatestRoundDataReverts_RevertsWithRevertOnError()`
- **Visibility**: public
- **Source Range**: 54641:1937:625
- **Details**: [function_test_DataOracleLatestRoundDataReverts_RevertsWithRevertOnError.md](./function_test_DataOracleLatestRoundDataReverts_RevertsWithRevertOnError.md)

**Signature:**
```solidity
/// @notice Tests that data oracle latestRoundData() revert causes revert when revertOnError=true
///  @dev Covers ORACLE_ROUND_DATA_CALL_FAIL error for data oracle
function test_DataOracleLatestRoundDataReverts_RevertsWithRevertOnError() public;
```

### test_NoUptimeFeed_ReturnsZeroWithoutRevert()

- **Signature**: `test_NoUptimeFeed_ReturnsZeroWithoutRevert()`
- **Visibility**: public
- **Source Range**: 56774:2492:625
- **Details**: [function_test_NoUptimeFeed_ReturnsZeroWithoutRevert.md](./function_test_NoUptimeFeed_ReturnsZeroWithoutRevert.md)

**Signature:**
```solidity
/// @notice Tests that NO_UPTIME_FEED returns 0 when revertOnError=false (AVERAGE_PROVIDER)
///  @dev Covers the new behavior where missing uptime feed returns 0 instead of reverting
function test_NoUptimeFeed_ReturnsZeroWithoutRevert() public;
```

### test_AverageQuote_MixedFailureModes()

- **Signature**: `test_AverageQuote_MixedFailureModes()`
- **Visibility**: public
- **Source Range**: 59449:4214:625
- **Details**: [function_test_AverageQuote_MixedFailureModes.md](./function_test_AverageQuote_MixedFailureModes.md)

**Signature:**
```solidity
/// @notice Tests multi-provider average with mixed failure modes
///  @dev Comprehensive test with sequencer down, grace period issues, stale data, and working provider
function test_AverageQuote_MixedFailureModes() public;
```

### test_AverageQuote_AllProvidersFail_Reverts()

- **Signature**: `test_AverageQuote_AllProvidersFail_Reverts()`
- **Visibility**: public
- **Source Range**: 63832:2608:625
- **Details**: [function_test_AverageQuote_AllProvidersFail_Reverts.md](./function_test_AverageQuote_AllProvidersFail_Reverts.md)

**Signature:**
```solidity
/// @notice Tests that all providers failing results in NO_VALID_REPORTED_PRICES
///  @dev When every provider fails, the average computation should revert
function test_AverageQuote_AllProvidersFail_Reverts() public;
```

### test_SequencerDown_BothRevertOnErrorPaths()

- **Signature**: `test_SequencerDown_BothRevertOnErrorPaths()`
- **Visibility**: public
- **Source Range**: 66621:747:625
- **Details**: [function_test_SequencerDown_BothRevertOnErrorPaths.md](./function_test_SequencerDown_BothRevertOnErrorPaths.md)

**Signature:**
```solidity
/// @notice Tests that SEQUENCER_DOWN returns 0 with revertOnError=false but reverts with revertOnError=true
///  @dev Verifies both paths for sequencer down condition
function test_SequencerDown_BothRevertOnErrorPaths() public;
```

### test_GracePeriodNotOver_BothRevertOnErrorPaths()

- **Signature**: `test_GracePeriodNotOver_BothRevertOnErrorPaths()`
- **Visibility**: public
- **Source Range**: 67554:846:625
- **Details**: [function_test_GracePeriodNotOver_BothRevertOnErrorPaths.md](./function_test_GracePeriodNotOver_BothRevertOnErrorPaths.md)

**Signature:**
```solidity
/// @notice Tests that GRACE_PERIOD_NOT_OVER returns 0 with revertOnError=false but reverts with revertOnError=true
///  @dev Verifies both paths for grace period condition
function test_GracePeriodNotOver_BothRevertOnErrorPaths() public;
```

### test_UptimeFeedGasConsumer_ReturnsZeroWithRevertOnErrorFalse()

- **Signature**: `test_UptimeFeedGasConsumer_ReturnsZeroWithRevertOnErrorFalse()`
- **Visibility**: public
- **Source Range**: 68970:3015:625
- **Details**: [function_test_UptimeFeedGasConsumer_ReturnsZeroWithRevertOnErrorFalse.md](./function_test_UptimeFeedGasConsumer_ReturnsZeroWithRevertOnErrorFalse.md)

**Signature:**
```solidity
/// @notice Tests line 120: When uptime feed consumes most gas before reverting and revertOnError=false
///  @dev Covers the `&& revertOnError` condition on line 120 when revertOnError=false
///  The gas check condition is true but && revertOnError makes the whole condition false,
///  so it falls through to line 121 (also false), and returns 0 on line 122
function test_UptimeFeedGasConsumer_ReturnsZeroWithRevertOnErrorFalse() public;
```

### test_DataOracleGasConsumer_ReturnsZeroWithRevertOnErrorFalse()

- **Signature**: `test_DataOracleGasConsumer_ReturnsZeroWithRevertOnErrorFalse()`
- **Visibility**: public
- **Source Range**: 72189:2873:625
- **Details**: [function_test_DataOracleGasConsumer_ReturnsZeroWithRevertOnErrorFalse.md](./function_test_DataOracleGasConsumer_ReturnsZeroWithRevertOnErrorFalse.md)

**Signature:**
```solidity
/// @notice Tests line 158: When data oracle consumes most gas before reverting and revertOnError=false
///  @dev Covers the `&& revertOnError` condition on line 158 when revertOnError=false
function test_DataOracleGasConsumer_ReturnsZeroWithRevertOnErrorFalse() public;
```

### test_DecimalsGasConsumer_ReturnsZeroWithRevertOnErrorFalse()

- **Signature**: `test_DecimalsGasConsumer_ReturnsZeroWithRevertOnErrorFalse()`
- **Visibility**: public
- **Source Range**: 75265:3032:625
- **Details**: [function_test_DecimalsGasConsumer_ReturnsZeroWithRevertOnErrorFalse.md](./function_test_DecimalsGasConsumer_ReturnsZeroWithRevertOnErrorFalse.md)

**Signature:**
```solidity
/// @notice Tests line 185: When decimals() consumes most gas before reverting and revertOnError=false
///  @dev Covers the `&& revertOnError` condition on line 185 when revertOnError=false
function test_DecimalsGasConsumer_ReturnsZeroWithRevertOnErrorFalse() public;
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
