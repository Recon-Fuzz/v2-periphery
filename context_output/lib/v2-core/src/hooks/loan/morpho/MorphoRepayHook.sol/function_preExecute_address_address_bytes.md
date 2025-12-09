# Function: preExecute(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol/contract_MorphoRepayHook.md]

## Metadata

- **Contract**: MorphoRepayHook
- **Signature**: `preExecute(address,address,bytes)`
- **Visibility**: external
- **Source Range**: 6572:390:364
- **Inherited From**: BaseHook

## Implementation

```solidity
/// @inheritdoc ISuperHook
function preExecute(address prevHook, address account, bytes calldata data) external {
    if (msg.sender != account) revert UNAUTHORIZED_CALLER();
    uint256 context = _getCurrentExecutionContext(account);
    if (_getPreExecuteMutex(context)) revert PRE_EXECUTE_ALREADY_CALLED();
    _setPreExecuteMutex(context, true);
    _preExecute(prevHook, account, data);
}
```

## Related Implementations

### _getCurrentExecutionContext(address)

- **Kind**: internal
- **Source**: 13205:216:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_getCurrentExecutionContext(address)`

```solidity
function _getCurrentExecutionContext(address caller) private view returns (uint256 context) {
    bytes32 key = _makeAccountContextKey(caller);
    assembly {
        context := tload(key)
    }
}
```

### _makeAccountContextKey(address)

- **Kind**: internal
- **Source**: 12565:165:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_makeAccountContextKey(address)`

```solidity
function _makeAccountContextKey(address account) private pure returns (bytes32) {
    return keccak256(abi.encodePacked(ACCOUNT_CONTEXT_STORAGE, account));
}
```

### _getPreExecuteMutex(uint256)

- **Kind**: internal
- **Source**: 14077:215:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_getPreExecuteMutex(uint256)`

```solidity
function _getPreExecuteMutex(uint256 context) private view returns (bool value) {
    bytes32 key = _makeKey(context, PRE_EXECUTE_MUTEX_OFFSET);
    assembly {
        value := tload(key)
    }
}
```

### _makeKey(uint256,uint256)

- **Kind**: internal
- **Source**: 13427:174:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_makeKey(uint256,uint256)`

```solidity
function _makeKey(uint256 context, uint256 offset) private pure returns (bytes32) {
    return keccak256(abi.encodePacked(HOOK_EXECUTION_STORAGE, context, offset));
}
```

### _setPreExecuteMutex(uint256,bool)

