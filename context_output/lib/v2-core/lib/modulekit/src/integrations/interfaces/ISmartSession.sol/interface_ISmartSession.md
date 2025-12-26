# Interface: ISmartSession

## Metadata

- **Name**: ISmartSession
- **Type**: Interface
- **Path**: lib/v2-core/lib/modulekit/src/integrations/interfaces/ISmartSession.sol
- **Documentation**:  @title ISmartSession
   @author Filipp Makarov (Biconomy) & zeroknots.eth (Rhinestone)
   @dev A collaborative effort between Rhinestone and Biconomy to create a powerful
        and flexible session key management system for ERC-4337 and ERC-7579 accounts.
   SmartSession is an advanced module for ERC-4337 and ERC-7579 compatible smart contract wallets,
   enabling granular
   control over session keys. It allows users to create and manage temporary, limited-permission
   access to their
   accounts through configurable policies. The module supports various policy types, including user
   operation
   validation, action-specific policies, and ERC-1271 signature validation. SmartSession implements
   a unique "enable
   flow" that allows session keys to be created within the first user operation, enhancing security
   and user experience.
   It uses a nested EIP-712 approach for signature validation, providing phishing resistance and
   compatibility with
   existing wallet interfaces. The module also supports batched executions and integrates with
   external policy contracts
   for flexible permission management. Overall, SmartSession offers a comprehensive solution for
   secure, temporary
   account access in the evolving landscape of account abstraction.

## Errors

### AssociatedArray_OutOfBounds

```solidity
error AssociatedArray_OutOfBounds(uint256 index);
```

### ChainIdMismatch

```solidity
error ChainIdMismatch(uint64 providedChainId);
```

### HashIndexOutOfBounds

```solidity
error HashIndexOutOfBounds(uint256 index);
```

### HashMismatch

```solidity
error HashMismatch(bytes32 providedHash, bytes32 computedHash);
```

### InvalidData

```solidity
error InvalidData();
```

### InvalidActionId

```solidity
error InvalidActionId();
```

### NoExecutionsInBatch

```solidity
error NoExecutionsInBatch();
```

### InvalidTarget

```solidity
error InvalidTarget();
```

### InvalidEnableSignature

```solidity
error InvalidEnableSignature(address account, bytes32 hash);
```

### InvalidISessionValidator

```solidity
error InvalidISessionValidator(ISessionValidator sessionValidator);
```

### InvalidSelfCall

```solidity
error InvalidSelfCall();
```

### InvalidSession

```solidity
error InvalidSession(PermissionId permissionId);
```

### InvalidSessionKeySignature

```solidity
error InvalidSessionKeySignature(PermissionId permissionId, address sessionValidator, address account, bytes32 userOpHash);
```

### SmartSessionModuleAlreadyInstalled

```solidity
error SmartSessionModuleAlreadyInstalled(address account);
```

### InvalidPermissionId

```solidity
error InvalidPermissionId(PermissionId permissionId);
```

### InvalidCallTarget

```solidity
error InvalidCallTarget();
```

### InvalidUserOpSender

```solidity
error InvalidUserOpSender(address sender);
```

### NoPoliciesSet

```solidity
error NoPoliciesSet(PermissionId permissionId);
```

### PartlyEnabledActions

```solidity
error PartlyEnabledActions();
```

### PartlyEnabledPolicies

```solidity
error PartlyEnabledPolicies();
```

### PolicyViolation

```solidity
error PolicyViolation(PermissionId permissionId, address policy);
```

### SignerNotFound

```solidity
error SignerNotFound(PermissionId permissionId, address account);
```

### UnsupportedExecutionType

```solidity
error UnsupportedExecutionType();
```

### UnsupportedPolicy

```solidity
error UnsupportedPolicy(address policy);
```

### UnsupportedSmartSessionMode

```solidity
error UnsupportedSmartSessionMode(SmartSessionMode mode);
```

### ForbiddenValidationData

```solidity
error ForbiddenValidationData();
```

## Events

### NonceIterated

```solidity
event NonceIterated(PermissionId permissionId, address account, uint256 newValue);
```

### SessionValidatorEnabled

```solidity
event SessionValidatorEnabled(PermissionId permissionId, address sessionValidator, address smartAccount);
```

### SessionValidatorDisabled

```solidity
event SessionValidatorDisabled(PermissionId permissionId, address sessionValidator, address smartAccount);
```

### PolicyDisabled

```solidity
event PolicyDisabled(PermissionId permissionId, PolicyType policyType, address policy, address smartAccount);
```

### ActionIdDisabled

