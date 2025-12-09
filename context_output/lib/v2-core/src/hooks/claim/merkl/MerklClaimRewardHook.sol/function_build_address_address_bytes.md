# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/claim/merkl/MerklClaimRewardHook.sol/contract_MerklClaimRewardHook.md]

## Metadata

- **Contract**: MerklClaimRewardHook
- **Signature**: `build(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 5451:1084:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @dev Standard build pattern - MUST include preExecute first, postExecute last
///  @inheritdoc ISuperHook
function build(address prevHook, address account, bytes calldata hookData) virtual external view returns (Execution[] memory executions) {
    Execution[] memory hookExecutions = _buildHookExecutions(prevHook, account, hookData);
    executions = new Execution[](hookExecutions.length + 2);
    executions[0] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.preExecute, (prevHook, account, hookData))});
    for (uint256 i = 0; i < hookExecutions.length; i++) {
        executions[i + 1] = hookExecutions[i];
    }
    executions[executions.length - 1] = Execution({target: address(this), value: 0, callData: abi.encodeCall(this.postExecute, (prevHook, account, hookData))});
}
```

## Related Implementations

### _buildHookExecutions(address,address,bytes)

- **Kind**: internal
- **Source**: 2315:1860:373
- **Link**: `lib/v2-core/src/hooks/claim/merkl/MerklClaimRewardHook.sol:MerklClaimRewardHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    ClaimParams memory params;
    (address feeReceiver, uint256 feePercent) = _decodeFeeParams(data);
    if (feePercent > MAX_FEE_PERCENT) revert FEE_NOT_VALID();
    if ((feePercent > 0) && (feeReceiver == address(0))) revert ADDRESS_NOT_VALID();
    address[] memory users = _setUsersArray(account, data);
    params.users = users;
    (params.tokens, params.amounts, params.proofs) = _decodeClaimParams(data);
    if (feePercent > 0) {
        uint256 len = params.tokens.length;
        executions = new Execution[](1 + len);
        for (uint256 i; i < len; ++i) {
            uint256 fee;
            uint208 amount;
            (amount, , ) = IDistributor(DISTRIBUTOR).claimed(params.users[i], params.tokens[i]);
            fee = ((params.amounts[i] - amount) * feePercent) / BPS;
            executions[i + 1] = Execution({target: params.tokens[i], value: 0, callData: abi.encodeCall(IERC20.transfer, (feeReceiver, fee))});
        }
    } else {
        executions = new Execution[](1);
    }
    executions[0] = Execution({target: DISTRIBUTOR, value: 0, callData: abi.encodeCall(IDistributor.claim, (params.users, params.tokens, params.amounts, params.proofs))});
}
```

### _decodeFeeParams(bytes)

- **Kind**: internal
- **Source**: 5712:220:373
- **Link**: `lib/v2-core/src/hooks/claim/merkl/MerklClaimRewardHook.sol:MerklClaimRewardHook:_decodeFeeParams(bytes)`

```solidity
function _decodeFeeParams(bytes calldata data) internal pure returns (address feeReceiver, uint256 feePercent) {
    feeReceiver = BytesLib.toAddress(data, 0);
    feePercent = BytesLib.toUint256(data, 20);
}
```

### toAddress(bytes,uint256)

- **Kind**: internal
- **Source**: 12130:354:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toAddress(bytes,uint256)`

```solidity
function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
    require(_bytes.length >= (_start + 20), "toAddress_outOfBounds");
    address tempAddress;
    assembly {
        tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }
    return tempAddress;
}
```

### toUint256(bytes,uint256)

- **Kind**: internal
- **Source**: 14359:311:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toUint256(bytes,uint256)`

```solidity
function toUint256(bytes memory _bytes, uint256 _start) internal pure returns (uint256) {
    require(_bytes.length >= (_start + 32), "toUint256_outOfBounds");
    uint256 tempUint;
    assembly {
        tempUint := mload(add(add(_bytes, 0x20), _start))
    }
    return tempUint;
}
```

### _setUsersArray(address,bytes)

- **Kind**: internal
- **Source**: 5938:311:373
- **Link**: `lib/v2-core/src/hooks/claim/merkl/MerklClaimRewardHook.sol:MerklClaimRewardHook:_setUsersArray(address,bytes)`

```solidity
function _setUsersArray(address account, bytes calldata data) internal pure returns (address[] memory users) {
    uint256 arrayLength = BytesLib.toUint256(data, 52);
    users = new address[](arrayLength);
    for (uint256 i; i < arrayLength; i++) {
        users[i] = account;
    }
}
```

### _decodeClaimParams(bytes)

- **Kind**: internal
- **Source**: 5210:496:373
- **Link**: `lib/v2-core/src/hooks/claim/merkl/MerklClaimRewardHook.sol:MerklClaimRewardHook:_decodeClaimParams(bytes)`

