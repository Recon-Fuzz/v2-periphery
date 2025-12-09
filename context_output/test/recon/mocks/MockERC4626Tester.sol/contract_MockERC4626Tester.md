# Contract: MockERC4626Tester

## Metadata

- **Name**: MockERC4626Tester
- **Type**: Contract
- **Path**: test/recon/mocks/MockERC4626Tester.sol
- **Documentation**: @dev This will use the simplest possible implementation initially to allow getting coverage and will be expanded on
   as necessary for testing potentially more interesting behaviors
   @dev Note that blindspots not testable with this current implementation are covered in the ERC4626-integrations.md
   file

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

### asset (inherited from ERC4626)

```solidity
MockERC20 public immutable asset
```

**MockERC20**: [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

### revertBehaviours

```solidity
mapping(FunctionType => RevertType) public revertBehaviours
```

### decimalsOffset

```solidity
uint8 public decimalsOffset
```

### totalLosses

```solidity
/// @dev Track total losses
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

### MAX_BPS

```solidity
uint256 public MAX_BPS = 10_000
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

### Deposit (inherited from ERC4626)

```solidity
event Deposit(address indexed caller, address indexed owner, uint256 assets, uint256 shares);
```

### Withdraw (inherited from ERC4626)

```solidity
event Withdraw(address indexed caller, address indexed receiver, address indexed owner, uint256 assets, uint256 shares);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 4763:58:637
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address _asset) ERC4626(MockERC20(_asset));
```

### deposit(uint256,address)

- **Signature**: `deposit(uint256,address)`
- **Visibility**: public
- **Source Range**: 4917:213:637
- **Details**: [function_deposit_uint256_address.md](./function_deposit_uint256_address.md)

**Signature:**
```solidity
/// @dev Deposit assets, reverts as specified
function deposit(uint256 assets, address receiver) override public returns (uint256);
```

### mint(uint256,address)

- **Signature**: `mint(uint256,address)`
- **Visibility**: public
- **Source Range**: 5183:204:637
- **Details**: [function_mint_uint256_address.md](./function_mint_uint256_address.md)

**Signature:**
```solidity
/// @dev Mint shares, reverts as specified
function mint(uint256 shares, address receiver) override public returns (uint256);
```

### withdraw(uint256,address,address)

- **Signature**: `withdraw(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 5444:404:637
- **Details**: [function_withdraw_uint256_address_address.md](./function_withdraw_uint256_address_address.md)

**Signature:**
```solidity
/// @dev Withdraw assets, reverts as specified
function withdraw(uint256 assets, address receiver, address owner) override public returns (uint256);
```

### redeem(uint256,address,address)

- **Signature**: `redeem(uint256,address,address)`
- **Visibility**: public
- **Source Range**: 5903:403:637
- **Details**: [function_redeem_uint256_address_address.md](./function_redeem_uint256_address_address.md)

**Signature:**
```solidity
/// @dev Redeem shares, reverts as specified
function redeem(uint256 shares, address receiver, address owner) override public returns (uint256);
```

### previewDeposit(uint256)

- **Signature**: `previewDeposit(uint256)`
- **Visibility**: public
- **Source Range**: 6363:204:637
- **Details**: [function_previewDeposit_uint256.md](./function_previewDeposit_uint256.md)

**Signature:**
```solidity
/// @dev Preview deposit, reverts as specified
function previewDeposit(uint256 assets) override public view returns (uint256);
```

### previewMint(uint256)

- **Signature**: `previewMint(uint256)`
- **Visibility**: public
- **Source Range**: 6621:195:637
- **Details**: [function_previewMint_uint256.md](./function_previewMint_uint256.md)

**Signature:**
```solidity
/// @dev Preview mint, reverts as specified
function previewMint(uint256 shares) override public view returns (uint256);
```

### previewWithdraw(uint256)

- **Signature**: `previewWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 6874:207:637
- **Details**: [function_previewWithdraw_uint256.md](./function_previewWithdraw_uint256.md)

**Signature:**
```solidity
/// @dev Preview withdraw, reverts as specified
function previewWithdraw(uint256 assets) override public view returns (uint256);
```

### previewRedeem(uint256)

- **Signature**: `previewRedeem(uint256)`
- **Visibility**: public
- **Source Range**: 7137:201:637
- **Details**: [function_previewRedeem_uint256.md](./function_previewRedeem_uint256.md)

**Signature:**
```solidity
/// @dev Preview redeem, reverts as specified
function previewRedeem(uint256 shares) override public view returns (uint256);
```

### setRevertBehavior(enum FunctionType,enum RevertType)

- **Signature**: `setRevertBehavior(enum FunctionType,enum RevertType)`
- **Visibility**: public
- **Source Range**: 8290:108:637
- **Details**: [function_setRevertBehavior_enum_FunctionType_enum_RevertType.md](./function_setRevertBehavior_enum_FunctionType_enum_RevertType.md)

**Signature:**
```solidity
/// @dev Specify the revert behavior on each function
function setRevertBehavior(FunctionType ft, RevertType rt) public;
```

### simulateLoss(uint256)

- **Signature**: `simulateLoss(uint256)`
- **Visibility**: external
- **Source Range**: 8455:157:637
- **Details**: [function_simulateLoss_uint256.md](./function_simulateLoss_uint256.md)

**Signature:**
```solidity
/// @dev Simulate a loss on the vault's assets
function simulateLoss(uint256 lossAmount) external;
```

### simulateGain(uint256)

- **Signature**: `simulateGain(uint256)`
- **Visibility**: external
- **Source Range**: 8704:170:637
- **Details**: [function_simulateGain_uint256.md](./function_simulateGain_uint256.md)

**Signature:**
```solidity
/// @dev Simulate a gain on the vault's assets (similar to Yearn's profit taking)
function simulateGain(uint256 gainAmount) external;
```

### setLossOnWithdraw(uint256)

- **Signature**: `setLossOnWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 8962:188:637
- **Details**: [function_setLossOnWithdraw_uint256.md](./function_setLossOnWithdraw_uint256.md)

**Signature:**
```solidity
/// @dev Set the loss on withdraw as percentage of the assets being withdrawn
function setLossOnWithdraw(uint256 _lossOnWithdraw) public;
```

### setDecimalsOffset(uint8)

- **Signature**: `setDecimalsOffset(uint8)`
- **Visibility**: external
- **Source Range**: 9223:202:637
- **Details**: [function_setDecimalsOffset_uint8.md](./function_setDecimalsOffset_uint8.md)

**Signature:**
```solidity
/// @dev Set the decimal offset. Only possible with no supply.
function setDecimalsOffset(uint8 targetDecimalsOffset) external;
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

### totalAssets() (inherited from ERC4626)

- **Signature**: `totalAssets()`
- **Visibility**: public
- **Source Range**: 1620:115:637
- **Details**: [function_totalAssets.md](./function_totalAssets.md)

**Signature:**
```solidity
function totalAssets() virtual public view returns (uint256);
```

### convertToShares(uint256) (inherited from ERC4626)

- **Signature**: `convertToShares(uint256)`
- **Visibility**: public
- **Source Range**: 1741:197:637
- **Details**: [function_convertToShares_uint256.md](./function_convertToShares_uint256.md)

**Signature:**
```solidity
function convertToShares(uint256 assets) virtual public view returns (uint256);
```

### convertToAssets(uint256) (inherited from ERC4626)

- **Signature**: `convertToAssets(uint256)`
- **Visibility**: public
- **Source Range**: 1944:197:637
- **Details**: [function_convertToAssets_uint256.md](./function_convertToAssets_uint256.md)

**Signature:**
```solidity
function convertToAssets(uint256 shares) virtual public view returns (uint256);
```

### maxDeposit(address) (inherited from ERC4626)

- **Signature**: `maxDeposit(address)`
- **Visibility**: public
- **Source Range**: 2810:108:637
- **Details**: [function_maxDeposit_address.md](./function_maxDeposit_address.md)

**Signature:**
```solidity
function maxDeposit(address) virtual public view returns (uint256);
```

### maxMint(address) (inherited from ERC4626)

- **Signature**: `maxMint(address)`
- **Visibility**: public
- **Source Range**: 2924:105:637
- **Details**: [function_maxMint_address.md](./function_maxMint_address.md)

**Signature:**
```solidity
function maxMint(address) virtual public view returns (uint256);
```

### maxWithdraw(address) (inherited from ERC4626)

- **Signature**: `maxWithdraw(address)`
- **Visibility**: public
- **Source Range**: 3035:131:637
- **Details**: [function_maxWithdraw_address.md](./function_maxWithdraw_address.md)

**Signature:**
```solidity
function maxWithdraw(address owner) virtual public view returns (uint256);
```

### maxRedeem(address) (inherited from ERC4626)

- **Signature**: `maxRedeem(address)`
- **Visibility**: public
- **Source Range**: 3172:112:637
- **Details**: [function_maxRedeem_address.md](./function_maxRedeem_address.md)

**Signature:**
```solidity
function maxRedeem(address owner) virtual public view returns (uint256);
```
