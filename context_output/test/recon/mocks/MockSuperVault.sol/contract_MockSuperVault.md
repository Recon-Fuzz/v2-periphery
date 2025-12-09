# Contract: MockSuperVault

## Metadata

- **Name**: MockSuperVault
- **Type**: Contract
- **Path**: test/recon/mocks/MockSuperVault.sol

## State Variables

### _AUTHORIZE_OPERATOR_TYPEHASHReturn_0

```solidity
bytes32 private _AUTHORIZE_OPERATOR_TYPEHASHReturn_0
```

### _DOMAIN_SEPARATORReturn_0

```solidity
bytes32 private _DOMAIN_SEPARATORReturn_0
```

### _PRECISIONReturn_0

```solidity
uint256 private _PRECISIONReturn_0
```

### _allowanceReturn_0

```solidity
uint256 private _allowanceReturn_0
```

### _approveReturn_0

```solidity
bool private _approveReturn_0
```

### _assetReturn_0

```solidity
address private _assetReturn_0
```

### _authorizationsReturn_0

```solidity
bool private _authorizationsReturn_0
```

### _authorizeOperatorReturn_0

```solidity
bool private _authorizeOperatorReturn_0
```

### _balanceOfReturn_0

```solidity
uint256 private _balanceOfReturn_0
```

### _claimableRedeemRequestReturn_0

```solidity
uint256 private _claimableRedeemRequestReturn_0
```

### _convertToAssetsReturn_0

```solidity
uint256 private _convertToAssetsReturn_0
```

### _convertToSharesReturn_0

```solidity
uint256 private _convertToSharesReturn_0
```

### _decimalsReturn_0

```solidity
uint8 private _decimalsReturn_0
```

### _depositReturn_0

```solidity
uint256 private _depositReturn_0
```

### _eip712DomainReturn_0

```solidity
bytes1 private _eip712DomainReturn_0
```

### _eip712DomainReturn_1

```solidity
string private _eip712DomainReturn_1
```

### _eip712DomainReturn_2

```solidity
string private _eip712DomainReturn_2
```

### _eip712DomainReturn_3

```solidity
uint256 private _eip712DomainReturn_3
```

### _eip712DomainReturn_4

```solidity
address private _eip712DomainReturn_4
```

### _eip712DomainReturn_5

```solidity
bytes32 private _eip712DomainReturn_5
```

### _eip712DomainReturn_6

```solidity
uint256[] private _eip712DomainReturn_6
```

### _escrowReturn_0

```solidity
address private _escrowReturn_0
```

### _isOperatorReturn_0

```solidity
bool private _isOperatorReturn_0
```

### _maxDepositReturn_0

```solidity
uint256 private _maxDepositReturn_0
```

### _maxMintReturn_0

```solidity
uint256 private _maxMintReturn_0
```

### _maxRedeemReturn_0

```solidity
uint256 private _maxRedeemReturn_0
```

### _maxWithdrawReturn_0

```solidity
uint256 private _maxWithdrawReturn_0
```

### _mintReturn_0

```solidity
uint256 private _mintReturn_0
```

### _nameReturn_0

```solidity
string private _nameReturn_0
```

### _pendingRedeemRequestReturn_0

```solidity
uint256 private _pendingRedeemRequestReturn_0
```

### _previewDepositReturn_0

```solidity
uint256 private _previewDepositReturn_0
```

### _previewMintReturn_0

```solidity
uint256 private _previewMintReturn_0
```

### _previewRedeemReturn_0

```solidity
uint256 private _previewRedeemReturn_0
```

### _previewWithdrawReturn_0

```solidity
uint256 private _previewWithdrawReturn_0
```

### _redeemReturn_0

```solidity
uint256 private _redeemReturn_0
```

### _requestRedeemReturn_0

```solidity
uint256 private _requestRedeemReturn_0
```

### _setOperatorReturn_0

```solidity
bool private _setOperatorReturn_0
```

### _shareReturn_0

```solidity
address private _shareReturn_0
```

### _strategyReturn_0

```solidity
address private _strategyReturn_0
```

### _superGovernorReturn_0

```solidity
address private _superGovernorReturn_0
```

