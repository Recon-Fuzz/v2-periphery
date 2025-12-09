# Interface: Vm

## Metadata

- **Name**: Vm
- **Type**: Interface
- **Path**: lib/forge-std/src/Vm.sol
- **Documentation**: The `Vm` interface does allow manipulation of the EVM state. These are all intended to be used
   in tests, but it is not recommended to use these cheats in scripts.

## Implements Interfaces

- **VmSafe** [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

## Structs

### Log (inherited from VmSafe)

```solidity
/// An Ethereum log. Returned by `getRecordedLogs`.
struct Log {
    bytes32[] topics;
    bytes data;
    address emitter;
}
```

### Rpc (inherited from VmSafe)

```solidity
/// An RPC URL and its alias. Returned by `rpcUrlStructs`.
struct Rpc {
    string key;
    string url;
}
```

### EthGetLogs (inherited from VmSafe)

```solidity
/// An RPC log object. Returned by `eth_getLogs`.
struct EthGetLogs {
    address emitter;
    bytes32[] topics;
    bytes data;
    bytes32 blockHash;
    uint64 blockNumber;
    bytes32 transactionHash;
    uint64 transactionIndex;
    uint256 logIndex;
    bool removed;
}
```

### DirEntry (inherited from VmSafe)

```solidity
/// A single entry in a directory listing. Returned by `readDir`.
struct DirEntry {
    string errorMessage;
    string path;
    uint64 depth;
    bool isDir;
    bool isSymlink;
}
```

### FsMetadata (inherited from VmSafe)

```solidity
/// Metadata information about a file.
///  This structure is returned from the `fsMetadata` function and represents known
///  metadata about a file such as its permissions, size, modification
///  times, etc.
struct FsMetadata {
    bool isDir;
    bool isSymlink;
    uint256 length;
    bool readOnly;
    uint256 modified;
    uint256 accessed;
    uint256 created;
}
```

### Wallet (inherited from VmSafe)

```solidity
/// A wallet with a public and private key.
struct Wallet {
    address addr;
    uint256 publicKeyX;
    uint256 publicKeyY;
    uint256 privateKey;
}
```

### FfiResult (inherited from VmSafe)

```solidity
/// The result of a `tryFfi` call.
struct FfiResult {
    int32 exitCode;
    bytes stdout;
    bytes stderr;
}
```

### ChainInfo (inherited from VmSafe)

```solidity
/// Information on the chain and fork.
struct ChainInfo {
    uint256 forkId;
    uint256 chainId;
}
```

### Chain (inherited from VmSafe)

```solidity
/// Information about a blockchain.
struct Chain {
    string name;
    uint256 chainId;
    string chainAlias;
    string rpcUrl;
}
```

### AccountAccess (inherited from VmSafe)

```solidity
/// The result of a `stopAndReturnStateDiff` call.
struct AccountAccess {
    ChainInfo chainInfo;
    AccountAccessKind kind;
    address account;
    address accessor;
    bool initialized;
    uint256 oldBalance;
    uint256 newBalance;
    bytes deployedCode;
    uint256 value;
    bytes data;
    bool reverted;
    StorageAccess[] storageAccesses;
    uint64 depth;
}
```

### StorageAccess (inherited from VmSafe)

```solidity
/// The storage accessed during an `AccountAccess`.
struct StorageAccess {
    address account;
    bytes32 slot;
    bool isWrite;
    bytes32 previousValue;
    bytes32 newValue;
    bool reverted;
}
```

### Gas (inherited from VmSafe)

```solidity
/// Gas used. Returned by `lastCallGas`.
struct Gas {
    uint64 gasLimit;
    uint64 gasTotalUsed;
    uint64 gasMemoryUsed;
    int64 gasRefunded;
    uint64 gasRemaining;
}
```

### DebugStep (inherited from VmSafe)

```solidity
/// The result of the `stopDebugTraceRecording` call
struct DebugStep {
    uint256[] stack;
    bytes memoryInput;
    uint8 opcode;
    uint64 depth;
    bool isOutOfGas;
    address contractAddr;
}
```

### BroadcastTxSummary (inherited from VmSafe)

```solidity
/// Represents a transaction's broadcast details.
struct BroadcastTxSummary {
    bytes32 txHash;
    BroadcastTxType txType;
    address contractAddress;
    uint64 blockNumber;
    bool success;
}
```

### SignedDelegation (inherited from VmSafe)

```solidity
/// Holds a signed EIP-7702 authorization for an authority account to delegate to an implementation.
struct SignedDelegation {
    uint8 v;
    bytes32 r;
    bytes32 s;
    uint64 nonce;
    address implementation;
}
```

### PotentialRevert (inherited from VmSafe)

```solidity
/// Represents a "potential" revert reason from a single subsequent call when using `vm.assumeNoReverts`.
///  Reverts that match will result in a FOUNDRY::ASSUME rejection, whereas unmatched reverts will be surfaced
///  as normal.
struct PotentialRevert {
    address reverter;
    bool partialMatch;
    bytes revertData;
}
```

### AccessListItem (inherited from VmSafe)

```solidity
/// An EIP-2930 access list item.
struct AccessListItem {
    address target;
    bytes32[] storageKeys;
}
```

## Enums

### CallerMode (inherited from VmSafe)

```solidity
/// A modification applied to either `msg.sender` or `tx.origin`. Returned by `readCallers`.
enum CallerMode {
    None,
    Broadcast,
    RecurrentBroadcast,
    Prank,
    RecurrentPrank
}
```

### AccountAccessKind (inherited from VmSafe)

```solidity
/// The kind of account access that occurred.
enum AccountAccessKind {
    Call,
    DelegateCall,
    CallCode,
    StaticCall,
    Create,
    SelfDestruct,
    Resume,
    Balance,
    Extcodesize,
    Extcodehash,
    Extcodecopy
}
```

### ForgeContext (inherited from VmSafe)

```solidity
/// Forge execution contexts.
enum ForgeContext {
    TestGroup,
    Test,
    Coverage,
    Snapshot,
    ScriptGroup,
    ScriptDryRun,
    ScriptBroadcast,
    ScriptResume,
    Unknown
}
```

### BroadcastTxType (inherited from VmSafe)

```solidity
/// The transaction type (`txType`) of the broadcast.
enum BroadcastTxType {
    Call,
    Create,
    Create2
}
```

## Public/External Functions

### accessList(struct VmSafe.AccessListItem[])

- **Signature**: `accessList(struct VmSafe.AccessListItem[])`
- **Visibility**: external
- **Source Range**: 102777:63:25

**Signature:**
```solidity
/// Utility cheatcode to set an EIP-2930 access list for all subsequent transactions.
function accessList(AccessListItem[] calldata access) external;;
```

### activeFork()

- **Signature**: `activeFork()`
- **Visibility**: external
- **Source Range**: 102947:61:25

**Signature:**
```solidity
/// Returns the identifier of the currently active fork. Reverts if no fork is currently active.
function activeFork() external view returns (uint256 forkId);;
```

### allowCheatcodes(address)

- **Signature**: `allowCheatcodes(address)`
- **Visibility**: external
- **Source Range**: 103092:51:25

**Signature:**
```solidity
/// In forking mode, explicitly grant the given address cheatcode access.
function allowCheatcodes(address account) external;;
```

### blobBaseFee(uint256)

- **Signature**: `blobBaseFee(uint256)`
- **Visibility**: external
- **Source Range**: 103182:54:25

**Signature:**
```solidity
/// Sets `block.blobbasefee`
function blobBaseFee(uint256 newBlobBaseFee) external;;
```

### blobhashes(bytes32[])

- **Signature**: `blobhashes(bytes32[])`
- **Visibility**: external
- **Source Range**: 103403:56:25

**Signature:**
```solidity
/// Sets the blobhashes in the transaction.
///  Not available on EVM versions before Cancun.
///  If used on unsupported EVM versions it will revert.
function blobhashes(bytes32[] calldata hashes) external;;
```

### chainId(uint256)

- **Signature**: `chainId(uint256)`
- **Visibility**: external
- **Source Range**: 103495:46:25

**Signature:**
```solidity
/// Sets `block.chainid`.
function chainId(uint256 newChainId) external;;
```

### clearMockedCalls()

- **Signature**: `clearMockedCalls()`
- **Visibility**: external
- **Source Range**: 103580:37:25

**Signature:**
```solidity
/// Clears all mocked calls.
function clearMockedCalls() external;;
```

### cloneAccount(address,address)

- **Signature**: `cloneAccount(address,address)`
- **Visibility**: external
- **Source Range**: 103739:63:25

**Signature:**
```solidity
/// Clones a source account code, state, balance and nonce to a target account and updates in-memory EVM state.
function cloneAccount(address source, address target) external;;
```

### coinbase(address)

- **Signature**: `coinbase(address)`
- **Visibility**: external
- **Source Range**: 103839:48:25

**Signature:**
```solidity
/// Sets `block.coinbase`.
function coinbase(address newCoinbase) external;;
```

### cool(address)

- **Signature**: `cool(address)`
- **Visibility**: external
- **Source Range**: 103964:39:25

**Signature:**
```solidity
/// Marks the slots of an account and the account address as cold.
function cool(address target) external;;
```

### coolSlot(address,bytes32)

- **Signature**: `coolSlot(address,bytes32)`
- **Visibility**: external
- **Source Range**: 104100:57:25

**Signature:**
```solidity
/// Utility cheatcode to mark specific storage slot as cold, simulating no prior read.
function coolSlot(address target, bytes32 slot) external;;
```

### createFork(string)

- **Signature**: `createFork(string)`
- **Visibility**: external
- **Source Range**: 104277:82:25

**Signature:**
```solidity
/// Creates a new fork with the given endpoint and the _latest_ block and returns the identifier of the fork.
function createFork(string calldata urlOrAlias) external returns (uint256 forkId);;
```

### createFork(string,uint256)

- **Signature**: `createFork(string,uint256)`
- **Visibility**: external
- **Source Range**: 104466:103:25

**Signature:**
```solidity
/// Creates a new fork with the given endpoint and block and returns the identifier of the fork.
function createFork(string calldata urlOrAlias, uint256 blockNumber) external returns (uint256 forkId);;
```

### createFork(string,bytes32)

- **Signature**: `createFork(string,bytes32)`
- **Visibility**: external
- **Source Range**: 104794:98:25

**Signature:**
```solidity
/// Creates a new fork with the given endpoint and at the block the given transaction was mined in,
///  replays all transaction mined in the block before the transaction, and returns the identifier of the fork.
function createFork(string calldata urlOrAlias, bytes32 txHash) external returns (uint256 forkId);;
```

### createSelectFork(string)

- **Signature**: `createSelectFork(string)`
- **Visibility**: external
- **Source Range**: 105027:88:25

**Signature:**
```solidity
/// Creates and also selects a new fork with the given endpoint and the latest block and returns the identifier of the fork.
function createSelectFork(string calldata urlOrAlias) external returns (uint256 forkId);;
```

### createSelectFork(string,uint256)

- **Signature**: `createSelectFork(string,uint256)`
- **Visibility**: external
- **Source Range**: 105239:109:25

**Signature:**
```solidity
/// Creates and also selects a new fork with the given endpoint and block and returns the identifier of the fork.
function createSelectFork(string calldata urlOrAlias, uint256 blockNumber) external returns (uint256 forkId);;
```

### createSelectFork(string,bytes32)

- **Signature**: `createSelectFork(string,bytes32)`
- **Visibility**: external
- **Source Range**: 105584:104:25

**Signature:**
```solidity
/// Creates and also selects new fork with the given endpoint and at the block the given transaction was mined in,
///  replays all transaction mined in the block before the transaction, returns the identifier of the fork.
function createSelectFork(string calldata urlOrAlias, bytes32 txHash) external returns (uint256 forkId);;
```

### deal(address,uint256)

- **Signature**: `deal(address,uint256)`
- **Visibility**: external
- **Source Range**: 105728:60:25

**Signature:**
```solidity
/// Sets an address' balance.
function deal(address account, uint256 newBalance) external;;
```

### deleteStateSnapshot(uint256)

- **Signature**: `deleteStateSnapshot(uint256)`
- **Visibility**: external
- **Source Range**: 106026:81:25

**Signature:**
```solidity
/// Removes the snapshot with the given ID created by `snapshot`.
///  Takes the snapshot ID to delete.
///  Returns `true` if the snapshot was successfully deleted.
///  Returns `false` if the snapshot does not exist.
function deleteStateSnapshot(uint256 snapshotId) external returns (bool success);;
```

### deleteStateSnapshots()

- **Signature**: `deleteStateSnapshots()`
- **Visibility**: external
- **Source Range**: 106179:41:25

**Signature:**
```solidity
/// Removes _all_ snapshots previously created by `snapshot`.
function deleteStateSnapshots() external;;
```

### difficulty(uint256)

- **Signature**: `difficulty(uint256)`
- **Visibility**: external
- **Source Range**: 106396:52:25

**Signature:**
```solidity
/// Sets `block.difficulty`.
///  Not available on EVM versions from Paris onwards. Use `prevrandao` instead.
///  Reverts if used on unsupported EVM versions.
function difficulty(uint256 newDifficulty) external;;
```

### dumpState(string)

- **Signature**: `dumpState(string)`
- **Visibility**: external
- **Source Range**: 106507:61:25

**Signature:**
```solidity
/// Dump a genesis JSON file's `allocs` to disk.
function dumpState(string calldata pathToStateJson) external;;
```

### etch(address,bytes)

- **Signature**: `etch(address,bytes)`
- **Visibility**: external
- **Source Range**: 106605:74:25

**Signature:**
```solidity
/// Sets an address' code.
function etch(address target, bytes calldata newRuntimeBytecode) external;;
```

### fee(uint256)

- **Signature**: `fee(uint256)`
- **Visibility**: external
- **Source Range**: 106715:42:25

**Signature:**
```solidity
/// Sets `block.basefee`.
function fee(uint256 newBasefee) external;;
```

### getBlobhashes()

- **Signature**: `getBlobhashes()`
- **Visibility**: external
- **Source Range**: 106935:73:25

**Signature:**
```solidity
/// Gets the blockhashes from the current transaction.
///  Not available on EVM versions before Cancun.
///  If used on unsupported EVM versions it will revert.
function getBlobhashes() external view returns (bytes32[] memory hashes);;
```

### isPersistent(address)

- **Signature**: `isPersistent(address)`
- **Visibility**: external
- **Source Range**: 107075:79:25

**Signature:**
```solidity
/// Returns true if the account is marked as persistent.
function isPersistent(address account) external view returns (bool persistent);;
```

### loadAllocs(string)

- **Signature**: `loadAllocs(string)`
- **Visibility**: external
- **Source Range**: 107234:63:25

**Signature:**
```solidity
/// Load a genesis JSON file's `allocs` into the in-memory EVM state.
function loadAllocs(string calldata pathToAllocsJson) external;;
```

### makePersistent(address)

- **Signature**: `makePersistent(address)`
- **Visibility**: external
- **Source Range**: 107500:50:25

**Signature:**
```solidity
/// Marks that the account(s) should use persistent storage across fork swaps in a multifork setup
///  Meaning, changes made to the state of this account will be kept when switching forks.
function makePersistent(address account) external;;
```

### makePersistent(address,address)

- **Signature**: `makePersistent(address,address)`
- **Visibility**: external
- **Source Range**: 107595:69:25

**Signature:**
```solidity
/// See `makePersistent(address)`.
function makePersistent(address account0, address account1) external;;
```

### makePersistent(address,address,address)

- **Signature**: `makePersistent(address,address,address)`
- **Visibility**: external
- **Source Range**: 107709:87:25

**Signature:**
```solidity
/// See `makePersistent(address)`.
function makePersistent(address account0, address account1, address account2) external;;
```

### makePersistent(address[])

- **Signature**: `makePersistent(address[])`
- **Visibility**: external
- **Source Range**: 107841:62:25

**Signature:**
```solidity
/// See `makePersistent(address)`.
function makePersistent(address[] calldata accounts) external;;
```

### mockCallRevert(address,bytes,bytes)

- **Signature**: `mockCallRevert(address,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 107974:97:25

**Signature:**
```solidity
/// Reverts a call to an address with specified revert data.
function mockCallRevert(address callee, bytes calldata data, bytes calldata revertData) external;;
```

### mockCallRevert(address,uint256,bytes,bytes)

- **Signature**: `mockCallRevert(address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 108171:123:25

**Signature:**
```solidity
/// Reverts a call to an address with a specific `msg.value`, with specified revert data.
function mockCallRevert(address callee, uint256 msgValue, bytes calldata data, bytes calldata revertData) external;;
```

### mockCallRevert(address,bytes4,bytes)

- **Signature**: `mockCallRevert(address,bytes4,bytes)`
- **Visibility**: external
- **Source Range**: 108507:89:25

**Signature:**
```solidity
/// Reverts a call to an address with specified revert data.
///  Overload to pass the function selector directly `token.approve.selector` instead of `abi.encodeWithSelector(token.approve.selector)`.
function mockCallRevert(address callee, bytes4 data, bytes calldata revertData) external;;
```

### mockCallRevert(address,uint256,bytes4,bytes)

- **Signature**: `mockCallRevert(address,uint256,bytes4,bytes)`
- **Visibility**: external
- **Source Range**: 108838:107:25

**Signature:**
```solidity
/// Reverts a call to an address with a specific `msg.value`, with specified revert data.
///  Overload to pass the function selector directly `token.approve.selector` instead of `abi.encodeWithSelector(token.approve.selector)`.
function mockCallRevert(address callee, uint256 msgValue, bytes4 data, bytes calldata revertData) external;;
```

### mockCall(address,bytes,bytes)

- **Signature**: `mockCall(address,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 109205:91:25

**Signature:**
```solidity
/// Mocks a call to an address, returning specified data.
///  Calldata can either be strict or a partial match, e.g. if you only
///  pass a Solidity selector to the expected calldata, then the entire Solidity
///  function will be mocked.
function mockCall(address callee, bytes calldata data, bytes calldata returnData) external;;
```

### mockCall(address,uint256,bytes,bytes)

- **Signature**: `mockCall(address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 109471:109:25

**Signature:**
```solidity
/// Mocks a call to an address with a specific `msg.value`, returning specified data.
///  Calldata match takes precedence over `msg.value` in case of ambiguity.
function mockCall(address callee, uint256 msgValue, bytes calldata data, bytes calldata returnData) external;;
```

### mockCall(address,bytes4,bytes)

- **Signature**: `mockCall(address,bytes4,bytes)`
- **Visibility**: external
- **Source Range**: 109982:83:25

**Signature:**
```solidity
/// Mocks a call to an address, returning specified data.
///  Calldata can either be strict or a partial match, e.g. if you only
///  pass a Solidity selector to the expected calldata, then the entire Solidity
///  function will be mocked.
///  Overload to pass the function selector directly `token.approve.selector` instead of `abi.encodeWithSelector(token.approve.selector)`.
function mockCall(address callee, bytes4 data, bytes calldata returnData) external;;
```

### mockCall(address,uint256,bytes4,bytes)

- **Signature**: `mockCall(address,uint256,bytes4,bytes)`
- **Visibility**: external
- **Source Range**: 110382:101:25

**Signature:**
```solidity
/// Mocks a call to an address with a specific `msg.value`, returning specified data.
///  Calldata match takes precedence over `msg.value` in case of ambiguity.
///  Overload to pass the function selector directly `token.approve.selector` instead of `abi.encodeWithSelector(token.approve.selector)`.
function mockCall(address callee, uint256 msgValue, bytes4 data, bytes calldata returnData) external;;
```

### mockCalls(address,bytes,bytes[])

- **Signature**: `mockCalls(address,bytes,bytes[])`
- **Visibility**: external
- **Source Range**: 110573:94:25

**Signature:**
```solidity
/// Mocks multiple calls to an address, returning specified data for each call.
function mockCalls(address callee, bytes calldata data, bytes[] calldata returnData) external;;
```

### mockCalls(address,uint256,bytes,bytes[])

- **Signature**: `mockCalls(address,uint256,bytes,bytes[])`
- **Visibility**: external
- **Source Range**: 110785:112:25

**Signature:**
```solidity
/// Mocks multiple calls to an address with a specific `msg.value`, returning specified data for each call.
function mockCalls(address callee, uint256 msgValue, bytes calldata data, bytes[] calldata returnData) external;;
```

### mockFunction(address,address,bytes)

- **Signature**: `mockFunction(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 111403:84:25

**Signature:**
```solidity
/// Whenever a call is made to `callee` with calldata `data`, this cheatcode instead calls
///  `target` with the same calldata. This functionality is similar to a delegate call made to
///  `target` contract from `callee`.
///  Can be used to substitute a call to a function with another implementation that captures
///  the primary logic of the original function but is easier to reason about.
///  If calldata is not a strict match then partial match by selector is attempted.
function mockFunction(address callee, address target, bytes calldata data) external;;
```

### noAccessList()

- **Signature**: `noAccessList()`
- **Visibility**: external
- **Source Range**: 111585:33:25

**Signature:**
```solidity
/// Utility cheatcode to remove any EIP-2930 access list set by `accessList` cheatcode.
function noAccessList() external;;
```

### prank(address)

- **Signature**: `prank(address)`
- **Visibility**: external
- **Source Range**: 111693:43:25

**Signature:**
```solidity
/// Sets the *next* call's `msg.sender` to be the input address.
function prank(address msgSender) external;;
```

### prank(address,address)

- **Signature**: `prank(address,address)`
- **Visibility**: external
- **Source Range**: 111855:61:25

**Signature:**
```solidity
/// Sets the *next* call's `msg.sender` to be the input address, and the `tx.origin` to be the second input.
function prank(address msgSender, address txOrigin) external;;
```

### prank(address,bool)

- **Signature**: `prank(address,bool)`
- **Visibility**: external
- **Source Range**: 112000:62:25

**Signature:**
```solidity
/// Sets the *next* delegate call's `msg.sender` to be the input address.
function prank(address msgSender, bool delegateCall) external;;
```

### prank(address,address,bool)

- **Signature**: `prank(address,address,bool)`
- **Visibility**: external
- **Source Range**: 112190:80:25

**Signature:**
```solidity
/// Sets the *next* delegate call's `msg.sender` to be the input address, and the `tx.origin` to be the second input.
function prank(address msgSender, address txOrigin, bool delegateCall) external;;
```

### prevrandao(bytes32)

- **Signature**: `prevrandao(bytes32)`
- **Visibility**: external
- **Source Range**: 112447:52:25

**Signature:**
```solidity
/// Sets `block.prevrandao`.
///  Not available on EVM versions before Paris. Use `difficulty` instead.
///  If used on unsupported EVM versions it will revert.
function prevrandao(bytes32 newPrevrandao) external;;
```

### prevrandao(uint256)

- **Signature**: `prevrandao(uint256)`
- **Visibility**: external
- **Source Range**: 112676:52:25

**Signature:**
```solidity
/// Sets `block.prevrandao`.
///  Not available on EVM versions before Paris. Use `difficulty` instead.
///  If used on unsupported EVM versions it will revert.
function prevrandao(uint256 newPrevrandao) external;;
```

### readCallers()

- **Signature**: `readCallers()`
- **Visibility**: external
- **Source Range**: 112856:101:25

**Signature:**
```solidity
/// Reads the current `msg.sender` and `tx.origin` from state and reports if there is any active caller modification.
function readCallers() external returns (CallerMode callerMode, address msgSender, address txOrigin);;
```

### resetNonce(address)

- **Signature**: `resetNonce(address)`
- **Visibility**: external
- **Source Range**: 113045:46:25

**Signature:**
```solidity
/// Resets the nonce of an account to 0 for EOAs and 1 for contract accounts.
function resetNonce(address account) external;;
```

### revertToState(uint256)

- **Signature**: `revertToState(uint256)`
- **Visibility**: external
- **Source Range**: 113439:75:25

**Signature:**
```solidity
/// Revert the state of the EVM to a previous snapshot
///  Takes the snapshot ID to revert to.
///  Returns `true` if the snapshot was successfully reverted.
///  Returns `false` if the snapshot does not exist.
///  **Note:** This does not automatically delete the snapshot. To delete the snapshot use `deleteStateSnapshot`.
function revertToState(uint256 snapshotId) external returns (bool success);;
```

### revertToStateAndDelete(uint256)

- **Signature**: `revertToStateAndDelete(uint256)`
- **Visibility**: external
- **Source Range**: 113797:84:25

**Signature:**
```solidity
/// Revert the state of the EVM to a previous snapshot and automatically deletes the snapshots
///  Takes the snapshot ID to revert to.
///  Returns `true` if the snapshot was successfully reverted and deleted.
///  Returns `false` if the snapshot does not exist.
function revertToStateAndDelete(uint256 snapshotId) external returns (bool success);;
```

### revokePersistent(address)

- **Signature**: `revokePersistent(address)`
- **Visibility**: external
- **Source Range**: 113978:52:25

**Signature:**
```solidity
/// Revokes persistent status from the address, previously added via `makePersistent`.
function revokePersistent(address account) external;;
```

### revokePersistent(address[])

- **Signature**: `revokePersistent(address[])`
- **Visibility**: external
- **Source Range**: 114077:64:25

**Signature:**
```solidity
/// See `revokePersistent(address)`.
function revokePersistent(address[] calldata accounts) external;;
```

### roll(uint256)

- **Signature**: `roll(uint256)`
- **Visibility**: external
- **Source Range**: 114176:42:25

**Signature:**
```solidity
/// Sets `block.height`.
function roll(uint256 newHeight) external;;
```

### rollFork(uint256)

- **Signature**: `rollFork(uint256)`
- **Visibility**: external
- **Source Range**: 114357:48:25

**Signature:**
```solidity
/// Updates the currently active fork to given block number
///  This is similar to `roll` but for the currently active fork.
function rollFork(uint256 blockNumber) external;;
```

### rollFork(bytes32)

- **Signature**: `rollFork(bytes32)`
- **Visibility**: external
- **Source Range**: 114620:43:25

**Signature:**
```solidity
/// Updates the currently active fork to given transaction. This will `rollFork` with the number
///  of the block the transaction was mined in and replays all transaction mined before it in the block.
function rollFork(bytes32 txHash) external;;
```

### rollFork(uint256,uint256)

- **Signature**: `rollFork(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 114723:64:25

**Signature:**
```solidity
/// Updates the given fork to given block number.
function rollFork(uint256 forkId, uint256 blockNumber) external;;
```

### rollFork(uint256,bytes32)

- **Signature**: `rollFork(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 114923:59:25

**Signature:**
```solidity
/// Updates the given fork to block number of the given transaction and replays all transaction mined before it in the block.
function rollFork(uint256 forkId, bytes32 txHash) external;;
```

### selectFork(uint256)

- **Signature**: `selectFork(uint256)`
- **Visibility**: external
- **Source Range**: 115095:45:25

**Signature:**
```solidity
/// Takes a fork identifier created by `createFork` and sets the corresponding forked state as active.
function selectFork(uint256 forkId) external;;
```

### setBlockhash(uint256,bytes32)

- **Signature**: `setBlockhash(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 115290:71:25

**Signature:**
```solidity
/// Set blockhash for the current block.
///  It only sets the blockhash for blocks where `block.number - 256 <= number < block.number`.
function setBlockhash(uint256 blockNumber, bytes32 blockHash) external;;
```

### setNonce(address,uint64)

- **Signature**: `setNonce(address,uint64)`
- **Visibility**: external
- **Source Range**: 115459:61:25

**Signature:**
```solidity
/// Sets the nonce of an account. Must be higher than the current nonce of the account.
function setNonce(address account, uint64 newNonce) external;;
```

### setNonceUnsafe(address,uint64)

- **Signature**: `setNonceUnsafe(address,uint64)`
- **Visibility**: external
- **Source Range**: 115586:67:25

**Signature:**
```solidity
/// Sets the nonce of an account to an arbitrary value.
function setNonceUnsafe(address account, uint64 newNonce) external;;
```

### snapshotGasLastCall(string)

- **Signature**: `snapshotGasLastCall(string)`
- **Visibility**: external
- **Source Range**: 115752:86:25

**Signature:**
```solidity
/// Snapshot capture the gas usage of the last call by name from the callee perspective.
function snapshotGasLastCall(string calldata name) external returns (uint256 gasUsed);;
```

### snapshotGasLastCall(string,string)

- **Signature**: `snapshotGasLastCall(string,string)`
- **Visibility**: external
- **Source Range**: 115948:109:25

**Signature:**
```solidity
/// Snapshot capture the gas usage of the last call by name in a group from the callee perspective.
function snapshotGasLastCall(string calldata group, string calldata name) external returns (uint256 gasUsed);;
```

### snapshotState()

- **Signature**: `snapshotState()`
- **Visibility**: external
- **Source Range**: 116217:63:25

**Signature:**
```solidity
/// Snapshot the current state of the evm.
///  Returns the ID of the snapshot that was created.
///  To revert a snapshot use `revertToState`.
function snapshotState() external returns (uint256 snapshotId);;
```

### snapshotValue(string,uint256)

- **Signature**: `snapshotValue(string,uint256)`
- **Visibility**: external
- **Source Range**: 116407:69:25

**Signature:**
```solidity
/// Snapshot capture an arbitrary numerical value by name.
///  The group name is derived from the contract name.
function snapshotValue(string calldata name, uint256 value) external;;
```

### snapshotValue(string,string,uint256)

- **Signature**: `snapshotValue(string,string,uint256)`
- **Visibility**: external
- **Source Range**: 116556:92:25

**Signature:**
```solidity
/// Snapshot capture an arbitrary numerical value by name in a group.
function snapshotValue(string calldata group, string calldata name, uint256 value) external;;
```

### startPrank(address)

- **Signature**: `startPrank(address)`
- **Visibility**: external
- **Source Range**: 116755:48:25

**Signature:**
```solidity
/// Sets all subsequent calls' `msg.sender` to be the input address until `stopPrank` is called.
function startPrank(address msgSender) external;;
```

### startPrank(address,address)

- **Signature**: `startPrank(address,address)`
- **Visibility**: external
- **Source Range**: 116954:66:25

**Signature:**
```solidity
/// Sets all subsequent calls' `msg.sender` to be the input address until `stopPrank` is called, and the `tx.origin` to be the second input.
function startPrank(address msgSender, address txOrigin) external;;
```

### startPrank(address,bool)

- **Signature**: `startPrank(address,bool)`
- **Visibility**: external
- **Source Range**: 117136:67:25

**Signature:**
```solidity
/// Sets all subsequent delegate calls' `msg.sender` to be the input address until `stopPrank` is called.
function startPrank(address msgSender, bool delegateCall) external;;
```

### startPrank(address,address,bool)

- **Signature**: `startPrank(address,address,bool)`
- **Visibility**: external
- **Source Range**: 117363:85:25

**Signature:**
```solidity
/// Sets all subsequent delegate calls' `msg.sender` to be the input address until `stopPrank` is called, and the `tx.origin` to be the second input.
function startPrank(address msgSender, address txOrigin, bool delegateCall) external;;
```

### startSnapshotGas(string)

- **Signature**: `startSnapshotGas(string)`
- **Visibility**: external
- **Source Range**: 117579:57:25

**Signature:**
```solidity
/// Start a snapshot capture of the current gas usage by name.
///  The group name is derived from the contract name.
function startSnapshotGas(string calldata name) external;;
```

### startSnapshotGas(string,string)

- **Signature**: `startSnapshotGas(string,string)`
- **Visibility**: external
- **Source Range**: 117720:80:25

**Signature:**
```solidity
/// Start a snapshot capture of the current gas usage by name in a group.
function startSnapshotGas(string calldata group, string calldata name) external;;
```

### stopPrank()

- **Signature**: `stopPrank()`
- **Visibility**: external
- **Source Range**: 117875:30:25

**Signature:**
```solidity
/// Resets subsequent calls' `msg.sender` to be `address(this)`.
function stopPrank() external;;
```

### stopSnapshotGas()

- **Signature**: `stopSnapshotGas()`
- **Visibility**: external
- **Source Range**: 118029:62:25

**Signature:**
```solidity
/// Stop the snapshot capture of the current gas by latest snapshot name, capturing the gas used since the start.
function stopSnapshotGas() external returns (uint256 gasUsed);;
```

### stopSnapshotGas(string)

- **Signature**: `stopSnapshotGas(string)`
- **Visibility**: external
- **Source Range**: 118263:82:25

**Signature:**
```solidity
/// Stop the snapshot capture of the current gas usage by name, capturing the gas used since the start.
///  The group name is derived from the contract name.
function stopSnapshotGas(string calldata name) external returns (uint256 gasUsed);;
```

### stopSnapshotGas(string,string)

- **Signature**: `stopSnapshotGas(string,string)`
- **Visibility**: external
- **Source Range**: 118470:105:25

**Signature:**
```solidity
/// Stop the snapshot capture of the current gas usage by name in a group, capturing the gas used since the start.
function stopSnapshotGas(string calldata group, string calldata name) external returns (uint256 gasUsed);;
```

### store(address,bytes32,bytes32)

- **Signature**: `store(address,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 118633:69:25

**Signature:**
```solidity
/// Stores a value to an address' storage slot.
function store(address target, bytes32 slot, bytes32 value) external;;
```

### transact(bytes32)

- **Signature**: `transact(bytes32)`
- **Visibility**: external
- **Source Range**: 118805:43:25

**Signature:**
```solidity
/// Fetches the given transaction from the active fork and executes it on the current state.
function transact(bytes32 txHash) external;;
```

### transact(uint256,bytes32)

- **Signature**: `transact(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 118950:59:25

**Signature:**
```solidity
/// Fetches the given transaction from the given fork and executes it on the current state.
function transact(uint256 forkId, bytes32 txHash) external;;
```

### txGasPrice(uint256)

- **Signature**: `txGasPrice(uint256)`
- **Visibility**: external
- **Source Range**: 119043:50:25

**Signature:**
```solidity
/// Sets `tx.gasprice`.
function txGasPrice(uint256 newGasPrice) external;;
```

### warmSlot(address,bytes32)

- **Signature**: `warmSlot(address,bytes32)`
- **Visibility**: external
- **Source Range**: 119189:57:25

**Signature:**
```solidity
/// Utility cheatcode to mark specific storage slot as warm, simulating a prior read.
function warmSlot(address target, bytes32 slot) external;;
```

### warp(uint256)

- **Signature**: `warp(uint256)`
- **Visibility**: external
- **Source Range**: 119284:45:25

**Signature:**
```solidity
/// Sets `block.timestamp`.
function warp(uint256 newTimestamp) external;;
```

### deleteSnapshot(uint256)

- **Signature**: `deleteSnapshot(uint256)`
- **Visibility**: external
- **Source Range**: 119454:76:25

**Signature:**
```solidity
/// `deleteSnapshot` is being deprecated in favor of `deleteStateSnapshot`. It will be removed in future versions.
function deleteSnapshot(uint256 snapshotId) external returns (bool success);;
```

### deleteSnapshots()

- **Signature**: `deleteSnapshots()`
- **Visibility**: external
- **Source Range**: 119657:36:25

**Signature:**
```solidity
/// `deleteSnapshots` is being deprecated in favor of `deleteStateSnapshots`. It will be removed in future versions.
function deleteSnapshots() external;;
```

### revertToAndDelete(uint256)

- **Signature**: `revertToAndDelete(uint256)`
- **Visibility**: external
- **Source Range**: 119824:79:25

**Signature:**
```solidity
/// `revertToAndDelete` is being deprecated in favor of `revertToStateAndDelete`. It will be removed in future versions.
function revertToAndDelete(uint256 snapshotId) external returns (bool success);;
```

### revertTo(uint256)

- **Signature**: `revertTo(uint256)`
- **Visibility**: external
- **Source Range**: 120016:70:25

**Signature:**
```solidity
/// `revertTo` is being deprecated in favor of `revertToState`. It will be removed in future versions.
function revertTo(uint256 snapshotId) external returns (bool success);;
```

### snapshot()

- **Signature**: `snapshot()`
- **Visibility**: external
- **Source Range**: 120199:58:25

**Signature:**
```solidity
/// `snapshot` is being deprecated in favor of `snapshotState`. It will be removed in future versions.
function snapshot() external returns (uint256 snapshotId);;
```

### expectCallMinGas(address,uint256,uint64,bytes)

- **Signature**: `expectCallMinGas(address,uint256,uint64,bytes)`
- **Visibility**: external
- **Source Range**: 120409:105:25

**Signature:**
```solidity
/// Expect a call to an address with the specified `msg.value` and calldata, and a *minimum* amount of gas.
function expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes calldata data) external;;
```

### expectCallMinGas(address,uint256,uint64,bytes,uint64)

- **Signature**: `expectCallMinGas(address,uint256,uint64,bytes,uint64)`
- **Visibility**: external
- **Source Range**: 120647:127:25

**Signature:**
```solidity
/// Expect given number of calls to an address with the specified `msg.value` and calldata, and a *minimum* amount of gas.
function expectCallMinGas(address callee, uint256 msgValue, uint64 minGas, bytes calldata data, uint64 count) external;;
```

### expectCall(address,bytes)

- **Signature**: `expectCall(address,bytes)`
- **Visibility**: external
- **Source Range**: 120906:66:25

**Signature:**
```solidity
/// Expects a call to an address with the specified calldata.
///  Calldata can either be a strict or a partial match.
function expectCall(address callee, bytes calldata data) external;;
```

### expectCall(address,bytes,uint64)

- **Signature**: `expectCall(address,bytes,uint64)`
- **Visibility**: external
- **Source Range**: 121059:80:25

**Signature:**
```solidity
/// Expects given number of calls to an address with the specified calldata.
function expectCall(address callee, bytes calldata data, uint64 count) external;;
```

### expectCall(address,uint256,bytes)

- **Signature**: `expectCall(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 121227:84:25

**Signature:**
```solidity
/// Expects a call to an address with the specified `msg.value` and calldata.
function expectCall(address callee, uint256 msgValue, bytes calldata data) external;;
```

### expectCall(address,uint256,bytes,uint64)

- **Signature**: `expectCall(address,uint256,bytes,uint64)`
- **Visibility**: external
- **Source Range**: 121414:98:25

**Signature:**
```solidity
/// Expects given number of calls to an address with the specified `msg.value` and calldata.
function expectCall(address callee, uint256 msgValue, bytes calldata data, uint64 count) external;;
```

### expectCall(address,uint256,uint64,bytes)

- **Signature**: `expectCall(address,uint256,uint64,bytes)`
- **Visibility**: external
- **Source Range**: 121605:96:25

**Signature:**
```solidity
/// Expect a call to an address with the specified `msg.value`, gas, and calldata.
function expectCall(address callee, uint256 msgValue, uint64 gas, bytes calldata data) external;;
```

### expectCall(address,uint256,uint64,bytes,uint64)

- **Signature**: `expectCall(address,uint256,uint64,bytes,uint64)`
- **Visibility**: external
- **Source Range**: 121810:110:25

**Signature:**
```solidity
/// Expects given number of calls to an address with the specified `msg.value`, gas, and calldata.
function expectCall(address callee, uint256 msgValue, uint64 gas, bytes calldata data, uint64 count) external;;
```

### expectCreate(bytes,address)

- **Signature**: `expectCreate(bytes,address)`
- **Visibility**: external
- **Source Range**: 122032:74:25

**Signature:**
```solidity
/// Expects the deployment of the specified bytecode by the specified address using the CREATE opcode
function expectCreate(bytes calldata bytecode, address deployer) external;;
```

### expectCreate2(bytes,address)

- **Signature**: `expectCreate2(bytes,address)`
- **Visibility**: external
- **Source Range**: 122219:75:25

**Signature:**
```solidity
/// Expects the deployment of the specified bytecode by the specified address using the CREATE2 opcode
function expectCreate2(bytes calldata bytecode, address deployer) external;;
```

### expectEmitAnonymous(bool,bool,bool,bool,bool)

- **Signature**: `expectEmitAnonymous(bool,bool,bool,bool,bool)`
- **Visibility**: external
- **Source Range**: 122653:134:25

**Signature:**
```solidity
/// Prepare an expected anonymous log with (bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData.).
///  Call this function, then emit an anonymous event, then call a function. Internally after the call, we check if
///  logs were emitted in the expected order with the expected topics and data (as specified by the booleans).
function expectEmitAnonymous(bool checkTopic0, bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData) external;;
```

### expectEmitAnonymous(bool,bool,bool,bool,bool,address)

- **Signature**: `expectEmitAnonymous(bool,bool,bool,bool,bool,address)`
- **Visibility**: external
- **Source Range**: 122890:197:25

**Signature:**
```solidity
/// Same as the previous method, but also checks supplied address against emitting contract.
function expectEmitAnonymous(bool checkTopic0, bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter) external;;
```

### expectEmitAnonymous()

- **Signature**: `expectEmitAnonymous()`
- **Visibility**: external
- **Source Range**: 123377:40:25

**Signature:**
```solidity
/// Prepare an expected anonymous log with all topic and data checks enabled.
///  Call this function, then emit an anonymous event, then call a function. Internally after the call, we check if
///  logs were emitted in the expected order with the expected topics and data.
function expectEmitAnonymous() external;;
```

### expectEmitAnonymous(address)

- **Signature**: `expectEmitAnonymous(address)`
- **Visibility**: external
- **Source Range**: 123520:55:25

**Signature:**
```solidity
/// Same as the previous method, but also checks supplied address against emitting contract.
function expectEmitAnonymous(address emitter) external;;
```

### expectEmit(bool,bool,bool,bool)

- **Signature**: `expectEmit(bool,bool,bool,bool)`
- **Visibility**: external
- **Source Range**: 123914:99:25

**Signature:**
```solidity
/// Prepare an expected log with (bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData.).
///  Call this function, then emit an event, then call a function. Internally after the call, we check if
///  logs were emitted in the expected order with the expected topics and data (as specified by the booleans).
function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData) external;;
```

### expectEmit(bool,bool,bool,bool,address)

- **Signature**: `expectEmit(bool,bool,bool,bool,address)`
- **Visibility**: external
- **Source Range**: 124116:124:25

**Signature:**
```solidity
/// Same as the previous method, but also checks supplied address against emitting contract.
function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter) external;;
```

### expectEmit()

- **Signature**: `expectEmit()`
- **Visibility**: external
- **Source Range**: 124510:31:25

**Signature:**
```solidity
/// Prepare an expected log with all topic and data checks enabled.
///  Call this function, then emit an event, then call a function. Internally after the call, we check if
///  logs were emitted in the expected order with the expected topics and data.
function expectEmit() external;;
```

### expectEmit(address)

- **Signature**: `expectEmit(address)`
- **Visibility**: external
- **Source Range**: 124644:46:25

**Signature:**
```solidity
/// Same as the previous method, but also checks supplied address against emitting contract.
function expectEmit(address emitter) external;;
```

### expectEmit(bool,bool,bool,bool,uint64)

- **Signature**: `expectEmit(bool,bool,bool,bool,uint64)`
- **Visibility**: external
- **Source Range**: 124760:113:25

**Signature:**
```solidity
/// Expect a given number of logs with the provided topics.
function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, uint64 count) external;;
```

### expectEmit(bool,bool,bool,bool,address,uint64)

- **Signature**: `expectEmit(bool,bool,bool,bool,address,uint64)`
- **Visibility**: external
- **Source Range**: 124967:184:25

**Signature:**
```solidity
/// Expect a given number of logs from a specific emitter with the provided topics.
function expectEmit(bool checkTopic1, bool checkTopic2, bool checkTopic3, bool checkData, address emitter, uint64 count) external;;
```

### expectEmit(uint64)

- **Signature**: `expectEmit(uint64)`
- **Visibility**: external
- **Source Range**: 125235:43:25

**Signature:**
```solidity
/// Expect a given number of logs with all topic and data checks enabled.
function expectEmit(uint64 count) external;;
```

### expectEmit(address,uint64)

- **Signature**: `expectEmit(address,uint64)`
- **Visibility**: external
- **Source Range**: 125386:60:25

**Signature:**
```solidity
/// Expect a given number of logs from a specific emitter with all topic and data checks enabled.
function expectEmit(address emitter, uint64 count) external;;
```

### expectPartialRevert(bytes4)

- **Signature**: `expectPartialRevert(bytes4)`
- **Visibility**: external
- **Source Range**: 125524:57:25

**Signature:**
```solidity
/// Expects an error on next call that starts with the revert data.
function expectPartialRevert(bytes4 revertData) external;;
```

### expectPartialRevert(bytes4,address)

- **Signature**: `expectPartialRevert(bytes4,address)`
- **Visibility**: external
- **Source Range**: 125680:75:25

**Signature:**
```solidity
/// Expects an error on next call to reverter address, that starts with the revert data.
function expectPartialRevert(bytes4 revertData, address reverter) external;;
```

### expectRevert()

- **Signature**: `expectRevert()`
- **Visibility**: external
- **Source Range**: 125821:33:25

**Signature:**
```solidity
/// Expects an error on next call with any revert data.
function expectRevert() external;;
```

### expectRevert(bytes4)

- **Signature**: `expectRevert(bytes4)`
- **Visibility**: external
- **Source Range**: 125936:50:25

**Signature:**
```solidity
/// Expects an error on next call that exactly matches the revert data.
function expectRevert(bytes4 revertData) external;;
```

### expectRevert(bytes4,address,uint64)

- **Signature**: `expectRevert(bytes4,address,uint64)`
- **Visibility**: external
- **Source Range**: 126114:82:25

**Signature:**
```solidity
/// Expects a `count` number of reverts from the upcoming calls from the reverter address that match the revert data.
function expectRevert(bytes4 revertData, address reverter, uint64 count) external;;
```

### expectRevert(bytes,address,uint64)

- **Signature**: `expectRevert(bytes,address,uint64)`
- **Visibility**: external
- **Source Range**: 126332:90:25

**Signature:**
```solidity
/// Expects a `count` number of reverts from the upcoming calls from the reverter address that exactly match the revert data.
function expectRevert(bytes calldata revertData, address reverter, uint64 count) external;;
```

### expectRevert(bytes)

- **Signature**: `expectRevert(bytes)`
- **Visibility**: external
- **Source Range**: 126504:58:25

**Signature:**
```solidity
/// Expects an error on next call that exactly matches the revert data.
function expectRevert(bytes calldata revertData) external;;
```

### expectRevert(address)

- **Signature**: `expectRevert(address)`
- **Visibility**: external
- **Source Range**: 126648:49:25

**Signature:**
```solidity
/// Expects an error with any revert data on next call to reverter address.
function expectRevert(address reverter) external;;
```

### expectRevert(bytes4,address)

- **Signature**: `expectRevert(bytes4,address)`
- **Visibility**: external
- **Source Range**: 126786:68:25

**Signature:**
```solidity
/// Expects an error from reverter address on next call, with any revert data.
function expectRevert(bytes4 revertData, address reverter) external;;
```

### expectRevert(bytes,address)

- **Signature**: `expectRevert(bytes,address)`
- **Visibility**: external
- **Source Range**: 126959:76:25

**Signature:**
```solidity
/// Expects an error from reverter address on next call, that exactly matches the revert data.
function expectRevert(bytes calldata revertData, address reverter) external;;
```

### expectRevert(uint64)

- **Signature**: `expectRevert(uint64)`
- **Visibility**: external
- **Source Range**: 127143:45:25

**Signature:**
```solidity
/// Expects a `count` number of reverts from the upcoming calls with any revert data or reverter.
function expectRevert(uint64 count) external;;
```

### expectRevert(bytes4,uint64)

- **Signature**: `expectRevert(bytes4,uint64)`
- **Visibility**: external
- **Source Range**: 127290:64:25

**Signature:**
```solidity
/// Expects a `count` number of reverts from the upcoming calls that match the revert data.
function expectRevert(bytes4 revertData, uint64 count) external;;
```

### expectRevert(bytes,uint64)

- **Signature**: `expectRevert(bytes,uint64)`
- **Visibility**: external
- **Source Range**: 127464:72:25

**Signature:**
```solidity
/// Expects a `count` number of reverts from the upcoming calls that exactly match the revert data.
function expectRevert(bytes calldata revertData, uint64 count) external;;
```

### expectRevert(address,uint64)

- **Signature**: `expectRevert(address,uint64)`
- **Visibility**: external
- **Source Range**: 127637:63:25

**Signature:**
```solidity
/// Expects a `count` number of reverts from the upcoming calls from the reverter address.
function expectRevert(address reverter, uint64 count) external;;
```

### expectSafeMemory(uint64,uint64)

- **Signature**: `expectSafeMemory(uint64,uint64)`
- **Visibility**: external
- **Source Range**: 127929:59:25

**Signature:**
```solidity
/// Only allows memory writes to offsets [0x00, 0x60) ∪ [min, max) in the current subcontext. If any other
///  memory is written to, the test will fail. Can be called multiple times to add more ranges to the set.
function expectSafeMemory(uint64 min, uint64 max) external;;
```

### expectSafeMemoryCall(uint64,uint64)

- **Signature**: `expectSafeMemoryCall(uint64,uint64)`
- **Visibility**: external
- **Source Range**: 128230:63:25

**Signature:**
```solidity
/// Only allows memory writes to offsets [0x00, 0x60) ∪ [min, max) in the next created subcontext.
///  If any other memory is written to, the test will fail. Can be called multiple times to add more ranges
///  to the set.
function expectSafeMemoryCall(uint64 min, uint64 max) external;;
```

### skip(bool)

- **Signature**: `skip(bool)`
- **Visibility**: external
- **Source Range**: 128375:38:25

**Signature:**
```solidity
/// Marks a test as skipped. Must be called at the top level of a test.
function skip(bool skipTest) external;;
```

### skip(bool,string)

- **Signature**: `skip(bool,string)`
- **Visibility**: external
- **Source Range**: 128509:62:25

**Signature:**
```solidity
/// Marks a test as skipped with a reason. Must be called at the top level of a test.
function skip(bool skipTest, string calldata reason) external;;
```

### stopExpectSafeMemory()

- **Signature**: `stopExpectSafeMemory()`
- **Visibility**: external
- **Source Range**: 128646:41:25

**Signature:**
```solidity
/// Stops all safe memory expectation in the current subcontext.
function stopExpectSafeMemory() external;;
```

### interceptInitcode()

- **Signature**: `interceptInitcode()`
- **Visibility**: external
- **Source Range**: 129175:38:25

**Signature:**
```solidity
/// Causes the next contract creation (via new) to fail and return its initcode in the returndata buffer.
///  This allows type-safe access to the initcode payload that would be used for contract creation.
///  Example usage:
///  vm.interceptInitcode();
///  bytes memory initcode;
///  try new MyContract(param1, param2) { assert(false); }
///  catch (bytes memory interceptedInitcode) { initcode = interceptedInitcode; }
function interceptInitcode() external;;
```

### createWallet(string) (inherited from VmSafe)

- **Signature**: `createWallet(string)`
- **Visibility**: external
- **Source Range**: 12656:91:25

**Signature:**
```solidity
/// Derives a private key from the name, labels the account with that name, and returns the wallet.
function createWallet(string calldata walletLabel) external returns (Wallet memory wallet);;
```

### createWallet(uint256) (inherited from VmSafe)

- **Signature**: `createWallet(uint256)`
- **Visibility**: external
- **Source Range**: 12825:82:25

**Signature:**
```solidity
/// Generates a wallet from the private key and returns the wallet.
function createWallet(uint256 privateKey) external returns (Wallet memory wallet);;
```

### createWallet(uint256,string) (inherited from VmSafe)

- **Signature**: `createWallet(uint256,string)`
- **Visibility**: external
- **Source Range**: 13021:111:25

**Signature:**
```solidity
/// Generates a wallet from the private key, labels the account with that name, and returns the wallet.
function createWallet(uint256 privateKey, string calldata walletLabel) external returns (Wallet memory wallet);;
```

### deriveKey(string,uint32) (inherited from VmSafe)

- **Signature**: `deriveKey(string,uint32)`
- **Visibility**: external
- **Source Range**: 13280:102:25

**Signature:**
```solidity
/// Derive a private key from a provided mnenomic string (or mnenomic file path)
///  at the derivation path `m/44'/60'/0'/0/{index}`.
function deriveKey(string calldata mnemonic, uint32 index) external pure returns (uint256 privateKey);;
```

### deriveKey(string,string,uint32) (inherited from VmSafe)

- **Signature**: `deriveKey(string,string,uint32)`
- **Visibility**: external
- **Source Range**: 13511:158:25

**Signature:**
```solidity
/// Derive a private key from a provided mnenomic string (or mnenomic file path)
///  at `{derivationPath}{index}`.
function deriveKey(string calldata mnemonic, string calldata derivationPath, uint32 index) external pure returns (uint256 privateKey);;
```

### deriveKey(string,uint32,string) (inherited from VmSafe)

- **Signature**: `deriveKey(string,uint32,string)`
- **Visibility**: external
- **Source Range**: 13843:152:25

**Signature:**
```solidity
/// Derive a private key from a provided mnenomic string (or mnenomic file path) in the specified language
///  at the derivation path `m/44'/60'/0'/0/{index}`.
function deriveKey(string calldata mnemonic, uint32 index, string calldata language) external pure returns (uint256 privateKey);;
```

### deriveKey(string,string,uint32,string) (inherited from VmSafe)

- **Signature**: `deriveKey(string,string,uint32,string)`
- **Visibility**: external
- **Source Range**: 14150:184:25

**Signature:**
```solidity
/// Derive a private key from a provided mnenomic string (or mnenomic file path) in the specified language
///  at `{derivationPath}{index}`.
function deriveKey(string calldata mnemonic, string calldata derivationPath, uint32 index, string calldata language) external pure returns (uint256 privateKey);;
```

### publicKeyP256(uint256) (inherited from VmSafe)

- **Signature**: `publicKeyP256(uint256)`
- **Visibility**: external
- **Source Range**: 14409:106:25

**Signature:**
```solidity
/// Derives secp256r1 public key from the provided `privateKey`.
function publicKeyP256(uint256 privateKey) external pure returns (uint256 publicKeyX, uint256 publicKeyY);;
```

### rememberKey(uint256) (inherited from VmSafe)

- **Signature**: `rememberKey(uint256)`
- **Visibility**: external
- **Source Range**: 14599:76:25

**Signature:**
```solidity
/// Adds a private key to the local forge wallet and returns the address.
function rememberKey(uint256 privateKey) external returns (address keyAddr);;
```

### rememberKeys(string,string,uint32) (inherited from VmSafe)

- **Signature**: `rememberKeys(string,string,uint32)`
- **Visibility**: external
- **Source Range**: 14908:155:25

**Signature:**
```solidity
/// Derive a set number of wallets from a mnemonic at the derivation path `m/44'/60'/0'/0/{0..count}`.
///  The respective private keys are saved to the local forge wallet for later use and their addresses are returned.
function rememberKeys(string calldata mnemonic, string calldata derivationPath, uint32 count) external returns (address[] memory keyAddrs);;
```

### rememberKeys(string,string,string,uint32) (inherited from VmSafe)

- **Signature**: `rememberKeys(string,string,string,uint32)`
- **Visibility**: external
- **Source Range**: 15322:203:25

**Signature:**
```solidity
/// Derive a set number of wallets from a mnemonic in the specified language at the derivation path `m/44'/60'/0'/0/{0..count}`.
///  The respective private keys are saved to the local forge wallet for later use and their addresses are returned.
function rememberKeys(string calldata mnemonic, string calldata derivationPath, string calldata language, uint32 count) external returns (address[] memory keyAddrs);;
```

### signCompact(struct VmSafe.Wallet,bytes32) (inherited from VmSafe)

- **Signature**: `signCompact(struct VmSafe.Wallet,bytes32)`
- **Visibility**: external
- **Source Range**: 15804:102:25

**Signature:**
```solidity
/// Signs data with a `Wallet`.
///  Returns a compact signature (`r`, `vs`) as per EIP-2098, where `vs` encodes both the
///  signature's `s` value, and the recovery id `v` in a single bytes32.
///  This format reduces the signature size from 65 to 64 bytes.
function signCompact(Wallet calldata wallet, bytes32 digest) external returns (bytes32 r, bytes32 vs);;
```

### signCompact(uint256,bytes32) (inherited from VmSafe)

- **Signature**: `signCompact(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 16217:103:25

**Signature:**
```solidity
/// Signs `digest` with `privateKey` using the secp256k1 curve.
///  Returns a compact signature (`r`, `vs`) as per EIP-2098, where `vs` encodes both the
///  signature's `s` value, and the recovery id `v` in a single bytes32.
///  This format reduces the signature size from 65 to 64 bytes.
function signCompact(uint256 privateKey, bytes32 digest) external pure returns (bytes32 r, bytes32 vs);;
```

### signCompact(bytes32) (inherited from VmSafe)

- **Signature**: `signCompact(bytes32)`
- **Visibility**: external
- **Source Range**: 16996:83:25

**Signature:**
```solidity
/// Signs `digest` with signer provided to script using the secp256k1 curve.
///  Returns a compact signature (`r`, `vs`) as per EIP-2098, where `vs` encodes both the
///  signature's `s` value, and the recovery id `v` in a single bytes32.
///  This format reduces the signature size from 65 to 64 bytes.
///  If `--sender` is provided, the signer with provided address is used, otherwise,
///  if exactly one signer is provided to the script, that signer is used.
///  Raises error if signer passed through `--sender` does not match any unlocked signers or
///  if `--sender` is not provided and not exactly one signer is passed to the script.
function signCompact(bytes32 digest) external pure returns (bytes32 r, bytes32 vs);;
```

### signCompact(address,bytes32) (inherited from VmSafe)

- **Signature**: `signCompact(address,bytes32)`
- **Visibility**: external
- **Source Range**: 17493:99:25

**Signature:**
```solidity
/// Signs `digest` with signer provided to script using the secp256k1 curve.
///  Returns a compact signature (`r`, `vs`) as per EIP-2098, where `vs` encodes both the
///  signature's `s` value, and the recovery id `v` in a single bytes32.
///  This format reduces the signature size from 65 to 64 bytes.
///  Raises error if none of the signers passed into the script have provided address.
function signCompact(address signer, bytes32 digest) external pure returns (bytes32 r, bytes32 vs);;
```

### signP256(uint256,bytes32) (inherited from VmSafe)

- **Signature**: `signP256(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 17666:99:25

**Signature:**
```solidity
/// Signs `digest` with `privateKey` using the secp256r1 curve.
function signP256(uint256 privateKey, bytes32 digest) external pure returns (bytes32 r, bytes32 s);;
```

### sign(struct VmSafe.Wallet,bytes32) (inherited from VmSafe)

- **Signature**: `sign(struct VmSafe.Wallet,bytes32)`
- **Visibility**: external
- **Source Range**: 17807:103:25

**Signature:**
```solidity
/// Signs data with a `Wallet`.
function sign(Wallet calldata wallet, bytes32 digest) external returns (uint8 v, bytes32 r, bytes32 s);;
```

### sign(uint256,bytes32) (inherited from VmSafe)

- **Signature**: `sign(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 17984:104:25

**Signature:**
```solidity
/// Signs `digest` with `privateKey` using the secp256k1 curve.
function sign(uint256 privateKey, bytes32 digest) external pure returns (uint8 v, bytes32 r, bytes32 s);;
```

### sign(bytes32) (inherited from VmSafe)

- **Signature**: `sign(bytes32)`
- **Visibility**: external
- **Source Range**: 18527:84:25

**Signature:**
```solidity
/// Signs `digest` with signer provided to script using the secp256k1 curve.
///  If `--sender` is provided, the signer with provided address is used, otherwise,
///  if exactly one signer is provided to the script, that signer is used.
///  Raises error if signer passed through `--sender` does not match any unlocked signers or
///  if `--sender` is not provided and not exactly one signer is passed to the script.
function sign(bytes32 digest) external pure returns (uint8 v, bytes32 r, bytes32 s);;
```

### sign(address,bytes32) (inherited from VmSafe)

- **Signature**: `sign(address,bytes32)`
- **Visibility**: external
- **Source Range**: 18788:100:25

**Signature:**
```solidity
/// Signs `digest` with signer provided to script using the secp256k1 curve.
///  Raises error if none of the signers passed into the script have provided address.
function sign(address signer, bytes32 digest) external pure returns (uint8 v, bytes32 r, bytes32 s);;
```

### envAddress(string) (inherited from VmSafe)

- **Signature**: `envAddress(string)`
- **Visibility**: external
- **Source Range**: 19075:80:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `address`.
///  Reverts if the variable was not found or could not be parsed.
function envAddress(string calldata name) external view returns (address value);;
```

### envAddress(string,string) (inherited from VmSafe)

- **Signature**: `envAddress(string,string)`
- **Visibility**: external
- **Source Range**: 19338:112:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `address`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envAddress(string calldata name, string calldata delim) external view returns (address[] memory value);;
```

### envBool(string) (inherited from VmSafe)

- **Signature**: `envBool(string)`
- **Visibility**: external
- **Source Range**: 19596:74:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `bool`.
///  Reverts if the variable was not found or could not be parsed.
function envBool(string calldata name) external view returns (bool value);;
```

### envBool(string,string) (inherited from VmSafe)

- **Signature**: `envBool(string,string)`
- **Visibility**: external
- **Source Range**: 19850:106:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `bool`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envBool(string calldata name, string calldata delim) external view returns (bool[] memory value);;
```

### envBytes32(string) (inherited from VmSafe)

- **Signature**: `envBytes32(string)`
- **Visibility**: external
- **Source Range**: 20105:80:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `bytes32`.
///  Reverts if the variable was not found or could not be parsed.
function envBytes32(string calldata name) external view returns (bytes32 value);;
```

### envBytes32(string,string) (inherited from VmSafe)

- **Signature**: `envBytes32(string,string)`
- **Visibility**: external
- **Source Range**: 20368:112:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `bytes32`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envBytes32(string calldata name, string calldata delim) external view returns (bytes32[] memory value);;
```

### envBytes(string) (inherited from VmSafe)

- **Signature**: `envBytes(string)`
- **Visibility**: external
- **Source Range**: 20627:83:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `bytes`.
///  Reverts if the variable was not found or could not be parsed.
function envBytes(string calldata name) external view returns (bytes memory value);;
```

### envBytes(string,string) (inherited from VmSafe)

- **Signature**: `envBytes(string,string)`
- **Visibility**: external
- **Source Range**: 20891:108:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `bytes`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envBytes(string calldata name, string calldata delim) external view returns (bytes[] memory value);;
```

### envExists(string) (inherited from VmSafe)

- **Signature**: `envExists(string)`
- **Visibility**: external
- **Source Range**: 21101:77:25

**Signature:**
```solidity
/// Gets the environment variable `name` and returns true if it exists, else returns false.
function envExists(string calldata name) external view returns (bool result);;
```

### envInt(string) (inherited from VmSafe)

- **Signature**: `envInt(string)`
- **Visibility**: external
- **Source Range**: 21326:75:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `int256`.
///  Reverts if the variable was not found or could not be parsed.
function envInt(string calldata name) external view returns (int256 value);;
```

### envInt(string,string) (inherited from VmSafe)

- **Signature**: `envInt(string,string)`
- **Visibility**: external
- **Source Range**: 21583:107:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `int256`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envInt(string calldata name, string calldata delim) external view returns (int256[] memory value);;
```

### envOr(string,bool) (inherited from VmSafe)

- **Signature**: `envOr(string,bool)`
- **Visibility**: external
- **Source Range**: 21881:91:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `bool`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, bool defaultValue) external view returns (bool value);;
```

### envOr(string,uint256) (inherited from VmSafe)

- **Signature**: `envOr(string,uint256)`
- **Visibility**: external
- **Source Range**: 22166:97:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `uint256`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, uint256 defaultValue) external view returns (uint256 value);;
```

### envOr(string,string,address[]) (inherited from VmSafe)

- **Signature**: `envOr(string,string,address[])`
- **Visibility**: external
- **Source Range**: 22491:164:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `address`, delimited by `delim`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, string calldata delim, address[] calldata defaultValue) external view returns (address[] memory value);;
```

### envOr(string,string,bytes32[]) (inherited from VmSafe)

- **Signature**: `envOr(string,string,bytes32[])`
- **Visibility**: external
- **Source Range**: 22883:164:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `bytes32`, delimited by `delim`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, string calldata delim, bytes32[] calldata defaultValue) external view returns (bytes32[] memory value);;
```

### envOr(string,string,string[]) (inherited from VmSafe)

- **Signature**: `envOr(string,string,string[])`
- **Visibility**: external
- **Source Range**: 23274:162:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `string`, delimited by `delim`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, string calldata delim, string[] calldata defaultValue) external view returns (string[] memory value);;
```

### envOr(string,string,bytes[]) (inherited from VmSafe)

- **Signature**: `envOr(string,string,bytes[])`
- **Visibility**: external
- **Source Range**: 23662:160:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `bytes`, delimited by `delim`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, string calldata delim, bytes[] calldata defaultValue) external view returns (bytes[] memory value);;
```

### envOr(string,int256) (inherited from VmSafe)

- **Signature**: `envOr(string,int256)`
- **Visibility**: external
- **Source Range**: 24015:95:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `int256`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, int256 defaultValue) external view returns (int256 value);;
```

### envOr(string,address) (inherited from VmSafe)

- **Signature**: `envOr(string,address)`
- **Visibility**: external
- **Source Range**: 24304:97:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `address`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, address defaultValue) external view returns (address value);;
```

### envOr(string,bytes32) (inherited from VmSafe)

- **Signature**: `envOr(string,bytes32)`
- **Visibility**: external
- **Source Range**: 24595:97:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `bytes32`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, bytes32 defaultValue) external view returns (bytes32 value);;
```

### envOr(string,string) (inherited from VmSafe)

- **Signature**: `envOr(string,string)`
- **Visibility**: external
- **Source Range**: 24885:111:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `string`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, string calldata defaultValue) external view returns (string memory value);;
```

