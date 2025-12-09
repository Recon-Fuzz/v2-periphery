# Contract: SuperVault5115Tests

## Metadata

- **Name**: SuperVault5115Tests
- **Type**: Contract
- **Path**: test/integration/SuperVault/SuperVault5115Tests.t.sol

## State Variables

### SUPER_ORACLE_KEY (inherited from PeripheryConstants)

```solidity
string public constant SUPER_ORACLE_KEY = "SuperOracle"
```

### SUPER_GOVERNOR_KEY (inherited from PeripheryConstants)

```solidity
string public constant SUPER_GOVERNOR_KEY = "SuperGovernor"
```

### SUPER_BANK_KEY (inherited from PeripheryConstants)

```solidity
string public constant SUPER_BANK_KEY = "SuperBank"
```

### SUPER_VAULT_AGGREGATOR_KEY (inherited from PeripheryConstants)

```solidity
string public constant SUPER_VAULT_AGGREGATOR_KEY = "SUPER_VAULT_AGGREGATOR"
```

### ECDSAPPS_ORACLE_KEY (inherited from PeripheryConstants)

```solidity
string public constant ECDSAPPS_ORACLE_KEY = "ECDSAPPS_ORACLE"
```

### ECDSAPPS_ORACLE_VERSION (inherited from PeripheryConstants)

```solidity
string public constant ECDSAPPS_ORACLE_VERSION = "1.0"
```

### EMERGENCY_ADMIN_KEY (inherited from PeripheryConstants)

```solidity
uint256 public constant EMERGENCY_ADMIN_KEY = 0x6
```

### ORACLE_ETH_TO_USD_KEY (inherited from PeripheryConstants)

```solidity
string public constant ORACLE_ETH_TO_USD_KEY = "ORACLE_ETH_TO_USD"
```

### ORACLE_USD_TO_UP_KEY (inherited from PeripheryConstants)

```solidity
string public constant ORACLE_USD_TO_UP_KEY = "ORACLE_USD_TO_UP"
```

### ORACLE_GAS_TO_ETH_KEY (inherited from PeripheryConstants)

```solidity
string public constant ORACLE_GAS_TO_ETH_KEY = "ORACLE_GAS_TO_ETH"
```

### CHAIN_1_POLYMER_PROVER (inherited from PeripheryConstants)

```solidity
address public constant CHAIN_1_POLYMER_PROVER = 0x441f16587d8a8cACE647352B24E1Aefa55ACEA76
```

### CHAIN_10_POLYMER_PROVER (inherited from PeripheryConstants)

```solidity
address public constant CHAIN_10_POLYMER_PROVER = address(0)
```

### CHAIN_8453_POLYMER_PROVER (inherited from PeripheryConstants)

```solidity
address public constant CHAIN_8453_POLYMER_PROVER = address(0)
```

### ORACLE_ETH_TO_USD (inherited from PeripheryConstants)

```solidity
address public constant ORACLE_ETH_TO_USD = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
```

### ORACLE_USD_TO_UP (inherited from PeripheryConstants)

```solidity
address public constant ORACLE_USD_TO_UP = address(0)
```

### ORACLE_GAS_TO_ETH (inherited from PeripheryConstants)

```solidity
address public constant ORACLE_GAS_TO_ETH = address(0x169E633A2D1E6c10dD91238Ba11c4A708dfEF37C)
```

### CHAIN_1_USDT (inherited from PeripheryConstants)

```solidity
address public constant CHAIN_1_USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7
```

### CHAIN_1_MERKL_CORE (inherited from PeripheryConstants)

```solidity
address public constant CHAIN_1_MERKL_CORE = 0x0E632a15EbCBa463151B5367B4fCF91313e389a6
```

### CHAIN_1_MERKL_TREE_UPDATER_EOA (inherited from PeripheryConstants)

```solidity
address public constant CHAIN_1_MERKL_TREE_UPDATER_EOA = 0x435046800Fb9149eE65159721A92cB7d50a7534b
```

### auxiliary (inherited from AuxiliaryFactory)

```solidity
/// @notice Stores the auxiliary contracts.
Auxiliary public auxiliary
```

### VM_ADDRESS (inherited from CommonBase)

```solidity
/// @dev Cheat code address.
///  Calculated as `address(uint160(uint256(keccak256("hevm cheat code"))))`.
address internal constant VM_ADDRESS = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D
```

### CONSOLE (inherited from CommonBase)

```solidity
/// @dev console.sol and console2.sol work by executing a staticcall to this address.
///  Calculated as `address(uint160(uint88(bytes11("console.log"))))`.
address internal constant CONSOLE = 0x000000000000000000636F6e736F6c652e6c6f67
```

### CREATE2_FACTORY (inherited from CommonBase)

```solidity
/// @dev Used when deploying with create2.
///  Taken from https://github.com/Arachnid/deterministic-deployment-proxy.
address internal constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### DEFAULT_SENDER (inherited from CommonBase)

```solidity
/// @dev The default address for tx.origin and msg.sender.
///  Calculated as `address(uint160(uint256(keccak256("foundry default caller"))))`.
address internal constant DEFAULT_SENDER = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38
```

### DEFAULT_TEST_CONTRACT (inherited from CommonBase)

```solidity
/// @dev The address of the first contract `CREATE`d by a running test contract.
///  When running tests, each test contract is `CREATE`d by `DEFAULT_SENDER` with nonce 1.
///  Calculated as `VM.computeCreateAddress(VM.computeCreateAddress(DEFAULT_SENDER, 1), 1)`.
address internal constant DEFAULT_TEST_CONTRACT = 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
```

### MULTICALL3_ADDRESS (inherited from CommonBase)

```solidity
/// @dev Deterministic deployment address of the Multicall3 contract.
///  Taken from https://www.multicall3.com.
address internal constant MULTICALL3_ADDRESS = 0xcA11bde05977b3631167028862bE2a173976CA11
```

### SECP256K1_ORDER (inherited from CommonBase)

```solidity
/// @dev The order of the secp256k1 curve.
uint256 internal constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from CommonBase)

```solidity
uint256 internal constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### vm (inherited from CommonBase)

```solidity
Vm internal constant vm = Vm(VM_ADDRESS)
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### stdstore (inherited from CommonBase)

```solidity
StdStorage internal stdstore
```

### vm (inherited from StdAssertions)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### FAILED_SLOT (inherited from StdAssertions)

```solidity
bytes32 private constant FAILED_SLOT = bytes32("failed")
```

### _failed (inherited from StdAssertions)

```solidity
bool private _failed
```

### vm (inherited from StdChains)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### stdChainsInitialized (inherited from StdChains)

```solidity
bool private stdChainsInitialized
```

### chains (inherited from StdChains)

```solidity
mapping(string => Chain) private chains
```

### defaultRpcUrls (inherited from StdChains)

```solidity
mapping(string => string) private defaultRpcUrls
```

### idToAlias (inherited from StdChains)

```solidity
mapping(uint256 => string) private idToAlias
```

### fallbackToDefaultRpcUrls (inherited from StdChains)

```solidity
bool private fallbackToDefaultRpcUrls = true
```

### vm (inherited from StdCheatsSafe)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### UINT256_MAX (inherited from StdCheatsSafe)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### gasMeteringOff (inherited from StdCheatsSafe)

```solidity
bool private gasMeteringOff
```

### stdstore (inherited from StdCheats)

```solidity
StdStorage private stdstore
```

### vm (inherited from StdCheats)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### CONSOLE2_ADDRESS (inherited from StdCheats)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### _excludedContracts (inherited from StdInvariant)

```solidity
address[] private _excludedContracts
```

### _excludedSenders (inherited from StdInvariant)

```solidity
address[] private _excludedSenders
```

### _targetedContracts (inherited from StdInvariant)

```solidity
address[] private _targetedContracts
```

### _targetedSenders (inherited from StdInvariant)

```solidity
address[] private _targetedSenders
```

### _excludedArtifacts (inherited from StdInvariant)

```solidity
string[] private _excludedArtifacts
```

### _targetedArtifacts (inherited from StdInvariant)

```solidity
string[] private _targetedArtifacts
```

### _targetedArtifactSelectors (inherited from StdInvariant)

```solidity
FuzzArtifactSelector[] private _targetedArtifactSelectors
```

### _excludedSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _excludedSelectors
```

### _targetedSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _targetedSelectors
```

### _targetedInterfaces (inherited from StdInvariant)

```solidity
FuzzInterface[] private _targetedInterfaces
```

### multicall (inherited from StdUtils)

```solidity
IMulticall3 private constant multicall = IMulticall3(0xcA11bde05977b3631167028862bE2a173976CA11)
```

**IMulticall3**: [lib/forge-std/src/interfaces/IMulticall3.sol/interface_IMulticall3.md]

### vm (inherited from StdUtils)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### CONSOLE2_ADDRESS (inherited from StdUtils)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### INT256_MIN_ABS (inherited from StdUtils)

```solidity
uint256 private constant INT256_MIN_ABS = 57896044618658097711785492504343953926634992332820282019728792003956564819968
```

### SECP256K1_ORDER (inherited from StdUtils)

```solidity
uint256 private constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from StdUtils)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### CREATE2_FACTORY (inherited from StdUtils)

```solidity
address private constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### IS_TEST (inherited from Test)

```solidity
bool public IS_TEST = true
```

### SMALL (inherited from Constants)

```solidity
uint256 public constant SMALL = 1 ether
```

### MEDIUM (inherited from Constants)

```solidity
uint256 public constant MEDIUM = 5 ether
```

### LARGE (inherited from Constants)

```solidity
uint256 public constant LARGE = 20 ether
```

### EXTRA_LARGE (inherited from Constants)

```solidity
uint256 public constant EXTRA_LARGE = 100 ether
```

### USER1_KEY (inherited from Constants)

```solidity
uint256 public constant USER1_KEY = 0x1
```

### USER2_KEY (inherited from Constants)

```solidity
uint256 public constant USER2_KEY = 0x2
```

### MANAGER_KEY (inherited from Constants)

```solidity
uint256 public constant MANAGER_KEY = 0x3
```

### ACROSS_RELAYER_KEY (inherited from Constants)

```solidity
uint256 public constant ACROSS_RELAYER_KEY = 0x4
```

### STRATEGIST_KEY (inherited from Constants)

```solidity
uint256 public constant STRATEGIST_KEY = 0x5
```

### FEE_RECIPIENT_KEY (inherited from Constants)

```solidity
uint256 public constant FEE_RECIPIENT_KEY = 0x7
```

### TREASURY_KEY (inherited from Constants)

```solidity
uint256 public constant TREASURY_KEY = 0x8
```

### SUPER_BUNDLER_KEY (inherited from Constants)

```solidity
uint256 public constant SUPER_BUNDLER_KEY = 0x9
```

### BANK_MANAGER_KEY (inherited from Constants)

```solidity
uint256 public constant BANK_MANAGER_KEY = 0x10
```

### VALIDATOR_KEY (inherited from Constants)

```solidity
uint256 public constant VALIDATOR_KEY = 0x11
```

### ROLES_ID (inherited from Constants)

```solidity
bytes32 public constant ROLES_ID = keccak256("ROLES")
```

### ETHEREUM_KEY (inherited from Constants)

```solidity
string public constant ETHEREUM_KEY = "Ethereum"
```

### OPTIMISM_KEY (inherited from Constants)

```solidity
string public constant OPTIMISM_KEY = "Optimism"
```

### BASE_KEY (inherited from Constants)

```solidity
string public constant BASE_KEY = "Base"
```

### ETH (inherited from Constants)

```solidity
uint64 public constant ETH = 1
```

### OP (inherited from Constants)

```solidity
uint64 public constant OP = 10
```

### BASE (inherited from Constants)

```solidity
uint64 public constant BASE = 8453
```

### ETH_BLOCK (inherited from Constants)

```solidity
uint256 public constant ETH_BLOCK = 21_929_476
```

### OP_BLOCK (inherited from Constants)

```solidity
uint256 public constant OP_BLOCK = 132_481_010
```

### BASE_BLOCK (inherited from Constants)

```solidity
uint256 public constant BASE_BLOCK = 26_885_730
```

### ACCOUNT_COUNT (inherited from Constants)

```solidity
uint256 public constant ACCOUNT_COUNT = 30
```

### ENTRYPOINT_ADDR (inherited from Constants)

```solidity
address public constant ENTRYPOINT_ADDR = 0x0000000071727De22E5E9d8BAf0edAc6f37da032
```

### SAFE_REGISTRY_ADDR (inherited from Constants)

```solidity
address public constant SAFE_REGISTRY_ADDR = 0x000000000069E2a187AEFFb852bF3cCdC95151B2
```

### ETHEREUM_RPC_URL_KEY (inherited from Constants)

```solidity
string public constant ETHEREUM_RPC_URL_KEY = "ETHEREUM_RPC_URL"
```

### OPTIMISM_RPC_URL_KEY (inherited from Constants)

```solidity
string public constant OPTIMISM_RPC_URL_KEY = "OPTIMISM_RPC_URL"
```

### BASE_RPC_URL_KEY (inherited from Constants)

```solidity
string public constant BASE_RPC_URL_KEY = "BASE_RPC_URL"
```

### ONE_INCH_API_KEY (inherited from Constants)

```solidity
string public constant ONE_INCH_API_KEY = "ONE_INCH_API_KEY"
```

### SWAP_ODOSV2_HOOK_KEY (inherited from Constants)

```solidity
string public constant SWAP_ODOSV2_HOOK_KEY = "SwapOdosV2Hook"
```

### MOCK_SWAP_ODOS_HOOK_KEY (inherited from Constants)

```solidity
string public constant MOCK_SWAP_ODOS_HOOK_KEY = "MockSwapOdosHook"
```

