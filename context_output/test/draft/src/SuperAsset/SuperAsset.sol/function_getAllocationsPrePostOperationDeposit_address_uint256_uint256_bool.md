# Function: getAllocationsPrePostOperationDeposit(address,uint256,uint256,bool)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `getAllocationsPrePostOperationDeposit(address,uint256,uint256,bool)`
- **Visibility**: public
- **Source Range**: 31651:3481:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function getAllocationsPrePostOperationDeposit(address token, uint256 deltaToken, uint256 amountToken, bool isSoft) public view returns (ISuperAsset.AllocationOperationReturnVars memory ret) {
    GetAllocationsPrePostOperationsDeposit memory s;
    s.extendedLength = _supportedAssets.length();
    ret.absoluteAllocationPreOperation = new uint256[](s.extendedLength);
    ret.absoluteAllocationPostOperation = new uint256[](s.extendedLength);
    ret.absoluteTargetAllocation = new uint256[](s.extendedLength);
    ret.vaultWeights = new uint256[](s.extendedLength);
    s.totalValueUSD = 0;
    s.priceUSDToken = 0;
    for (uint256 i; i < s.extendedLength; i++) {
        s.token = _supportedAssets.at(i);
        (ret.oraclePriceUSD, ret.isDepeg, ret.isDispersion, ret.isOracleOff) = getPriceAndCircuitBreakers(s.token);
        if ((!isSoft) && (((ret.isDepeg || ret.isDispersion) || ret.isOracleOff) || (ret.oraclePriceUSD == 0))) {
            ret.assetWithBreakerTriggered = s.token;
            return ret;
        }
        s.balance = IERC20(s.token).balanceOf(address(this));
        uint256 decimals = IERC20Metadata(s.token).decimals();
        if (s.balance > 0) {
            s.totalValueUSD += Math.mulDiv(s.balance, ret.oraclePriceUSD, 10 ** decimals);
        }
        ret.absoluteAllocationPreOperation[i] = Math.mulDiv(s.balance, ret.oraclePriceUSD, 10 ** decimals);
        ret.totalAllocationPreOperation += ret.absoluteAllocationPreOperation[i];
        ret.absoluteAllocationPostOperation[i] = ret.absoluteAllocationPreOperation[i];
        if (s.token == token) {
            s.priceUSDToken = ret.oraclePriceUSD;
            ret.tokenFound = true;
            s.absDeltaValue = Math.mulDiv(deltaToken, s.priceUSDToken, 10 ** decimals);
            s.deltaValue = int256(s.absDeltaValue);
            ret.absoluteAllocationPostOperation[i] = uint256(int256(ret.absoluteAllocationPreOperation[i]) + s.deltaValue);
        }
        ret.totalAllocationPostOperation += ret.absoluteAllocationPostOperation[i];
        ret.absoluteTargetAllocation[i] = tokenData[s.token].targetAllocations;
        ret.totalTargetAllocation += ret.absoluteTargetAllocation[i];
        ret.vaultWeights[i] = tokenData[s.token].weights;
    }
    uint256 superAssetPPS;
    uint256 totalSupply_ = totalSupply();
    if (totalSupply_ == 0) {
        superAssetPPS = PRECISION;
    } else {
        superAssetPPS = Math.mulDiv(s.totalValueUSD, PRECISION, totalSupply_);
    }
    ret.amountAssets = Math.mulDiv(amountToken, s.priceUSDToken, superAssetPPS);
    uint8 decimalsToken = IERC20Metadata(token).decimals();
    if (decimalsToken < DECIMALS) {
        ret.amountAssets = Math.mulDiv(ret.amountAssets, 10 ** (DECIMALS - decimalsToken), PRECISION);
    } else if (decimalsToken > DECIMALS) {
        ret.amountAssets = Math.mulDiv(ret.amountAssets, 10 ** (decimalsToken - DECIMALS), PRECISION);
    }
}
```

## Related Implementations

### length(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 12616:115:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:length(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Returns the number of values in the set. O(1).
function length(AddressSet storage set) internal view returns (uint256) {
    return _length(set._inner);
}
```

### _length(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5311:107:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_length(struct EnumerableSet.Set)`

```solidity
///  @dev Returns the number of values on the set. O(1).
function _length(Set storage set) private view returns (uint256) {
    return set._values.length;
}
```

### at(struct EnumerableSet.AddressSet,uint256)

