# Interface: VmSafe

## Metadata

- **Name**: VmSafe
- **Type**: Interface
- **Path**: lib/forge-std/src/Vm.sol
- **Documentation**: The `VmSafe` interface does not allow manipulation of the EVM state or other actions that may
   result in Script simulations differing from on-chain execution. It is recommended to only use
   these cheats in scripts.

## Structs

### Log

```solidity
/// An Ethereum log. Returned by `getRecordedLogs`.
struct Log {
    bytes32[] topics;
    bytes data;
    address emitter;
}
```

### Rpc

```solidity
/// An RPC URL and its alias. Returned by `rpcUrlStructs`.
struct Rpc {
    string key;
    string url;
}
```

### EthGetLogs

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

### DirEntry

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

### FsMetadata

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

### Wallet

```solidity
/// A wallet with a public and private key.
struct Wallet {
    address addr;
    uint256 publicKeyX;
    uint256 publicKeyY;
    uint256 privateKey;
}
```

### FfiResult

```solidity
/// The result of a `tryFfi` call.
struct FfiResult {
    int32 exitCode;
    bytes stdout;
    bytes stderr;
}
```

### ChainInfo

```solidity
/// Information on the chain and fork.
struct ChainInfo {
    uint256 forkId;
    uint256 chainId;
}
```

### Chain

```solidity
/// Information about a blockchain.
struct Chain {
    string name;
    uint256 chainId;
    string chainAlias;
    string rpcUrl;
}
```

### AccountAccess

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

### StorageAccess

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

### Gas

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

### DebugStep

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

### BroadcastTxSummary

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

### SignedDelegation

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

### PotentialRevert

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

### AccessListItem

```solidity
/// An EIP-2930 access list item.
struct AccessListItem {
    address target;
    bytes32[] storageKeys;
}
```

## Enums

### CallerMode

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

### AccountAccessKind

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

### ForgeContext

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

### BroadcastTxType

```solidity
/// The transaction type (`txType`) of the broadcast.
enum BroadcastTxType {
    Call,
    Create,
    Create2
}
```

## Public/External Functions

### createWallet(string)

- **Signature**: `createWallet(string)`
- **Visibility**: external
- **Source Range**: 12656:91:25

**Signature:**
```solidity
/// Derives a private key from the name, labels the account with that name, and returns the wallet.
function createWallet(string calldata walletLabel) external returns (Wallet memory wallet);;
```

### createWallet(uint256)

- **Signature**: `createWallet(uint256)`
- **Visibility**: external
- **Source Range**: 12825:82:25

**Signature:**
```solidity
/// Generates a wallet from the private key and returns the wallet.
function createWallet(uint256 privateKey) external returns (Wallet memory wallet);;
```

### createWallet(uint256,string)

- **Signature**: `createWallet(uint256,string)`
- **Visibility**: external
- **Source Range**: 13021:111:25

**Signature:**
```solidity
/// Generates a wallet from the private key, labels the account with that name, and returns the wallet.
function createWallet(uint256 privateKey, string calldata walletLabel) external returns (Wallet memory wallet);;
```

### deriveKey(string,uint32)

- **Signature**: `deriveKey(string,uint32)`
- **Visibility**: external
- **Source Range**: 13280:102:25