### _supportsInterfaceReturn_0

```solidity
bool private _supportsInterfaceReturn_0
```

### _symbolReturn_0

```solidity
string private _symbolReturn_0
```

### _totalAssetsReturn_0

```solidity
uint256 private _totalAssetsReturn_0
```

### _totalSupplyReturn_0

```solidity
uint256 private _totalSupplyReturn_0
```

### _transferReturn_0

```solidity
bool private _transferReturn_0
```

### _transferFromReturn_0

```solidity
bool private _transferFromReturn_0
```

### _withdrawReturn_0

```solidity
uint256 private _withdrawReturn_0
```

## Events

### Approval

```solidity
///    ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️ WARNING ⚠️  *
///  -----------------------------------------------------------------*
///       Generally you only need to modify the sections above.      *
///           The code below handles system operations.              *
event Approval(address owner, address spender, uint256 value);
```

### Deposit

```solidity
event Deposit(address sender, address owner, uint256 assets, uint256 shares);
```

### EIP712DomainChanged

```solidity
event EIP712DomainChanged();
```

### Initialized

```solidity
event Initialized(uint64 version);
```

### NonceInvalidated

```solidity
event NonceInvalidated(address sender, bytes32 nonce);
```

### OperatorSet

```solidity
event OperatorSet(address controller, address operator, bool approved);
```

### RedeemRequest

```solidity
event RedeemRequest(address controller, address owner, uint256 requestId, address sender, uint256 assets);
```

### RedeemRequestCancelled

```solidity
event RedeemRequestCancelled(address controller, address sender);
```

### SuperGovernorSet

```solidity
event SuperGovernorSet(address superGovernor);
```

### Transfer

```solidity
event Transfer(address from, address to, uint256 value);
```

### Withdraw

```solidity
event Withdraw(address sender, address receiver, address owner, uint256 assets, uint256 shares);
```

## Public/External Functions

### burnShares(uint256)

- **Signature**: `burnShares(uint256)`
- **Visibility**: public
- **Source Range**: 495:46:643
- **Details**: [function_burnShares_uint256.md](./function_burnShares_uint256.md)

**Signature:**
```solidity
function burnShares(uint256 amount) public;
```

### cancelRedeem(address)

- **Signature**: `cancelRedeem(address)`
- **Visibility**: public
- **Source Range**: 590:52:643
- **Details**: [function_cancelRedeem_address.md](./function_cancelRedeem_address.md)

**Signature:**
```solidity
function cancelRedeem(address controller) public;
```

### initialize(address,string,string,address,address)

- **Signature**: `initialize(address,string,string,address,address)`
- **Visibility**: public
- **Source Range**: 689:180:643
- **Details**: [function_initialize_address_string_string_address_address.md](./function_initialize_address_string_string_address_address.md)

**Signature:**
```solidity
function initialize(address asset_, string memory name_, string memory symbol_, address strategy_, address escrow_) public;
```

### invalidateNonce(bytes32)

- **Signature**: `invalidateNonce(bytes32)`
- **Visibility**: public
- **Source Range**: 921:50:643
- **Details**: [function_invalidateNonce_bytes32.md](./function_invalidateNonce_bytes32.md)

**Signature:**
```solidity
function invalidateNonce(bytes32 nonce) public;
```

### setAUTHORIZE_OPERATOR_TYPEHASHReturn(bytes32)

- **Signature**: `setAUTHORIZE_OPERATOR_TYPEHASHReturn(bytes32)`
- **Visibility**: public
- **Source Range**: 1406:133:643
- **Details**: [function_setAUTHORIZE_OPERATOR_TYPEHASHReturn_bytes32.md](./function_setAUTHORIZE_OPERATOR_TYPEHASHReturn_bytes32.md)

**Signature:**
```solidity
function setAUTHORIZE_OPERATOR_TYPEHASHReturn(bytes32 _value0) public;
```

### setDOMAIN_SEPARATORReturn(bytes32)

- **Signature**: `setDOMAIN_SEPARATORReturn(bytes32)`
- **Visibility**: public
- **Source Range**: 1603:111:643
- **Details**: [function_setDOMAIN_SEPARATORReturn_bytes32.md](./function_setDOMAIN_SEPARATORReturn_bytes32.md)

