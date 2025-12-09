# Function: redeem(struct ISuperAsset.RedeemArgs)

**Contract**: [test/draft/src/SuperAsset/SuperAsset.sol/contract_SuperAsset.md]

## Metadata

- **Contract**: SuperAsset
- **Signature**: `redeem(struct ISuperAsset.RedeemArgs)`
- **Visibility**: public
- **Source Range**: 14107:4040:548

## Implementation

```solidity
/// @inheritdoc ISuperAsset
function redeem(RedeemArgs memory args) public returns (RedeemReturnVars memory ret) {
    if ((args.receiver == address(0)) || (args.tokenOut == address(0))) revert ZERO_ADDRESS();
    if (args.amountSharesToRedeem == 0) revert ZERO_AMOUNT();
    if (!_supportedAssets.contains(args.tokenOut)) revert NOT_SUPPORTED_TOKEN();
    PreviewRedeemArgs memory previewArgs = PreviewRedeemArgs({tokenOut: args.tokenOut, amountSharesToRedeem: args.amountSharesToRedeem, isSoft: true});
    PreviewRedeemReturnVars memory previewRet = previewRedeem(previewArgs);
    ret.amountTokenOutAfterFees = previewRet.amountTokenOutAfterFees;
    ret.swapFee = previewRet.swapFee;
    ret.amountIncentiveUSDRedeem = previewRet.amountIncentiveUSDRedeem;
    if ((!previewRet.incentiveCalculationSuccess) && (totalSupply() != 0)) revert INCENTIVE_CALCULATION_FAILED();
    if (ret.amountTokenOutAfterFees < args.minTokenOut) revert SLIPPAGE_PROTECTION();
    if (previewRet.assetWithBreakerTriggered != address(0)) {
        if (previewRet.isDepeg) {
            revert SUPPORTED_ASSET_PRICE_DEPEG(previewRet.assetWithBreakerTriggered);
        }
        if (previewRet.isOracleOff) {
            revert SUPPORTED_ASSET_PRICE_ORACLE_OFF(previewRet.assetWithBreakerTriggered);
        }
        if (previewRet.isDispersion) {
            revert SUPPORTED_ASSET_PRICE_DISPERSION(previewRet.assetWithBreakerTriggered);
        }
        if (previewRet.oraclePriceUSD == 0) {
            revert SUPPORTED_ASSET_PRICE_ZERO(previewRet.assetWithBreakerTriggered);
        }
    }
    if (!previewRet.tokenOutFound) {
        revert NOT_SUPPORTED_TOKEN();
    }
    if (ret.amountIncentiveUSDRedeem > 0) {
        _settleIncentive(args.receiver, ret.amountIncentiveUSDRedeem);
    }
    _burn(msg.sender, args.amountSharesToRedeem);
    IERC20(args.tokenOut).safeTransfer(superGovernor.getAddress(superGovernor.SUPER_BANK()), ret.swapFee);
    IERC20(args.tokenOut).safeTransfer(args.receiver, ret.amountTokenOutAfterFees);
    emit Redeem(args.receiver, args.tokenOut, args.amountSharesToRedeem, ret.amountTokenOutAfterFees, ret.swapFee, ret.amountIncentiveUSDRedeem);
}
```