### envOr(string,bytes) (inherited from VmSafe)

- **Signature**: `envOr(string,bytes)`
- **Visibility**: external
- **Source Range**: 25188:109:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `bytes`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, bytes calldata defaultValue) external view returns (bytes memory value);;
```

### envOr(string,string,bool[]) (inherited from VmSafe)

- **Signature**: `envOr(string,string,bool[])`
- **Visibility**: external
- **Source Range**: 25522:158:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `bool`, delimited by `delim`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, string calldata delim, bool[] calldata defaultValue) external view returns (bool[] memory value);;
```

### envOr(string,string,uint256[]) (inherited from VmSafe)

- **Signature**: `envOr(string,string,uint256[])`
- **Visibility**: external
- **Source Range**: 25908:164:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `uint256`, delimited by `delim`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, string calldata delim, uint256[] calldata defaultValue) external view returns (uint256[] memory value);;
```

### envOr(string,string,int256[]) (inherited from VmSafe)

- **Signature**: `envOr(string,string,int256[])`
- **Visibility**: external
- **Source Range**: 26299:162:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `int256`, delimited by `delim`.
///  Reverts if the variable could not be parsed.
///  Returns `defaultValue` if the variable was not found.
function envOr(string calldata name, string calldata delim, int256[] calldata defaultValue) external view returns (int256[] memory value);;
```

