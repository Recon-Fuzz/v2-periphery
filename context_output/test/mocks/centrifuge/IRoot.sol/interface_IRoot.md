# Interface: IRoot

## Metadata

- **Name**: IRoot
- **Type**: Interface
- **Path**: test/mocks/centrifuge/IRoot.sol

## Implements Interfaces

- **IMessageHandler** [test/mocks/centrifuge/IMessageHandler.sol/interface_IMessageHandler.md]

## Events

### File

```solidity
event File(bytes32 indexed what, uint256 data);
```

### Pause

```solidity
event Pause();
```

### Unpause

```solidity
event Unpause();
```

### ScheduleRely

```solidity
event ScheduleRely(address indexed target, uint256 indexed scheduledTime);
```

### CancelRely

```solidity
event CancelRely(address indexed target);
```

### RelyContract

```solidity
event RelyContract(address indexed target, address indexed user);
```

### DenyContract

```solidity
event DenyContract(address indexed target, address indexed user);
```

### RecoverTokens

```solidity
event RecoverTokens(address indexed target, address indexed token, address indexed to, uint256 amount);
```

### Endorse

```solidity
event Endorse(address indexed user);
```

### Veto

```solidity
event Veto(address indexed user);
```

## Public/External Functions

### paused()

- **Signature**: `paused()`
- **Visibility**: external
- **Source Range**: 1257:47:620

**Signature:**
```solidity
/// @notice Returns whether the root is paused
function paused() external view returns (bool);;
```

### delay()

- **Signature**: `delay()`
- **Visibility**: external
- **Source Range**: 1376:49:620

**Signature:**
```solidity
/// @notice Returns the current timelock for adding new wards
function delay() external view returns (uint256);;
```

### endorsements(address)

- **Signature**: `endorsements(address)`
- **Visibility**: external
- **Source Range**: 1483:70:620

**Signature:**
```solidity
/// @notice Trusted contracts within the system
function endorsements(address target) external view returns (uint256);;
```

### schedule(address)

- **Signature**: `schedule(address)`
- **Visibility**: external
- **Source Range**: 1625:80:620

**Signature:**
```solidity
/// @notice Returns when `relyTarget` has passed the timelock
function schedule(address relyTarget) external view returns (uint256 timestamp);;
```

### file(bytes32,uint256)

- **Signature**: `file(bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 1850:51:620

**Signature:**
```solidity
/// @notice Updates a contract parameter
///  @param what Accepts a bytes32 representation of 'delay'
function file(bytes32 what, uint256 data) external;;
```

### endorse(address)

- **Signature**: `endorse(address)`
- **Visibility**: external
- **Source Range**: 2302:40:620

**Signature:**
```solidity
/// --- Endorsements ---
///  @notice Endorses the `user`
///  @dev    Endorsed users are trusted contracts in the system. They are allowed to bypass
///          token restrictions (e.g. the Escrow can automatically receive tranche tokens by being endorsed), and
///          can automatically set operators in ERC-7540 vaults (e.g. the CentrifugeRouter) is always an operator.
function endorse(address user) external;;
```

### veto(address)

- **Signature**: `veto(address)`
- **Visibility**: external
- **Source Range**: 2390:37:620

**Signature:**
```solidity
/// @notice Removes the endorsed user
function veto(address user) external;;
```

### endorsed(address)

- **Signature**: `endorsed(address)`
- **Visibility**: external
- **Source Range**: 2486:61:620

**Signature:**
```solidity
/// @notice Returns whether the user is endorsed
function endorsed(address user) external view returns (bool);;
```

### pause()

- **Signature**: `pause()`
- **Visibility**: external
- **Source Range**: 2652:26:620

**Signature:**
```solidity
/// @notice Pause any contracts that depend on `Root.paused()`
function pause() external;;
```

### unpause()

- **Signature**: `unpause()`
- **Visibility**: external
- **Source Range**: 2753:28:620

**Signature:**
```solidity
/// @notice Unpause any contracts that depend on `Root.paused()`
function unpause() external;;
```

### scheduleRely(address)

- **Signature**: `scheduleRely(address)`
- **Visibility**: external
- **Source Range**: 2901:47:620

**Signature:**
```solidity
/// --- Timelocked ward management ---
///  @notice Schedule relying a new ward after the delay has passed
function scheduleRely(address target) external;;
```

### cancelRely(address)

- **Signature**: `cancelRely(address)`
- **Visibility**: external
- **Source Range**: 3002:45:620

**Signature:**
```solidity
/// @notice Cancel a pending scheduled rely
function cancelRely(address target) external;;
```

### executeScheduledRely(address)

- **Signature**: `executeScheduledRely(address)`
- **Visibility**: external
- **Source Range**: 3171:55:620

**Signature:**
```solidity
/// @notice Execute a scheduled rely
///  @dev    Can be triggered by anyone since the scheduling is protected
function executeScheduledRely(address target) external;;
```

### handle(bytes)

- **Signature**: `handle(bytes)`
- **Visibility**: external
- **Source Range**: 3274:49:620

**Signature:**
```solidity
/// --- Incoming message handling ---
function handle(bytes calldata message) external;;
```

### relyContract(address,address)

- **Signature**: `relyContract(address,address)`
- **Visibility**: external
- **Source Range**: 3457:61:620

**Signature:**
```solidity
/// --- External contract ward management ---
///  @notice Make an address a ward on any contract that Root is a ward on
function relyContract(address target, address user) external;;
```

### denyContract(address,address)

- **Signature**: `denyContract(address,address)`
- **Visibility**: external
- **Source Range**: 3608:61:620

**Signature:**
```solidity
/// @notice Removes an address as a ward on any contract that Root is a ward on
function denyContract(address target, address user) external;;
```

### recoverTokens(address,address,address,uint256)

- **Signature**: `recoverTokens(address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 3796:91:620

**Signature:**
```solidity
/// --- Token Recovery ---
///  @notice Allows Governance to recover tokens sent to the wrong contract by mistake
function recoverTokens(address target, address token, address to, uint256 amount) external;;
```

### handleMessage(bytes) (inherited from IMessageHandler)

- **Signature**: `handleMessage(bytes)`
- **Visibility**: external
- **Source Range**: 90:54:615

**Signature:**
```solidity
function handleMessage(bytes memory message) external;;
```
