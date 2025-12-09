# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/tokens/permit2/BatchTransferFromHook.sol/contract_BatchTransferFromHook.md]

## Metadata

- **Contract**: BatchTransferFromHook
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
- **Source**: 3150:2956:398
- **Link**: `lib/v2-core/src/hooks/tokens/permit2/BatchTransferFromHook.sol:BatchTransferFromHook:_buildHookExecutions(address,address,bytes)`

```solidity
/// @inheritdoc BaseHook
function _buildHookExecutions(address, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    BuildExecutionVars memory vars;
    vars.from = BytesLib.toAddress(data, 0);
    if (vars.from == address(0)) revert ADDRESS_NOT_VALID();
    vars.tokensLength = BytesLib.toUint256(data, 20);
    if (vars.tokensLength == 0) revert INVALID_ARRAY_LENGTH();
    vars.sigDeadline = BytesLib.toUint256(data, 52);
    vars.tokensData = BytesLib.slice(data, 84, 20 * vars.tokensLength);
    vars.amountsData = BytesLib.slice(data, 84 + (20 * vars.tokensLength), 32 * vars.tokensLength);
    vars.noncesData = BytesLib.slice(data, (84 + (20 * vars.tokensLength)) + (32 * vars.tokensLength), 6 * vars.tokensLength);
    vars.signature = BytesLib.slice(data, data.length - 65, 65);
    executions = new Execution[](2);
    vars.details = new IAllowanceTransfer.PermitDetails[](vars.tokensLength);
    for (uint256 i; i < vars.tokensLength; i++) {
        address token = BytesLib.toAddress(vars.tokensData, i * 20);
        uint256 amount = BytesLib.toUint256(vars.amountsData, i * 32);
        bytes memory nonceSlice = BytesLib.slice(vars.noncesData, i * 6, 6);
        uint48 nonce = uint48(uint256(bytes32(nonceSlice)) >> 208);
        if (token == address(0)) revert ADDRESS_NOT_VALID();
        if (amount == 0) revert AMOUNT_NOT_VALID();
        vars.details[i] = IAllowanceTransfer.PermitDetails({token: token, amount: amount.toUint160(), expiration: vars.sigDeadline.toUint48(), nonce: nonce});
    }
    vars.permitBatch = IAllowanceTransfer.PermitBatch({details: vars.details, spender: account, sigDeadline: vars.sigDeadline});
    bytes memory permitCallData = abi.encodeCall(IPermit2Batch.permit, (vars.from, vars.permitBatch, vars.signature));
    executions[0] = Execution({target: PERMIT_2, value: 0, callData: permitCallData});
    vars.transferDetails = _createAllowanceTransferDetails(vars.from, account, vars.tokensData, vars.amountsData, vars.tokensLength);
    bytes memory transferCallData = abi.encodeCall(IPermit2Batch.transferFrom, (vars.transferDetails));
    executions[1] = Execution({target: PERMIT_2, value: 0, callData: transferCallData});
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

### slice(bytes,uint256,uint256)

- **Kind**: internal
- **Source**: 9250:2874:441
- **Link**: `lib/v2-core/src/vendor/BytesLib.sol:BytesLib:slice(bytes,uint256,uint256)`

```solidity
function slice(bytes memory _bytes, uint256 _start, uint256 _length) internal pure returns (bytes memory) {
    unchecked {
        require((_length + 31) >= _length, "slice_overflow");
    }
    require(_bytes.length >= (_start + _length), "slice_outOfBounds");
    bytes memory tempBytes;
    assembly {
        switch iszero(_length)
        case 0 {
            tempBytes := mload(0x40)
            let lengthmod := and(_length, 31)
            let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
            let end := add(mc, _length)
            for {
                let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
            } lt(mc, end) {
                mc := add(mc, 0x20)
                cc := add(cc, 0x20)
            } {
                mstore(mc, mload(cc))
            }
            mstore(tempBytes, _length)
            mstore(0x40, and(add(mc, 31), not(31)))
        }
        default {
            tempBytes := mload(0x40)
            mstore(tempBytes, 0)
            mstore(0x40, add(tempBytes, 0x20))
        }
    }
    return tempBytes;
}
```

### toUint160(uint256)

- **Kind**: internal
- **Source**: 7228:218:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint160(uint256)`

