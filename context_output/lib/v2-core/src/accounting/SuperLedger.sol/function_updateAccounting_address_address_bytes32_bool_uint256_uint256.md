# Function: updateAccounting(address,address,bytes32,bool,uint256,uint256)

**Contract**: [lib/v2-core/src/accounting/SuperLedger.sol/contract_SuperLedger.md]

## Metadata

- **Contract**: SuperLedger
- **Signature**: `updateAccounting(address,address,bytes32,bool,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 3198:391:351
- **Inherited From**: BaseLedger

## Implementation

```solidity
/// @inheritdoc ISuperLedger
function updateAccounting(address user, address yieldSource, bytes32 yieldSourceOracleId, bool isInflow, uint256 amountSharesOrAssets, uint256 usedShares) external returns (uint256 feeAmount) {
    return _updateAccounting(user, yieldSource, yieldSourceOracleId, isInflow, amountSharesOrAssets, usedShares);
}
```

## Related Implementations

### _updateAccounting(address,address,bytes32,bool,uint256,uint256)

- **Kind**: internal
- **Source**: 11813:1646:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:_updateAccounting(address,address,bytes32,bool,uint256,uint256)`

```solidity
/// @notice Core accounting function that processes inflows and outflows
///  @dev Handles both deposit (inflow) and withdrawal (outflow) accounting:
///       - For inflows: Records new share acquisition with current price
///       - For outflows: Calculates fees based on yield and updates records
///       This is the central function that integrates with oracles for pricing
///       and tracks user positions for accurate yield calculation
///  @param user Address of the user whose accounting is being updated
///  @param yieldSource Address of the yield-bearing asset being processed
///  @param yieldSourceOracleId Identifier for the oracle providing price data
///  @param isInflow True if this is a deposit, false if withdrawal
///  @param amountSharesOrAssets Amount of shares (for inflow) or assets (for outflow)
///  @param usedShares Number of shares consumed (only used for outflows)
///  @return feeAmount The calculated fee amount (zero for inflows)
function _updateAccounting(address user, address yieldSource, bytes32 yieldSourceOracleId, bool isInflow, uint256 amountSharesOrAssets, uint256 usedShares) virtual internal onlyExecutor() returns (uint256 feeAmount) {
    ISuperLedgerConfiguration.YieldSourceOracleConfig memory config = SUPER_LEDGER_CONFIGURATION.getYieldSourceOracleConfig(yieldSourceOracleId);
    if (config.manager == address(0)) revert MANAGER_NOT_SET();
    if (config.ledger != address(this)) revert INVALID_LEDGER();
    uint256 pps = IYieldSourceOracle(config.yieldSourceOracle).getPricePerShare(yieldSource);
    if (pps == 0) revert INVALID_PRICE();
    if (isInflow) {
        _takeSnapshot(user, amountSharesOrAssets, yieldSource, pps, IYieldSourceOracle(config.yieldSourceOracle).decimals(yieldSource));
        emit AccountingInflow(user, config.yieldSourceOracle, yieldSource, amountSharesOrAssets, pps);
    } else {
        uint8 decimals = IYieldSourceOracle(config.yieldSourceOracle).decimals(yieldSource);
        uint256 amountAssets = _getOutflowProcessVolume(amountSharesOrAssets, usedShares, pps, decimals);
        feeAmount = _processOutflow(user, yieldSource, amountAssets, usedShares, config, pps, decimals);
        emit AccountingOutflow(user, config.yieldSourceOracle, yieldSource, amountSharesOrAssets, feeAmount);
        return feeAmount;
    }
}
```

### _takeSnapshot(address,uint256,address,uint256,uint256)

