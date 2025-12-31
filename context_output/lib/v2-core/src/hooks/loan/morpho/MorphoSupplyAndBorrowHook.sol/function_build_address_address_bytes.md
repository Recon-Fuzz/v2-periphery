# Function: build(address,address,bytes)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoSupplyAndBorrowHook.sol/contract_MorphoSupplyAndBorrowHook.md]

## Metadata

- **Contract**: MorphoSupplyAndBorrowHook
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
- **Source**: 2840:1622:379
- **Link**: `lib/v2-core/src/hooks/loan/morpho/MorphoSupplyAndBorrowHook.sol:MorphoSupplyAndBorrowHook:_buildHookExecutions(address,address,bytes)`

```solidity
function _buildHookExecutions(address prevHook, address account, bytes calldata data) override internal view returns (Execution[] memory executions) {
    BorrowHookLocalVars memory vars = _decodeBorrowHookData(data);
    if (vars.usePrevHookAmount) {
        vars.amount = ISuperHookResult(prevHook).getOutAmount(account);
    }
    if (vars.amount == 0) revert AMOUNT_NOT_VALID();
    if ((vars.loanToken == address(0)) || (vars.collateralToken == address(0))) revert ADDRESS_NOT_VALID();
    MarketParams memory marketParams = _generateMarketParams(vars.loanToken, vars.collateralToken, vars.oracle, vars.irm, vars.lltv);
    uint256 loanAmount = deriveLoanAmount(vars.amount, vars.ltvRatio, vars.lltv, vars.oracle);
    executions = new Execution[](4);
    executions[0] = Execution({target: vars.collateralToken, value: 0, callData: abi.encodeCall(IERC20.approve, (morpho, 0))});
    executions[1] = Execution({target: vars.collateralToken, value: 0, callData: abi.encodeCall(IERC20.approve, (morpho, vars.amount))});
    executions[2] = Execution({target: morpho, value: 0, callData: abi.encodeCall(IMorphoBase.supplyCollateral, (marketParams, vars.amount, account, ""))});
    executions[3] = Execution({target: morpho, value: 0, callData: abi.encodeCall(IMorphoBase.borrow, (marketParams, loanAmount, 0, account, account))});
}
```

### _decodeBorrowHookData(bytes)

- **Kind**: internal
- **Source**: 6242:869:379
- **Link**: `lib/v2-core/src/hooks/loan/morpho/MorphoSupplyAndBorrowHook.sol:MorphoSupplyAndBorrowHook:_decodeBorrowHookData(bytes)`