**Signature:**
```solidity
function setDOMAIN_SEPARATORReturn(bytes32 _value0) public;
```

### setPRECISIONReturn(uint256)

- **Signature**: `setPRECISIONReturn(uint256)`
- **Visibility**: public
- **Source Range**: 1771:97:643
- **Details**: [function_setPRECISIONReturn_uint256.md](./function_setPRECISIONReturn_uint256.md)

**Signature:**
```solidity
function setPRECISIONReturn(uint256 _value0) public;
```

### setAllowanceReturn(uint256)

- **Signature**: `setAllowanceReturn(uint256)`
- **Visibility**: public
- **Source Range**: 1925:97:643
- **Details**: [function_setAllowanceReturn_uint256.md](./function_setAllowanceReturn_uint256.md)

**Signature:**
```solidity
function setAllowanceReturn(uint256 _value0) public;
```

### setApproveReturn(bool)

- **Signature**: `setApproveReturn(bool)`
- **Visibility**: public
- **Source Range**: 2077:90:643
- **Details**: [function_setApproveReturn_bool.md](./function_setApproveReturn_bool.md)

**Signature:**
```solidity
function setApproveReturn(bool _value0) public;
```

### setAssetReturn(address)

- **Signature**: `setAssetReturn(address)`
- **Visibility**: public
- **Source Range**: 2220:89:643
- **Details**: [function_setAssetReturn_address.md](./function_setAssetReturn_address.md)

**Signature:**
```solidity
function setAssetReturn(address _value0) public;
```

### setAuthorizationsReturn(bool)

- **Signature**: `setAuthorizationsReturn(bool)`
- **Visibility**: public
- **Source Range**: 2371:104:643
- **Details**: [function_setAuthorizationsReturn_bool.md](./function_setAuthorizationsReturn_bool.md)

**Signature:**
```solidity
function setAuthorizationsReturn(bool _value0) public;
```

### setAuthorizeOperatorReturn(bool)

- **Signature**: `setAuthorizeOperatorReturn(bool)`
- **Visibility**: public
- **Source Range**: 2540:110:643
- **Details**: [function_setAuthorizeOperatorReturn_bool.md](./function_setAuthorizeOperatorReturn_bool.md)

**Signature:**
```solidity
function setAuthorizeOperatorReturn(bool _value0) public;
```

### setBalanceOfReturn(uint256)

- **Signature**: `setBalanceOfReturn(uint256)`
- **Visibility**: public
- **Source Range**: 2707:97:643
- **Details**: [function_setBalanceOfReturn_uint256.md](./function_setBalanceOfReturn_uint256.md)

**Signature:**
```solidity
function setBalanceOfReturn(uint256 _value0) public;
```

### setClaimableRedeemRequestReturn(uint256)

- **Signature**: `setClaimableRedeemRequestReturn(uint256)`
- **Visibility**: public
- **Source Range**: 2874:123:643
- **Details**: [function_setClaimableRedeemRequestReturn_uint256.md](./function_setClaimableRedeemRequestReturn_uint256.md)

**Signature:**
```solidity
function setClaimableRedeemRequestReturn(uint256 _value0) public;
```

### setConvertToAssetsReturn(uint256)

- **Signature**: `setConvertToAssetsReturn(uint256)`
- **Visibility**: public
- **Source Range**: 3060:109:643
- **Details**: [function_setConvertToAssetsReturn_uint256.md](./function_setConvertToAssetsReturn_uint256.md)

**Signature:**
```solidity
function setConvertToAssetsReturn(uint256 _value0) public;
```

### setConvertToSharesReturn(uint256)

- **Signature**: `setConvertToSharesReturn(uint256)`
- **Visibility**: public
- **Source Range**: 3232:109:643
- **Details**: [function_setConvertToSharesReturn_uint256.md](./function_setConvertToSharesReturn_uint256.md)

**Signature:**
```solidity
function setConvertToSharesReturn(uint256 _value0) public;
```

### setDecimalsReturn(uint8)