**Signature:**
```solidity
/// Derive a private key from a provided mnenomic string (or mnenomic file path)
///  at the derivation path `m/44'/60'/0'/0/{index}`.
function deriveKey(string calldata mnemonic, uint32 index) external pure returns (uint256 privateKey);;
```

### deriveKey(string,string,uint32)

- **Signature**: `deriveKey(string,string,uint32)`
- **Visibility**: external
- **Source Range**: 13511:158:25

**Signature:**
```solidity
/// Derive a private key from a provided mnenomic string (or mnenomic file path)
///  at `{derivationPath}{index}`.
function deriveKey(string calldata mnemonic, string calldata derivationPath, uint32 index) external pure returns (uint256 privateKey);;
```

### deriveKey(string,uint32,string)

- **Signature**: `deriveKey(string,uint32,string)`
- **Visibility**: external
- **Source Range**: 13843:152:25

**Signature:**
```solidity
/// Derive a private key from a provided mnenomic string (or mnenomic file path) in the specified language
///  at the derivation path `m/44'/60'/0'/0/{index}`.
function deriveKey(string calldata mnemonic, uint32 index, string calldata language) external pure returns (uint256 privateKey);;
```

### deriveKey(string,string,uint32,string)

- **Signature**: `deriveKey(string,string,uint32,string)`
- **Visibility**: external
- **Source Range**: 14150:184:25

**Signature:**
```solidity
/// Derive a private key from a provided mnenomic string (or mnenomic file path) in the specified language
///  at `{derivationPath}{index}`.
function deriveKey(string calldata mnemonic, string calldata derivationPath, uint32 index, string calldata language) external pure returns (uint256 privateKey);;
```

### publicKeyP256(uint256)

- **Signature**: `publicKeyP256(uint256)`
- **Visibility**: external
- **Source Range**: 14409:106:25

**Signature:**
```solidity
/// Derives secp256r1 public key from the provided `privateKey`.
function publicKeyP256(uint256 privateKey) external pure returns (uint256 publicKeyX, uint256 publicKeyY);;
```

### rememberKey(uint256)

- **Signature**: `rememberKey(uint256)`
- **Visibility**: external
- **Source Range**: 14599:76:25

**Signature:**
```solidity
/// Adds a private key to the local forge wallet and returns the address.
function rememberKey(uint256 privateKey) external returns (address keyAddr);;
```

### rememberKeys(string,string,uint32)

- **Signature**: `rememberKeys(string,string,uint32)`
- **Visibility**: external
- **Source Range**: 14908:155:25

**Signature:**
```solidity
/// Derive a set number of wallets from a mnemonic at the derivation path `m/44'/60'/0'/0/{0..count}`.
///  The respective private keys are saved to the local forge wallet for later use and their addresses are returned.
function rememberKeys(string calldata mnemonic, string calldata derivationPath, uint32 count) external returns (address[] memory keyAddrs);;
```

### rememberKeys(string,string,string,uint32)

- **Signature**: `rememberKeys(string,string,string,uint32)`
- **Visibility**: external
- **Source Range**: 15322:203:25

**Signature:**
```solidity
/// Derive a set number of wallets from a mnemonic in the specified language at the derivation path `m/44'/60'/0'/0/{0..count}`.
///  The respective private keys are saved to the local forge wallet for later use and their addresses are returned.
function rememberKeys(string calldata mnemonic, string calldata derivationPath, string calldata language, uint32 count) external returns (address[] memory keyAddrs);;
```

### signCompact(struct VmSafe.Wallet,bytes32)

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

### signCompact(uint256,bytes32)

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

### signCompact(bytes32)

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

### signCompact(address,bytes32)

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

### signP256(uint256,bytes32)

- **Signature**: `signP256(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 17666:99:25

**Signature:**
```solidity
/// Signs `digest` with `privateKey` using the secp256r1 curve.
function signP256(uint256 privateKey, bytes32 digest) external pure returns (bytes32 r, bytes32 s);;
```

### sign(struct VmSafe.Wallet,bytes32)

- **Signature**: `sign(struct VmSafe.Wallet,bytes32)`
- **Visibility**: external
- **Source Range**: 17807:103:25

**Signature:**
```solidity
/// Signs data with a `Wallet`.
function sign(Wallet calldata wallet, bytes32 digest) external returns (uint8 v, bytes32 r, bytes32 s);;
```

### sign(uint256,bytes32)

- **Signature**: `sign(uint256,bytes32)`
- **Visibility**: external
- **Source Range**: 17984:104:25

**Signature:**
```solidity
/// Signs `digest` with `privateKey` using the secp256k1 curve.
function sign(uint256 privateKey, bytes32 digest) external pure returns (uint8 v, bytes32 r, bytes32 s);;
```

### sign(bytes32)

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

### sign(address,bytes32)

- **Signature**: `sign(address,bytes32)`
- **Visibility**: external
- **Source Range**: 18788:100:25

**Signature:**
```solidity
/// Signs `digest` with signer provided to script using the secp256k1 curve.
///  Raises error if none of the signers passed into the script have provided address.
function sign(address signer, bytes32 digest) external pure returns (uint8 v, bytes32 r, bytes32 s);;
```

### envAddress(string)

- **Signature**: `envAddress(string)`
- **Visibility**: external
- **Source Range**: 19075:80:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `address`.
///  Reverts if the variable was not found or could not be parsed.
function envAddress(string calldata name) external view returns (address value);;
```

### envAddress(string,string)

- **Signature**: `envAddress(string,string)`
- **Visibility**: external
- **Source Range**: 19338:112:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `address`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envAddress(string calldata name, string calldata delim) external view returns (address[] memory value);;
```

### envBool(string)

- **Signature**: `envBool(string)`
- **Visibility**: external
- **Source Range**: 19596:74:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `bool`.
///  Reverts if the variable was not found or could not be parsed.
function envBool(string calldata name) external view returns (bool value);;
```

### envBool(string,string)

- **Signature**: `envBool(string,string)`
- **Visibility**: external
- **Source Range**: 19850:106:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `bool`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envBool(string calldata name, string calldata delim) external view returns (bool[] memory value);;
```

### envBytes32(string)

- **Signature**: `envBytes32(string)`
- **Visibility**: external
- **Source Range**: 20105:80:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `bytes32`.
///  Reverts if the variable was not found or could not be parsed.
function envBytes32(string calldata name) external view returns (bytes32 value);;
```

### envBytes32(string,string)

- **Signature**: `envBytes32(string,string)`
- **Visibility**: external
- **Source Range**: 20368:112:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `bytes32`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envBytes32(string calldata name, string calldata delim) external view returns (bytes32[] memory value);;
```

### envBytes(string)

- **Signature**: `envBytes(string)`
- **Visibility**: external
- **Source Range**: 20627:83:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `bytes`.
///  Reverts if the variable was not found or could not be parsed.
function envBytes(string calldata name) external view returns (bytes memory value);;
```

### envBytes(string,string)

- **Signature**: `envBytes(string,string)`
- **Visibility**: external
- **Source Range**: 20891:108:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `bytes`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envBytes(string calldata name, string calldata delim) external view returns (bytes[] memory value);;
```

### envExists(string)

- **Signature**: `envExists(string)`
- **Visibility**: external
- **Source Range**: 21101:77:25

**Signature:**
```solidity
/// Gets the environment variable `name` and returns true if it exists, else returns false.
function envExists(string calldata name) external view returns (bool result);;
```

### envInt(string)

- **Signature**: `envInt(string)`
- **Visibility**: external
- **Source Range**: 21326:75:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `int256`.
///  Reverts if the variable was not found or could not be parsed.
function envInt(string calldata name) external view returns (int256 value);;
```

### envInt(string,string)

- **Signature**: `envInt(string,string)`
- **Visibility**: external
- **Source Range**: 21583:107:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `int256`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envInt(string calldata name, string calldata delim) external view returns (int256[] memory value);;
```

### envOr(string,bool)

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

### envOr(string,uint256)

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

### envOr(string,string,address[])

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

### envOr(string,string,bytes32[])

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

### envOr(string,string,string[])

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

### envOr(string,string,bytes[])

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

### envOr(string,int256)

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

### envOr(string,address)

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

### envOr(string,bytes32)

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

### envOr(string,string)

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

### envOr(string,bytes)

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

### envOr(string,string,bool[])

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

### envOr(string,string,uint256[])

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

### envOr(string,string,int256[])

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

### envString(string)

- **Signature**: `envString(string)`
- **Visibility**: external
- **Source Range**: 26609:85:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `string`.
///  Reverts if the variable was not found or could not be parsed.
function envString(string calldata name) external view returns (string memory value);;
```

### envString(string,string)

- **Signature**: `envString(string,string)`
- **Visibility**: external
- **Source Range**: 26876:110:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `string`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envString(string calldata name, string calldata delim) external view returns (string[] memory value);;
```

### envUint(string)

- **Signature**: `envUint(string)`
- **Visibility**: external
- **Source Range**: 27135:77:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as `uint256`.
///  Reverts if the variable was not found or could not be parsed.
function envUint(string calldata name) external view returns (uint256 value);;
```

### envUint(string,string)

- **Signature**: `envUint(string,string)`
- **Visibility**: external
- **Source Range**: 27395:109:25

**Signature:**
```solidity
/// Gets the environment variable `name` and parses it as an array of `uint256`, delimited by `delim`.
///  Reverts if the variable was not found or could not be parsed.
function envUint(string calldata name, string calldata delim) external view returns (uint256[] memory value);;
```

### isContext(enum VmSafe.ForgeContext)

- **Signature**: `isContext(enum VmSafe.ForgeContext)`
- **Visibility**: external
- **Source Range**: 27581:77:25

**Signature:**
```solidity
/// Returns true if `forge` command was executed in given context.
function isContext(ForgeContext context) external view returns (bool result);;
```

### setEnv(string,string)

- **Signature**: `setEnv(string,string)`
- **Visibility**: external
- **Source Range**: 27700:70:25

**Signature:**
```solidity
/// Sets environment variables.
function setEnv(string calldata name, string calldata value) external;;
```

### accesses(address)

- **Signature**: `accesses(address)`
- **Visibility**: external
- **Source Range**: 27902:109:25

**Signature:**
```solidity
/// Gets all accessed reads and write slot from a `vm.record` session, for a given address.
function accesses(address target) external returns (bytes32[] memory readSlots, bytes32[] memory writeSlots);;
```

### addr(uint256)

- **Signature**: `addr(uint256)`
- **Visibility**: external
- **Source Range**: 28067:74:25

**Signature:**
```solidity
/// Gets the address for a given private key.
function addr(uint256 privateKey) external pure returns (address keyAddr);;
```

### eth_getLogs(uint256,uint256,address,bytes32[])

- **Signature**: `eth_getLogs(uint256,uint256,address,bytes32[])`
- **Visibility**: external
- **Source Range**: 28204:160:25

**Signature:**
```solidity
/// Gets all the logs according to specified filter.
function eth_getLogs(uint256 fromBlock, uint256 toBlock, address target, bytes32[] calldata topics) external returns (EthGetLogs[] memory logs);;
```

### getBlobBaseFee()

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

### getBlockNumber()

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

### getBlockTimestamp()

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

### getMappingKeyAndParentOf(address,bytes32)

- **Signature**: `getMappingKeyAndParentOf(address,bytes32)`
- **Visibility**: external
- **Source Range**: 29639:146:25

**Signature:**
```solidity
/// Gets the map key and parent of a mapping at a given slot, for a given address.
function getMappingKeyAndParentOf(address target, bytes32 elementSlot) external returns (bool found, bytes32 key, bytes32 parent);;
```

### getMappingLength(address,bytes32)

- **Signature**: `getMappingLength(address,bytes32)`
- **Visibility**: external
- **Source Range**: 29882:97:25

**Signature:**
```solidity
/// Gets the number of elements in the mapping at the given slot, for a given address.
function getMappingLength(address target, bytes32 mappingSlot) external returns (uint256 length);;
```

### getMappingSlotAt(address,bytes32,uint256)

- **Signature**: `getMappingSlotAt(address,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 30183:109:25

**Signature:**
```solidity
/// Gets the elements at index idx of the mapping at the given slot, for a given address. The
///  index must be less than the length of the mapping (i.e. the number of keys in the mapping).
function getMappingSlotAt(address target, bytes32 mappingSlot, uint256 idx) external returns (bytes32 value);;
```

### getNonce(address)

- **Signature**: `getNonce(address)`
- **Visibility**: external
- **Source Range**: 30336:72:25

**Signature:**
```solidity
/// Gets the nonce of an account.
function getNonce(address account) external view returns (uint64 nonce);;
```

### getNonce(struct VmSafe.Wallet)

- **Signature**: `getNonce(struct VmSafe.Wallet)`
- **Visibility**: external
- **Source Range**: 30451:74:25

**Signature:**
```solidity
/// Get the nonce of a `Wallet`.
function getNonce(Wallet calldata wallet) external returns (uint64 nonce);;
```

### getRawBlockHeader(uint256)

- **Signature**: `getRawBlockHeader(uint256)`
- **Visibility**: external
- **Source Range**: 30689:95:25

**Signature:**
```solidity
/// Gets the RLP encoded block header for a given block number.
///  Returns the block header in the same format as `cast block <block_number> --raw`.
function getRawBlockHeader(uint256 blockNumber) external view returns (bytes memory rlpHeader);;
```

### getRecordedLogs()

- **Signature**: `getRecordedLogs()`
- **Visibility**: external
- **Source Range**: 30826:64:25

**Signature:**
```solidity
/// Gets all the recorded logs.
function getRecordedLogs() external returns (Log[] memory logs);;
```

### getStateDiff()

- **Signature**: `getStateDiff()`
- **Visibility**: external
- **Source Range**: 30975:67:25

**Signature:**
```solidity
/// Returns state diffs from current `vm.startStateDiffRecording` session.
function getStateDiff() external view returns (string memory diff);;
```

### getStateDiffJson()

- **Signature**: `getStateDiffJson()`
- **Visibility**: external
- **Source Range**: 31143:71:25

**Signature:**
```solidity
/// Returns state diffs from current `vm.startStateDiffRecording` session, in json format.
function getStateDiffJson() external view returns (string memory diff);;
```

### lastCallGas()

- **Signature**: `lastCallGas()`
- **Visibility**: external
- **Source Range**: 31292:62:25

**Signature:**
```solidity
/// Gets the gas used in the last call from the callee perspective.
function lastCallGas() external view returns (Gas memory gas);;
```

### load(address,bytes32)

- **Signature**: `load(address,bytes32)`
- **Visibility**: external
- **Source Range**: 31406:81:25

**Signature:**
```solidity
/// Loads a storage slot from an address.
function load(address target, bytes32 slot) external view returns (bytes32 data);;
```

### pauseGasMetering()

- **Signature**: `pauseGasMetering()`
- **Visibility**: external
- **Source Range**: 31578:37:25

**Signature:**
```solidity
/// Pauses gas metering (i.e. gas usage is not counted). Noop if already paused.
function pauseGasMetering() external;;
```

### record()

- **Signature**: `record()`
- **Visibility**: external
- **Source Range**: 31775:27:25

**Signature:**
```solidity
/// Records all storage reads and writes. Use `accesses` to get the recorded data.
///  Subsequent calls to `record` will clear the previous data.
function record() external;;
```

### recordLogs()

- **Signature**: `recordLogs()`
- **Visibility**: external
- **Source Range**: 31849:31:25

**Signature:**
```solidity
/// Record all the transaction logs.
function recordLogs() external;;
```

### resetGasMetering()

- **Signature**: `resetGasMetering()`
- **Visibility**: external
- **Source Range**: 31951:37:25

**Signature:**
```solidity
/// Reset gas metering (i.e. gas usage is set to gas limit).
function resetGasMetering() external;;
```

### resumeGasMetering()

- **Signature**: `resumeGasMetering()`
- **Visibility**: external
- **Source Range**: 32078:38:25

**Signature:**
```solidity
/// Resumes gas metering (i.e. gas usage is counted again). Noop if already on.
function resumeGasMetering() external;;
```

### rpc(string,string)

- **Signature**: `rpc(string,string)`
- **Visibility**: external
- **Source Range**: 32193:98:25

**Signature:**
```solidity
/// Performs an Ethereum JSON-RPC request to the current fork URL.
function rpc(string calldata method, string calldata params) external returns (bytes memory data);;
```

### rpc(string,string,string)

- **Signature**: `rpc(string,string,string)`
- **Visibility**: external
- **Source Range**: 32366:142:25

**Signature:**
```solidity
/// Performs an Ethereum JSON-RPC request to the given endpoint.
function rpc(string calldata urlOrAlias, string calldata method, string calldata params) external returns (bytes memory data);;
```

### startDebugTraceRecording()

- **Signature**: `startDebugTraceRecording()`
- **Visibility**: external
- **Source Range**: 32562:45:25

**Signature:**
```solidity
/// Records the debug trace during the run.
function startDebugTraceRecording() external;;
```

### startMappingRecording()

- **Signature**: `startMappingRecording()`
- **Visibility**: external
- **Source Range**: 32675:42:25

**Signature:**
```solidity
/// Starts recording all map SSTOREs for later retrieval.
function startMappingRecording() external;;
```

### startStateDiffRecording()

- **Signature**: `startStateDiffRecording()`
- **Visibility**: external
- **Source Range**: 32861:44:25

**Signature:**
```solidity
/// Record all account accesses as part of CREATE, CALL or SELFDESTRUCT opcodes in order,
///  along with the context of the calls
function startStateDiffRecording() external;;
```

### stopAndReturnDebugTraceRecording()

- **Signature**: `stopAndReturnDebugTraceRecording()`
- **Visibility**: external
- **Source Range**: 32984:87:25

**Signature:**
```solidity
/// Stop debug trace recording and returns the recorded debug trace.
function stopAndReturnDebugTraceRecording() external returns (DebugStep[] memory step);;
```

### stopAndReturnStateDiff()

- **Signature**: `stopAndReturnStateDiff()`
- **Visibility**: external
- **Source Range**: 33179:92:25

**Signature:**
```solidity
/// Returns an ordered array of all account accesses from a `vm.startStateDiffRecording` session.
function stopAndReturnStateDiff() external returns (AccountAccess[] memory accountAccesses);;
```

### stopMappingRecording()

- **Signature**: `stopMappingRecording()`
- **Visibility**: external
- **Source Range**: 33367:41:25

**Signature:**
```solidity
/// Stops recording all map SSTOREs for later retrieval and clears the recorded data.
function stopMappingRecording() external;;
```

### stopRecord()

- **Signature**: `stopRecord()`
- **Visibility**: external
- **Source Range**: 33464:31:25

**Signature:**
```solidity
/// Stops recording storage reads and writes.
function stopRecord() external;;
```

### closeFile(string)

- **Signature**: `closeFile(string)`
- **Visibility**: external
- **Source Range**: 33694:50:25

**Signature:**
```solidity
/// Closes file for reading, resetting the offset and allowing to read it from beginning with readLine.
///  `path` is relative to the project root.
function closeFile(string calldata path) external;;
```

### copyFile(string,string)

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

### createDir(string,bool)

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

### deployCode(string)

- **Signature**: `deployCode(string)`
- **Visibility**: external
- **Source Range**: 34853:93:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
function deployCode(string calldata artifactPath) external returns (address deployedAddress);;
```

### deployCode(string,bytes)

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

### deployCode(string,uint256)

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

### deployCode(string,bytes,uint256)

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

### deployCode(string,bytes32)

- **Signature**: `deployCode(string,bytes32)`
- **Visibility**: external
- **Source Range**: 36481:107:25

**Signature:**
```solidity
/// Deploys a contract from an artifact file, using the CREATE2 salt. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
function deployCode(string calldata artifactPath, bytes32 salt) external returns (address deployedAddress);;
```

### deployCode(string,bytes,bytes32)

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

### deployCode(string,uint256,bytes32)

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

### deployCode(string,bytes,uint256,bytes32)

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

### exists(string)

- **Signature**: `exists(string)`
- **Visibility**: external
- **Source Range**: 38094:74:25

**Signature:**
```solidity
/// Returns true if the given path points to an existing entity, else returns false.
function exists(string calldata path) external view returns (bool result);;
```

### ffi(string[])

- **Signature**: `ffi(string[])`
- **Visibility**: external
- **Source Range**: 38233:84:25

**Signature:**
```solidity
/// Performs a foreign function call via the terminal.
function ffi(string[] calldata commandInput) external returns (bytes memory result);;
```

### fsMetadata(string)

- **Signature**: `fsMetadata(string)`
- **Visibility**: external
- **Source Range**: 38416:93:25

**Signature:**
```solidity
/// Given a path, query the file system to get information about a file, directory, etc.
function fsMetadata(string calldata path) external view returns (FsMetadata memory metadata);;
```

### getArtifactPathByCode(bytes)

- **Signature**: `getArtifactPathByCode(bytes)`
- **Visibility**: external
- **Source Range**: 38578:95:25

**Signature:**
```solidity
/// Gets the artifact path from code (aka. creation code).
function getArtifactPathByCode(bytes calldata code) external view returns (string memory path);;
```

### getArtifactPathByDeployedCode(bytes)

- **Signature**: `getArtifactPathByDeployedCode(bytes)`
- **Visibility**: external
- **Source Range**: 38750:111:25

**Signature:**
```solidity
/// Gets the artifact path from deployed code (aka. runtime code).
function getArtifactPathByDeployedCode(bytes calldata deployedCode) external view returns (string memory path);;
```

### getBroadcast(string,uint64,enum VmSafe.BroadcastTxType)

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

### getBroadcasts(string,uint64,enum VmSafe.BroadcastTxType)

- **Signature**: `getBroadcasts(string,uint64,enum VmSafe.BroadcastTxType)`
- **Visibility**: external
- **Source Range**: 39581:169:25

**Signature:**
```solidity
/// Returns all broadcasts for the given contract on `chainId` with the specified `txType`.
///  Sorted such that the most recent broadcast is the first element, and the oldest is the last. i.e descending order of BroadcastTxSummary.blockNumber.
function getBroadcasts(string calldata contractName, uint64 chainId, BroadcastTxType txType) external view returns (BroadcastTxSummary[] memory);;
```

### getBroadcasts(string,uint64)

- **Signature**: `getBroadcasts(string,uint64)`
- **Visibility**: external
- **Source Range**: 39981:145:25

**Signature:**
```solidity
/// Returns all broadcasts for the given contract on `chainId`.
///  Sorted such that the most recent broadcast is the first element, and the oldest is the last. i.e descending order of BroadcastTxSummary.blockNumber.
function getBroadcasts(string calldata contractName, uint64 chainId) external view returns (BroadcastTxSummary[] memory);;
```

### getCode(string)

- **Signature**: `getCode(string)`
- **Visibility**: external
- **Source Range**: 40364:101:25

**Signature:**
```solidity
/// Gets the creation bytecode from an artifact file. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
function getCode(string calldata artifactPath) external view returns (bytes memory creationBytecode);;
```

### getDeployedCode(string)

- **Signature**: `getDeployedCode(string)`
- **Visibility**: external
- **Source Range**: 40703:108:25

**Signature:**
```solidity
/// Gets the deployed bytecode from an artifact file. Takes in the relative path to the json file or the path to the
///  artifact in the form of <path>:<contract>:<version> where <contract> and <version> parts are optional.
function getDeployedCode(string calldata artifactPath) external view returns (bytes memory runtimeBytecode);;
```

### getDeployment(string)

- **Signature**: `getDeployment(string)`
- **Visibility**: external
- **Source Range**: 40887:101:25

**Signature:**
```solidity
/// Returns the most recent deployment for the current `chainId`.
function getDeployment(string calldata contractName) external view returns (address deployedAddress);;
```

### getDeployment(string,uint64)

- **Signature**: `getDeployment(string,uint64)`
- **Visibility**: external
- **Source Range**: 41073:141:25

**Signature:**
```solidity
/// Returns the most recent deployment for the given contract on `chainId`
function getDeployment(string calldata contractName, uint64 chainId) external view returns (address deployedAddress);;
```

### getDeployments(string,uint64)

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

### isDir(string)

- **Signature**: `isDir(string)`
- **Visibility**: external
- **Source Range**: 41742:73:25

**Signature:**
```solidity
/// Returns true if the path exists on disk and is pointing at a directory, else returns false.
function isDir(string calldata path) external view returns (bool result);;
```

### isFile(string)

- **Signature**: `isFile(string)`
- **Visibility**: external
- **Source Range**: 41924:74:25

**Signature:**
```solidity
/// Returns true if the path exists on disk and is pointing at a regular file, else returns false.
function isFile(string calldata path) external view returns (bool result);;
```

### projectRoot()

- **Signature**: `projectRoot()`
- **Visibility**: external
- **Source Range**: 42054:66:25

**Signature:**
```solidity
/// Get the path of the current project root.
function projectRoot() external view returns (string memory path);;
```

### prompt(string)

- **Signature**: `prompt(string)`
- **Visibility**: external
- **Source Range**: 42187:83:25

**Signature:**
```solidity
/// Prompts the user for a string value in the terminal.
function prompt(string calldata promptText) external returns (string memory input);;
```

### promptAddress(string)

- **Signature**: `promptAddress(string)`
- **Visibility**: external
- **Source Range**: 42333:78:25

**Signature:**
```solidity
/// Prompts the user for an address in the terminal.
function promptAddress(string calldata promptText) external returns (address);;
```

### promptSecret(string)

- **Signature**: `promptSecret(string)`
- **Visibility**: external
- **Source Range**: 42485:89:25

**Signature:**
```solidity
/// Prompts the user for a hidden string value in the terminal.
function promptSecret(string calldata promptText) external returns (string memory input);;
```

### promptSecretUint(string)

- **Signature**: `promptSecretUint(string)`
- **Visibility**: external
- **Source Range**: 42654:81:25

**Signature:**
```solidity
/// Prompts the user for hidden uint256 in the terminal (usually pk).
function promptSecretUint(string calldata promptText) external returns (uint256);;
```

### promptUint(string)

- **Signature**: `promptUint(string)`
- **Visibility**: external
- **Source Range**: 42795:75:25

**Signature:**
```solidity
/// Prompts the user for uint256 in the terminal.
function promptUint(string calldata promptText) external returns (uint256);;
```

### readDir(string)

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

### readDir(string,uint64)

- **Signature**: `readDir(string,uint64)`
- **Visibility**: external
- **Source Range**: 43244:106:25

**Signature:**
```solidity
/// See `readDir(string)`.
function readDir(string calldata path, uint64 maxDepth) external view returns (DirEntry[] memory entries);;
```

### readDir(string,uint64,bool)

- **Signature**: `readDir(string,uint64,bool)`
- **Visibility**: external
- **Source Range**: 43387:148:25

**Signature:**
```solidity
/// See `readDir(string)`.
function readDir(string calldata path, uint64 maxDepth, bool followLinks) external view returns (DirEntry[] memory entries);;
```

### readFile(string)

- **Signature**: `readFile(string)`
- **Visibility**: external
- **Source Range**: 43633:83:25

**Signature:**
```solidity
/// Reads the entire content of file to string. `path` is relative to the project root.
function readFile(string calldata path) external view returns (string memory data);;
```

### readFileBinary(string)

- **Signature**: `readFileBinary(string)`
- **Visibility**: external
- **Source Range**: 43814:88:25

**Signature:**
```solidity
/// Reads the entire content of file as binary. `path` is relative to the project root.
function readFileBinary(string calldata path) external view returns (bytes memory data);;
```

### readLine(string)

- **Signature**: `readLine(string)`
- **Visibility**: external
- **Source Range**: 43951:83:25

**Signature:**
```solidity
/// Reads next line of file to string.
function readLine(string calldata path) external view returns (string memory line);;
```

### readLink(string)

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

### removeDir(string,bool)

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

### removeFile(string)

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

### tryFfi(string[])

- **Signature**: `tryFfi(string[])`
- **Visibility**: external
- **Source Range**: 45333:91:25

**Signature:**
```solidity
/// Performs a foreign function call via terminal and returns the exit code, stdout, and stderr.
function tryFfi(string[] calldata commandInput) external returns (FfiResult memory result);;
```

### unixTime()

- **Signature**: `unixTime()`
- **Visibility**: external
- **Source Range**: 45489:65:25

**Signature:**
```solidity
/// Returns the time since unix epoch in milliseconds.
function unixTime() external view returns (uint256 milliseconds);;
```

### writeFile(string,string)

- **Signature**: `writeFile(string,string)`
- **Visibility**: external
- **Source Range**: 45723:72:25

**Signature:**
```solidity
/// Writes data to file, creating a file if it does not exist, and entirely replacing its contents if it does.
///  `path` is relative to the project root.
function writeFile(string calldata path, string calldata data) external;;
```

### writeFileBinary(string,bytes)

- **Signature**: `writeFileBinary(string,bytes)`
- **Visibility**: external
- **Source Range**: 45973:77:25

**Signature:**
```solidity
/// Writes binary data to a file, creating a file if it does not exist, and entirely replacing its contents if it does.
///  `path` is relative to the project root.
function writeFileBinary(string calldata path, bytes calldata data) external;;
```

### writeLine(string,string)

- **Signature**: `writeLine(string,string)`
- **Visibility**: external
- **Source Range**: 46171:72:25

**Signature:**
```solidity
/// Writes line to file, creating a file if it does not exist.
///  `path` is relative to the project root.
function writeLine(string calldata path, string calldata data) external;;
```

### keyExistsJson(string,string)

- **Signature**: `keyExistsJson(string,string)`
- **Visibility**: external
- **Source Range**: 46329:95:25

**Signature:**
```solidity
/// Checks if `key` exists in a JSON object.
function keyExistsJson(string calldata json, string calldata key) external view returns (bool);;
```

### parseJsonAddress(string,string)

- **Signature**: `parseJsonAddress(string,string)`
- **Visibility**: external
- **Source Range**: 46505:101:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `address`.
function parseJsonAddress(string calldata json, string calldata key) external pure returns (address);;
```

### parseJsonAddressArray(string,string)

- **Signature**: `parseJsonAddressArray(string,string)`
- **Visibility**: external
- **Source Range**: 46689:139:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `address[]`.
function parseJsonAddressArray(string calldata json, string calldata key) external pure returns (address[] memory);;
```

### parseJsonBool(string,string)

- **Signature**: `parseJsonBool(string,string)`
- **Visibility**: external
- **Source Range**: 46906:95:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bool`.
function parseJsonBool(string calldata json, string calldata key) external pure returns (bool);;
```

### parseJsonBoolArray(string,string)

- **Signature**: `parseJsonBoolArray(string,string)`
- **Visibility**: external
- **Source Range**: 47081:109:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bool[]`.
function parseJsonBoolArray(string calldata json, string calldata key) external pure returns (bool[] memory);;
```

### parseJsonBytes(string,string)

- **Signature**: `parseJsonBytes(string,string)`
- **Visibility**: external
- **Source Range**: 47269:104:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bytes`.
function parseJsonBytes(string calldata json, string calldata key) external pure returns (bytes memory);;
```

### parseJsonBytes32(string,string)

- **Signature**: `parseJsonBytes32(string,string)`
- **Visibility**: external
- **Source Range**: 47454:101:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bytes32`.
function parseJsonBytes32(string calldata json, string calldata key) external pure returns (bytes32);;
```

### parseJsonBytes32Array(string,string)

- **Signature**: `parseJsonBytes32Array(string,string)`
- **Visibility**: external
- **Source Range**: 47638:139:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bytes32[]`.
function parseJsonBytes32Array(string calldata json, string calldata key) external pure returns (bytes32[] memory);;
```

### parseJsonBytesArray(string,string)

- **Signature**: `parseJsonBytesArray(string,string)`
- **Visibility**: external
- **Source Range**: 47858:111:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `bytes[]`.
function parseJsonBytesArray(string calldata json, string calldata key) external pure returns (bytes[] memory);;
```

### parseJsonInt(string,string)

- **Signature**: `parseJsonInt(string,string)`
- **Visibility**: external
- **Source Range**: 48049:96:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `int256`.
function parseJsonInt(string calldata json, string calldata key) external pure returns (int256);;
```

### parseJsonIntArray(string,string)

- **Signature**: `parseJsonIntArray(string,string)`
- **Visibility**: external
- **Source Range**: 48227:110:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `int256[]`.
function parseJsonIntArray(string calldata json, string calldata key) external pure returns (int256[] memory);;
```

### parseJsonKeys(string,string)

- **Signature**: `parseJsonKeys(string,string)`
- **Visibility**: external
- **Source Range**: 48402:111:25

**Signature:**
```solidity
/// Returns an array of all the keys in a JSON object.
function parseJsonKeys(string calldata json, string calldata key) external pure returns (string[] memory keys);;
```

### parseJsonString(string,string)

- **Signature**: `parseJsonString(string,string)`
- **Visibility**: external
- **Source Range**: 48593:106:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `string`.
function parseJsonString(string calldata json, string calldata key) external pure returns (string memory);;
```

### parseJsonStringArray(string,string)

- **Signature**: `parseJsonStringArray(string,string)`
- **Visibility**: external
- **Source Range**: 48781:113:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `string[]`.
function parseJsonStringArray(string calldata json, string calldata key) external pure returns (string[] memory);;
```

### parseJsonTypeArray(string,string,string)

- **Signature**: `parseJsonTypeArray(string,string,string)`
- **Visibility**: external
- **Source Range**: 49011:165:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to type array corresponding to `typeDescription`.
function parseJsonTypeArray(string calldata json, string calldata key, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseJsonType(string,string)

- **Signature**: `parseJsonType(string,string)`
- **Visibility**: external
- **Source Range**: 49278:139:25

**Signature:**
```solidity
/// Parses a string of JSON data and coerces it to type corresponding to `typeDescription`.
function parseJsonType(string calldata json, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseJsonType(string,string,string)

- **Signature**: `parseJsonType(string,string,string)`
- **Visibility**: external
- **Source Range**: 49528:160:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to type corresponding to `typeDescription`.
function parseJsonType(string calldata json, string calldata key, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseJsonUint(string,string)

- **Signature**: `parseJsonUint(string,string)`
- **Visibility**: external
- **Source Range**: 49769:98:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `uint256`.
function parseJsonUint(string calldata json, string calldata key) external pure returns (uint256);;
```

### parseJsonUintArray(string,string)

- **Signature**: `parseJsonUintArray(string,string)`
- **Visibility**: external
- **Source Range**: 49950:112:25

**Signature:**
```solidity
/// Parses a string of JSON data at `key` and coerces it to `uint256[]`.
function parseJsonUintArray(string calldata json, string calldata key) external pure returns (uint256[] memory);;
```

### parseJson(string)

- **Signature**: `parseJson(string)`
- **Visibility**: external
- **Source Range**: 50103:93:25

**Signature:**
```solidity
/// ABI-encodes a JSON object.
function parseJson(string calldata json) external pure returns (bytes memory abiEncodedData);;
```

### parseJson(string,string)

- **Signature**: `parseJson(string,string)`
- **Visibility**: external
- **Source Range**: 50246:114:25

**Signature:**
```solidity
/// ABI-encodes a JSON object at `key`.
function parseJson(string calldata json, string calldata key) external pure returns (bytes memory abiEncodedData);;
```

### serializeAddress(string,string,address)

- **Signature**: `serializeAddress(string,string,address)`
- **Visibility**: external
- **Source Range**: 50395:148:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeAddress(string calldata objectKey, string calldata valueKey, address value) external returns (string memory json);;
```

### serializeAddress(string,string,address[])

- **Signature**: `serializeAddress(string,string,address[])`
- **Visibility**: external
- **Source Range**: 50578:160:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeAddress(string calldata objectKey, string calldata valueKey, address[] calldata values) external returns (string memory json);;
```

### serializeBool(string,string,bool)

- **Signature**: `serializeBool(string,string,bool)`
- **Visibility**: external
- **Source Range**: 50773:142:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBool(string calldata objectKey, string calldata valueKey, bool value) external returns (string memory json);;
```

### serializeBool(string,string,bool[])

- **Signature**: `serializeBool(string,string,bool[])`
- **Visibility**: external
- **Source Range**: 50950:154:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBool(string calldata objectKey, string calldata valueKey, bool[] calldata values) external returns (string memory json);;
```

### serializeBytes32(string,string,bytes32)

- **Signature**: `serializeBytes32(string,string,bytes32)`
- **Visibility**: external
- **Source Range**: 51139:148:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBytes32(string calldata objectKey, string calldata valueKey, bytes32 value) external returns (string memory json);;
```

### serializeBytes32(string,string,bytes32[])

- **Signature**: `serializeBytes32(string,string,bytes32[])`
- **Visibility**: external
- **Source Range**: 51322:160:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBytes32(string calldata objectKey, string calldata valueKey, bytes32[] calldata values) external returns (string memory json);;
```

### serializeBytes(string,string,bytes)

- **Signature**: `serializeBytes(string,string,bytes)`
- **Visibility**: external
- **Source Range**: 51517:153:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBytes(string calldata objectKey, string calldata valueKey, bytes calldata value) external returns (string memory json);;
```

### serializeBytes(string,string,bytes[])

- **Signature**: `serializeBytes(string,string,bytes[])`
- **Visibility**: external
- **Source Range**: 51705:156:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeBytes(string calldata objectKey, string calldata valueKey, bytes[] calldata values) external returns (string memory json);;
```

### serializeInt(string,string,int256)

- **Signature**: `serializeInt(string,string,int256)`
- **Visibility**: external
- **Source Range**: 51896:143:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeInt(string calldata objectKey, string calldata valueKey, int256 value) external returns (string memory json);;
```

### serializeInt(string,string,int256[])

- **Signature**: `serializeInt(string,string,int256[])`
- **Visibility**: external
- **Source Range**: 52074:155:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeInt(string calldata objectKey, string calldata valueKey, int256[] calldata values) external returns (string memory json);;
```

### serializeJson(string,string)

- **Signature**: `serializeJson(string,string)`
- **Visibility**: external
- **Source Range**: 52426:111:25

**Signature:**
```solidity
/// Serializes a key and value to a JSON object stored in-memory that can be later written to a file.
///  Returns the stringified version of the specific JSON file up to that moment.
function serializeJson(string calldata objectKey, string calldata value) external returns (string memory json);;
```

### serializeJsonType(string,bytes)

- **Signature**: `serializeJsonType(string,bytes)`
- **Visibility**: external
- **Source Range**: 52572:149:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeJsonType(string calldata typeDescription, bytes calldata value) external pure returns (string memory json);;
```

### serializeJsonType(string,string,string,bytes)

- **Signature**: `serializeJsonType(string,string,string,bytes)`
- **Visibility**: external
- **Source Range**: 52756:211:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeJsonType(string calldata objectKey, string calldata valueKey, string calldata typeDescription, bytes calldata value) external returns (string memory json);;
```

### serializeString(string,string,string)

- **Signature**: `serializeString(string,string,string)`
- **Visibility**: external
- **Source Range**: 53002:155:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeString(string calldata objectKey, string calldata valueKey, string calldata value) external returns (string memory json);;
```

### serializeString(string,string,string[])

- **Signature**: `serializeString(string,string,string[])`
- **Visibility**: external
- **Source Range**: 53192:158:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeString(string calldata objectKey, string calldata valueKey, string[] calldata values) external returns (string memory json);;
```

### serializeUintToHex(string,string,uint256)

- **Signature**: `serializeUintToHex(string,string,uint256)`
- **Visibility**: external
- **Source Range**: 53385:150:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeUintToHex(string calldata objectKey, string calldata valueKey, uint256 value) external returns (string memory json);;
```

### serializeUint(string,string,uint256)

- **Signature**: `serializeUint(string,string,uint256)`
- **Visibility**: external
- **Source Range**: 53570:145:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeUint(string calldata objectKey, string calldata valueKey, uint256 value) external returns (string memory json);;
```

### serializeUint(string,string,uint256[])

- **Signature**: `serializeUint(string,string,uint256[])`
- **Visibility**: external
- **Source Range**: 53750:157:25

**Signature:**
```solidity
/// See `serializeJson`.
function serializeUint(string calldata objectKey, string calldata valueKey, uint256[] calldata values) external returns (string memory json);;
```

### writeJson(string,string)

- **Signature**: `writeJson(string,string)`
- **Visibility**: external
- **Source Range**: 54007:72:25

**Signature:**
```solidity
/// Write a serialized JSON object to a file. If the file exists, it will be overwritten.
function writeJson(string calldata json, string calldata path) external;;
```

### writeJson(string,string,string)

- **Signature**: `writeJson(string,string,string)`
- **Visibility**: external
- **Source Range**: 54305:98:25

**Signature:**
```solidity
/// Write a serialized JSON object to an **existing** JSON file, replacing a value with key = <value_key.>
///  This is useful to replace a specific value of a JSON file, without having to parse the entire thing.
function writeJson(string calldata json, string calldata path, string calldata valueKey) external;;
```

### keyExists(string,string)

- **Signature**: `keyExists(string,string)`
- **Visibility**: external
- **Source Range**: 54565:91:25

**Signature:**
```solidity
/// Checks if `key` exists in a JSON object
///  `keyExists` is being deprecated in favor of `keyExistsJson`. It will be removed in future versions.
function keyExists(string calldata json, string calldata key) external view returns (bool);;
```

### attachBlob(bytes)

- **Signature**: `attachBlob(bytes)`
- **Visibility**: external
- **Source Range**: 54747:50:25

**Signature:**
```solidity
/// Attach an EIP-4844 blob to the next call
function attachBlob(bytes calldata blob) external;;
```

### attachDelegation(struct VmSafe.SignedDelegation)

- **Signature**: `attachDelegation(struct VmSafe.SignedDelegation)`
- **Visibility**: external
- **Source Range**: 54862:79:25

**Signature:**
```solidity
/// Designate the next call as an EIP-7702 transaction
function attachDelegation(SignedDelegation calldata signedDelegation) external;;
```

### attachDelegation(struct VmSafe.SignedDelegation,bool)

- **Signature**: `attachDelegation(struct VmSafe.SignedDelegation,bool)`
- **Visibility**: external
- **Source Range**: 55043:96:25

**Signature:**
```solidity
/// Designate the next call as an EIP-7702 transaction, with optional cross-chain validity.
function attachDelegation(SignedDelegation calldata signedDelegation, bool crossChain) external;;
```

### broadcastRawTransaction(bytes)

- **Signature**: `broadcastRawTransaction(bytes)`
- **Visibility**: external
- **Source Range**: 55214:63:25

**Signature:**
```solidity
/// Takes a signed transaction and broadcasts it to the network.
function broadcastRawTransaction(bytes calldata data) external;;
```

### broadcast()

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

### broadcast(address)

- **Signature**: `broadcast(address)`
- **Visibility**: external
- **Source Range**: 55980:44:25

**Signature:**
```solidity
/// Has the next call (at this call depth only) create a transaction with the address provided
///  as the sender that can later be signed and sent onchain.
function broadcast(address signer) external;;
```

### broadcast(uint256)

- **Signature**: `broadcast(uint256)`
- **Visibility**: external
- **Source Range**: 56198:48:25

**Signature:**
```solidity
/// Has the next call (at this call depth only) create a transaction with the private key
///  provided as the sender that can later be signed and sent onchain.
function broadcast(uint256 privateKey) external;;
```

### getWallets()

- **Signature**: `getWallets()`
- **Visibility**: external
- **Source Range**: 56335:66:25

**Signature:**
```solidity
/// Returns addresses of available unlocked wallets in the script environment.
function getWallets() external returns (address[] memory wallets);;
```

### signAndAttachDelegation(address,uint256)

- **Signature**: `signAndAttachDelegation(address,uint256)`
- **Visibility**: external
- **Source Range**: 56501:153:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization and designate the next call as an EIP-7702 transaction
function signAndAttachDelegation(address implementation, uint256 privateKey) external returns (SignedDelegation memory signedDelegation);;
```

### signAndAttachDelegation(address,uint256,uint64)

- **Signature**: `signAndAttachDelegation(address,uint256,uint64)`
- **Visibility**: external
- **Source Range**: 56773:167:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization and designate the next call as an EIP-7702 transaction for specific nonce
function signAndAttachDelegation(address implementation, uint256 privateKey, uint64 nonce) external returns (SignedDelegation memory signedDelegation);;
```

### signAndAttachDelegation(address,uint256,bool)

- **Signature**: `signAndAttachDelegation(address,uint256,bool)`
- **Visibility**: external
- **Source Range**: 57077:170:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization and designate the next call as an EIP-7702 transaction, with optional cross-chain validity.
function signAndAttachDelegation(address implementation, uint256 privateKey, bool crossChain) external returns (SignedDelegation memory signedDelegation);;
```

### signDelegation(address,uint256)

- **Signature**: `signDelegation(address,uint256)`
- **Visibility**: external
- **Source Range**: 57307:144:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization for delegation
function signDelegation(address implementation, uint256 privateKey) external returns (SignedDelegation memory signedDelegation);;
```

### signDelegation(address,uint256,uint64)

- **Signature**: `signDelegation(address,uint256,uint64)`
- **Visibility**: external
- **Source Range**: 57530:158:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization for delegation for specific nonce
function signDelegation(address implementation, uint256 privateKey, uint64 nonce) external returns (SignedDelegation memory signedDelegation);;
```

### signDelegation(address,uint256,bool)

- **Signature**: `signDelegation(address,uint256,bool)`
- **Visibility**: external
- **Source Range**: 57785:161:25

**Signature:**
```solidity
/// Sign an EIP-7702 authorization for delegation, with optional cross-chain validity.
function signDelegation(address implementation, uint256 privateKey, bool crossChain) external returns (SignedDelegation memory signedDelegation);;
```

### startBroadcast()

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

### startBroadcast(address)

- **Signature**: `startBroadcast(address)`
- **Visibility**: external
- **Source Range**: 58653:49:25

**Signature:**
```solidity
/// Has all subsequent calls (at this call depth only) create transactions with the address
///  provided that can later be signed and sent onchain.
function startBroadcast(address signer) external;;
```

### startBroadcast(uint256)

- **Signature**: `startBroadcast(uint256)`
- **Visibility**: external
- **Source Range**: 58868:53:25

**Signature:**
```solidity
/// Has all subsequent calls (at this call depth only) create transactions with the private key
///  provided that can later be signed and sent onchain.
function startBroadcast(uint256 privateKey) external;;
```

### stopBroadcast()

- **Signature**: `stopBroadcast()`
- **Visibility**: external
- **Source Range**: 58974:34:25

**Signature:**
```solidity
/// Stops collecting onchain transactions.
function stopBroadcast() external;;
```

### contains(string,string)

- **Signature**: `contains(string,string)`
- **Visibility**: external
- **Source Range**: 59120:98:25

**Signature:**
```solidity
/// Returns true if `search` is found in `subject`, false otherwise.
function contains(string calldata subject, string calldata search) external returns (bool result);;
```

### indexOf(string,string)

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

### parseAddress(string)

- **Signature**: `parseAddress(string)`
- **Visibility**: external
- **Source Range**: 59586:100:25

**Signature:**
```solidity
/// Parses the given `string` into an `address`.
function parseAddress(string calldata stringifiedValue) external pure returns (address parsedValue);;
```

### parseBool(string)

- **Signature**: `parseBool(string)`
- **Visibility**: external
- **Source Range**: 59741:94:25

**Signature:**
```solidity
/// Parses the given `string` into a `bool`.
function parseBool(string calldata stringifiedValue) external pure returns (bool parsedValue);;
```

### parseBytes(string)

- **Signature**: `parseBytes(string)`
- **Visibility**: external
- **Source Range**: 59889:103:25

**Signature:**
```solidity
/// Parses the given `string` into `bytes`.
function parseBytes(string calldata stringifiedValue) external pure returns (bytes memory parsedValue);;
```

### parseBytes32(string)

- **Signature**: `parseBytes32(string)`
- **Visibility**: external
- **Source Range**: 60050:100:25

**Signature:**
```solidity
/// Parses the given `string` into a `bytes32`.
function parseBytes32(string calldata stringifiedValue) external pure returns (bytes32 parsedValue);;
```

### parseInt(string)

- **Signature**: `parseInt(string)`
- **Visibility**: external
- **Source Range**: 60207:95:25

**Signature:**
```solidity
/// Parses the given `string` into a `int256`.
function parseInt(string calldata stringifiedValue) external pure returns (int256 parsedValue);;
```

### parseUint(string)

- **Signature**: `parseUint(string)`
- **Visibility**: external
- **Source Range**: 60360:97:25

**Signature:**
```solidity
/// Parses the given `string` into a `uint256`.
function parseUint(string calldata stringifiedValue) external pure returns (uint256 parsedValue);;
```

### replace(string,string,string)

- **Signature**: `replace(string,string,string)`
- **Visibility**: external
- **Source Range**: 60535:151:25

**Signature:**
```solidity
/// Replaces occurrences of `from` in the given `string` with `to`.
function replace(string calldata input, string calldata from, string calldata to) external pure returns (string memory output);;
```

### split(string,string)

- **Signature**: `split(string,string)`
- **Visibility**: external
- **Source Range**: 60779:113:25

**Signature:**
```solidity
/// Splits the given `string` into an array of strings divided by the `delimiter`.
function split(string calldata input, string calldata delimiter) external pure returns (string[] memory outputs);;
```

### toLowercase(string)

- **Signature**: `toLowercase(string)`
- **Visibility**: external
- **Source Range**: 60954:89:25

**Signature:**
```solidity
/// Converts the given `string` value to Lowercase.
function toLowercase(string calldata input) external pure returns (string memory output);;
```

### toString(address)

- **Signature**: `toString(address)`
- **Visibility**: external
- **Source Range**: 61097:88:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(address value) external pure returns (string memory stringifiedValue);;
```

### toString(bytes)

- **Signature**: `toString(bytes)`
- **Visibility**: external
- **Source Range**: 61239:95:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(bytes calldata value) external pure returns (string memory stringifiedValue);;
```

### toString(bytes32)

- **Signature**: `toString(bytes32)`
- **Visibility**: external
- **Source Range**: 61388:88:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(bytes32 value) external pure returns (string memory stringifiedValue);;
```

### toString(bool)

- **Signature**: `toString(bool)`
- **Visibility**: external
- **Source Range**: 61530:85:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(bool value) external pure returns (string memory stringifiedValue);;
```

### toString(uint256)

- **Signature**: `toString(uint256)`
- **Visibility**: external
- **Source Range**: 61669:88:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(uint256 value) external pure returns (string memory stringifiedValue);;
```

### toString(int256)

- **Signature**: `toString(int256)`
- **Visibility**: external
- **Source Range**: 61811:87:25

**Signature:**
```solidity
/// Converts the given value to a `string`.
function toString(int256 value) external pure returns (string memory stringifiedValue);;
```

### toUppercase(string)

- **Signature**: `toUppercase(string)`
- **Visibility**: external
- **Source Range**: 61960:89:25

**Signature:**
```solidity
/// Converts the given `string` value to Uppercase.
function toUppercase(string calldata input) external pure returns (string memory output);;
```

### trim(string)

- **Signature**: `trim(string)`
- **Visibility**: external
- **Source Range**: 62132:82:25

**Signature:**
```solidity
/// Trims leading and trailing whitespace from the given `string` value.
function trim(string calldata input) external pure returns (string memory output);;
```

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256)

- **Signature**: `assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 62409:113:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
///  Formats values with decimals in failure message.
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals) external pure;;
```

### assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)

- **Signature**: `assertApproxEqAbsDecimal(uint256,uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 62737:182:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string calldata error) external pure;;
```

### assertApproxEqAbsDecimal(int256,int256,uint256,uint256)

- **Signature**: `assertApproxEqAbsDecimal(int256,int256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 63079:111:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
///  Formats values with decimals in failure message.
function assertApproxEqAbsDecimal(int256 left, int256 right, uint256 maxDelta, uint256 decimals) external pure;;
```

### assertApproxEqAbsDecimal(int256,int256,uint256,uint256,string)

- **Signature**: `assertApproxEqAbsDecimal(int256,int256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 63404:180:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertApproxEqAbsDecimal(int256 left, int256 right, uint256 maxDelta, uint256 decimals, string calldata error) external pure;;
```

### assertApproxEqAbs(uint256,uint256,uint256)

- **Signature**: `assertApproxEqAbs(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 63688:88:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta) external pure;;
```

### assertApproxEqAbs(uint256,uint256,uint256,string)

- **Signature**: `assertApproxEqAbs(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 63942:111:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects difference to be less than or equal to `maxDelta`.
///  Includes error message into revert string on failure.
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta, string calldata error) external pure;;
```

### assertApproxEqAbs(int256,int256,uint256)

- **Signature**: `assertApproxEqAbs(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 64156:86:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
function assertApproxEqAbs(int256 left, int256 right, uint256 maxDelta) external pure;;
```

### assertApproxEqAbs(int256,int256,uint256,string)

- **Signature**: `assertApproxEqAbs(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 64407:109:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects difference to be less than or equal to `maxDelta`.
///  Includes error message into revert string on failure.
function assertApproxEqAbs(int256 left, int256 right, uint256 maxDelta, string calldata error) external pure;;
```

### assertApproxEqRelDecimal(uint256,uint256,uint256,uint256)

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

### assertApproxEqRelDecimal(uint256,uint256,uint256,uint256,string)

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

### assertApproxEqRelDecimal(int256,int256,uint256,uint256)

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

### assertApproxEqRelDecimal(int256,int256,uint256,uint256,string)

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

### assertApproxEqRel(uint256,uint256,uint256)

- **Signature**: `assertApproxEqRel(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 66566:95:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
function assertApproxEqRel(uint256 left, uint256 right, uint256 maxPercentDelta) external pure;;
```

### assertApproxEqRel(uint256,uint256,uint256,string)

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

### assertApproxEqRel(int256,int256,uint256)

- **Signature**: `assertApproxEqRel(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 67284:93:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects relative difference in percents to be less than or equal to `maxPercentDelta`.
///  `maxPercentDelta` is an 18 decimal fixed point number, where 1e18 == 100%
function assertApproxEqRel(int256 left, int256 right, uint256 maxPercentDelta) external pure;;
```

### assertApproxEqRel(int256,int256,uint256,string)

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

### assertEqDecimal(uint256,uint256,uint256)

- **Signature**: `assertEqDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 67893:86:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are equal, formatting them with decimals in failure message.
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertEqDecimal(uint256,uint256,uint256,string)

- **Signature**: `assertEqDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 68150:109:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are equal, formatting them with decimals in failure message.
///  Includes error message into revert string on failure.
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertEqDecimal(int256,int256,uint256)

- **Signature**: `assertEqDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 68367:84:25

**Signature:**
```solidity
/// Asserts that two `int256` values are equal, formatting them with decimals in failure message.
function assertEqDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertEqDecimal(int256,int256,uint256,string)

- **Signature**: `assertEqDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 68621:107:25

**Signature:**
```solidity
/// Asserts that two `int256` values are equal, formatting them with decimals in failure message.
///  Includes error message into revert string on failure.
function assertEqDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertEq(bool,bool)

- **Signature**: `assertEq(bool,bool)`
- **Visibility**: external
- **Source Range**: 68784:55:25

**Signature:**
```solidity
/// Asserts that two `bool` values are equal.
function assertEq(bool left, bool right) external pure;;
```

### assertEq(bool,bool,string)

- **Signature**: `assertEq(bool,bool,string)`
- **Visibility**: external
- **Source Range**: 68952:78:25

**Signature:**
```solidity
/// Asserts that two `bool` values are equal and includes error message into revert string on failure.
function assertEq(bool left, bool right, string calldata error) external pure;;
```

### assertEq(string,string)

- **Signature**: `assertEq(string,string)`
- **Visibility**: external
- **Source Range**: 69088:77:25

**Signature:**
```solidity
/// Asserts that two `string` values are equal.
function assertEq(string calldata left, string calldata right) external pure;;
```

### assertEq(string,string,string)

- **Signature**: `assertEq(string,string,string)`
- **Visibility**: external
- **Source Range**: 69280:100:25

**Signature:**
```solidity
/// Asserts that two `string` values are equal and includes error message into revert string on failure.
function assertEq(string calldata left, string calldata right, string calldata error) external pure;;
```

### assertEq(bytes,bytes)

- **Signature**: `assertEq(bytes,bytes)`
- **Visibility**: external
- **Source Range**: 69437:75:25

**Signature:**
```solidity
/// Asserts that two `bytes` values are equal.
function assertEq(bytes calldata left, bytes calldata right) external pure;;
```

### assertEq(bytes,bytes,string)

- **Signature**: `assertEq(bytes,bytes,string)`
- **Visibility**: external
- **Source Range**: 69626:98:25

**Signature:**
```solidity
/// Asserts that two `bytes` values are equal and includes error message into revert string on failure.
function assertEq(bytes calldata left, bytes calldata right, string calldata error) external pure;;
```

### assertEq(bool[],bool[])

- **Signature**: `assertEq(bool[],bool[])`
- **Visibility**: external
- **Source Range**: 69790:77:25

**Signature:**
```solidity
/// Asserts that two arrays of `bool` values are equal.
function assertEq(bool[] calldata left, bool[] calldata right) external pure;;
```

### assertEq(bool[],bool[],string)

- **Signature**: `assertEq(bool[],bool[],string)`
- **Visibility**: external
- **Source Range**: 69990:100:25

**Signature:**
```solidity
/// Asserts that two arrays of `bool` values are equal and includes error message into revert string on failure.
function assertEq(bool[] calldata left, bool[] calldata right, string calldata error) external pure;;
```

### assertEq(uint256[],uint256[])

- **Signature**: `assertEq(uint256[],uint256[])`
- **Visibility**: external
- **Source Range**: 70158:83:25

**Signature:**
```solidity
/// Asserts that two arrays of `uint256 values are equal.
function assertEq(uint256[] calldata left, uint256[] calldata right) external pure;;
```

### assertEq(uint256[],uint256[],string)

- **Signature**: `assertEq(uint256[],uint256[],string)`
- **Visibility**: external
- **Source Range**: 70367:106:25

**Signature:**
```solidity
/// Asserts that two arrays of `uint256` values are equal and includes error message into revert string on failure.
function assertEq(uint256[] calldata left, uint256[] calldata right, string calldata error) external pure;;
```

### assertEq(int256[],int256[])

- **Signature**: `assertEq(int256[],int256[])`
- **Visibility**: external
- **Source Range**: 70541:81:25

**Signature:**
```solidity
/// Asserts that two arrays of `int256` values are equal.
function assertEq(int256[] calldata left, int256[] calldata right) external pure;;
```

### assertEq(int256[],int256[],string)

- **Signature**: `assertEq(int256[],int256[],string)`
- **Visibility**: external
- **Source Range**: 70747:104:25

**Signature:**
```solidity
/// Asserts that two arrays of `int256` values are equal and includes error message into revert string on failure.
function assertEq(int256[] calldata left, int256[] calldata right, string calldata error) external pure;;
```

### assertEq(uint256,uint256)

- **Signature**: `assertEq(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 70910:61:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are equal.
function assertEq(uint256 left, uint256 right) external pure;;
```

### assertEq(address[],address[])

- **Signature**: `assertEq(address[],address[])`
- **Visibility**: external
- **Source Range**: 71040:83:25

**Signature:**
```solidity
/// Asserts that two arrays of `address` values are equal.
function assertEq(address[] calldata left, address[] calldata right) external pure;;
```

### assertEq(address[],address[],string)

- **Signature**: `assertEq(address[],address[],string)`
- **Visibility**: external
- **Source Range**: 71249:106:25

**Signature:**
```solidity
/// Asserts that two arrays of `address` values are equal and includes error message into revert string on failure.
function assertEq(address[] calldata left, address[] calldata right, string calldata error) external pure;;
```

### assertEq(bytes32[],bytes32[])

- **Signature**: `assertEq(bytes32[],bytes32[])`
- **Visibility**: external
- **Source Range**: 71424:83:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes32` values are equal.
function assertEq(bytes32[] calldata left, bytes32[] calldata right) external pure;;
```

### assertEq(bytes32[],bytes32[],string)

- **Signature**: `assertEq(bytes32[],bytes32[],string)`
- **Visibility**: external
- **Source Range**: 71633:106:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes32` values are equal and includes error message into revert string on failure.
function assertEq(bytes32[] calldata left, bytes32[] calldata right, string calldata error) external pure;;
```

### assertEq(string[],string[])

- **Signature**: `assertEq(string[],string[])`
- **Visibility**: external
- **Source Range**: 71807:81:25

**Signature:**
```solidity
/// Asserts that two arrays of `string` values are equal.
function assertEq(string[] calldata left, string[] calldata right) external pure;;
```

### assertEq(string[],string[],string)

- **Signature**: `assertEq(string[],string[],string)`
- **Visibility**: external
- **Source Range**: 72013:104:25

**Signature:**
```solidity
/// Asserts that two arrays of `string` values are equal and includes error message into revert string on failure.
function assertEq(string[] calldata left, string[] calldata right, string calldata error) external pure;;
```

### assertEq(bytes[],bytes[])

- **Signature**: `assertEq(bytes[],bytes[])`
- **Visibility**: external
- **Source Range**: 72184:79:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes` values are equal.
function assertEq(bytes[] calldata left, bytes[] calldata right) external pure;;
```

### assertEq(bytes[],bytes[],string)

- **Signature**: `assertEq(bytes[],bytes[],string)`
- **Visibility**: external
- **Source Range**: 72387:102:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes` values are equal and includes error message into revert string on failure.
function assertEq(bytes[] calldata left, bytes[] calldata right, string calldata error) external pure;;
```

### assertEq(uint256,uint256,string)

- **Signature**: `assertEq(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 72605:84:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are equal and includes error message into revert string on failure.
function assertEq(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertEq(int256,int256)

- **Signature**: `assertEq(int256,int256)`
- **Visibility**: external
- **Source Range**: 72747:59:25

**Signature:**
```solidity
/// Asserts that two `int256` values are equal.
function assertEq(int256 left, int256 right) external pure;;
```

### assertEq(int256,int256,string)

- **Signature**: `assertEq(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 72921:82:25

**Signature:**
```solidity
/// Asserts that two `int256` values are equal and includes error message into revert string on failure.
function assertEq(int256 left, int256 right, string calldata error) external pure;;
```

### assertEq(address,address)

- **Signature**: `assertEq(address,address)`
- **Visibility**: external
- **Source Range**: 73062:61:25

**Signature:**
```solidity
/// Asserts that two `address` values are equal.
function assertEq(address left, address right) external pure;;
```

### assertEq(address,address,string)

- **Signature**: `assertEq(address,address,string)`
- **Visibility**: external
- **Source Range**: 73239:84:25

**Signature:**
```solidity
/// Asserts that two `address` values are equal and includes error message into revert string on failure.
function assertEq(address left, address right, string calldata error) external pure;;
```

### assertEq(bytes32,bytes32)

- **Signature**: `assertEq(bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 73382:61:25

**Signature:**
```solidity
/// Asserts that two `bytes32` values are equal.
function assertEq(bytes32 left, bytes32 right) external pure;;
```

### assertEq(bytes32,bytes32,string)

- **Signature**: `assertEq(bytes32,bytes32,string)`
- **Visibility**: external
- **Source Range**: 73559:84:25

**Signature:**
```solidity
/// Asserts that two `bytes32` values are equal and includes error message into revert string on failure.
function assertEq(bytes32 left, bytes32 right, string calldata error) external pure;;
```

### assertFalse(bool)

- **Signature**: `assertFalse(bool)`
- **Visibility**: external
- **Source Range**: 73700:51:25

**Signature:**
```solidity
/// Asserts that the given condition is false.
function assertFalse(bool condition) external pure;;
```

### assertFalse(bool,string)

- **Signature**: `assertFalse(bool,string)`
- **Visibility**: external
- **Source Range**: 73865:74:25

**Signature:**
```solidity
/// Asserts that the given condition is false and includes error message into revert string on failure.
function assertFalse(bool condition, string calldata error) external pure;;
```

### assertGeDecimal(uint256,uint256,uint256)

- **Signature**: `assertGeDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 74100:86:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than or equal to second.
///  Formats values with decimals in failure message.
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertGeDecimal(uint256,uint256,uint256,string)

- **Signature**: `assertGeDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 74401:109:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than or equal to second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertGeDecimal(int256,int256,uint256)

- **Signature**: `assertGeDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 74670:84:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than or equal to second.
///  Formats values with decimals in failure message.
function assertGeDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertGeDecimal(int256,int256,uint256,string)

- **Signature**: `assertGeDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 74968:107:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than or equal to second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertGeDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertGe(uint256,uint256)

- **Signature**: `assertGe(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 75179:61:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than or equal to second.
function assertGe(uint256 left, uint256 right) external pure;;
```

### assertGe(uint256,uint256,string)

- **Signature**: `assertGe(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 75406:84:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than or equal to second.
///  Includes error message into revert string on failure.
function assertGe(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertGe(int256,int256)

- **Signature**: `assertGe(int256,int256)`
- **Visibility**: external
- **Source Range**: 75593:59:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than or equal to second.
function assertGe(int256 left, int256 right) external pure;;
```

### assertGe(int256,int256,string)

- **Signature**: `assertGe(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 75817:82:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than or equal to second.
///  Includes error message into revert string on failure.
function assertGe(int256 left, int256 right, string calldata error) external pure;;
```

### assertGtDecimal(uint256,uint256,uint256)

- **Signature**: `assertGtDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 76048:86:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than second.
///  Formats values with decimals in failure message.
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertGtDecimal(uint256,uint256,uint256,string)

- **Signature**: `assertGtDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 76337:109:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertGtDecimal(int256,int256,uint256)

- **Signature**: `assertGtDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 76594:84:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than second.
///  Formats values with decimals in failure message.
function assertGtDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertGtDecimal(int256,int256,uint256,string)

- **Signature**: `assertGtDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 76880:107:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertGtDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertGt(uint256,uint256)

- **Signature**: `assertGt(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 77079:61:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than second.
function assertGt(uint256 left, uint256 right) external pure;;
```

### assertGt(uint256,uint256,string)

- **Signature**: `assertGt(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 77294:84:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be greater than second.
///  Includes error message into revert string on failure.
function assertGt(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertGt(int256,int256)

- **Signature**: `assertGt(int256,int256)`
- **Visibility**: external
- **Source Range**: 77469:59:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than second.
function assertGt(int256 left, int256 right) external pure;;
```

### assertGt(int256,int256,string)

- **Signature**: `assertGt(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 77681:82:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be greater than second.
///  Includes error message into revert string on failure.
function assertGt(int256 left, int256 right, string calldata error) external pure;;
```

### assertLeDecimal(uint256,uint256,uint256)

- **Signature**: `assertLeDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 77921:86:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than or equal to second.
///  Formats values with decimals in failure message.
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertLeDecimal(uint256,uint256,uint256,string)

- **Signature**: `assertLeDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 78219:109:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than or equal to second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertLeDecimal(int256,int256,uint256)

- **Signature**: `assertLeDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 78485:84:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than or equal to second.
///  Formats values with decimals in failure message.
function assertLeDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertLeDecimal(int256,int256,uint256,string)

- **Signature**: `assertLeDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 78780:107:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than or equal to second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertLeDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertLe(uint256,uint256)

- **Signature**: `assertLe(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 78988:61:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than or equal to second.
function assertLe(uint256 left, uint256 right) external pure;;
```

### assertLe(uint256,uint256,string)

- **Signature**: `assertLe(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 79212:84:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than or equal to second.
///  Includes error message into revert string on failure.
function assertLe(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertLe(int256,int256)

- **Signature**: `assertLe(int256,int256)`
- **Visibility**: external
- **Source Range**: 79396:59:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than or equal to second.
function assertLe(int256 left, int256 right) external pure;;
```

### assertLe(int256,int256,string)

- **Signature**: `assertLe(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 79617:82:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than or equal to second.
///  Includes error message into revert string on failure.
function assertLe(int256 left, int256 right, string calldata error) external pure;;
```

### assertLtDecimal(uint256,uint256,uint256)

- **Signature**: `assertLtDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 79845:86:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than second.
///  Formats values with decimals in failure message.
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertLtDecimal(uint256,uint256,uint256,string)

- **Signature**: `assertLtDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 80131:109:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertLtDecimal(int256,int256,uint256)

- **Signature**: `assertLtDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 80385:84:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than second.
///  Formats values with decimals in failure message.
function assertLtDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertLtDecimal(int256,int256,uint256,string)

- **Signature**: `assertLtDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 80668:107:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than second.
///  Formats values with decimals in failure message. Includes error message into revert string on failure.
function assertLtDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertLt(uint256,uint256)

- **Signature**: `assertLt(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 80864:61:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than second.
function assertLt(uint256 left, uint256 right) external pure;;
```

### assertLt(uint256,uint256,string)

- **Signature**: `assertLt(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 81076:84:25

**Signature:**
```solidity
/// Compares two `uint256` values. Expects first value to be less than second.
///  Includes error message into revert string on failure.
function assertLt(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertLt(int256,int256)

- **Signature**: `assertLt(int256,int256)`
- **Visibility**: external
- **Source Range**: 81248:59:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than second.
function assertLt(int256 left, int256 right) external pure;;
```

### assertLt(int256,int256,string)

- **Signature**: `assertLt(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 81457:82:25

**Signature:**
```solidity
/// Compares two `int256` values. Expects first value to be less than second.
///  Includes error message into revert string on failure.
function assertLt(int256 left, int256 right, string calldata error) external pure;;
```

### assertNotEqDecimal(uint256,uint256,uint256)

- **Signature**: `assertNotEqDecimal(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 81652:89:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are not equal, formatting them with decimals in failure message.
function assertNotEqDecimal(uint256 left, uint256 right, uint256 decimals) external pure;;
```

### assertNotEqDecimal(uint256,uint256,uint256,string)

- **Signature**: `assertNotEqDecimal(uint256,uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 81916:112:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are not equal, formatting them with decimals in failure message.
///  Includes error message into revert string on failure.
function assertNotEqDecimal(uint256 left, uint256 right, uint256 decimals, string calldata error) external pure;;
```

### assertNotEqDecimal(int256,int256,uint256)

- **Signature**: `assertNotEqDecimal(int256,int256,uint256)`
- **Visibility**: external
- **Source Range**: 82140:87:25

**Signature:**
```solidity
/// Asserts that two `int256` values are not equal, formatting them with decimals in failure message.
function assertNotEqDecimal(int256 left, int256 right, uint256 decimals) external pure;;
```

### assertNotEqDecimal(int256,int256,uint256,string)

- **Signature**: `assertNotEqDecimal(int256,int256,uint256,string)`
- **Visibility**: external
- **Source Range**: 82401:110:25

**Signature:**
```solidity
/// Asserts that two `int256` values are not equal, formatting them with decimals in failure message.
///  Includes error message into revert string on failure.
function assertNotEqDecimal(int256 left, int256 right, uint256 decimals, string calldata error) external pure;;
```

### assertNotEq(bool,bool)

- **Signature**: `assertNotEq(bool,bool)`
- **Visibility**: external
- **Source Range**: 82571:58:25

**Signature:**
```solidity
/// Asserts that two `bool` values are not equal.
function assertNotEq(bool left, bool right) external pure;;
```

### assertNotEq(bool,bool,string)

- **Signature**: `assertNotEq(bool,bool,string)`
- **Visibility**: external
- **Source Range**: 82746:81:25

**Signature:**
```solidity
/// Asserts that two `bool` values are not equal and includes error message into revert string on failure.
function assertNotEq(bool left, bool right, string calldata error) external pure;;
```

### assertNotEq(string,string)

- **Signature**: `assertNotEq(string,string)`
- **Visibility**: external
- **Source Range**: 82889:80:25

**Signature:**
```solidity
/// Asserts that two `string` values are not equal.
function assertNotEq(string calldata left, string calldata right) external pure;;
```

### assertNotEq(string,string,string)

- **Signature**: `assertNotEq(string,string,string)`
- **Visibility**: external
- **Source Range**: 83088:103:25

**Signature:**
```solidity
/// Asserts that two `string` values are not equal and includes error message into revert string on failure.
function assertNotEq(string calldata left, string calldata right, string calldata error) external pure;;
```

### assertNotEq(bytes,bytes)

- **Signature**: `assertNotEq(bytes,bytes)`
- **Visibility**: external
- **Source Range**: 83252:78:25

**Signature:**
```solidity
/// Asserts that two `bytes` values are not equal.
function assertNotEq(bytes calldata left, bytes calldata right) external pure;;
```

### assertNotEq(bytes,bytes,string)

- **Signature**: `assertNotEq(bytes,bytes,string)`
- **Visibility**: external
- **Source Range**: 83448:101:25

**Signature:**
```solidity
/// Asserts that two `bytes` values are not equal and includes error message into revert string on failure.
function assertNotEq(bytes calldata left, bytes calldata right, string calldata error) external pure;;
```

### assertNotEq(bool[],bool[])

- **Signature**: `assertNotEq(bool[],bool[])`
- **Visibility**: external
- **Source Range**: 83619:80:25

**Signature:**
```solidity
/// Asserts that two arrays of `bool` values are not equal.
function assertNotEq(bool[] calldata left, bool[] calldata right) external pure;;
```

### assertNotEq(bool[],bool[],string)

- **Signature**: `assertNotEq(bool[],bool[],string)`
- **Visibility**: external
- **Source Range**: 83826:103:25

**Signature:**
```solidity
/// Asserts that two arrays of `bool` values are not equal and includes error message into revert string on failure.
function assertNotEq(bool[] calldata left, bool[] calldata right, string calldata error) external pure;;
```

### assertNotEq(uint256[],uint256[])

- **Signature**: `assertNotEq(uint256[],uint256[])`
- **Visibility**: external
- **Source Range**: 84002:86:25

**Signature:**
```solidity
/// Asserts that two arrays of `uint256` values are not equal.
function assertNotEq(uint256[] calldata left, uint256[] calldata right) external pure;;
```

### assertNotEq(uint256[],uint256[],string)

- **Signature**: `assertNotEq(uint256[],uint256[],string)`
- **Visibility**: external
- **Source Range**: 84218:109:25

**Signature:**
```solidity
/// Asserts that two arrays of `uint256` values are not equal and includes error message into revert string on failure.
function assertNotEq(uint256[] calldata left, uint256[] calldata right, string calldata error) external pure;;
```

### assertNotEq(int256[],int256[])

- **Signature**: `assertNotEq(int256[],int256[])`
- **Visibility**: external
- **Source Range**: 84399:84:25

**Signature:**
```solidity
/// Asserts that two arrays of `int256` values are not equal.
function assertNotEq(int256[] calldata left, int256[] calldata right) external pure;;
```

### assertNotEq(int256[],int256[],string)

- **Signature**: `assertNotEq(int256[],int256[],string)`
- **Visibility**: external
- **Source Range**: 84612:107:25

**Signature:**
```solidity
/// Asserts that two arrays of `int256` values are not equal and includes error message into revert string on failure.
function assertNotEq(int256[] calldata left, int256[] calldata right, string calldata error) external pure;;
```

### assertNotEq(uint256,uint256)

- **Signature**: `assertNotEq(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 84782:64:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are not equal.
function assertNotEq(uint256 left, uint256 right) external pure;;
```

### assertNotEq(address[],address[])

- **Signature**: `assertNotEq(address[],address[])`
- **Visibility**: external
- **Source Range**: 84919:86:25

**Signature:**
```solidity
/// Asserts that two arrays of `address` values are not equal.
function assertNotEq(address[] calldata left, address[] calldata right) external pure;;
```

### assertNotEq(address[],address[],string)

- **Signature**: `assertNotEq(address[],address[],string)`
- **Visibility**: external
- **Source Range**: 85135:109:25

**Signature:**
```solidity
/// Asserts that two arrays of `address` values are not equal and includes error message into revert string on failure.
function assertNotEq(address[] calldata left, address[] calldata right, string calldata error) external pure;;
```

### assertNotEq(bytes32[],bytes32[])

- **Signature**: `assertNotEq(bytes32[],bytes32[])`
- **Visibility**: external
- **Source Range**: 85317:86:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes32` values are not equal.
function assertNotEq(bytes32[] calldata left, bytes32[] calldata right) external pure;;
```

### assertNotEq(bytes32[],bytes32[],string)

- **Signature**: `assertNotEq(bytes32[],bytes32[],string)`
- **Visibility**: external
- **Source Range**: 85533:109:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes32` values are not equal and includes error message into revert string on failure.
function assertNotEq(bytes32[] calldata left, bytes32[] calldata right, string calldata error) external pure;;
```

### assertNotEq(string[],string[])

- **Signature**: `assertNotEq(string[],string[])`
- **Visibility**: external
- **Source Range**: 85714:84:25

**Signature:**
```solidity
/// Asserts that two arrays of `string` values are not equal.
function assertNotEq(string[] calldata left, string[] calldata right) external pure;;
```

### assertNotEq(string[],string[],string)

- **Signature**: `assertNotEq(string[],string[],string)`
- **Visibility**: external
- **Source Range**: 85927:107:25

**Signature:**
```solidity
/// Asserts that two arrays of `string` values are not equal and includes error message into revert string on failure.
function assertNotEq(string[] calldata left, string[] calldata right, string calldata error) external pure;;
```

### assertNotEq(bytes[],bytes[])

- **Signature**: `assertNotEq(bytes[],bytes[])`
- **Visibility**: external
- **Source Range**: 86105:82:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes` values are not equal.
function assertNotEq(bytes[] calldata left, bytes[] calldata right) external pure;;
```

### assertNotEq(bytes[],bytes[],string)

- **Signature**: `assertNotEq(bytes[],bytes[],string)`
- **Visibility**: external
- **Source Range**: 86315:105:25

**Signature:**
```solidity
/// Asserts that two arrays of `bytes` values are not equal and includes error message into revert string on failure.
function assertNotEq(bytes[] calldata left, bytes[] calldata right, string calldata error) external pure;;
```

### assertNotEq(uint256,uint256,string)

- **Signature**: `assertNotEq(uint256,uint256,string)`
- **Visibility**: external
- **Source Range**: 86540:87:25

**Signature:**
```solidity
/// Asserts that two `uint256` values are not equal and includes error message into revert string on failure.
function assertNotEq(uint256 left, uint256 right, string calldata error) external pure;;
```

### assertNotEq(int256,int256)

- **Signature**: `assertNotEq(int256,int256)`
- **Visibility**: external
- **Source Range**: 86689:62:25

**Signature:**
```solidity
/// Asserts that two `int256` values are not equal.
function assertNotEq(int256 left, int256 right) external pure;;
```

### assertNotEq(int256,int256,string)

- **Signature**: `assertNotEq(int256,int256,string)`
- **Visibility**: external
- **Source Range**: 86870:85:25

**Signature:**
```solidity
/// Asserts that two `int256` values are not equal and includes error message into revert string on failure.
function assertNotEq(int256 left, int256 right, string calldata error) external pure;;
```

### assertNotEq(address,address)

- **Signature**: `assertNotEq(address,address)`
- **Visibility**: external
- **Source Range**: 87018:64:25

**Signature:**
```solidity
/// Asserts that two `address` values are not equal.
function assertNotEq(address left, address right) external pure;;
```

### assertNotEq(address,address,string)

- **Signature**: `assertNotEq(address,address,string)`
- **Visibility**: external
- **Source Range**: 87202:87:25

**Signature:**
```solidity
/// Asserts that two `address` values are not equal and includes error message into revert string on failure.
function assertNotEq(address left, address right, string calldata error) external pure;;
```

### assertNotEq(bytes32,bytes32)

- **Signature**: `assertNotEq(bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 87352:64:25

**Signature:**
```solidity
/// Asserts that two `bytes32` values are not equal.
function assertNotEq(bytes32 left, bytes32 right) external pure;;
```

### assertNotEq(bytes32,bytes32,string)

- **Signature**: `assertNotEq(bytes32,bytes32,string)`
- **Visibility**: external
- **Source Range**: 87536:87:25

**Signature:**
```solidity
/// Asserts that two `bytes32` values are not equal and includes error message into revert string on failure.
function assertNotEq(bytes32 left, bytes32 right, string calldata error) external pure;;
```

### assertTrue(bool)

- **Signature**: `assertTrue(bool)`
- **Visibility**: external
- **Source Range**: 87679:50:25

**Signature:**
```solidity
/// Asserts that the given condition is true.
function assertTrue(bool condition) external pure;;
```

### assertTrue(bool,string)

- **Signature**: `assertTrue(bool,string)`
- **Visibility**: external
- **Source Range**: 87842:73:25

**Signature:**
```solidity
/// Asserts that the given condition is true and includes error message into revert string on failure.
function assertTrue(bool condition, string calldata error) external pure;;
```

### assume(bool)

- **Signature**: `assume(bool)`
- **Visibility**: external
- **Source Range**: 88010:46:25

**Signature:**
```solidity
/// If the condition is false, discard this run's fuzz inputs and generate new ones.
function assume(bool condition) external pure;;
```

### assumeNoRevert()

- **Signature**: `assumeNoRevert()`
- **Visibility**: external
- **Source Range**: 88146:40:25

**Signature:**
```solidity
/// Discard this run's fuzz inputs and generate new ones if next call reverted.
function assumeNoRevert() external pure;;
```

### assumeNoRevert(struct VmSafe.PotentialRevert)

- **Signature**: `assumeNoRevert(struct VmSafe.PotentialRevert)`
- **Visibility**: external
- **Source Range**: 88312:80:25

**Signature:**
```solidity
/// Discard this run's fuzz inputs and generate new ones if next call reverts with the potential revert parameters.
function assumeNoRevert(PotentialRevert calldata potentialRevert) external pure;;
```

### assumeNoRevert(struct VmSafe.PotentialRevert[])

- **Signature**: `assumeNoRevert(struct VmSafe.PotentialRevert[])`
- **Visibility**: external
- **Source Range**: 88529:83:25

**Signature:**
```solidity
/// Discard this run's fuzz inputs and generate new ones if next call reverts with the any of the potential revert parameters.
function assumeNoRevert(PotentialRevert[] calldata potentialReverts) external pure;;
```

### breakpoint(string)

- **Signature**: `breakpoint(string)`
- **Visibility**: external
- **Source Range**: 88674:56:25

**Signature:**
```solidity
/// Writes a breakpoint to jump to in the debugger.
function breakpoint(string calldata char) external pure;;
```

### breakpoint(string,bool)

- **Signature**: `breakpoint(string,bool)`
- **Visibility**: external
- **Source Range**: 88804:68:25

**Signature:**
```solidity
/// Writes a conditional breakpoint to jump to in the debugger.
function breakpoint(string calldata char, bool value) external pure;;
```

### foundryVersionAtLeast(string)

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

### foundryVersionCmp(string)

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

### getChain(string)

- **Signature**: `getChain(string)`
- **Visibility**: external
- **Source Range**: 89949:89:25

**Signature:**
```solidity
/// Returns a Chain struct for specific alias
function getChain(string calldata chainAlias) external view returns (Chain memory chain);;
```

### getChain(uint256)

- **Signature**: `getChain(uint256)`
- **Visibility**: external
- **Source Range**: 90096:78:25

**Signature:**
```solidity
/// Returns a Chain struct for specific chainId
function getChain(uint256 chainId) external view returns (Chain memory chain);;
```

### getFoundryVersion()

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

### rpcUrl(string)

- **Signature**: `rpcUrl(string)`
- **Visibility**: external
- **Source Range**: 90739:85:25

**Signature:**
```solidity
/// Returns the RPC url for the given alias.
function rpcUrl(string calldata rpcAlias) external view returns (string memory json);;
```

### rpcUrlStructs()

- **Signature**: `rpcUrlStructs()`
- **Visibility**: external
- **Source Range**: 90889:67:25

**Signature:**
```solidity
/// Returns all rpc urls and their aliases as structs.
function rpcUrlStructs() external view returns (Rpc[] memory urls);;
```

### rpcUrls()

- **Signature**: `rpcUrls()`
- **Visibility**: external
- **Source Range**: 91027:67:25

**Signature:**
```solidity
/// Returns all rpc urls and their aliases `[alias, url][]`.
function rpcUrls() external view returns (string[2][] memory urls);;
```

### sleep(uint256)

- **Signature**: `sleep(uint256)`
- **Visibility**: external
- **Source Range**: 91175:42:25

**Signature:**
```solidity
/// Suspends execution of the main thread for `duration` milliseconds.
function sleep(uint256 duration) external;;
```

### keyExistsToml(string,string)

- **Signature**: `keyExistsToml(string,string)`
- **Visibility**: external
- **Source Range**: 91302:95:25

**Signature:**
```solidity
/// Checks if `key` exists in a TOML table.
function keyExistsToml(string calldata toml, string calldata key) external view returns (bool);;
```

### parseTomlAddress(string,string)

- **Signature**: `parseTomlAddress(string,string)`
- **Visibility**: external
- **Source Range**: 91478:101:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `address`.
function parseTomlAddress(string calldata toml, string calldata key) external pure returns (address);;
```

### parseTomlAddressArray(string,string)

- **Signature**: `parseTomlAddressArray(string,string)`
- **Visibility**: external
- **Source Range**: 91662:139:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `address[]`.
function parseTomlAddressArray(string calldata toml, string calldata key) external pure returns (address[] memory);;
```

### parseTomlBool(string,string)

- **Signature**: `parseTomlBool(string,string)`
- **Visibility**: external
- **Source Range**: 91879:95:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bool`.
function parseTomlBool(string calldata toml, string calldata key) external pure returns (bool);;
```

### parseTomlBoolArray(string,string)

- **Signature**: `parseTomlBoolArray(string,string)`
- **Visibility**: external
- **Source Range**: 92054:109:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bool[]`.
function parseTomlBoolArray(string calldata toml, string calldata key) external pure returns (bool[] memory);;
```

### parseTomlBytes(string,string)

- **Signature**: `parseTomlBytes(string,string)`
- **Visibility**: external
- **Source Range**: 92242:104:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bytes`.
function parseTomlBytes(string calldata toml, string calldata key) external pure returns (bytes memory);;
```

### parseTomlBytes32(string,string)

- **Signature**: `parseTomlBytes32(string,string)`
- **Visibility**: external
- **Source Range**: 92427:101:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bytes32`.
function parseTomlBytes32(string calldata toml, string calldata key) external pure returns (bytes32);;
```

### parseTomlBytes32Array(string,string)

- **Signature**: `parseTomlBytes32Array(string,string)`
- **Visibility**: external
- **Source Range**: 92611:139:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bytes32[]`.
function parseTomlBytes32Array(string calldata toml, string calldata key) external pure returns (bytes32[] memory);;
```

### parseTomlBytesArray(string,string)

- **Signature**: `parseTomlBytesArray(string,string)`
- **Visibility**: external
- **Source Range**: 92831:111:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `bytes[]`.
function parseTomlBytesArray(string calldata toml, string calldata key) external pure returns (bytes[] memory);;
```

### parseTomlInt(string,string)

- **Signature**: `parseTomlInt(string,string)`
- **Visibility**: external
- **Source Range**: 93022:96:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `int256`.
function parseTomlInt(string calldata toml, string calldata key) external pure returns (int256);;
```

### parseTomlIntArray(string,string)

- **Signature**: `parseTomlIntArray(string,string)`
- **Visibility**: external
- **Source Range**: 93200:110:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `int256[]`.
function parseTomlIntArray(string calldata toml, string calldata key) external pure returns (int256[] memory);;
```

### parseTomlKeys(string,string)

- **Signature**: `parseTomlKeys(string,string)`
- **Visibility**: external
- **Source Range**: 93374:111:25

**Signature:**
```solidity
/// Returns an array of all the keys in a TOML table.
function parseTomlKeys(string calldata toml, string calldata key) external pure returns (string[] memory keys);;
```

### parseTomlString(string,string)

- **Signature**: `parseTomlString(string,string)`
- **Visibility**: external
- **Source Range**: 93565:106:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `string`.
function parseTomlString(string calldata toml, string calldata key) external pure returns (string memory);;
```

### parseTomlStringArray(string,string)

- **Signature**: `parseTomlStringArray(string,string)`
- **Visibility**: external
- **Source Range**: 93753:113:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `string[]`.
function parseTomlStringArray(string calldata toml, string calldata key) external pure returns (string[] memory);;
```

### parseTomlTypeArray(string,string,string)

- **Signature**: `parseTomlTypeArray(string,string,string)`
- **Visibility**: external
- **Source Range**: 93983:165:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to type array corresponding to `typeDescription`.
function parseTomlTypeArray(string calldata toml, string calldata key, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseTomlType(string,string)

- **Signature**: `parseTomlType(string,string)`
- **Visibility**: external
- **Source Range**: 94250:139:25

**Signature:**
```solidity
/// Parses a string of TOML data and coerces it to type corresponding to `typeDescription`.
function parseTomlType(string calldata toml, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseTomlType(string,string,string)

- **Signature**: `parseTomlType(string,string,string)`
- **Visibility**: external
- **Source Range**: 94500:160:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to type corresponding to `typeDescription`.
function parseTomlType(string calldata toml, string calldata key, string calldata typeDescription) external pure returns (bytes memory);;
```

### parseTomlUint(string,string)

- **Signature**: `parseTomlUint(string,string)`
- **Visibility**: external
- **Source Range**: 94741:98:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `uint256`.
function parseTomlUint(string calldata toml, string calldata key) external pure returns (uint256);;
```

### parseTomlUintArray(string,string)

- **Signature**: `parseTomlUintArray(string,string)`
- **Visibility**: external
- **Source Range**: 94922:112:25

**Signature:**
```solidity
/// Parses a string of TOML data at `key` and coerces it to `uint256[]`.
function parseTomlUintArray(string calldata toml, string calldata key) external pure returns (uint256[] memory);;
```

### parseToml(string)

- **Signature**: `parseToml(string)`
- **Visibility**: external
- **Source Range**: 95074:93:25

**Signature:**
```solidity
/// ABI-encodes a TOML table.
function parseToml(string calldata toml) external pure returns (bytes memory abiEncodedData);;
```

### parseToml(string,string)

- **Signature**: `parseToml(string,string)`
- **Visibility**: external
- **Source Range**: 95216:114:25

**Signature:**
```solidity
/// ABI-encodes a TOML table at `key`.
function parseToml(string calldata toml, string calldata key) external pure returns (bytes memory abiEncodedData);;
```

### writeToml(string,string)

- **Signature**: `writeToml(string,string)`
- **Visibility**: external
- **Source Range**: 95423:72:25

**Signature:**
```solidity
/// Takes serialized JSON, converts to TOML and write a serialized TOML to a file.
function writeToml(string calldata json, string calldata path) external;;
```

### writeToml(string,string,string)

- **Signature**: `writeToml(string,string,string)`
- **Visibility**: external
- **Source Range**: 95764:98:25

**Signature:**
```solidity
/// Takes serialized JSON, converts to TOML and write a serialized TOML table to an **existing** TOML file, replacing a value with key = <value_key.>
///  This is useful to replace a specific value of a TOML file, without having to parse the entire thing.
function writeToml(string calldata json, string calldata path, string calldata valueKey) external;;
```

### computeCreate2Address(bytes32,bytes32,address)

- **Signature**: `computeCreate2Address(bytes32,bytes32,address)`
- **Visibility**: external
- **Source Range**: 96001:141:25

**Signature:**
```solidity
/// Compute the address of a contract created with CREATE2 using the given CREATE2 deployer.
function computeCreate2Address(bytes32 salt, bytes32 initCodeHash, address deployer) external pure returns (address);;
```

### computeCreate2Address(bytes32,bytes32)

- **Signature**: `computeCreate2Address(bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 96247:99:25

**Signature:**
```solidity
/// Compute the address of a contract created with CREATE2 using the default CREATE2 deployer.
function computeCreate2Address(bytes32 salt, bytes32 initCodeHash) external pure returns (address);;
```

### computeCreateAddress(address,uint256)

- **Signature**: `computeCreateAddress(address,uint256)`
- **Visibility**: external
- **Source Range**: 96451:95:25

**Signature:**
```solidity
/// Compute the address a contract will be deployed at for a given deployer address and nonce.
function computeCreateAddress(address deployer, uint256 nonce) external pure returns (address);;
```

### copyStorage(address,address)

- **Signature**: `copyStorage(address,address)`
- **Visibility**: external
- **Source Range**: 96639:56:25

**Signature:**
```solidity
/// Utility cheatcode to copy storage of `from` contract to another `to` contract.
function copyStorage(address from, address to) external;;
```

### eip712HashStruct(string,bytes)

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

### eip712HashStruct(string,string,bytes)

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

### eip712HashType(string)

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

### eip712HashType(string,string)

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

### eip712HashTypedData(string)

- **Signature**: `eip712HashTypedData(string)`
- **Visibility**: external
- **Source Range**: 99274:94:25

**Signature:**
```solidity
/// Generates a ready-to-sign digest of human-readable typed data following the EIP-712 standard.
function eip712HashTypedData(string calldata jsonData) external pure returns (bytes32 digest);;
```

### ensNamehash(string)

- **Signature**: `ensNamehash(string)`
- **Visibility**: external
- **Source Range**: 99424:75:25

**Signature:**
```solidity
/// Returns ENS namehash for provided string.
function ensNamehash(string calldata name) external pure returns (bytes32);;
```

### getLabel(address)

- **Signature**: `getLabel(address)`
- **Visibility**: external
- **Source Range**: 99555:86:25

**Signature:**
```solidity
/// Gets the label for the specified address.
function getLabel(address account) external view returns (string memory currentLabel);;
```

### label(address,string)

- **Signature**: `label(address,string)`
- **Visibility**: external
- **Source Range**: 99689:67:25

**Signature:**
```solidity
/// Labels an address in call traces.
function label(address account, string calldata newLabel) external;;
```

### pauseTracing()

- **Signature**: `pauseTracing()`
- **Visibility**: external
- **Source Range**: 99911:38:25

**Signature:**
```solidity
/// Pauses collection of call traces. Useful in cases when you want to skip tracing of
///  complex calls which are not useful for debugging.
function pauseTracing() external view;;
```

### randomAddress()

- **Signature**: `randomAddress()`
- **Visibility**: external
- **Source Range**: 99991:57:25

**Signature:**
```solidity
/// Returns a random `address`.
function randomAddress() external view returns (address);;
```

### randomBool()

- **Signature**: `randomBool()`
- **Visibility**: external
- **Source Range**: 100087:51:25

**Signature:**
```solidity
/// Returns a random `bool`.
function randomBool() external view returns (bool);;
```

### randomBytes(uint256)

- **Signature**: `randomBytes(uint256)`
- **Visibility**: external
- **Source Range**: 100207:71:25

**Signature:**
```solidity
/// Returns a random byte array value of the given length.
function randomBytes(uint256 len) external view returns (bytes memory);;
```

### randomBytes4()

- **Signature**: `randomBytes4()`
- **Visibility**: external
- **Source Range**: 100344:55:25

**Signature:**
```solidity
/// Returns a random fixed-size byte array of length 4.
function randomBytes4() external view returns (bytes4);;
```

### randomBytes8()

- **Signature**: `randomBytes8()`
- **Visibility**: external
- **Source Range**: 100465:55:25

**Signature:**
```solidity
/// Returns a random fixed-size byte array of length 8.
function randomBytes8() external view returns (bytes8);;
```

### randomInt()

- **Signature**: `randomInt()`
- **Visibility**: external
- **Source Range**: 100567:52:25

**Signature:**
```solidity
/// Returns a random `int256` value.
function randomInt() external view returns (int256);;
```

### randomInt(uint256)

- **Signature**: `randomInt(uint256)`
- **Visibility**: external
- **Source Range**: 100680:64:25

**Signature:**
```solidity
/// Returns a random `int256` value of given bits.
function randomInt(uint256 bits) external view returns (int256);;
```

### randomUint()

- **Signature**: `randomUint()`
- **Visibility**: external
- **Source Range**: 100790:54:25

**Signature:**
```solidity
/// Returns a random uint256 value.
function randomUint() external view returns (uint256);;
```

### randomUint(uint256,uint256)

- **Signature**: `randomUint(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 100928:78:25

**Signature:**
```solidity
/// Returns random uint256 value between the provided range (=min..=max).
function randomUint(uint256 min, uint256 max) external view returns (uint256);;
```

### randomUint(uint256)

- **Signature**: `randomUint(uint256)`
- **Visibility**: external
- **Source Range**: 101068:66:25

**Signature:**
```solidity
/// Returns a random `uint256` value of given bits.
function randomUint(uint256 bits) external view returns (uint256);;
```

### resumeTracing()

- **Signature**: `resumeTracing()`
- **Visibility**: external
- **Source Range**: 101184:39:25

**Signature:**
```solidity
/// Unpauses collection of call traces.
function resumeTracing() external view;;
```

### setArbitraryStorage(address)

- **Signature**: `setArbitraryStorage(address)`
- **Visibility**: external
- **Source Range**: 101306:54:25

**Signature:**
```solidity
/// Utility cheatcode to set arbitrary storage for given target address.
function setArbitraryStorage(address target) external;;
```

### setArbitraryStorage(address,bool)

- **Signature**: `setArbitraryStorage(address,bool)`
- **Visibility**: external
- **Source Range**: 101513:70:25

**Signature:**
```solidity
/// Utility cheatcode to set arbitrary storage for given target address and overwrite
///  any storage slots that have been previously set.
function setArbitraryStorage(address target, bool overwrite) external;;
```

### setSeed(uint256)

- **Signature**: `setSeed(uint256)`
- **Visibility**: external
- **Source Range**: 101611:40:25

**Signature:**
```solidity
/// Set RNG seed.
function setSeed(uint256 seed) external;;
```

### shuffle(uint256[])

- **Signature**: `shuffle(uint256[])`
- **Visibility**: external
- **Source Range**: 101693:79:25

**Signature:**
```solidity
/// Randomly shuffles an array.
function shuffle(uint256[] calldata array) external returns (uint256[] memory);;
```

### sort(uint256[])

- **Signature**: `sort(uint256[])`
- **Visibility**: external
- **Source Range**: 101821:76:25

**Signature:**
```solidity
/// Sorts an array in ascending order.
function sort(uint256[] calldata array) external returns (uint256[] memory);;
```

### toBase64URL(bytes)

- **Signature**: `toBase64URL(bytes)`
- **Visibility**: external
- **Source Range**: 101958:80:25

**Signature:**
```solidity
/// Encodes a `bytes` value to a base64url string.
function toBase64URL(bytes calldata data) external pure returns (string memory);;
```

### toBase64URL(string)

- **Signature**: `toBase64URL(string)`
- **Visibility**: external
- **Source Range**: 102100:81:25

**Signature:**
```solidity
/// Encodes a `string` value to a base64url string.
function toBase64URL(string calldata data) external pure returns (string memory);;
```

### toBase64(bytes)

- **Signature**: `toBase64(bytes)`
- **Visibility**: external
- **Source Range**: 102239:77:25

**Signature:**
```solidity
/// Encodes a `bytes` value to a base64 string.
function toBase64(bytes calldata data) external pure returns (string memory);;
```

### toBase64(string)

- **Signature**: `toBase64(string)`
- **Visibility**: external
- **Source Range**: 102375:78:25

**Signature:**
```solidity
/// Encodes a `string` value to a base64 string.
function toBase64(string calldata data) external pure returns (string memory);;
```
