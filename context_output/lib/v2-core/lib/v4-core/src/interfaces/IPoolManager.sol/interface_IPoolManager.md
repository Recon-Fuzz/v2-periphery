# Interface: IPoolManager

## Metadata

- **Name**: IPoolManager
- **Type**: Interface
- **Path**: lib/v2-core/lib/v4-core/src/interfaces/IPoolManager.sol
- **Documentation**: @notice Interface for the PoolManager

## Implements Interfaces

- **IExttload** [lib/v2-core/lib/v4-core/src/interfaces/IExttload.sol/interface_IExttload.md]
- **IExtsload** [lib/v2-core/lib/v4-core/src/interfaces/IExtsload.sol/interface_IExtsload.md]
- **IERC6909Claims** [lib/v2-core/lib/v4-core/src/interfaces/external/IERC6909Claims.sol/interface_IERC6909Claims.md]
- **IProtocolFees** [lib/v2-core/lib/v4-core/src/interfaces/IProtocolFees.sol/interface_IProtocolFees.md]

## Structs

### ModifyLiquidityParams

```solidity
struct ModifyLiquidityParams {
    int24 tickLower;
    int24 tickUpper;
    int256 liquidityDelta;
    bytes32 salt;
}
```

### SwapParams

```solidity
struct SwapParams {
    bool zeroForOne;
    int256 amountSpecified;
    uint160 sqrtPriceLimitX96;
}
```

## Errors

### ProtocolFeeTooLarge (inherited from IProtocolFees)

```solidity
/// @notice Thrown when protocol fee is set too high
error ProtocolFeeTooLarge(uint24 fee);
```

### InvalidCaller (inherited from IProtocolFees)

```solidity
/// @notice Thrown when collectProtocolFees or setProtocolFee is not called by the controller.
error InvalidCaller();
```

### ProtocolFeeCurrencySynced (inherited from IProtocolFees)

```solidity
/// @notice Thrown when collectProtocolFees is attempted on a token that is synced.
error ProtocolFeeCurrencySynced();
```

### CurrencyNotSettled

```solidity
/// @notice Thrown when a currency is not netted out after the contract is unlocked
error CurrencyNotSettled();
```

### PoolNotInitialized

```solidity
/// @notice Thrown when trying to interact with a non-initialized pool
error PoolNotInitialized();
```

### AlreadyUnlocked

```solidity
/// @notice Thrown when unlock is called, but the contract is already unlocked
error AlreadyUnlocked();
```

### ManagerLocked

```solidity
/// @notice Thrown when a function is called that requires the contract to be unlocked, but it is not
error ManagerLocked();
```

### TickSpacingTooLarge

```solidity
/// @notice Pools are limited to type(int16).max tickSpacing in #initialize, to prevent overflow
error TickSpacingTooLarge(int24 tickSpacing);
```

### TickSpacingTooSmall

```solidity
/// @notice Pools must have a positive non-zero tickSpacing passed to #initialize
error TickSpacingTooSmall(int24 tickSpacing);
```

### CurrenciesOutOfOrderOrEqual

```solidity
/// @notice PoolKey must have currencies where address(currency0) < address(currency1)
error CurrenciesOutOfOrderOrEqual(address currency0, address currency1);
```

### UnauthorizedDynamicLPFeeUpdate

```solidity
/// @notice Thrown when a call to updateDynamicLPFee is made by an address that is not the hook,
///  or on a pool that does not have a dynamic swap fee.
error UnauthorizedDynamicLPFeeUpdate();
```

### SwapAmountCannotBeZero

```solidity
/// @notice Thrown when trying to swap amount of 0
error SwapAmountCannotBeZero();
```

### NonzeroNativeValue

```solidity
/// @notice Thrown when native currency is passed to a non native settlement
error NonzeroNativeValue();
```

### MustClearExactPositiveDelta

```solidity
/// @notice Thrown when `clear` is called with an amount that is not exactly equal to the open currency delta.
error MustClearExactPositiveDelta();
```

## Events

### ProtocolFeeControllerUpdated (inherited from IProtocolFees)