```solidity
function _decodeBorrowHookData(bytes memory data) internal pure returns (BorrowHookLocalVars memory vars) {
    address loanToken = BytesLib.toAddress(data, 0);
    address collateralToken = BytesLib.toAddress(data, 20);
    address oracle = BytesLib.toAddress(data, 40);
    address irm = BytesLib.toAddress(data, 60);
    uint256 amount = _decodeAmount(data);
    uint256 ltvRatio = BytesLib.toUint256(data, 112);
    bool usePrevHookAmount = _decodeBool(data, 144);
    uint256 lltv = BytesLib.toUint256(data, 145);
    return BorrowHookLocalVars({loanToken: loanToken, collateralToken: collateralToken, oracle: oracle, irm: irm, amount: amount, ltvRatio: ltvRatio, usePrevHookAmount: usePrevHookAmount, lltv: lltv});
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

### deriveLoanAmount(uint256,uint256,uint256,address)

- **Kind**: internal
- **Source**: 5507:546:379
- **Link**: `lib/v2-core/src/hooks/loan/morpho/MorphoSupplyAndBorrowHook.sol:MorphoSupplyAndBorrowHook:deriveLoanAmount(uint256,uint256,uint256,address)`

```solidity
/// @dev This function returns the loan amount required for a given collateral amount.
///  @dev It corresponds to the price of 10**(collateral token decimals) assets of collateral token quoted in
///  10**(loan token decimals) assets of loan token with `36 + loan token decimals - collateral token decimals`
///  decimals of precision.
function deriveLoanAmount(uint256 collateralAmount, uint256 ltvRatio, uint256 lltv, address oracle) public view returns (uint256 loanAmount) {
    IOracle oracleInstance = IOracle(oracle);
    uint256 price = oracleInstance.price();
    if (ltvRatio >= lltv) revert LTV_RATIO_NOT_VALID();
    uint256 fullAmount = Math.mulDiv(collateralAmount, price, PRICE_SCALING_FACTOR);
    loanAmount = Math.mulDiv(fullAmount, ltvRatio, PERCENTAGE_SCALING_FACTOR);
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

```solidity
///  @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
///  denominator == 0.
///  Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
///  Uniswap Labs also under MIT license.
function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
    unchecked {
        (uint256 high, uint256 low) = mul512(x, y);
        if (high == 0) {
            return low / denominator;
        }
        if (denominator <= high) {
            Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
        }
        uint256 remainder;
        assembly ("memory-safe") {
            remainder := mulmod(x, y, denominator)
            high := sub(high, gt(remainder, low))
            low := sub(low, remainder)
        }
        uint256 twos = denominator & (0 - denominator);
        assembly ("memory-safe") {
            denominator := div(denominator, twos)
            low := div(low, twos)
            twos := add(div(sub(0, twos), twos), 1)
        }
        low |= high * twos;
        uint256 inverse = (3 * denominator) ^ 2;
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        result = low * inverse;
        return result;
    }
}
```

### mul512(uint256,uint256)

- **Kind**: internal
- **Source**: 1027:550:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

```solidity
///  @dev Return the 512-bit multiplication of two uint256.
///  The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
function mul512(uint256 a, uint256 b) internal pure returns (uint256 high, uint256 low) {
    assembly ("memory-safe") {
        let mm := mulmod(a, b, not(0))
        low := mul(a, b)
        high := sub(sub(mm, low), lt(mm, low))
    }
}
```

### panic(uint256)

- **Kind**: internal
- **Source**: 1776:194:281
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

```solidity
/// @dev Reverts with a panic code. Recommended to use with
///  the internal constants with predefined codes.
function panic(uint256 code) internal pure {
    assembly ("memory-safe") {
        mstore(0x00, 0x4e487b71)
        mstore(0x20, code)
        revert(0x1c, 0x24)
    }
}
```

### ternary(bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5071:294:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

```solidity
///  @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
///  IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
///  However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
///  one branch when needed, making this function more expensive.
function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
    unchecked {
        return b ^ ((a ^ b) * SafeCast.toUint(condition));
    }
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

```solidity
///  @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
function toUint(bool b) internal pure returns (uint256 u) {
    assembly ("memory-safe") {
        u := iszero(iszero(b))
    }
}
```

## External Calls

- **ISuperHookResult::getOutAmount(address)**
- **IAcrossSpokePoolV3::wrappedNativeToken()**
- **ISuperSignatureStorage::retrieveSignatureData(address)**

## State Variable Reads

- **morpho** (`address`)
- **AMOUNT_POSITION** (`uint256`)
- **PRICE_SCALING_FACTOR** (`uint256`)
- **PERCENTAGE_SCALING_FACTOR** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseHook.build(address,address,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MorphoSupplyAndBorrowHook._buildHookExecutions(address,address,bytes) (NodeID: 1)
      💬 Args: [prevHook, account, hookData]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: MorphoSupplyAndBorrowHook._decodeBorrowHookData(bytes) (NodeID: 2)
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
    │ └─ [3] ⚙️ FUNCTION: BytesLib.toUint256(bytes,uint256) (NodeID: 11)
    │     💬 Args: [data, 145]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseMorphoLoanHook._generateMarketParams(address,address,address,address,uint256) (NodeID: 12)
    │   💬 Args: [vars.loanToken, vars.collateralToken, vars.oracle, vars.irm, vars.lltv]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: MorphoSupplyAndBorrowHook.deriveLoanAmount(uint256,uint256,uint256,address) (NodeID: 13)
        💬 Args: [vars.amount, vars.ltvRatio, vars.lltv, vars.oracle]
        👁️  Def: public
      ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 14)
      │   💬 Args: [collateralAmount, price, PRICE_SCALING_FACTOR]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 15)
      │ │   💬 Args: [x, y]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 16)
      │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 17)
      │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 18)
      │         💬 Args: [condition]
      │         👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 19)
          💬 Args: [fullAmount, ltvRatio, PERCENTAGE_SCALING_FACTOR]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 20)
        │   💬 Args: [x, y]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 21)
            💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 22)
              💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 23)
                💬 Args: [condition]
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