### MOCK_APPROVE_AND_SWAP_ODOS_HOOK_KEY (inherited from Constants)

```solidity
string public constant MOCK_APPROVE_AND_SWAP_ODOS_HOOK_KEY = "MockApproveAndSwapOdosHook"
```

### APPROVE_ERC20_HOOK_KEY (inherited from Constants)

```solidity
string public constant APPROVE_ERC20_HOOK_KEY = "ApproveERC20Hook"
```

### APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY = "ApproveAndDeposit4626VaultHook"
```

### DEPOSIT_4626_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant DEPOSIT_4626_VAULT_HOOK_KEY = "Deposit4626VaultHook"
```

### REDEEM_4626_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant REDEEM_4626_VAULT_HOOK_KEY = "Redeem4626VaultHook"
```

### TRANSFER_ERC20_HOOK_KEY (inherited from Constants)

```solidity
string public constant TRANSFER_ERC20_HOOK_KEY = "TransferERC20Hook"
```

### APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY = "ApproveAndDeposit5115VaultHook"
```

### DEPOSIT_5115_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant DEPOSIT_5115_VAULT_HOOK_KEY = "Deposit5115VaultHook"
```

### REDEEM_5115_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant REDEEM_5115_VAULT_HOOK_KEY = "Redeem5115VaultHook"
```

### REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY = "RequestDeposit7540VaultHook"
```

### REQUEST_REDEEM_7540_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant REQUEST_REDEEM_7540_VAULT_HOOK_KEY = "RequestRedeem7540VaultHook"
```

### DEPOSIT_7540_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant DEPOSIT_7540_VAULT_HOOK_KEY = "Deposit7540VaultHook"
```

### WITHDRAW_7540_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant WITHDRAW_7540_VAULT_HOOK_KEY = "Withdraw7540VaultHook"
```