- **Kind**: internal
- **Source**: 14298:200:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_setPreExecuteMutex(uint256,bool)`

```solidity
function _setPreExecuteMutex(uint256 context, bool value) private {
    bytes32 key = _makeKey(context, PRE_EXECUTE_MUTEX_OFFSET);
    assembly {
        tstore(key, value)
    }
}
```

### _preExecute(address,address,bytes)

- **Kind**: internal
- **Source**: 6519:353:378
- **Link**: `lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol:MorphoRepayHook:_preExecute(address,address,bytes)`

```solidity
function _preExecute(address, address, bytes calldata data) override internal {
    BuildHookLocalVars memory vars = _decodeHookData(data);
    MarketParams memory marketParams = _generateMarketParams(vars.loanToken, vars.collateralToken, vars.oracle, vars.irm, vars.lltv);
    morphoInterface.accrueInterest(marketParams);
}
```

### _decodeHookData(bytes)

- **Kind**: internal
- **Source**: 1529:872:376
- **Link**: `lib/v2-core/src/hooks/loan/morpho/BaseMorphoLoanHook.sol:BaseMorphoLoanHook:_decodeHookData(bytes)`

```solidity
/// @dev Decodes the hook data
///  @param data The hook data
///  @return vars The decoded hook data
function _decodeHookData(bytes memory data) internal pure returns (BuildHookLocalVars memory vars) {
    address loanToken = BytesLib.toAddress(data, 0);
    address collateralToken = BytesLib.toAddress(data, 20);
    address oracle = BytesLib.toAddress(data, 40);
    address irm = BytesLib.toAddress(data, 60);
    uint256 amount = _decodeAmount(data);
    uint256 lltv = BytesLib.toUint256(data, 112);
    bool usePrevHookAmount = _decodeBool(data, 144);
    bool isFullRepayment = _decodeBool(data, 145);
    vars = BuildHookLocalVars({loanToken: loanToken, collateralToken: collateralToken, oracle: oracle, irm: irm, amount: amount, lltv: lltv, usePrevHookAmount: usePrevHookAmount, isFullRepayment: isFullRepayment});
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

### _decodeAmount(bytes)

- **Kind**: internal
- **Source**: 2639:139:375
- **Link**: `lib/v2-core/src/hooks/loan/BaseLoanHook.sol:BaseLoanHook:_decodeAmount(bytes)`

```solidity
function _decodeAmount(bytes memory data) internal pure returns (uint256) {
    return BytesLib.toUint256(data, AMOUNT_POSITION);
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

### _decodeBool(bytes,uint256)

- **Kind**: internal
- **Source**: 11462:126:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:_decodeBool(bytes,uint256)`

```solidity
/// @notice Decodes a boolean value from a byte array at the specified offset
///  @dev Helper function for extracting boolean values from packed data
///       Used when parsing hook-specific data parameters
///  @param data The byte array containing the encoded data
///  @param offset The position in the array to read from
///  @return The decoded boolean value (true if byte is non-zero)
function _decodeBool(bytes memory data, uint256 offset) internal pure returns (bool) {
    return data[offset] != 0;
}
```

### _generateMarketParams(address,address,address,address,uint256)

- **Kind**: internal
- **Source**: 2676:438:376
- **Link**: `lib/v2-core/src/hooks/loan/morpho/BaseMorphoLoanHook.sol:BaseMorphoLoanHook:_generateMarketParams(address,address,address,address,uint256)`

```solidity
/// @dev Generates the market params
///  @param loanToken The loan token
///  @param collateralToken The collateral token
///  @param oracle The oracle
///  @param irm The irm
///  @param lltv The lltv
///  @return marketParams The market params
function _generateMarketParams(address loanToken, address collateralToken, address oracle, address irm, uint256 lltv) internal pure returns (MarketParams memory) {
    return MarketParams({loanToken: loanToken, collateralToken: collateralToken, oracle: oracle, irm: irm, lltv: lltv});
}
```

## State Variable Reads

- **ACCOUNT_CONTEXT_STORAGE** (`bytes32`)
- **PRE_EXECUTE_MUTEX_OFFSET** (`uint256`)
- **HOOK_EXECUTION_STORAGE** (`bytes32`)
- **AMOUNT_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.preExecute(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseHook._getCurrentExecutionContext(address) (NodeID: 1)
  │   💬 Args: [account]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeAccountContextKey(address) (NodeID: 2)
  │     💬 Args: [caller]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: BaseHook._getPreExecuteMutex(uint256) (NodeID: 3)
  │   💬 Args: [context]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 4)
  │     💬 Args: [context, PRE_EXECUTE_MUTEX_OFFSET]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: BaseHook._setPreExecuteMutex(uint256,bool) (NodeID: 5)
  │   💬 Args: [context, true]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: BaseHook._makeKey(uint256,uint256) (NodeID: 6)
  │     💬 Args: [context, PRE_EXECUTE_MUTEX_OFFSET]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: MorphoRepayHook._preExecute(address,address,bytes) (NodeID: 7)
      💬 Args: [prevHook, account, data]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseMorphoLoanHook._decodeHookData(bytes) (NodeID: 8)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 9)
    │ │   💬 Args: [data, 0]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 10)
    │ │   💬 Args: [data, 20]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 11)
    │ │   💬 Args: [data, 40]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 12)
    │ │   💬 Args: [data, 60]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseLoanHook._decodeAmount(bytes) (NodeID: 13)
    │ │   💬 Args: [data]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 14)
    │ │     💬 Args: [data, AMOUNT_POSITION]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 15)
    │ │   💬 Args: [data, 112]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 16)
    │ │   💬 Args: [data, 144]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 17)
    │     💬 Args: [data, 145]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BaseMorphoLoanHook._generateMarketParams(address,address,address,address,uint256) (NodeID: 18)
        💬 Args: [vars.loanToken, vars.collateralToken, vars.oracle, vars.irm, vars.lltv]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHook

### Interface Documentation

@notice Prepares the hook for execution
 @dev Called before the main execution, used to validate inputs and set execution context
      This method may perform state changes to set up the hook's execution state
 @param prevHook The address of the previous hook in the chain, or address(0) if first
 @param account The account to perform operations for
 @param data The hook-specific parameters and configuration data
