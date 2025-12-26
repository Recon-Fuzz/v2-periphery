# Function: getUserOpHash(struct PackedUserOperation)

**Contract**: [lib/v2-core/lib/modulekit/src/deployment/predeploy/EntryPoint.sol/contract_EntryPointSimulationsPatch.md]

## Metadata

- **Contract**: EntryPointSimulationsPatch
- **Signature**: `getUserOpHash(struct PackedUserOperation)`
- **Visibility**: public
- **Source Range**: 12662:180:89
- **Inherited From**: EntryPoint

## Implementation

```solidity
/// @inheritdoc IEntryPoint
function getUserOpHash(PackedUserOperation calldata userOp) public view returns (bytes32) {
    return keccak256(abi.encode(userOp.hash(), address(this), block.chainid));
}
```

## Related Implementations

### hash(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 4848:146:96
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/UserOperationLib.sol:UserOperationLib:hash(struct PackedUserOperation)`

```solidity
///  Hash the user operation data.
///  @param userOp - The user operation data.
function hash(PackedUserOperation calldata userOp) internal pure returns (bytes32) {
    return keccak256(encode(userOp));
}
```

### encode(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 1760:769:96
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/UserOperationLib.sol:UserOperationLib:encode(struct PackedUserOperation)`

```solidity
///  Pack the user operation data into bytes for hashing.
///  @param userOp - The user operation data.
function encode(PackedUserOperation calldata userOp) internal pure returns (bytes memory ret) {
    address sender = getSender(userOp);
    uint256 nonce = userOp.nonce;
    bytes32 hashInitCode = calldataKeccak(userOp.initCode);
    bytes32 hashCallData = calldataKeccak(userOp.callData);
    bytes32 accountGasLimits = userOp.accountGasLimits;
    uint256 preVerificationGas = userOp.preVerificationGas;
    bytes32 gasFees = userOp.gasFees;
    bytes32 hashPaymasterAndData = calldataKeccak(userOp.paymasterAndData);
    return abi.encode(sender, nonce, hashInitCode, hashCallData, accountGasLimits, preVerificationGas, gasFees, hashPaymasterAndData);
}
```

### getSender(struct PackedUserOperation)

- **Kind**: internal
- **Source**: 606:323:96
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/UserOperationLib.sol:UserOperationLib:getSender(struct PackedUserOperation)`

```solidity
///  Get sender from user operation data.
///  @param userOp - The user operation data.
function getSender(PackedUserOperation calldata userOp) internal pure returns (address) {
    address data;
    assembly {
        data := calldataload(userOp)
    }
    return address(uint160(data));
}
```

### calldataKeccak(bytes)

- **Kind**: free-function
- **Source**: 2879:281:92
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@ERC4337/account-abstraction/contracts/core/Helpers.sol:calldataKeccak(bytes)`

```solidity
///  keccak function over calldata.
///  @dev copy calldata into memory, do keccak and drop allocated memory. Strangely, this is more efficient than letting solidity do it.
function calldataKeccak(bytes calldata data) pure returns (bytes32 ret) {
    assembly ("memory-safe") {
        let mem := mload(0x40)
        let len := data.length
        calldatacopy(mem, data.offset, len)
        ret := keccak256(mem, len)
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: EntryPoint.getUserOpHash(struct PackedUserOperation) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: UserOperationLib.hash(struct PackedUserOperation) (NodeID: 1)
      💬 Args: [userOp]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: UserOperationLib.encode(struct PackedUserOperation) (NodeID: 2)
        💬 Args: [userOp]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: UserOperationLib.getSender(struct PackedUserOperation) (NodeID: 3)
      │   💬 Args: [userOp]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Unknown.calldataKeccak(bytes) (NodeID: 4)
      │   💬 Args: [userOp.initCode]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Unknown.calldataKeccak(bytes) (NodeID: 5)
      │   💬 Args: [userOp.callData]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Unknown.calldataKeccak(bytes) (NodeID: 6)
          💬 Args: [userOp.paymasterAndData]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IEntryPoint

### Interface Documentation

 Generate a request Id - unique identifier for this request.
 The request ID is a hash over the content of the userOp (except the signature), the entrypoint and the chainid.
 @param userOp - The user operation to generate the request ID for.
 @return hash the hash of this UserOperation