### envString(string) (inherited from VmSafe)

- **Signature**: `envString(string)`
- **Visibility**: external
- **Source Range**: 26609:85:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `string`.
///  Reverts if the variable was not found or could not be parsed.
function envString(string calldata name) external view returns (string memory value);;
```

### envString(string,string) (inherited from VmSafe)

- **Signature**: `envString(string,string)`
- **Visibility**: external
- **Source Range**: 26876:110:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `string`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envString(string calldata name, string calldata delim) external view returns (string[] memory value);;
```

### envUint(string) (inherited from VmSafe)

- **Signature**: `envUint(string)`
- **Visibility**: external
- **Source Range**: 27135:77:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `uint256`.
///  Reverts if the variable was not found or could not be parsed.
function envUint(string calldata name) external view returns (uint256 value);;
```

### envUint(string,string) (inherited from VmSafe)

- **Signature**: `envUint(string,string)`
- **Visibility**: external
- **Source Range**: 27395:109:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `uint256`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envUint(string calldata name, string calldata delim) external view returns (uint256[] memory value);;
```

### isContext(enum VmSafe.ForgeContext) (inherited from VmSafe)

- **Signature**: `isContext(enum VmSafe.ForgeContext)`
- **Visibility**: external
- **Source Range**: 27581:77:25

