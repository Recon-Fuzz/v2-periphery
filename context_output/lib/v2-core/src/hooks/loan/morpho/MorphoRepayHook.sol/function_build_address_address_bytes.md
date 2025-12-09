# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol/contract_MorphoRepayHook.md]

## Metadata

- **Contract**: MorphoRepayHook
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
- **Source**: 2719:2373:378
- **Link**: `lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol:MorphoRepayHook:_buildHookExecutions(address,address,bytes)`

```solidity
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    BuildHookLocalVars memory vars = _decodeHookData(data);
    if ((vars.loanToken == address(0)) || (vars.collateralToken == address(0))) revert ADDRESS_NOT_VALID();
    MarketParams memory marketParams = _generateMarketParams(vars.loanToken, vars.collateralToken, vars.oracle, vars.irm, vars.lltv);
    Id id = marketParams.id();
    executions = new Execution[](4);
    executions[0] = Execution({target: vars.loanToken, value: 0, callData: abi.encodeCall(IERC20.approve, (morpho, 0))});
    if (vars.isFullRepayment) {
        uint128 borrowBalance = deriveShareBalance(id, account);
        uint256 shareBalance = uint256(borrowBalance);
        uint256 assetsToPay = sharesToAssets(marketParams, account);
        executions[1] = Execution({target: vars.loanToken, value: 0, callData: abi.encodeCall(IERC20.approve, (morpho, assetsToPay))});
        executions[2] = Execution({target: morpho, value: 0, callData: abi.encodeCall(IMorphoBase.repay, (marketParams, 0, shareBalance, account, ""))});
    } else {
        if (vars.usePrevHookAmount) {
            vars.amount = ISuperHookResult(prevHook).getOutAmount(account);
        }
        if (vars.amount == 0) revert AMOUNT_NOT_VALID();
        executions[1] = Execution({target: vars.loanToken, value: 0, callData: abi.encodeCall(IERC20.approve, (morpho, vars.amount))});
        executions[2] = Execution({target: morpho, value: 0, callData: abi.encodeCall(IMorphoBase.repay, (marketParams, vars.amount, 0, account, ""))});
    }
    executions[3] = Execution({target: vars.loanToken, value: 0, callData: abi.encodeCall(IERC20.approve, (morpho, 0))});
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

### id(struct MarketParams)

- **Kind**: internal
- **Source**: 588:222:457
- **Link**: `lib/v2-core/src/vendor/morpho/MarketParamsLib.sol:MarketParamsLib:id(struct MarketParams)`

```solidity
/// @notice Returns the id of the market `marketParams`.
function id(MarketParams memory marketParams) internal pure returns (Id marketParamsId) {
    assembly ("memory-safe") {
        marketParamsId := keccak256(marketParams, MARKET_PARAMS_BYTES_LENGTH)
    }
}
```

### deriveShareBalance(Id,address)

- **Kind**: internal
- **Source**: 5780:172:378
- **Link**: `lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol:MorphoRepayHook:deriveShareBalance(Id,address)`

```solidity
function deriveShareBalance(Id id, address account) public view returns (uint128 borrowShares) {
    (, borrowShares, ) = morphoStaticTyping.position(id, account);
}
```

### sharesToAssets(struct MarketParams,address)

- **Kind**: internal
- **Source**: 5958:372:378
- **Link**: `lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol:MorphoRepayHook:sharesToAssets(struct MarketParams,address)`

```solidity
function sharesToAssets(MarketParams memory marketParams, address account) public view returns (uint256 assets) {
    Id id = marketParams.id();
    uint256 shareBalance = deriveShareBalance(id, account);
    Market memory market = morphoInterface.market(id);
    assets = shareBalance.toAssetsUp(market.totalBorrowAssets, market.totalBorrowShares);
}
```

### toAssetsUp(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2150:209:459
- **Link**: `lib/v2-core/src/vendor/morpho/SharesMathLib.sol:SharesMathLib:toAssetsUp(uint256,uint256,uint256)`

```solidity
/// @dev Calculates the value of `shares` quoted in assets, rounding up.
function toAssetsUp(uint256 shares, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
    return shares.mulDivUp(totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES);
}
```

### mulDivUp(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1017:128:458
- **Link**: `lib/v2-core/src/vendor/morpho/MathLib.sol:MathLib:mulDivUp(uint256,uint256,uint256)`

```solidity
/// @dev Returns (`x` * `y`) / `d` rounded up.
function mulDivUp(uint256 x, uint256 y, uint256 d) internal pure returns (uint256) {
    return ((x * y) + (d - 1)) / d;
}
```

## State Variable Reads

- **morpho** (`address`)
- **AMOUNT_POSITION** (`uint256`)
- **morphoStaticTyping** (`contract IMorphoStaticTyping`) [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorphoStaticTyping.md]
- **VIRTUAL_ASSETS** (`uint256`)
- **VIRTUAL_SHARES** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MorphoRepayHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseMorphoLoanHook._decodeHookData(bytes) (NodeID: 2)
    │   💬 Args: [data]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 3)
    │ │   💬 Args: [data, 0]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 4)
    │ │   💬 Args: [data, 20]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 5)
    │ │   💬 Args: [data, 40]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toAddress(bytes,uint256) (NodeID: 6)
    │ │   💬 Args: [data, 60]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseLoanHook._decodeAmount(bytes) (NodeID: 7)
    │ │   💬 Args: [data]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 8)
    │ │     💬 Args: [data, AMOUNT_POSITION]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 9)
    │ │   💬 Args: [data, 112]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 10)
    │ │   💬 Args: [data, 144]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseHook._decodeBool(bytes,uint256) (NodeID: 11)
    │     💬 Args: [data, 145]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseMorphoLoanHook._generateMarketParams(address,address,address,address,uint256) (NodeID: 12)
    │   💬 Args: [vars.loanToken, vars.collateralToken, vars.oracle, vars.irm, vars.lltv]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 13)
    │   💬 Args: [marketParams]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MorphoRepayHook.deriveShareBalance(Id,address) (NodeID: 14)
    │   💬 Args: [id, account]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: MorphoRepayHook.sharesToAssets(struct MarketParams,address) (NodeID: 15)
        💬 Args: [marketParams, account]
        👁️  Def: public
      ├─ [3] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 16)
      │   💬 Args: [marketParams]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: MorphoRepayHook.deriveShareBalance(Id,address) (NodeID: 17)
      │   💬 Args: [id, account]
      │   👁️  Def: public
      └─ [3] ⚙️ FUNCTION: SharesMathLib.toAssetsUp(uint256,uint256,uint256) (NodeID: 18)
          💬 Args: [shareBalance, market.totalBorrowAssets, market.totalBorrowShares]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 19)
            💬 Args: [shares, totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES]
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
