# Interface: IAccountFactory

## Metadata

- **Name**: IAccountFactory
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/factory/interface/IAccountFactory.sol

## Structs

### ModuleInitData

```solidity
struct ModuleInitData {
    address module;
    bytes data;
}
```

## Public/External Functions

### init()

- **Signature**: `init()`
- **Visibility**: external
- **Source Range**: 177:25:155

**Signature:**
```solidity
function init() external;;
```

### createAccount(bytes32,bytes)

- **Signature**: `createAccount(bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 208:133:155

**Signature:**
```solidity
function createAccount(bytes32 salt, bytes memory initCode) external returns (address account);;
```

### getAddress(bytes32,bytes)

- **Signature**: `getAddress(bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 347:84:155

**Signature:**
```solidity
function getAddress(bytes32 salt, bytes memory initCode) external returns (address);;
```

### getInitData(address,bytes)

- **Signature**: `getInitData(address,bytes)`
- **Visibility**: external
- **Source Range**: 437:138:155

**Signature:**
```solidity
function getInitData(address validator, bytes memory initData) external returns (bytes memory init);;
```

### getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[])

- **Signature**: `getInitData(struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData[],struct IAccountFactory.ModuleInitData,struct IAccountFactory.ModuleInitData[])`
- **Visibility**: external
- **Source Range**: 581:311:155

**Signature:**
```solidity
function getInitData(IAccountFactory.ModuleInitData[] memory validators, IAccountFactory.ModuleInitData[] memory executors, IAccountFactory.ModuleInitData memory hook, IAccountFactory.ModuleInitData[] memory fallbacks) external returns (bytes memory _init);;
```