## Related Implementations

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 12370:165:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 5101:129:297
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._positions[value] != 0;
}
```

### previewRedeem(struct ISuperAsset.PreviewRedeemArgs)

- **Kind**: internal
- **Source**: 22625:2351:548
- **Link**: `test/draft/src/SuperAsset/SuperAsset.sol:SuperAsset:previewRedeem(struct ISuperAsset.PreviewRedeemArgs)`

```solidity
/// @inheritdoc ISuperAsset
function previewRedeem(PreviewRedeemArgs memory args) public view returns (PreviewRedeemReturnVars memory ret) {
    ISuperAsset.AllocationOperationReturnVars memory allocRet = getAllocationsPrePostOperationRedeem(args.tokenOut, args.amountSharesToRedeem, args.isSoft);
    ret.assetWithBreakerTriggered = allocRet.assetWithBreakerTriggered;
    ret.oraclePriceUSD = allocRet.oraclePriceUSD;
    ret.isDepeg = allocRet.isDepeg;
    ret.isDispersion = allocRet.isDispersion;
    ret.isOracleOff = allocRet.isOracleOff;
    ret.tokenOutFound = allocRet.tokenFound;
    if ((((ret.isDepeg || ret.isDispersion) || ret.isOracleOff) || (ret.oraclePriceUSD == 0))) {
        ret.amountTokenOutAfterFees = 0;
        ret.swapFee = 0;
        ret.amountIncentiveUSDRedeem = 0;
        ret.incentiveCalculationSuccess = false;
        return ret;
    }
    ret.swapFee = Math.mulDiv(allocRet.amountAssets, swapFeeOutPercentage, SWAP_FEE_PERC);
    ret.amountTokenOutAfterFees = allocRet.amountAssets - ret.swapFee;
    if (IIncentiveFundContract(factory.getIncentiveFundContract(address(this))).incentivesEnabled()) {
        (ret.amountIncentiveUSDRedeem, ret.incentiveCalculationSuccess) = IIncentiveCalculationContract(factory.getIncentiveCalculationContract(address(this))).calculateIncentive(allocRet.absoluteAllocationPreOperation, allocRet.absoluteAllocationPostOperation, allocRet.absoluteTargetAllocation, allocRet.vaultWeights, allocRet.totalAllocationPreOperation, allocRet.totalAllocationPostOperation, allocRet.totalTargetAllocation, energyToUSDExchangeRatio);
    } else {
        ret.incentiveCalculationSuccess = true;
    }
}
```

### getAllocationsPrePostOperationRedeem(address,uint256,bool)

- **Kind**: internal
- **Source**: 35170:5487:548
- **Link**: `test/draft/src/SuperAsset/SuperAsset.sol:SuperAsset:getAllocationsPrePostOperationRedeem(address,uint256,bool)`

```solidity
/// @inheritdoc ISuperAsset
function getAllocationsPrePostOperationRedeem(address token, uint256 amountToken, bool isSoft) public view returns (ISuperAsset.AllocationOperationReturnVars memory ret) {
    GetAllocationsPrePostOperationsRedeem memory s;
    s.extendedLength = _supportedAssets.length();
    s.oraclePriceUSDs = new uint256[](s.extendedLength);
    s.balances = new uint256[](s.extendedLength);
    s.decimals = new uint256[](s.extendedLength);
    s.isDepegs = new bool[](s.extendedLength);
    s.isDispersions = new bool[](s.extendedLength);
    s.isOracleOffs = new bool[](s.extendedLength);
    s.totalValueUSD = 0;
    s.priceUSDToken = 0;
    for (uint256 i; i < s.extendedLength; i++) {
        s.token = _supportedAssets.at(i);
        (s.oraclePriceUSDs[i], s.isDepegs[i], s.isDispersions[i], s.isOracleOffs[i]) = getPriceAndCircuitBreakers(s.token);
        if ((!isSoft) && (((s.isDepegs[i] || s.isDispersions[i]) || s.isOracleOffs[i]) || (s.oraclePriceUSDs[i] == 0))) {
            ret.assetWithBreakerTriggered = s.token;
            ret.oraclePriceUSD = s.oraclePriceUSDs[i];
            ret.isDepeg = s.isDepegs[i];
            ret.isDispersion = s.isDispersions[i];
            ret.isOracleOff = s.isOracleOffs[i];
            return ret;
        }
        s.balances[i] = IERC20(s.token).balanceOf(address(this));
        s.decimals[i] = IERC20Metadata(s.token).decimals();
        if (s.balances[i] > 0) {
            s.totalValueUSD += Math.mulDiv(s.balances[i], s.oraclePriceUSDs[i], 10 ** s.decimals[i]);
        }
        if (s.token == token) {
            s.priceUSDToken = s.oraclePriceUSDs[i];
            ret.tokenFound = true;
        }
        if (i == (s.extendedLength - 1)) {
            ret.assetWithBreakerTriggered = s.token;
            ret.oraclePriceUSD = s.oraclePriceUSDs[i];
            ret.isDepeg = s.isDepegs[i];
            ret.isDispersion = s.isDispersions[i];
            ret.isOracleOff = s.isOracleOffs[i];
        }
    }
    ret.absoluteAllocationPreOperation = new uint256[](s.extendedLength);
    ret.absoluteAllocationPostOperation = new uint256[](s.extendedLength);
    ret.absoluteTargetAllocation = new uint256[](s.extendedLength);
    ret.vaultWeights = new uint256[](s.extendedLength);
    uint256 totalSupply_ = totalSupply();
    if (totalSupply_ == 0) {
        s.superAssetPPS = PRECISION;
    } else {
        s.superAssetPPS = Math.mulDiv(s.totalValueUSD, PRECISION, totalSupply_);
    }
    ret.amountAssets = Math.mulDiv(amountToken, s.superAssetPPS, s.priceUSDToken);
    s.decimalsToken = IERC20Metadata(token).decimals();
    if (s.decimalsToken < DECIMALS) {
        ret.amountAssets = Math.mulDiv(ret.amountAssets, 10 ** (DECIMALS - s.decimalsToken), PRECISION);
    } else if (s.decimalsToken > DECIMALS) {
        ret.amountAssets = Math.mulDiv(ret.amountAssets, 10 ** (s.decimalsToken - DECIMALS), PRECISION);
    }
    s.balanceOfDeltaToken = IERC20(token).balanceOf(address(this));
    if (ret.amountAssets > s.balanceOfDeltaToken) {
        s.deltaToken = s.balanceOfDeltaToken;
    } else {
        s.deltaToken = ret.amountAssets;
    }
    for (uint256 i; i < s.extendedLength; i++) {
        s.token = _supportedAssets.at(i);
        ret.absoluteAllocationPreOperation[i] = Math.mulDiv(s.balances[i], s.oraclePriceUSDs[i], 10 ** s.decimals[i]);
        ret.totalAllocationPreOperation += ret.absoluteAllocationPreOperation[i];
        ret.absoluteAllocationPostOperation[i] = ret.absoluteAllocationPreOperation[i];
        if (s.token == token) {
            s.absDeltaValue = Math.mulDiv(s.deltaToken, s.oraclePriceUSDs[i], 10 ** s.decimals[i]);
            s.deltaValue = -int256(s.absDeltaValue);
            ret.absoluteAllocationPostOperation[i] = uint256(int256(ret.absoluteAllocationPreOperation[i]) + s.deltaValue);
        }
        ret.totalAllocationPostOperation += ret.absoluteAllocationPostOperation[i];
        ret.absoluteTargetAllocation[i] = tokenData[s.token].targetAllocations;
        ret.totalTargetAllocation += ret.absoluteTargetAllocation[i];
        ret.vaultWeights[i] = tokenData[s.token].weights;
    }
}
```

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

### _settleIncentive(address,int256)

- **Kind**: internal
- **Source**: 41601:549:548
- **Link**: `test/draft/src/SuperAsset/SuperAsset.sol:SuperAsset:_settleIncentive(address,int256)`

```solidity
/// @dev Settles incentives for a user
///  @param user The address of the user to settle incentives for
///  @param amountIncentiveUSD The amount of incentives to settle
function _settleIncentive(address user, int256 amountIncentiveUSD) internal {
    if (amountIncentiveUSD > 0) {
        IIncentiveFundContract(factory.getIncentiveFundContract(address(this))).payIncentive(user, uint256(amountIncentiveUSD));
    } else if (amountIncentiveUSD < 0) {
        IIncentiveFundContract(factory.getIncentiveFundContract(address(this))).takeIncentive(user, uint256(-amountIncentiveUSD));
    }
}
```

### _burn(address,uint256)

- **Kind**: internal
- **Source**: 7888:206:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_burn(address,uint256)`

