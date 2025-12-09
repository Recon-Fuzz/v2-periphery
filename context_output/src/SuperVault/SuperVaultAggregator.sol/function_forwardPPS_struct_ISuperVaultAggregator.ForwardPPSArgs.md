# Function: forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)

**Contract**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

## Metadata

- **Contract**: SuperVaultAggregator
- **Signature**: `forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs)`
- **Visibility**: external
- **Source Range**: 10324:3045:511

## Implementation

```solidity
/// @inheritdoc ISuperVaultAggregator
function forwardPPS(ForwardPPSArgs calldata args) external onlyPPSOracle() {
    bool paymentsEnabled = SUPER_GOVERNOR.isUpkeepPaymentsEnabled();
    uint256 strategiesLength = args.strategies.length;
    for (uint256 i; i < strategiesLength; ++i) {
        address strategy = args.strategies[i];
        if (!_superVaultStrategies.contains(strategy)) {
            emit UnknownStrategy(strategy);
            continue;
        }
        uint256 ts = args.timestamps[i];
        if (ts > block.timestamp) {
            emit ProvidedTimestampExceedsBlockTimestamp(strategy, ts, block.timestamp);
            continue;
        }
        StrategyData storage data = _strategyData[strategy];
        if (data.isPaused) {
            emit PPSUpdateRejectedStrategyPaused(strategy);
            continue;
        }
        if ((block.timestamp - ts) > data.maxStaleness) {
            emit StaleUpdate(strategy, args.updateAuthority, ts);
            continue;
        }
        uint256 upkeepCost = 0;
        if (paymentsEnabled) {
            try SUPER_GOVERNOR.getUpkeepCostPerSingleUpdate(msg.sender) returns (uint256 cost) {
                upkeepCost = cost;
            } catch {
                upkeepCost = 0;
            }
        }
        _forwardPPS(PPSUpdateData({strategy: strategy, isExempt: upkeepCost == 0, pps: args.ppss[i], timestamp: ts, upkeepCost: upkeepCost}));
    }
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

### _forwardPPS(struct ISuperVaultAggregator.PPSUpdateData)

- **Kind**: internal
- **Source**: 52080:5242:511
- **Link**: `src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator:_forwardPPS(struct ISuperVaultAggregator.PPSUpdateData)`

```solidity
/// @notice Internal implementation of forwarding PPS updates
///  @dev Implements Properties 7-11 from /security/security_properties.md:
///       - Property 7: Timestamp Monotonicity (line 1213)
///       - Property 8: Post-Unpause Timestamp Validation / C1-RE_ANCHOR (line 1222)
///       - Property 9: Rate Limit Enforcement (line 1231)
///       - Property 10: Deviation Threshold / C1 Check (line 1242)
///       - Property 11: Upkeep Balance Check (line 1284)
///  @dev Uses 'return' (not 'revert') for business logic rejections to enable batch processing
///  @dev Auto-pauses strategy and marks PPS stale on validation failures
///  @param args Struct containing all parameters for PPS update
function _forwardPPS(PPSUpdateData memory args) internal {
    uint256 minInterval = _strategyData[args.strategy].minUpdateInterval;
    uint256 lastUpdate = _strategyData[args.strategy].lastUpdateTimestamp;
    if (args.timestamp <= lastUpdate) {
        emit TimestampNotMonotonic();
        return;
    }
    uint256 lastUnpauseTimestamp = _strategyData[args.strategy].lastUnpauseTimestamp;
    if ((lastUnpauseTimestamp > 0) && (args.timestamp <= lastUnpauseTimestamp)) {
        emit StaleSignatureAfterUnpause(args.strategy, args.timestamp, lastUnpauseTimestamp);
        return;
    }
    if ((args.timestamp - lastUpdate) < minInterval) {
        emit UpdateTooFrequent();
        return;
    }
    bool checksFailed;
    uint256 currentPPS = _strategyData[args.strategy].pps;
    if (((_strategyData[args.strategy].deviationThreshold != type(uint256).max) && (currentPPS > 0)) && (!_strategyData[args.strategy].ppsStale)) {
        uint256 absDiff = (args.pps > currentPPS) ? (args.pps - currentPPS) : (currentPPS - args.pps);
        uint256 relativeDeviation = Math.mulDiv(absDiff, 1e18, currentPPS);
        if (relativeDeviation > _strategyData[args.strategy].deviationThreshold) {
            checksFailed = true;
            emit StrategyCheckFailed(args.strategy, "HIGH_PPS_DEVIATION");
        }
    }
    uint256 strategyUpkeepBalance = _strategyUpkeepBalance[args.strategy];
    if (!args.isExempt) {
        if (strategyUpkeepBalance < args.upkeepCost) {
            _strategyData[args.strategy].isPaused = true;
            _strategyData[args.strategy].ppsStale = true;
            emit StrategyPaused(args.strategy);
            emit StrategyPPSStale(args.strategy);
            emit InsufficientUpkeep(args.strategy, args.strategy, strategyUpkeepBalance, args.upkeepCost);
            return;
        }
        _strategyUpkeepBalance[args.strategy] -= args.upkeepCost;
        claimableUpkeep += args.upkeepCost;
        emit UpkeepSpent(args.strategy, args.upkeepCost, strategyUpkeepBalance, claimableUpkeep);
    }
    if ((checksFailed || (args.pps == 0))) {
        _strategyData[args.strategy].isPaused = true;
        _strategyData[args.strategy].ppsStale = true;
        emit StrategyPaused(args.strategy);
        emit StrategyPPSStale(args.strategy);
    } else {
        _strategyData[args.strategy].pps = args.pps;
        _strategyData[args.strategy].lastUpdateTimestamp = args.timestamp;
        if (_strategyData[args.strategy].ppsStale) {
            _strategyData[args.strategy].ppsStale = false;
            emit StrategyPPSStaleReset(args.strategy);
        }
        emit PPSUpdated(args.strategy, args.pps, args.timestamp);
    }
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

### onlyPPSOracle()

- **Kind**: modifier
- **Source**: 4026:69:511
- **Link**: `src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator:onlyPPSOracle()`

```solidity
/// @notice Validates that msg.sender is the active PPS Oracle
modifier onlyPPSOracle() {
    _onlyPPSOracle();
    _;
}
```

### _onlyPPSOracle()

- **Kind**: internal
- **Source**: 4101:164:511
- **Link**: `src/SuperVault/SuperVaultAggregator.sol:SuperVaultAggregator:_onlyPPSOracle()`

```solidity
function _onlyPPSOracle() internal view {
    if (!SUPER_GOVERNOR.isActivePPSOracle(msg.sender)) {
        revert UNAUTHORIZED_PPS_ORACLE();
    }
}
```

## External Calls

- **ISuperGovernor::isUpkeepPaymentsEnabled()**
- **ISuperGovernor::getUpkeepCostPerSingleUpdate(address)**

## State Variable Reads

- **SUPER_GOVERNOR** (`contract ISuperGovernor`) [src/interfaces/ISuperGovernor.sol/interface_ISuperGovernor.md]
- **_superVaultStrategies** (`struct EnumerableSet.AddressSet`)
- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **_strategyUpkeepBalance** (`mapping(address => uint256)`)
- **claimableUpkeep** (`uint256`)

## State Variable Writes

- **_strategyData** (`mapping(address => struct ISuperVaultAggregator.StrategyData)`)
- **_strategyUpkeepBalance** (`mapping(address => uint256)`)
- **claimableUpkeep** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultAggregator.forwardPPS(struct ISuperVaultAggregator.ForwardPPSArgs) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 1)
  │   💬 Args: [_superVaultStrategies, strategy]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 2)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SuperVaultAggregator._forwardPPS(struct ISuperVaultAggregator.PPSUpdateData) (NodeID: 3)
  │   💬 Args: [PPSUpdateData({strategy: strategy, isExempt: upkeepCost == 0, pps: args.ppss[i], timestamp: ts, upkeepCost: upkeepCost})]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 4)
  │     💬 Args: [absDiff, 1e18, currentPPS]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 5)
  │   │   💬 Args: [x, y]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 6)
  │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 7)
  │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 8)
  │           💬 Args: [condition]
  │           👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperVaultAggregator.onlyPPSOracle() (NodeID: 9)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: SuperVaultAggregator._onlyPPSOracle() (NodeID: 10)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperVaultAggregator

### Interface Documentation

@notice Batch forwards validated PPS updates to multiple strategies
 @param args Struct containing all batch PPS update parameters