- **Signature**: `setDecimalsReturn(uint8)`
- **Visibility**: public
- **Source Range**: 3397:93:643
- **Details**: [function_setDecimalsReturn_uint8.md](./function_setDecimalsReturn_uint8.md)

**Signature:**
```solidity
function setDecimalsReturn(uint8 _value0) public;
```

### setDepositReturn(uint256)

- **Signature**: `setDepositReturn(uint256)`
- **Visibility**: public
- **Source Range**: 3545:93:643
- **Details**: [function_setDepositReturn_uint256.md](./function_setDepositReturn_uint256.md)

**Signature:**
```solidity
function setDepositReturn(uint256 _value0) public;
```

### setEip712DomainReturn(bytes1,string,string,uint256,address,bytes32,uint256[])

- **Signature**: `setEip712DomainReturn(bytes1,string,string,uint256,address,bytes32,uint256[])`
- **Visibility**: public
- **Source Range**: 3698:659:643
- **Details**: [function_setEip712DomainReturn_bytes1_string_string_uint256_address_bytes32_uint256[].md](./function_setEip712DomainReturn_bytes1_string_string_uint256_address_bytes32_uint256[].md)

**Signature:**
```solidity
function setEip712DomainReturn(bytes1 _value0, string memory _value1, string memory _value2, uint256 _value3, address _value4, bytes32 _value5, uint256[] memory _value6) public;
```

### setEscrowReturn(address)

- **Signature**: `setEscrowReturn(address)`
- **Visibility**: public
- **Source Range**: 4411:91:643
- **Details**: [function_setEscrowReturn_address.md](./function_setEscrowReturn_address.md)

**Signature:**
```solidity
function setEscrowReturn(address _value0) public;
```

### setIsOperatorReturn(bool)

- **Signature**: `setIsOperatorReturn(bool)`
- **Visibility**: public
- **Source Range**: 4560:96:643
- **Details**: [function_setIsOperatorReturn_bool.md](./function_setIsOperatorReturn_bool.md)

**Signature:**
```solidity
function setIsOperatorReturn(bool _value0) public;
```

### setMaxDepositReturn(uint256)

- **Signature**: `setMaxDepositReturn(uint256)`
- **Visibility**: public
- **Source Range**: 4714:99:643
- **Details**: [function_setMaxDepositReturn_uint256.md](./function_setMaxDepositReturn_uint256.md)

**Signature:**
```solidity
function setMaxDepositReturn(uint256 _value0) public;
```

### setMaxMintReturn(uint256)

- **Signature**: `setMaxMintReturn(uint256)`
- **Visibility**: public
- **Source Range**: 4868:93:643
- **Details**: [function_setMaxMintReturn_uint256.md](./function_setMaxMintReturn_uint256.md)

**Signature:**
```solidity
function setMaxMintReturn(uint256 _value0) public;
```

### setMaxRedeemReturn(uint256)

- **Signature**: `setMaxRedeemReturn(uint256)`
- **Visibility**: public
- **Source Range**: 5018:97:643
- **Details**: [function_setMaxRedeemReturn_uint256.md](./function_setMaxRedeemReturn_uint256.md)

**Signature:**
```solidity
function setMaxRedeemReturn(uint256 _value0) public;
```

### setMaxWithdrawReturn(uint256)

- **Signature**: `setMaxWithdrawReturn(uint256)`
- **Visibility**: public
- **Source Range**: 5174:101:643
- **Details**: [function_setMaxWithdrawReturn_uint256.md](./function_setMaxWithdrawReturn_uint256.md)

**Signature:**
```solidity
function setMaxWithdrawReturn(uint256 _value0) public;
```

### setMintReturn(uint256)

- **Signature**: `setMintReturn(uint256)`
- **Visibility**: public
- **Source Range**: 5327:87:643
- **Details**: [function_setMintReturn_uint256.md](./function_setMintReturn_uint256.md)

**Signature:**
```solidity
function setMintReturn(uint256 _value0) public;
```

### setNameReturn(string)

- **Signature**: `setNameReturn(string)`
- **Visibility**: public
- **Source Range**: 5466:93:643
- **Details**: [function_setNameReturn_string.md](./function_setNameReturn_string.md)

**Signature:**
```solidity
function setNameReturn(string memory _value0) public;
```