### REDEEM_7540_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant REDEEM_7540_VAULT_HOOK_KEY = "Redeem7540VaultHook"
```

### CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY (inherited from Constants)

```solidity
string public constant CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY = "CancelDepositRequest7540Hook"
```

### CANCEL_REDEEM_REQUEST_7540_HOOK_KEY (inherited from Constants)

```solidity
string public constant CANCEL_REDEEM_REQUEST_7540_HOOK_KEY = "CancelRedeemRequest7540Hook"
```

### CLAIM_CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY (inherited from Constants)

```solidity
string public constant CLAIM_CANCEL_DEPOSIT_REQUEST_7540_HOOK_KEY = "ClaimCancelDepositRequest7540Hook"
```

### CLAIM_CANCEL_REDEEM_REQUEST_7540_HOOK_KEY (inherited from Constants)

```solidity
string public constant CLAIM_CANCEL_REDEEM_REQUEST_7540_HOOK_KEY = "ClaimCancelRedeemRequest7540Hook"
```

### APPROVE_WITH_PERMIT2_HOOK_KEY (inherited from Constants)

```solidity
string public constant APPROVE_WITH_PERMIT2_HOOK_KEY = "ApproveWithPermit2Hook"
```

### PERMIT_WITH_PERMIT2_HOOK_KEY (inherited from Constants)

```solidity
string public constant PERMIT_WITH_PERMIT2_HOOK_KEY = "PermitWithPermit2Hook"
```

### BATCH_TRANSFER_FROM_HOOK_KEY (inherited from Constants)

```solidity
string public constant BATCH_TRANSFER_FROM_HOOK_KEY = "BatchTransferFromHook"
```

### OFFRAMP_TOKENS_HOOK_KEY (inherited from Constants)

```solidity
string public constant OFFRAMP_TOKENS_HOOK_KEY = "OfframpTokensHook"
```

### MINT_SUPERPOSITIONS_HOOK_KEY (inherited from Constants)

```solidity
string public constant MINT_SUPERPOSITIONS_HOOK_KEY = "MintSuperPositionsHook"
```

### SWAP_1INCH_HOOK_KEY (inherited from Constants)

```solidity
string public constant SWAP_1INCH_HOOK_KEY = "Swap1InchHook"
```

### ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY (inherited from Constants)

```solidity
string public constant ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY = "AcrossSendFundsAndExecuteOnDstHook"
```

### APPROVE_AND_ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY (inherited from Constants)

```solidity
string public constant APPROVE_AND_ACROSS_SEND_FUNDS_AND_EXECUTE_ON_DST_HOOK_KEY = "ApproveAndAcrossSendFundsAndExecuteOnDstHook"
```

### GEARBOX_STAKE_HOOK_KEY (inherited from Constants)

```solidity
string public constant GEARBOX_STAKE_HOOK_KEY = "GearboxStakeHook"
```

### GEARBOX_UNSTAKE_HOOK_KEY (inherited from Constants)

```solidity
string public constant GEARBOX_UNSTAKE_HOOK_KEY = "GearboxUnstakeHook"
```

### GEARBOX_CLAIM_REWARD_HOOK_KEY (inherited from Constants)

```solidity
string public constant GEARBOX_CLAIM_REWARD_HOOK_KEY = "GearboxClaimRewardHook"
```

### FLUID_CLAIM_REWARD_HOOK_KEY (inherited from Constants)

```solidity
string public constant FLUID_CLAIM_REWARD_HOOK_KEY = "FluidClaimRewardHook"
```

### FLUID_STAKE_HOOK_KEY (inherited from Constants)

```solidity
string public constant FLUID_STAKE_HOOK_KEY = "FluidStakeHook"
```

### FLUID_UNSTAKE_HOOK_KEY (inherited from Constants)

```solidity
string public constant FLUID_UNSTAKE_HOOK_KEY = "FluidUnstakeHook"
```

### SOMELIER_STAKE_HOOK_KEY (inherited from Constants)

```solidity
string public constant SOMELIER_STAKE_HOOK_KEY = "SomelierStakeHook"
```

### SOMELIER_UNBOND_ALL_HOOK_KEY (inherited from Constants)

```solidity
string public constant SOMELIER_UNBOND_ALL_HOOK_KEY = "SomelierUnbondAllHook"
```

### SOMELIER_UNBOND_HOOK_KEY (inherited from Constants)

```solidity
string public constant SOMELIER_UNBOND_HOOK_KEY = "SomelierUnbondHook"
```

### SOMELIER_UNSTAKE_ALL_HOOK_KEY (inherited from Constants)

```solidity
string public constant SOMELIER_UNSTAKE_ALL_HOOK_KEY = "SomelierUnstakeAllHook"
```

### SOMELIER_UNSTAKE_HOOK_KEY (inherited from Constants)

```solidity
string public constant SOMELIER_UNSTAKE_HOOK_KEY = "SomelierUnstakeHook"
```

### YEARN_CLAIM_ONE_REWARD_HOOK_KEY (inherited from Constants)

```solidity
string public constant YEARN_CLAIM_ONE_REWARD_HOOK_KEY = "YearnClaimOneRewardHook"
```

### YEARN_CLAIM_ALL_REWARDS_HOOK_KEY (inherited from Constants)

```solidity
string public constant YEARN_CLAIM_ALL_REWARDS_HOOK_KEY = "YearnClaimAllRewardsHook"
```

### GEARBOX_APPROVE_AND_STAKE_HOOK_KEY (inherited from Constants)

```solidity
string public constant GEARBOX_APPROVE_AND_STAKE_HOOK_KEY = "GearboxApproveAndStakeHook"
```

### APPROVE_AND_SWAP_ODOSV2_HOOK_KEY (inherited from Constants)

```solidity
string public constant APPROVE_AND_SWAP_ODOSV2_HOOK_KEY = "ApproveAndSwapOdosV2Hook"
```

### APPROVE_AND_FLUID_STAKE_HOOK_KEY (inherited from Constants)

```solidity
string public constant APPROVE_AND_FLUID_STAKE_HOOK_KEY = "ApproveAndFluidStakeHook"
```

### APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY (inherited from Constants)

```solidity
string public constant APPROVE_AND_REQUEST_DEPOSIT_7540_VAULT_HOOK_KEY = "ApproveAndRequestDeposit7540VaultHook"
```

### ETHENA_COOLDOWN_SHARES_HOOK_KEY (inherited from Constants)

```solidity
string public constant ETHENA_COOLDOWN_SHARES_HOOK_KEY = "EthenaCooldownSharesHook"
```

### ETHENA_UNSTAKE_HOOK_KEY (inherited from Constants)

```solidity
string public constant ETHENA_UNSTAKE_HOOK_KEY = "EthenaUnstakeHook"
```

### SPECTRA_EXCHANGE_DEPOSIT_HOOK_KEY (inherited from Constants)

```solidity
string public constant SPECTRA_EXCHANGE_DEPOSIT_HOOK_KEY = "SpectraExchangeDepositHook"
```

### SPECTRA_EXCHANGE_REDEEM_HOOK_KEY (inherited from Constants)

```solidity
string public constant SPECTRA_EXCHANGE_REDEEM_HOOK_KEY = "SpectraExchangeRedeemHook"
```

### PENDLE_ROUTER_SWAP_HOOK_KEY (inherited from Constants)

```solidity
string public constant PENDLE_ROUTER_SWAP_HOOK_KEY = "PendleRouterSwapHook"
```

### PENDLE_ROUTER_REDEEM_HOOK_KEY (inherited from Constants)

```solidity
string public constant PENDLE_ROUTER_REDEEM_HOOK_KEY = "PendleRouterRedeemHook"
```

### MORPHO_BORROW_HOOK_KEY (inherited from Constants)

```solidity
string public constant MORPHO_BORROW_HOOK_KEY = "MorphoSupplyAndBorrowHook"
```

### MORPHO_REPAY_HOOK_KEY (inherited from Constants)

```solidity
string public constant MORPHO_REPAY_HOOK_KEY = "MorphoRepayHook"
```

### MORPHO_REPAY_AND_WITHDRAW_HOOK_KEY (inherited from Constants)

```solidity
string public constant MORPHO_REPAY_AND_WITHDRAW_HOOK_KEY = "MorphoRepayAndWithdrawHook"
```

### MARK_ROOT_AS_USED_HOOK_KEY (inherited from Constants)

```solidity
string public constant MARK_ROOT_AS_USED_HOOK_KEY = "MarkAsUsedHook"
```

### MERKL_CLAIM_REWARD_HOOK_KEY (inherited from Constants)

```solidity
string public constant MERKL_CLAIM_REWARD_HOOK_KEY = "MerklClaimRewardHook"
```

### SWAP_UNISWAP_V4_HOOK_KEY (inherited from Constants)

```solidity
string public constant SWAP_UNISWAP_V4_HOOK_KEY = "SwapUniswapV4Hook"
```

### SWAP_UNISWAP_V4_MULTI_HOP_HOOK_KEY (inherited from Constants)

```solidity
string public constant SWAP_UNISWAP_V4_MULTI_HOP_HOOK_KEY = "SwapUniswapV4MultiHopHook"
```

### ACROSS_V3_HELPER_KEY (inherited from Constants)

```solidity
string public constant ACROSS_V3_HELPER_KEY = "AcrossV3Helper"
```

### DEBRIDGE_HELPER_KEY (inherited from Constants)

```solidity
string public constant DEBRIDGE_HELPER_KEY = "DebridgeHelper"
```

### DEBRIDGE_DLN_HELPER_KEY (inherited from Constants)

```solidity
string public constant DEBRIDGE_DLN_HELPER_KEY = "DebridgeDlnHelper"
```

### DEBRIDGE_SEND_ORDER_AND_EXECUTE_ON_DST_HOOK_KEY (inherited from Constants)

```solidity
string public constant DEBRIDGE_SEND_ORDER_AND_EXECUTE_ON_DST_HOOK_KEY = "DeBridgeSendOrderAndExecuteOnDstHook"
```

### DEBRIDGE_CANCEL_ORDER_HOOK_KEY (inherited from Constants)

```solidity
string public constant DEBRIDGE_CANCEL_ORDER_HOOK_KEY = "DeBridgeCancelOrderHook"
```

### SUPER_DESTINATION_EXECUTOR_KEY (inherited from Constants)

```solidity
string public constant SUPER_DESTINATION_EXECUTOR_KEY = "SuperDestinationExecutor"
```

### SUPER_SENDER_CREATOR_KEY (inherited from Constants)

```solidity
string public constant SUPER_SENDER_CREATOR_KEY = "SuperSenderCreator"
```

### SUPER_7702_SENDER_CREATOR_KEY (inherited from Constants)

```solidity
string public constant SUPER_7702_SENDER_CREATOR_KEY = "Super7702SenderCreator"
```

### SUPER_LEDGER_KEY (inherited from Constants)

```solidity
string public constant SUPER_LEDGER_KEY = "SuperLedger"
```

### ERC1155_LEDGER_KEY (inherited from Constants)

```solidity
string public constant ERC1155_LEDGER_KEY = "ERC5115Ledger"
```

### SUPER_LEDGER_CONFIGURATION_KEY (inherited from Constants)

```solidity
string public constant SUPER_LEDGER_CONFIGURATION_KEY = "SuperLedgerConfiguration"
```

### SUPER_EXECUTOR_KEY (inherited from Constants)

```solidity
string public constant SUPER_EXECUTOR_KEY = "SuperExecutor"
```

### MOCK_TARGET_EXECUTOR_KEY (inherited from Constants)

```solidity
string public constant MOCK_TARGET_EXECUTOR_KEY = "MockTargetExecutor"
```

### ACROSS_V3_ADAPTER_KEY (inherited from Constants)

```solidity
string public constant ACROSS_V3_ADAPTER_KEY = "AcrossV3Adapter"
```

### DEBRIDGE_ADAPTER_KEY (inherited from Constants)

```solidity
string public constant DEBRIDGE_ADAPTER_KEY = "DebridgeAdapter"
```

### SUPER_MERKLE_VALIDATOR_KEY (inherited from Constants)

```solidity
string public constant SUPER_MERKLE_VALIDATOR_KEY = "SuperValidator"
```

### SUPER_DESTINATION_VALIDATOR_KEY (inherited from Constants)

```solidity
string public constant SUPER_DESTINATION_VALIDATOR_KEY = "SuperDestinationValidator"
```

### ERC4626_YIELD_SOURCE_ORACLE_KEY (inherited from Constants)

```solidity
string public constant ERC4626_YIELD_SOURCE_ORACLE_KEY = "ERC4626YieldSourceOracle"
```

### ERC5115_YIELD_SOURCE_ORACLE_KEY (inherited from Constants)

```solidity
string public constant ERC5115_YIELD_SOURCE_ORACLE_KEY = "ERC5115YieldSourceOracle"
```

### ERC7540_YIELD_SOURCE_ORACLE_KEY (inherited from Constants)

```solidity
string public constant ERC7540_YIELD_SOURCE_ORACLE_KEY = "ERC7540YieldSourceOracle"
```

### STAKING_YIELD_SOURCE_ORACLE_KEY (inherited from Constants)

```solidity
string public constant STAKING_YIELD_SOURCE_ORACLE_KEY = "StakingYieldSourceOracle"
```

### SUPER_NATIVE_PAYMASTER_KEY (inherited from Constants)

```solidity
string public constant SUPER_NATIVE_PAYMASTER_KEY = "SuperNativePaymaster"
```

### DAI_KEY (inherited from Constants)

```solidity
string public constant DAI_KEY = "DAI"
```

### USDC_KEY (inherited from Constants)

```solidity
string public constant USDC_KEY = "USDC"
```

### WETH_KEY (inherited from Constants)

```solidity
string public constant WETH_KEY = "WETH"
```

### SUSDE_KEY (inherited from Constants)

```solidity
string public constant SUSDE_KEY = "SUSDe"
```

### USDE_KEY (inherited from Constants)

```solidity
string public constant USDE_KEY = "USDe"
```

### USDCE_KEY (inherited from Constants)

```solidity
string public constant USDCE_KEY = "USDCe"
```

### GEAR_KEY (inherited from Constants)

```solidity
string public constant GEAR_KEY = "GEAR"
```

### WST_ETH_KEY (inherited from Constants)

```solidity
string public constant WST_ETH_KEY = "wstETH"
```

### CHAIN_1_WBTC (inherited from Constants)

```solidity
address public constant CHAIN_1_WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599
```

### CHAIN_1_DAI (inherited from Constants)

```solidity
address public constant CHAIN_1_DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F
```

### CHAIN_1_USDC (inherited from Constants)

```solidity
address public constant CHAIN_1_USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
```

### CHAIN_1_WETH (inherited from Constants)

```solidity
address public constant CHAIN_1_WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2
```

### CHAIN_1_SUSDE (inherited from Constants)

```solidity
address public constant CHAIN_1_SUSDE = 0x9D39A5DE30e57443BfF2A8307A4256c8797A3497
```

### CHAIN_1_USDE (inherited from Constants)

```solidity
address public constant CHAIN_1_USDE = 0x4c9EDD5852cd905f086C759E8383e09bff1E68B3
```

### CHAIN_1_GEAR (inherited from Constants)

```solidity
address public constant CHAIN_1_GEAR = 0xBa3335588D9403515223F109EdC4eB7269a9Ab5D
```

### CHAIN_1_WST_ETH (inherited from Constants)

```solidity
address public constant CHAIN_1_WST_ETH = 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0
```

### CHAIN_10_DAI (inherited from Constants)

```solidity
address public constant CHAIN_10_DAI = 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1
```

### CHAIN_10_USDC (inherited from Constants)

```solidity
address public constant CHAIN_10_USDC = 0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85
```

### CHAIN_10_WETH (inherited from Constants)

```solidity
address public constant CHAIN_10_WETH = 0x4200000000000000000000000000000000000006
```

### CHAIN_10_USDCE (inherited from Constants)

```solidity
address public constant CHAIN_10_USDCE = 0x7F5c764cBc14f9669B88837ca1490cCa17c31607
```

### CHAIN_8453_DAI (inherited from Constants)

```solidity
address public constant CHAIN_8453_DAI = 0x50c5725949A6F0c72E6C4a641F24049A917DB0Cb
```

### CHAIN_8453_USDC (inherited from Constants)

```solidity
address public constant CHAIN_8453_USDC = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
```

### CHAIN_8453_WETH (inherited from Constants)

```solidity
address public constant CHAIN_8453_WETH = 0x4200000000000000000000000000000000000006
```

### PERMIT2 (inherited from Constants)

```solidity
address public constant PERMIT2 = 0x000000000022D473030F116dDEE9F6B43aC78BA3
```

### ONE_INCH_ROUTER (inherited from Constants)

```solidity
address public constant ONE_INCH_ROUTER = 0x111111125421cA6dc452d289314280a0f8842A65
```

### CHAIN_1_ODOS_ROUTER (inherited from Constants)

```solidity
address public constant CHAIN_1_ODOS_ROUTER = 0xCf5540fFFCdC3d510B18bFcA6d2b9987b0772559
```

### CHAIN_10_ODOS_ROUTER (inherited from Constants)

```solidity
address public constant CHAIN_10_ODOS_ROUTER = 0xCa423977156BB05b13A2BA3b76Bc5419E2fE9680
```

### CHAIN_8453_ODOS_ROUTER (inherited from Constants)

```solidity
address public constant CHAIN_8453_ODOS_ROUTER = 0x19cEeAd7105607Cd444F5ad10dd51356436095a1
```

### MAINNET_V4_POOL_MANAGER (inherited from Constants)

```solidity
address public constant MAINNET_V4_POOL_MANAGER = 0x000000000004444c5dc75cB358380D2e3dE08A90
```

### MAINNET_V4_POSITION_MANAGER (inherited from Constants)

```solidity
address public constant MAINNET_V4_POSITION_MANAGER = 0xbD216513d74C8cf14cf4747E6AaA6420FF64ee9e
```

### MORPHO_KEY (inherited from Constants)

```solidity
string public constant MORPHO_KEY = "Morpho"
```

### MORPHO (inherited from Constants)

```solidity
address public constant MORPHO = 0xBBBBBbbBBb9cC5e90e3b3Af64bdAF62C37EEFFCb
```

### MORPHO_IRM (inherited from Constants)

```solidity
address public constant MORPHO_IRM = 0x46415998764C29aB2a25CbeA6254146D50D22687
```

### MORPHO_ORACLE (inherited from Constants)

```solidity
address public constant MORPHO_ORACLE = 0xD09048c8B568Dbf5f189302beA26c9edABFC4858
```

### MERKL_DISTRIBUTOR (inherited from Constants)

```solidity
address public constant MERKL_DISTRIBUTOR = 0x3Ef3D8bA38EBe18DB133cEc108f4D14CE00Dd9Ae
```

### ERC4626_VAULT_KEY (inherited from Constants)

```solidity
string public constant ERC4626_VAULT_KEY = "ERC4626"
```

### ERC5115_VAULT_KEY (inherited from Constants)

```solidity
string public constant ERC5115_VAULT_KEY = "ERC5115"
```

### AAVE_VAULT_KEY (inherited from Constants)

```solidity
string public constant AAVE_VAULT_KEY = "AaveVault"
```

### ALOE_USDC_VAULT_KEY (inherited from Constants)

```solidity
string public constant ALOE_USDC_VAULT_KEY = "AloeUSDC"
```

### FLUID_VAULT_KEY (inherited from Constants)

```solidity
string public constant FLUID_VAULT_KEY = "FluidVault"
```

### EULER_VAULT_KEY (inherited from Constants)

```solidity
string public constant EULER_VAULT_KEY = "EulerVault"
```

### GEARBOX_VAULT_KEY (inherited from Constants)

```solidity
string public constant GEARBOX_VAULT_KEY = "GearboxVault"
```

### MORPHO_VAULT_KEY (inherited from Constants)

```solidity
string public constant MORPHO_VAULT_KEY = "MorphoVault"
```

### CENTRIFUGE_USDC_VAULT_KEY (inherited from Constants)

```solidity
string public constant CENTRIFUGE_USDC_VAULT_KEY = "CentrifugeUSDC"
```

### MORPHO_GAUNTLET_USDC_PRIME_KEY (inherited from Constants)

```solidity
string public constant MORPHO_GAUNTLET_USDC_PRIME_KEY = "MorphoGauntletUSDCPrime"
```

### MORPHO_GAUNTLET_WETH_CORE_KEY (inherited from Constants)

```solidity
string public constant MORPHO_GAUNTLET_WETH_CORE_KEY = "MorphoGauntletWETHCore"
```

### SPARK_USDC_VAULT_KEY (inherited from Constants)

```solidity
string public constant SPARK_USDC_VAULT_KEY = "SparkUSDCVault"
```

### AAVE_BASE_WETH (inherited from Constants)

```solidity
string public constant AAVE_BASE_WETH = "AaveBaseWeth"
```

### ERC7540_FULLY_ASYNC_KEY (inherited from Constants)

```solidity
string public constant ERC7540_FULLY_ASYNC_KEY = "ERC7540FullyAsync"
```

### PENDLE_ETHENA_KEY (inherited from Constants)

```solidity
string public constant PENDLE_ETHENA_KEY = "PendleEthena"
```

### SUPER_COLLECTIVE_VAULT_KEY (inherited from Constants)

```solidity
string public constant SUPER_COLLECTIVE_VAULT_KEY = "SUPER_COLLECTIVE_VAULT_KEY"
```

### SUPER_GAS_TANK_ID (inherited from Constants)

```solidity
string public constant SUPER_GAS_TANK_ID = "SUPER_GAS_TANK_ID"
```

### CHAIN_1_AAVE_VAULT (inherited from Constants)

```solidity
address public constant CHAIN_1_AAVE_VAULT = 0x73edDFa87C71ADdC275c2b9890f5c3a8480bC9E6
```

### CHAIN_1_FLUID_VAULT (inherited from Constants)

```solidity
address public constant CHAIN_1_FLUID_VAULT = 0x490681095ed277B45377d28cA15Ac41d64583048
```

### CHAIN_1_EULER_VAULT (inherited from Constants)

```solidity
address public constant CHAIN_1_EULER_VAULT = 0x797DD80692c3b2dAdabCe8e30C07fDE5307D48a9
```

### CHAIN_1_MORPHO_VAULT (inherited from Constants)

```solidity
address public constant CHAIN_1_MORPHO_VAULT = 0xdd0f28e19C1780eb6396170735D45153D261490d
```

### CHAIN_1_CENTRIFUGE_USDC (inherited from Constants)

```solidity
address public constant CHAIN_1_CENTRIFUGE_USDC = 0x1d01Ef1997d44206d839b78bA6813f60F1B3A970
```

### CHAIN_1_YEARN_VAULT (inherited from Constants)

```solidity
address public constant CHAIN_1_YEARN_VAULT = 0x028eC7330ff87667b6dfb0D94b954c820195336c
```

### CHAIN_1_PENDLE_ETHENA (inherited from Constants)

```solidity
address public constant CHAIN_1_PENDLE_ETHENA = 0x3Ee118EFC826d30A29645eAf3b2EaaC9E8320185
```

### CHAIN_1_GEARBOX_VAULT (inherited from Constants)

```solidity
address public constant CHAIN_1_GEARBOX_VAULT = 0xda00000035fef4082F78dEF6A8903bee419FbF8E
```

### CHAIN_1_PENDLE_ROUTER (inherited from Constants)

```solidity
address public constant CHAIN_1_PENDLE_ROUTER = 0x888888888889758F76e7103c6CbF23ABbF58F946
```

### CHAIN_1_CUSDO (inherited from Constants)

```solidity
address public constant CHAIN_1_CUSDO = 0xaD55aebc9b8c03FC43cd9f62260391c13c23e7c0
```

### CHAIN_1_USDO (inherited from Constants)

```solidity
address public constant CHAIN_1_USDO = 0x8238884Ec9668Ef77B90C6dfF4D1a9F4F4823BFe
```

### CHAIN_1_PENDLE_SWAP (inherited from Constants)

```solidity
address public constant CHAIN_1_PENDLE_SWAP = 0x313e7Ef7d52f5C10aC04ebaa4d33CDc68634c212
```

### CHAIN_1_SPECTRA_ROUTER (inherited from Constants)

```solidity
address public constant CHAIN_1_SPECTRA_ROUTER = 0xD733e545C65d539f588d7c3793147B497403F0d2
```

### CHAIN_1_SPECTRA_PTT_TOKEN (inherited from Constants)

```solidity
address public constant CHAIN_1_SPECTRA_PTT_TOKEN = 0x3b660B2f136FddF98A081439De483D8712c16ca4
```

### CHAIN_1_SPECTRA_PT_IPOR_USDC (inherited from Constants)

```solidity
address public constant CHAIN_1_SPECTRA_PT_IPOR_USDC = 0xf2C5E30fD95A7363583BCAa932Dbe493765BF74f
```

### CHAIN_10_ALOE_USDC (inherited from Constants)

```solidity
address public constant CHAIN_10_ALOE_USDC = 0x462654Cc90C9124A406080EadaF0bA349eaA4AF9
```

### CHAIN_10_PENDLE_ROUTER (inherited from Constants)

```solidity
address public constant CHAIN_10_PENDLE_ROUTER = 0x888888888889758F76e7103c6CbF23ABbF58F946
```

### CHAIN_10_PENDLE_SWAP (inherited from Constants)

```solidity
address public constant CHAIN_10_PENDLE_SWAP = 0x313e7Ef7d52f5C10aC04ebaa4d33CDc68634c212
```

### CHAIN_10_SPECTRA_ROUTER (inherited from Constants)

```solidity
address public constant CHAIN_10_SPECTRA_ROUTER = 0x7dcDeA738C2765398BaF66e4DbBcD2769F4C00Dc
```

### CHAIN_8453_SPARK_USDC_VAULT (inherited from Constants)

```solidity
address public constant CHAIN_8453_SPARK_USDC_VAULT = 0x7BfA7C4f149E7415b73bdeDfe609237e29CBF34A
```

### CHAIN_8453_SUPER_USDC_VAULT (inherited from Constants)

```solidity
address public constant CHAIN_8453_SUPER_USDC_VAULT = 0xe9F2a5F9f3c846f29066d7fB3564F8E6B6b2D65b
```

### CHAIN_8453_MORPHO_GAUNTLET_USDC_PRIME (inherited from Constants)

```solidity
address public constant CHAIN_8453_MORPHO_GAUNTLET_USDC_PRIME = 0xeE8F4eC5672F09119b96Ab6fB59C27E1b7e44b61
```

### CHAIN_8453_MORPHO_GAUNTLET_WETH_CORE (inherited from Constants)

```solidity
address public constant CHAIN_8453_MORPHO_GAUNTLET_WETH_CORE = 0x6b13c060F13Af1fdB319F52315BbbF3fb1D88844
```

### CHAIN_8453_AAVE_BASE_WETH (inherited from Constants)

```solidity
address public constant CHAIN_8453_AAVE_BASE_WETH = 0x468973e3264F2aEba0417A8f2cD0Ec397E738898
```

### CHAIN_8453_PENDLE_ROUTER (inherited from Constants)

```solidity
address public constant CHAIN_8453_PENDLE_ROUTER = 0x888888888889758F76e7103c6CbF23ABbF58F946
```

### CHAIN_8453_PENDLE_SWAP (inherited from Constants)

```solidity
address public constant CHAIN_8453_PENDLE_SWAP = 0x313e7Ef7d52f5C10aC04ebaa4d33CDc68634c212
```

### CHAIN_8453_SPECTRA_ROUTER (inherited from Constants)

```solidity
address public constant CHAIN_8453_SPECTRA_ROUTER = 0x0FC2fbd3E8391744426C8bE5228b668481C59532
```

### MORPHO_ORACLE_WBTC_USDC (inherited from Constants)

```solidity
address public constant MORPHO_ORACLE_WBTC_USDC = 0xDddd770BADd886dF3864029e4B377B5F6a2B6b83
```

### MORPHO_IRM_WBTC_USDC (inherited from Constants)

```solidity
address public constant MORPHO_IRM_WBTC_USDC = 0x870aC11D48B15DB9a138Cf899d20F13F79Ba00BC
```

### GEARBOX_STAKING_KEY (inherited from Constants)

```solidity
string public constant GEARBOX_STAKING_KEY = "GearboxStaking"
```

### CHAIN_1_GEARBOX_STAKING (inherited from Constants)

```solidity
address public constant CHAIN_1_GEARBOX_STAKING = 0x9ef444a6d7F4A5adcd68FD5329aA5240C90E14d2
```

### CHAIN_1_SPOKE_POOL_V3_ADDRESS (inherited from Constants)

```solidity
address public constant CHAIN_1_SPOKE_POOL_V3_ADDRESS = 0x5c7BCd6E7De5423a257D81B442095A1a6ced35C5
```

### CHAIN_10_SPOKE_POOL_V3_ADDRESS (inherited from Constants)

```solidity
address public constant CHAIN_10_SPOKE_POOL_V3_ADDRESS = 0x6f26Bf09B1C792e3228e5467807a900A503c0281
```

### CHAIN_8453_SPOKE_POOL_V3_ADDRESS (inherited from Constants)

```solidity
address public constant CHAIN_8453_SPOKE_POOL_V3_ADDRESS = 0x09aea4b2242abC8bb4BB78D537A67a245A7bEC64
```

### DEBRIDGE_DLN_SOURCE_ADDRESS (inherited from Constants)

```solidity
address public constant DEBRIDGE_DLN_SOURCE_ADDRESS = 0xeF4fB24aD0916217251F553c0596F8Edc630EB66
```

### DEBRIDGE_DLN_DST (inherited from Constants)

```solidity
address public constant DEBRIDGE_DLN_DST = 0xE7351Fd770A37282b91D153Ee690B63579D6dd7f
```

### NEXUS_ACCOUNT_IMPLEMENTATION_ID (inherited from Constants)

```solidity
string public constant NEXUS_ACCOUNT_IMPLEMENTATION_ID = "biconomy.nexus.1.0.0"
```

### MODE_VALIDATION (inherited from Constants)

```solidity
bytes1 internal constant MODE_VALIDATION = 0x00
```

### CHAIN_1_NEXUS_BOOTSTRAP (inherited from Constants)

```solidity
address public constant CHAIN_1_NEXUS_BOOTSTRAP = 0x000000F5b753Fdd20C5CA2D7c1210b3Ab1EA5903
```

### CHAIN_10_NEXUS_BOOTSTRAP (inherited from Constants)

```solidity
address public constant CHAIN_10_NEXUS_BOOTSTRAP = 0x000000F5b753Fdd20C5CA2D7c1210b3Ab1EA5903
```

### CHAIN_8453_NEXUS_BOOTSTRAP (inherited from Constants)

```solidity
address public constant CHAIN_8453_NEXUS_BOOTSTRAP = 0x000000F5b753Fdd20C5CA2D7c1210b3Ab1EA5903
```

### CHAIN_1_NEXUS_FACTORY (inherited from Constants)

```solidity
address public constant CHAIN_1_NEXUS_FACTORY = 0x000000226cada0d8b36034F5D5c06855F59F6F3A
```

### CHAIN_10_NEXUS_FACTORY (inherited from Constants)

```solidity
address public constant CHAIN_10_NEXUS_FACTORY = 0x000000226cada0d8b36034F5D5c06855F59F6F3A
```

### CHAIN_8453_NEXUS_FACTORY (inherited from Constants)

```solidity
address public constant CHAIN_8453_NEXUS_FACTORY = 0x000000226cada0d8b36034F5D5c06855F59F6F3A
```

### VM_ADDR (inherited from Helpers)

```solidity
address internal constant VM_ADDR = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D
```

### user1 (inherited from Helpers)

```solidity
address public user1
```

### user2 (inherited from Helpers)

```solidity
address public user2
```

### user3 (inherited from Helpers)

```solidity
address public user3
```

### MANAGER (inherited from Helpers)

```solidity
address public constant MANAGER = address(0x9876564321)
```

### TREASURY (inherited from Helpers)

```solidity
address public TREASURY
```

### SUPER_BUNDLER (inherited from Helpers)

```solidity
address public SUPER_BUNDLER
```

### ACROSS_RELAYER (inherited from Helpers)

```solidity
address public ACROSS_RELAYER
```

### SV_MANAGER (inherited from PeripheryHelpers)

```solidity
address public SV_MANAGER
```

### EMERGENCY_ADMIN (inherited from PeripheryHelpers)

```solidity
address public EMERGENCY_ADMIN
```

### VALIDATOR (inherited from PeripheryHelpers)

```solidity
address public VALIDATOR
```

### currentChainId (inherited from MerkleReader)

```solidity
uint256 private currentChainId = 1
```

### basePathForRoot (inherited from MerkleReader)

```solidity
string private basePathForRoot = "/test/utils/merkle/output/jsGeneratedRoot_1"
```

### basePathForTreeDump (inherited from MerkleReader)

```solidity
string private basePathForTreeDump = "/test/utils/merkle/output/jsTreeDump_1"
```

### prepend (inherited from MerkleReader)

```solidity
string private prepend = ".values["
```

### hookNameQueryAppend (inherited from MerkleReader)

```solidity
string private hookNameQueryAppend = "].hookName"
```

### hookAddressQueryAppend (inherited from MerkleReader)

```solidity
string private hookAddressQueryAppend = "].hookAddress"
```

### encodedArgsQueryAppend (inherited from MerkleReader)

```solidity
string private encodedArgsQueryAppend = "].encodedHookArgs"
```

### proofQueryAppend (inherited from MerkleReader)

```solidity
string private proofQueryAppend = "].proof"
```

### _defaultValidator (inherited from RhinestoneModuleKit)

```solidity
/// @notice The default validator used for testing
MockValidator public _defaultValidator
```

**MockValidator**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockValidator.sol/contract_MockValidator.md]

### _defaultSessionValidator (inherited from RhinestoneModuleKit)

```solidity
/// @notice The default stateless validator used for testing smart sessions
MockStatelessValidator public _defaultSessionValidator
```

**MockStatelessValidator**: [lib/v2-core/lib/modulekit/src/module-bases/mocks/MockStatelessValidator.sol/contract_MockStatelessValidator.md]

### isInit (inherited from RhinestoneModuleKit)

```solidity
/// @notice Whether the module kit has been initialized on a specific chain
mapping(uint256 => bool) public isInit
```

### hookLeavesPerChain (inherited from MerkleTreeHelper)

```solidity
mapping(uint64 => bytes32[]) public hookLeavesPerChain
```

### hookProofsPerChain (inherited from MerkleTreeHelper)

```solidity
mapping(uint64 => bytes32[][]) public hookProofsPerChain
```

### hookRootPerChain (inherited from MerkleTreeHelper)

```solidity
mapping(uint64 => bytes32) public hookRootPerChain
```

### API_QUOTE_URL (inherited from OdosAPIParser)

```solidity
string internal constant API_QUOTE_URL = "https://api.odos.xyz/sor/quote/v2"
```

### API_ASSEMBLE_URL (inherited from OdosAPIParser)

```solidity
string internal constant API_ASSEMBLE_URL = "https://api.odos.xyz/sor/assemble"
```

### ADDRESS_LIST_START (inherited from OdosAPIParser)

```solidity
uint256 private constant ADDRESS_LIST_START = 80_084_422_859_880_547_211_683_076_133_703_299_733_277_748_156_566_366_325_829_078_699_459_944_778_998
```

### REDEEM_IBT_FOR_ASSET (inherited from InternalHelpers)

```solidity
bytes1 public constant REDEEM_IBT_FOR_ASSET = bytes1(uint8(SpectraCommands.REDEEM_IBT_FOR_ASSET))
```

### REDEEM_PT_FOR_ASSET (inherited from InternalHelpers)

```solidity
bytes1 public constant REDEEM_PT_FOR_ASSET = bytes1(uint8(SpectraCommands.REDEEM_PT_FOR_ASSET))
```

### TRANSFER_SPEC_VERSION (inherited from InternalHelpers)

```solidity
uint32 public constant TRANSFER_SPEC_VERSION = 1
```

### MAX_BLOCK_HEIGHT (inherited from InternalHelpers)

```solidity
uint256 public constant MAX_BLOCK_HEIGHT = 10_000
```

### TRANSFER_SPEC_SOURCE_DOMAIN (inherited from InternalHelpers)

```solidity
uint32 public constant TRANSFER_SPEC_SOURCE_DOMAIN = 1
```

### TRANSFER_SPEC_DESTINATION_DOMAIN (inherited from InternalHelpers)

```solidity
uint32 public constant TRANSFER_SPEC_DESTINATION_DOMAIN = 2
```

### ATTESTATION_MAGIC (inherited from InternalHelpers)

```solidity
bytes4 public constant ATTESTATION_MAGIC = 0xff6fb334
```

### TRANSFER_SPEC_MAGIC (inherited from InternalHelpers)

```solidity
bytes4 public constant TRANSFER_SPEC_MAGIC = 0xca85def7
```

### ATTESTATION_SET_MAGIC (inherited from InternalHelpers)

```solidity
bytes4 public constant ATTESTATION_SET_MAGIC = 0x1e12db71
```

### chainIds (inherited from BaseTest)

```solidity
uint64[] public chainIds = [ETH, OP, BASE]
```

### chainsNames (inherited from BaseTest)

```solidity
string[] public chainsNames = [ETHEREUM_KEY, OPTIMISM_KEY, BASE_KEY]
```

### underlyingTokens (inherited from BaseTest)

```solidity
string[] public underlyingTokens = [DAI_KEY, USDC_KEY, WETH_KEY, SUSDE_KEY, USDE_KEY]
```

### spokePoolV3Addresses (inherited from BaseTest)

```solidity
address[] public spokePoolV3Addresses = [CHAIN_1_SPOKE_POOL_V3_ADDRESS, CHAIN_10_SPOKE_POOL_V3_ADDRESS, CHAIN_8453_SPOKE_POOL_V3_ADDRESS]
```

### SPOKE_POOL_V3_ADDRESSES (inherited from BaseTest)

```solidity
mapping(uint64 => address) public SPOKE_POOL_V3_ADDRESSES
```

### DEBRIDGE_DLN_ADDRESSES (inherited from BaseTest)

```solidity
mapping(uint64 => address) public DEBRIDGE_DLN_ADDRESSES
```

### DEBRIDGE_DLN_ADDRESSES_DST (inherited from BaseTest)

```solidity
mapping(uint64 => address) public DEBRIDGE_DLN_ADDRESSES_DST
```

### NEXUS_FACTORY_ADDRESSES (inherited from BaseTest)

```solidity
mapping(uint64 => address) public NEXUS_FACTORY_ADDRESSES
```

### POLYMER_PROVER (inherited from BaseTest)

```solidity
mapping(uint64 => address) public POLYMER_PROVER
```

### existingUnderlyingTokens (inherited from BaseTest)

```solidity
/// @dev mappings
mapping(uint64 => mapping(string => address)) public existingUnderlyingTokens
```

### realVaultAddresses (inherited from BaseTest)

```solidity
mapping(uint64 => mapping(string => mapping(string => mapping(string => address)))) public realVaultAddresses
```

### contractAddresses (inherited from BaseTest)

```solidity
mapping(uint64 => mapping(string => address)) public contractAddresses
```

### hookAddresses (inherited from BaseTest)

```solidity
mapping(uint64 => mapping(string => address)) public hookAddresses
```

### hookListPerChain (inherited from BaseTest)

```solidity
mapping(uint64 => address[]) public hookListPerChain
```

### hooksByCategory (inherited from BaseTest)

```solidity
mapping(uint64 => mapping(HookCategory => Hook[])) public hooksByCategory
```

### hooks (inherited from BaseTest)

```solidity
mapping(uint64 => mapping(string => Hook)) public hooks
```

### accountInstances (inherited from BaseTest)

```solidity
mapping(uint64 => AccountInstance) public accountInstances
```

### randomAccountInstances (inherited from BaseTest)

```solidity
mapping(uint64 => AccountInstance[]) public randomAccountInstances
```

### mockOdosRouters (inherited from BaseTest)

```solidity
mapping(uint64 => address) public mockOdosRouters
```

### PENDLE_ROUTERS (inherited from BaseTest)

```solidity
mapping(uint64 => address) public PENDLE_ROUTERS
```

### PENDLE_SWAP (inherited from BaseTest)

```solidity
mapping(uint64 => address) public PENDLE_SWAP
```

### ODOS_ROUTER (inherited from BaseTest)

```solidity
mapping(uint64 => address) public ODOS_ROUTER
```

### SPECTRA_ROUTERS (inherited from BaseTest)

```solidity
mapping(uint64 => address) public SPECTRA_ROUTERS
```

### FORKS (inherited from BaseTest)

```solidity
mapping(uint64 => uint256) public FORKS
```

### RPC_URLS (inherited from BaseTest)

```solidity
mapping(uint64 => string) public RPC_URLS
```

### validatorSigners (inherited from BaseTest)

```solidity
mapping(uint64 => address) public validatorSigners
```

### validatorSignerPrivateKeys (inherited from BaseTest)

```solidity
mapping(uint64 => uint256) public validatorSignerPrivateKeys
```

### mockRegistry (inherited from BaseTest)

```solidity
MockRegistry public mockRegistry
```

**MockRegistry**: [lib/v2-core/test/mocks/MockRegistry.sol/contract_MockRegistry.md]

### ETHEREUM_RPC_URL (inherited from BaseTest)

```solidity
string public ETHEREUM_RPC_URL = vm.envString(ETHEREUM_RPC_URL_KEY)
```

### OPTIMISM_RPC_URL (inherited from BaseTest)

```solidity
string public OPTIMISM_RPC_URL = vm.envString(OPTIMISM_RPC_URL_KEY)
```

### BASE_RPC_URL (inherited from BaseTest)

```solidity
string public BASE_RPC_URL = vm.envString(BASE_RPC_URL_KEY)
```

### DEBUG (inherited from BaseTest)

```solidity
bool internal constant DEBUG = false
```

### DEFAULT_ACCOUNT (inherited from BaseTest)

```solidity
string internal constant DEFAULT_ACCOUNT = "NEXUS"
```

### SALT (inherited from BaseTest)

```solidity
bytes32 internal constant SALT = keccak256("TEST")
```

### INITCODE_EIP7702_MARKER (inherited from BaseTest)

```solidity
bytes2 internal constant INITCODE_EIP7702_MARKER = 0x7702
```

### mockBaseHook (inherited from BaseTest)

```solidity
address public mockBaseHook
```

### skipAccountsCreation (inherited from BaseTest)

```solidity
bool public skipAccountsCreation = false
```

### useLatestFork (inherited from BaseTest)

```solidity
bool public useLatestFork = false
```

### useRealOdosRouter (inherited from BaseTest)

```solidity
bool public useRealOdosRouter = false
```

### globalMerkleHooks (inherited from BaseTest)

```solidity
address[] public globalMerkleHooks
```

### globalMerkleHookNames (inherited from BaseTest)

```solidity
string[] public globalMerkleHookNames
```

### TEST_SALT (inherited from BaseTest)

```solidity
string internal constant TEST_SALT = "TEST"
```

### PERIPHERY_HOOKS_SALT (inherited from BaseTest)

```solidity
string internal constant PERIPHERY_HOOKS_SALT = "PERIPHERY_HOOKS"
```

### globalSVStrategy (inherited from BaseTest)

```solidity
address public globalSVStrategy
```

### globalSVGearStrategy (inherited from BaseTest)

```solidity
address public globalSVGearStrategy
```

### globalRuggableVault (inherited from BaseTest)

```solidity
address public globalRuggableVault
```

### globalSV5115Strategy (inherited from BaseTest)

```solidity
address public globalSV5115Strategy
```

### test1_DynamicAllocation_MockVault (inherited from BaseTest)

```solidity
address public test1_DynamicAllocation_MockVault
```

### test3_UnderlyingVaults_StressTest (inherited from BaseTest)

```solidity
address public test3_UnderlyingVaults_StressTest
```

### test6_yieldAccumulation_vault1 (inherited from BaseTest)

```solidity
address public test6_yieldAccumulation_vault1
```

### test6_yieldAccumulation_vault2 (inherited from BaseTest)

```solidity
address public test6_yieldAccumulation_vault2
```

### test6_yieldAccumulation_vault3 (inherited from BaseTest)

```solidity
address public test6_yieldAccumulation_vault3
```

### test6_yieldAccumulation_WithRebalancing_vault1 (inherited from BaseTest)

```solidity
address public test6_yieldAccumulation_WithRebalancing_vault1
```

### test6_yieldAccumulation_WithRebalancing_vault2 (inherited from BaseTest)

```solidity
address public test6_yieldAccumulation_WithRebalancing_vault2
```

### test6_yieldAccumulation_WithRebalancing_vault3 (inherited from BaseTest)

```solidity
address public test6_yieldAccumulation_WithRebalancing_vault3
```

### test10_RuggableVault_Deposit (inherited from BaseTest)

```solidity
address public test10_RuggableVault_Deposit
```

### test10_RuggableVault_Withdraw (inherited from BaseTest)

```solidity
address public test10_RuggableVault_Withdraw
```

### test10_RuggableVault_Withdraw_ConvertDistortion (inherited from BaseTest)

```solidity
address public test10_RuggableVault_Withdraw_ConvertDistortion
```

### test11_Allocate_NewYieldSource (inherited from BaseTest)

```solidity
address public test11_Allocate_NewYieldSource
```

### test1_SuperVault_5115_ReAllocateFrom4626To5115_Vault1 (inherited from BaseTest)

```solidity
address public test1_SuperVault_5115_ReAllocateFrom4626To5115_Vault1
```

### test2_SuperVault_5115_ReAllocateFrom4626To5115_Vault2 (inherited from BaseTest)

```solidity
address public test2_SuperVault_5115_ReAllocateFrom4626To5115_Vault2
```

### globalMerkleHooksPeriphery (inherited from BaseTest)

```solidity
address[] public globalMerkleHooksPeriphery
```

### globalMerkleHookNamesPeriphery (inherited from BaseTest)

```solidity
string[] public globalMerkleHookNamesPeriphery
```

### approveAndSwapOdosHookAddressETH (inherited from BaseTest)

```solidity
address public approveAndSwapOdosHookAddressETH
```

### accountEth (inherited from BaseSuperVaultTest)

```solidity
address public accountEth
```

### instanceOnEth (inherited from BaseSuperVaultTest)

```solidity
AccountInstance public instanceOnEth
```

### accInstances (inherited from BaseSuperVaultTest)

```solidity
AccountInstance[] internal accInstances
```

### superExecutorOnEth (inherited from BaseSuperVaultTest)

```solidity
ISuperExecutor public superExecutorOnEth
```

**ISuperExecutor**: [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]

### superLedgerETH (inherited from BaseSuperVaultTest)

```solidity
ISuperLedger public superLedgerETH
```

**ISuperLedger**: [lib/v2-core/src/interfaces/accounting/ISuperLedger.sol/interface_ISuperLedger.md]

### oracle (inherited from BaseSuperVaultTest)

```solidity
ERC7540YieldSourceOracle public oracle
```

**ERC7540YieldSourceOracle**: [lib/v2-core/test/mocks/unused-oracles/ERC7540YieldSourceOracle.sol/contract_ERC7540YieldSourceOracle.md]

### configSuperLedger (inherited from BaseSuperVaultTest)

```solidity
ISuperLedgerConfiguration public configSuperLedger
```

**ISuperLedgerConfiguration**: [lib/v2-core/src/interfaces/accounting/ISuperLedgerConfiguration.sol/interface_ISuperLedgerConfiguration.md]

### vault (inherited from BaseSuperVaultTest)

```solidity
SuperVault public vault
```

**SuperVault**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

### escrow (inherited from BaseSuperVaultTest)

```solidity
SuperVaultEscrow public escrow
```

**SuperVaultEscrow**: [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

### aggregator (inherited from BaseSuperVaultTest)

```solidity
SuperVaultAggregator public aggregator
```

**SuperVaultAggregator**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

### strategy (inherited from BaseSuperVaultTest)

```solidity
SuperVaultStrategy public strategy
```

**SuperVaultStrategy**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

### superGovernor (inherited from BaseSuperVaultTest)

```solidity
SuperGovernor public superGovernor
```

**SuperGovernor**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

### ecdsappsOracle (inherited from BaseSuperVaultTest)

```solidity
IECDSAPPSOracle public ecdsappsOracle
```

**IECDSAPPSOracle**: [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]

### superOracle (inherited from BaseSuperVaultTest)

```solidity
ISuperOracle public superOracle
```

**ISuperOracle**: [src/interfaces/oracles/ISuperOracle.sol/interface_ISuperOracle.md]

### mockUSD (inherited from BaseSuperVaultTest)

```solidity
MockERC20 public mockUSD
```

**MockERC20**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

### upToken (inherited from BaseSuperVaultTest)

```solidity
address internal upToken
```

### oracleEthToUsd (inherited from BaseSuperVaultTest)

```solidity
address public oracleEthToUsd
```

### oracleUsdToUp (inherited from BaseSuperVaultTest)

```solidity
address public oracleUsdToUp
```

### oracleGasToEth (inherited from BaseSuperVaultTest)

```solidity
address public oracleGasToEth
```

### mockFeedWithRealDataEthToUsd (inherited from BaseSuperVaultTest)

```solidity
MockFeedWithRealData public mockFeedWithRealDataEthToUsd
```

**MockFeedWithRealData**: [test/mocks/MockFeedWithRealData.sol/contract_MockFeedWithRealData.md]

### mockFeedWithRealDataGasToEth (inherited from BaseSuperVaultTest)

```solidity
MockFeedWithRealData public mockFeedWithRealDataGasToEth
```

**MockFeedWithRealData**: [test/mocks/MockFeedWithRealData.sol/contract_MockFeedWithRealData.md]

### totalAssetHelper (inherited from BaseSuperVaultTest)

```solidity
TotalAssetHelper public totalAssetHelper
```

**TotalAssetHelper**: [test/integration/SuperVault/TotalAssetHelper.sol/contract_TotalAssetHelper.md]

### asset (inherited from BaseSuperVaultTest)

```solidity
IERC20Metadata public asset
```

**IERC20Metadata**: [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### asset5115 (inherited from BaseSuperVaultTest)

```solidity
IERC20Metadata public asset5115
```

**IERC20Metadata**: [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

### fluidVault (inherited from BaseSuperVaultTest)

```solidity
IERC4626 public fluidVault
```

**IERC4626**: [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]

### aaveVault (inherited from BaseSuperVaultTest)

```solidity
IERC4626 public aaveVault
```

**IERC4626**: [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]

### pendleEthenaAddress (inherited from BaseSuperVaultTest)

```solidity
address public pendleEthenaAddress
```

### pendleEthena (inherited from BaseSuperVaultTest)

```solidity
IStandardizedYield public pendleEthena
```

**IStandardizedYield**: [lib/v2-core/src/vendor/pendle/IStandardizedYield.sol/interface_IStandardizedYield.md]

### LARGE_DEPOSIT (inherited from BaseSuperVaultTest)

```solidity
uint256 internal constant LARGE_DEPOSIT = 100_000e6
```

### ONE_HUNDRED_PERCENT (inherited from BaseSuperVaultTest)

```solidity
uint256 internal constant ONE_HUNDRED_PERCENT = 10_000
```

### superVaultStates (inherited from BaseSuperVaultTest)

```solidity
mapping(address => SuperVaultState) private superVaultStates
```

### validator1PrivateKey (inherited from BaseSuperVaultTest)

```solidity
uint256 public validator1PrivateKey
```

### validator2PrivateKey (inherited from BaseSuperVaultTest)

```solidity
uint256 public validator2PrivateKey
```

### validator3PrivateKey (inherited from BaseSuperVaultTest)

```solidity
uint256 public validator3PrivateKey
```

### poolId (inherited from BaseSuperVaultTest)

```solidity
uint64 public poolId
```

### assetId (inherited from BaseSuperVaultTest)

```solidity
uint128 public assetId
```

### trancheId (inherited from BaseSuperVaultTest)

```solidity
bytes16 public trancheId
```

### rootManager (inherited from BaseSuperVaultTest)

```solidity
address public rootManager
```

### rootCentrifuge (inherited from BaseSuperVaultTest)

```solidity
IRoot public rootCentrifuge
```

**IRoot**: [lib/v2-core/test/mocks/centrifuge/IRoot.sol/interface_IRoot.md]

### poolManager (inherited from BaseSuperVaultTest)

```solidity
IPoolManager public poolManager
```

**IPoolManager**: [lib/v2-core/test/mocks/centrifuge/IPoolManager.sol/interface_IPoolManager.md]

### centrifugeVault (inherited from BaseSuperVaultTest)

```solidity
IERC7540 public centrifugeVault
```

**IERC7540**: [lib/v2-core/src/vendor/vaults/7540/IERC7540.sol/interface_IERC7540.md]

### yieldSource7540AddressETH_USDC (inherited from BaseSuperVaultTest)

```solidity
address public yieldSource7540AddressETH_USDC
```

### investmentManager (inherited from BaseSuperVaultTest)

```solidity
IInvestmentManager public investmentManager
```

**IInvestmentManager**: [lib/v2-core/test/mocks/centrifuge/IInvestmentManager.sol/interface_IInvestmentManager.md]

### restrictionManager (inherited from BaseSuperVaultTest)

```solidity
RestrictionManagerLike public restrictionManager
```

**RestrictionManagerLike**: [lib/v2-core/test/mocks/centrifuge/IRestrictionManagerLike.sol/interface_RestrictionManagerLike.md]

### operator

```solidity
address internal operator = address(0x123)
```

### userPrivateKey

```solidity
uint256 internal constant userPrivateKey = 0xA11CE
```

### userAddress

```solidity
address internal userAddress
```

### oracle5115

```solidity
ERC5115YieldSourceOracle public oracle5115
```

**ERC5115YieldSourceOracle**: [lib/v2-core/src/accounting/oracles/ERC5115YieldSourceOracle.sol/contract_ERC5115YieldSourceOracle.md]

### sv5115

```solidity
SuperVault internal sv5115
```

**SuperVault**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

### escrow5115SuperVault

```solidity
SuperVaultEscrow internal escrow5115SuperVault
```

**SuperVaultEscrow**: [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

### strategy5115SuperVault

```solidity
SuperVaultStrategy internal strategy5115SuperVault
```

**SuperVaultStrategy**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Structs

### ChainData (inherited from StdChains)

```solidity
struct ChainData {
    string name;
    uint256 chainId;
    string rpcUrl;
}
```

### Chain (inherited from StdChains)

```solidity
struct Chain {
    string name;
    uint256 chainId;
    string chainAlias;
    string rpcUrl;
}
```

### RawTx1559 (inherited from StdCheatsSafe)

```solidity
struct RawTx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    RawTx1559Detail txDetail;
    string opcode;
}
```

### RawTx1559Detail (inherited from StdCheatsSafe)

```solidity
struct RawTx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    bytes gas;
    bytes nonce;
    address to;
    bytes txType;
    bytes value;
}
```

### Tx1559 (inherited from StdCheatsSafe)

```solidity
struct Tx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    Tx1559Detail txDetail;
    string opcode;
}
```

### Tx1559Detail (inherited from StdCheatsSafe)

```solidity
struct Tx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    uint256 gas;
    uint256 nonce;
    address to;
    uint256 txType;
    uint256 value;
}
```

### TxLegacy (inherited from StdCheatsSafe)

```solidity
struct TxLegacy {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    string hash;
    string opcode;
    TxDetailLegacy transaction;
}
```

### TxDetailLegacy (inherited from StdCheatsSafe)

```solidity
struct TxDetailLegacy {
    AccessList[] accessList;
    uint256 chainId;
    bytes data;
    address from;
    uint256 gas;
    uint256 gasPrice;
    bytes32 hash;
    uint256 nonce;
    bytes1 opcode;
    bytes32 r;
    bytes32 s;
    uint256 txType;
    address to;
    uint8 v;
    uint256 value;
}
```

### AccessList (inherited from StdCheatsSafe)

```solidity
struct AccessList {
    address accessAddress;
    bytes32[] storageKeys;
}
```

### RawReceipt (inherited from StdCheatsSafe)

```solidity
struct RawReceipt {
    bytes32 blockHash;
    bytes blockNumber;
    address contractAddress;
    bytes cumulativeGasUsed;
    bytes effectiveGasPrice;
    address from;
    bytes gasUsed;
    RawReceiptLog[] logs;
    bytes logsBloom;
    bytes status;
    address to;
    bytes32 transactionHash;
    bytes transactionIndex;
}
```

### Receipt (inherited from StdCheatsSafe)

```solidity
struct Receipt {
    bytes32 blockHash;
    uint256 blockNumber;
    address contractAddress;
    uint256 cumulativeGasUsed;
    uint256 effectiveGasPrice;
    address from;
    uint256 gasUsed;
    ReceiptLog[] logs;
    bytes logsBloom;
    uint256 status;
    address to;
    bytes32 transactionHash;
    uint256 transactionIndex;
}
```

### EIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct EIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    Receipt[] receipts;
    uint256 timestamp;
    Tx1559[] transactions;
    TxReturn[] txReturns;
}
```

### RawEIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct RawEIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    RawReceipt[] receipts;
    TxReturn[] txReturns;
    uint256 timestamp;
    RawTx1559[] transactions;
}
```

### RawReceiptLog (inherited from StdCheatsSafe)

```solidity
struct RawReceiptLog {
    address logAddress;
    bytes32 blockHash;
    bytes blockNumber;
    bytes data;
    bytes logIndex;
    bool removed;
    bytes32[] topics;
    bytes32 transactionHash;
    bytes transactionIndex;
    bytes transactionLogIndex;
}
```

### ReceiptLog (inherited from StdCheatsSafe)

```solidity
struct ReceiptLog {
    address logAddress;
    bytes32 blockHash;
    uint256 blockNumber;
    bytes data;
    uint256 logIndex;
    bytes32[] topics;
    uint256 transactionIndex;
    uint256 transactionLogIndex;
    bool removed;
}
```

### TxReturn (inherited from StdCheatsSafe)

```solidity
struct TxReturn {
    string internalType;
    string value;
}
```

### Account (inherited from StdCheatsSafe)

```solidity
struct Account {
    address addr;
    uint256 key;
}
```

### FuzzSelector (inherited from StdInvariant)

```solidity
struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}
```

### FuzzArtifactSelector (inherited from StdInvariant)

```solidity
struct FuzzArtifactSelector {
    string artifact;
    bytes4[] selectors;
}
```

### FuzzInterface (inherited from StdInvariant)

```solidity
struct FuzzInterface {
    address addr;
    string[] artifacts;
}
```

### LocalVars (inherited from MerkleReader)

```solidity
struct LocalVars {
    string rootJson;
    bytes encodedRoot;
    string treeJson;
    bytes encodedHookName;
    bytes encodedValue;
    bytes encodedProof;
}
```

### QuoteInputToken (inherited from OdosAPIParser)

```solidity
struct QuoteInputToken {
    address tokenAddress;
    uint256 amount;
}
```

### QuoteOutputToken (inherited from OdosAPIParser)

```solidity
struct QuoteOutputToken {
    address tokenAddress;
    uint256 proportion;
}
```

### OdosDecodedSwap (inherited from OdosAPIParser)

```solidity
struct OdosDecodedSwap {
    IOdosRouterV2.swapTokenInfo tokenInfo;
    bytes pathDefinition;
    address executor;
    uint32 referralCode;
}
```

### SingleHopParams (inherited from UniswapV4Parser)

```solidity
/// @notice Parameters for single-hop V4 swap
///  @param poolKey Pool key for the V4 pool
///  @param dstReceiver Recipient of output tokens
///  @param sqrtPriceLimitX96 Price limit (0 for no limit)
///  @param originalAmountIn Input amount
///  @param originalMinAmountOut Minimum output amount
///  @param maxSlippageDeviationBps Maximum allowed ratio change in basis points
///  @param zeroForOne Whether swapping token0 for token1
///  @param additionalData Additional data for the swap
struct SingleHopParams {
    PoolKey poolKey;
    address dstReceiver;
    uint160 sqrtPriceLimitX96;
    uint256 originalAmountIn;
    uint256 originalMinAmountOut;
    uint256 maxSlippageDeviationBps;
    bool zeroForOne;
    bytes additionalData;
}
```

### Hook (inherited from BaseTest)

```solidity
struct Hook {
    string name;
    HookCategory category;
    HookCategory dependency;
    address hook;
    bytes description;
}
```

### ProcessAcrossV3MessageParams (inherited from BaseTest)

```solidity
struct ProcessAcrossV3MessageParams {
    uint64 srcChainId;
    uint64 dstChainId;
    uint256 warpTimestamp;
    ExecutionReturnData executionData;
    RELAYER_TYPE relayerType;
    bytes4 errorMessage;
    string errorReason;
    bytes32 root;
    address account;
    uint256 relayerGas;
}
```

### TargetExecutorMessage (inherited from BaseTest)

```solidity
struct TargetExecutorMessage {
    address[] hooksAddresses;
    bytes[] hooksData;
    address validator;
    address signer;
    uint256 signerPrivateKey;
    address targetAdapter;
    address targetExecutor;
    address nexusFactory;
    address nexusBootstrap;
    uint64 chainId;
    uint256 amount;
    address account;
    address tokenSent;
}
```

### MerkleContext (inherited from BaseTest)

```solidity
struct MerkleContext {
    uint48 validUntil;
    bytes executionData;
    bytes32[] leaves;
    address[] dstTokens;
    uint256[] intentAmounts;
    bytes32[][] merkleProof;
    bytes32 merkleRoot;
    bytes signature;
}
```

### AccountCreationParams (inherited from BaseTest)

```solidity
struct AccountCreationParams {
    address senderCreatorOnDestinationChain;
    address validatorOnDestinationChain;
    address superMerkleValidator;
    address theSigner;
    address executorOnDestinationChain;
    address superExecutor;
    address nexusFactory;
    address nexusBootstrap;
    bool is7702;
}
```

### DebridgeOrderData (inherited from BaseTest)

```solidity
struct DebridgeOrderData {
    bool usePrevHookAmount;
    uint256 value;
    address giveTokenAddress;
    uint256 giveAmount;
    uint8 version;
    address fallbackAddress;
    address executorAddress;
    uint256 executionFee;
    bool allowDelayedExecution;
    bool requireSuccessfulExecution;
    bytes payload;
    address takeTokenAddress;
    uint256 takeAmount;
    uint256 takeChainId;
    address receiverDst;
    address givePatchAuthoritySrc;
    bytes orderAuthorityAddressDst;
    bytes allowedTakerDst;
    bytes allowedCancelBeneficiarySrc;
    bytes affiliateFee;
    uint32 referralCode;
}
```

### SuperVaultState (inherited from BaseSuperVaultTest)

```solidity
struct SuperVaultState {
    uint256 accumulatorShares;
    uint256 accumulatorCostBasis;
}
```

### DeployVaultVars (inherited from BaseSuperVaultTest)

```solidity
///  @notice Struct to hold local variables for _deployVault to avoid stack too deep errors
struct DeployVaultVars {
    uint256 superVaultCap;
}
```

### DepositViaSmartAccountVars (inherited from BaseSuperVaultTest)

```solidity
struct DepositViaSmartAccountVars {
    address depositHookAddress;
    address[] fulfillHooksAddresses;
    bytes[] fulfillHooksData;
    uint256 halfAmount;
    uint256[] expectedAssetsOrSharesOut;
    bytes[] argsForProofs;
    ISuperVaultStrategy.ExecuteArgs executeArgs;
    address executeHooksHook;
    address[] hooksAddresses;
    bytes[] hooksData;
    ISuperExecutor.ExecutorEntry entry;
    UserOpData userOpData;
    uint256 pricePerShare;
    uint256 shares;
}
```

### FulfillRedeemLocalVars (inherited from BaseSuperVaultTest)

```solidity
struct FulfillRedeemLocalVars {
    address[] requestingUsers;
    address withdrawHookAddress;
    address[] fulfillHooksAddresses;
    uint256 fluidSharesOut;
    uint256 aaveSharesOut;
    bytes[] fulfillHooksData;
    uint256 totalSvAssets;
    uint256 pricePerShare;
    uint256 amountForVault1;
    uint256 amountForVault2;
    uint256 underlyingSharesForVault1;
    uint256 underlyingSharesForVault2;
    uint256[] expectedAssetsOrSharesOut;
}
```

### DepositFreeAssetsVars (inherited from BaseSuperVaultTest)

```solidity
struct DepositFreeAssetsVars {
    address depositHookAddress;
    address[] fulfillHooksAddresses;
    bytes[] fulfillHooksData;
    uint256[] expectedAssetsOrSharesOut;
    bytes[] argsForProofs;
    bytes32 yieldSourceOracleId;
    address assetAddress;
    ISuperVaultStrategy.ExecuteArgs executeArgs;
}
```

### ExecuteRedeemHooks4626ForUsersVars (inherited from BaseSuperVaultTest)

```solidity
struct ExecuteRedeemHooks4626ForUsersVars {
    uint256 underlyingSharesVault1;
    uint256 underlyingSharesVault2;
    address withdrawHookAddress;
    address[] fulfillHooksAddresses;
    bytes[] fulfillHooksData;
    bytes[] argsForProofs;
    bytes32[][] proofs;
    uint256[] totalAssetsOut;
}
```

### FulfillRedeem7540UnderlyingLocalVars (inherited from BaseSuperVaultTest)

```solidity
struct FulfillRedeem7540UnderlyingLocalVars {
    address[] requestingUsers;
    address[] fulfillHooksAddresses;
    uint256 centrifugeSharesOut;
    uint256 aaveSharesOut;
    bytes[] fulfillHooksData;
    uint256 totalSvAssets;
    uint256 pricePerShare;
    uint256 amountForAave;
    uint256 amountForCentrifuge;
    uint256 underlyingSharesForAave;
    uint256 underlyingSharesForCentrifuge;
    uint256[] expectedAssetsOrSharesOut;
}
```

### ReallocateLocalVars (inherited from BaseSuperVaultTest)

```solidity
///  @notice Struct to hold local variables for the _reallocate function
struct ReallocateLocalVars {
    uint256 currentVault1Balance;
    uint256 currentVault2Balance;
    uint256 currentVault3Balance;
    uint256 totalBalance;
    uint256 targetVault1Assets;
    uint256 targetVault2Assets;
    uint256 targetVault3Assets;
    int256 vault1Diff;
    int256 vault2Diff;
    int256 vault3Diff;
    address[] sources;
    uint256[] sourceAmounts;
    address[] destinations;
    uint256[] destinationAmounts;
    uint256 sourceCount;
    uint256 destCount;
    address source;
    address destination;
    uint256 amountToMove;
    uint256 sharesToRedeem;
    address[] hooksAddresses;
    bytes[] hooksData;
    uint256 finalVault1Balance;
    uint256 finalVault2Balance;
    uint256 finalVault3Balance;
    uint256 totalFinalBalance;
    uint256 finalVault1Ratio;
    uint256 finalVault2Ratio;
    uint256 finalVault3Ratio;
}
```

### ReallocateArgs (inherited from BaseSuperVaultTest)

```solidity
///  @notice Struct to hold arguments for the _reallocate function
struct ReallocateArgs {
    IERC4626 vault1;
    IERC4626 vault2;
    IERC4626 vault3;
    uint256 targetVault1Percentage;
    uint256 targetVault2Percentage;
    uint256 targetVault3Percentage;
    address withdrawHookAddress;
    address depositHookAddress;
}
```

### DepositVerificationVars (inherited from BaseSuperVaultTest)

```solidity
struct DepositVerificationVars {
    uint256 depositAmount;
    uint256 totalAmount;
    uint256 allocationAmountVault1;
    uint256 allocationAmountVault2;
    uint256 initialFluidVaultBalance;
    uint256 initialAaveVaultBalance;
    uint256 initialStrategyAssetBalance;
    uint256 fluidVaultSharesIncrease;
    uint256 aaveVaultSharesIncrease;
    uint256 strategyAssetBalanceDecrease;
    uint256 fluidVaultAssetsValue;
    uint256 aaveVaultAssetsValue;
    uint256 totalAssetsAllocated;
    uint256 totalSharesMinted;
    uint256 totalAssetsFromShares;
}
```

### ChangingAllocationVars (inherited from BaseSuperVaultTest)

```solidity
struct ChangingAllocationVars {
    uint256 firstDepositAmount;
    uint256 secondDepositAmount;
    uint256 firstAllocationVault1;
    uint256 firstAllocationVault2;
    uint256 secondAllocationVault1;
    uint256 secondAllocationVault2;
    uint256 initialShareBalance;
    uint256 firstDepositShares;
    uint256 firstDepositSharePrice;
    uint256 shareBalanceAfterFirstDeposit;
    uint256 secondDepositShares;
    uint256 secondDepositSharePrice;
    uint256 totalShares;
    uint256 totalShareValue;
}
```

### RedeemVerificationVars (inherited from BaseSuperVaultTest)

```solidity
struct RedeemVerificationVars {
    uint256 depositAmount;
    uint256 redeemAmount;
    uint256 totalDepositAmount;
    uint256 totalRedeemAmount;
    uint256 totalRedeemedAssets;
    uint256 allocationAmountVault1;
    uint256 allocationAmountVault2;
    uint256 initialFluidVaultBalance;
    uint256 initialAaveVaultBalance;
    uint256 initialStrategyAssetBalance;
    uint256 fluidVaultSharesDecrease;
    uint256 aaveVaultSharesDecrease;
    uint256 strategyAssetBalanceIncrease;
    uint256 fluidVaultAssetsValue;
    uint256 aaveVaultAssetsValue;
    uint256 totalAssetsRedeemed;
    uint256 totalSharesBurned;
    uint256[] userShareBalances;
}
```

### UpdatePPSVars (inherited from BaseSuperVaultTest)

```solidity
///  @notice Structure to hold local variables for the _updateSuperVaultPPS function
///  @dev This helps reduce stack depth issues and organize parameters
struct UpdatePPSVars {
    uint256 totalSupplyAmount;
    uint256 currentTotalAssets;
    uint256 precision;
    uint256 pps;
    uint256 timestamp;
    bytes32 messageHash;
    bytes32 ethSignedMessageHash;
    uint8 v;
    bytes32 r;
    bytes32 s;
    bytes signature;
    bytes[] proofs;
}
```

### ExecuteRedeemHooksVars (inherited from BaseSuperVaultTest)

```solidity
/// @notice Struct to hold local variables for _executeRedeemHooks4626ForUsers to avoid stack too deep
struct ExecuteRedeemHooksVars {
    uint256 underlyingSharesVault1;
    uint256 underlyingSharesVault2;
    address[] fulfillHooksAddresses;
    bytes[] fulfillHooksData;
    uint256[] expectedAssetsOrSharesOut;
    bytes[] argsForProofs;
    uint256[] totalAssetsOut;
}
```

### PositiveAndNegativePpsVars

```solidity
struct PositiveAndNegativePpsVars {
    uint256 feeBalanceBefore;
    uint256 ppsBefore;
    uint256 ppsAfter;
    uint256 deposit1Amount;
    uint256 deposit2Amount;
    uint256 deposit3Amount;
    uint256 shares1;
    uint256 shares2;
    uint256 shares3;
    uint256 totalShares;
    uint256 redeemAmount1;
    uint256 superformFee1;
    uint256 recipientFee1;
    uint256 totalFee1;
    uint256 userBalanceBeforeRedeem1;
    uint256 treasuryBalanceAfterRedeem1;
    uint256 claimableAssets1;
    uint256 userAssetsAfterRedeem1;
    uint256 remainingShares;
    uint256 redeemAmount2;
    uint256 superformFee2;
    uint256 recipientFee2;
    uint256 totalFee2;
    uint256 userBalanceBeforeRedeem2;
    uint256 treasuryBalanceAfterRedeem2;
    uint256 claimableAssets2;
    uint256 userAssetsAfterRedeem2;
}
```

### ReallocationVars

```solidity
struct ReallocationVars {
    uint256 depositAmount;
    uint256 shares1;
    uint256 ppsBefore;
    uint256 ppsAfter;
    uint256 initial5115Balance;
    uint256 initialNewVaultBalance;
    uint256 amountToReallocateFrom5115;
    uint256 assetAmountToReallocateFrom5115;
    address withdraw5115HookAddress;
    address deposit4626HookAddress;
    address[] hooksAddresses;
    bytes[] hooksData;
    uint256[] expectedAssetsOrSharesOut;
    bytes[] argsForProofs;
    uint256 final5115Balance;
    uint256 finalNewVaultBalance;
    uint256 totalAssetsAfter;
}
```

## Errors

### InvalidTokenPath (inherited from UniswapV4Parser)

```solidity
/// @notice Thrown when token path is invalid for multi-hop
error InvalidTokenPath();
```

### InvalidFeesArray (inherited from UniswapV4Parser)

```solidity
/// @notice Thrown when fees array doesn't match token path
error InvalidFeesArray();
```

### IdenticalTokens (inherited from UniswapV4Parser)

```solidity
/// @notice Thrown when tokens are identical
error IdenticalTokens();
```

### EMPTY_ARRAYS (inherited from AssetAdjustmentHelper)

```solidity
error EMPTY_ARRAYS();
```

### ARRAY_LENGTH_MISMATCH (inherited from AssetAdjustmentHelper)

```solidity
error ARRAY_LENGTH_MISMATCH();
```

### ZERO_TOTAL_THEORETICAL (inherited from AssetAdjustmentHelper)

```solidity
error ZERO_TOTAL_THEORETICAL();
```

### INSUFFICIENT_AVAILABLE_ASSETS (inherited from AssetAdjustmentHelper)

```solidity
error INSUFFICIENT_AVAILABLE_ASSETS();
```

## Events

### log (inherited from StdAssertions)

```solidity
event log(string);
```

### logs (inherited from StdAssertions)

```solidity
event logs(bytes);
```

### log_address (inherited from StdAssertions)

```solidity
event log_address(address);
```

### log_bytes32 (inherited from StdAssertions)

```solidity
event log_bytes32(bytes32);
```

### log_int (inherited from StdAssertions)

```solidity
event log_int(int256);
```

### log_uint (inherited from StdAssertions)

```solidity
event log_uint(uint256);
```

### log_bytes (inherited from StdAssertions)

```solidity
event log_bytes(bytes);
```

### log_string (inherited from StdAssertions)

```solidity
event log_string(string);
```

### log_named_address (inherited from StdAssertions)

```solidity
event log_named_address(string key, address val);
```

### log_named_bytes32 (inherited from StdAssertions)

```solidity
event log_named_bytes32(string key, bytes32 val);
```

### log_named_decimal_int (inherited from StdAssertions)

```solidity
event log_named_decimal_int(string key, int256 val, uint256 decimals);
```

### log_named_decimal_uint (inherited from StdAssertions)

```solidity
event log_named_decimal_uint(string key, uint256 val, uint256 decimals);
```

### log_named_int (inherited from StdAssertions)

```solidity
event log_named_int(string key, int256 val);
```

### log_named_uint (inherited from StdAssertions)

```solidity
event log_named_uint(string key, uint256 val);
```

### log_named_bytes (inherited from StdAssertions)

```solidity
event log_named_bytes(string key, bytes val);
```

### log_named_string (inherited from StdAssertions)

```solidity
event log_named_string(string key, string val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(uint256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(int256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(address[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, uint256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, int256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, address[] val);
```

## Enums

### AddressType (inherited from StdCheatsSafe)

```solidity
enum AddressType {
    Payable,
    NonPayable,
    ZeroAddress,
    Precompile,
    ForgeAddress
}
```

### HookCategory (inherited from BaseTest)

```solidity
/// @dev arrays
enum HookCategory {
    TokenApprovals,
    VaultDeposits,
    VaultWithdrawals,
    Bridges,
    Stakes,
    Claims,
    Loans,
    Swaps,
    None
}
```

### RELAYER_TYPE (inherited from BaseTest)

```solidity
enum RELAYER_TYPE {
    USED_ROOT,
    NOT_ENOUGH_BALANCE,
    ENOUGH_BALANCE,
    NO_HOOKS,
    REVERT
}
```

## Public/External Functions

### setUp()

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 3094:369:581
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() override public;
```

### test_5115_Name()

- **Signature**: `test_5115_Name()`
- **Visibility**: public
- **Source Range**: 5465:149:581
- **Details**: [function_test_5115_Name.md](./function_test_5115_Name.md)

**Signature:**
```solidity
function test_5115_Name() public;
```

### test_5115_Symbol()

- **Signature**: `test_5115_Symbol()`
- **Visibility**: public
- **Source Range**: 5620:153:581
- **Details**: [function_test_5115_Symbol.md](./function_test_5115_Symbol.md)

**Signature:**
```solidity
function test_5115_Symbol() public;
```

### test_Deposit5115()

- **Signature**: `test_Deposit5115()`
- **Visibility**: public
- **Source Range**: 5966:790:581
- **Details**: [function_test_Deposit5115.md](./function_test_Deposit5115.md)

**Signature:**
```solidity
function test_Deposit5115() public;
```

### test_Deposit5115_AndAllocate()

- **Signature**: `test_Deposit5115_AndAllocate()`
- **Visibility**: public
- **Source Range**: 6762:543:581
- **Details**: [function_test_Deposit5115_AndAllocate.md](./function_test_Deposit5115_AndAllocate.md)

**Signature:**
```solidity
function test_Deposit5115_AndAllocate() public;
```

### test_Deposit5115_AndAllocateToYieldViaSmartAccountManager()

- **Signature**: `test_Deposit5115_AndAllocateToYieldViaSmartAccountManager()`
- **Visibility**: public
- **Source Range**: 7311:2060:581
- **Details**: [function_test_Deposit5115_AndAllocateToYieldViaSmartAccountManager.md](./function_test_Deposit5115_AndAllocateToYieldViaSmartAccountManager.md)

**Signature:**
```solidity
function test_Deposit5115_AndAllocateToYieldViaSmartAccountManager() public;
```

### test_DepositAndAllocateTo5115()

- **Signature**: `test_DepositAndAllocateTo5115()`
- **Visibility**: public
- **Source Range**: 9377:672:581
- **Details**: [function_test_DepositAndAllocateTo5115.md](./function_test_DepositAndAllocateTo5115.md)

**Signature:**
```solidity
function test_DepositAndAllocateTo5115() public;
```

### test_RequestRedeem5115()

- **Signature**: `test_RequestRedeem5115()`
- **Visibility**: public
- **Source Range**: 10230:864:581
- **Details**: [function_test_RequestRedeem5115.md](./function_test_RequestRedeem5115.md)

**Signature:**
```solidity
function test_RequestRedeem5115() public;
```

### test_FulfillRedeem_FullAmountWithThreshold5115()

- **Signature**: `test_FulfillRedeem_FullAmountWithThreshold5115()`
- **Visibility**: public
- **Source Range**: 11100:937:581
- **Details**: [function_test_FulfillRedeem_FullAmountWithThreshold5115.md](./function_test_FulfillRedeem_FullAmountWithThreshold5115.md)

**Signature:**
```solidity
function test_FulfillRedeem_FullAmountWithThreshold5115() public;
```

### test_FulfillRedeem_FullAmount()

- **Signature**: `test_FulfillRedeem_FullAmount()`
- **Visibility**: public
- **Source Range**: 12043:890:581
- **Details**: [function_test_FulfillRedeem_FullAmount.md](./function_test_FulfillRedeem_FullAmount.md)

**Signature:**
```solidity
function test_FulfillRedeem_FullAmount() public;
```

### test_ClaimRedeem5115()

- **Signature**: `test_ClaimRedeem5115()`
- **Visibility**: public
- **Source Range**: 12939:2258:581
- **Details**: [function_test_ClaimRedeem5115.md](./function_test_ClaimRedeem5115.md)

**Signature:**
```solidity
function test_ClaimRedeem5115() public;
```

### test_ConvertToShares5115()

- **Signature**: `test_ConvertToShares5115()`
- **Visibility**: public
- **Source Range**: 15386:743:581
- **Details**: [function_test_ConvertToShares5115.md](./function_test_ConvertToShares5115.md)

**Signature:**
```solidity
function test_ConvertToShares5115() public;
```

### test_ConvertToAssets5115()

- **Signature**: `test_ConvertToAssets5115()`
- **Visibility**: public
- **Source Range**: 16135:723:581
- **Details**: [function_test_ConvertToAssets5115.md](./function_test_ConvertToAssets5115.md)

**Signature:**
```solidity
function test_ConvertToAssets5115() public;
```

### test_Convert_VariousEdgeCases_AndInvalidPPS_5115()

- **Signature**: `test_Convert_VariousEdgeCases_AndInvalidPPS_5115()`
- **Visibility**: public
- **Source Range**: 16864:3394:581
- **Details**: [function_test_Convert_VariousEdgeCases_AndInvalidPPS_5115.md](./function_test_Convert_VariousEdgeCases_AndInvalidPPS_5115.md)

**Signature:**
```solidity
function test_Convert_VariousEdgeCases_AndInvalidPPS_5115() public;
```

### test_AuthorizeOperator5115()

- **Signature**: `test_AuthorizeOperator5115()`
- **Visibility**: public
- **Source Range**: 20438:1323:581
- **Details**: [function_test_AuthorizeOperator5115.md](./function_test_AuthorizeOperator5115.md)

**Signature:**
```solidity
function test_AuthorizeOperator5115() public;
```

### test_TotalAssets5115()

- **Signature**: `test_TotalAssets5115()`
- **Visibility**: public
- **Source Range**: 21767:813:581
- **Details**: [function_test_TotalAssets5115.md](./function_test_TotalAssets5115.md)

**Signature:**
```solidity
function test_TotalAssets5115() public;
```

### test_Mint5115()

- **Signature**: `test_Mint5115()`
- **Visibility**: public
- **Source Range**: 22586:844:581
- **Details**: [function_test_Mint5115.md](./function_test_Mint5115.md)

**Signature:**
```solidity
function test_Mint5115() public;
```

### test_MaxMint5115()

- **Signature**: `test_MaxMint5115()`
- **Visibility**: public
- **Source Range**: 23436:441:581
- **Details**: [function_test_MaxMint5115.md](./function_test_MaxMint5115.md)

**Signature:**
```solidity
function test_MaxMint5115() public;
```

### test_MaxWithdraw5115()

- **Signature**: `test_MaxWithdraw5115()`
- **Visibility**: public
- **Source Range**: 23883:1235:581
- **Details**: [function_test_MaxWithdraw5115.md](./function_test_MaxWithdraw5115.md)

**Signature:**
```solidity
function test_MaxWithdraw5115() public;
```

### test_MaxRedeem5115()

- **Signature**: `test_MaxRedeem5115()`
- **Visibility**: public
- **Source Range**: 25124:1802:581
- **Details**: [function_test_MaxRedeem5115.md](./function_test_MaxRedeem5115.md)

**Signature:**
```solidity
function test_MaxRedeem5115() public;
```

### test_PreviewDepositAndMint5115()

- **Signature**: `test_PreviewDepositAndMint5115()`
- **Visibility**: public
- **Source Range**: 26932:703:581
- **Details**: [function_test_PreviewDepositAndMint5115.md](./function_test_PreviewDepositAndMint5115.md)

**Signature:**
```solidity
function test_PreviewDepositAndMint5115() public;
```

### test_SuperVault_5115_PositivePPS()

- **Signature**: `test_SuperVault_5115_PositivePPS()`
- **Visibility**: public
- **Source Range**: 28850:2845:581
- **Details**: [function_test_SuperVault_5115_PositivePPS.md](./function_test_SuperVault_5115_PositivePPS.md)

**Signature:**
```solidity
function test_SuperVault_5115_PositivePPS() public;
```

### test_SuperVault_5115_NegativePPS()

- **Signature**: `test_SuperVault_5115_NegativePPS()`
- **Visibility**: public
- **Source Range**: 31701:6489:581
- **Details**: [function_test_SuperVault_5115_NegativePPS.md](./function_test_SuperVault_5115_NegativePPS.md)

**Signature:**
```solidity
function test_SuperVault_5115_NegativePPS() public;
```

### test_SuperVault_5115_ReAllocate5115To4626()

- **Signature**: `test_SuperVault_5115_ReAllocate5115To4626()`
- **Visibility**: public
- **Source Range**: 39016:7240:581
- **Details**: [function_test_SuperVault_5115_ReAllocate5115To4626.md](./function_test_SuperVault_5115_ReAllocate5115To4626.md)

**Signature:**
```solidity
function test_SuperVault_5115_ReAllocate5115To4626() public;
```

### test_SuperVault_4626_ReAllocate4626ToPendle()

- **Signature**: `test_SuperVault_4626_ReAllocate4626ToPendle()`
- **Visibility**: public
- **Source Range**: 46262:5259:581
- **Details**: [function_test_SuperVault_4626_ReAllocate4626ToPendle.md](./function_test_SuperVault_4626_ReAllocate4626ToPendle.md)

**Signature:**
```solidity
function test_SuperVault_4626_ReAllocate4626ToPendle() public;
```

### failed() (inherited from StdAssertions)

- **Signature**: `failed()`
- **Visibility**: public
- **Source Range**: 1306:195:12
- **Details**: [function_failed.md](./function_failed.md)

**Signature:**
```solidity
function failed() public view returns (bool);
```

### excludeArtifacts() (inherited from StdInvariant)

- **Signature**: `excludeArtifacts()`
- **Visibility**: public
- **Source Range**: 2459:141:17
- **Details**: [function_excludeArtifacts.md](./function_excludeArtifacts.md)

**Signature:**
```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_);
```

### excludeContracts() (inherited from StdInvariant)

- **Signature**: `excludeContracts()`
- **Visibility**: public
- **Source Range**: 2606:142:17
- **Details**: [function_excludeContracts.md](./function_excludeContracts.md)

**Signature:**
```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_);
```

### excludeSelectors() (inherited from StdInvariant)

- **Signature**: `excludeSelectors()`
- **Visibility**: public
- **Source Range**: 2754:147:17
- **Details**: [function_excludeSelectors.md](./function_excludeSelectors.md)

**Signature:**
```solidity
function excludeSelectors() public view returns (FuzzSelector[] memory excludedSelectors_);
```

### excludeSenders() (inherited from StdInvariant)

- **Signature**: `excludeSenders()`
- **Visibility**: public
- **Source Range**: 2907:134:17
- **Details**: [function_excludeSenders.md](./function_excludeSenders.md)

**Signature:**
```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_);
```

### targetArtifacts() (inherited from StdInvariant)

- **Signature**: `targetArtifacts()`
- **Visibility**: public
- **Source Range**: 3047:140:17
- **Details**: [function_targetArtifacts.md](./function_targetArtifacts.md)

**Signature:**
```solidity
function targetArtifacts() public view returns (string[] memory targetedArtifacts_);
```

### targetArtifactSelectors() (inherited from StdInvariant)

- **Signature**: `targetArtifactSelectors()`
- **Visibility**: public
- **Source Range**: 3193:186:17
- **Details**: [function_targetArtifactSelectors.md](./function_targetArtifactSelectors.md)

**Signature:**
```solidity
function targetArtifactSelectors() public view returns (FuzzArtifactSelector[] memory targetedArtifactSelectors_);
```

### targetContracts() (inherited from StdInvariant)

- **Signature**: `targetContracts()`
- **Visibility**: public
- **Source Range**: 3385:141:17
- **Details**: [function_targetContracts.md](./function_targetContracts.md)

**Signature:**
```solidity
function targetContracts() public view returns (address[] memory targetedContracts_);
```

### targetSelectors() (inherited from StdInvariant)

- **Signature**: `targetSelectors()`
- **Visibility**: public
- **Source Range**: 3532:146:17
- **Details**: [function_targetSelectors.md](./function_targetSelectors.md)

**Signature:**
```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_);
```

### targetSenders() (inherited from StdInvariant)

- **Signature**: `targetSenders()`
- **Visibility**: public
- **Source Range**: 3684:133:17
- **Details**: [function_targetSenders.md](./function_targetSenders.md)

**Signature:**
```solidity
function targetSenders() public view returns (address[] memory targetedSenders_);
```

### targetInterfaces() (inherited from StdInvariant)

- **Signature**: `targetInterfaces()`
- **Visibility**: public
- **Source Range**: 3823:151:17
- **Details**: [function_targetInterfaces.md](./function_targetInterfaces.md)

**Signature:**
```solidity
function targetInterfaces() public view returns (FuzzInterface[] memory targetedInterfaces_);
```

### deployAccounts() (inherited from Helpers)

- **Signature**: `deployAccounts()`
- **Visibility**: public
- **Source Range**: 649:378:500
- **Details**: [function_deployAccounts.md](./function_deployAccounts.md)

**Signature:**
```solidity
function deployAccounts() public;
```

### envOr(string,string) (inherited from Helpers)

- **Signature**: `envOr(string,string)`
- **Visibility**: public
- **Source Range**: 4081:166:500
- **Details**: [function_envOr_string_string.md](./function_envOr_string_string.md)

**Signature:**
```solidity
function envOr(string memory name, string memory defaultValue) public view returns (string memory value);
```

### startStateDiffRecording() (inherited from Helpers)

- **Signature**: `startStateDiffRecording()`
- **Visibility**: public
- **Source Range**: 4253:96:500
- **Details**: [function_startStateDiffRecording.md](./function_startStateDiffRecording.md)

**Signature:**
```solidity
function startStateDiffRecording() public;
```

### envOr(string,bool) (inherited from Helpers)

- **Signature**: `envOr(string,bool)`
- **Visibility**: public
- **Source Range**: 4355:148:500
- **Details**: [function_envOr_string_bool.md](./function_envOr_string_bool.md)

**Signature:**
```solidity
function envOr(string memory name, bool defaultValue) public view returns (bool value);
```

### deployPeripheryAccounts() (inherited from PeripheryHelpers)

- **Signature**: `deployPeripheryAccounts()`
- **Visibility**: public
- **Source Range**: 374:286:667
- **Details**: [function_deployPeripheryAccounts.md](./function_deployPeripheryAccounts.md)

**Signature:**
```solidity
function deployPeripheryAccounts() public;
```

### fromHex(string) (inherited from BaseAPIParser)

- **Signature**: `fromHex(string)`
- **Visibility**: public
- **Source Range**: 373:517:504
- **Details**: [function_fromHex_string.md](./function_fromHex_string.md)

**Signature:**
```solidity
function fromHex(string memory s) public pure returns (bytes memory);
```

### getTickSpacing(uint24) (inherited from UniswapV4Parser)

- **Signature**: `getTickSpacing(uint24)`
- **Visibility**: public
- **Source Range**: 2373:341:506
- **Details**: [function_getTickSpacing_uint24.md](./function_getTickSpacing_uint24.md)

**Signature:**
```solidity
/// @notice Get tick spacing for a given fee tier
///  @param fee The fee tier
///  @return tickSpacing The tick spacing for the fee tier
function getTickSpacing(uint24 fee) public pure returns (int24 tickSpacing);
```

### generateSingleHopSwapCalldata(struct UniswapV4Parser.SingleHopParams,bool) (inherited from UniswapV4Parser)

- **Signature**: `generateSingleHopSwapCalldata(struct UniswapV4Parser.SingleHopParams,bool)`
- **Visibility**: public
- **Source Range**: 3828:1408:506
- **Details**: [function_generateSingleHopSwapCalldata_struct_UniswapV4Parser.SingleHopParams_bool.md](./function_generateSingleHopSwapCalldata_struct_UniswapV4Parser.SingleHopParams_bool.md)

**Signature:**
```solidity
/// @notice Generate hook data for single-hop V4 swap
///  @dev Creates properly encoded data matching SwapUniswapV4Hook expectations
///  @param params The swap parameters
///  @param usePrevHookAmount Whether to use previous hook's output
///  @return hookData Encoded hook data ready for execution
function generateSingleHopSwapCalldata(SingleHopParams memory params, bool usePrevHookAmount) public pure returns (bytes memory hookData);
```

### executeOp(struct UserOpData) (inherited from InternalHelpers)

- **Signature**: `executeOp(struct UserOpData)`
- **Visibility**: public
- **Source Range**: 2902:141:501
- **Details**: [function_executeOp_struct_UserOpData.md](./function_executeOp_struct_UserOpData.md)

**Signature:**
```solidity
function executeOp(UserOpData memory userOpData) public returns (ExecutionReturnData memory);
```

### updateTestVaultPredictions() (inherited from BaseTest)

- **Signature**: `updateTestVaultPredictions()`
- **Visibility**: public
- **Source Range**: 16989:90:545
- **Details**: [function_updateTestVaultPredictions.md](./function_updateTestVaultPredictions.md)

**Signature:**
```solidity
/// @notice Updates test vault predictions with the correct deployer address
///  @dev Should be called from test contracts where address(this) gives the actual deployer
function updateTestVaultPredictions() public;
```