```solidity
///  @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
///  Relies on the `_update` mechanism.
///  Emits a {Transfer} event with `to` set to the zero address.
///  NOTE: This function is not virtual, {_update} should be overridden instead
function _burn(address account, uint256 value) internal {
    if (account == address(0)) {
        revert ERC20InvalidSender(address(0));
    }
    _update(account, address(0), value);
}
```

### _update(address,address,uint256)

- **Kind**: internal
- **Source**: 5912:1107:267
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:_update(address,address,uint256)`

```solidity
///  @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
///  (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
///  this function.
///  Emits a {Transfer} event.
function _update(address from, address to, uint256 value) virtual internal {
    if (from == address(0)) {
        _totalSupply += value;
    } else {
        uint256 fromBalance = _balances[from];
        if (fromBalance < value) {
            revert ERC20InsufficientBalance(from, fromBalance, value);
        }
        unchecked {
            _balances[from] = fromBalance - value;
        }
    }
    if (to == address(0)) {
        unchecked {
            _totalSupply -= value;
        }
    } else {
        unchecked {
            _balances[to] += value;
        }
    }
    emit Transfer(from, to, value);
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **ISuperGovernor::getAddress(bytes32)**
- **ISuperGovernor::SUPER_BANK()**

## State Variable Reads

- **_supportedAssets** (`struct EnumerableSet.AddressSet`)
- **superGovernor** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **swapFeeOutPercentage** (`uint256`)
- **SWAP_FEE_PERC** (`uint256`)
- **factory** (`contract ISuperAssetFactory`) [test/draft/src/interfaces/SuperAsset/ISuperAssetFactory.sol/interface_ISuperAssetFactory.md]
- **energyToUSDExchangeRatio** (`uint256`)
- **PRECISION** (`uint256`)
- **DECIMALS** (`uint256`)
- **tokenData** (`mapping(address => struct ISuperAsset.TokenData)`)
- **USD** (`address`)
- **DEPEG_LOWER_THRESHOLD** (`uint256`)
- **DEPEG_UPPER_THRESHOLD** (`uint256`)
- **DISPERSION_THRESHOLD** (`uint256`)
- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## State Variable Writes

- **_totalSupply** (`uint256`)
- **_balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperAsset.redeem(struct ISuperAsset.RedeemArgs) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 1)
  │   💬 Args: [_supportedAssets, args.tokenOut]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 2)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperAsset.previewRedeem(struct ISuperAsset.PreviewRedeemArgs) (NodeID: 3)
  │   💬 Args: [previewArgs]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: SuperAsset.getAllocationsPrePostOperationRedeem(address,uint256,bool) (NodeID: 4)
  │ │   💬 Args: [args.tokenOut, args.amountSharesToRedeem, args.isSoft]
  │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.length(struct EnumerableSet.AddressSet) (NodeID: 5)
  │ │ │   💬 Args: [_supportedAssets]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 6)
  │ │ │     💬 Args: [set._inner]
  │ │ │     👁️  Def: private
  │ │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 7)
  │ │ │   💬 Args: [_supportedAssets, i]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 8)
  │ │ │     💬 Args: [set._inner, index]
  │ │ │     👁️  Def: private
  │ │ ├─ [3] ⚙️ FUNCTION: SuperAsset.getPriceAndCircuitBreakers(address) (NodeID: 9)
  │ │ │   💬 Args: [s.token]
  │ │ │   👁️  Def: public
  │ │ │ └─ [4] ⚙️ FUNCTION: SuperAssetPriceLib.getPriceWithCircuitBreakers(struct ISuperAsset.PriceArgs) (NodeID: 10)
  │ │ │     💬 Args: [ISuperAsset.PriceArgs({superOracle: superOracle, superAsset: address(this), token: token, usd: USD, depegLowerThreshold: DEPEG_LOWER_THRESHOLD, depegUpperThreshold: DEPEG_UPPER_THRESHOLD, dispersionThreshold: DISPERSION_THRESHOLD})]
  │ │ │     👁️  Def: external
  │ │ │   ├─ [5] ⚙️ FUNCTION: SuperAssetPriceLib._getPriceInfo(contract ISuperOracle,contract ISuperAsset,address,address) (NodeID: 11)
  │ │ │   │   💬 Args: [superOracle, superAsset, args.usd, args.token]
  │ │ │   │   👁️  Def: internal
  │ │ │   │ └─ [6] ⚙️ FUNCTION: SuperAssetPriceLib._derivePriceFromUnderlyingVault(contract ISuperOracle,contract ISuperAsset,address,address,address) (NodeID: 12)
  │ │ │   │     💬 Args: [superOracle, superAsset, USD, token, tokenData.oracle]
  │ │ │   │     👁️  Def: internal
  │ │ │   │   └─ [7] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 13)
  │ │ │   │       💬 Args: [pricePerShare, priceUSD, superAsset.getPrecision(), Math.Rounding.Floor]
  │ │ │   │       👁️  Def: internal
  │ │ │   │     ├─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 14)
  │ │ │   │     │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │   │     │   👁️  Def: internal
  │ │ │   │     │ └─ [9] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 15)
  │ │ │   │     │     💬 Args: [rounding]
  │ │ │   │     │     👁️  Def: internal
  │ │ │   │     └─ [8] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 16)
  │ │ │   │         💬 Args: [x, y, denominator]
  │ │ │   │         👁️  Def: internal
  │ │ │   │       ├─ [9] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 17)
  │ │ │   │       │   💬 Args: [x, y]
  │ │ │   │       │   👁️  Def: internal
  │ │ │   │       └─ [9] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 18)
  │ │ │   │           💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │   │           👁️  Def: internal
  │ │ │   │         └─ [10] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 19)
  │ │ │   │             💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │   │             👁️  Def: internal
  │ │ │   │           └─ [11] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 20)
  │ │ │   │               💬 Args: [condition]
  │ │ │   │               👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SuperAssetPriceLib._getDepegAndDispersion(struct ISuperAsset.PriceArgs,uint256,uint256,uint256) (NodeID: 21)
  │ │ │       💬 Args: [args, precision, priceUSD, stddev]
  │ │ │       👁️  Def: internal
  │ │ │     ├─ [6] ⚙️ FUNCTION: SuperAssetPriceLib._getAssetPriceUSD(address,address,address) (NodeID: 22)
  │ │ │     │   💬 Args: [args.superOracle, args.superAsset, args.usd]
  │ │ │     │   👁️  Def: internal
  │ │ │     ├─ [6] ⚙️ FUNCTION: SuperAssetPriceLib._isTokenDepeg(uint256,uint256,uint256,uint256,uint256) (NodeID: 23)
  │ │ │     │   💬 Args: [priceUSD, precision, assetPriceUSD, args.depegLowerThreshold, args.depegUpperThreshold]
  │ │ │     │   👁️  Def: internal
  │ │ │     │ └─ [7] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 24)
  │ │ │     │     💬 Args: [priceUSD, precision, assetPriceUSD]
  │ │ │     │     👁️  Def: internal
  │ │ │     │   ├─ [8] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 25)
  │ │ │     │   │   💬 Args: [x, y]
  │ │ │     │   │   👁️  Def: internal
  │ │ │     │   └─ [8] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 26)
  │ │ │     │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │     │       👁️  Def: internal
  │ │ │     │     └─ [9] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 27)
  │ │ │     │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │     │         👁️  Def: internal
  │ │ │     │       └─ [10] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 28)
  │ │ │     │           💬 Args: [condition]
  │ │ │     │           👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: SuperAssetPriceLib._isSTDDevDegged(address,uint256,uint256,uint256) (NodeID: 29)
  │ │ │         💬 Args: [args.superAsset, stddev, priceUSD, args.dispersionThreshold]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 30)
  │ │ │           💬 Args: [stddev, ISuperAsset(superAsset).getPrecision(), priceUSD]
  │ │ │           👁️  Def: internal
  │ │ │         ├─ [8] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 31)
  │ │ │         │   💬 Args: [x, y]
  │ │ │         │   👁️  Def: internal
  │ │ │         └─ [8] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 32)
  │ │ │             💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │             👁️  Def: internal
  │ │ │           └─ [9] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 33)
  │ │ │               💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │               👁️  Def: internal
  │ │ │             └─ [10] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 34)
  │ │ │                 💬 Args: [condition]
  │ │ │                 👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 35)
  │ │ │   💬 Args: [s.balances[i], s.oraclePriceUSDs[i], 10 ** s.decimals[i]]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 36)
  │ │ │ │   💬 Args: [x, y]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 37)
  │ │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 38)
  │ │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 39)
  │ │ │         💬 Args: [condition]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 40)
  │ │ │   💬 Args: [no args]
  │ │ │   👁️  Def: public
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 41)
  │ │ │   💬 Args: [s.totalValueUSD, PRECISION, totalSupply_]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 42)
  │ │ │ │   💬 Args: [x, y]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 43)
  │ │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 44)
  │ │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 45)
  │ │ │         💬 Args: [condition]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 46)
  │ │ │   💬 Args: [amountToken, s.superAssetPPS, s.priceUSDToken]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 47)
  │ │ │ │   💬 Args: [x, y]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 48)
  │ │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 49)
  │ │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 50)
  │ │ │         💬 Args: [condition]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 51)
  │ │ │   💬 Args: [ret.amountAssets, 10 ** (DECIMALS - s.decimalsToken), PRECISION]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 52)
  │ │ │ │   💬 Args: [x, y]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 53)
  │ │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 54)
  │ │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 55)
  │ │ │         💬 Args: [condition]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 56)
  │ │ │   💬 Args: [ret.amountAssets, 10 ** (s.decimalsToken - DECIMALS), PRECISION]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 57)
  │ │ │ │   💬 Args: [x, y]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 58)
  │ │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 59)
  │ │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 60)
  │ │ │         💬 Args: [condition]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 61)
  │ │ │   💬 Args: [_supportedAssets, i]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 62)
  │ │ │     💬 Args: [set._inner, index]
  │ │ │     👁️  Def: private
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 63)
  │ │ │   💬 Args: [s.balances[i], s.oraclePriceUSDs[i], 10 ** s.decimals[i]]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 64)
  │ │ │ │   💬 Args: [x, y]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 65)
  │ │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 66)
  │ │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 67)
  │ │ │         💬 Args: [condition]
  │ │ │         👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 68)
  │ │     💬 Args: [s.deltaToken, s.oraclePriceUSDs[i], 10 ** s.decimals[i]]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 69)
  │ │   │   💬 Args: [x, y]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 70)
  │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 71)
  │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 72)
  │ │           💬 Args: [condition]
  │ │           👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 73)
  │     💬 Args: [allocRet.amountAssets, swapFeeOutPercentage, SWAP_FEE_PERC]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 74)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 75)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 76)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 77)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 78)
  │   💬 Args: [no args]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperAsset._settleIncentive(address,int256) (NodeID: 79)
  │   💬 Args: [args.receiver, ret.amountIncentiveUSDRedeem]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ERC20._burn(address,uint256) (NodeID: 80)
      💬 Args: [msg.sender, args.amountSharesToRedeem]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ERC20._update(address,address,uint256) (NodeID: 81)
        💬 Args: [account, address(0), value]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperAsset

### Interface Documentation

@notice Redeems SuperUSD shares for underlying assets from a whitelisted vault.
 @param args The redeem arguments (receiver, amountSharesToRedeem, tokenOut, minTokenOut)
 @return ret The redeem return variables.