```solidity
/// @notice Emitted when the protocol fee controller address is updated in setProtocolFeeController.
event ProtocolFeeControllerUpdated(address indexed protocolFeeController);
```

### ProtocolFeeUpdated (inherited from IProtocolFees)

```solidity
/// @notice Emitted when the protocol fee is updated for a pool.
event ProtocolFeeUpdated(PoolId indexed id, uint24 protocolFee);
```

### OperatorSet (inherited from IERC6909Claims)

```solidity
event OperatorSet(address indexed owner, address indexed operator, bool approved);
```

### Approval (inherited from IERC6909Claims)

```solidity
event Approval(address indexed owner, address indexed spender, uint256 indexed id, uint256 amount);
```

### Transfer (inherited from IERC6909Claims)

```solidity
event Transfer(address caller, address indexed from, address indexed to, uint256 indexed id, uint256 amount);
```

### Initialize

```solidity
/// @notice Emitted when a new pool is initialized
///  @param id The abi encoded hash of the pool key struct for the new pool
///  @param currency0 The first currency of the pool by address sort order
///  @param currency1 The second currency of the pool by address sort order
///  @param fee The fee collected upon every swap in the pool, denominated in hundredths of a bip
///  @param tickSpacing The minimum number of ticks between initialized ticks
///  @param hooks The hooks contract address for the pool, or address(0) if none
///  @param sqrtPriceX96 The price of the pool on initialization
///  @param tick The initial tick of the pool corresponding to the initialized price
event Initialize(PoolId indexed id, Currency indexed currency0, Currency indexed currency1, uint24 fee, int24 tickSpacing, IHooks hooks, uint160 sqrtPriceX96, int24 tick);
```

### ModifyLiquidity

```solidity
/// @notice Emitted when a liquidity position is modified
///  @param id The abi encoded hash of the pool key struct for the pool that was modified
///  @param sender The address that modified the pool
///  @param tickLower The lower tick of the position
///  @param tickUpper The upper tick of the position
///  @param liquidityDelta The amount of liquidity that was added or removed
///  @param salt The extra data to make positions unique
event ModifyLiquidity(PoolId indexed id, address indexed sender, int24 tickLower, int24 tickUpper, int256 liquidityDelta, bytes32 salt);
```

### Swap

```solidity
/// @notice Emitted for swaps between currency0 and currency1
///  @param id The abi encoded hash of the pool key struct for the pool that was modified
///  @param sender The address that initiated the swap call, and that received the callback
///  @param amount0 The delta of the currency0 balance of the pool
///  @param amount1 The delta of the currency1 balance of the pool
///  @param sqrtPriceX96 The sqrt(price) of the pool after the swap, as a Q64.96
///  @param liquidity The liquidity of the pool after the swap
///  @param tick The log base 1.0001 of the price of the pool after the swap
///  @param fee The swap fee in hundredths of a bip
event Swap(PoolId indexed id, address indexed sender, int128 amount0, int128 amount1, uint160 sqrtPriceX96, uint128 liquidity, int24 tick, uint24 fee);
```

### Donate

```solidity
/// @notice Emitted for donations
///  @param id The abi encoded hash of the pool key struct for the pool that was donated to
///  @param sender The address that initiated the donate call
///  @param amount0 The amount donated in currency0
///  @param amount1 The amount donated in currency1
event Donate(PoolId indexed id, address indexed sender, uint256 amount0, uint256 amount1);
```

## Public/External Functions

### unlock(bytes)

- **Signature**: `unlock(bytes)`
- **Visibility**: external
- **Source Range**: 5579:69:328

**Signature:**
```solidity
/// @notice All interactions on the contract that account deltas require unlocking. A caller that calls `unlock` must implement
///  `IUnlockCallback(msg.sender).unlockCallback(data)`, where they interact with the remaining functions on this contract.
///  @dev The only functions callable without an unlocking are `initialize` and `updateDynamicLPFee`
///  @param data Any data to pass to the callback, via `IUnlockCallback(msg.sender).unlockCallback(data)`
///  @return The data returned by the call to `IUnlockCallback(msg.sender).unlockCallback(data)`
function unlock(bytes calldata data) external returns (bytes memory);;
```

