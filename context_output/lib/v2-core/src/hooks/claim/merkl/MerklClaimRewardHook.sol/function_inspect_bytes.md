# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/claim/merkl/MerklClaimRewardHook.sol/contract_MerklClaimRewardHook.md]

## Metadata

- **Contract**: MerklClaimRewardHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 4221:541:373

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory addressData) {
    (address feeReceiver, ) = _decodeFeeParams(data);
    addressData = bytes.concat(addressData, bytes20(feeReceiver));
    (address[] memory tokens, , ) = _decodeClaimParams(data);
    uint256 length = tokens.length;
    for (uint256 i; i < length; i++) {
        addressData = bytes.concat(addressData, bytes20(tokens[i]));
    }
}
```

## Related Implementations

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MerklClaimRewardHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MerklClaimRewardHook._decodeFeeParams(bytes) (NodeID: 1)
  │   💬 Args: [data]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
  │ │   💬 Args: [data, 0]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 3)
  │     💬 Args: [data, 20]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MerklClaimRewardHook._decodeClaimParams(bytes) (NodeID: 4)
      💬 Args: [data]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MerklClaimRewardHook._decodeTokensAndAmounts(bytes) (NodeID: 5)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 6)
    │ │   💬 Args: [data, 52]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 7)
    │ │   💬 Args: [data, cursor]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 8)
    │     💬 Args: [data, cursor]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MerklClaimRewardHook._decodeProofs(bytes,uint256) (NodeID: 9)
        💬 Args: [data, cursorAfterAmounts]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 10)
      │   💬 Args: [data, 52]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 11)
      │   💬 Args: [data, cursor]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: BytesLib.toBytes32(bytes,uint256) (NodeID: 12)
          💬 Args: [data, cursor]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