**Signature:**
```solidity
/// Returns true if `forge` command was executed in given context.
function isContext(ForgeContext context) external view returns (bool result);;
```

### setEnv(string,string) (inherited from VmSafe)

- **Signature**: `setEnv(string,string)`
- **Visibility**: external
- **Source Range**: 27700:70:25

**Signature:**
```solidity
/// Sets environment variables.
function setEnv(string calldata name, string calldata value) external;;
```

### accesses(address) (inherited from VmSafe)

- **Signature**: `accesses(address)`
- **Visibility**: external
- **Source Range**: 27902:109:25

**Signature:**
```solidity
/// Gets all accessed reads and write slot from a `vm.record` session, for a given address.
function accesses(address target) external returns (bytes32[] memory readSlots, bytes32[] memory writeSlots);;
```

### addr(uint256) (inherited from VmSafe)

- **Signature**: `addr(uint256)`
- **Visibility**: external
- **Source Range**: 28067:74:25

**Signature:**
```solidity
/// Gets the address for a given private key.
function addr(uint256 privateKey) external pure returns (address keyAddr);;
```

### eth_getLogs(uint256,uint256,address,bytes32[]) (inherited from VmSafe)

- **Signature**: `eth_getLogs(uint256,uint256,address,bytes32[])`
- **Visibility**: external
- **Source Range**: 28204:160:25

**Signature:**
```solidity
/// Gets all the logs according to specified filter.
function eth_getLogs(uint256 fromBlock, uint256 toBlock, address target, bytes32[] calldata topics) external returns (EthGetLogs[] memory logs);;
```

### getBlobBaseFee() (inherited from VmSafe)

- **Signature**: `getBlobBaseFee()`
- **Visibility**: external
- **Source Range**: 28701:70:25

**Signature:**
```solidity
/// Gets the current `block.blobbasefee`.
///  You should use this instead of `block.blobbasefee` if you use `vm.blobBaseFee`, as `block.blobbasefee` is assumed to be constant across a transaction,
///  and as a result will get optimized out by the compiler.
///  See https://github.com/foundry-rs/foundry/issues/6180
function getBlobBaseFee() external view returns (uint256 blobBaseFee);;
```

### getBlockNumber() (inherited from VmSafe)

- **Signature**: `getBlockNumber()`
- **Visibility**: external
- **Source Range**: 29086:65:25

**Signature:**
```solidity
/// Gets the current `block.number`.
///  You should use this instead of `block.number` if you use `vm.roll`, as `block.number` is assumed to be constant across a transaction,
///  and as a result will get optimized out by the compiler.
///  See https://github.com/foundry-rs/foundry/issues/6180
function getBlockNumber() external view returns (uint256 height);;
```

### getBlockTimestamp() (inherited from VmSafe)

- **Signature**: `getBlockTimestamp()`
- **Visibility**: external
- **Source Range**: 29475:71:25

**Signature:**
```solidity
/// Gets the current `block.timestamp`.
///  You should use this instead of `block.timestamp` if you use `vm.warp`, as `block.timestamp` is assumed to be constant across a transaction,
///  and as a result will get optimized out by the compiler.
///  See https://github.com/foundry-rs/foundry/issues/6180
function getBlockTimestamp() external view returns (uint256 timestamp);;
```

### getMappingKeyAndParentOf(address,bytes32) (inherited from VmSafe)

- **Signature**: `getMappingKeyAndParentOf(address,bytes32)`
- **Visibility**: external
- **Source Range**: 29639:146:25

**Signature:**
```solidity
/// Gets the map key and parent of a mapping at a given slot, for a given address.
function getMappingKeyAndParentOf(address target, bytes32 elementSlot) external returns (bool found, bytes32 key, bytes32 parent);;
```

### getMappingLength(address,bytes32) (inherited from VmSafe)

- **Signature**: `getMappingLength(address,bytes32)`
- **Visibility**: external
- **Source Range**: 29882:97:25

**Signature:**
```solidity
/// Gets the number of elements in the mapping at the given slot, for a given address.
function getMappingLength(address target, bytes32 mappingSlot) external returns (uint256 length);;
```

### getMappingSlotAt(address,bytes32,uint256) (inherited from VmSafe)

- **Signature**: `getMappingSlotAt(address,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 30183:109:25

**Signature:**
```solidity
/// Gets the elements at index idx of the mapping at the given slot, for a given address. The
///  index must be less than the length of the mapping (i.e. the number of keys in the mapping).
function getMappingSlotAt(address target, bytes32 mappingSlot, uint256 idx) external returns (bytes32 value);;
```

### getNonce(address) (inherited from VmSafe)

- **Signature**: `getNonce(address)`
- **Visibility**: external
- **Source Range**: 30336:72:25

**Signature:**
```solidity
/// Gets the nonce of an account.
function getNonce(address account) external view returns (uint64 nonce);;
```

### getNonce(struct VmSafe.Wallet) (inherited from VmSafe)

- **Signature**: `getNonce(struct VmSafe.Wallet)`
- **Visibility**: external
- **Source Range**: 30451:74:25

**Signature:**
```solidity
/// Get the nonce of a `Wallet`.
function getNonce(Wallet calldata wallet) external returns (uint64 nonce);;
```

### getRawBlockHeader(uint256) (inherited from VmSafe)

- **Signature**: `getRawBlockHeader(uint256)`
- **Visibility**: external
- **Source Range**: 30689:95:25

**Signature:**
```solidity
/// Gets the RLP encoded block header for a given block number.
///  Returns the block header in the same format as `cast block <block_number> --raw`.
function getRawBlockHeader(uint256 blockNumber) external view returns (bytes memory rlpHeader);;
```

### getRecordedLogs() (inherited from VmSafe)

- **Signature**: `getRecordedLogs()`
- **Visibility**: external
- **Source Range**: 30826:64:25

**Signature:**
```solidity
/// Gets all the recorded logs.
function getRecordedLogs() external returns (Log[] memory logs);;
```

### getStateDiff() (inherited from VmSafe)

- **Signature**: `getStateDiff()`
- **Visibility**: external
- **Source Range**: 30975:67:25

**Signature:**
```solidity
/// Returns state diffs from current `vm.startStateDiffRecording` session.
function getStateDiff() external view returns (string memory diff);;
```

### getStateDiffJson() (inherited from VmSafe)

- **Signature**: `getStateDiffJson()`
- **Visibility**: external
- **Source Range**: 31143:71:25

**Signature:**
```solidity
/// Returns state diffs from current `vm.startStateDiffRecording` session, in json format.
function getStateDiffJson() external view returns (string memory diff);;
```

### lastCallGas() (inherited from VmSafe)

- **Signature**: `lastCallGas()`
- **Visibility**: external
- **Source Range**: 31292:62:25

**Signature:**
```solidity
/// Gets the gas used in the last call from the callee perspective.
function lastCallGas() external view returns (Gas memory gas);;
```

### load(address,bytes32) (inherited from VmSafe)

- **Signature**: `load(address,bytes32)`
- **Visibility**: external
- **Source Range**: 31406:81:25

**Signature:**
```solidity
/// Loads a storage slot from an address.
function load(address target, bytes32 slot) external view returns (bytes32 data);;
```

### pauseGasMetering() (inherited from VmSafe)

- **Signature**: `pauseGasMetering()`
- **Visibility**: external
- **Source Range**: 31578:37:25

**Signature:**
```solidity
/// Pauses gas metering (i.e. gas usage is not counted). Noop if already paused.
function pauseGasMetering() external;;
```

### record() (inherited from VmSafe)

- **Signature**: `record()`
- **Visibility**: external
- **Source Range**: 31775:27:25

**Signature:**
```solidity
/// Records all storage reads and writes. Use `accesses` to get the recorded data.
///  Subsequent calls to `record` will clear the previous data.
function record() external;;
```

### recordLogs() (inherited from VmSafe)

- **Signature**: `recordLogs()`
- **Visibility**: external
- **Source Range**: 31849:31:25

**Signature:**
```solidity
/// Record all the transaction logs.
function recordLogs() external;;
```

### resetGasMetering() (inherited from VmSafe)

- **Signature**: `resetGasMetering()`
- **Visibility**: external
- **Source Range**: 31951:37:25

**Signature:**
```solidity
/// Reset gas metering (i.e. gas usage is set to gas limit).
function resetGasMetering() external;;
```

### resumeGasMetering() (inherited from VmSafe)

- **Signature**: `resumeGasMetering()`
- **Visibility**: external
- **Source Range**: 32078:38:25

**Signature:**
```solidity
/// Resumes gas metering (i.e. gas usage is counted again). Noop if already on.
function resumeGasMetering() external;;
```

### rpc(string,string) (inherited from VmSafe)

- **Signature**: `rpc(string,string)`
- **Visibility**: external
- **Source Range**: 32193:98:25

**Signature:**
```solidity
/// Performs an Ethereum JSON-RPC request to the current fork URL.
function rpc(string calldata method, string calldata params) external returns (bytes memory data);;
```

### rpc(string,string,string) (inherited from VmSafe)

- **Signature**: `rpc(string,string,string)`
- **Visibility**: external
- **Source Range**: 32366:142:25

**Signature:**
```solidity
/// Performs an Ethereum JSON-RPC request to the given endpoint.
function rpc(string calldata urlOrAlias, string calldata method, string calldata params) external returns (bytes memory data);;
```

### startDebugTraceRecording() (inherited from VmSafe)

- **Signature**: `startDebugTraceRecording()`
- **Visibility**: external
- **Source Range**: 32562:45:25

**Signature:**
```solidity
/// Records the debug trace during the run.
function startDebugTraceRecording() external;;
```

### startMappingRecording() (inherited from VmSafe)

- **Signature**: `startMappingRecording()`
- **Visibility**: external
- **Source Range**: 32675:42:25

**Signature:**
```solidity
/// Starts recording all map SSTOREs for later retrieval.
function startMappingRecording() external;;
```

### startStateDiffRecording() (inherited from VmSafe)

- **Signature**: `startStateDiffRecording()`
- **Visibility**: external
- **Source Range**: 32861:44:25

**Signature:**
```solidity
/// Record all account accesses as part of CREATE, CALL or SELFDESTRUCT opcodes in order,
///  along with the context of the calls
function startStateDiffRecording() external;;
```

### stopAndReturnDebugTraceRecording() (inherited from VmSafe)

- **Signature**: `stopAndReturnDebugTraceRecording()`
- **Visibility**: external
- **Source Range**: 32984:87:25

**Signature:**
```solidity
/// Stop debug trace recording and returns the recorded debug trace.
function stopAndReturnDebugTraceRecording() external returns (DebugStep[] memory step);;
```

### stopAndReturnStateDiff() (inherited from VmSafe)

- **Signature**: `stopAndReturnStateDiff()`
- **Visibility**: external
- **Source Range**: 33179:92:25

**Signature:**
```solidity
/// Returns an ordered array of all account accesses from a `vm.startStateDiffRecording` session.
function stopAndReturnStateDiff() external returns (AccountAccess[] memory accountAccesses);;
```

### stopMappingRecording() (inherited from VmSafe)

- **Signature**: `stopMappingRecording()`
- **Visibility**: external
- **Source Range**: 33367:41:25

**Signature:**
```solidity
/// Stops recording all map SSTOREs for later retrieval and clears the recorded data.
function stopMappingRecording() external;;
```

### stopRecord() (inherited from VmSafe)

- **Signature**: `stopRecord()`
- **Visibility**: external
- **Source Range**: 33464:31:25

**Signature:**
```solidity
/// Stops recording storage reads and writes.
function stopRecord() external;;
```

### closeFile(string) (inherited from VmSafe)

- **Signature**: `closeFile(string)`
- **Visibility**: external
- **Source Range**: 33694:50:25

**Signature:**
```solidity
/// Closes file for reading, resetting the offset and allowing to read it from beginning with readLine.
///  `path` is relative to the project root.
function closeFile(string calldata path) external;;
```

### copyFile(string,string) (inherited from VmSafe)

- **Signature**: `copyFile(string,string)`
- **Visibility**: external
- **Source Range**: 34059:93:25

**Signature:**
```solidity
/// Copies the contents of one file to another. This function will **overwrite** the contents of `to`.
///  On success, the total number of bytes copied is returned and it is equal to the length of the `to` file as reported by `metadata`.
///  Both `from` and `to` are relative to the project root.
function copyFile(string calldata from, string calldata to) external returns (uint64 copied);;
```

### createDir(string,bool) (inherited from VmSafe)

- **Signature**: `createDir(string,bool)`
- **Visibility**: external
- **Source Range**: 34557:66:25

**Signature:**
```solidity
/// Creates a new, empty directory at the provided path.
///  This cheatcode will revert in the following situations, but is not limited to just these cases:
///  - User lacks permissions to modify `path`.
///  - A parent of the given path doesn't exist and `recursive` is false.
///  - `path` already exists and `recursive` is false.
///  `path` is relative to the project root.
function createDir(string calldata path, bool recursive) external;;
```

### deployCode(string) (inherited from VmSafe)

- **Signature**: `deployCode(string)`
- **Visibility**: external
- **Source Range**: 34853:93:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
function deployCode(string calldata artifactPath) external returns (address deployedAddress);;
```

### deployCode(string,bytes) (inherited from VmSafe)

- **Signature**: `deployCode(string,bytes)`
- **Visibility**: external
- **Source Range**: 35240:141:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
///  Additionally accepts abi-encoded constructor arguments.
function deployCode(string calldata artifactPath, bytes calldata constructorArgs) external returns (address deployedAddress);;
```

### deployCode(string,uint256) (inherited from VmSafe)

- **Signature**: `deployCode(string,uint256)`
- **Visibility**: external
- **Source Range**: 35653:108:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
///  Additionally accepts `msg.value`.
function deployCode(string calldata artifactPath, uint256 value) external returns (address deployedAddress);;
```

### deployCode(string,bytes,uint256) (inherited from VmSafe)

- **Signature**: `deployCode(string,bytes,uint256)`
- **Visibility**: external
- **Source Range**: 36071:156:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
///  Additionally accepts abi-encoded constructor arguments and `msg.value`.
function deployCode(string calldata artifactPath, bytes calldata constructorArgs, uint256 value) external returns (address deployedAddress);;
```

### deployCode(string,bytes32) (inherited from VmSafe)

- **Signature**: `deployCode(string,bytes32)`
- **Visibility**: external
- **Source Range**: 36481:107:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file, using the CREATE2 salt. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
function deployCode(string calldata artifactPath, bytes32 salt) external returns (address deployedAddress);;
```

### deployCode(string,bytes,bytes32) (inherited from VmSafe)

- **Signature**: `deployCode(string,bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 36906:155:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file, using the CREATE2 salt. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
///  Additionally accepts abi-encoded constructor arguments.
function deployCode(string calldata artifactPath, bytes calldata constructorArgs, bytes32 salt) external returns (address deployedAddress);;
```

### deployCode(string,uint256,bytes32) (inherited from VmSafe)

- **Signature**: `deployCode(string,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 37357:138:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file, using the CREATE2 salt. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
///  Additionally accepts `msg.value`.
function deployCode(string calldata artifactPath, uint256 value, bytes32 salt) external returns (address deployedAddress);;
```

### deployCode(string,bytes,uint256,bytes32) (inherited from VmSafe)

- **Signature**: `deployCode(string,bytes,uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 37829:170:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file, using the CREATE2 salt. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
///  Additionally accepts abi-encoded constructor arguments and `msg.value`.
function deployCode(string calldata artifactPath, bytes calldata constructorArgs, uint256 value, bytes32 salt) external returns (address deployedAddress);;
```

### exists(string) (inherited from VmSafe)

- **Signature**: `exists(string)`
- **Visibility**: external
- **Source Range**: 38094:74:25

**Signature:**
```solidity
/// Returns true if the given path points to an existing entity, else returns false.
function exists(string calldata path) external view returns (bool result);;
```

### ffi(string[]) (inherited from VmSafe)

- **Signature**: `ffi(string[])`
- **Visibility**: external
- **Source Range**: 38233:84:25

**Signature:**
```solidity
/// Performs a foreign function call via the terminal.
function ffi(string[] calldata commandInput) external returns (bytes memory result);;
```

### fsMetadata(string) (inherited from VmSafe)

- **Signature**: `fsMetadata(string)`
- **Visibility**: external
- **Source Range**: 38416:93:25

**Signature:**
```solidity
/// Given a path, query the file system to get information about a file, directory, etc.
function fsMetadata(string calldata path) external view returns (FsMetadata memory metadata);;
```

### getArtifactPathByCode(bytes) (inherited from VmSafe)

- **Signature**: `getArtifactPathByCode(bytes)`
- **Visibility**: external
- **Source Range**: 38578:95:25

**Signature:**
```solidity
/// Gets the artifact path from code (aka. creation code).
function getArtifactPathByCode(bytes calldata code) external view returns (string memory path);;
```

### getArtifactPathByDeployedCode(bytes) (inherited from VmSafe)

- **Signature**: `getArtifactPathByDeployedCode(bytes)`
- **Visibility**: external
- **Source Range**: 38750:111:25

**Signature:**
```solidity
/// Gets the artifact path from deployed code (aka. runtime code).
function getArtifactPathByDeployedCode(bytes calldata deployedCode) external view returns (string memory path);;
```

### getBroadcast(string,uint64,enum VmSafe.BroadcastTxType) (inherited from VmSafe)

- **Signature**: `getBroadcast(string,uint64,enum VmSafe.BroadcastTxType)`
- **Visibility**: external
- **Source Range**: 39156:166:25

**Signature:**
```solidity
/// Returns the most recent broadcast for the given contract on `chainId` matching `txType`.
///  For example:
///  The most recent deployment can be fetched by passing `txType` as `CREATE` or `CREATE2`.
///  The most recent call can be fetched by passing `txType` as `CALL`.
function getBroadcast(string calldata contractName, uint64 chainId, BroadcastTxType txType) external view returns (BroadcastTxSummary memory);;
```

### getBroadcasts(string,uint64,enum VmSafe.BroadcastTxType) (inherited from VmSafe)

- **Signature**: `getBroadcasts(string,uint64,enum VmSafe.BroadcastTxType)`
- **Visibility**: external
- **Source Range**: 39581:169:25

**Signature:**
```solidity
/// Returns all broadcasts for the given contract on `chainId` with the specified `txType`.
///  Sorted such that the most recent broadcast is the first element, and the oldest is the last. i.e descending order of BroadcastTxSummary.blockNumber.
function getBroadcasts(string calldata contractName, uint64 chainId, BroadcastTxType txType) external view returns (BroadcastTxSummary[] memory);;
```

### getBroadcasts(string,uint64) (inherited from VmSafe)

- **Signature**: `getBroadcasts(string,uint64)`
- **Visibility**: external
- **Source Range**: 39981:145:25

**Signature:**
```solidity
/// Returns all broadcasts for the given contract on `chainId`.
///  Sorted such that the most recent broadcast is the first element, and the oldest is the last. i.e descending order of BroadcastTxSummary.blockNumber.
function getBroadcasts(string calldata contractName, uint64 chainId) external view returns (BroadcastTxSummary[] memory);;
```

### getCode(string) (inherited from VmSafe)

