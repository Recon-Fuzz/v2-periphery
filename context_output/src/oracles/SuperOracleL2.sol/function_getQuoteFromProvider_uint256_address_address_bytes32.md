# Function: getQuoteFromProvider(uint256,address,address,bytes32)

**Contract**: [src/oracles/SuperOracleL2.sol/contract_SuperOracleL2.md]

## Metadata

- **Contract**: SuperOracleL2
- **Signature**: `getQuoteFromProvider(uint256,address,address,bytes32)`
- **Visibility**: public
- **Source Range**: 10247:1303:535
- **Inherited From**: SuperOracleBase

## Implementation

```solidity
/// @inheritdoc ISuperOracle
function getQuoteFromProvider(uint256 baseAmount, address base, address quote, bytes32 oracleProvider) virtual public view returns (uint256 quoteAmount, uint256 deviation, uint256 totalProviders, uint256 availableProviders) {
    if (oracleProvider == AVERAGE_PROVIDER) {
        uint256 length = activeProviders.length;
        uint256[] memory validQuotes = new uint256[](length);
        uint256 count;
        (quoteAmount, validQuotes, totalProviders, count) = _getAverageQuote(base, quote, baseAmount, length);
        availableProviders = count;
        deviation = _calculateStdDev(validQuotes, count);
    } else {
        if (!isProviderSet[oracleProvider]) revert ORACLE_UNTRUSTED_DATA();
        address _oracle = oracles[base][quote][oracleProvider];
        if (_oracle == address(0)) revert NO_ORACLES_CONFIGURED();
        quoteAmount = _getQuoteFromOracle(_oracle, baseAmount, base, quote, true);
        deviation = 0;
        totalProviders = 1;
        availableProviders = 1;
    }
}
```

## Related Implementations

### _getAverageQuote(address,address,uint256,uint256)

- **Kind**: internal
- **Source**: 17830:2069:535
- **Link**: `src/oracles/SuperOracleBase.sol:SuperOracleBase:_getAverageQuote(address,address,uint256,uint256)`

```solidity
/// @notice Calculates average quote across multiple oracle providers
///  @param base Base asset address
///  @param quote Quote asset address
///  @param baseAmount Amount to convert
///  @param numberOfProviders Maximum providers to sample (capped to activeProviders.length)
///  @return quoteAmount Average of all valid oracle quotes
///  @return validQuotes Array of valid quotes (only first `count` elements valid, rest are zero)
///  @return totalCount Number of providers that have a configured oracle for this pair
///  @return count Number of providers that successfully returned a valid quote
///  @dev Gracefully skips providers without configured oracles or with untrusted data.
///       Early exits after MAX_SAMPLE_PROVIDERS valid quotes to bound gas costs.
///       Reverts only if NO valid quotes are found (all oracles failed or unconfigured).
function _getAverageQuote(address base, address quote, uint256 baseAmount, uint256 numberOfProviders) virtual internal view returns (uint256 quoteAmount, uint256[] memory validQuotes, uint256 totalCount, uint256 count) {
    uint256 total;
    validQuotes = new uint256[](numberOfProviders);
    for (uint256 i; i < numberOfProviders; ++i) {
        bytes32 provider = activeProviders[i];
        address providerOracle = oracles[base][quote][provider];
        if (providerOracle == address(0)) continue;
        unchecked {
            ++totalCount;
        }
        uint256 quote_ = _getQuoteFromOracle(providerOracle, baseAmount, base, quote, false);
        /// @dev we don't revert on error, we just skip the oracle value
        if (quote_ > 0) {
            total += quote_;
            validQuotes[count] = quote_;
            unchecked {
                ++count;
            }
            if (count == MAX_SAMPLE_PROVIDERS) {
                break;
            }
        }
    }
    if (count == 0) revert NO_VALID_REPORTED_PRICES();
    quoteAmount = total / count;
}
```

### _getQuoteFromOracle(address,uint256,address,address,bool)

- **Kind**: internal
- **Source**: 3390:4246:536
- **Link**: `src/oracles/SuperOracleL2.sol:SuperOracleL2:_getQuoteFromOracle(address,uint256,address,address,bool)`

