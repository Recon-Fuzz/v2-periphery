# Contract: MockERC5115Tester

## Metadata

- **Name**: MockERC5115Tester
- **Type**: Contract
- **Path**: test/recon/mocks/MockERC5115Tester.sol

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

### yieldToken (inherited from ERC5115)

```solidity
MockERC20 public immutable yieldToken
```

**MockERC20**: [lib/setup-helpers/src/MockERC20.sol/contract_MockERC20.md]

### tokensIn (inherited from ERC5115)

```solidity
address[] public tokensIn
```

### tokensOut (inherited from ERC5115)

```solidity
address[] public tokensOut
```

### revertBehaviour

```solidity
RevertType public revertBehaviour
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

### Deposit (inherited from ERC5115)

```solidity
event Deposit(address indexed caller, address indexed receiver, address indexed tokenIn, uint256 amountDeposited, uint256 amountSyOut);
```

### Redeem (inherited from ERC5115)

```solidity
event Redeem(address indexed caller, address indexed receiver, address indexed tokenOut, uint256 amountSyToRedeem, uint256 amountTokenOut);
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 3112:68:639
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address _yieldToken) ERC5115(MockERC20(_yieldToken));
```

### deposit(address,address,uint256,uint256,bool)

- **Signature**: `deposit(address,address,uint256,uint256,bool)`
- **Visibility**: public
- **Source Range**: 3186:431:639
- **Details**: [function_deposit_address_address_uint256_uint256_bool.md](./function_deposit_address_address_uint256_uint256_bool.md)

**Signature:**
```solidity
function deposit(address receiver, address tokenIn, uint256 amountTokenToDeposit, uint256 minSharesOut, bool depositFromInternalBalance) override public returns (uint256 amountSharesOut);
```

### redeem(address,uint256,address,uint256,bool)

- **Signature**: `redeem(address,uint256,address,uint256,bool)`
- **Visibility**: public
- **Source Range**: 3623:663:639
- **Details**: [function_redeem_address_uint256_address_uint256_bool.md](./function_redeem_address_uint256_address_uint256_bool.md)

**Signature:**
```solidity
function redeem(address receiver, uint256 amountSharesToRedeem, address tokenOut, uint256, bool) virtual public returns (uint256 amountTokenOut);
```

### setRevertBehavior(enum RevertType)

- **Signature**: `setRevertBehavior(enum RevertType)`
- **Visibility**: public
- **Source Range**: 4963:86:639
- **Details**: [function_setRevertBehavior_enum_RevertType.md](./function_setRevertBehavior_enum_RevertType.md)

**Signature:**
```solidity
function setRevertBehavior(RevertType rt) public;
```

### simulateLoss(uint256)

- **Signature**: `simulateLoss(uint256)`
- **Visibility**: external
- **Source Range**: 5055:162:639
- **Details**: [function_simulateLoss_uint256.md](./function_simulateLoss_uint256.md)

**Signature:**
```solidity
function simulateLoss(uint256 lossAmount) external;
```

### simulateGain(uint256)

- **Signature**: `simulateGain(uint256)`
- **Visibility**: external
- **Source Range**: 5223:175:639
- **Details**: [function_simulateGain_uint256.md](./function_simulateGain_uint256.md)

**Signature:**
```solidity
function simulateGain(uint256 gainAmount) external;
```

### setLossOnWithdraw(uint256)

- **Signature**: `setLossOnWithdraw(uint256)`
- **Visibility**: public
- **Source Range**: 5486:188:639
- **Details**: [function_setLossOnWithdraw_uint256.md](./function_setLossOnWithdraw_uint256.md)

**Signature:**
```solidity
/// @dev Set the loss on withdraw as percentage of the assets being withdrawn
function setLossOnWithdraw(uint256 _lossOnWithdraw) public;
```

### increaseYield(uint256)

- **Signature**: `increaseYield(uint256)`
- **Visibility**: public
- **Source Range**: 5680:316:639
- **Details**: [function_increaseYield_uint256.md](./function_increaseYield_uint256.md)

**Signature:**
```solidity
function increaseYield(uint256 increasePercentageFP4) public;
```

### decreaseYield(uint256)

- **Signature**: `decreaseYield(uint256)`
- **Visibility**: public
- **Source Range**: 6002:333:639
- **Details**: [function_decreaseYield_uint256.md](./function_decreaseYield_uint256.md)

**Signature:**
```solidity
function decreaseYield(uint256 decreasePercentageFP4) public;
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

### exchangeRate() (inherited from ERC5115)

- **Signature**: `exchangeRate()`
- **Visibility**: public
- **Source Range**: 1444:215:639
- **Details**: [function_exchangeRate.md](./function_exchangeRate.md)

**Signature:**
```solidity
function exchangeRate() virtual public view returns (uint256);
```

### getTokensIn() (inherited from ERC5115)

- **Signature**: `getTokensIn()`
- **Visibility**: public
- **Source Range**: 1665:102:639
- **Details**: [function_getTokensIn.md](./function_getTokensIn.md)

**Signature:**
```solidity
function getTokensIn() virtual public view returns (address[] memory);
```

### getTokensOut() (inherited from ERC5115)

- **Signature**: `getTokensOut()`
- **Visibility**: public
- **Source Range**: 1773:104:639
- **Details**: [function_getTokensOut.md](./function_getTokensOut.md)

**Signature:**
```solidity
function getTokensOut() virtual public view returns (address[] memory);
```

### previewDeposit(address,uint256) (inherited from ERC5115)

- **Signature**: `previewDeposit(address,uint256)`
- **Visibility**: public
- **Source Range**: 1883:458:639
- **Details**: [function_previewDeposit_address_uint256.md](./function_previewDeposit_address_uint256.md)

**Signature:**
```solidity
function previewDeposit(address tokenIn, uint256 amountTokenToDeposit) virtual public view returns (uint256 amountSharesOut);
```

### previewRedeem(address,uint256) (inherited from ERC5115)

- **Signature**: `previewRedeem(address,uint256)`
- **Visibility**: public
- **Source Range**: 2347:458:639
- **Details**: [function_previewRedeem_address_uint256.md](./function_previewRedeem_address_uint256.md)

**Signature:**
```solidity
function previewRedeem(address tokenOut, uint256 amountSharesToRedeem) virtual public view returns (uint256 amountTokenOut);
```