- **Signature**: `getCode(string)`
- **Visibility**: external
- **Source Range**: 40364:101:25

**Signature:**
```solidity
/// Gets the creation bytecode from an artifact file. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
function getCode(string calldata artifactPath) external view returns (bytes memory creationBytecode);;
```

### getDeployedCode(string) (inherited from VmSafe)

- **Signature**: `getDeployedCode(string)`
- **Visibility**: external
- **Source Range**: 40703:108:25

**Signature:**
```solidity
/// Gets the deployed bytecode from an artifact file. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
function getDeployedCode(string calldata artifactPath) external view returns (bytes memory runtimeBytecode);;
```

### getDeployment(string) (inherited from VmSafe)

- **Signature**: `getDeployment(string)`
- **Visibility**: external
- **Source Range**: 40887:101:25

**Signature:**
```solidity
/// Returns the most recent deployment for the current `chainId`.
function getDeployment(string calldata contractName) external view returns (address deployedAddress);;
```

### getDeployment(string,uint64) (inherited from VmSafe)

- **Signature**: `getDeployment(string,uint64)`
- **Visibility**: external
- **Source Range**: 41073:141:25

**Signature:**
```solidity
/// Returns the most recent deployment for the given contract on `chainId`
function getDeployment(string calldata contractName, uint64 chainId) external view returns (address deployedAddress);;
```

### getDeployments(string,uint64) (inherited from VmSafe)

- **Signature**: `getDeployments(string,uint64)`
- **Visibility**: external
- **Source Range**: 41483:153:25

**Signature:**
```solidity
/// Returns all deployments for the given contract on `chainId`
///  Sorted in descending order of deployment time i.e descending order of BroadcastTxSummary.blockNumber.
///  The most recent deployment is the first element, and the oldest is the last.
function getDeployments(string calldata contractName, uint64 chainId) external view returns (address[] memory deployedAddresses);;
```

### isDir(string) (inherited from VmSafe)

- **Signature**: `isDir(string)`
- **Visibility**: external
- **Source Range**: 41742:73:25

**Signature:**
```solidity
/// Returns true if the path exists on disk and is pointing at a directory, else returns false.
function isDir(string calldata path) external view returns (bool result);;
```

### isFile(string) (inherited from VmSafe)

- **Signature**: `isFile(string)`
- **Visibility**: external
- **Source Range**: 41924:74:25

**Signature:**
```solidity
/// Returns true if the path exists on disk and is pointing at a regular file, else returns false.
function isFile(string calldata path) external view returns (bool result);;
```

### projectRoot() (inherited from VmSafe)

- **Signature**: `projectRoot()`
- **Visibility**: external
- **Source Range**: 42054:66:25

**Signature:**
```solidity
/// Get the path of the current project root.
function projectRoot() external view returns (string memory path);;
```

### prompt(string) (inherited from VmSafe)

- **Signature**: `prompt(string)`
- **Visibility**: external
- **Source Range**: 42187:83:25

**Signature:**
```solidity
/// Prompts the user for a string value in the terminal.
function prompt(string calldata promptText) external returns (string memory input);;
```

### promptAddress(string) (inherited from VmSafe)

- **Signature**: `promptAddress(string)`
- **Visibility**: external
- **Source Range**: 42333:78:25

**Signature:**
```solidity
/// Prompts the user for an address in the terminal.
function promptAddress(string calldata promptText) external returns (address);;
```

### promptSecret(string) (inherited from VmSafe)

- **Signature**: `promptSecret(string)`
- **Visibility**: external
- **Source Range**: 42485:89:25

**Signature:**
```solidity
/// Prompts the user for a hidden string value in the terminal.
function promptSecret(string calldata promptText) external returns (string memory input);;
```

### promptSecretUint(string) (inherited from VmSafe)

- **Signature**: `promptSecretUint(string)`
- **Visibility**: external
- **Source Range**: 42654:81:25

**Signature:**
```solidity
/// Prompts the user for hidden uint256 in the terminal (usually pk).
function promptSecretUint(string calldata promptText) external returns (uint256);;
```

### promptUint(string) (inherited from VmSafe)

- **Signature**: `promptUint(string)`
- **Visibility**: external
- **Source Range**: 42795:75:25

**Signature:**
```solidity
/// Prompts the user for uint256 in the terminal.
function promptUint(string calldata promptText) external returns (uint256);;
```

### readDir(string) (inherited from VmSafe)

- **Signature**: `readDir(string)`
- **Visibility**: external
- **Source Range**: 43118:89:25

**Signature:**
```solidity
/// Reads the directory at the given path recursively, up to `maxDepth`.
///  `maxDepth` defaults to 1, meaning only the direct children of the given directory will be returned.
///  Follows symbolic links if `followLinks` is true.
function readDir(string calldata path) external view returns (DirEntry[] memory entries);;
```

### readDir(string,uint64) (inherited from VmSafe)

- **Signature**: `readDir(string,uint64)`
- **Visibility**: external
- **Source Range**: 43244:106:25

**Signature:**
```solidity
/// See `readDir(string)`.
function readDir(string calldata path, uint64 maxDepth) external view returns (DirEntry[] memory entries);;
```

### readDir(string,uint64,bool) (inherited from VmSafe)

- **Signature**: `readDir(string,uint64,bool)`
- **Visibility**: external
- **Source Range**: 43387:148:25

**Signature:**
```solidity
/// See `readDir(string)`.
function readDir(string calldata path, uint64 maxDepth, bool followLinks) external view returns (DirEntry[] memory entries);;
```

### readFile(string) (inherited from VmSafe)

- **Signature**: `readFile(string)`
- **Visibility**: external
- **Source Range**: 43633:83:25

**Signature:**
```solidity
/// Reads the entire content of file to string. `path` is relative to the project root.
function readFile(string calldata path) external view returns (string memory data);;
```

### readFileBinary(string) (inherited from VmSafe)

- **Signature**: `readFileBinary(string)`
- **Visibility**: external
- **Source Range**: 43814:88:25

**Signature:**
```solidity
/// Reads the entire content of file as binary. `path` is relative to the project root.
function readFileBinary(string calldata path) external view returns (bytes memory data);;
```

### readLine(string) (inherited from VmSafe)

- **Signature**: `readLine(string)`
- **Visibility**: external
- **Source Range**: 43951:83:25

**Signature:**
```solidity
/// Reads next line of file to string.
function readLine(string calldata path) external view returns (string memory line);;
```

### readLink(string) (inherited from VmSafe)

- **Signature**: `readLink(string)`
- **Visibility**: external
- **Source Range**: 44293:93:25

**Signature:**
```solidity
/// Reads a symbolic link, returning the path that the link points to.
///  This cheatcode will revert in the following situations, but is not limited to just these cases:
///  - `path` is not a symbolic link.
///  - `path` does not exist.
function readLink(string calldata linkPath) external view returns (string memory targetPath);;
```

### removeDir(string,bool) (inherited from VmSafe)

- **Signature**: `removeDir(string,bool)`
- **Visibility**: external
- **Source Range**: 44776:66:25

**Signature:**
```solidity
/// Removes a directory at the provided path.
///  This cheatcode will revert in the following situations, but is not limited to just these cases:
///  - `path` doesn't exist.
///  - `path` isn't a directory.
///  - User lacks permissions to modify `path`.
///  - The directory is not empty and `recursive` is false.
///  `path` is relative to the project root.
function removeDir(string calldata path, bool recursive) external;;
```

### removeFile(string) (inherited from VmSafe)

- **Signature**: `removeFile(string)`
- **Visibility**: external
- **Source Range**: 45175:51:25

**Signature:**
```solidity
/// Removes a file from the filesystem.
///  This cheatcode will revert in the following situations, but is not limited to just these cases:
///  - `path` points to a directory.
///  - The file doesn't exist.
///  - The user lacks permissions to remove the file.
///  `path` is relative to the project root.
function removeFile(string calldata path) external;;
```

### tryFfi(string[]) (inherited from VmSafe)

- **Signature**: `tryFfi(string[])`
- **Visibility**: external
- **Source Range**: 45333:91:25

**Signature:**
```solidity
/// Performs a foreign function call via terminal and returns the exit code, stdout, and stderr.
function tryFfi(string[] calldata commandInput) external returns (FfiResult memory result);;
```

### unixTime() (inherited from VmSafe)

- **Signature**: `unixTime()`
- **Visibility**: external
- **Source Range**: 45489:65:25

**Signature:**
```solidity
/// Returns the time since unix epoch in milliseconds.
function unixTime() external view returns (uint256 milliseconds);;
```

### writeFile(string,string) (inherited from VmSafe)

- **Signature**: `writeFile(string,string)`
- **Visibility**: external
- **Source Range**: 45723:72:25

**Signature:**
```solidity
/// Writes data to file, creating a file if it does not exist, and entirely replacing its contents if it does.
///  `path` is relative to the project root.
function writeFile(string calldata path, string calldata data) external;;
```

### writeFileBinary(string,bytes) (inherited from VmSafe)

- **Signature**: `writeFileBinary(string,bytes)`
- **Visibility**: external
- **Source Range**: 45973:77:25

**Signature:**
```solidity
/// Writes binary data to a file, creating a file if it does not exist, and entirely replacing its contents if it does.
///  `path` is relative to the project root.
function writeFileBinary(string calldata path, bytes calldata data) external;;
```

### writeLine(string,string) (inherited from VmSafe)

- **Signature**: `writeLine(string,string)`
- **Visibility**: external
- **Source Range**: 46171:72:25

**Signature:**
```solidity
/// Writes line to file, creating a file if it does not exist.
///  `path` is relative to the project root.
function writeLine(string calldata path, string calldata data) external;;
```

### keyExistsJson(string,string) (inherited from VmSafe)

- **Signature**: `keyExistsJson(string,string)`
- **Visibility**: external
- **Source Range**: 46329:95:25

**Signature:**
```solidity
/// Checks if `key` exists in a JSON object.
function keyExistsJson(string calldata json, string calldata key) external view returns (bool);;
```

### parseJsonAddress(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonAddress(string,string)`
- **Visibility**: external
- **Source Range**: 46505:101:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `address`.
function parseJsonAddress(string calldata json, string calldata key) external pure returns (address);;
```

### parseJsonAddressArray(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonAddressArray(string,string)`
- **Visibility**: external
- **Source Range**: 46689:139:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `address[]`.
function parseJsonAddressArray(string calldata json, string calldata key) external pure returns (address[] memory);;
```

### parseJsonBool(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonBool(string,string)`
- **Visibility**: external
- **Source Range**: 46906:95:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bool`.
function parseJsonBool(string calldata json, string calldata key) external pure returns (bool);;
```

### parseJsonBoolArray(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonBoolArray(string,string)`
- **Visibility**: external
- **Source Range**: 47081:109:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bool[]`.
function parseJsonBoolArray(string calldata json, string calldata key) external pure returns (bool[] memory);;
```

### parseJsonBytes(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonBytes(string,string)`
- **Visibility**: external
- **Source Range**: 47269:104:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bytes`.
function parseJsonBytes(string calldata json, string calldata key) external pure returns (bytes memory);;
```

### parseJsonBytes32(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonBytes32(string,string)`
- **Visibility**: external
- **Source Range**: 47454:101:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bytes32`.
function parseJsonBytes32(string calldata json, string calldata key) external pure returns (bytes32);;
```

### parseJsonBytes32Array(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonBytes32Array(string,string)`
- **Visibility**: external
- **Source Range**: 47638:139:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bytes32[]`.
function parseJsonBytes32Array(string calldata json, string calldata key) external pure returns (bytes32[] memory);;
```

### parseJsonBytesArray(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonBytesArray(string,string)`
- **Visibility**: external
- **Source Range**: 47858:111:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bytes[]`.
function parseJsonBytesArray(string calldata json, string calldata key) external pure returns (bytes[] memory);;
```

### parseJsonInt(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonInt(string,string)`
- **Visibility**: external
- **Source Range**: 48049:96:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `int256`.
function parseJsonInt(string calldata json, string calldata key) external pure returns (int256);;
```

### parseJsonIntArray(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonIntArray(string,string)`
- **Visibility**: external
- **Source Range**: 48227:110:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `int256[]`.
function parseJsonIntArray(string calldata json, string calldata key) external pure returns (int256[] memory);;
```

### parseJsonKeys(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonKeys(string,string)`
- **Visibility**: external
- **Source Range**: 48402:111:25

**Signature:**
```solidity
/// Returns an array of all the keys in a JSON object.
function parseJsonKeys(string calldata json, string calldata key) external pure returns (string[] memory keys);;
```

### parseJsonString(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonString(string,string)`
- **Visibility**: external
- **Source Range**: 48593:106:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `string`.
function parseJsonString(string calldata json, string calldata key) external pure returns (string memory);;
```

### parseJsonStringArray(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonStringArray(string,string)`
- **Visibility**: external
- **Source Range**: 48781:113:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `string[]`.
function parseJsonStringArray(string calldata json, string calldata key) external pure returns (string[] memory);;
```

### parseJsonTypeArray(string,string,string) (inherited from VmSafe)

- **Signature**: `parseJsonTypeArray(string,string,string)`
- **Visibility**: external
- **Source Range**: 49011:165:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to type array corresponding to `typeDescription`.
function parseJsonTypeArray(string calldata json, string calldata key, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseJsonType(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonType(string,string)`
- **Visibility**: external
- **Source Range**: 49278:139:25

**Signature:**
```solidity
/// Parses a string of JSON data and coerces it to type corresponding to `typeDescription`.
function parseJsonType(string calldata json, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseJsonType(string,string,string) (inherited from VmSafe)

- **Signature**: `parseJsonType(string,string,string)`
- **Visibility**: external
- **Source Range**: 49528:160:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to type corresponding to `typeDescription`.
function parseJsonType(string calldata json, string calldata key, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseJsonUint(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonUint(string,string)`
- **Visibility**: external
- **Source Range**: 49769:98:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `uint256`.
function parseJsonUint(string calldata json, string calldata key) external pure returns (uint256);;
```

### parseJsonUintArray(string,string) (inherited from VmSafe)

- **Signature**: `parseJsonUintArray(string,string)`
- **Visibility**: external
- **Source Range**: 49950:112:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `uint256[]`.
function parseJsonUintArray(string calldata json, string calldata key) external pure returns (uint256[] memory);;
```

### parseJson(string) (inherited from VmSafe)

- **Signature**: `parseJson(string)`
- **Visibility**: external
- **Source Range**: 50103:93:25

**Signature:**
```solidity
/// ABI-encodes a JSON object.
function parseJson(string calldata json) external pure returns (bytes memory abiEncodedData);;
```

### parseJson(string,string) (inherited from VmSafe)

- **Signature**: `parseJson(string,string)`
- **Visibility**: external
- **Source Range**: 50246:114:25

**Signature:**
```solidity
/// ABI-encodes a JSON object at `key`.
function parseJson(string calldata json, string calldata key) external pure returns (bytes memory abiEncodedData);;
```

### serializeAddress(string,string,address) (inherited from VmSafe)

- **Signature**: `serializeAddress(string,string,address)`
- **Visibility**: external
- **Source Range**: 50395:148:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeAddress(string calldata objectKey, string calldata valueKey, address value) external returns (string memory json);;
```

### serializeAddress(string,string,address[]) (inherited from VmSafe)

- **Signature**: `serializeAddress(string,string,address[])`
- **Visibility**: external
- **Source Range**: 50578:160:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeAddress(string calldata objectKey, string calldata valueKey, address[] calldata values) external returns (string memory json);;
```

### serializeBool(string,string,bool) (inherited from VmSafe)

- **Signature**: `serializeBool(string,string,bool)`
- **Visibility**: external
- **Source Range**: 50773:142:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBool(string calldata objectKey, string calldata valueKey, bool value) external returns (string memory json);;
```

### serializeBool(string,string,bool[]) (inherited from VmSafe)

- **Signature**: `serializeBool(string,string,bool[])`
- **Visibility**: external
- **Source Range**: 50950:154:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBool(string calldata objectKey, string calldata valueKey, bool[] calldata values) external returns (string memory json);;
```

### serializeBytes32(string,string,bytes32) (inherited from VmSafe)

- **Signature**: `serializeBytes32(string,string,bytes32)`
- **Visibility**: external
- **Source Range**: 51139:148:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBytes32(string calldata objectKey, string calldata valueKey, bytes32 value) external returns (string memory json);;
```

### serializeBytes32(string,string,bytes32[]) (inherited from VmSafe)

- **Signature**: `serializeBytes32(string,string,bytes32[])`
- **Visibility**: external
- **Source Range**: 51322:160:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBytes32(string calldata objectKey, string calldata valueKey, bytes32[] calldata values) external returns (string memory json);;
```

### serializeBytes(string,string,bytes) (inherited from VmSafe)

- **Signature**: `serializeBytes(string,string,bytes)`
- **Visibility**: external
- **Source Range**: 51517:153:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBytes(string calldata objectKey, string calldata valueKey, bytes calldata value) external returns (string memory json);;
```

### serializeBytes(string,string,bytes[]) (inherited from VmSafe)

- **Signature**: `serializeBytes(string,string,bytes[])`
- **Visibility**: external
- **Source Range**: 51705:156:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBytes(string calldata objectKey, string calldata valueKey, bytes[] calldata values) external returns (string memory json);;
```

### serializeInt(string,string,int256) (inherited from VmSafe)

- **Signature**: `serializeInt(string,string,int256)`
- **Visibility**: external
- **Source Range**: 51896:143:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeInt(string calldata objectKey, string calldata valueKey, int256 value) external returns (string memory json);;
```

### serializeInt(string,string,int256[]) (inherited from VmSafe)

- **Signature**: `serializeInt(string,string,int256[])`
- **Visibility**: external
- **Source Range**: 52074:155:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeInt(string calldata objectKey, string calldata valueKey, int256[] calldata values) external returns (string memory json);;
```

### serializeJson(string,string) (inherited from VmSafe)

- **Signature**: `serializeJson(string,string)`
- **Visibility**: external
- **Source Range**: 52426:111:25

**Signature:**
```solidity
/// Serializes a key and value to a JSON object stored in-memory that can be later written to a file.
///  Returns the stringified version of the specific JSON file up to that moment.
function serializeJson(string calldata objectKey, string calldata value) external returns (string memory json);;
```

### serializeJsonType(string,bytes) (inherited from VmSafe)

- **Signature**: `serializeJsonType(string,bytes)`
- **Visibility**: external
- **Source Range**: 52572:149:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeJsonType(string calldata typeDescription, bytes calldata value) external pure returns (string memory json);;
```

### serializeJsonType(string,string,string,bytes) (inherited from VmSafe)

- **Signature**: `serializeJsonType(string,string,string,bytes)`
- **Visibility**: external
- **Source Range**: 52756:211:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeJsonType(string calldata objectKey, string calldata valueKey, string calldata typeDescription, bytes calldata value) external returns (string memory json);;
```

### serializeString(string,string,string) (inherited from VmSafe)

- **Signature**: `serializeString(string,string,string)`
- **Visibility**: external
- **Source Range**: 53002:155:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeString(string calldata objectKey, string calldata valueKey, string calldata value) external returns (string memory json);;
```

### serializeString(string,string,string[]) (inherited from VmSafe)

- **Signature**: `serializeString(string,string,string[])`
- **Visibility**: external
- **Source Range**: 53192:158:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeString(string calldata objectKey, string calldata valueKey, string[] calldata values) external returns (string memory json);;
```

### serializeUintToHex(string,string,uint256) (inherited from VmSafe)

- **Signature**: `serializeUintToHex(string,string,uint256)`
- **Visibility**: external
- **Source Range**: 53385:150:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeUintToHex(string calldata objectKey, string calldata valueKey, uint256 value) external returns (string memory json);;
```

### serializeUint(string,string,uint256) (inherited from VmSafe)

- **Signature**: `serializeUint(string,string,uint256)`
- **Visibility**: external
- **Source Range**: 53570:145:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeUint(string calldata objectKey, string calldata valueKey, uint256 value) external returns (string memory json);;
```

### serializeUint(string,string,uint256[]) (inherited from VmSafe)