```solidity
function _getQuoteFromOracle(address oracle, uint256 baseAmount, address base, address quote, bool revertOnError) override internal view returns (uint256 quoteAmount) {
    int256 answer;
    uint256 updatedAt;
    {
        address uptimeOracle = uptimeFeeds[oracle];
        if (uptimeOracle == address(0)) {
            if (revertOnError) revert NO_UPTIME_FEED();
            return 0;
        }
        uint256 gasBeforeUptime = gasleft();
        int256 uptimeAnswer;
        uint256 startedAt;
        try AggregatorV3Interface(uptimeOracle).latestRoundData() returns (uint80, int256 _uptimeAnswer, uint256 _startedAt, uint256, uint80) {
            uptimeAnswer = _uptimeAnswer;
            startedAt = _startedAt;
        } catch {
            if ((gasleft() <= (gasBeforeUptime / 64)) && revertOnError) revert INSUFFICIENT_GAS_FOR_EXTERNAL_CALL();
            if (revertOnError) revert ORACLE_ROUND_DATA_CALL_FAIL(uptimeOracle);
            return 0;
        }
        bool isSequencerUp = uptimeAnswer == 0;
        if (!isSequencerUp) {
            if (revertOnError) revert SEQUENCER_DOWN();
            return 0;
        }
        uint256 timeSinceUp = block.timestamp - startedAt;
        uint256 gracePeriod = gracePeriods[uptimeOracle];
        if (gracePeriod == 0) {
            gracePeriod = DEFAULT_GRACE_PERIOD_TIME;
        }
        if (timeSinceUp <= gracePeriod) {
            if (revertOnError) revert GRACE_PERIOD_NOT_OVER();
            return 0;
        }
    }
    {
        uint256 gasBeforeData = gasleft();
        try AggregatorV3Interface(oracle).latestRoundData() returns (uint80, int256 _answer, uint256, uint256 _updatedAt, uint80) {
            answer = _answer;
            updatedAt = _updatedAt;
        } catch {
            if ((gasleft() <= (gasBeforeData / 64)) && revertOnError) revert INSUFFICIENT_GAS_FOR_EXTERNAL_CALL();
            if (revertOnError) revert ORACLE_ROUND_DATA_CALL_FAIL(oracle);
            return 0;
        }
    }
    uint256 limit = (feedMaxStaleness[oracle] == 0) ? defaultStaleness : Math.min(feedMaxStaleness[oracle], defaultStaleness);
    if ((answer <= 0) || ((block.timestamp - updatedAt) > limit)) {
        if (revertOnError) revert ORACLE_UNTRUSTED_DATA();
        return 0;
    }
    uint256 gasBefore = gasleft();
    try AggregatorV3Interface(oracle).decimals() returns (uint8 feedDecimals) {
        uint8 baseDecimals = IERC20(base).safeDecimals();
        uint8 quoteDecimals = IERC20(quote).safeDecimals();
        quoteAmount = _scaleQuoteAmount(baseAmount, uint256(answer), feedDecimals, baseDecimals, quoteDecimals);
    } catch {
        if ((gasleft() <= (gasBefore / 64)) && revertOnError) revert INSUFFICIENT_GAS_FOR_EXTERNAL_CALL();
        if (revertOnError) revert ORACLE_DECIMALS_CALL_FAIL(oracle);
        return 0;
    }
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 5617:111:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return ternary(a < b, a, b);
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

### _scaleQuoteAmount(uint256,uint256,uint8,uint8,uint8)

- **Kind**: internal
- **Source**: 16558:365:535
- **Link**: `src/oracles/SuperOracleBase.sol:SuperOracleBase:_scaleQuoteAmount(uint256,uint256,uint8,uint8,uint8)`

```solidity
/// @notice Scales quote amount using proper decimal conversion
///  @param baseAmount Amount of base asset
///  @param answer Oracle price answer
///  @param feedDecimals Decimals of the oracle feed
///  @param baseDecimals Decimals of the base asset
///  @param quoteDecimals Decimals of the quote asset
///  @return quoteAmount Scaled quote amount
///  @dev Formula: quoteAmount = (baseAmount * answer * 10^quoteDecimals) / (10^(feedDecimals + baseDecimals))
///       This ensures proper decimal scaling across all three token types
function _scaleQuoteAmount(uint256 baseAmount, uint256 answer, uint8 feedDecimals, uint8 baseDecimals, uint8 quoteDecimals) internal pure returns (uint256 quoteAmount) {
    return Math.mulDiv(baseAmount, uint256(answer) * (10 ** quoteDecimals), 10 ** (feedDecimals + baseDecimals));
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

### _calculateStdDev(uint256[],uint256)

- **Kind**: internal
- **Source**: 20507:806:535
- **Link**: `src/oracles/SuperOracleBase.sol:SuperOracleBase:_calculateStdDev(uint256[],uint256)`

```solidity
/// @notice Calculates standard deviation of oracle price quotes
///  @param values Array of quote values
///  @param length Number of valid elements in values array (first `length` elements)
///  @return stddev Standard deviation (square root of variance)
///  @dev Uses Babylonian square root method (_sqrt). Returns 0 if fewer than 2 values.
///       Used by getQuoteFromProvider() to measure price deviation across oracle providers.
function _calculateStdDev(uint256[] memory values, uint256 length) virtual internal pure returns (uint256 stddev) {
    uint256 sum = 0;
    uint256 count = 0;
    for (uint256 i; i < length; ++i) {
        sum += values[i];
        count++;
    }
    if (count < 2) return 0;
    uint256 mean = sum / count;
    uint256 sumSquaredDiff = 0;
    for (uint256 i; i < length; ++i) {
        uint256 diff;
        if (values[i] >= mean) {
            diff = values[i] - mean;
        } else {
            diff = mean - values[i];
        }
        uint256 squaredDiff = Math.mulDiv(diff, diff, 1);
        sumSquaredDiff += squaredDiff;
    }
    uint256 variance = sumSquaredDiff / count;
    return _sqrt(variance);
}
```

### _sqrt(uint256)

- **Kind**: internal
- **Source**: 21569:233:535
- **Link**: `src/oracles/SuperOracleBase.sol:SuperOracleBase:_sqrt(uint256)`

```solidity
/// @notice Calculates integer square root using Babylonian method
///  @param x Value to calculate square root of
///  @return y Integer square root (rounded down)
///  @dev Iterative convergence algorithm. Safe for all uint256 values.
function _sqrt(uint256 x) internal pure returns (uint256 y) {
    if (x == 0) return 0;
    uint256 z = (x + 1) / 2;
    y = x;
    while (z < y) {
        y = z;
        z = ((x / z) + z) / 2;
    }
}
```

## State Variable Reads

- **AVERAGE_PROVIDER** (`bytes32`)
- **activeProviders** (`bytes32[]`)
- **isProviderSet** (`mapping(bytes32 => bool)`)
- **oracles** (`mapping(address => mapping(address => mapping(bytes32 => address)))`)
- **MAX_SAMPLE_PROVIDERS** (`uint256`)
- **uptimeFeeds** (`mapping(address => address)`)
- **gracePeriods** (`mapping(address => uint256)`)
- **DEFAULT_GRACE_PERIOD_TIME** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleBase.getQuoteFromProvider(uint256,address,address,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperOracleBase._getAverageQuote(address,address,uint256,uint256) (NodeID: 1)
  │   💬 Args: [base, quote, baseAmount, length]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperOracleL2._getQuoteFromOracle(address,uint256,address,address,bool) (NodeID: 2)
  │     💬 Args: [providerOracle, baseAmount, base, quote, false]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 3)
  │   │   💬 Args: [feedMaxStaleness[oracle], defaultStaleness]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 4)
  │   │     💬 Args: [a < b, a, b]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 5)
  │   │       💬 Args: [condition]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SuperOracleBase._scaleQuoteAmount(uint256,uint256,uint8,uint8,uint8) (NodeID: 6)
  │       💬 Args: [baseAmount, uint256(answer), feedDecimals, baseDecimals, quoteDecimals]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 7)
  │         💬 Args: [baseAmount, uint256(answer) * (10 ** quoteDecimals), 10 ** (feedDecimals + baseDecimals)]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 8)
  │       │   💬 Args: [x, y]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 9)
  │           💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 10)
  │             💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 11)
  │               💬 Args: [condition]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperOracleBase._calculateStdDev(uint256[],uint256) (NodeID: 12)
  │   💬 Args: [validQuotes, count]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 13)
  │ │   💬 Args: [diff, diff, 1]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 14)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 15)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 16)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 17)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperOracleBase._sqrt(uint256) (NodeID: 18)
  │     💬 Args: [variance]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperOracleL2._getQuoteFromOracle(address,uint256,address,address,bool) (NodeID: 19)
      💬 Args: [_oracle, baseAmount, base, quote, true]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 20)
    │   💬 Args: [feedMaxStaleness[oracle], defaultStaleness]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 21)
    │     💬 Args: [a < b, a, b]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 22)
    │       💬 Args: [condition]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperOracleBase._scaleQuoteAmount(uint256,uint256,uint8,uint8,uint8) (NodeID: 23)
        💬 Args: [baseAmount, uint256(answer), feedDecimals, baseDecimals, quoteDecimals]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 24)
          💬 Args: [baseAmount, uint256(answer) * (10 ** quoteDecimals), 10 ** (feedDecimals + baseDecimals)]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 25)
        │   💬 Args: [x, y]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 26)
            💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 27)
              💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 28)
                💬 Args: [condition]
                👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperOracle

### Interface Documentation

@notice Get quote from specified oracle provider
 @param baseAmount Amount of base asset
 @param base Base asset address
 @param quote Quote asset address
 @param oracleProvider Id of oracle provider to use
 @return quoteAmount The quote amount
 @return deviation Standard deviation of oracle quotes in quote asset units (0 for single provider)
 @return totalProviders Total number of providers that have a configured oracle for this pair
 @return availableProviders Number of providers that successfully returned a valid quote