```solidity
///  @dev Returns the downcasted uint160 from uint256, reverting on
///  overflow (when the input is greater than largest uint160).
///  Counterpart to Solidity's `uint160` operator.
///  Requirements:
///  - input must fit into 160 bits
function toUint160(uint256 value) internal pure returns (uint160) {
    if (value > type(uint160).max) {
        revert SafeCastOverflowedUintDowncast(160, value);
    }
    return uint160(value);
}
```

### toUint48(uint256)

- **Kind**: internal
- **Source**: 14296:213:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint48(uint256)`

```solidity
///  @dev Returns the downcasted uint48 from uint256, reverting on
///  overflow (when the input is greater than largest uint48).
///  Counterpart to Solidity's `uint48` operator.
///  Requirements:
///  - input must fit into 48 bits
function toUint48(uint256 value) internal pure returns (uint48) {
    if (value > type(uint48).max) {
        revert SafeCastOverflowedUintDowncast(48, value);
    }
    return uint48(value);
}
```

### _createAllowanceTransferDetails(address,address,bytes,bytes,uint256)

- **Kind**: internal
- **Source**: 6957:742:398
- **Link**: `lib/v2-core/src/hooks/tokens/permit2/BatchTransferFromHook.sol:BatchTransferFromHook:_createAllowanceTransferDetails(address,address,bytes,bytes,uint256)`

```solidity
function _createAllowanceTransferDetails(address from, address account, bytes memory tokensData, bytes memory amountsData, uint256 length) private pure returns (IAllowanceTransfer.AllowanceTransferDetails[] memory details) {
    details = new IAllowanceTransfer.AllowanceTransferDetails[](length);
    for (uint256 i; i < length; ++i) {
        address token = BytesLib.toAddress(tokensData, i * 20);
        uint256 amount = BytesLib.toUint256(amountsData, i * 32);
        details[i] = IAllowanceTransfer.AllowanceTransferDetails({from: from, to: account, token: token, amount: amount.toUint160()});
    }
}
```

## State Variable Reads

- **PERMIT_2** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BatchTransferFromHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
    │   💬 Args: [data, 0]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 3)
    │   💬 Args: [data, 20]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 4)
    │   💬 Args: [data, 52]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 5)
    │   💬 Args: [data, 84, 20 * vars.tokensLength]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 6)
    │   💬 Args: [data, 84 + (20 * vars.tokensLength), 32 * vars.tokensLength]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 7)
    │   💬 Args: [data, (84 + (20 * vars.tokensLength)) + (32 * vars.tokensLength), 6 * vars.tokensLength]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 8)
    │   💬 Args: [data, data.length - 65, 65]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 9)
    │   💬 Args: [vars.tokensData, i * 20]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 10)
    │   💬 Args: [vars.amountsData, i * 32]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BytesLib.slice(bytes,uint256,uint256) (NodeID: 11)
    │   💬 Args: [vars.noncesData, i * 6, 6]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SafeCast.toUint160(uint256) (NodeID: 12)
    │   💬 Args: [amount]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SafeCast.toUint48(uint256) (NodeID: 13)
    │   💬 Args: [vars.sigDeadline]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BatchTransferFromHook._createAllowanceTransferDetails(address,address,bytes,bytes,uint256) (NodeID: 14)
        💬 Args: [vars.from, account, vars.tokensData, vars.amountsData, vars.tokensLength]
        👁️  Def: private
      ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 15)
      │   💬 Args: [tokensData, i * 20]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 16)
      │   💬 Args: [amountsData, i * 32]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SafeCast.toUint160(uint256) (NodeID: 17)
          💬 Args: [amount]
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