- **Kind**: internal
- **Source**: 5933:372:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:_takeSnapshot(address,uint256,address,uint256,uint256)`

```solidity
/// @notice Records share acquisition in the user's ledger
///  @dev Updates the user's accumulator values when new shares are added
///       Cost basis is calculated using the current price per share
///  @param user Address of the user receiving shares
///  @param amountShares Amount of shares being added to the user's position
///  @param yieldSource Address of the yield-bearing asset
///  @param pps Current price per share of the yield source
///  @param decimals Decimal precision of the yield source
function _takeSnapshot(address user, uint256 amountShares, address yieldSource, uint256 pps, uint256 decimals) virtual internal {
    usersAccumulatorShares[user][yieldSource] += amountShares;
    usersAccumulatorCostBasis[user][yieldSource] += Math.mulDiv(amountShares, pps, 10 ** decimals);
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

### _getOutflowProcessVolume(uint256,uint256,uint256,uint8)

- **Kind**: internal
- **Source**: 6711:247:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:_getOutflowProcessVolume(uint256,uint256,uint256,uint8)`

```solidity
/// @notice Determines the volume to use for outflow fee calculations
///  @dev Can be overridden by derived contracts to implement different volume calculation strategies
///       In the base implementation, simply returns the input amount unchanged
///  @param amountSharesOrAssets The amount of shares or assets being withdrawn
///  @return The volume to use for fee calculations
function _getOutflowProcessVolume(uint256 amountSharesOrAssets, uint256, uint256, uint8) virtual internal pure returns (uint256) {
    return amountSharesOrAssets;
}
```

### _processOutflow(address,address,uint256,uint256,struct ISuperLedgerConfiguration.YieldSourceOracleConfig,uint256,uint8)

- **Kind**: internal
- **Source**: 8808:975:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:_processOutflow(address,address,uint256,uint256,struct ISuperLedgerConfiguration.YieldSourceOracleConfig,uint256,uint8)`

```solidity
/// @notice Processes an outflow operation and calculates associated fees
///  @dev Gets the cost basis for consumed shares and calculates fees on any yield generated
///       Updates user accounting records to reflect the share consumption
///  @param user Address of the user withdrawing shares
///  @param yieldSource Address of the yield-bearing asset
///  @param amountAssets Current value of the shares in asset terms
///  @param usedShares Amount of shares being consumed
///  @param config Configuration for the yield source oracle
///  @param pps Price per share of the yield source
///  @param decimals Decimals of the yield source
///  @return feeAmount The calculated fee amount based on yield generated
function _processOutflow(address user, address yieldSource, uint256 amountAssets, uint256 usedShares, ISuperLedgerConfiguration.YieldSourceOracleConfig memory config, uint256 pps, uint8 decimals) virtual internal returns (uint256 feeAmount) {
    (uint256 costBasis, uint256 updatedUsedShares) = _calculateCostBasis(user, yieldSource, usedShares);
    /// @dev if a user performs a deposit outside superform, his shares were truncated in L87. Likewise we use the
    ///  truncated shares to roll back to the original asset amount that belongs to an action done through superform
    ///  core v2
    if (usedShares != updatedUsedShares) {
        amountAssets = Math.mulDiv(updatedUsedShares, pps, 10 ** decimals);
    }
    if (config.feePercent > 0) {
        feeAmount = _calculateFees(costBasis, amountAssets, config.feePercent);
    }
}
```

### _calculateCostBasis(address,address,uint256)

- **Kind**: internal
- **Source**: 7487:564:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:_calculateCostBasis(address,address,uint256)`

```solidity
/// @notice Calculates and updates the cost basis for consumed shares
///  @dev Retrieves the cost basis for the shares being used and updates the user's accumulators
///       Proportionally reduces both shares and cost basis in the user's accounting records
///  @param user Address of the user consuming shares
///  @param yieldSource Address of the yield-bearing asset
///  @param usedShares Amount of shares being consumed
///  @return costBasis The calculated cost basis for the consumed shares
function _calculateCostBasis(address user, address yieldSource, uint256 usedShares) internal returns (uint256 costBasis, uint256 updatedUsedShares) {
    (costBasis, updatedUsedShares) = calculateCostBasisView(user, yieldSource, usedShares);
    if (updatedUsedShares != usedShares) {
        emit UsedSharesCapped(usedShares, updatedUsedShares);
    }
    usersAccumulatorShares[user][yieldSource] -= updatedUsedShares;
    usersAccumulatorCostBasis[user][yieldSource] -= costBasis;
}
```

### calculateCostBasisView(address,address,uint256)

- **Kind**: internal
- **Source**: 3628:656:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:calculateCostBasisView(address,address,uint256)`

```solidity
/// @inheritdoc ISuperLedger
function calculateCostBasisView(address user, address yieldSource, uint256 usedShares) public view returns (uint256 costBasis, uint256 shares) {
    uint256 accumulatorShares = usersAccumulatorShares[user][yieldSource];
    uint256 accumulatorCostBasis = usersAccumulatorCostBasis[user][yieldSource];
    if (usedShares > accumulatorShares) {
        usedShares = accumulatorShares;
    }
    costBasis = (usedShares > 0) ? Math.mulDiv(accumulatorCostBasis, usedShares, accumulatorShares) : 0;
    shares = usedShares;
}
```

### _calculateFees(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 10351:446:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:_calculateFees(uint256,uint256,uint256)`

```solidity
/// @notice Calculates performance fees based on realized profit
///  @dev Compares current asset value to cost basis to determine profit
///       Applies the fee percentage to any positive profit amount
///       Uses basis points (10,000 = 100%) for fee percentage
///  @param costBasis Original acquisition value of the shares
///  @param amountAssets Current value of the shares in asset terms
///  @param feePercent Fee percentage in basis points (e.g., 1000 = 10%)
///  @return feeAmount The calculated fee amount based on profit
function _calculateFees(uint256 costBasis, uint256 amountAssets, uint256 feePercent) virtual internal pure returns (uint256 feeAmount) {
    uint256 profit = (amountAssets > costBasis) ? (amountAssets - costBasis) : 0;
    if (profit > 0) {
        if (feePercent == 0) revert FEE_NOT_SET();
        feeAmount = Math.mulDiv(profit, feePercent, 10_000);
    }
}
```

### onlyExecutor()

- **Kind**: modifier
- **Source**: 3047:112:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:onlyExecutor()`

```solidity
/// @notice Restricts function access to authorized executors only
///  @dev Checks if the caller is in the allowedExecutors mapping
modifier onlyExecutor() {
    if (!_isExecutorAllowed(msg.sender)) revert NOT_AUTHORIZED();
    _;
}
```

### _isExecutorAllowed(address)

- **Kind**: internal
- **Source**: 13769:125:351
- **Link**: `lib/v2-core/src/accounting/BaseLedger.sol:BaseLedger:_isExecutorAllowed(address)`

```solidity
/// @notice Checks if an address is authorized to execute accounting operations
///  @dev Used by the onlyExecutor modifier to validate caller permissions
///  @param executor Address to check for executor permissions
///  @return True if the address is an allowed executor, false otherwise
function _isExecutorAllowed(address executor) internal view returns (bool) {
    return allowedExecutors[executor];
}
```

## External Calls

- **ISuperLedgerConfiguration::getYieldSourceOracleConfig(bytes32)**
- **IYieldSourceOracle::getPricePerShare(address)**
- **IYieldSourceOracle::decimals(address)**

## State Variable Reads

- **SUPER_LEDGER_CONFIGURATION** (`contract ISuperLedgerConfiguration`) [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]
- **usersAccumulatorShares** (`mapping(address => mapping(address => uint256))`)
- **usersAccumulatorCostBasis** (`mapping(address => mapping(address => uint256))`)
- **allowedExecutors** (`mapping(address => bool)`)

## State Variable Writes

- **usersAccumulatorShares** (`mapping(address => mapping(address => uint256))`)
- **usersAccumulatorCostBasis** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BaseLedger.updateAccounting(address,address,bytes32,bool,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BaseLedger._updateAccounting(address,address,bytes32,bool,uint256,uint256) (NodeID: 1)
      💬 Args: [user, yieldSource, yieldSourceOracleId, isInflow, amountSharesOrAssets, usedShares]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseLedger._takeSnapshot(address,uint256,address,uint256,uint256) (NodeID: 2)
    │   💬 Args: [user, amountSharesOrAssets, yieldSource, pps, IYieldSourceOracle(config.yieldSourceOracle).decimals(yieldSource)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 3)
    │     💬 Args: [amountShares, pps, 10 ** decimals]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 4)
    │   │   💬 Args: [x, y]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 5)
    │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 6)
    │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 7)
    │           💬 Args: [condition]
    │           👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseLedger._getOutflowProcessVolume(uint256,uint256,uint256,uint8) (NodeID: 8)
    │   💬 Args: [amountSharesOrAssets, usedShares, pps, decimals]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: BaseLedger._processOutflow(address,address,uint256,uint256,struct ISuperLedgerConfiguration.YieldSourceOracleConfig,uint256,uint8) (NodeID: 9)
    │   💬 Args: [user, yieldSource, amountAssets, usedShares, config, pps, decimals]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: BaseLedger._calculateCostBasis(address,address,uint256) (NodeID: 10)
    │ │   💬 Args: [user, yieldSource, usedShares]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: BaseLedger.calculateCostBasisView(address,address,uint256) (NodeID: 11)
    │ │     💬 Args: [user, yieldSource, usedShares]
    │ │     👁️  Def: public
    │ │   └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 12)
    │ │       💬 Args: [accumulatorCostBasis, usedShares, accumulatorShares]
    │ │       👁️  Def: internal
    │ │     ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 13)
    │ │     │   💬 Args: [x, y]
    │ │     │   👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 14)
    │ │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
    │ │         👁️  Def: internal
    │ │       └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 15)
    │ │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
    │ │           👁️  Def: internal
    │ │         └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 16)
    │ │             💬 Args: [condition]
    │ │             👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 17)
    │ │   💬 Args: [updatedUsedShares, pps, 10 ** decimals]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 18)
    │ │ │   💬 Args: [x, y]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 19)
    │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
    │ │     👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 20)
    │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 21)
    │ │         💬 Args: [condition]
    │ │         👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: BaseLedger._calculateFees(uint256,uint256,uint256) (NodeID: 22)
    │     💬 Args: [costBasis, amountAssets, config.feePercent]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 23)
    │       💬 Args: [profit, feePercent, 10_000]
    │       👁️  Def: internal
    │     ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 24)
    │     │   💬 Args: [x, y]
    │     │   👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 25)
    │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
    │         👁️  Def: internal
    │       └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 26)
    │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
    │           👁️  Def: internal
    │         └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 27)
    │             💬 Args: [condition]
    │             👁️  Def: internal
    └─ [2] 🔒 MODIFIER: BaseLedger.onlyExecutor() (NodeID: 28)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: BaseLedger._isExecutorAllowed(address) (NodeID: 29)
          💬 Args: [msg.sender]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperLedger

### Interface Documentation

@notice Updates accounting for a user's yield source interaction
 @dev For inflows, records new shares at current price; for outflows, calculates fees based on profit
      Only authorized executors can call this function
      For outflows, the fee is calculated as a percentage of the profit:
      profit = (current_value - cost_basis) where current_value is based on oracle price
 @param user The user address whose accounting is being updated
 @param yieldSource The yield source address (e.g. aUSDC, cUSDC, etc.)
 @param yieldSourceOracleId ID for looking up the oracle configuration for this yield source
 @param isInflow Whether this is an inflow (true) or outflow (false)
 @param amountSharesOrAssets The amount of shares (for inflow) or assets (for outflow)
 @param usedShares The amount of shares used for outflow calculation (0 for inflows)
 @return feeAmount The amount of fee to be collected in the asset being withdrawn (0 for inflows)