```solidity
event ActionIdDisabled(PermissionId permissionId, ActionId actionId, address smartAccount);
```

### PolicyEnabled

```solidity
event PolicyEnabled(PermissionId permissionId, PolicyType policyType, address policy, address smartAccount);
```

### SessionCreated

```solidity
event SessionCreated(PermissionId permissionId, address account);
```

### SessionRemoved

```solidity
event SessionRemoved(PermissionId permissionId, address smartAccount);
```

## Public/External Functions

### validateUserOp(struct PackedUserOperation,bytes32)

- **Signature**: `validateUserOp(struct PackedUserOperation,bytes32)`
- **Visibility**: external
- **Source Range**: 8581:154:191

**Signature:**
```solidity
///  ERC4337/ERC7579 validation function
///  the primary purpose of this function, is to validate if a userOp forwarded by a 7579 account
///  is valid.
///  This function will dissect the userop.signature field, and parse out the provided
///  PermissionId, which identifies
///  a
///  unique ID of a dapp for a specific user. n Policies and one Signer contract are mapped to
///  this Id and will be
///  checked. Only UserOps that pass policies and signer checks, are considered valid.
///  Enable Flow:
///      SmartSessions allows session keys to be created within the "first" UserOp. If the enable
///  flow is chosen, the
///      EnableSession data, which is packed in userOp.signature is parsed, and stored in the
///  SmartSession storage.
function validateUserOp(PackedUserOperation memory userOp, bytes32 userOpHash) external returns (ValidationData vd);;
```

### onInstall(bytes)

- **Signature**: `onInstall(bytes)`
- **Visibility**: external
- **Source Range**: 8946:47:191

**Signature:**
```solidity
///  ERC7579 compliant onInstall function.
///  expected to abi.encode(Session[]) for the enable data
///  Note: It's possible to install the smartsession module with data = ""
function onInstall(bytes memory data) external;;
```

### onUninstall(bytes)

- **Signature**: `onUninstall(bytes)`
- **Visibility**: external
- **Source Range**: 9125:44:191

**Signature:**
```solidity
///  ERC7579 compliant uninstall function.
///  will wipe all configIds and associated Policies / Signers
function onUninstall(bytes memory) external;;
```

### isValidSignatureWithSender(address,bytes32,bytes)

- **Signature**: `isValidSignatureWithSender(address,bytes32,bytes)`
- **Visibility**: external
- **Source Range**: 9300:182:191

**Signature:**
```solidity
///  ERC7579 compliant ERC1271 function
///  this function allows session keys to sign ERC1271 requests.
function isValidSignatureWithSender(address sender, bytes32 hash, bytes memory signature) external view returns (bytes4 result);;
```

### isInitialized(address)

- **Signature**: `isInitialized(address)`
- **Visibility**: external
- **Source Range**: 9488:74:191

**Signature:**
```solidity
function isInitialized(address smartAccount) external view returns (bool);;
```

### isModuleType(uint256)

- **Signature**: `isModuleType(uint256)`
- **Visibility**: external
- **Source Range**: 9567:67:191

**Signature:**
```solidity
function isModuleType(uint256 typeID) external pure returns (bool);;
```

### enableActionPolicies(PermissionId,struct ActionData[])

- **Signature**: `enableActionPolicies(PermissionId,struct ActionData[])`
- **Visibility**: external
- **Source Range**: 9921:132:191

**Signature:**
```solidity
function enableActionPolicies(PermissionId permissionId, ActionData[] memory actionPolicies) external;;
```

### enableERC1271Policies(PermissionId,struct ERC7739Data)

- **Signature**: `enableERC1271Policies(PermissionId,struct ERC7739Data)`
- **Visibility**: external
- **Source Range**: 10058:135:191

**Signature:**
```solidity
function enableERC1271Policies(PermissionId permissionId, ERC7739Data calldata erc1271Policies) external;;
```

### enableSessions(struct Session[])

- **Signature**: `enableSessions(struct Session[])`
- **Visibility**: external
- **Source Range**: 10198:122:191

**Signature:**
```solidity
function enableSessions(Session[] memory sessions) external returns (PermissionId[] memory permissionIds);;
```

### enableUserOpPolicies(PermissionId,struct PolicyData[])

- **Signature**: `enableUserOpPolicies(PermissionId,struct PolicyData[])`
- **Visibility**: external
- **Source Range**: 10325:132:191

**Signature:**
```solidity
function enableUserOpPolicies(PermissionId permissionId, PolicyData[] memory userOpPolicies) external;;
```

### disableActionPolicies(PermissionId,ActionId,address[])