- **Signature**: `serializeUint(string,string,uint256[])`
- **Visibility**: external
- **Source Range**: 53750:157:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeUint(string calldata objectKey, string calldata valueKey, uint256[] calldata values) external returns (string memory json);;
```

### writeJson(string,string) (inherited from VmSafe)

- **Signature**: `writeJson(string,string)`
- **Visibility**: external
- **Source Range**: 54007:72:25

**Signature:**
```solidity
/// Write a serialized JSON object to a file. If the file exists, it will be overwritten.
function writeJson(string calldata json, string calldata path) external;;
```

### writeJson(string,string,string) (inherited from VmSafe)

- **Signature**: `writeJson(string,string,string)`
- **Visibility**: external
- **Source Range**: 54305:98:25

**Signature:**
```solidity
/// Write a serialized JSON object to an **existing** JSON file, replacing a value with key = <value_key.>
///  This is useful to replace a specific value of a JSON file, without having to parse the entire thing.
function writeJson(string calldata json, string calldata path, string calldata valueKey) external;;
```

### keyExists(string,string) (inherited from VmSafe)

- **Signature**: `keyExists(string,string)`
- **Visibility**: external
- **Source Range**: 54565:91:25

**Signature:**
```solidity
/// Checks if `key` exists in a JSON object
///  `keyExists` is being deprecated in favor of `keyExistsJson`. It will be removed in future versions.
function keyExists(string calldata json, string calldata key) external view returns (bool);;
```

### attachBlob(bytes) (inherited from VmSafe)

- **Signature**: `attachBlob(bytes)`
- **Visibility**: external
- **Source Range**: 54747:50:25

**Signature:**
```solidity
/// Attach an EIP-4844 blob to the next call
function attachBlob(bytes calldata blob) external;;
```

### attachDelegation(struct VmSafe.SignedDelegation) (inherited from VmSafe)

- **Signature**: `attachDelegation(struct VmSafe.SignedDelegation)`
- **Visibility**: external
- **Source Range**: 54862:79:25

**Signature:**
```solidity
/// Designate the next call as an EIP-7702 transaction
function attachDelegation(SignedDelegation calldata signedDelegation) external;;
```

### attachDelegation(struct VmSafe.SignedDelegation,bool) (inherited from VmSafe)

- **Signature**: `attachDelegation(struct VmSafe.SignedDelegation,bool)`
- **Visibility**: external
- **Source Range**: 55043:96:25

**Signature:**
```solidity
/// Designate the next call as an EIP-7702 transaction, with optional cross-chain validity.
function attachDelegation(SignedDelegation calldata signedDelegation, bool crossChain) external;;
```

### broadcastRawTransaction(bytes) (inherited from VmSafe)

- **Signature**: `broadcastRawTransaction(bytes)`
- **Visibility**: external
- **Source Range**: 55214:63:25

**Signature:**
```solidity
/// Takes a signed transaction and broadcasts it to the network.
function broadcastRawTransaction(bytes calldata data) external;;
```

### broadcast() (inherited from VmSafe)

- **Signature**: `broadcast()`
- **Visibility**: external
- **Source Range**: 55780:30:25

**Signature:**
```solidity
/// Has the next call (at this call depth only) create transactions that can later be signed and sent onchain.
///  Broadcasting address is determined by checking the following in order:
///  1. If `--sender` argument was provided, that address is used.
///  2. If exactly one signer (e.g. private key, hw wallet, keystore) is set when `forge broadcast` is invoked, that signer is used.
///  3. Otherwise, default foundry sender (1804c8AB1F12E6bbf3894d4083f33e07309d1f38) is used.
function broadcast() external;;
```

### broadcast(address) (inherited from VmSafe)

- **Signature**: `broadcast(address)`
- **Visibility**: external
- **Source Range**: 55980:44:25

**Signature:**
```solidity
/// Has the next call (at this call depth only) create a transaction with the address provided
///  as the sender that can later be signed and sent onchain.
function broadcast(address signer) external;;
```

### broadcast(uint256) (inherited from VmSafe)

- **Signature**: `broadcast(uint256)`
- **Visibility**: external
- **Source Range**: 56198:48:25

**Signature:**
```solidity
/// Has the next call (at this call depth only) create a transaction with the private key
///  provided as the sender that can later be signed and sent onchain.
function broadcast(uint256 privateKey) external;;
```

### getWallets() (inherited from VmSafe)

- **Signature**: `getWallets()`
- **Visibility**: external
- **Source Range**: 56335:66:25

**Signature:**
```solidity
/// Returns addresses of available unlocked wallets in the script environment.
function getWallets() external returns (address[] memory wallets);;
```

### signAndAttachDelegation(address,uint256) (inherited from VmSafe)

- **Signature**: `signAndAttachDelegation(address,uint256)`
- **Visibility**: external
- **Source Range**: 56501:153:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization and designate the next call as an EIP-7702 transaction
function signAndAttachDelegation(address implementation, uint256 privateKey) external returns (SignedDelegation memory signedDelegation);;
```

### signAndAttachDelegation(address,uint256,uint64) (inherited from VmSafe)

- **Signature**: `signAndAttachDelegation(address,uint256,uint64)`
- **Visibility**: external
- **Source Range**: 56773:167:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization and designate the next call as an EIP-7702 transaction for specific nonce
function signAndAttachDelegation(address implementation, uint256 privateKey, uint64 nonce) external returns (SignedDelegation memory signedDelegation);;
```

### signAndAttachDelegation(address,uint256,bool) (inherited from VmSafe)

- **Signature**: `signAndAttachDelegation(address,uint256,bool)`
- **Visibility**: external
- **Source Range**: 57077:170:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization and designate the next call as an EIP-7702 transaction, with optional cross-chain validity.
function signAndAttachDelegation(address implementation, uint256 privateKey, bool crossChain) external returns (SignedDelegation memory signedDelegation);;
```

### signDelegation(address,uint256) (inherited from VmSafe)

- **Signature**: `signDelegation(address,uint256)`
- **Visibility**: external
- **Source Range**: 57307:144:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization for delegation
function signDelegation(address implementation, uint256 privateKey) external returns (SignedDelegation memory signedDelegation);;
```

### signDelegation(address,uint256,uint64) (inherited from VmSafe)

- **Signature**: `signDelegation(address,uint256,uint64)`
- **Visibility**: external
- **Source Range**: 57530:158:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization for delegation for specific nonce
function signDelegation(address implementation, uint256 privateKey, uint64 nonce) external returns (SignedDelegation memory signedDelegation);;
```

### signDelegation(address,uint256,bool) (inherited from VmSafe)

- **Signature**: `signDelegation(address,uint256,bool)`
- **Visibility**: external
- **Source Range**: 57785:161:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization for delegation, with optional cross-chain validity.
function signDelegation(address implementation, uint256 privateKey, bool crossChain) external returns (SignedDelegation memory signedDelegation);;
```

### startBroadcast() (inherited from VmSafe)

- **Signature**: `startBroadcast()`
- **Visibility**: external
- **Source Range**: 58456:35:25

**Signature:**
```solidity
/// Has all subsequent calls (at this call depth only) create transactions that can later be signed and sent onchain.
///  Broadcasting address is determined by checking the following in order:
///  1. If `--sender` argument was provided, that address is used.
///  2. If exactly one signer (e.g. private key, hw wallet, keystore) is set when `forge broadcast` is invoked, that signer is used.
///  3. Otherwise, default foundry sender (1804c8AB1F12E6bbf3894d4083f33e07309d1f38) is used.
function startBroadcast() external;;
```

### startBroadcast(address) (inherited from VmSafe)

- **Signature**: `startBroadcast(address)`
- **Visibility**: external
- **Source Range**: 58653:49:25

**Signature:**
```solidity
/// Has all subsequent calls (at this call depth only) create transactions with the address
///  provided that can later be signed and sent onchain.
function startBroadcast(address signer) external;;
```

### startBroadcast(uint256) (inherited from VmSafe)

- **Signature**: `startBroadcast(uint256)`
- **Visibility**: external
- **Source Range**: 58868:53:25

**Signature:**
```solidity
/// Has all subsequent calls (at this call depth only) create transactions with the private key
///  provided that can later be signed and sent onchain.
function startBroadcast(uint256 privateKey) external;;
```

### stopBroadcast() (inherited from VmSafe)

- **Signature**: `stopBroadcast()`
- **Visibility**: external
- **Source Range**: 58974:34:25

**Signature:**
```solidity
/// Stops collecting onchain transactions.
function stopBroadcast() external;;
```

### contains(string,string) (inherited from VmSafe)

- **Signature**: `contains(string,string)`
- **Visibility**: external
- **Source Range**: 59120:98:25

**Signature:**
```solidity
/// Returns true if `search` is found in `subject`, false otherwise.
function contains(string calldata subject, string calldata search) external returns (bool result);;
```

### indexOf(string,string) (inherited from VmSafe)

- **Signature**: `indexOf(string,string)`
- **Visibility**: external
- **Source Range**: 59434:93:25

**Signature:**
```solidity
/// Returns the index of the first occurrence of a `key` in an `input` string.
///  Returns `NOT_FOUND` (i.e. `type(uint256).max`) if the `key` is not found.
///  Returns 0 in case of an empty `key`.
function indexOf(string calldata input, string calldata key) external pure returns (uint256);;
```

### parseAddress(string) (inherited from VmSafe)

- **Signature**: `parseAddress(string)`
- **Visibility**: external
- **Source Range**: 59586:100:25

**Signature:**
```solidity
/// Parses the given `string` into an `address`.
function parseAddress(string calldata stringifiedValue) external pure returns (address parsedValue);;
```

### parseBool(string) (inherited from VmSafe)

- **Signature**: `parseBool(string)`
- **Visibility**: external
- **Source Range**: 59741:94:25

**Signature:**
```solidity
/// Parses the given `string` into a `bool`.
function parseBool(string calldata stringifiedValue) external pure returns (bool parsedValue);;
```

### parseBytes(string) (inherited from VmSafe)

- **Signature**: `parseBytes(string)`
- **Visibility**: external
- **Source Range**: 59889:103:25

**Signature:**
```solidity
/// Parses the given `string` into `bytes`.
function parseBytes(string calldata stringifiedValue) external pure returns (bytes memory parsedValue);;
```

### parseBytes32(string) (inherited from VmSafe)

- **Signature**: `parseBytes32(string)`
- **Visibility**: external
- **Source Range**: 60050:100:25

**Signature:**
```solidity
/// Parses the given `string` into a `bytes32`.
function parseBytes32(string calldata stringifiedValue) external pure returns (bytes32 parsedValue);;
```

### parseInt(string) (inherited from VmSafe)

- **Signature**: `parseInt(string)`
- **Visibility**: external
- **Source Range**: 60207:95:25

**Signature:**
```solidity
/// Parses the given `string` into a `int256`.
function parseInt(string calldata stringifiedValue) external pure returns (int256 parsedValue);;
```

### parseUint(string) (inherited from VmSafe)

- **Signature**: `parseUint(string)`
- **Visibility**: external
- **Source Range**: 60360:97:25

**Signature:**
```solidity
/// Parses the given `string` into a `uint256`.
function parseUint(string calldata stringifiedValue) external pure returns (uint256 parsedValue);;
```

### replace(string,string,string) (inherited from VmSafe)

- **Signature**: `replace(string,string,string)`
- **Visibility**: external
- **Source Range**: 60535:151:25

**Signature:**
```solidity
/// Replaces occurrences of `from` in the given `string` with `to`.
function replace(string calldata input, string calldata from, string calldata to) external pure returns (string memory output);;
```

### split(string,string) (inherited from VmSafe)

- **Signature**: `split(string,string)`
- **Visibility**: external
- **Source Range**: 60779:113:25

**Signature:**
```solidity
/// Splits the given `string` into an array of strings divided by the `delimiter`.
function split(string calldata input, string calldata delimiter) external pure returns (string[] memory outputs);;
```

### toLowercase(string) (inherited from VmSafe)

- **Signature**: `toLowercase(string)`
- **Visibility**: external
- **Source Range**: 60954:89:25

**Signature:**
```solidity
/// Converts the given `string` value to Lowercase.
function toLowercase(string calldata input) external pure returns (string memory output);;
```

### toString(address) (inherited from VmSafe)

- **Signature**: `toString(address)`
- **Visibility**: external
- **Source Range**: 61097:88:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(address value) external pure returns (string memory stringifiedValue);;
```

### toString(bytes) (inherited from VmSafe)

- **Signature**: `toString(bytes)`
- **Visibility**: external
- **Source Range**: 61239:95:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(bytes calldata value) external pure returns (string memory stringifiedValue);;
```

### toString(bytes32) (inherited from VmSafe)

- **Signature**: `toString(bytes32)`
- **Visibility**: external
- **Source Range**: 61388:88:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(bytes32 value) external pure returns (string memory stringifiedValue);;
```

### toString(bool) (inherited from VmSafe)

- **Signature**: `toString(bool)`
- **Visibility**: external
- **Source Range**: 61530:85:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(bool value) external pure returns (string memory stringifiedValue);;
```

### toString(uint256) (inherited from VmSafe)

- **Signature**: `toString(uint256)`
- **Visibility**: external
- **Source Range**: 61669:88:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(uint256 value) external pure returns (string memory stringifiedValue);;
```

### toString(int256) (inherited from VmSafe)

- **Signature**: `toString(int256)`
- **Visibility**: external
- **Source Range**: 61811:87:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(int256 value) external pure returns (string memory stringifiedValue);;
```

### toUppercase(string) (inherited from VmSafe)

- **Signature**: `toUppercase(string)`
- **Visibility**: external
- **Source Range**: 61960:89:25

**Signature:**
```solidity
/// Converts the given `string` value to Uppercase.
function toUppercase(string calldata input) external pure returns (string memory output);;
```

### trim(string) (inherited from VmSafe)

- **Signature**: `trim(string)`
- **Visibility**: external
- **Source Range**: 62132:82:25

**Signature:**
```solidity
/// Trims leading and trailing whitespace from the given `string` value.
function trim(string calldata input) external pure returns (string memory output);;
```

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 62409:113:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
///  Formats values with decimals in failure message.
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals) external pure;;
```

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 62737:182:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string calldata error) external pure;;
```

### assertApproxEqAbsDecimal(int256,int256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertApproxEqAbsDecimal(int256,int256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 63079:111:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
///  Formats values with decimals in failure message.
function assertApproxEqAbsDecimal(int256 left, int256 right, uint256 maxDelta, uint256 decimals) external pure;;
```

### assertApproxEqAbsDecimal(int256,int256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertApproxEqAbsDecimal(int256,int256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 63404:180:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertApproxEqAbsDecimal(int256 left, int256 right, uint256 maxDelta, uint256 decimals, string calldata error) external pure;;
```

### assertApproxEqAbs(uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertApproxEqAbs(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 63688:88:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta) external pure;;
```

