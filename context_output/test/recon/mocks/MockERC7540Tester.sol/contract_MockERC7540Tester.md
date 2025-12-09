# Contract: MockERC7540Tester

## Metadata

- **Name**: MockERC7540Tester
- **Type**: Contract
- **Path**: test/recon/mocks/MockERC7540Tester.sol

## Implements Interfaces

- **IERC165** [lib/v2-core/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol/interface_IERC165.md]

## State Variables

### name (inherited from ERC20)

```solidity
string public name
```

### symbol (inherited from ERC20)

```solidity
string public symbol
```

### decimals (inherited from ERC20)

```solidity
uint8 public immutable decimals
```

### totalSupply (inherited from ERC20)

```solidity
uint256 public totalSupply
```

### balanceOf (inherited from ERC20)

```solidity
mapping(address => uint256) public balanceOf
```

### allowance (inherited from ERC20)

```solidity
mapping(address => mapping(address => uint256)) public allowance
```

### INITIAL_CHAIN_ID (inherited from ERC20)

```solidity
uint256 internal immutable INITIAL_CHAIN_ID
```

### INITIAL_DOMAIN_SEPARATOR (inherited from ERC20)

```solidity
bytes32 internal immutable INITIAL_DOMAIN_SEPARATOR
```

### nonces (inherited from ERC20)

```solidity
mapping(address => uint256) public nonces
```

### asset (inherited from ERC7575)

```solidity
MockERC20 public immutable asset
```

