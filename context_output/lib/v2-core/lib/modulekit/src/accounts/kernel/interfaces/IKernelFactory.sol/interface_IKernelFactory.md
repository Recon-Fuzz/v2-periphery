# Interface: IKernelFactory

## Metadata

- **Name**: IKernelFactory
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/accounts/kernel/interfaces/IKernelFactory.sol

## Public/External Functions

### createAccount(bytes,bytes32)

- **Signature**: `createAccount(bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 97:93:162

**Signature:**
```solidity
function createAccount(bytes calldata data, bytes32 salt) external payable returns (address);;
```

### getAddress(bytes,bytes32)

- **Signature**: `getAddress(bytes,bytes32)`
- **Visibility**: external
- **Source Range**: 195:82:162

**Signature:**
```solidity
function getAddress(bytes calldata data, bytes32 salt) external returns (address);;
```
