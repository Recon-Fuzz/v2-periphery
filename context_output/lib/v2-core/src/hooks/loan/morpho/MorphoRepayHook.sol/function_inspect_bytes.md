# Function: inspect(bytes)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol/contract_MorphoRepayHook.md]

## Metadata

- **Contract**: MorphoRepayHook
- **Signature**: `inspect(bytes)`
- **Visibility**: external
- **Source Range**: 5138:455:378

## Implementation

```solidity
/// @inheritdoc ISuperHookInspector
function inspect(bytes calldata data) override external pure returns (bytes memory) {
    BuildHookLocalVars memory vars = _decodeHookData(data);
    MarketParams memory marketParams = _generateMarketParams(vars.loanToken, vars.collateralToken, vars.oracle, vars.irm, vars.lltv);
    return abi.encodePacked(marketParams.loanToken, marketParams.collateralToken, marketParams.oracle, marketParams.irm);
}
```

## Related Implementations

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

- **AMOUNT_POSITION** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoRepayHook.inspect(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: BaseMorphoLoanHook._decodeHookData(bytes) (NodeID: 1)
  │   💬 Args: [data]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 2)
  │ │   💬 Args: [data, 0]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
  │ │   💬 Args: [data, 20]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
  │ │   💬 Args: [data, 40]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 5)
  │ │   💬 Args: [data, 60]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseLoanHook._decodeAmount(bytes) (NodeID: 6)
  │ │   💬 Args: [data]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 7)
  │ │     💬 Args: [data, AMOUNT_POSITION]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 8)
  │ │   💬 Args: [data, 112]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 9)
  │ │   💬 Args: [data, 144]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 10)
  │     💬 Args: [data, 145]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BaseMorphoLoanHook._generateMarketParams(address,address,address,address,uint256) (NodeID: 11)
      💬 Args: [vars.loanToken, vars.collateralToken, vars.oracle, vars.irm, vars.lltv]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperHookInspector

### Interface Documentation

@notice Inspect the hook
 @param data The hook data to inspect
 @return argsEncoded The arguments of the hook encoded
