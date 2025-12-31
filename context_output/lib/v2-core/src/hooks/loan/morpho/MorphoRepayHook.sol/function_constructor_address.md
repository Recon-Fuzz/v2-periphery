# Function: constructor(address)

**Contract**: [lib/v2-core/src/hooks/loan/morpho/MorphoRepayHook.sol/contract_MorphoRepayHook.md]

## Metadata

- **Contract**: MorphoRepayHook
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2271:261:378

## Implementation

```solidity
constructor(address morpho_) BaseMorphoLoanHook(morpho_,HookSubTypes.LOAN_REPAY) {
    morpho = morpho_;
    morphoBase = IMorphoBase(morpho_);
    morphoInterface = IMorpho(morpho_);
    morphoStaticTyping = IMorphoStaticTyping(morpho_);
}
```

## Related Implementations

### (address,bytes32)

- **Kind**: internal
- **Source**: 1036:192:376
- **Link**: `lib/v2-core/src/hooks/loan/morpho/BaseMorphoLoanHook.sol:BaseMorphoLoanHook:constructor(address,bytes32)`

```solidity
constructor(address morpho_, bytes32 hookSubtype_) BaseLoanHook(hookSubtype_) {
    if (morpho_ == address(0)) revert ADDRESS_NOT_VALID();
    morphoInterface = IMorpho(morpho_);
}
```

### (bytes32)

- **Kind**: internal
- **Source**: 924:84:375
- **Link**: `lib/v2-core/src/hooks/loan/BaseLoanHook.sol:BaseLoanHook:constructor(bytes32)`

```solidity
constructor(bytes32 hookSubtype_) BaseHook(HookType.NONACCOUNTING,hookSubtype_) {}
```

### (enum ISuperHook.HookType,bytes32)

- **Kind**: internal
- **Source**: 4728:127:364
- **Link**: `lib/v2-core/src/hooks/BaseHook.sol:BaseHook:constructor(enum ISuperHook.HookType,bytes32)`

```solidity
/// @notice Initializes the hook with its type and subtype
///  @dev Sets immutable parameters that define the hook's behavior
///  @param hookType_ The type classification for this hook (NONACCOUNTING, INFLOW, OUTFLOW)
///  @param subType_ The specific subtype identifier for specialized hook functionality
constructor(ISuperHook.HookType hookType_, bytes32 subType_) {
    hookType = hookType_;
    SUB_TYPE = subType_;
}
```

## State Variable Writes

- **morpho** (`address`)
- **morphoBase** (`contract IMorphoBase`) [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorphoBase.md]
- **morphoStaticTyping** (`contract IMorphoStaticTyping`) [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorphoStaticTyping.md]
- **morphoInterface** (`contract IMorpho`) [lib/v2-core/src/vendor/morpho/IMorpho.sol/interface_IMorpho.md]
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MorphoRepayHook.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MorphoRepayHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseMorphoLoanHook.constructor(address,bytes32) (NodeID: 1)
      💬 Args: [morpho_, HookSubTypes.LOAN_REPAY]
      🏗️  Contract: BaseMorphoLoanHook
    └─ [2] 🏗️ CONSTRUCTOR: BaseLoanHook.constructor(bytes32) (NodeID: 2)
        💬 Args: [HookSubTypes.LOAN_REPAY]
        🏗️  Contract: BaseLoanHook
      └─ [3] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 3)
          💬 Args: [HookType.NONACCOUNTING, HookSubTypes.LOAN_REPAY]
          🏗️  Contract: BaseHook
```