### setPendingRedeemRequestReturn(uint256)

- **Signature**: `setPendingRedeemRequestReturn(uint256)`
- **Visibility**: public
- **Source Range**: 5627:119:643
- **Details**: [function_setPendingRedeemRequestReturn_uint256.md](./function_setPendingRedeemRequestReturn_uint256.md)

**Signature:**
```solidity
function setPendingRedeemRequestReturn(uint256 _value0) public;
```

### setPreviewDepositReturn(uint256)

- **Signature**: `setPreviewDepositReturn(uint256)`
- **Visibility**: public
- **Source Range**: 5808:107:643
- **Details**: [function_setPreviewDepositReturn_uint256.md](./function_setPreviewDepositReturn_uint256.md)

**Signature:**
```solidity
function setPreviewDepositReturn(uint256 _value0) public;
```

### setPreviewMintReturn(uint256)

- **Signature**: `setPreviewMintReturn(uint256)`
- **Visibility**: public
- **Source Range**: 5974:101:643
- **Details**: [function_setPreviewMintReturn_uint256.md](./function_setPreviewMintReturn_uint256.md)

**Signature:**
```solidity
function setPreviewMintReturn(uint256 _value0) public;
```

### setPreviewRedeemReturn(uint256)

- **Signature**: `setPreviewRedeemReturn(uint256)`
- **Visibility**: public
- **Source Range**: 6136:105:643
- **Details**: [function_setPreviewRedeemReturn_uint256.md](./function_setPreviewRedeemReturn_uint256.md)

**Signature:**
```solidity
function setPreviewRedeemReturn(uint256 _value0) public;
```

### setPreviewWithdrawReturn(uint256)

- **Signature**: `setPreviewWithdrawReturn(uint256)`
- **Visibility**: public
- **Source Range**: 6304:109:643
- **Details**: [function_setPreviewWithdrawReturn_uint256.md](./function_setPreviewWithdrawReturn_uint256.md)

**Signature:**
```solidity
function setPreviewWithdrawReturn(uint256 _value0) public;
```

### setRedeemReturn(uint256)

- **Signature**: `setRedeemReturn(uint256)`
- **Visibility**: public
- **Source Range**: 6467:91:643
- **Details**: [function_setRedeemReturn_uint256.md](./function_setRedeemReturn_uint256.md)

**Signature:**
```solidity
function setRedeemReturn(uint256 _value0) public;
```

### setRequestRedeemReturn(uint256)

- **Signature**: `setRequestRedeemReturn(uint256)`
- **Visibility**: public
- **Source Range**: 6619:105:643
- **Details**: [function_setRequestRedeemReturn_uint256.md](./function_setRequestRedeemReturn_uint256.md)

**Signature:**
```solidity
function setRequestRedeemReturn(uint256 _value0) public;
```

### setSetOperatorReturn(bool)

- **Signature**: `setSetOperatorReturn(bool)`
- **Visibility**: public
- **Source Range**: 6783:98:643
- **Details**: [function_setSetOperatorReturn_bool.md](./function_setSetOperatorReturn_bool.md)

**Signature:**
```solidity
function setSetOperatorReturn(bool _value0) public;
```

### setShareReturn(address)

- **Signature**: `setShareReturn(address)`
- **Visibility**: public
- **Source Range**: 6934:89:643
- **Details**: [function_setShareReturn_address.md](./function_setShareReturn_address.md)

**Signature:**
```solidity
function setShareReturn(address _value0) public;
```

### setStrategyReturn(address)

- **Signature**: `setStrategyReturn(address)`
- **Visibility**: public
- **Source Range**: 7079:95:643
- **Details**: [function_setStrategyReturn_address.md](./function_setStrategyReturn_address.md)

**Signature:**
```solidity
function setStrategyReturn(address _value0) public;
```

### setSuperGovernorReturn(address)

- **Signature**: `setSuperGovernorReturn(address)`
- **Visibility**: public
- **Source Range**: 7235:105:643
- **Details**: [function_setSuperGovernorReturn_address.md](./function_setSuperGovernorReturn_address.md)

**Signature:**
```solidity
function setSuperGovernorReturn(address _value0) public;
```