### assertApproxEqAbs(uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertApproxEqAbs(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 63942:111:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
///  Includes error message into revert string on failure.
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta, string calldata error) external pure;;
```

### assertApproxEqAbs(int256,int256,uint256) (inherited from VmSafe)

- **Signature**: `assertApproxEqAbs(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 64156:86:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
function assertApproxEqAbs(int256 left, int256 right, uint256 maxDelta) external pure;;
```

### assertApproxEqAbs(int256,int256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertApproxEqAbs(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 64407:109:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
///  Includes error message into revert string on failure.
function assertApproxEqAbs(int256 left, int256 right, uint256 maxDelta, string calldata error) external pure;;
```

### assertApproxEqRelDecimal(uint256,uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertApproxEqRelDecimal(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 64787:136:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
///  Formats values with decimals in failure message.
function assertApproxEqRelDecimal(uint256 left, uint256 right, uint256 maxPercentDelta, uint256 decimals) external pure;;
```

### assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 65248:189:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertApproxEqRelDecimal(uint256 left, uint256 right, uint256 maxPercentDelta, uint256 decimals, string calldata error) external pure;;
```

### assertApproxEqRelDecimal(int256,int256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertApproxEqRelDecimal(int256,int256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 65707:134:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
///  Formats values with decimals in failure message.
function assertApproxEqRelDecimal(int256 left, int256 right, uint256 maxPercentDelta, uint256 decimals) external pure;;
```

### assertApproxEqRelDecimal(int256,int256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertApproxEqRelDecimal(int256,int256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 66165:187:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertApproxEqRelDecimal(int256 left, int256 right, uint256 maxPercentDelta, uint256 decimals, string calldata error) external pure;;
```

### assertApproxEqRel(uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertApproxEqRel(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 66566:95:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
function assertApproxEqRel(uint256 left, uint256 right, uint256 maxPercentDelta) external pure;;
```

### assertApproxEqRel(uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertApproxEqRel(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 66937:134:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
///  Includes error message into revert string on failure.
function assertApproxEqRel(uint256 left, uint256 right, uint256 maxPercentDelta, string calldata error) external pure;;
```

### assertApproxEqRel(int256,int256,uint256) (inherited from VmSafe)

- **Signature**: `assertApproxEqRel(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 67284:93:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
function assertApproxEqRel(int256 left, int256 right, uint256 maxPercentDelta) external pure;;
```

### assertApproxEqRel(int256,int256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertApproxEqRel(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 67652:132:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
///  Includes error message into revert string on failure.
function assertApproxEqRel(int256 left, int256 right, uint256 maxPercentDelta, string calldata error) external pure;;
```

### assertEqDecimal(uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertEqDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 67893:86:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are equal, formatting them with decimals in failure message.
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertEqDecimal(uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertEqDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 68150:109:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are equal, formatting them with decimals in failure message.
///  Includes error message into revert string on failure.
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertEqDecimal(int256,int256,uint256) (inherited from VmSafe)

- **Signature**: `assertEqDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 68367:84:25

**Signature:**
```solidity
/// Asserts that two `int256` values are equal, formatting them with decimals in failure message.
function assertEqDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertEqDecimal(int256,int256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertEqDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 68621:107:25

**Signature:**
```solidity
/// Asserts that two `int256` values are equal, formatting them with decimals in failure message.
///  Includes error message into revert string on failure.
function assertEqDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertEq(bool,bool) (inherited from VmSafe)

- **Signature**: `assertEq(bool,bool)`
- **Visibility**: external
- **Source Range**: 68784:55:25

**Signature:**
```solidity
/// Asserts that two `bool` values are equal.
function assertEq(bool left, bool right) external pure;;
```

### assertEq(bool,bool,string) (inherited from VmSafe)

- **Signature**: `assertEq(bool,bool,string)`
- **Visibility**: external
- **Source Range**: 68952:78:25

**Signature:**
```solidity
/// Asserts that two `bool` values are equal and includes error message into revert string on failure.
function assertEq(bool left, bool right, string calldata error) external pure;;
```

### assertEq(string,string) (inherited from VmSafe)

- **Signature**: `assertEq(string,string)`
- **Visibility**: external
- **Source Range**: 69088:77:25

**Signature:**
```solidity
/// Asserts that two `string` values are equal.
function assertEq(string calldata left, string calldata right) external pure;;
```

### assertEq(string,string,string) (inherited from VmSafe)

- **Signature**: `assertEq(string,string,string)`
- **Visibility**: external
- **Source Range**: 69280:100:25

**Signature:**
```solidity
/// Asserts that two `string` values are equal and includes error message into revert string on failure.
function assertEq(string calldata left, string calldata right, string calldata error) external pure;;
```

### assertEq(bytes,bytes) (inherited from VmSafe)

- **Signature**: `assertEq(bytes,bytes)`
- **Visibility**: external
- **Source Range**: 69437:75:25

**Signature:**
```solidity
/// Asserts that two `bytes` values are equal.
function assertEq(bytes calldata left, bytes calldata right) external pure;;
```

### assertEq(bytes,bytes,string) (inherited from VmSafe)

- **Signature**: `assertEq(bytes,bytes,string)`
- **Visibility**: external
- **Source Range**: 69626:98:25

**Signature:**
```solidity
/// Asserts that two `bytes` values are equal and includes error message into revert string on failure.
function assertEq(bytes calldata left, bytes calldata right, string calldata error) external pure;;
```

### assertEq(bool[],bool[]) (inherited from VmSafe)

- **Signature**: `assertEq(bool[],bool[])`
- **Visibility**: external
- **Source Range**: 69790:77:25

**Signature:**
```solidity
/// Asserts that two arrays of `bool` values are equal.
function assertEq(bool[] calldata left, bool[] calldata right) external pure;;
```

### assertEq(bool[],bool[],string) (inherited from VmSafe)

- **Signature**: `assertEq(bool[],bool[],string)`
- **Visibility**: external
- **Source Range**: 69990:100:25

**Signature:**
```solidity
/// Asserts that two arrays of `bool` values are equal and includes error message into revert string on failure.
function assertEq(bool[] calldata left, bool[] calldata right, string calldata error) external pure;;
```

### assertEq(uint256[],uint256[]) (inherited from VmSafe)

- **Signature**: `assertEq(uint256[],uint256[])`
- **Visibility**: external
- **Source Range**: 70158:83:25

**Signature:**
```solidity
/// Asserts that two arrays of `uint256 values are equal.
function assertEq(uint256[] calldata left, uint256[] calldata right) external pure;;
```

### assertEq(uint256[],uint256[],string) (inherited from VmSafe)

- **Signature**: `assertEq(uint256[],uint256[],string)`
- **Visibility**: external
- **Source Range**: 70367:106:25

**Signature:**
```solidity
/// Asserts that two arrays of `uint256` values are equal and includes error message into revert string on failure.
function assertEq(uint256[] calldata left, uint256[] calldata right, string calldata error) external pure;;
```

### assertEq(int256[],int256[]) (inherited from VmSafe)

- **Signature**: `assertEq(int256[],int256[])`
- **Visibility**: external
- **Source Range**: 70541:81:25

**Signature:**
```solidity
/// Asserts that two arrays of `int256` values are equal.
function assertEq(int256[] calldata left, int256[] calldata right) external pure;;
```

### assertEq(int256[],int256[],string) (inherited from VmSafe)

- **Signature**: `assertEq(int256[],int256[],string)`
- **Visibility**: external
- **Source Range**: 70747:104:25

**Signature:**
```solidity
/// Asserts that two arrays of `int256` values are equal and includes error message into revert string on failure.
function assertEq(int256[] calldata left, int256[] calldata right, string calldata error) external pure;;
```

### assertEq(uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertEq(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 70910:61:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are equal.
function assertEq(uint256 left, uint256 right) external pure;;
```

### assertEq(address[],address[]) (inherited from VmSafe)

- **Signature**: `assertEq(address[],address[])`
- **Visibility**: external
- **Source Range**: 71040:83:25

**Signature:**
```solidity
/// Asserts that two arrays of `address` values are equal.
function assertEq(address[] calldata left, address[] calldata right) external pure;;
```

### assertEq(address[],address[],string) (inherited from VmSafe)

- **Signature**: `assertEq(address[],address[],string)`
- **Visibility**: external
- **Source Range**: 71249:106:25

**Signature:**
```solidity
/// Asserts that two arrays of `address` values are equal and includes error message into revert string on failure.
function assertEq(address[] calldata left, address[] calldata right, string calldata error) external pure;;
```

### assertEq(bytes32[],bytes32[]) (inherited from VmSafe)

- **Signature**: `assertEq(bytes32[],bytes32[])`
- **Visibility**: external
- **Source Range**: 71424:83:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes32` values are equal.
function assertEq(bytes32[] calldata left, bytes32[] calldata right) external pure;;
```

### assertEq(bytes32[],bytes32[],string) (inherited from VmSafe)

- **Signature**: `assertEq(bytes32[],bytes32[],string)`
- **Visibility**: external
- **Source Range**: 71633:106:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes32` values are equal and includes error message into revert string on failure.
function assertEq(bytes32[] calldata left, bytes32[] calldata right, string calldata error) external pure;;
```

### assertEq(string[],string[]) (inherited from VmSafe)

- **Signature**: `assertEq(string[],string[])`
- **Visibility**: external
- **Source Range**: 71807:81:25

**Signature:**
```solidity
/// Asserts that two arrays of `string` values are equal.
function assertEq(string[] calldata left, string[] calldata right) external pure;;
```

### assertEq(string[],string[],string) (inherited from VmSafe)

- **Signature**: `assertEq(string[],string[],string)`
- **Visibility**: external
- **Source Range**: 72013:104:25

**Signature:**
```solidity
/// Asserts that two arrays of `string` values are equal and includes error message into revert string on failure.
function assertEq(string[] calldata left, string[] calldata right, string calldata error) external pure;;
```

### assertEq(bytes[],bytes[]) (inherited from VmSafe)

- **Signature**: `assertEq(bytes[],bytes[])`
- **Visibility**: external
- **Source Range**: 72184:79:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes` values are equal.
function assertEq(bytes[] calldata left, bytes[] calldata right) external pure;;
```

### assertEq(bytes[],bytes[],string) (inherited from VmSafe)

- **Signature**: `assertEq(bytes[],bytes[],string)`
- **Visibility**: external
- **Source Range**: 72387:102:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes` values are equal and includes error message into revert string on failure.
function assertEq(bytes[] calldata left, bytes[] calldata right, string calldata error) external pure;;
```

### assertEq(uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertEq(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 72605:84:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are equal and includes error message into revert string on failure.
function assertEq(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertEq(int256,int256) (inherited from VmSafe)

- **Signature**: `assertEq(int256,int256)`
- **Visibility**: external
- **Source Range**: 72747:59:25

**Signature:**
```solidity
/// Asserts that two `int256` values are equal.
function assertEq(int256 left, int256 right) external pure;;
```

### assertEq(int256,int256,string) (inherited from VmSafe)

- **Signature**: `assertEq(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 72921:82:25

**Signature:**
```solidity
/// Asserts that two `int256` values are equal and includes error message into revert string on failure.
function assertEq(int256 left, int256 right, string calldata error) external pure;;
```

### assertEq(address,address) (inherited from VmSafe)

- **Signature**: `assertEq(address,address)`
- **Visibility**: external
- **Source Range**: 73062:61:25

**Signature:**
```solidity
/// Asserts that two `address` values are equal.
function assertEq(address left, address right) external pure;;
```

### assertEq(address,address,string) (inherited from VmSafe)

- **Signature**: `assertEq(address,address,string)`
- **Visibility**: external
- **Source Range**: 73239:84:25

**Signature:**
```solidity
/// Asserts that two `address` values are equal and includes error message into revert string on failure.
function assertEq(address left, address right, string calldata error) external pure;;
```

### assertEq(bytes32,bytes32) (inherited from VmSafe)

- **Signature**: `assertEq(bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 73382:61:25

**Signature:**
```solidity
/// Asserts that two `bytes32` values are equal.
function assertEq(bytes32 left, bytes32 right) external pure;;
```

### assertEq(bytes32,bytes32,string) (inherited from VmSafe)

- **Signature**: `assertEq(bytes32,bytes32,string)`
- **Visibility**: external
- **Source Range**: 73559:84:25

**Signature:**
```solidity
/// Asserts that two `bytes32` values are equal and includes error message into revert string on failure.
function assertEq(bytes32 left, bytes32 right, string calldata error) external pure;;
```

### assertFalse(bool) (inherited from VmSafe)

- **Signature**: `assertFalse(bool)`
- **Visibility**: external
- **Source Range**: 73700:51:25

**Signature:**
```solidity
/// Asserts that the given condition is false.
function assertFalse(bool condition) external pure;;
```

### assertFalse(bool,string) (inherited from VmSafe)

- **Signature**: `assertFalse(bool,string)`
- **Visibility**: external
- **Source Range**: 73865:74:25

**Signature:**
```solidity
/// Asserts that the given condition is false and includes error message into revert string on failure.
function assertFalse(bool condition, string calldata error) external pure;;
```

### assertGeDecimal(uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertGeDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 74100:86:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than or equal to second.
///  Formats values with decimals in failure message.
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertGeDecimal(uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertGeDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 74401:109:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than or equal to second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertGeDecimal(int256,int256,uint256) (inherited from VmSafe)

- **Signature**: `assertGeDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 74670:84:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than or equal to second.
///  Formats values with decimals in failure message.
function assertGeDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertGeDecimal(int256,int256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertGeDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 74968:107:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than or equal to second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertGeDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertGe(uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertGe(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 75179:61:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than or equal to second.
function assertGe(uint256 left, uint256 right) external pure;;
```

### assertGe(uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertGe(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 75406:84:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than or equal to second.
///  Includes error message into revert string on failure.
function assertGe(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertGe(int256,int256) (inherited from VmSafe)

- **Signature**: `assertGe(int256,int256)`
- **Visibility**: external
- **Source Range**: 75593:59:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than or equal to second.
function assertGe(int256 left, int256 right) external pure;;
```

### assertGe(int256,int256,string) (inherited from VmSafe)

- **Signature**: `assertGe(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 75817:82:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than or equal to second.
///  Includes error message into revert string on failure.
function assertGe(int256 left, int256 right, string calldata error) external pure;;
```

### assertGtDecimal(uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertGtDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 76048:86:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than second.
///  Formats values with decimals in failure message.
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertGtDecimal(uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertGtDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 76337:109:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertGtDecimal(int256,int256,uint256) (inherited from VmSafe)

- **Signature**: `assertGtDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 76594:84:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than second.
///  Formats values with decimals in failure message.
function assertGtDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertGtDecimal(int256,int256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertGtDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 76880:107:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertGtDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertGt(uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertGt(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 77079:61:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than second.
function assertGt(uint256 left, uint256 right) external pure;;
```

### assertGt(uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertGt(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 77294:84:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than second.
///  Includes error message into revert string on failure.
function assertGt(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertGt(int256,int256) (inherited from VmSafe)

- **Signature**: `assertGt(int256,int256)`
- **Visibility**: external
- **Source Range**: 77469:59:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than second.
function assertGt(int256 left, int256 right) external pure;;
```

### assertGt(int256,int256,string) (inherited from VmSafe)

- **Signature**: `assertGt(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 77681:82:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than second.
///  Includes error message into revert string on failure.
function assertGt(int256 left, int256 right, string calldata error) external pure;;
```

### assertLeDecimal(uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertLeDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 77921:86:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than or equal to second.
///  Formats values with decimals in failure message.
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertLeDecimal(uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertLeDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 78219:109:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than or equal to second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertLeDecimal(int256,int256,uint256) (inherited from VmSafe)

- **Signature**: `assertLeDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 78485:84:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than or equal to second.
///  Formats values with decimals in failure message.
function assertLeDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertLeDecimal(int256,int256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertLeDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 78780:107:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than or equal to second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertLeDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertLe(uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertLe(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 78988:61:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than or equal to second.
function assertLe(uint256 left, uint256 right) external pure;;
```

### assertLe(uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertLe(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 79212:84:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than or equal to second.
///  Includes error message into revert string on failure.
function assertLe(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertLe(int256,int256) (inherited from VmSafe)

- **Signature**: `assertLe(int256,int256)`
- **Visibility**: external
- **Source Range**: 79396:59:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than or equal to second.
function assertLe(int256 left, int256 right) external pure;;
```

### assertLe(int256,int256,string) (inherited from VmSafe)

- **Signature**: `assertLe(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 79617:82:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than or equal to second.
///  Includes error message into revert string on failure.
function assertLe(int256 left, int256 right, string calldata error) external pure;;
```

### assertLtDecimal(uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertLtDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 79845:86:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than second.
///  Formats values with decimals in failure message.
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertLtDecimal(uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertLtDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 80131:109:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertLtDecimal(int256,int256,uint256) (inherited from VmSafe)

- **Signature**: `assertLtDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 80385:84:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than second.
///  Formats values with decimals in failure message.
function assertLtDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertLtDecimal(int256,int256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertLtDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 80668:107:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertLtDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertLt(uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertLt(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 80864:61:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than second.
function assertLt(uint256 left, uint256 right) external pure;;
```

### assertLt(uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertLt(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 81076:84:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than second.
///  Includes error message into revert string on failure.
function assertLt(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertLt(int256,int256) (inherited from VmSafe)

- **Signature**: `assertLt(int256,int256)`
- **Visibility**: external
- **Source Range**: 81248:59:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than second.
function assertLt(int256 left, int256 right) external pure;;
```

### assertLt(int256,int256,string) (inherited from VmSafe)

- **Signature**: `assertLt(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 81457:82:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than second.
///  Includes error message into revert string on failure.
function assertLt(int256 left, int256 right, string calldata error) external pure;;
```

### assertNotEqDecimal(uint256,uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertNotEqDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 81652:89:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are not equal, formatting them with decimals in failure message.
function assertNotEqDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertNotEqDecimal(uint256,uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertNotEqDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 81916:112:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are not equal, formatting them with decimals in failure message.
///  Includes error message into revert string on failure.
function assertNotEqDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertNotEqDecimal(int256,int256,uint256) (inherited from VmSafe)

- **Signature**: `assertNotEqDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 82140:87:25

**Signature:**
```solidity
/// Asserts that two `int256` values are not equal, formatting them with decimals in failure message.
function assertNotEqDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertNotEqDecimal(int256,int256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertNotEqDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 82401:110:25

**Signature:**
```solidity
/// Asserts that two `int256` values are not equal, formatting them with decimals in failure message.
///  Includes error message into revert string on failure.
function assertNotEqDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertNotEq(bool,bool) (inherited from VmSafe)

- **Signature**: `assertNotEq(bool,bool)`
- **Visibility**: external
- **Source Range**: 82571:58:25

**Signature:**
```solidity
/// Asserts that two `bool` values are not equal.
function assertNotEq(bool left, bool right) external pure;;
```

### assertNotEq(bool,bool,string) (inherited from VmSafe)

- **Signature**: `assertNotEq(bool,bool,string)`
- **Visibility**: external
- **Source Range**: 82746:81:25

**Signature:**
```solidity
/// Asserts that two `bool` values are not equal and includes error message into revert string on failure.
function assertNotEq(bool left, bool right, string calldata error) external pure;;
```

### assertNotEq(string,string) (inherited from VmSafe)

- **Signature**: `assertNotEq(string,string)`
- **Visibility**: external
- **Source Range**: 82889:80:25

**Signature:**
```solidity
/// Asserts that two `string` values are not equal.
function assertNotEq(string calldata left, string calldata right) external pure;;
```

### assertNotEq(string,string,string) (inherited from VmSafe)

- **Signature**: `assertNotEq(string,string,string)`
- **Visibility**: external
- **Source Range**: 83088:103:25

**Signature:**
```solidity
/// Asserts that two `string` values are not equal and includes error message into revert string on failure.
function assertNotEq(string calldata left, string calldata right, string calldata error) external pure;;
```

### assertNotEq(bytes,bytes) (inherited from VmSafe)

- **Signature**: `assertNotEq(bytes,bytes)`
- **Visibility**: external
- **Source Range**: 83252:78:25

**Signature:**
```solidity
/// Asserts that two `bytes` values are not equal.
function assertNotEq(bytes calldata left, bytes calldata right) external pure;;
```

### assertNotEq(bytes,bytes,string) (inherited from VmSafe)

- **Signature**: `assertNotEq(bytes,bytes,string)`
- **Visibility**: external
- **Source Range**: 83448:101:25

**Signature:**
```solidity
/// Asserts that two `bytes` values are not equal and includes error message into revert string on failure.
function assertNotEq(bytes calldata left, bytes calldata right, string calldata error) external pure;;
```

### assertNotEq(bool[],bool[]) (inherited from VmSafe)

- **Signature**: `assertNotEq(bool[],bool[])`
- **Visibility**: external
- **Source Range**: 83619:80:25

**Signature:**
```solidity
/// Asserts that two arrays of `bool` values are not equal.
function assertNotEq(bool[] calldata left, bool[] calldata right) external pure;;
```

### assertNotEq(bool[],bool[],string) (inherited from VmSafe)

- **Signature**: `assertNotEq(bool[],bool[],string)`
- **Visibility**: external
- **Source Range**: 83826:103:25

**Signature:**
```solidity
/// Asserts that two arrays of `bool` values are not equal and includes error message into revert string on failure.
function assertNotEq(bool[] calldata left, bool[] calldata right, string calldata error) external pure;;
```

### assertNotEq(uint256[],uint256[]) (inherited from VmSafe)

- **Signature**: `assertNotEq(uint256[],uint256[])`
- **Visibility**: external
- **Source Range**: 84002:86:25

**Signature:**
```solidity
/// Asserts that two arrays of `uint256` values are not equal.
function assertNotEq(uint256[] calldata left, uint256[] calldata right) external pure;;
```

### assertNotEq(uint256[],uint256[],string) (inherited from VmSafe)

- **Signature**: `assertNotEq(uint256[],uint256[],string)`
- **Visibility**: external
- **Source Range**: 84218:109:25

**Signature:**
```solidity
/// Asserts that two arrays of `uint256` values are not equal and includes error message into revert string on failure.
function assertNotEq(uint256[] calldata left, uint256[] calldata right, string calldata error) external pure;;
```

### assertNotEq(int256[],int256[]) (inherited from VmSafe)

- **Signature**: `assertNotEq(int256[],int256[])`
- **Visibility**: external
- **Source Range**: 84399:84:25

**Signature:**
```solidity
/// Asserts that two arrays of `int256` values are not equal.
function assertNotEq(int256[] calldata left, int256[] calldata right) external pure;;
```

### assertNotEq(int256[],int256[],string) (inherited from VmSafe)

- **Signature**: `assertNotEq(int256[],int256[],string)`
- **Visibility**: external
- **Source Range**: 84612:107:25

**Signature:**
```solidity
/// Asserts that two arrays of `int256` values are not equal and includes error message into revert string on failure.
function assertNotEq(int256[] calldata left, int256[] calldata right, string calldata error) external pure;;
```

### assertNotEq(uint256,uint256) (inherited from VmSafe)

- **Signature**: `assertNotEq(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 84782:64:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are not equal.
function assertNotEq(uint256 left, uint256 right) external pure;;
```

### assertNotEq(address[],address[]) (inherited from VmSafe)

- **Signature**: `assertNotEq(address[],address[])`
- **Visibility**: external
- **Source Range**: 84919:86:25

**Signature:**
```solidity
/// Asserts that two arrays of `address` values are not equal.
function assertNotEq(address[] calldata left, address[] calldata right) external pure;;
```

### assertNotEq(address[],address[],string) (inherited from VmSafe)

- **Signature**: `assertNotEq(address[],address[],string)`
- **Visibility**: external
- **Source Range**: 85135:109:25

**Signature:**
```solidity
/// Asserts that two arrays of `address` values are not equal and includes error message into revert string on failure.
function assertNotEq(address[] calldata left, address[] calldata right, string calldata error) external pure;;
```

### assertNotEq(bytes32[],bytes32[]) (inherited from VmSafe)

- **Signature**: `assertNotEq(bytes32[],bytes32[])`
- **Visibility**: external
- **Source Range**: 85317:86:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes32` values are not equal.
function assertNotEq(bytes32[] calldata left, bytes32[] calldata right) external pure;;
```

### assertNotEq(bytes32[],bytes32[],string) (inherited from VmSafe)

- **Signature**: `assertNotEq(bytes32[],bytes32[],string)`
- **Visibility**: external
- **Source Range**: 85533:109:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes32` values are not equal and includes error message into revert string on failure.
function assertNotEq(bytes32[] calldata left, bytes32[] calldata right, string calldata error) external pure;;
```

### assertNotEq(string[],string[]) (inherited from VmSafe)

- **Signature**: `assertNotEq(string[],string[])`
- **Visibility**: external
- **Source Range**: 85714:84:25

**Signature:**
```solidity
/// Asserts that two arrays of `string` values are not equal.
function assertNotEq(string[] calldata left, string[] calldata right) external pure;;
```

### assertNotEq(string[],string[],string) (inherited from VmSafe)

- **Signature**: `assertNotEq(string[],string[],string)`
- **Visibility**: external
- **Source Range**: 85927:107:25

**Signature:**
```solidity
/// Asserts that two arrays of `string` values are not equal and includes error message into revert string on failure.
function assertNotEq(string[] calldata left, string[] calldata right, string calldata error) external pure;;
```

### assertNotEq(bytes[],bytes[]) (inherited from VmSafe)

- **Signature**: `assertNotEq(bytes[],bytes[])`
- **Visibility**: external
- **Source Range**: 86105:82:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes` values are not equal.
function assertNotEq(bytes[] calldata left, bytes[] calldata right) external pure;;
```

### assertNotEq(bytes[],bytes[],string) (inherited from VmSafe)

- **Signature**: `assertNotEq(bytes[],bytes[],string)`
- **Visibility**: external
- **Source Range**: 86315:105:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes` values are not equal and includes error message into revert string on failure.
function assertNotEq(bytes[] calldata left, bytes[] calldata right, string calldata error) external pure;;
```

### assertNotEq(uint256,uint256,string) (inherited from VmSafe)

- **Signature**: `assertNotEq(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 86540:87:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are not equal and includes error message into revert string on failure.
function assertNotEq(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertNotEq(int256,int256) (inherited from VmSafe)

- **Signature**: `assertNotEq(int256,int256)`
- **Visibility**: external
- **Source Range**: 86689:62:25

**Signature:**
```solidity
/// Asserts that two `int256` values are not equal.
function assertNotEq(int256 left, int256 right) external pure;;
```

### assertNotEq(int256,int256,string) (inherited from VmSafe)

- **Signature**: `assertNotEq(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 86870:85:25

**Signature:**
```solidity
/// Asserts that two `int256` values are not equal and includes error message into revert string on failure.
function assertNotEq(int256 left, int256 right, string calldata error) external pure;;
```

### assertNotEq(address,address) (inherited from VmSafe)

- **Signature**: `assertNotEq(address,address)`
- **Visibility**: external
- **Source Range**: 87018:64:25

**Signature:**
```solidity
/// Asserts that two `address` values are not equal.
function assertNotEq(address left, address right) external pure;;
```

### assertNotEq(address,address,string) (inherited from VmSafe)

- **Signature**: `assertNotEq(address,address,string)`
- **Visibility**: external
- **Source Range**: 87202:87:25

**Signature:**
```solidity
/// Asserts that two `address` values are not equal and includes error message into revert string on failure.
function assertNotEq(address left, address right, string calldata error) external pure;;
```

### assertNotEq(bytes32,bytes32) (inherited from VmSafe)

- **Signature**: `assertNotEq(bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 87352:64:25

**Signature:**
```solidity
/// Asserts that two `bytes32` values are not equal.
function assertNotEq(bytes32 left, bytes32 right) external pure;;
```

### assertNotEq(bytes32,bytes32,string) (inherited from VmSafe)

- **Signature**: `assertNotEq(bytes32,bytes32,string)`
- **Visibility**: external
- **Source Range**: 87536:87:25

**Signature:**
```solidity
/// Asserts that two `bytes32` values are not equal and includes error message into revert string on failure.
function assertNotEq(bytes32 left, bytes32 right, string calldata error) external pure;;
```

### assertTrue(bool) (inherited from VmSafe)

- **Signature**: `assertTrue(bool)`
- **Visibility**: external
- **Source Range**: 87679:50:25

**Signature:**
```solidity
/// Asserts that the given condition is true.
function assertTrue(bool condition) external pure;;
```

### assertTrue(bool,string) (inherited from VmSafe)

- **Signature**: `assertTrue(bool,string)`
- **Visibility**: external
- **Source Range**: 87842:73:25

**Signature:**
```solidity
/// Asserts that the given condition is true and includes error message into revert string on failure.
function assertTrue(bool condition, string calldata error) external pure;;
```

### assume(bool) (inherited from VmSafe)

- **Signature**: `assume(bool)`
- **Visibility**: external
- **Source Range**: 88010:46:25

**Signature:**
```solidity
/// If the condition is false, discard this run's fuzz inputs and generate new ones.
function assume(bool condition) external pure;;
```

### assumeNoRevert() (inherited from VmSafe)

- **Signature**: `assumeNoRevert()`
- **Visibility**: external
- **Source Range**: 88146:40:25

**Signature:**
```solidity
/// Discard this run's fuzz inputs and generate new ones if next call reverted.
function assumeNoRevert() external pure;;
```

### assumeNoRevert(struct VmSafe.PotentialRevert) (inherited from VmSafe)

- **Signature**: `assumeNoRevert(struct VmSafe.PotentialRevert)`
- **Visibility**: external
- **Source Range**: 88312:80:25

**Signature:**
```solidity
/// Discard this run's fuzz inputs and generate new ones if next call reverts with the potential revert parameters.
function assumeNoRevert(PotentialRevert calldata potentialRevert) external pure;;
```

### assumeNoRevert(struct VmSafe.PotentialRevert[]) (inherited from VmSafe)

- **Signature**: `assumeNoRevert(struct VmSafe.PotentialRevert[])`
- **Visibility**: external
- **Source Range**: 88529:83:25

**Signature:**
```solidity
/// Discard this run's fuzz inputs and generate new ones if next call reverts with the any of the potential revert parameters.
function assumeNoRevert(PotentialRevert[] calldata potentialReverts) external pure;;
```

### breakpoint(string) (inherited from VmSafe)

- **Signature**: `breakpoint(string)`
- **Visibility**: external
- **Source Range**: 88674:56:25

**Signature:**
```solidity
/// Writes a breakpoint to jump to in the debugger.
function breakpoint(string calldata char) external pure;;
```

### breakpoint(string,bool) (inherited from VmSafe)

- **Signature**: `breakpoint(string,bool)`
- **Visibility**: external
- **Source Range**: 88804:68:25

**Signature:**
```solidity
/// Writes a conditional breakpoint to jump to in the debugger.
function breakpoint(string calldata char, bool value) external pure;;
```

### foundryVersionAtLeast(string) (inherited from VmSafe)

- **Signature**: `foundryVersionAtLeast(string)`
- **Visibility**: external
- **Source Range**: 89118:85:25

**Signature:**
```solidity
/// Returns true if the current Foundry version is greater than or equal to the given version.
///  The given version string must be in the format `major.minor.patch`.
///  This is equivalent to `foundryVersionCmp(version) >= 0`.
function foundryVersionAtLeast(string calldata version) external view returns (bool);;
```

### foundryVersionCmp(string) (inherited from VmSafe)

- **Signature**: `foundryVersionCmp(string)`
- **Visibility**: external
- **Source Range**: 89810:83:25

**Signature:**
```solidity
/// Compares the current Foundry version with the given version string.
///  The given version string must be in the format `major.minor.patch`.
///  Returns:
///  -1 if current Foundry version is less than the given version
///  0 if current Foundry version equals the given version
///  1 if current Foundry version is greater than the given version
///  This result can then be used with a comparison operator against `0`.
///  For example, to check if the current Foundry version is greater than or equal to `1.0.0`:
///  `if (foundryVersionCmp("1.0.0") >= 0) { ... }`
function foundryVersionCmp(string calldata version) external view returns (int256);;
```

### getChain(string) (inherited from VmSafe)

- **Signature**: `getChain(string)`
- **Visibility**: external
- **Source Range**: 89949:89:25

**Signature:**
```solidity
/// Returns a Chain struct for specific alias
function getChain(string calldata chainAlias) external view returns (Chain memory chain);;
```

### getChain(uint256) (inherited from VmSafe)

- **Signature**: `getChain(uint256)`
- **Visibility**: external
- **Source Range**: 90096:78:25

**Signature:**
```solidity
/// Returns a Chain struct for specific chainId
function getChain(uint256 chainId) external view returns (Chain memory chain);;
```

### getFoundryVersion() (inherited from VmSafe)

- **Signature**: `getFoundryVersion()`
- **Visibility**: external
- **Source Range**: 90609:75:25

**Signature:**
```solidity
/// Returns the Foundry version.
///  Format: <cargo_version>-<tag>+<git_sha_short>.<unix_build_timestamp>.<profile>
///  Sample output: 0.3.0-nightly+3cb96bde9b.1737036656.debug
///  Note: Build timestamps may vary slightly across platforms due to separate CI jobs.
///  For reliable version comparisons, use UNIX format (e.g., >= 1700000000)
///  to compare timestamps while ignoring minor time differences.
function getFoundryVersion() external view returns (string memory version);;
```

### rpcUrl(string) (inherited from VmSafe)

- **Signature**: `rpcUrl(string)`
- **Visibility**: external
- **Source Range**: 90739:85:25

**Signature:**
```solidity
/// Returns the RPC url for the given alias.
function rpcUrl(string calldata rpcAlias) external view returns (string memory json);;
```

### rpcUrlStructs() (inherited from VmSafe)

- **Signature**: `rpcUrlStructs()`
- **Visibility**: external
- **Source Range**: 90889:67:25

**Signature:**
```solidity
/// Returns all rpc urls and their aliases as structs.
function rpcUrlStructs() external view returns (Rpc[] memory urls);;
```

### rpcUrls() (inherited from VmSafe)

- **Signature**: `rpcUrls()`
- **Visibility**: external
- **Source Range**: 91027:67:25

**Signature:**
```solidity
/// Returns all rpc urls and their aliases `[alias, url][]`.
function rpcUrls() external view returns (string[2][] memory urls);;
```

### sleep(uint256) (inherited from VmSafe)

- **Signature**: `sleep(uint256)`
- **Visibility**: external
- **Source Range**: 91175:42:25

**Signature:**
```solidity
/// Suspends execution of the main thread for `duration` milliseconds.
function sleep(uint256 duration) external;;
```

### keyExistsToml(string,string) (inherited from VmSafe)

- **Signature**: `keyExistsToml(string,string)`
- **Visibility**: external
- **Source Range**: 91302:95:25

**Signature:**
```solidity
/// Checks if `key` exists in a TOML table.
function keyExistsToml(string calldata toml, string calldata key) external view returns (bool);;
```

### parseTomlAddress(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlAddress(string,string)`
- **Visibility**: external
- **Source Range**: 91478:101:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `address`.
function parseTomlAddress(string calldata toml, string calldata key) external pure returns (address);;
```

### parseTomlAddressArray(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlAddressArray(string,string)`
- **Visibility**: external
- **Source Range**: 91662:139:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `address[]`.
function parseTomlAddressArray(string calldata toml, string calldata key) external pure returns (address[] memory);;
```

### parseTomlBool(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlBool(string,string)`
- **Visibility**: external
- **Source Range**: 91879:95:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bool`.
function parseTomlBool(string calldata toml, string calldata key) external pure returns (bool);;
```

### parseTomlBoolArray(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlBoolArray(string,string)`
- **Visibility**: external
- **Source Range**: 92054:109:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bool[]`.
function parseTomlBoolArray(string calldata toml, string calldata key) external pure returns (bool[] memory);;
```

### parseTomlBytes(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlBytes(string,string)`
- **Visibility**: external
- **Source Range**: 92242:104:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bytes`.
function parseTomlBytes(string calldata toml, string calldata key) external pure returns (bytes memory);;
```

### parseTomlBytes32(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlBytes32(string,string)`
- **Visibility**: external
- **Source Range**: 92427:101:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bytes32`.
function parseTomlBytes32(string calldata toml, string calldata key) external pure returns (bytes32);;
```

### parseTomlBytes32Array(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlBytes32Array(string,string)`
- **Visibility**: external
- **Source Range**: 92611:139:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bytes32[]`.
function parseTomlBytes32Array(string calldata toml, string calldata key) external pure returns (bytes32[] memory);;
```

### parseTomlBytesArray(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlBytesArray(string,string)`
- **Visibility**: external
- **Source Range**: 92831:111:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bytes[]`.
function parseTomlBytesArray(string calldata toml, string calldata key) external pure returns (bytes[] memory);;
```

### parseTomlInt(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlInt(string,string)`
- **Visibility**: external
- **Source Range**: 93022:96:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `int256`.
function parseTomlInt(string calldata toml, string calldata key) external pure returns (int256);;
```

### parseTomlIntArray(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlIntArray(string,string)`
- **Visibility**: external
- **Source Range**: 93200:110:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `int256[]`.
function parseTomlIntArray(string calldata toml, string calldata key) external pure returns (int256[] memory);;
```

### parseTomlKeys(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlKeys(string,string)`
- **Visibility**: external
- **Source Range**: 93374:111:25

**Signature:**
```solidity
/// Returns an array of all the keys in a TOML table.
function parseTomlKeys(string calldata toml, string calldata key) external pure returns (string[] memory keys);;
```

### parseTomlString(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlString(string,string)`
- **Visibility**: external
- **Source Range**: 93565:106:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `string`.
function parseTomlString(string calldata toml, string calldata key) external pure returns (string memory);;
```

### parseTomlStringArray(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlStringArray(string,string)`
- **Visibility**: external
- **Source Range**: 93753:113:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `string[]`.
function parseTomlStringArray(string calldata toml, string calldata key) external pure returns (string[] memory);;
```

### parseTomlTypeArray(string,string,string) (inherited from VmSafe)

- **Signature**: `parseTomlTypeArray(string,string,string)`
- **Visibility**: external
- **Source Range**: 93983:165:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to type array corresponding to `typeDescription`.
function parseTomlTypeArray(string calldata toml, string calldata key, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseTomlType(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlType(string,string)`
- **Visibility**: external
- **Source Range**: 94250:139:25

**Signature:**
```solidity
/// Parses a string of TOML data and coerces it to type corresponding to `typeDescription`.
function parseTomlType(string calldata toml, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseTomlType(string,string,string) (inherited from VmSafe)

- **Signature**: `parseTomlType(string,string,string)`
- **Visibility**: external
- **Source Range**: 94500:160:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to type corresponding to `typeDescription`.
function parseTomlType(string calldata toml, string calldata key, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseTomlUint(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlUint(string,string)`
- **Visibility**: external
- **Source Range**: 94741:98:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `uint256`.
function parseTomlUint(string calldata toml, string calldata key) external pure returns (uint256);;
```

### parseTomlUintArray(string,string) (inherited from VmSafe)

- **Signature**: `parseTomlUintArray(string,string)`
- **Visibility**: external
- **Source Range**: 94922:112:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `uint256[]`.
function parseTomlUintArray(string calldata toml, string calldata key) external pure returns (uint256[] memory);;
```

### parseToml(string) (inherited from VmSafe)

- **Signature**: `parseToml(string)`
- **Visibility**: external
- **Source Range**: 95074:93:25

**Signature:**
```solidity
/// ABI-encodes a TOML table.
function parseToml(string calldata toml) external pure returns (bytes memory abiEncodedData);;
```

### parseToml(string,string) (inherited from VmSafe)

- **Signature**: `parseToml(string,string)`
- **Visibility**: external
- **Source Range**: 95216:114:25

**Signature:**
```solidity
/// ABI-encodes a TOML table at `key`.
function parseToml(string calldata toml, string calldata key) external pure returns (bytes memory abiEncodedData);;
```

### writeToml(string,string) (inherited from VmSafe)

- **Signature**: `writeToml(string,string)`
- **Visibility**: external
- **Source Range**: 95423:72:25

**Signature:**
```solidity
/// Takes serialized JSON, converts to TOML and write a serialized TOML to a file.
function writeToml(string calldata json, string calldata path) external;;
```

### writeToml(string,string,string) (inherited from VmSafe)

- **Signature**: `writeToml(string,string,string)`
- **Visibility**: external
- **Source Range**: 95764:98:25

**Signature:**
```solidity
/// Takes serialized JSON, converts to TOML and write a serialized TOML table to an **existing** TOML file, replacing a value with key = <value_key.>
///  This is useful to replace a specific value of a TOML file, without having to parse the entire thing.
function writeToml(string calldata json, string calldata path, string calldata valueKey) external;;
```

### computeCreate2Address(bytes32,bytes32,address) (inherited from VmSafe)

- **Signature**: `computeCreate2Address(bytes32,bytes32,address)`
- **Visibility**: external
- **Source Range**: 96001:141:25

**Signature:**
```solidity
/// Compute the address of a contract created with CREATE2 using the given CREATE2 deployer.
function computeCreate2Address(bytes32 salt, bytes32 initCodeHash, address deployer) external pure returns (address);;
```

### computeCreate2Address(bytes32,bytes32) (inherited from VmSafe)

- **Signature**: `computeCreate2Address(bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 96247:99:25

**Signature:**
```solidity
/// Compute the address of a contract created with CREATE2 using the default CREATE2 deployer.
function computeCreate2Address(bytes32 salt, bytes32 initCodeHash) external pure returns (address);;
```

### computeCreateAddress(address,uint256) (inherited from VmSafe)

- **Signature**: `computeCreateAddress(address,uint256)`
- **Visibility**: external
- **Source Range**: 96451:95:25

**Signature:**
```solidity
/// Compute the address a contract will be deployed at for a given deployer address and nonce.
function computeCreateAddress(address deployer, uint256 nonce) external pure returns (address);;
```

### copyStorage(address,address) (inherited from VmSafe)

- **Signature**: `copyStorage(address,address)`
- **Visibility**: external
- **Source Range**: 96639:56:25

**Signature:**
```solidity
/// Utility cheatcode to copy storage of `from` contract to another `to` contract.
function copyStorage(address from, address to) external;;
```

### eip712HashStruct(string,bytes) (inherited from VmSafe)

- **Signature**: `eip712HashStruct(string,bytes)`
- **Visibility**: external
- **Source Range**: 97290:160:25

**Signature:**
```solidity
/// Generates the struct hash of the canonical EIP-712 type representation and its abi-encoded data.
///  Supports 2 different inputs:
///  1. Name of the type (i.e. "PermitSingle"):
///  * requires previous binding generation with `forge bind-json`.
///  * bindings will be retrieved from the path configured in `foundry.toml`.
///  2. String representation of the type (i.e. "Foo(Bar bar) Bar(uint256 baz)").
///  * Note: the cheatcode will use the canonical type even if the input is malformated
///  with the wrong order of elements or with extra whitespaces.
function eip712HashStruct(string calldata typeNameOrDefinition, bytes calldata abiEncodedData) external pure returns (bytes32 typeHash);;
```

### eip712HashStruct(string,string,bytes) (inherited from VmSafe)

- **Signature**: `eip712HashStruct(string,string,bytes)`
- **Visibility**: external
- **Source Range**: 97870:178:25

**Signature:**
```solidity
/// Generates the struct hash of the canonical EIP-712 type representation and its abi-encoded data.
///  Requires previous binding generation with `forge bind-json`.
///  Params:
///  * `bindingsPath`: path where the output of `forge bind-json` is stored.
///  * `typeName`: Name of the type (i.e. "PermitSingle").
///  * `abiEncodedData`: ABI-encoded data for the struct that is being hashed.
function eip712HashStruct(string calldata bindingsPath, string calldata typeName, bytes calldata abiEncodedData) external pure returns (bytes32 typeHash);;
```

### eip712HashType(string) (inherited from VmSafe)

- **Signature**: `eip712HashType(string)`
- **Visibility**: external
- **Source Range**: 98613:103:25

**Signature:**
```solidity
/// Generates the hash of the canonical EIP-712 type representation.
///  Supports 2 different inputs:
///  1. Name of the type (i.e. "Transaction"):
///  * requires previous binding generation with `forge bind-json`.
///  * bindings will be retrieved from the path configured in `foundry.toml`.
///  2. String representation of the type (i.e. "Foo(Bar bar) Bar(uint256 baz)").
///  * Note: the cheatcode will output the canonical type even if the input is malformated
///  with the wrong order of elements or with extra whitespaces.
function eip712HashType(string calldata typeNameOrDefinition) external pure returns (bytes32 typeHash);;
```

### eip712HashType(string,string) (inherited from VmSafe)

- **Signature**: `eip712HashType(string,string)`
- **Visibility**: external
- **Source Range**: 99021:145:25

**Signature:**
```solidity
/// Generates the hash of the canonical EIP-712 type representation.
///  Requires previous binding generation with `forge bind-json`.
///  Params:
///  * `bindingsPath`: path where the output of `forge bind-json` is stored.
///  * `typeName`: Name of the type (i.e. "Transaction").
function eip712HashType(string calldata bindingsPath, string calldata typeName) external pure returns (bytes32 typeHash);;
```

### eip712HashTypedData(string) (inherited from VmSafe)

- **Signature**: `eip712HashTypedData(string)`
- **Visibility**: external
- **Source Range**: 99274:94:25

**Signature:**
```solidity
/// Generates a ready-to-sign digest of human-readable typed data following the EIP-712 standard.
function eip712HashTypedData(string calldata jsonData) external pure returns (bytes32 digest);;
```

### ensNamehash(string) (inherited from VmSafe)

- **Signature**: `ensNamehash(string)`
- **Visibility**: external
- **Source Range**: 99424:75:25

**Signature:**
```solidity
/// Returns ENS namehash for provided string.
function ensNamehash(string calldata name) external pure returns (bytes32);;
```

### getLabel(address) (inherited from VmSafe)

- **Signature**: `getLabel(address)`
- **Visibility**: external
- **Source Range**: 99555:86:25

**Signature:**
```solidity
/// Gets the label for the specified address.
function getLabel(address account) external view returns (string memory currentLabel);;
```

### label(address,string) (inherited from VmSafe)

- **Signature**: `label(address,string)`
- **Visibility**: external
- **Source Range**: 99689:67:25

**Signature:**
```solidity
/// Labels an address in call traces.
function label(address account, string calldata newLabel) external;;
```

### pauseTracing() (inherited from VmSafe)

- **Signature**: `pauseTracing()`
- **Visibility**: external
- **Source Range**: 99911:38:25

**Signature:**
```solidity
/// Pauses collection of call traces. Useful in cases when you want to skip tracing of
///  complex calls which are not useful for debugging.
function pauseTracing() external view;;
```

### randomAddress() (inherited from VmSafe)

- **Signature**: `randomAddress()`
- **Visibility**: external
- **Source Range**: 99991:57:25

**Signature:**
```solidity
/// Returns a random `address`.
function randomAddress() external view returns (address);;
```

### randomBool() (inherited from VmSafe)

- **Signature**: `randomBool()`
- **Visibility**: external
- **Source Range**: 100087:51:25

**Signature:**
```solidity
/// Returns a random `bool`.
function randomBool() external view returns (bool);;
```

### randomBytes(uint256) (inherited from VmSafe)

- **Signature**: `randomBytes(uint256)`
- **Visibility**: external
- **Source Range**: 100207:71:25

**Signature:**
```solidity
/// Returns a random byte array value of the given length.
function randomBytes(uint256 len) external view returns (bytes memory);;
```

### randomBytes4() (inherited from VmSafe)

- **Signature**: `randomBytes4()`
- **Visibility**: external
- **Source Range**: 100344:55:25

**Signature:**
```solidity
/// Returns a random fixed-size byte array of length 4.
function randomBytes4() external view returns (bytes4);;
```

### randomBytes8() (inherited from VmSafe)

- **Signature**: `randomBytes8()`
- **Visibility**: external
- **Source Range**: 100465:55:25

**Signature:**
```solidity
/// Returns a random fixed-size byte array of length 8.
function randomBytes8() external view returns (bytes8);;
```

### randomInt() (inherited from VmSafe)

- **Signature**: `randomInt()`
- **Visibility**: external
- **Source Range**: 100567:52:25

**Signature:**
```solidity
/// Returns a random `int256` value.
function randomInt() external view returns (int256);;
```

### randomInt(uint256) (inherited from VmSafe)

- **Signature**: `randomInt(uint256)`
- **Visibility**: external
- **Source Range**: 100680:64:25

**Signature:**
```solidity
/// Returns a random `int256` value of given bits.
function randomInt(uint256 bits) external view returns (int256);;
```

### randomUint() (inherited from VmSafe)

- **Signature**: `randomUint()`
- **Visibility**: external
- **Source Range**: 100790:54:25

**Signature:**
```solidity
/// Returns a random uint256 value.
function randomUint() external view returns (uint256);;
```

### randomUint(uint256,uint256) (inherited from VmSafe)

- **Signature**: `randomUint(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 100928:78:25

**Signature:**
```solidity
/// Returns random uint256 value between the provided range (=min..=max).
function randomUint(uint256 min, uint256 max) external view returns (uint256);;
```

### randomUint(uint256) (inherited from VmSafe)

- **Signature**: `randomUint(uint256)`
- **Visibility**: external
- **Source Range**: 101068:66:25

**Signature:**
```solidity
/// Returns a random `uint256` value of given bits.
function randomUint(uint256 bits) external view returns (uint256);;
```

### resumeTracing() (inherited from VmSafe)

- **Signature**: `resumeTracing()`
- **Visibility**: external
- **Source Range**: 101184:39:25

**Signature:**
```solidity
/// Unpauses collection of call traces.
function resumeTracing() external view;;
```

### setArbitraryStorage(address) (inherited from VmSafe)

- **Signature**: `setArbitraryStorage(address)`
- **Visibility**: external
- **Source Range**: 101306:54:25

**Signature:**
```solidity
/// Utility cheatcode to set arbitrary storage for given target address.
function setArbitraryStorage(address target) external;;
```

### setArbitraryStorage(address,bool) (inherited from VmSafe)

- **Signature**: `setArbitraryStorage(address,bool)`
- **Visibility**: external
- **Source Range**: 101513:70:25

**Signature:**
```solidity
/// Utility cheatcode to set arbitrary storage for given target address and overwrite
///  any storage slots that have been previously set.
function setArbitraryStorage(address target, bool overwrite) external;;
```

### setSeed(uint256) (inherited from VmSafe)

- **Signature**: `setSeed(uint256)`
- **Visibility**: external
- **Source Range**: 101611:40:25

**Signature:**
```solidity
/// Set RNG seed.
function setSeed(uint256 seed) external;;
```

### shuffle(uint256[]) (inherited from VmSafe)

- **Signature**: `shuffle(uint256[])`
- **Visibility**: external
- **Source Range**: 101693:79:25

**Signature:**
```solidity
/// Randomly shuffles an array.
function shuffle(uint256[] calldata array) external returns (uint256[] memory);;
```

### sort(uint256[]) (inherited from VmSafe)

- **Signature**: `sort(uint256[])`
- **Visibility**: external
- **Source Range**: 101821:76:25

**Signature:**
```solidity
/// Sorts an array in ascending order.
function sort(uint256[] calldata array) external returns (uint256[] memory);;
```

### toBase64URL(bytes) (inherited from VmSafe)

- **Signature**: `toBase64URL(bytes)`
- **Visibility**: external
- **Source Range**: 101958:80:25

**Signature:**
```solidity
/// Encodes a `bytes` value to a base64url string.
function toBase64URL(bytes calldata data) external pure returns (string memory);;
```

### toBase64URL(string) (inherited from VmSafe)

- **Signature**: `toBase64URL(string)`
- **Visibility**: external
- **Source Range**: 102100:81:25

**Signature:**
```solidity
/// Encodes a `string` value to a base64url string.
function toBase64URL(string calldata data) external pure returns (string memory);;
```

### toBase64(bytes) (inherited from VmSafe)

- **Signature**: `toBase64(bytes)`
- **Visibility**: external
- **Source Range**: 102239:77:25

**Signature:**
```solidity
/// Encodes a `bytes` value to a base64 string.
function toBase64(bytes calldata data) external pure returns (string memory);;
```

### toBase64(string) (inherited from VmSafe)

- **Signature**: `toBase64(string)`
- **Visibility**: external
- **Source Range**: 102375:78:25

**Signature:**
```solidity
/// Encodes a `string` value to a base64 string.
function toBase64(string calldata data) external pure returns (string memory);;
```