**MockERC20**: [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

### _nextRequestId

```solidity
uint256 private _nextRequestId = 1
```

### depositRequests

```solidity
mapping(uint256 => DepositRequestStruct) public depositRequests
```

### redeemRequests

```solidity
mapping(uint256 => RedeemRequestStruct) public redeemRequests
```

### operators

```solidity
mapping(address => mapping(address => bool)) public operators
```

### pendingCancelDeposit

```solidity
mapping(uint256 => bool) public pendingCancelDeposit
```

### pendingCancelRedeem

```solidity
mapping(uint256 => bool) public pendingCancelRedeem
```

### yieldMultiplier

```solidity
uint256 public yieldMultiplier = 10_000
```

### MAX_BPS

```solidity
uint256 private constant MAX_BPS = 10_000
```

### totalLosses

```solidity
uint256 public totalLosses
```

### totalGains

```solidity
uint256 public totalGains
```

### lossOnWithdraw

```solidity
uint256 public lossOnWithdraw
```

## Structs

### DepositRequestStruct

```solidity
struct DepositRequestStruct {
    uint256 assets;
    address controller;
    address owner;
    bool fulfilled;
    bool canceled;
}
```

### RedeemRequestStruct

```solidity
struct RedeemRequestStruct {
    uint256 shares;
    address controller;
    address owner;
    bool fulfilled;
    bool canceled;
}
```

## Errors

### InsufficientBalance (inherited from ERC20)

```solidity
/// @notice Thrown when attempting to transfer more tokens than available balance
error InsufficientBalance(address from, uint256 balance, uint256 amount);
```

### InsufficientAllowance (inherited from ERC20)

```solidity
/// @notice Thrown when attempting to transfer more tokens than allowed
error InsufficientAllowance(address owner, address spender, uint256 allowance, uint256 amount);
```

### MintOverflow (inherited from ERC20)

```solidity
/// @notice Thrown when minting would cause overflow
error MintOverflow(uint256 currentSupply, uint256 amount);
```

## Events

### Transfer (inherited from ERC20)

```solidity
event Transfer(address indexed from, address indexed to, uint256 amount);
```

### Approval (inherited from ERC20)

```solidity
event Approval(address indexed owner, address indexed spender, uint256 amount);
```

### Deposit (inherited from ERC7575)

```solidity
event Deposit(address indexed sender, address indexed owner, uint256 assets, uint256 shares);
```

### Withdraw (inherited from ERC7575)

```solidity
event Withdraw(address indexed sender, address indexed receiver, address indexed owner, uint256 assets, uint256 shares);
```

### DepositRequest

```solidity
event DepositRequest(address indexed controller, address indexed owner, uint256 indexed requestId, address sender, uint256 assets);
```

### RedeemRequest

```solidity
event RedeemRequest(address indexed controller, address indexed owner, uint256 indexed requestId, address sender, uint256 shares);
```

### OperatorSet

```solidity
event OperatorSet(address indexed controller, address indexed operator, bool approved);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 4397:58:641
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address _asset) ERC7575(MockERC20(_asset));
```

### setOperator(address,bool)

- **Signature**: `setOperator(address,bool)`
- **Visibility**: external
- **Source Range**: 4488:216:641
- **Details**: [function_setOperator_address_bool.md](./function_setOperator_address_bool.md)

**Signature:**
```solidity
function setOperator(address operator, bool approved) external returns (bool);
```

### isOperator(address,address)

- **Signature**: `isOperator(address,address)`
- **Visibility**: external
- **Source Range**: 4710:142:641
- **Details**: [function_isOperator_address_address.md](./function_isOperator_address_address.md)

**Signature:**
```solidity
function isOperator(address controller, address operator) external view returns (bool);
```

### requestDeposit(uint256,address,address)

- **Signature**: `requestDeposit(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 4884:472:641
- **Details**: [function_requestDeposit_uint256_address_address.md](./function_requestDeposit_uint256_address_address.md)

**Signature:**
```solidity
function requestDeposit(uint256 assets, address controller, address owner) external returns (uint256 requestId);
```

### pendingDepositRequest(uint256,address)

- **Signature**: `pendingDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 5362:336:641
- **Details**: [function_pendingDepositRequest_uint256_address.md](./function_pendingDepositRequest_uint256_address.md)

**Signature:**
```solidity
function pendingDepositRequest(uint256 requestId, address controller) external view returns (uint256);
```

### claimableDepositRequest(uint256,address)

- **Signature**: `claimableDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 5704:338:641
- **Details**: [function_claimableDepositRequest_uint256_address.md](./function_claimableDepositRequest_uint256_address.md)

**Signature:**
```solidity
function claimableDepositRequest(uint256 requestId, address controller) external view returns (uint256);
```

### pendingCancelDepositRequest(uint256,address)

- **Signature**: `pendingCancelDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 6048:271:641
- **Details**: [function_pendingCancelDepositRequest_uint256_address.md](./function_pendingCancelDepositRequest_uint256_address.md)

**Signature:**
```solidity
function pendingCancelDepositRequest(uint256 requestId, address controller) external view returns (bool);
```

### deposit(uint256,address,address)

- **Signature**: `deposit(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 6374:1082:641
- **Details**: [function_deposit_uint256_address_address.md](./function_deposit_uint256_address_address.md)

**Signature:**
```solidity
function deposit(uint256 assets, address receiver, address controller) public returns (uint256 shares);
```

### withdraw(uint256,address,address)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 7462:474:641
- **Details**: [function_withdraw_uint256_address_address.md](./function_withdraw_uint256_address_address.md)

**Signature:**
```solidity
function withdraw(uint256 assets, address receiver, address owner) public returns (uint256 shares);
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 7942:470:641
- **Details**: [function_redeem_uint256_address_address.md](./function_redeem_uint256_address_address.md)

**Signature:**
```solidity
function redeem(uint256 shares, address receiver, address owner) public returns (uint256 assets);
```

### requestRedeem(uint256,address,address)

- **Signature**: `requestRedeem(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 8443:405:641
- **Details**: [function_requestRedeem_uint256_address_address.md](./function_requestRedeem_uint256_address_address.md)

**Signature:**
```solidity
function requestRedeem(uint256 shares, address controller, address owner) external returns (uint256 requestId);
```

### pendingRedeemRequest(uint256,address)

- **Signature**: `pendingRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 8854:333:641
- **Details**: [function_pendingRedeemRequest_uint256_address.md](./function_pendingRedeemRequest_uint256_address.md)

**Signature:**
```solidity
function pendingRedeemRequest(uint256 requestId, address controller) external view returns (uint256);
```

### claimableRedeemRequest(uint256,address)

- **Signature**: `claimableRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9193:335:641
- **Details**: [function_claimableRedeemRequest_uint256_address.md](./function_claimableRedeemRequest_uint256_address.md)

**Signature:**
```solidity
function claimableRedeemRequest(uint256 requestId, address controller) external view returns (uint256);
```

### pendingCancelRedeemRequest(uint256,address)

- **Signature**: `pendingCancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9534:267:641
- **Details**: [function_pendingCancelRedeemRequest_uint256_address.md](./function_pendingCancelRedeemRequest_uint256_address.md)

**Signature:**
```solidity
function pendingCancelRedeemRequest(uint256 requestId, address controller) external view returns (bool);
```

### cancelDepositRequest(uint256,address)

- **Signature**: `cancelDepositRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 9832:399:641
- **Details**: [function_cancelDepositRequest_uint256_address.md](./function_cancelDepositRequest_uint256_address.md)

**Signature:**
```solidity
function cancelDepositRequest(uint256 requestId, address controller) external;
```

### claimCancelDepositRequest(uint256,address,address)

- **Signature**: `claimCancelDepositRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 10237:421:641
- **Details**: [function_claimCancelDepositRequest_uint256_address_address.md](./function_claimCancelDepositRequest_uint256_address_address.md)

**Signature:**
```solidity
function claimCancelDepositRequest(uint256 requestId, address receiver, address) external returns (uint256 assets);
```

### cancelRedeemRequest(uint256,address)

- **Signature**: `cancelRedeemRequest(uint256,address)`
- **Visibility**: external
- **Source Range**: 10664:169:641
- **Details**: [function_cancelRedeemRequest_uint256_address.md](./function_cancelRedeemRequest_uint256_address.md)

**Signature:**
```solidity
function cancelRedeemRequest(uint256 requestId, address) external;
```

### claimCancelRedeemRequest(uint256,address,address)

- **Signature**: `claimCancelRedeemRequest(uint256,address,address)`
- **Visibility**: external
- **Source Range**: 10839:408:641
- **Details**: [function_claimCancelRedeemRequest_uint256_address_address.md](./function_claimCancelRedeemRequest_uint256_address_address.md)

**Signature:**
```solidity
function claimCancelRedeemRequest(uint256 requestId, address receiver, address) external returns (uint256 shares);
```

### poolId()

- **Signature**: `poolId()`
- **Visibility**: external
- **Source Range**: 11311:74:641
- **Details**: [function_poolId.md](./function_poolId.md)

**Signature:**
```solidity
function poolId() external pure returns (uint64);
```

### trancheId()

- **Signature**: `trancheId()`
- **Visibility**: external
- **Source Range**: 11391:96:641
- **Details**: [function_trancheId.md](./function_trancheId.md)

**Signature:**
```solidity
function trancheId() external pure returns (bytes16);
```

### increaseYield(uint256)

- **Signature**: `increaseYield(uint256)`
- **Visibility**: external
- **Source Range**: 11706:220:641
- **Details**: [function_increaseYield_uint256.md](./function_increaseYield_uint256.md)

**Signature:**
```solidity
function increaseYield(uint256 increasePercentageFP4) external;
```

### decreaseYield(uint256)

- **Signature**: `decreaseYield(uint256)`
- **Visibility**: external
- **Source Range**: 11932:206:641
- **Details**: [function_decreaseYield_uint256.md](./function_decreaseYield_uint256.md)

**Signature:**
```solidity
function decreaseYield(uint256 decreasePercentageFP4) external;
```

### simulateGain(uint256)

- **Signature**: `simulateGain(uint256)`
- **Visibility**: external
- **Source Range**: 12144:170:641
- **Details**: [function_simulateGain_uint256.md](./function_simulateGain_uint256.md)

**Signature:**
```solidity
function simulateGain(uint256 gainAmount) external;
```

### simulateLoss(uint256)

- **Signature**: `simulateLoss(uint256)`
- **Visibility**: external
- **Source Range**: 12320:157:641
- **Details**: [function_simulateLoss_uint256.md](./function_simulateLoss_uint256.md)

**Signature:**
```solidity
function simulateLoss(uint256 lossAmount) external;
```

### setLossOnWithdraw(uint256)

- **Signature**: `setLossOnWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 12565:188:641
- **Details**: [function_setLossOnWithdraw_uint256.md](./function_setLossOnWithdraw_uint256.md)

**Signature:**
```solidity
/// @dev Set the loss on withdraw as percentage of the assets being withdrawn
function setLossOnWithdraw(uint256 _lossOnWithdraw) public;
```

### supportsInterface(bytes4)

- **Signature**: `supportsInterface(bytes4)`
- **Visibility**: external
- **Source Range**: 12802:149:641
- **Details**: [function_supportsInterface_bytes4.md](./function_supportsInterface_bytes4.md)

**Signature:**
```solidity
/// @notice ERC165 interface detection
function supportsInterface(bytes4 interfaceId) override external pure returns (bool);
```

### approve(address,uint256) (inherited from ERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 3072:211:73
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
function approve(address spender, uint256 amount) virtual public returns (bool);
```

### transfer(address,uint256) (inherited from ERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3289:535:73
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
function transfer(address to, uint256 amount) virtual public returns (bool);
```

### transferFrom(address,address,uint256) (inherited from ERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 3830:834:73
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function transferFrom(address from, address to, uint256 amount) virtual public returns (bool);
```

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (inherited from ERC20)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 4853:1441:73
- **Details**: [function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md](./function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md)

**Signature:**
```solidity
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) virtual public;
```

### DOMAIN_SEPARATOR() (inherited from ERC20)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: public
- **Source Range**: 6300:177:73
- **Details**: [function_DOMAIN_SEPARATOR.md](./function_DOMAIN_SEPARATOR.md)

**Signature:**
```solidity
function DOMAIN_SEPARATOR() virtual public view returns (bytes32);
```

### constructor(string,string,uint8) (inherited from MockERC20)

- **Signature**: `constructor(string,string,uint8)`
- **Visibility**: public
- **Source Range**: 8072:108:73
- **Details**: [function_constructor_string_string_uint8.md](./function_constructor_string_string_uint8.md)

**Signature:**
```solidity
constructor(string memory _name, string memory _symbol, uint8 _decimals) ERC20(_name,_symbol,_decimals);
```

### mint(address,uint256) (inherited from MockERC20)

- **Signature**: `mint(address,uint256)`
- **Visibility**: public
- **Source Range**: 8186:89:73
- **Details**: [function_mint_address_uint256.md](./function_mint_address_uint256.md)

**Signature:**
```solidity
function mint(address to, uint256 value) virtual public;
```

### burn(address,uint256) (inherited from MockERC20)

- **Signature**: `burn(address,uint256)`
- **Visibility**: public
- **Source Range**: 8281:93:73
- **Details**: [function_burn_address_uint256.md](./function_burn_address_uint256.md)

**Signature:**
```solidity
function burn(address from, uint256 value) virtual public;
```

### share() (inherited from ERC7575)

- **Signature**: `share()`
- **Visibility**: external
- **Source Range**: 624:158:641
- **Details**: [function_share.md](./function_share.md)

**Signature:**
```solidity
function share() external view returns (address);
```

### totalAssets() (inherited from ERC7575)

- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 788:115:641
- **Details**: [function_totalAssets.md](./function_totalAssets.md)

**Signature:**
```solidity
function totalAssets() virtual public view returns (uint256);
```

### convertToShares(uint256) (inherited from ERC7575)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 909:197:641
- **Details**: [function_convertToShares_uint256.md](./function_convertToShares_uint256.md)

**Signature:**
```solidity
function convertToShares(uint256 assets) virtual public view returns (uint256);
```

### convertToAssets(uint256) (inherited from ERC7575)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: public
- **Source Range**: 1112:197:641
- **Details**: [function_convertToAssets_uint256.md](./function_convertToAssets_uint256.md)

**Signature:**
```solidity
function convertToAssets(uint256 shares) virtual public view returns (uint256);
```

### maxDeposit(address) (inherited from ERC7575)

- **Signature**: `maxDeposit(address)`
- **Visibility**: public
- **Source Range**: 1315:108:641
- **Details**: [function_maxDeposit_address.md](./function_maxDeposit_address.md)

**Signature:**
```solidity
function maxDeposit(address) virtual public pure returns (uint256);
```

### maxMint(address) (inherited from ERC7575)

- **Signature**: `maxMint(address)`
- **Visibility**: public
- **Source Range**: 1429:105:641
- **Details**: [function_maxMint_address.md](./function_maxMint_address.md)

**Signature:**
```solidity
function maxMint(address) virtual public pure returns (uint256);
```

### maxWithdraw(address) (inherited from ERC7575)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 1540:131:641
- **Details**: [function_maxWithdraw_address.md](./function_maxWithdraw_address.md)

**Signature:**
```solidity
function maxWithdraw(address owner) virtual public view returns (uint256);
```

### maxRedeem(address) (inherited from ERC7575)

- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 1677:112:641
- **Details**: [function_maxRedeem_address.md](./function_maxRedeem_address.md)

**Signature:**
```solidity
function maxRedeem(address owner) virtual public view returns (uint256);
```

### previewDeposit(uint256) (inherited from ERC7575)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: public
- **Source Range**: 1795:125:641
- **Details**: [function_previewDeposit_uint256.md](./function_previewDeposit_uint256.md)

**Signature:**
```solidity
function previewDeposit(uint256 assets) virtual public view returns (uint256);
```

### previewMint(uint256) (inherited from ERC7575)

- **Signature**: `previewMint(uint256)`
- **Visibility**: public
- **Source Range**: 1926:193:641
- **Details**: [function_previewMint_uint256.md](./function_previewMint_uint256.md)

**Signature:**
```solidity
function previewMint(uint256 shares) virtual public view returns (uint256);
```

### previewWithdraw(uint256) (inherited from ERC7575)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 2125:197:641
- **Details**: [function_previewWithdraw_uint256.md](./function_previewWithdraw_uint256.md)

**Signature:**
```solidity
function previewWithdraw(uint256 assets) virtual public view returns (uint256);
```

### previewRedeem(uint256) (inherited from ERC7575)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 2328:124:641
- **Details**: [function_previewRedeem_uint256.md](./function_previewRedeem_uint256.md)

**Signature:**
```solidity
function previewRedeem(uint256 shares) virtual public view returns (uint256);
```

### deposit(uint256,address) (inherited from ERC7575)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: public
- **Source Range**: 2458:295:641
- **Details**: [function_deposit_uint256_address.md](./function_deposit_uint256_address.md)

**Signature:**
```solidity
function deposit(uint256 assets, address receiver) virtual public returns (uint256 shares);
```

### mint(uint256,address) (inherited from ERC7575)

- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 2759:289:641
- **Details**: [function_mint_uint256_address.md](./function_mint_uint256_address.md)

**Signature:**
```solidity
function mint(uint256 shares, address receiver) virtual public returns (uint256 assets);
```
