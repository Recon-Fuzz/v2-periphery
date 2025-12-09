# Function: constructor(address,address,address,address,uint256)

**Contract**: [test/mocks/MockMultiTargetHook.sol/contract_MockMultiTargetHook.md]

## Metadata

- **Contract**: MockMultiTargetHook
- **Signature**: `constructor(address,address,address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1470:403:597

## Implementation

```solidity
/// @notice Constructor
///  @param _token The ERC20 token to transfer
///  @param _recipient1 First recipient address
///  @param _recipient2 Second recipient address
///  @param _recipient3 Third recipient address
///  @param _amount Amount to transfer to each recipient
constructor(address _token, address _recipient1, address _recipient2, address _recipient3, uint256 _amount) BaseHook(ISuperHook.HookType.NONACCOUNTING,keccak256("MockMultiTargetHook")) {
    token = _token;
    recipient1 = _recipient1;
    recipient2 = _recipient2;
    recipient3 = _recipient3;
    amount = _amount;
}
```

## Related Implementations

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

- **token** (`address`)
- **recipient1** (`address`)
- **recipient2** (`address`)
- **recipient3** (`address`)
- **amount** (`uint256`)
- **hookType** (`enum ISuperHook.HookType`)
- **SUB_TYPE** (`bytes32`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockMultiTargetHook.constructor(address,address,address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockMultiTargetHook
  └─ [1] 🏗️ CONSTRUCTOR: BaseHook.constructor(enum ISuperHook.HookType,bytes32) (NodeID: 1)
      💬 Args: [ISuperHook.HookType.NONACCOUNTING, keccak256("MockMultiTargetHook")]
      🏗️  Contract: BaseHook
```

## Documentation

### Function Documentation

@notice Constructor
 @param _token The ERC20 token to transfer
 @param _recipient1 First recipient address
 @param _recipient2 Second recipient address
 @param _recipient3 Third recipient address
 @param _amount Amount to transfer to each recipient