```solidity
function _decodeClaimParams(bytes calldata data) internal pure returns (address[] memory tokens, uint256[] memory amounts, bytes32[][] memory proofs) {
    (uint256 cursorAfterAmounts, address[] memory _tokens, uint256[] memory _amounts) = _decodeTokensAndAmounts(data);
    tokens = _tokens;
    amounts = _amounts;
    proofs = _decodeProofs(data, cursorAfterAmounts);
}
```

### _decodeTokensAndAmounts(bytes)

- **Kind**: internal
- **Source**: 6255:902:373
- **Link**: `lib/v2-core/src/hooks/claim/merkl/MerklClaimRewardHook.sol:MerklClaimRewardHook:_decodeTokensAndAmounts(bytes)`

```solidity
function _decodeTokensAndAmounts(bytes calldata data) internal pure returns (uint256 cursor, address[] memory tokens, uint256[] memory amounts) {
    uint256 arrayLength = BytesLib.toUint256(data, 52);
    cursor = 84;
    tokens = new address[](arrayLength);
    for (uint256 i; i < arrayLength; i++) {
        address token = BytesLib.toAddress(data, cursor);
        cursor += 20;
        if (token == address(0)) revert ADDRESS_NOT_VALID();
        tokens[i] = token;
    }
    amounts = new uint256[](arrayLength);
    for (uint256 i; i < arrayLength; i++) {
        uint256 amount = BytesLib.toUint256(data, cursor);
        cursor += 32;
        if (amount == 0) revert AMOUNT_NOT_VALID();
        amounts[i] = amount;
    }
}
```

### _decodeProofs(bytes,uint256)

- **Kind**: internal
- **Source**: 7163:757:373
- **Link**: `lib/v2-core/src/hooks/claim/merkl/MerklClaimRewardHook.sol:MerklClaimRewardHook:_decodeProofs(bytes,uint256)`

```solidity
function _decodeProofs(bytes calldata data, uint256 cursor) internal pure returns (bytes32[][] memory proofs) {
    uint256 arrayLength = BytesLib.toUint256(data, 52);
    proofs = new bytes32[][](arrayLength);
    for (uint256 i; i < arrayLength; ++i) {
        uint256 innerLength = BytesLib.toUint256(data, cursor);
        cursor += 32;
        bytes32[] memory proof = new bytes32[](innerLength);
        for (uint256 j; j < innerLength; ++j) {
            proof[j] = BytesLib.toBytes32(data, cursor);
            cursor += 32;
        }
        proofs[i] = proof;
    }
    if (cursor != data.length) revert INVALID_ENCODING();
}
```

### toBytes32(bytes,uint256)

- **Kind**: internal
- **Source**: 14676:320:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:toBytes32(bytes,uint256)`

```solidity
function toBytes32(bytes memory _bytes, uint256 _start) internal pure returns (bytes32) {
    require(_bytes.length >= (_start + 32), "toBytes32_outOfBounds");
    bytes32 tempBytes32;
    assembly {
        tempBytes32 := mload(add(add(_bytes, 0x20), _start))
    }
    return tempBytes32;
}
```

## State Variable Reads

- **MAX_FEE_PERCENT** (`uint256`)
- **DISTRIBUTOR** (`address`)
- **BPS** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MerklClaimRewardHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MerklClaimRewardHook._decodeFeeParams(bytes) (NodeID: 2)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │ │   💬 Args: [data, 0]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 4)
    │     💬 Args: [data, 20]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MerklClaimRewardHook._setUsersArray(address,bytes) (NodeID: 5)
    │   💬 Args: [account, data]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 6)
    │     💬 Args: [data, 52]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MerklClaimRewardHook._decodeClaimParams(bytes) (NodeID: 7)
        💬 Args: [data]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: MerklClaimRewardHook._decodeTokensAndAmounts(bytes) (NodeID: 8)
      │   💬 Args: [data]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 9)
      │ │   💬 Args: [data, 52]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 10)
      │ │   💬 Args: [data, cursor]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 11)
      │     💬 Args: [data, cursor]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: MerklClaimRewardHook._decodeProofs(bytes,uint256) (NodeID: 12)
          💬 Args: [data, cursorAfterAmounts]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 13)
        │   💬 Args: [data, 52]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 14)
        │   💬 Args: [data, cursor]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: BytesLib.toBytes32(bytes,uint256) (NodeID: 15)
            💬 Args: [data, cursor]
            👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Standard build pattern - MUST include preExecute first, postExecute last
 @inheritdoc ISuperHook

### Interface Documentation

@notice Builds the execution array for the hook operation
 @dev This is the core method where hooks define their on-chain interactions
      The returned executions are a sequence of contract calls to perform
      No state changes should occur in this method
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account to perform executions for (usually an ERC7579 account)
 @param data The hook-specific parameters and configuration data
 @return executions Array of Execution structs defining calls to make