- **Signature**: `disableActionPolicies(PermissionId,ActionId,address[])`
- **Visibility**: external
- **Source Range**: 10462:151:191

**Signature:**
```solidity
function disableActionPolicies(PermissionId permissionId, ActionId actionId, address[] memory policies) external;;
```

### disableActionId(PermissionId,ActionId)

- **Signature**: `disableActionId(PermissionId,ActionId)`
- **Visibility**: external
- **Source Range**: 10618:80:191

**Signature:**
```solidity
function disableActionId(PermissionId permissionId, ActionId actionId) external;;
```

### disableERC1271Policies(PermissionId,address[],string[])

- **Signature**: `disableERC1271Policies(PermissionId,address[],string[])`
- **Visibility**: external
- **Source Range**: 10703:161:191

**Signature:**
```solidity
function disableERC1271Policies(PermissionId permissionId, address[] memory policies, string[] calldata contents) external;;
```

### disableUserOpPolicies(PermissionId,address[])

- **Signature**: `disableUserOpPolicies(PermissionId,address[])`
- **Visibility**: external
- **Source Range**: 10869:94:191

**Signature:**
```solidity
function disableUserOpPolicies(PermissionId permissionId, address[] memory policies) external;;
```

### removeSession(PermissionId)

- **Signature**: `removeSession(PermissionId)`
- **Visibility**: external
- **Source Range**: 10968:59:191

**Signature:**
```solidity
function removeSession(PermissionId permissionId) external;;
```

### revokeEnableSignature(PermissionId)

- **Signature**: `revokeEnableSignature(PermissionId)`
- **Visibility**: external
- **Source Range**: 11032:67:191

**Signature:**
```solidity
function revokeEnableSignature(PermissionId permissionId) external;;
```

### getSessionDigest(PermissionId,address,struct Session,enum SmartSessionMode)

- **Signature**: `getSessionDigest(PermissionId,address,struct Session,enum SmartSessionMode)`
- **Visibility**: external
- **Source Range**: 11388:208:191

**Signature:**
```solidity
function getSessionDigest(PermissionId permissionId, address account, Session memory data, SmartSessionMode mode) external view returns (bytes32);;
```

### getNonce(PermissionId,address)

- **Signature**: `getNonce(PermissionId,address)`
- **Visibility**: external
- **Source Range**: 11602:94:191

**Signature:**
```solidity
function getNonce(PermissionId permissionId, address account) external view returns (uint256);;
```

### getPermissionId(struct Session)

- **Signature**: `getPermissionId(struct Session)`
- **Visibility**: external
- **Source Range**: 11701:123:191

**Signature:**
```solidity
function getPermissionId(Session memory session) external pure returns (PermissionId permissionId);;
```

### isPermissionEnabled(PermissionId,address)

- **Signature**: `isPermissionEnabled(PermissionId,address)`
- **Visibility**: external
- **Source Range**: 11829:148:191

**Signature:**
```solidity
function isPermissionEnabled(PermissionId permissionId, address account) external view returns (bool);;
```

### isISessionValidatorSet(PermissionId,address)

- **Signature**: `isISessionValidatorSet(PermissionId,address)`
- **Visibility**: external
- **Source Range**: 11982:151:191

**Signature:**
```solidity
function isISessionValidatorSet(PermissionId permissionId, address account) external view returns (bool);;
```

### areUserOpPoliciesEnabled(address,PermissionId,struct PolicyData[])

- **Signature**: `areUserOpPoliciesEnabled(address,PermissionId,struct PolicyData[])`
- **Visibility**: external
- **Source Range**: 12138:199:191

**Signature:**
```solidity
function areUserOpPoliciesEnabled(address account, PermissionId permissionId, PolicyData[] calldata userOpPolicies) external view returns (bool);;
```

### areERC1271PoliciesEnabled(address,PermissionId,struct PolicyData[])

- **Signature**: `areERC1271PoliciesEnabled(address,PermissionId,struct PolicyData[])`
- **Visibility**: external
- **Source Range**: 12342:201:191

**Signature:**
```solidity
function areERC1271PoliciesEnabled(address account, PermissionId permissionId, PolicyData[] calldata erc1271Policies) external view returns (bool);;
```

### areActionsEnabled(address,PermissionId,struct ActionData[])

- **Signature**: `areActionsEnabled(address,PermissionId,struct ActionData[])`
- **Visibility**: external
- **Source Range**: 12548:185:191

**Signature:**
```solidity
function areActionsEnabled(address account, PermissionId permissionId, ActionData[] calldata actions) external view returns (bool);;
```