- **Kind**: internal
- **Source**: 13073:156:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:at(struct EnumerableSet.AddressSet,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function at(AddressSet storage set, uint256 index) internal view returns (address) {
    return address(uint160(uint256(_at(set._inner, index))));
}
```

### _at(struct EnumerableSet.Set,uint256)

- **Kind**: internal
- **Source**: 5760:118:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_at(struct EnumerableSet.Set,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function _at(Set storage set, uint256 index) private view returns (bytes32) {
    return set._values[index];
}
```

### getPriceAndCircuitBreakers(address)

- **Kind**: internal
- **Source**: 28384:707:548
- **Link**: `test/draft/src/SuperAsset/SuperAsset.sol:SuperAsset:getPriceAndCircuitBreakers(address)`

```solidity
/// @inheritdoc ISuperAsset
function getPriceAndCircuitBreakers(address token) public view returns (uint256 priceUSD, bool isDepeg, bool isDispersion, bool isOracleOff) {
    address superOracle = superGovernor.getAddress(superGovernor.SUPER_ORACLE());
    return SuperAssetPriceLib.getPriceWithCircuitBreakers(ISuperAsset.PriceArgs({superOracle: superOracle, superAsset: address(this), token: token, usd: USD, depegLowerThreshold: DEPEG_LOWER_THRESHOLD, depegUpperThreshold: DEPEG_UPPER_THRESHOLD, dispersionThreshold: DISPERSION_THRESHOLD}));
}
```

### getPriceWithCircuitBreakers(struct ISuperAsset.PriceArgs)

- **Kind**: internal
- **Source**: 984:1209:563
- **Link**: `test/draft/src/libraries/SuperAssetPriceLib.sol:SuperAssetPriceLib:getPriceWithCircuitBreakers(struct ISuperAsset.PriceArgs)`

```solidity
/// @dev Gets the price of a token with circuit breakers
///  @param args The arguments for the price calculation
///  @return priceUSD The price of the token in USD
///  @return isDepeg Whether the token is depegged
///  @return isDispersion Whether the token has price dispersion
///  @return isOracleOff Whether the oracle is off
function getPriceWithCircuitBreakers(ISuperAsset.PriceArgs memory args) external view returns (uint256 priceUSD, bool isDepeg, bool isDispersion, bool isOracleOff) {
    uint256 stddev;
    uint256 M;
    ISuperOracle superOracle = ISuperOracle(args.superOracle);
    ISuperAsset superAsset = ISuperAsset(args.superAsset);
    uint256 precision = superAsset.getPrecision();
    (priceUSD, stddev, M) = _getPriceInfo(superOracle, superAsset, args.usd, args.token);
    if (M == 0) {
        isOracleOff = true;
    } else {
        address primaryAsset = superAsset.getPrimaryAsset();
        if (primaryAsset == args.usd) {
            return (precision, false, false, false);
        }
        (isDepeg, isDispersion) = _getDepegAndDispersion(args, precision, priceUSD, stddev);
    }
    return (priceUSD, isDepeg, isDispersion, isOracleOff);
}
```

### _getPriceInfo(contract ISuperOracle,contract ISuperAsset,address,address)

- **Kind**: internal
- **Source**: 5582:810:563
- **Link**: `test/draft/src/libraries/SuperAssetPriceLib.sol:SuperAssetPriceLib:_getPriceInfo(contract ISuperOracle,contract ISuperAsset,address,address)`

```solidity
/// @dev Gets the price information for a token
///  @param superOracle The super oracle
///  @param superAsset The super asset
///  @param USD The USD address
///  @param token The token address
///  @return priceUSD The price of the token in USD
///  @return stddev The standard deviation of the token
function _getPriceInfo(ISuperOracle superOracle, ISuperAsset superAsset, address USD, address token) internal view returns (uint256 priceUSD, uint256 stddev, uint256 M) {
    bytes32 AVERAGE_PROVIDER = keccak256("AVERAGE_PROVIDER");
    uint256 one = 10 ** IERC20Metadata(token).decimals();
    ISuperAsset.TokenData memory tokenData = superAsset.getTokenData(token);
    if (tokenData.isSupportedERC20) {
        (priceUSD, stddev, , M) = superOracle.getQuoteFromProvider(one, token, USD, AVERAGE_PROVIDER);
    } else if (tokenData.isSupportedUnderlyingVault) {
        (priceUSD, stddev, M) = _derivePriceFromUnderlyingVault(superOracle, superAsset, USD, token, tokenData.oracle);
    }
}
```

### _derivePriceFromUnderlyingVault(contract ISuperOracle,contract ISuperAsset,address,address,address)

- **Kind**: internal
- **Source**: 2500:828:563
- **Link**: `test/draft/src/libraries/SuperAssetPriceLib.sol:SuperAssetPriceLib:_derivePriceFromUnderlyingVault(contract ISuperOracle,contract ISuperAsset,address,address,address)`

```solidity
/// @dev Derives the price of the token from the underlying vault
///  @param token The address of the token to derive the price of
///  @return priceUSD The price of the token in USD
///  @return stddev The standard deviation of the token
///  @return M The number of quote providers
function _derivePriceFromUnderlyingVault(ISuperOracle superOracle, ISuperAsset superAsset, address USD, address token, address oracle) internal view returns (uint256 priceUSD, uint256 stddev, uint256 M) {
    address vaultAsset = IERC4626(token).asset();
    uint256 unitVaultAsset = 10 ** IERC20Metadata(vaultAsset).decimals();
    bytes32 AVERAGE_PROVIDER = keccak256("AVERAGE_PROVIDER");
    (priceUSD, stddev, , M) = superOracle.getQuoteFromProvider(unitVaultAsset, vaultAsset, USD, AVERAGE_PROVIDER);
    uint256 pricePerShare = IYieldSourceOracle(oracle).getPricePerShare(token);
    if (priceUSD > 0) {
        priceUSD = pricePerShare.mulDiv(priceUSD, superAsset.getPrecision(), Math.Rounding.Floor);
    }
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
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

### unsignedRoundsUp(enum Math.Rounding)

- **Kind**: internal
- **Source**: 32020:122:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
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

### _getDepegAndDispersion(struct ISuperAsset.PriceArgs,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 6805:569:563
- **Link**: `test/draft/src/libraries/SuperAssetPriceLib.sol:SuperAssetPriceLib:_getDepegAndDispersion(struct ISuperAsset.PriceArgs,uint256,uint256,uint256)`

```solidity
/// @dev Gets the depeg and dispersion status of a token
///  @param args The arguments for the price calculation
///  @param precision The precision of the token
///  @param priceUSD The price of the token in USD
///  @param stddev The standard deviation of the token
///  @return isDepeg True if the token is depegged
///  @return isDispersion True if the token has price dispersion
function _getDepegAndDispersion(ISuperAsset.PriceArgs memory args, uint256 precision, uint256 priceUSD, uint256 stddev) internal view returns (bool isDepeg, bool isDispersion) {
    uint256 assetPriceUSD = _getAssetPriceUSD(args.superOracle, args.superAsset, args.usd);
    isDepeg = _isTokenDepeg(priceUSD, precision, assetPriceUSD, args.depegLowerThreshold, args.depegUpperThreshold);
    isDispersion = _isSTDDevDegged(args.superAsset, stddev, priceUSD, args.dispersionThreshold);
}
```

### _getAssetPriceUSD(address,address,address)

- **Kind**: internal
- **Source**: 7666:616:563
- **Link**: `test/draft/src/libraries/SuperAssetPriceLib.sol:SuperAssetPriceLib:_getAssetPriceUSD(address,address,address)`

```solidity
/// @dev Gets the price of the asset in USD
///  @param superOracleAddress The address of the super oracle
///  @param superAssetAddress The address of the super asset
///  @param USD The address of the USD token
///  @return assetPriceUSD The price of the asset in USD
function _getAssetPriceUSD(address superOracleAddress, address superAssetAddress, address USD) internal view returns (uint256 assetPriceUSD) {
    bytes32 AVERAGE_PROVIDER = keccak256("AVERAGE_PROVIDER");
    address primaryAsset = ISuperAsset(superAssetAddress).getPrimaryAsset();
    uint256 oneUnitAsset = 10 ** IERC20Metadata(primaryAsset).decimals();
    ISuperOracle superOracle = ISuperOracle(superOracleAddress);
    (assetPriceUSD, , , ) = superOracle.getQuoteFromProvider(oneUnitAsset, primaryAsset, USD, AVERAGE_PROVIDER);
}
```

### _isTokenDepeg(uint256,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 4341:909:563
- **Link**: `test/draft/src/libraries/SuperAssetPriceLib.sol:SuperAssetPriceLib:_isTokenDepeg(uint256,uint256,uint256,uint256,uint256)`

```solidity
/// @dev Checks if the token is depegged
///  @param priceUSD The price of the token in USD
///  @param assetPriceUSD The price of the asset in USD
///  @return isDepeg True if the token is depegged
function _isTokenDepeg(uint256 priceUSD, uint256 precision, uint256 assetPriceUSD, uint256 depegLowerThreshold, uint256 depegUpperThreshold) internal pure returns (bool isDepeg) {
    uint256 ratio = Math.mulDiv(priceUSD, precision, assetPriceUSD);
    if ((ratio < depegLowerThreshold) || (ratio > depegUpperThreshold)) {
        isDepeg = true;
    }
}
```

### _isSTDDevDegged(address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3608:515:563
- **Link**: `test/draft/src/libraries/SuperAssetPriceLib.sol:SuperAssetPriceLib:_isSTDDevDegged(address,uint256,uint256,uint256)`

```solidity
/// @dev Checks if the standard deviation is greater than the dispersion threshold
///  @param stddev The standard deviation
///  @param priceUSD The price in USD
///  @return isDispersion True if the standard deviation is greater than the dispersion threshold
function _isSTDDevDegged(address superAsset, uint256 stddev, uint256 priceUSD, uint256 dispersionThreshold) internal pure returns (bool) {
    uint256 relativeStdDev = Math.mulDiv(stddev, ISuperAsset(superAsset).getPrecision(), priceUSD);
    if (relativeStdDev > dispersionThreshold) {
        return true;
    }
    return false;
}
```

### totalSupply()

- **Kind**: internal
- **Source**: 2803:97:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:totalSupply()`

```solidity
/// @inheritdoc IERC20
function totalSupply() virtual public view returns (uint256) {
    return _totalSupply;
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **IERC20Metadata::decimals()**

## State Variable Reads

- **_supportedAssets** (`struct EnumerableSet.AddressSet`)
- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)
- **PRECISION** (`uint256`)
- **DECIMALS** (`uint256`)
- **superGovernor** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **USD** (`address`)
- **DEPEG_LOWER_THRESHOLD** (`uint256`)
- **DEPEG_UPPER_THRESHOLD** (`uint256`)
- **DISPERSION_THRESHOLD** (`uint256`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.getAllocationsPrePostOperationDeposit(address,uint256,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.length(struct EnumerableSet.AddressSet) (NodeID: 1)
  │   💬 Args: [_supportedAssets]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 2)
  │     💬 Args: [set._inner]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 3)
  │   💬 Args: [_supportedAssets, i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 4)
  │     💬 Args: [set._inner, index]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperAsset.getPriceAndCircuitBreakers(address) (NodeID: 5)
  │   💬 Args: [s.token]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: SuperAssetPriceLib.getPriceWithCircuitBreakers(struct ISuperAsset.PriceArgs) (NodeID: 6)
  │     💬 Args: [ISuperAsset.PriceArgs({superOracle: superOracle, superAsset: address(this), token: token, usd: USD, depegLowerThreshold: DEPEG_LOWER_THRESHOLD, depegUpperThreshold: DEPEG_UPPER_THRESHOLD, dispersionThreshold: DISPERSION_THRESHOLD})]
  │     👁️  Def: external
  │   ├─ [3] ⚙️ FUNCTION: SuperAssetPriceLib._getPriceInfo(contract ISuperOracle,contract ISuperAsset,address,address) (NodeID: 7)
  │   │   💬 Args: [superOracle, superAsset, args.usd, args.token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: SuperAssetPriceLib._derivePriceFromUnderlyingVault(contract ISuperOracle,contract ISuperAsset,address,address,address) (NodeID: 8)
  │   │     💬 Args: [superOracle, superAsset, USD, token, tokenData.oracle]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 9)
  │   │       💬 Args: [pricePerShare, priceUSD, superAsset.getPrecision(), Math.Rounding.Floor]
  │   │       👁️  Def: internal
  │   │     ├─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 10)
  │   │     │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │   │     │   👁️  Def: internal
  │   │     │ └─ [7] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 11)
  │   │     │     💬 Args: [rounding]
  │   │     │     👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 12)
  │   │         💬 Args: [x, y, denominator]
  │   │         👁️  Def: internal
  │   │       ├─ [7] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 13)
  │   │       │   💬 Args: [x, y]
  │   │       │   👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 14)
  │   │           💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │   │           👁️  Def: internal
  │   │         └─ [8] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 15)
  │   │             💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │   │             👁️  Def: internal
  │   │           └─ [9] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 16)
  │   │               💬 Args: [condition]
  │   │               👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SuperAssetPriceLib._getDepegAndDispersion(struct ISuperAsset.PriceArgs,uint256,uint256,uint256) (NodeID: 17)
  │       💬 Args: [args, precision, priceUSD, stddev]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: SuperAssetPriceLib._getAssetPriceUSD(address,address,address) (NodeID: 18)
  │     │   💬 Args: [args.superOracle, args.superAsset, args.usd]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: SuperAssetPriceLib._isTokenDepeg(uint256,uint256,uint256,uint256,uint256) (NodeID: 19)
  │     │   💬 Args: [priceUSD, precision, assetPriceUSD, args.depegLowerThreshold, args.depegUpperThreshold]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 20)
  │     │     💬 Args: [priceUSD, precision, assetPriceUSD]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 21)
  │     │   │   💬 Args: [x, y]
  │     │   │   👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 22)
  │     │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 23)
  │     │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │     │         👁️  Def: internal
  │     │       └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 24)
  │     │           💬 Args: [condition]
  │     │           👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SuperAssetPriceLib._isSTDDevDegged(address,uint256,uint256,uint256) (NodeID: 25)
  │         💬 Args: [args.superAsset, stddev, priceUSD, args.dispersionThreshold]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 26)
  │           💬 Args: [stddev, ISuperAsset(superAsset).getPrecision(), priceUSD]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 27)
  │         │   💬 Args: [x, y]
  │         │   👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 28)
  │             💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 29)
  │               💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 30)
  │                 💬 Args: [condition]
  │                 👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 31)
  │   💬 Args: [s.balance, ret.oraclePriceUSD, 10 ** decimals]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 32)
  │ │   💬 Args: [x, y]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 33)
  │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 34)
  │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 35)
  │         💬 Args: [condition]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 36)
  │   💬 Args: [s.balance, ret.oraclePriceUSD, 10 ** decimals]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 37)
  │ │   💬 Args: [x, y]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 38)
  │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 39)
  │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 40)
  │         💬 Args: [condition]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 41)
  │   💬 Args: [deltaToken, s.priceUSDToken, 10 ** decimals]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 42)
  │ │   💬 Args: [x, y]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 43)
  │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 44)
  │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 45)
  │         💬 Args: [condition]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 46)
  │   💬 Args: [no args]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 47)
  │   💬 Args: [s.totalValueUSD, PRECISION, totalSupply_]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 48)
  │ │   💬 Args: [x, y]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 49)
  │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 50)
  │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 51)
  │         💬 Args: [condition]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 52)
  │   💬 Args: [amountToken, s.priceUSDToken, superAssetPPS]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 53)
  │ │   💬 Args: [x, y]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 54)
  │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 55)
  │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 56)
  │         💬 Args: [condition]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 57)
  │   💬 Args: [ret.amountAssets, 10 ** (DECIMALS - decimalsToken), PRECISION]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 58)
  │ │   💬 Args: [x, y]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 59)
  │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 60)
  │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 61)
  │         💬 Args: [condition]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 62)
      💬 Args: [ret.amountAssets, 10 ** (decimalsToken - DECIMALS), PRECISION]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 63)
    │   💬 Args: [x, y]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 64)
        💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 65)
          💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 66)
            💬 Args: [condition]
            👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Gets the allocations before and after an operation deposit
 @param token The token address involved in the operation
 @param deltaToken The delta token (this is amountTokenToDeposit)
 @param amountToken The amount of the token after fees
 @param isSoft Whether the operation is soft or strict on checks
 @return ret The allocation operation return variables containing:
 - absoluteAllocationPreOperation: Array of pre-operation absolute allocations
 - totalAllocationPreOperation: Total pre-operation allocation
 - absoluteAllocationPostOperation: Array of post-operation absolute allocations
 - totalAllocationPostOperation: Total post-operation allocation
 - absoluteTargetAllocation: Array of target absolute allocations
 - totalTargetAllocation: Total target allocation
 - vaultWeights: Array of vault weights
 - amountAssets: Amount of shares (for deposit) or tokens (for redeem)
 - assetWithBreakerTriggered: Address of the asset with the breaker triggered
 - oraclePriceUSD: Oracle price in USD
 - isDepeg: Whether the asset is depegged
 - isDispersion: Whether the asset is dispersed
 - isOracleOff: Whether the asset is oracle off
 - tokenFound: Whether the token in/out was found
