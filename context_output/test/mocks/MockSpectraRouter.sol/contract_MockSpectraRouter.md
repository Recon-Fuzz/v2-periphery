# Contract: MockSpectraRouter

## Metadata

- **Name**: MockSpectraRouter
- **Type**: Contract
- **Path**: test/mocks/MockSpectraRouter.sol

## State Variables

### ptToken

```solidity
address public immutable ptToken
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 214:65:601
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address _ptToken);
```

### execute(bytes,bytes[])

- **Signature**: `execute(bytes,bytes[])`
- **Visibility**: external
- **Source Range**: 285:126:601
- **Details**: [function_execute_bytes_bytes[].md](./function_execute_bytes_bytes[].md)

**Signature:**
```solidity
function execute(bytes calldata, bytes[] calldata) external payable;
```

### execute(bytes,bytes[],uint256)

- **Signature**: `execute(bytes,bytes[],uint256)`
- **Visibility**: external
- **Source Range**: 417:135:601
- **Details**: [function_execute_bytes_bytes[]_uint256.md](./function_execute_bytes_bytes[]_uint256.md)

**Signature:**
```solidity
function execute(bytes calldata, bytes[] calldata, uint256) external payable;
```