### initialize(struct PoolKey,uint160)

- **Signature**: `initialize(struct PoolKey,uint160)`
- **Visibility**: external
- **Source Range**: 6015:92:328

**Signature:**
```solidity
/// @notice Initialize the state for a given pool ID
///  @dev A swap fee totaling MAX_SWAP_FEE (100%) makes exact output swaps impossible since the input is entirely consumed by the fee
///  @param key The pool key for the pool to initialize
///  @param sqrtPriceX96 The initial square root price
///  @return tick The initial tick of the pool
function initialize(PoolKey memory key, uint160 sqrtPriceX96) external returns (int24 tick);;
```

### modifyLiquidity(struct PoolKey,struct IPoolManager.ModifyLiquidityParams,bytes)

- **Signature**: `modifyLiquidity(struct PoolKey,struct IPoolManager.ModifyLiquidityParams,bytes)`
- **Visibility**: external
- **Source Range**: 7422:193:328

**Signature:**
```solidity
/// @notice Modify the liquidity for the given pool
///  @dev Poke by calling with a zero liquidityDelta
///  @param key The pool to modify liquidity in
///  @param params The parameters for modifying the liquidity
///  @param hookData The data to pass through to the add/removeLiquidity hooks
///  @return callerDelta The balance delta of the caller of modifyLiquidity. This is the total of both principal, fee deltas, and hook deltas if applicable
///  @return feesAccrued The balance delta of the fees generated in the liquidity range. Returned for informational purposes
///  @dev Note that feesAccrued can be artificially inflated by a malicious actor and integrators should be careful using the value
///  For pools with a single liquidity position, actors can donate to themselves to inflate feeGrowthGlobal (and consequently feesAccrued)
///  atomically donating and collecting fees in the same unlockCallback may make the inflated value more extreme
function modifyLiquidity(PoolKey memory key, ModifyLiquidityParams memory params, bytes calldata hookData) external returns (BalanceDelta callerDelta, BalanceDelta feesAccrued);;
```

### swap(struct PoolKey,struct IPoolManager.SwapParams,bytes)

- **Signature**: `swap(struct PoolKey,struct IPoolManager.SwapParams,bytes)`
- **Visibility**: external
- **Source Range**: 8642:143:328

**Signature:**
```solidity
/// @notice Swap against the given pool
///  @param key The pool to swap in
///  @param params The parameters for swapping
///  @param hookData The data to pass through to the swap hooks
///  @return swapDelta The balance delta of the address swapping
///  @dev Swapping on low liquidity pools may cause unexpected swap amounts when liquidity available is less than amountSpecified.
///  Additionally note that if interacting with hooks that have the BEFORE_SWAP_RETURNS_DELTA_FLAG or AFTER_SWAP_RETURNS_DELTA_FLAG
///  the hook may alter the swap input/output. Integrators should perform checks on the returned swapDelta.
function swap(PoolKey memory key, SwapParams memory params, bytes calldata hookData) external returns (BalanceDelta swapDelta);;
```

### donate(struct PoolKey,uint256,uint256,bytes)