### setSupportsInterfaceReturn(bool)

- **Signature**: `setSupportsInterfaceReturn(bool)`
- **Visibility**: public
- **Source Range**: 7405:110:643
- **Details**: [function_setSupportsInterfaceReturn_bool.md](./function_setSupportsInterfaceReturn_bool.md)

**Signature:**
```solidity
function setSupportsInterfaceReturn(bool _value0) public;
```

### setSymbolReturn(string)

- **Signature**: `setSymbolReturn(string)`
- **Visibility**: public
- **Source Range**: 7569:97:643
- **Details**: [function_setSymbolReturn_string.md](./function_setSymbolReturn_string.md)

**Signature:**
```solidity
function setSymbolReturn(string memory _value0) public;
```

### setTotalAssetsReturn(uint256)

- **Signature**: `setTotalAssetsReturn(uint256)`
- **Visibility**: public
- **Source Range**: 7725:101:643
- **Details**: [function_setTotalAssetsReturn_uint256.md](./function_setTotalAssetsReturn_uint256.md)

**Signature:**
```solidity
function setTotalAssetsReturn(uint256 _value0) public;
```

### setTotalSupplyReturn(uint256)

- **Signature**: `setTotalSupplyReturn(uint256)`
- **Visibility**: public
- **Source Range**: 7885:101:643
- **Details**: [function_setTotalSupplyReturn_uint256.md](./function_setTotalSupplyReturn_uint256.md)

**Signature:**
```solidity
function setTotalSupplyReturn(uint256 _value0) public;
```

### setTransferReturn(bool)

- **Signature**: `setTransferReturn(bool)`
- **Visibility**: public
- **Source Range**: 8042:92:643
- **Details**: [function_setTransferReturn_bool.md](./function_setTransferReturn_bool.md)

**Signature:**
```solidity
function setTransferReturn(bool _value0) public;
```

### setTransferFromReturn(bool)

- **Signature**: `setTransferFromReturn(bool)`
- **Visibility**: public
- **Source Range**: 8194:100:643
- **Details**: [function_setTransferFromReturn_bool.md](./function_setTransferFromReturn_bool.md)

**Signature:**
```solidity
function setTransferFromReturn(bool _value0) public;
```

### setWithdrawReturn(uint256)

- **Signature**: `setWithdrawReturn(uint256)`
- **Visibility**: public
- **Source Range**: 8350:95:643
- **Details**: [function_setWithdrawReturn_uint256.md](./function_setWithdrawReturn_uint256.md)

**Signature:**
```solidity
function setWithdrawReturn(uint256 _value0) public;
```

### AUTHORIZE_OPERATOR_TYPEHASH()

- **Signature**: `AUTHORIZE_OPERATOR_TYPEHASH()`
- **Visibility**: public
- **Source Range**: 13030:129:643
- **Details**: [function_AUTHORIZE_OPERATOR_TYPEHASH.md](./function_AUTHORIZE_OPERATOR_TYPEHASH.md)

**Signature:**
```solidity
function AUTHORIZE_OPERATOR_TYPEHASH() public view returns (bytes32);
```

### DOMAIN_SEPARATOR()

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 13212:107:643
- **Details**: [function_DOMAIN_SEPARATOR.md](./function_DOMAIN_SEPARATOR.md)

**Signature:**
```solidity
function DOMAIN_SEPARATOR() public view returns (bytes32);
```

### PRECISION()

- **Signature**: `PRECISION()`
- **Visibility**: public
- **Source Range**: 13365:93:643
- **Details**: [function_PRECISION.md](./function_PRECISION.md)

**Signature:**
```solidity
function PRECISION() public view returns (uint256);
```

### allowance(address,address)

- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 13504:189:643
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
function allowance(address, address) public view returns (uint256);
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 13737:182:643
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
function approve(address, uint256) public view returns (bool);
```

### asset()

- **Signature**: `asset()`
- **Visibility**: public
- **Source Range**: 13961:85:643
- **Details**: [function_asset.md](./function_asset.md)

**Signature:**
```solidity
function asset() public view returns (address);
```

### authorizations(address,bytes32)

- **Signature**: `authorizations(address,bytes32)`
- **Visibility**: public
- **Source Range**: 14097:199:643
- **Details**: [function_authorizations_address_bytes32.md](./function_authorizations_address_bytes32.md)

**Signature:**
```solidity
function authorizations(address, bytes32) public view returns (bool);
```

### authorizeOperator(address,address,bool,bytes32,uint256,bytes)

- **Signature**: `authorizeOperator(address,address,bool,bytes32,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 14350:360:643
- **Details**: [function_authorizeOperator_address_address_bool_bytes32_uint256_bytes.md](./function_authorizeOperator_address_address_bool_bytes32_uint256_bytes.md)

**Signature:**
```solidity
function authorizeOperator(address, address, bool, bytes32, uint256, bytes memory) public view returns (bool);
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 14756:154:643
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
function balanceOf(address) public view returns (uint256);
```

### claimableRedeemRequest(uint256,address)

- **Signature**: `claimableRedeemRequest(uint256,address)`
- **Visibility**: public
- **Source Range**: 14969:217:643
- **Details**: [function_claimableRedeemRequest_uint256_address.md](./function_claimableRedeemRequest_uint256_address.md)

**Signature:**
```solidity
function claimableRedeemRequest(uint256, address) public view returns (uint256);
```

### convertToAssets(uint256)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: public
- **Source Range**: 15238:165:643
- **Details**: [function_convertToAssets_uint256.md](./function_convertToAssets_uint256.md)

**Signature:**
```solidity
function convertToAssets(uint256) public view returns (uint256);
```

### convertToShares(uint256)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 15455:165:643
- **Details**: [function_convertToShares_uint256.md](./function_convertToShares_uint256.md)

**Signature:**
```solidity
function convertToShares(uint256) public view returns (uint256);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 15665:89:643
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() public view returns (uint8);
```

### deposit(uint256,address)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: public
- **Source Range**: 15798:187:643
- **Details**: [function_deposit_uint256_address.md](./function_deposit_uint256_address.md)

**Signature:**
```solidity
function deposit(uint256, address) public view returns (uint256);
```

### eip712Domain()

- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 16034:435:643
- **Details**: [function_eip712Domain.md](./function_eip712Domain.md)

**Signature:**
```solidity
function eip712Domain() public view returns (bytes1, string memory, string memory, uint256, address, bytes32, uint256[] memory);
```

### escrow()

- **Signature**: `escrow()`
- **Visibility**: public
- **Source Range**: 16512:87:643
- **Details**: [function_escrow.md](./function_escrow.md)

**Signature:**
```solidity
function escrow() public view returns (address);
```

### isOperator(address,address)

- **Signature**: `isOperator(address,address)`
- **Visibility**: public
- **Source Range**: 16646:193:643
- **Details**: [function_isOperator_address_address.md](./function_isOperator_address_address.md)

**Signature:**
```solidity
function isOperator(address, address) public view returns (bool);
```

### maxDeposit(address)

- **Signature**: `maxDeposit(address)`
- **Visibility**: public
- **Source Range**: 16886:155:643
- **Details**: [function_maxDeposit_address.md](./function_maxDeposit_address.md)

**Signature:**
```solidity
function maxDeposit(address) public view returns (uint256);
```

### maxMint(address)

- **Signature**: `maxMint(address)`
- **Visibility**: public
- **Source Range**: 17085:149:643
- **Details**: [function_maxMint_address.md](./function_maxMint_address.md)

**Signature:**
```solidity
function maxMint(address) public view returns (uint256);
```

### maxRedeem(address)

- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 17280:154:643
- **Details**: [function_maxRedeem_address.md](./function_maxRedeem_address.md)

**Signature:**
```solidity
function maxRedeem(address) public view returns (uint256);
```

### maxWithdraw(address)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 17482:158:643
- **Details**: [function_maxWithdraw_address.md](./function_maxWithdraw_address.md)

**Signature:**
```solidity
function maxWithdraw(address) public view returns (uint256);
```

### mint(uint256,address)

- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 17681:181:643
- **Details**: [function_mint_uint256_address.md](./function_mint_uint256_address.md)

**Signature:**
```solidity
function mint(uint256, address) public view returns (uint256);
```

### name()

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 17903:89:643
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
function name() public view returns (string memory);
```

### pendingRedeemRequest(uint256,address)

- **Signature**: `pendingRedeemRequest(uint256,address)`
- **Visibility**: public
- **Source Range**: 18049:213:643
- **Details**: [function_pendingRedeemRequest_uint256_address.md](./function_pendingRedeemRequest_uint256_address.md)

**Signature:**
```solidity
function pendingRedeemRequest(uint256, address) public view returns (uint256);
```

### previewDeposit(uint256)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: public
- **Source Range**: 18313:163:643
- **Details**: [function_previewDeposit_uint256.md](./function_previewDeposit_uint256.md)

**Signature:**
```solidity
function previewDeposit(uint256) public view returns (uint256);
```

### previewMint(uint256)

- **Signature**: `previewMint(uint256)`
- **Visibility**: public
- **Source Range**: 18524:157:643
- **Details**: [function_previewMint_uint256.md](./function_previewMint_uint256.md)

**Signature:**
```solidity
function previewMint(uint256) public view returns (uint256);
```

### previewRedeem(uint256)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 18731:159:643
- **Details**: [function_previewRedeem_uint256.md](./function_previewRedeem_uint256.md)

**Signature:**
```solidity
function previewRedeem(uint256) public view returns (uint256);
```

### previewWithdraw(uint256)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 18942:163:643
- **Details**: [function_previewWithdraw_uint256.md](./function_previewWithdraw_uint256.md)

**Signature:**
```solidity
function previewWithdraw(uint256) public view returns (uint256);
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 19148:225:643
- **Details**: [function_redeem_uint256_address_address.md](./function_redeem_uint256_address_address.md)

**Signature:**
```solidity
function redeem(uint256, address, address) public view returns (uint256);
```

### requestRedeem(uint256,address,address)

- **Signature**: `requestRedeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 19423:236:643
- **Details**: [function_requestRedeem_uint256_address_address.md](./function_requestRedeem_uint256_address_address.md)

**Signature:**
```solidity
function requestRedeem(uint256, address, address) public view returns (uint256);
```

### setOperator(address,bool)

- **Signature**: `setOperator(address,bool)`
- **Visibility**: public
- **Source Range**: 19707:191:643
- **Details**: [function_setOperator_address_bool.md](./function_setOperator_address_bool.md)

**Signature:**
```solidity
function setOperator(address, bool) public view returns (bool);
```

### share()

- **Signature**: `share()`
- **Visibility**: public
- **Source Range**: 19940:85:643
- **Details**: [function_share.md](./function_share.md)

**Signature:**
```solidity
function share() public view returns (address);
```

### strategy()

- **Signature**: `strategy()`
- **Visibility**: public
- **Source Range**: 20070:91:643
- **Details**: [function_strategy.md](./function_strategy.md)

**Signature:**
```solidity
function strategy() public view returns (address);
```

### superGovernor()

- **Signature**: `superGovernor()`
- **Visibility**: public
- **Source Range**: 20211:101:643
- **Details**: [function_superGovernor.md](./function_superGovernor.md)

**Signature:**
```solidity
function superGovernor() public view returns (address);
```

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: public
- **Source Range**: 20366:170:643
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
function supportsInterface(bytes4) public view returns (bool);
```

### symbol()

- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 20579:93:643
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
function symbol() public view returns (string memory);
```

### totalAssets()

- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 20720:97:643
- **Details**: [function_totalAssets.md](./function_totalAssets.md)

**Signature:**
```solidity
function totalAssets() public view returns (uint256);
```

### totalSupply()

- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 20865:97:643
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
function totalSupply() public view returns (uint256);
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 21007:179:643
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
function transfer(address, uint256) public view returns (bool);
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 21235:221:643
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function transferFrom(address, address, uint256) public view returns (bool);
```

### withdraw(uint256,address,address)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 21501:229:643
- **Details**: [function_withdraw_uint256_address_address.md](./function_withdraw_uint256_address_address.md)

**Signature:**
```solidity
function withdraw(uint256, address, address) public view returns (uint256);
```
