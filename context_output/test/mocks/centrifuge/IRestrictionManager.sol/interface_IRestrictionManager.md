# Interface: IRestrictionManager

## Metadata

- **Name**: IRestrictionManager
- **Type**: Interface
- **Path**: test/mocks/centrifuge/IRestrictionManager.sol

## Events

### UpdateMember

```solidity
event UpdateMember(address indexed token, address indexed user, uint64 validUntil);
```

### Freeze

```solidity
event Freeze(address indexed token, address indexed user);
```

### Unfreeze

```solidity
event Unfreeze(address indexed token, address indexed user);
```

## Public/External Functions

### freeze(address,address)

- **Signature**: `freeze(address,address)`
- **Visibility**: external
- **Source Range**: 541:54:618

**Signature:**
```solidity
/// @notice Freeze a user balance. Frozen users cannot receive nor send tokens
function freeze(address token, address user) external;;
```

### unfreeze(address,address)

- **Signature**: `unfreeze(address,address)`
- **Visibility**: external
- **Source Range**: 641:56:618

**Signature:**
```solidity
/// @notice Unfreeze a user balance
function unfreeze(address token, address user) external;;
```

### isFrozen(address,address)

- **Signature**: `isFrozen(address,address)`
- **Visibility**: external
- **Source Range**: 764:76:618

**Signature:**
```solidity
/// @notice Returns whether the user's tokens are frozen
function isFrozen(address token, address user) external view returns (bool);;
```

### updateMember(address,address,uint64)

- **Signature**: `updateMember(address,address,uint64)`
- **Visibility**: external
- **Source Range**: 1061:79:618

**Signature:**
```solidity
/// @notice Add a member. Non-members cannot receive tokens, but can send tokens to valid members
///  @param  validUntil Timestamp until which the user will be a valid member
function updateMember(address token, address user, uint64 validUntil) external;;
```

### isMember(address,address)

- **Signature**: `isMember(address,address)`
- **Visibility**: external
- **Source Range**: 1218:103:618

**Signature:**
```solidity
/// @notice Returns whether the user is a valid member of the token
function isMember(address token, address user) external view returns (bool isValid, uint64 validUntil);;
```