- **Signature**: `donate(struct PoolKey,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 9848:143:328

**Signature:**
```solidity
/// @notice Donate the given currency amounts to the in-range liquidity providers of a pool
///  @dev Calls to donate can be frontrun adding just-in-time liquidity, with the aim of receiving a portion donated funds.
///  Donors should keep this in mind when designing donation mechanisms.
///  @dev This function donates to in-range LPs at slot0.tick. In certain edge-cases of the swap algorithm, the `sqrtPrice` of
///  a pool can be at the lower boundary of tick `n`, but the `slot0.tick` of the pool is already `n - 1`. In this case a call to
///  `donate` would donate to tick `n - 1` (slot0.tick) not tick `n` (getTickAtSqrtPrice(slot0.sqrtPriceX96)).
///  Read the comments in `Pool.swap()` for more information about this.
///  @param key The key of the pool to donate to
///  @param amount0 The amount of currency0 to donate
///  @param amount1 The amount of currency1 to donate
///  @param hookData The data to pass through to the donate hooks
///  @return BalanceDelta The delta of the caller after the donate
function donate(PoolKey memory key, uint256 amount0, uint256 amount1, bytes calldata hookData) external returns (BalanceDelta);;
```

### sync(Currency)

- **Signature**: `sync(Currency)`
- **Visibility**: external
- **Source Range**: 10607:42:328

**Signature:**
```solidity
/// @notice Writes the current ERC20 balance of the specified currency to transient storage
///  This is used to checkpoint balances for the manager and derive deltas for the caller.
///  @dev This MUST be called before any ERC20 tokens are sent into the contract, but can be skipped
///  for native tokens because the amount to settle is determined by the sent value.
///  However, if an ERC20 token has been synced and not settled, and the caller instead wants to settle
///  native funds, this function can be called with the native currency to then be able to settle the native currency
function sync(Currency currency) external;;
```

### take(Currency,address,uint256)

- **Signature**: `take(Currency,address,uint256)`
- **Visibility**: external
- **Source Range**: 11065:70:328

**Signature:**
```solidity
/// @notice Called by the user to net out some value owed to the user
///  @dev Will revert if the requested amount is not available, consider using `mint` instead
///  @dev Can also be used as a mechanism for free flash loans
///  @param currency The currency to withdraw from the pool manager
///  @param to The address to withdraw to
///  @param amount The amount of currency to withdraw
function take(Currency currency, address to, uint256 amount) external;;
```

### settle()

- **Signature**: `settle()`
- **Visibility**: external
- **Source Range**: 11248:58:328

**Signature:**
```solidity
/// @notice Called by the user to pay what is owed
///  @return paid The amount of currency settled
function settle() external payable returns (uint256 paid);;
```

### settleFor(address)

- **Signature**: `settleFor(address)`
- **Visibility**: external
- **Source Range**: 11498:78:328

**Signature:**
```solidity
/// @notice Called by the user to pay on behalf of another address
///  @param recipient The address to credit for the payment
///  @return paid The amount of currency settled
function settleFor(address recipient) external payable returns (uint256 paid);;
```

### clear(Currency,uint256)

- **Signature**: `clear(Currency,uint256)`
- **Visibility**: external
- **Source Range**: 12012:59:328

**Signature:**
```solidity
/// @notice WARNING - Any currency that is cleared, will be non-retrievable, and locked in the contract permanently.
///  A call to clear will zero out a positive balance WITHOUT a corresponding transfer.
///  @dev This could be used to clear a balance that is considered dust.
///  Additionally, the amount must be the exact positive balance. This is to enforce that the caller is aware of the amount being cleared.
function clear(Currency currency, uint256 amount) external;;
```

### mint(address,uint256,uint256)

- **Signature**: `mint(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 12470:63:328

**Signature:**
```solidity
/// @notice Called by the user to move value into ERC6909 balance
///  @param to The address to mint the tokens to
///  @param id The currency address to mint to ERC6909s, as a uint256
///  @param amount The amount of currency to mint
///  @dev The id is converted to a uint160 to correspond to a currency address
///  If the upper 12 bytes are not 0, they will be 0-ed out
function mint(address to, uint256 id, uint256 amount) external;;
```

### burn(address,uint256,uint256)

- **Signature**: `burn(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 12938:65:328

**Signature:**
```solidity
/// @notice Called by the user to move value from ERC6909 balance
///  @param from The address to burn the tokens from
///  @param id The currency address to burn from ERC6909s, as a uint256
///  @param amount The amount of currency to burn
///  @dev The id is converted to a uint160 to correspond to a currency address
///  If the upper 12 bytes are not 0, they will be 0-ed out
function burn(address from, uint256 id, uint256 amount) external;;
```

### updateDynamicLPFee(struct PoolKey,uint24)

- **Signature**: `updateDynamicLPFee(struct PoolKey,uint24)`
- **Visibility**: external
- **Source Range**: 13365:81:328

**Signature:**
```solidity
/// @notice Updates the pools lp fees for the a pool that has enabled dynamic lp fees.
///  @dev A swap fee totaling MAX_SWAP_FEE (100%) makes exact output swaps impossible since the input is entirely consumed by the fee
///  @param key The key of the pool to update dynamic LP fees for
///  @param newDynamicLPFee The new dynamic pool LP fee
function updateDynamicLPFee(PoolKey memory key, uint24 newDynamicLPFee) external;;
```

### protocolFeesAccrued(Currency) (inherited from IProtocolFees)

- **Signature**: `protocolFeesAccrued(Currency)`
- **Visibility**: external
- **Source Range**: 1201:87:329

**Signature:**
```solidity
/// @notice Given a currency address, returns the protocol fees accrued in that currency
///  @param currency The currency to check
///  @return amount The amount of protocol fees accrued in the currency
function protocolFeesAccrued(Currency currency) external view returns (uint256 amount);;
```

### setProtocolFee(struct PoolKey,uint24) (inherited from IProtocolFees)

- **Signature**: `setProtocolFee(struct PoolKey,uint24)`
- **Visibility**: external
- **Source Range**: 1461:76:329

**Signature:**
```solidity
/// @notice Sets the protocol fee for the given pool
///  @param key The key of the pool to set a protocol fee for
///  @param newProtocolFee The fee to set
function setProtocolFee(PoolKey memory key, uint24 newProtocolFee) external;;
```

### setProtocolFeeController(address) (inherited from IProtocolFees)

- **Signature**: `setProtocolFeeController(address)`
- **Visibility**: external
- **Source Range**: 1650:63:329

**Signature:**
```solidity
/// @notice Sets the protocol fee controller
///  @param controller The new protocol fee controller
function setProtocolFeeController(address controller) external;;
```

### collectProtocolFees(address,Currency,uint256) (inherited from IProtocolFees)

- **Signature**: `collectProtocolFees(address,Currency,uint256)`
- **Visibility**: external
- **Source Range**: 2137:142:329

**Signature:**
```solidity
/// @notice Collects the protocol fees for a given recipient and currency, returning the amount collected
///  @dev This will revert if the contract is unlocked
///  @param recipient The address to receive the protocol fees
///  @param currency The currency to withdraw
///  @param amount The amount of currency to withdraw
///  @return amountCollected The amount of currency successfully withdrawn
function collectProtocolFees(address recipient, Currency currency, uint256 amount) external returns (uint256 amountCollected);;
```

### protocolFeeController() (inherited from IProtocolFees)

- **Signature**: `protocolFeeController()`
- **Visibility**: external
- **Source Range**: 2421:65:329

**Signature:**
```solidity
/// @notice Returns the current protocol fee controller address
///  @return address The current protocol fee controller address
function protocolFeeController() external view returns (address);;
```

### balanceOf(address,uint256) (inherited from IERC6909Claims)

- **Signature**: `balanceOf(address,uint256)`
- **Visibility**: external
- **Source Range**: 1011:85:332

**Signature:**
```solidity
/// @notice Owner balance of an id.
///  @param owner The address of the owner.
///  @param id The id of the token.
///  @return amount The balance of the token.
function balanceOf(address owner, uint256 id) external view returns (uint256 amount);;
```

### allowance(address,address,uint256) (inherited from IERC6909Claims)

- **Signature**: `allowance(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 1334:102:332

**Signature:**
```solidity
/// @notice Spender allowance of an id.
///  @param owner The address of the owner.
///  @param spender The address of the spender.
///  @param id The id of the token.
///  @return amount The allowance of the token.
function allowance(address owner, address spender, uint256 id) external view returns (uint256 amount);;
```

### isOperator(address,address) (inherited from IERC6909Claims)

- **Signature**: `isOperator(address,address)`
- **Visibility**: external
- **Source Range**: 1661:90:332

**Signature:**
```solidity
/// @notice Checks if a spender is approved by an owner as an operator
///  @param owner The address of the owner.
///  @param spender The address of the spender.
///  @return approved The approval status.
function isOperator(address owner, address spender) external view returns (bool approved);;
```

### transfer(address,uint256,uint256) (inherited from IERC6909Claims)

- **Signature**: `transfer(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2035:88:332

**Signature:**
```solidity
/// @notice Transfers an amount of an id from the caller to a receiver.
///  @param receiver The address of the receiver.
///  @param id The id of the token.
///  @param amount The amount of the token.
///  @return bool True, always, unless the function reverts
function transfer(address receiver, uint256 id, uint256 amount) external returns (bool);;
```

### transferFrom(address,address,uint256,uint256) (inherited from IERC6909Claims)

- **Signature**: `transferFrom(address,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2454:108:332

**Signature:**
```solidity
/// @notice Transfers an amount of an id from a sender to a receiver.
///  @param sender The address of the sender.
///  @param receiver The address of the receiver.
///  @param id The id of the token.
///  @param amount The amount of the token.
///  @return bool True, always, unless the function reverts
function transferFrom(address sender, address receiver, uint256 id, uint256 amount) external returns (bool);;
```

### approve(address,uint256,uint256) (inherited from IERC6909Claims)

- **Signature**: `approve(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2797:86:332

**Signature:**
```solidity
/// @notice Approves an amount of an id to a spender.
///  @param spender The address of the spender.
///  @param id The id of the token.
///  @param amount The amount of the token.
///  @return bool True, always
function approve(address spender, uint256 id, uint256 amount) external returns (bool);;
```

### setOperator(address,bool) (inherited from IERC6909Claims)

- **Signature**: `setOperator(address,bool)`
- **Visibility**: external
- **Source Range**: 3081:78:332

**Signature:**
```solidity
/// @notice Sets or removes an operator for the caller.
///  @param operator The address of the operator.
///  @param approved The approval status.
///  @return bool True, always
function setOperator(address operator, bool approved) external returns (bool);;
```

### extsload(bytes32) (inherited from IExtsload)

- **Signature**: `extsload(bytes32)`
- **Visibility**: external
- **Source Range**: 331:70:325

**Signature:**
```solidity
/// @notice Called by external contracts to access granular pool state
///  @param slot Key of slot to sload
///  @return value The value of the slot as bytes32
function extsload(bytes32 slot) external view returns (bytes32 value);;
```

### extsload(bytes32,uint256) (inherited from IExtsload)

- **Signature**: `extsload(bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 652:101:325

**Signature:**
```solidity
/// @notice Called by external contracts to access granular pool state
///  @param startSlot Key of slot to start sloading from
///  @param nSlots Number of slots to load into return value
///  @return values List of loaded values.
function extsload(bytes32 startSlot, uint256 nSlots) external view returns (bytes32[] memory values);;
```

### extsload(bytes32[]) (inherited from IExtsload)

- **Signature**: `extsload(bytes32[])`
- **Visibility**: external
- **Source Range**: 928:92:325

**Signature:**
```solidity
/// @notice Called by external contracts to access sparse pool state
///  @param slots List of slots to SLOAD from.
///  @return values List of loaded values.
function extsload(bytes32[] calldata slots) external view returns (bytes32[] memory values);;
```

### exttload(bytes32) (inherited from IExttload)

- **Signature**: `exttload(bytes32)`
- **Visibility**: external
- **Source Range**: 356:70:326

**Signature:**
```solidity
/// @notice Called by external contracts to access transient storage of the contract
///  @param slot Key of slot to tload
///  @return value The value of the slot as bytes32
function exttload(bytes32 slot) external view returns (bytes32 value);;
```

### exttload(bytes32[]) (inherited from IExttload)

- **Signature**: `exttload(bytes32[])`
- **Visibility**: external
- **Source Range**: 604:92:326

**Signature:**
```solidity
/// @notice Called by external contracts to access sparse transient pool state
///  @param slots List of slots to tload
///  @return values List of loaded values
function exttload(bytes32[] calldata slots) external view returns (bytes32[] memory values);;
```
