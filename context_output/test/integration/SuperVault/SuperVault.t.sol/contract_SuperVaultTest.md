# Contract: SuperVaultTest

## Metadata

- **Name**: SuperVaultTest
- **Type**: Contract
- **Path**: test/integration/SuperVault/SuperVault.t.sol

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

### gearToken

```solidity
address internal gearToken
```

### gearboxVault

```solidity
IERC4626 internal gearboxVault
```

**IERC4626**: [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]

### gearboxFarmingPool

```solidity
IGearboxFarmingPool internal gearboxFarmingPool
```

**IGearboxFarmingPool**: [test/vendor/gearbox/IGearboxFarmingPool.sol/interface_IGearboxFarmingPool.md]

### gearSuperVault

```solidity
SuperVault internal gearSuperVault
```

**SuperVault**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

### escrowGearSuperVault

```solidity
SuperVaultEscrow internal escrowGearSuperVault
```

**SuperVaultEscrow**: [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]

### strategyGearSuperVault

```solidity
SuperVaultStrategy internal strategyGearSuperVault
```

**SuperVaultStrategy**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

### tempUserRedemptionAmounts

```solidity
mapping(address => uint256) private tempUserRedemptionAmounts
```

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

### UserPersona

```solidity
struct UserPersona {
    address account;
    uint256 depositAmount;
    uint256 initialBalance;
    uint256 shares;
    uint256 finalBalance;
    uint256 claimableAssets;
}
```

### TradingCycle

```solidity
struct TradingCycle {
    uint256 cycleNumber;
    uint256 depositAmount;
    uint256 sharesAfterDeposit;
    uint256 redeemAmount;
    uint256 claimedAssets;
}
```

### LongTermHolderTestData

```solidity
///  @notice Test focused on long-term holder behavior with single deposit and hold strategy
struct LongTermHolderTestData {
    address holder;
    uint256 depositAmount;
    uint256 initialBalance;
    uint256 shares;
    uint256 redeemShares;
    uint256 pendingRedeem;
    uint256 allocationAmountVault1;
    uint256 allocationAmountVault2;
    uint256 claimableAssets;
    uint256 maxWithdrawAmount;
    uint256 assetsToWithdraw;
    uint256 expectedPrincipal;
    uint256 actualEarnings;
    uint256 finalBalance;
}
```

### RoundingTestVars

```solidity
struct RoundingTestVars {
    uint256 depositAmount;
    uint256 initialShareBalance;
    uint256 initialAssetBalance;
    uint256 initialStrategyBalance;
    uint256 redeemAmount;
    uint256 firstHalf;
    uint256 secondHalf;
    uint256 maxWithdraw;
    uint256 finalShareBalance;
    uint256 finalAssetBalance;
    uint256 finalStrategyBalance;
    uint256 assetsReceived;
    uint256 remainingShareValue;
}
```

### GasEfficiencyTestVars

```solidity
struct GasEfficiencyTestVars {
    uint256 depositAmount;
    address user;
    uint256 gasStart;
    uint256 shares;
    uint256 gasUsedDeposit;
    uint256 gasUsedRequest;
    uint256 totalAssetsAfterProfit;
    uint256 costBasis;
    uint256 expectedProfit;
    ISuperVaultStrategy.FeeConfig feeConfig_;
    uint256 expectedFee;
    address[] hooksAddresses;
    uint256 vault1SharesOut;
    uint256 vault2SharesOut;
    bytes[] hooksData;
    uint256[] expectedAssetsOrSharesOut;
    bytes[] argsForProofs;
    address[] controllers;
    uint256[] totalAssetsOut;
    uint256 gasUsedSkim;
    uint256 gasUsedFulfill;
}
```

### MultipleDepositsTestVars

```solidity
struct MultipleDepositsTestVars {
    uint256 deposit1;
    uint256 deposit2;
    uint256 deposit3;
    uint256 initialCostBasis;
    uint256 expectedCostBasis;
    uint256 totalDeposits;
    uint256 totalAssetsAfterProfit;
    uint256 finalCostBasis;
    uint256 expectedProfit;
    ISuperVaultStrategy.FeeConfig feeConfig_;
    uint256 expectedFee;
    uint256 user1Shares;
    uint256 user2Shares;
    uint256 user3Shares;
    uint256 totalShares;
    uint256 claimable1;
    uint256 claimable2;
    uint256 claimable3;
}
```

### NewYieldSourceVars

```solidity
struct NewYieldSourceVars {
    uint256 depositAmount;
    uint256 initialFluidVaultBalance;
    uint256 initialAaveVaultBalance;
    uint256 initialMockVaultBalance;
    uint256 initialPendleVaultBalance;
    uint256 amountToReallocateFluidVault;
    uint256 amountToReallocateAaveVault;
    uint256 assetAmountToReallocateFromFluidVault;
    uint256 assetAmountToReallocateFromAaveVault;
    uint256 assetAmountToReallocateToMockVault;
    uint256 assetAmountToReallocateToPendleVault;
    uint256 finalFluidVaultBalance;
    uint256 finalAaveVaultBalance;
    uint256 finalMockVaultBalance;
    uint256 finalPendleVaultBalance;
    uint256 initialTotalValue;
    uint256 finalTotalValue;
    IERC4626 newVault;
    address pendleVault;
    uint256 initialFluidVaultPPS;
    uint256 initialAaveVaultPPS;
    uint256 initialPendleVaultPPS;
    uint256 initialMockVaultPPS;
}
```

### MultipleDepositsPartialRedemptionsVars

```solidity
struct MultipleDepositsPartialRedemptionsVars {
    uint256 initialUserAssets;
    uint256 feeBalanceBefore;
    uint256 deposit1Amount;
    uint256 deposit2Amount;
    uint256 deposit3Amount;
    uint256 shares1;
    uint256 shares2;
    uint256 shares3;
    uint256 totalShares;
    uint256 redeemAmount1;
    uint256 totalFee1;
    uint256 userBalanceBeforeRedeem1;
    uint256 treasuryBalanceAfterRedeem1;
    uint256 claimableAssets1;
    uint256 claimableShares1;
    uint256 userAssetsAfterRedeem1;
    uint256 remainingShares;
    uint256 redeemAmount2;
    uint256 totalFee2;
    uint256 userBalanceBeforeRedeem2;
    uint256 treasuryBalanceAfterRedeem2;
    uint256 claimableAssets2;
    uint256 claimableShares2;
    uint256 userAssetsAfterRedeem2;
    uint256 finalShares;
    uint256 totalFee3;
    uint256 userBalanceBeforeRedeem3;
    uint256 treasuryBalanceAfterRedeem3;
    uint256 claimableAssets3;
    uint256 claimableShares3;
    uint256 userAssetsAfterRedeem3;
    uint256 totalDeposits;
    uint256 totalFees;
    uint256 totalAssetsReceived;
}
```

### VaultCreationParams

```solidity
struct VaultCreationParams {
    address asset;
    address manager;
    uint256 minUpdateInterval;
    uint256 maxStaleness;
    uint256 performanceFeeBps;
    string symbol;
}
```

### RebalanceVars

```solidity
struct RebalanceVars {
    uint256 depositAmount;
    uint256 initialFluidVaultBalance;
    uint256 initialAaveVaultBalance;
    uint256 totalAssets;
    uint256 targetFluidVaultAssets;
    uint256 targetAaveVaultAssets;
    uint256 currentFluidVaultAssets;
    uint256 currentAaveVaultAssets;
    uint256 assetsToMove;
    uint256 sharesToRedeem;
    uint256 finalFluidVaultBalance;
    uint256 finalAaveVaultBalance;
    uint256 finalFluidVaultAssets;
    uint256 finalAaveVaultAssets;
    uint256 finalTotalAssets;
    uint256 fluidVaultPercentage;
    uint256 aaveVaultPercentage;
    uint256 initialTotalValue;
}
```

### AllocateNewYieldSourceVars

```solidity
struct AllocateNewYieldSourceVars {
    uint256 depositAmount;
    uint256 initialFluidVaultBalance;
    uint256 initialAaveVaultBalance;
    uint256 initialNewVaultBalance;
    uint256 finalFluidVaultBalance;
    uint256 finalAaveVaultBalance;
    uint256 finalNewVaultBalance;
    uint256 initialTotalValue;
    uint256 finalTotalValue;
}
```

### MultipleOperationsVars

```solidity
struct MultipleOperationsVars {
    uint256 seed;
    uint256[] depositAmounts;
    address[] redeemUsers;
    uint256[] redeemAmounts;
    bool[] selected;
    uint256 selectedCount;
    uint256 totalRedeemShares;
    uint256 redeemSharesVault1;
    uint256 redeemSharesVault2;
    uint256 initialTimestamp;
    uint256 initialTotalAssets;
    uint256 initialTotalSupply;
    uint256 initialPricePerShare;
}
```

### FinalBalanceVerificationVars

```solidity
struct FinalBalanceVerificationVars {
    uint256 finalTotalAssets;
    uint256 finalTotalSupply;
    uint256 finalPricePerShare;
    uint256 totalValueLocked;
    uint256 fluidBalance;
    uint256 aaveBalance;
    uint256 escrowBalance;
    uint256 totalYieldAccrued;
    uint256 yieldPerShare;
    uint256 totalUserShares;
    uint256 totalUserAssets;
    uint256 totalPendingDeposits;
    uint256 totalPendingRedeems;
    uint256 currentShares;
    uint256 currentAssets;
    uint256 expectedShares;
    uint256 expectedAssets;
    uint256 userYieldAccrued;
    bool isRedeemer;
    uint256 redeemedShares;
}
```

### ScenarioNewYieldSourceVars

```solidity
struct ScenarioNewYieldSourceVars {
    uint256 depositAmount;
    uint256 initialFluidVaultBalance;
    uint256 initialAaveVaultBalance;
    uint256 initialNewVaultBalance;
    uint256 amountToReallocateFluidVault;
    uint256 amountToReallocateAaveVault;
    uint256 assetAmountToReallocateFromFluidVault;
    uint256 assetAmountToReallocateFromAaveVault;
    uint256 assetAmountToReallocateToNewVault;
    uint256 finalFluidVaultBalance;
    uint256 finalAaveVaultBalance;
    uint256 finalNewVaultBalance;
    uint256 initialTotalValue;
    uint256 finalTotalValue;
    uint256 initialFluidVaultPPS;
    uint256 initialAaveVaultPPS;
}
```

### VaultLifecycleVars

```solidity
struct VaultLifecycleVars {
    uint256[] userDepositAmounts;
    address[] users;
    uint256 initialFluidVaultPPS;
    uint256 initialAaveVaultPPS;
    uint256 initialTotalValue;
    uint256 finalTotalValue;
    uint256[] userInitialShares;
    uint256[] userInitialAssets;
    uint256[] userFinalShares;
    uint256[] userFinalAssets;
    uint256[] userYields;
}
```

### RugTestVarsDeposit

```solidity
struct RugTestVarsDeposit {
    uint256 depositAmount;
    uint256 initialTotalAssets;
    uint256 initialTotalSupply;
    uint256 initialPricePerShare;
    uint256 rugPercentage;
    address[] depositUsers;
    uint256[] depositAmounts;
    uint256 initialTimestamp;
    RuggableVault ruggableVault;
}
```

### RugTestVarsWithdraw

```solidity
struct RugTestVarsWithdraw {
    bool convertVault;
    uint256 depositAmount;
    uint256 initialTotalAssets;
    uint256 initialTotalSupply;
    uint256 initialPricePerShare;
    uint256 rugPercentage;
    address[] depositUsers;
    uint256[] depositAmounts;
    address[] redeemUsers;
    uint256[] redeemAmounts;
    uint256 totalRedeemShares;
    uint256 redeemSharesVault1;
    uint256 redeemSharesVault2;
    uint256 initialTimestamp;
    address ruggableVault;
    uint256 initialRuggableVaultBalance;
    uint256 initialFluidVaultBalance;
    uint256 initialRuggableVaultAssets;
    uint256 initialFluidVaultAssets;
    uint256 amountToReallocate;
    uint256 assetAmountToReallocate;
    uint256 finalRuggableVaultBalance;
    uint256 finalFluidVaultBalance;
    uint256 finalRuggableVaultAssets;
    uint256 finalFluidVaultAssets;
    uint256 initialTotalValue;
    uint256 finalTotalValue;
    uint256 vaultTotalAssetsAfterAllocation;
    uint256 pricePerShareAfterAllocation;
    uint256 ppsBeforeWarp;
    uint256 ppsAfterWarp;
    uint256[] expectedAssetsOrSharesOut;
    uint256 assetsVault1;
    uint256 assetsVault2;
    uint256 finalTotalAssets;
    uint256 finalTotalSupply;
    uint256 totalAssetsPreClaimTaintedAssets;
    uint256 totalSupplyPreClaimTaintedAssets;
    uint256 pricePerSharePreClaimTaintedAssets;
}
```

### VaultCapTestVars

```solidity
struct VaultCapTestVars {
    address withdrawHookAddress;
    address depositHookAddress;
    address[] hooksAddresses;
    bytes[] hooksData;
    uint256 depositAmount;
    uint256 initialFluidVaultPPS;
    uint256 initialAaveVaultPPS;
    uint256 totalInitialBalance;
    uint256 initialFluidRatio;
    uint256 initialAaveRatio;
    uint256 initialEulerRatio;
    uint256 initialFluidVaultBalance;
    uint256 initialAaveVaultBalance;
    uint256 initialEulerVaultBalance;
    uint256 assetsToMove;
    uint256 finalFluidVaultBalance;
    uint256 finalAaveVaultBalance;
    uint256 finalEulerVaultBalance;
    uint256 totalFinalBalance;
    uint256 finalFluidRatio;
    uint256 finalAaveRatio;
    uint256 finalEulerRatio;
    uint256 newVaultCap;
    uint256 targetFluidAssets2;
    uint256 targetAaveAssets2;
    uint256 targetEulerAssets2;
    uint256 finalFluidVaultBalance2;
    uint256 finalAaveVaultBalance2;
    uint256 finalEulerVaultBalance2;
    uint256 finalFluidRatio2;
    uint256 finalAaveRatio2;
    uint256 finalEulerRatio2;
    uint256 finalTotalValue;
    uint256 newSuperVaultCap;
}
```

### TestVars

```solidity
struct TestVars {
    uint256 initialTimestamp;
    uint256 totalDeposited;
    uint256 initialTotalAssets;
    uint256 initialTotalSupply;
    uint256 initialPricePerShare;
    uint256 finalTotalAssets;
    uint256 finalTotalSupply;
    uint256 finalPricePerShare;
    uint256 fluidVaultBalance;
    uint256 aaveVaultBalance;
    uint256[] depositAmounts;
    address[] depositUsers;
}
```

### YieldTestVars

```solidity
struct YieldTestVars {
    uint256 depositAmount;
    uint256 initialTimestamp;
    Mock4626Vault vault1;
    Mock4626Vault vault2;
    Mock4626Vault vault3;
    uint256 initialVault1Balance;
    uint256 initialVault2Balance;
    uint256 initialVault3Balance;
    uint256 initialVault1Assets;
    uint256 initialVault2Assets;
    uint256 initialVault3Assets;
    uint256 finalVault1Assets;
    uint256 finalVault2Assets;
    uint256 finalVault3Assets;
    uint256 initialTotalAssets;
    uint256 initialTotalSupply;
    uint256 initialPricePerShare;
}
```

### UserAccounting

```solidity
struct UserAccounting {
    address user;
    uint256 shares;
    uint256 assets;
}
```

### EmergencyAssetRecoveryVars

```solidity
struct EmergencyAssetRecoveryVars {
    address vaultAddr;
    address strategyAddr;
    address escrowAddr;
    uint256 depositAmount;
    address[] users;
    uint256[] userShares;
    uint256 totalFreeAssets;
    uint256 halfAmount;
    address depositHookAddress;
    address[] fulfillHooksAddresses;
    bytes[] fulfillHooksData;
    uint256 currentPPS;
    uint256 deviatingPPS;
    uint256 fluidBalance;
    uint256 aaveBalance;
    address[] redeemHooksAddresses;
    bytes[] redeemHooksData;
    uint256 totalAssetsInStrategy;
    UserAccounting[] userAccountingSnapshot;
    uint256 totalShares;
    address batchTransferHook;
    address escrowRecipient;
    bytes batchTransferInspectResult;
    bytes32 batchTransferLeaf;
    bytes32 newStrategistRoot;
    uint256 timelockPeriod;
    bytes32 currentStrategistRoot;
    uint256 assetsToTransfer;
    address[] tokens;
    uint256[] amounts;
    bytes batchTransferData;
    address[] batchTransferHooks;
    bytes[] batchTransferHooksData;
    uint256[] expectedOut;
    bytes32[][] strategyProofs;
    bytes32[][] globalProofs;
    uint256 recipientBalanceBefore;
    uint256 recipientBalanceAfter;
    uint256 strategyBalanceAfter;
    address emergencyVault;
    uint256 emergencyVaultBalance;
    uint256 withdrawAmount;
    uint256 balanceAfterWithdraw;
    uint256 sharesBefore;
    uint256 sharesAfter;
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

### PerformanceFeeSkimmed

```solidity
/// @notice Event declaration for testing
event PerformanceFeeSkimmed(uint256 totalFee, uint256 superformFee);
```

### PPSUpdatedAfterSkim

```solidity
/// @notice Event for testing
event PPSUpdatedAfterSkim(address indexed strategy, uint256 oldPPS, uint256 newPPS, uint256 feeAmount, uint256 timestamp);
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
- **Source Range**: 4547:1422:580
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() override public;
```

### test_SuperVault_Constructor()

- **Signature**: `test_SuperVault_Constructor()`
- **Visibility**: public
- **Source Range**: 6165:1279:580
- **Details**: [function_test_SuperVault_Constructor.md](./function_test_SuperVault_Constructor.md)

**Signature:**
```solidity
function test_SuperVault_Constructor() public;
```

### test_SuperVault_Initializer()

- **Signature**: `test_SuperVault_Initializer()`
- **Visibility**: public
- **Source Range**: 7450:1733:580
- **Details**: [function_test_SuperVault_Initializer.md](./function_test_SuperVault_Initializer.md)

**Signature:**
```solidity
function test_SuperVault_Initializer() public;
```

### test_Name()

- **Signature**: `test_Name()`
- **Visibility**: public
- **Source Range**: 9371:121:580
- **Details**: [function_test_Name.md](./function_test_Name.md)

**Signature:**
```solidity
function test_Name() public view;
```

### test_Symbol()

- **Signature**: `test_Symbol()`
- **Visibility**: public
- **Source Range**: 9498:126:580
- **Details**: [function_test_Symbol.md](./function_test_Symbol.md)

**Signature:**
```solidity
function test_Symbol() public view;
```

### test_DefaultRedeemSlippageBps()

- **Signature**: `test_DefaultRedeemSlippageBps()`
- **Visibility**: public
- **Source Range**: 9630:223:580
- **Details**: [function_test_DefaultRedeemSlippageBps.md](./function_test_DefaultRedeemSlippageBps.md)

**Signature:**
```solidity
function test_DefaultRedeemSlippageBps() public view;
```

### test_DepositXQ()

- **Signature**: `test_DepositXQ()`
- **Visibility**: public
- **Source Range**: 9859:365:580
- **Details**: [function_test_DepositXQ.md](./function_test_DepositXQ.md)

**Signature:**
```solidity
function test_DepositXQ() public;
```

### test_Deposit_RevertCases()

- **Signature**: `test_Deposit_RevertCases()`
- **Visibility**: public
- **Source Range**: 10230:249:580
- **Details**: [function_test_Deposit_RevertCases.md](./function_test_Deposit_RevertCases.md)

**Signature:**
```solidity
function test_Deposit_RevertCases() public;
```

### test_Deposit_RevertWhen_ZeroAmount()

- **Signature**: `test_Deposit_RevertWhen_ZeroAmount()`
- **Visibility**: public
- **Source Range**: 10547:216:580
- **Details**: [function_test_Deposit_RevertWhen_ZeroAmount.md](./function_test_Deposit_RevertWhen_ZeroAmount.md)

**Signature:**
```solidity
/// @notice Dedicated test for zero amount deposit revert
function test_Deposit_RevertWhen_ZeroAmount() public;
```

### test_Deposit_RevertWhen_ZeroAddressReceiver()

- **Signature**: `test_Deposit_RevertWhen_ZeroAddressReceiver()`
- **Visibility**: public
- **Source Range**: 10833:231:580
- **Details**: [function_test_Deposit_RevertWhen_ZeroAddressReceiver.md](./function_test_Deposit_RevertWhen_ZeroAddressReceiver.md)

**Signature:**
```solidity
/// @notice Dedicated test for zero address receiver revert
function test_Deposit_RevertWhen_ZeroAddressReceiver() public;
```

### test_DepositDirectlyMintsShares()

- **Signature**: `test_DepositDirectlyMintsShares()`
- **Visibility**: public
- **Source Range**: 11070:665:580
- **Details**: [function_test_DepositDirectlyMintsShares.md](./function_test_DepositDirectlyMintsShares.md)

**Signature:**
```solidity
function test_DepositDirectlyMintsShares() public;
```

### test_DepositAndAllocateToYield()

- **Signature**: `test_DepositAndAllocateToYield()`
- **Visibility**: public
- **Source Range**: 11741:781:580
- **Details**: [function_test_DepositAndAllocateToYield.md](./function_test_DepositAndAllocateToYield.md)

**Signature:**
```solidity
function test_DepositAndAllocateToYield() public;
```

### test_DepositAndAllocateToYieldViaSmartAccountManager()

- **Signature**: `test_DepositAndAllocateToYieldViaSmartAccountManager()`
- **Visibility**: public
- **Source Range**: 12528:1878:580
- **Details**: [function_test_DepositAndAllocateToYieldViaSmartAccountManager.md](./function_test_DepositAndAllocateToYieldViaSmartAccountManager.md)

**Signature:**
```solidity
function test_DepositAndAllocateToYieldViaSmartAccountManager() public;
```

### test_HandleDeposit_ReturnsCorrectShares()

- **Signature**: `test_HandleDeposit_ReturnsCorrectShares()`
- **Visibility**: public
- **Source Range**: 14412:498:580
- **Details**: [function_test_HandleDeposit_ReturnsCorrectShares.md](./function_test_HandleDeposit_ReturnsCorrectShares.md)

**Signature:**
```solidity
function test_HandleDeposit_ReturnsCorrectShares() public;
```

### test_Mint_RevertCases()

- **Signature**: `test_Mint_RevertCases()`
- **Visibility**: public
- **Source Range**: 14916:240:580
- **Details**: [function_test_Mint_RevertCases.md](./function_test_Mint_RevertCases.md)

**Signature:**
```solidity
function test_Mint_RevertCases() public;
```

### test_HandleMint_RevertCases()

- **Signature**: `test_HandleMint_RevertCases()`
- **Visibility**: public
- **Source Range**: 15162:736:580
- **Details**: [function_test_HandleMint_RevertCases.md](./function_test_HandleMint_RevertCases.md)

**Signature:**
```solidity
function test_HandleMint_RevertCases() public;
```

### test_FulfillRedeem_FullAmountWithThreshold()

- **Signature**: `test_FulfillRedeem_FullAmountWithThreshold()`
- **Visibility**: public
- **Source Range**: 15904:798:580
- **Details**: [function_test_FulfillRedeem_FullAmountWithThreshold.md](./function_test_FulfillRedeem_FullAmountWithThreshold.md)

**Signature:**
```solidity
function test_FulfillRedeem_FullAmountWithThreshold() public;
```

### test_FulfillRedeem_FullAmount()

- **Signature**: `test_FulfillRedeem_FullAmount()`
- **Visibility**: public
- **Source Range**: 16708:741:580
- **Details**: [function_test_FulfillRedeem_FullAmount.md](./function_test_FulfillRedeem_FullAmount.md)

**Signature:**
```solidity
function test_FulfillRedeem_FullAmount() public;
```

### test_DepositAndAllocate()

- **Signature**: `test_DepositAndAllocate()`
- **Visibility**: public
- **Source Range**: 17455:627:580
- **Details**: [function_test_DepositAndAllocate.md](./function_test_DepositAndAllocate.md)

**Signature:**
```solidity
function test_DepositAndAllocate() public;
```

### test_PauseAndUnpauseStrategy()

- **Signature**: `test_PauseAndUnpauseStrategy()`
- **Visibility**: public
- **Source Range**: 18088:1367:580
- **Details**: [function_test_PauseAndUnpauseStrategy.md](./function_test_PauseAndUnpauseStrategy.md)

**Signature:**
```solidity
function test_PauseAndUnpauseStrategy() public;
```

### test_RequestRedeem()

- **Signature**: `test_RequestRedeem()`
- **Visibility**: public
- **Source Range**: 19642:1256:580
- **Details**: [function_test_RequestRedeem.md](./function_test_RequestRedeem.md)

**Signature:**
```solidity
function test_RequestRedeem() public;
```

### test_FulfillRedeem()

- **Signature**: `test_FulfillRedeem()`
- **Visibility**: public
- **Source Range**: 20904:804:580
- **Details**: [function_test_FulfillRedeem.md](./function_test_FulfillRedeem.md)

**Signature:**
```solidity
function test_FulfillRedeem() public;
```

### test_ClaimRedeem()

- **Signature**: `test_ClaimRedeem()`
- **Visibility**: public
- **Source Range**: 21714:1951:580
- **Details**: [function_test_ClaimRedeem.md](./function_test_ClaimRedeem.md)

**Signature:**
```solidity
function test_ClaimRedeem() public;
```

### test_LongTermHolder_vs_ActiveTrader_SameAmounts()

- **Signature**: `test_LongTermHolder_vs_ActiveTrader_SameAmounts()`
- **Visibility**: public
- **Source Range**: 23671:1387:580
- **Details**: [function_test_LongTermHolder_vs_ActiveTrader_SameAmounts.md](./function_test_LongTermHolder_vs_ActiveTrader_SameAmounts.md)

**Signature:**
```solidity
function test_LongTermHolder_vs_ActiveTrader_SameAmounts() public;
```

### test_LongTermHolder_vs_ActiveTrader_CompleteYieldComparison()

- **Signature**: `test_LongTermHolder_vs_ActiveTrader_CompleteYieldComparison()`
- **Visibility**: public
- **Source Range**: 25157:2374:580
- **Details**: [function_test_LongTermHolder_vs_ActiveTrader_CompleteYieldComparison.md](./function_test_LongTermHolder_vs_ActiveTrader_CompleteYieldComparison.md)

**Signature:**
```solidity
/// @notice Complete yield comparison test that shows final earnings for both strategies
function test_LongTermHolder_vs_ActiveTrader_CompleteYieldComparison() public;
```

### test_LongTermHolder_vs_ActiveTrader()

- **Signature**: `test_LongTermHolder_vs_ActiveTrader()`
- **Visibility**: public
- **Source Range**: 27743:1373:580
- **Details**: [function_test_LongTermHolder_vs_ActiveTrader.md](./function_test_LongTermHolder_vs_ActiveTrader.md)

**Signature:**
```solidity
///  @notice Test simulating different user personas: Long-term holder vs Active trader
///  @dev This test demonstrates how different user behaviors interact with the SuperVault system
function test_LongTermHolder_vs_ActiveTrader() public;
```

### test_LongTermHolder_SingleDepositHold()

- **Signature**: `test_LongTermHolder_SingleDepositHold()`
- **Visibility**: public
- **Source Range**: 29122:5414:580
- **Details**: [function_test_LongTermHolder_SingleDepositHold.md](./function_test_LongTermHolder_SingleDepositHold.md)

**Signature:**
```solidity
function test_LongTermHolder_SingleDepositHold() public;
```

### test_ActiveTrader_MultipleDepositRedeemCycles()

- **Signature**: `test_ActiveTrader_MultipleDepositRedeemCycles()`
- **Visibility**: public
- **Source Range**: 34654:3793:580
- **Details**: [function_test_ActiveTrader_MultipleDepositRedeemCycles.md](./function_test_ActiveTrader_MultipleDepositRedeemCycles.md)

**Signature:**
```solidity
///  @notice Test focused on active trader behavior with multiple rapid deposit-redeem cycles
function test_ActiveTrader_MultipleDepositRedeemCycles() public;
```

### test_AuthorizeOperator()

- **Signature**: `test_AuthorizeOperator()`
- **Visibility**: public
- **Source Range**: 38453:1251:580
- **Details**: [function_test_AuthorizeOperator.md](./function_test_AuthorizeOperator.md)

**Signature:**
```solidity
function test_AuthorizeOperator() public;
```

### test_RevertWhen_AuthorizingOperatorWithExpiredDeadline()

- **Signature**: `test_RevertWhen_AuthorizingOperatorWithExpiredDeadline()`
- **Visibility**: public
- **Source Range**: 39710:989:580
- **Details**: [function_test_RevertWhen_AuthorizingOperatorWithExpiredDeadline.md](./function_test_RevertWhen_AuthorizingOperatorWithExpiredDeadline.md)

**Signature:**
```solidity
function test_RevertWhen_AuthorizingOperatorWithExpiredDeadline() public;
```

### test_RevertWhen_AuthorizingOperatorWithUsedNonce()

- **Signature**: `test_RevertWhen_AuthorizingOperatorWithUsedNonce()`
- **Visibility**: public
- **Source Range**: 40705:1099:580
- **Details**: [function_test_RevertWhen_AuthorizingOperatorWithUsedNonce.md](./function_test_RevertWhen_AuthorizingOperatorWithUsedNonce.md)

**Signature:**
```solidity
function test_RevertWhen_AuthorizingOperatorWithUsedNonce() public;
```

### test_RevertWhen_AuthorizingOperatorWithInvalidSignature()

- **Signature**: `test_RevertWhen_AuthorizingOperatorWithInvalidSignature()`
- **Visibility**: public
- **Source Range**: 41810:1033:580
- **Details**: [function_test_RevertWhen_AuthorizingOperatorWithInvalidSignature.md](./function_test_RevertWhen_AuthorizingOperatorWithInvalidSignature.md)

**Signature:**
```solidity
function test_RevertWhen_AuthorizingOperatorWithInvalidSignature() public;
```

### test_RevertWhen_OperatorAuthorizingSelf()

- **Signature**: `test_RevertWhen_OperatorAuthorizingSelf()`
- **Visibility**: public
- **Source Range**: 42849:916:580
- **Details**: [function_test_RevertWhen_OperatorAuthorizingSelf.md](./function_test_RevertWhen_OperatorAuthorizingSelf.md)

**Signature:**
```solidity
function test_RevertWhen_OperatorAuthorizingSelf() public;
```

### test_RevertWhen_AuthorizingOperatorWithDifferentChainId()

- **Signature**: `test_RevertWhen_AuthorizingOperatorWithDifferentChainId()`
- **Visibility**: public
- **Source Range**: 43771:1145:580
- **Details**: [function_test_RevertWhen_AuthorizingOperatorWithDifferentChainId.md](./function_test_RevertWhen_AuthorizingOperatorWithDifferentChainId.md)

**Signature:**
```solidity
function test_RevertWhen_AuthorizingOperatorWithDifferentChainId() public;
```

### test_InvalidateNonce()

- **Signature**: `test_InvalidateNonce()`
- **Visibility**: public
- **Source Range**: 44922:1143:580
- **Details**: [function_test_InvalidateNonce.md](./function_test_InvalidateNonce.md)

**Signature:**
```solidity
function test_InvalidateNonce() public;
```

### test_TotalAssets()

- **Signature**: `test_TotalAssets()`
- **Visibility**: public
- **Source Range**: 46071:720:580
- **Details**: [function_test_TotalAssets.md](./function_test_TotalAssets.md)

**Signature:**
```solidity
function test_TotalAssets() public;
```

### test_ConvertToShares()

- **Signature**: `test_ConvertToShares()`
- **Visibility**: public
- **Source Range**: 46797:637:580
- **Details**: [function_test_ConvertToShares.md](./function_test_ConvertToShares.md)

**Signature:**
```solidity
function test_ConvertToShares() public;
```

### test_ConvertToAssets()

- **Signature**: `test_ConvertToAssets()`
- **Visibility**: public
- **Source Range**: 47440:654:580
- **Details**: [function_test_ConvertToAssets.md](./function_test_ConvertToAssets.md)

**Signature:**
```solidity
function test_ConvertToAssets() public;
```

### test_ConvertFunctions_ZeroPPS_RealVault()

- **Signature**: `test_ConvertFunctions_ZeroPPS_RealVault()`
- **Visibility**: public
- **Source Range**: 48298:3096:580
- **Details**: [function_test_ConvertFunctions_ZeroPPS_RealVault.md](./function_test_ConvertFunctions_ZeroPPS_RealVault.md)

**Signature:**
```solidity
/// @notice Tests that zero PPS is never stored (protection for external integrators)
///  @dev This verifies that attempting to set PPS to 0 (even with escape hatch) keeps the old PPS value
function test_ConvertFunctions_ZeroPPS_RealVault() public;
```

### test_MaxMint()

- **Signature**: `test_MaxMint()`
- **Visibility**: public
- **Source Range**: 51400:376:580
- **Details**: [function_test_MaxMint.md](./function_test_MaxMint.md)

**Signature:**
```solidity
function test_MaxMint() public view;
```

### test_MaxWithdraw()

- **Signature**: `test_MaxWithdraw()`
- **Visibility**: public
- **Source Range**: 51782:1172:580
- **Details**: [function_test_MaxWithdraw.md](./function_test_MaxWithdraw.md)

**Signature:**
```solidity
function test_MaxWithdraw() public;
```

### test_MaxRedeem()

- **Signature**: `test_MaxRedeem()`
- **Visibility**: public
- **Source Range**: 52960:1628:580
- **Details**: [function_test_MaxRedeem.md](./function_test_MaxRedeem.md)

**Signature:**
```solidity
function test_MaxRedeem() public;
```

### test_PreviewDepositAndMint()

- **Signature**: `test_PreviewDepositAndMint()`
- **Visibility**: public
- **Source Range**: 54594:637:580
- **Details**: [function_test_PreviewDepositAndMint.md](./function_test_PreviewDepositAndMint.md)

**Signature:**
```solidity
function test_PreviewDepositAndMint() public view;
```

### test_RevertWhen_PreviewWithdraw()

- **Signature**: `test_RevertWhen_PreviewWithdraw()`
- **Visibility**: public
- **Source Range**: 55237:268:580
- **Details**: [function_test_RevertWhen_PreviewWithdraw.md](./function_test_RevertWhen_PreviewWithdraw.md)

**Signature:**
```solidity
function test_RevertWhen_PreviewWithdraw() public;
```

### test_RevertWhen_PreviewRedeem()

- **Signature**: `test_RevertWhen_PreviewRedeem()`
- **Visibility**: public
- **Source Range**: 55511:264:580
- **Details**: [function_test_RevertWhen_PreviewRedeem.md](./function_test_RevertWhen_PreviewRedeem.md)

**Signature:**
```solidity
function test_RevertWhen_PreviewRedeem() public;
```

### test_Redeem()

- **Signature**: `test_Redeem()`
- **Visibility**: public
- **Source Range**: 55781:1380:580
- **Details**: [function_test_Redeem.md](./function_test_Redeem.md)

**Signature:**
```solidity
function test_Redeem() public;
```

### test_Redeem_RevertCases()

- **Signature**: `test_Redeem_RevertCases()`
- **Visibility**: public
- **Source Range**: 57167:1593:580
- **Details**: [function_test_Redeem_RevertCases.md](./function_test_Redeem_RevertCases.md)

**Signature:**
```solidity
function test_Redeem_RevertCases() public;
```

### test_Withdraw_InvalidAmount()

- **Signature**: `test_Withdraw_InvalidAmount()`
- **Visibility**: public
- **Source Range**: 58766:690:580
- **Details**: [function_test_Withdraw_InvalidAmount.md](./function_test_Withdraw_InvalidAmount.md)

**Signature:**
```solidity
function test_Withdraw_InvalidAmount() public;
```

### test_PendingRedeemRequest()

- **Signature**: `test_PendingRedeemRequest()`
- **Visibility**: public
- **Source Range**: 59652:950:580
- **Details**: [function_test_PendingRedeemRequest.md](./function_test_PendingRedeemRequest.md)

**Signature:**
```solidity
function test_PendingRedeemRequest() public;
```

### test_CancelRedeem()

- **Signature**: `test_CancelRedeem()`
- **Visibility**: public
- **Source Range**: 60608:1960:580
- **Details**: [function_test_CancelRedeem.md](./function_test_CancelRedeem.md)

**Signature:**
```solidity
function test_CancelRedeem() public;
```

### test_ClaimCancelRedeem_RevertCases()

- **Signature**: `test_ClaimCancelRedeem_RevertCases()`
- **Visibility**: public
- **Source Range**: 62574:1029:580
- **Details**: [function_test_ClaimCancelRedeem_RevertCases.md](./function_test_ClaimCancelRedeem_RevertCases.md)

**Signature:**
```solidity
function test_ClaimCancelRedeem_RevertCases() public;
```

### test_SetOperator()

- **Signature**: `test_SetOperator()`
- **Visibility**: public
- **Source Range**: 63798:806:580
- **Details**: [function_test_SetOperator.md](./function_test_SetOperator.md)

**Signature:**
```solidity
function test_SetOperator() public;
```

### test_SupportsInterface()

- **Signature**: `test_SupportsInterface()`
- **Visibility**: public
- **Source Range**: 64797:956:580
- **Details**: [function_test_SupportsInterface.md](./function_test_SupportsInterface.md)

**Signature:**
```solidity
function test_SupportsInterface() public view;
```

### test_ValidateOwnerOrOperator()

- **Signature**: `test_ValidateOwnerOrOperator()`
- **Visibility**: public
- **Source Range**: 65954:347:580
- **Details**: [function_test_ValidateOwnerOrOperator.md](./function_test_ValidateOwnerOrOperator.md)

**Signature:**
```solidity
function test_ValidateOwnerOrOperator() public;
```

### test_RevertWhen_UnauthorizedBurnShares()

- **Signature**: `test_RevertWhen_UnauthorizedBurnShares()`
- **Visibility**: public
- **Source Range**: 66498:279:580
- **Details**: [function_test_RevertWhen_UnauthorizedBurnShares.md](./function_test_RevertWhen_UnauthorizedBurnShares.md)

**Signature:**
```solidity
function test_RevertWhen_UnauthorizedBurnShares() public;
```

### test_RequestRedeem_MultipleUsers(uint256)

- **Signature**: `test_RequestRedeem_MultipleUsers(uint256)`
- **Visibility**: public
- **Source Range**: 66967:393:580
- **Details**: [function_test_RequestRedeem_MultipleUsers_uint256.md](./function_test_RequestRedeem_MultipleUsers_uint256.md)

**Signature:**
```solidity
function test_RequestRedeem_MultipleUsers(uint256 depositAmount) public;
```

### test_RequestRedeemMultipleUsers_With_CompleteFullfilment(uint256)

- **Signature**: `test_RequestRedeemMultipleUsers_With_CompleteFullfilment(uint256)`
- **Visibility**: public
- **Source Range**: 67366:1485:580
- **Details**: [function_test_RequestRedeemMultipleUsers_With_CompleteFullfilment_uint256.md](./function_test_RequestRedeemMultipleUsers_With_CompleteFullfilment_uint256.md)

**Signature:**
```solidity
function test_RequestRedeemMultipleUsers_With_CompleteFullfilment(uint256 depositAmount) public;
```

### test_RequestRedeem_MultipleUsers_DifferentAmounts()

- **Signature**: `test_RequestRedeem_MultipleUsers_DifferentAmounts()`
- **Visibility**: public
- **Source Range**: 68857:1929:580
- **Details**: [function_test_RequestRedeem_MultipleUsers_DifferentAmounts.md](./function_test_RequestRedeem_MultipleUsers_DifferentAmounts.md)

**Signature:**
```solidity
function test_RequestRedeem_MultipleUsers_DifferentAmounts() public;
```

### test_RequestRedeemMultipleUsers_With_PartialUsersFullfilment(uint256)

- **Signature**: `test_RequestRedeemMultipleUsers_With_PartialUsersFullfilment(uint256)`
- **Visibility**: public
- **Source Range**: 70792:3133:580
- **Details**: [function_test_RequestRedeemMultipleUsers_With_PartialUsersFullfilment_uint256.md](./function_test_RequestRedeemMultipleUsers_With_PartialUsersFullfilment_uint256.md)

**Signature:**
```solidity
function test_RequestRedeemMultipleUsers_With_PartialUsersFullfilment(uint256 depositAmount) public;
```

### test_RequestRedeem_RevertOnExceedingBalance(uint256)

- **Signature**: `test_RequestRedeem_RevertOnExceedingBalance(uint256)`
- **Visibility**: public
- **Source Range**: 73931:610:580
- **Details**: [function_test_RequestRedeem_RevertOnExceedingBalance_uint256.md](./function_test_RequestRedeem_RevertOnExceedingBalance_uint256.md)

**Signature:**
```solidity
function test_RequestRedeem_RevertOnExceedingBalance(uint256 depositAmount) public;
```

### test_ClaimRedeem_RevertBeforeFulfillment()

- **Signature**: `test_ClaimRedeem_RevertBeforeFulfillment()`
- **Visibility**: public
- **Source Range**: 74547:1549:580
- **Details**: [function_test_ClaimRedeem_RevertBeforeFulfillment.md](./function_test_ClaimRedeem_RevertBeforeFulfillment.md)

**Signature:**
```solidity
function test_ClaimRedeem_RevertBeforeFulfillment() public;
```

### test_ClaimRedeem_AfterPriceIncrease()

- **Signature**: `test_ClaimRedeem_AfterPriceIncrease()`
- **Visibility**: public
- **Source Range**: 76102:2815:580
- **Details**: [function_test_ClaimRedeem_AfterPriceIncrease.md](./function_test_ClaimRedeem_AfterPriceIncrease.md)

**Signature:**
```solidity
function test_ClaimRedeem_AfterPriceIncrease() public;
```

### test_Redeem_RoundingBehavior()

- **Signature**: `test_Redeem_RoundingBehavior()`
- **Visibility**: public
- **Source Range**: 82163:2084:580
- **Details**: [function_test_Redeem_RoundingBehavior.md](./function_test_Redeem_RoundingBehavior.md)

**Signature:**
```solidity
function test_Redeem_RoundingBehavior() public;
```

### externalClaimWithdraw(struct AccountInstance,uint256)

- **Signature**: `externalClaimWithdraw(struct AccountInstance,uint256)`
- **Visibility**: external
- **Source Range**: 84253:146:580
- **Details**: [function_externalClaimWithdraw_struct_AccountInstance_uint256.md](./function_externalClaimWithdraw_struct_AccountInstance_uint256.md)

**Signature:**
```solidity
function externalClaimWithdraw(AccountInstance memory accInst, uint256 assets) external;
```

### test_RequestRedeem_VerifyAmounts()

- **Signature**: `test_RequestRedeem_VerifyAmounts()`
- **Visibility**: public
- **Source Range**: 84405:3301:580
- **Details**: [function_test_RequestRedeem_VerifyAmounts.md](./function_test_RequestRedeem_VerifyAmounts.md)

**Signature:**
```solidity
function test_RequestRedeem_VerifyAmounts() public;
```

### test_MultipleUsers_SameAllocation_EqualRedeemValue()

- **Signature**: `test_MultipleUsers_SameAllocation_EqualRedeemValue()`
- **Visibility**: public
- **Source Range**: 87712:3689:580
- **Details**: [function_test_MultipleUsers_SameAllocation_EqualRedeemValue.md](./function_test_MultipleUsers_SameAllocation_EqualRedeemValue.md)

**Signature:**
```solidity
function test_MultipleUsers_SameAllocation_EqualRedeemValue() public;
```

### test_MultipleUsers_ChangingAllocation_RedeemValue()

- **Signature**: `test_MultipleUsers_ChangingAllocation_RedeemValue()`
- **Visibility**: public
- **Source Range**: 91407:3697:580
- **Details**: [function_test_MultipleUsers_ChangingAllocation_RedeemValue.md](./function_test_MultipleUsers_ChangingAllocation_RedeemValue.md)

**Signature:**
```solidity
function test_MultipleUsers_ChangingAllocation_RedeemValue() public;
```

### test_gasReport_RequestRedeem()

- **Signature**: `test_gasReport_RequestRedeem()`
- **Visibility**: public
- **Source Range**: 96301:734:580
- **Details**: [function_test_gasReport_RequestRedeem.md](./function_test_gasReport_RequestRedeem.md)

**Signature:**
```solidity
function test_gasReport_RequestRedeem() public;
```

### test_gasReport_ClaimRedeem()

- **Signature**: `test_gasReport_ClaimRedeem()`
- **Visibility**: public
- **Source Range**: 97041:1615:580
- **Details**: [function_test_gasReport_ClaimRedeem.md](./function_test_gasReport_ClaimRedeem.md)

**Signature:**
```solidity
function test_gasReport_ClaimRedeem() public;
```

### test_gasReport_TwoVaults_Fulfill()

- **Signature**: `test_gasReport_TwoVaults_Fulfill()`
- **Visibility**: public
- **Source Range**: 98662:186:580
- **Details**: [function_test_gasReport_TwoVaults_Fulfill.md](./function_test_gasReport_TwoVaults_Fulfill.md)

**Signature:**
```solidity
function test_gasReport_TwoVaults_Fulfill() public;
```

### test_gasReport_ThreeVaults_Fulfill_And_Rebalance()

- **Signature**: `test_gasReport_ThreeVaults_Fulfill_And_Rebalance()`
- **Visibility**: public
- **Source Range**: 98854:8906:580
- **Details**: [function_test_gasReport_ThreeVaults_Fulfill_And_Rebalance.md](./function_test_gasReport_ThreeVaults_Fulfill_And_Rebalance.md)

**Signature:**
```solidity
function test_gasReport_ThreeVaults_Fulfill_And_Rebalance() public;
```

### test_SuperVault_E2E_Flow_With_Ledger_Fees()

- **Signature**: `test_SuperVault_E2E_Flow_With_Ledger_Fees()`
- **Visibility**: public
- **Source Range**: 109600:3492:580
- **Details**: [function_test_SuperVault_E2E_Flow_With_Ledger_Fees.md](./function_test_SuperVault_E2E_Flow_With_Ledger_Fees.md)

**Signature:**
```solidity
function test_SuperVault_E2E_Flow_With_Ledger_Fees() public;
```

### test_SuperVault_E2E_Flow_With_PPS_Slippage_Update()

- **Signature**: `test_SuperVault_E2E_Flow_With_PPS_Slippage_Update()`
- **Visibility**: public
- **Source Range**: 113098:3150:580
- **Details**: [function_test_SuperVault_E2E_Flow_With_PPS_Slippage_Update.md](./function_test_SuperVault_E2E_Flow_With_PPS_Slippage_Update.md)

**Signature:**
```solidity
function test_SuperVault_E2E_Flow_With_PPS_Slippage_Update() public;
```

### test_SuperVault_E2E_Flow_With_0_Ledger_Fees()

- **Signature**: `test_SuperVault_E2E_Flow_With_0_Ledger_Fees()`
- **Visibility**: public
- **Source Range**: 116254:2777:580
- **Details**: [function_test_SuperVault_E2E_Flow_With_0_Ledger_Fees.md](./function_test_SuperVault_E2E_Flow_With_0_Ledger_Fees.md)

**Signature:**
```solidity
function test_SuperVault_E2E_Flow_With_0_Ledger_Fees() public;
```

### test_SuperVault_MultipleDeposits_PartialRedemptions()

- **Signature**: `test_SuperVault_MultipleDeposits_PartialRedemptions()`
- **Visibility**: public
- **Source Range**: 119037:12282:580
- **Details**: [function_test_SuperVault_MultipleDeposits_PartialRedemptions.md](./function_test_SuperVault_MultipleDeposits_PartialRedemptions.md)

**Signature:**
```solidity
function test_SuperVault_MultipleDeposits_PartialRedemptions() public;
```

### test_DeployVault()

- **Signature**: `test_DeployVault()`
- **Visibility**: public
- **Source Range**: 131509:1628:580
- **Details**: [function_test_DeployVault.md](./function_test_DeployVault.md)

**Signature:**
```solidity
function test_DeployVault() public;
```

### test_DeployMultipleVaults()

- **Signature**: `test_DeployMultipleVaults()`
- **Visibility**: public
- **Source Range**: 133143:719:580
- **Details**: [function_test_DeployMultipleVaults.md](./function_test_DeployMultipleVaults.md)

**Signature:**
```solidity
function test_DeployMultipleVaults() public;
```

### test_RevertOnZeroAddresses()

- **Signature**: `test_RevertOnZeroAddresses()`
- **Visibility**: public
- **Source Range**: 133868:932:580
- **Details**: [function_test_RevertOnZeroAddresses.md](./function_test_RevertOnZeroAddresses.md)

**Signature:**
```solidity
function test_RevertOnZeroAddresses() public;
```

### test_CreateVaultWithSecondaryManagers()

- **Signature**: `test_CreateVaultWithSecondaryManagers()`
- **Visibility**: public
- **Source Range**: 134806:854:580
- **Details**: [function_test_CreateVaultWithSecondaryManagers.md](./function_test_CreateVaultWithSecondaryManagers.md)

**Signature:**
```solidity
function test_CreateVaultWithSecondaryManagers() public;
```

### test_SuperVault_StakeClaimFlow()

- **Signature**: `test_SuperVault_StakeClaimFlow()`
- **Visibility**: public
- **Source Range**: 137809:4328:580
- **Details**: [function_test_SuperVault_StakeClaimFlow.md](./function_test_SuperVault_StakeClaimFlow.md)

**Signature:**
```solidity
function test_SuperVault_StakeClaimFlow() public;
```

### test_SuperBank_TokenBridge_BaseToETH()

- **Signature**: `test_SuperBank_TokenBridge_BaseToETH()`
- **Visibility**: public
- **Source Range**: 151794:752:580
- **Details**: [function_test_SuperBank_TokenBridge_BaseToETH.md](./function_test_SuperBank_TokenBridge_BaseToETH.md)

**Signature:**
```solidity
function test_SuperBank_TokenBridge_BaseToETH() public;
```

### _tryGetBaseMerkleRoot()

- **Signature**: `_tryGetBaseMerkleRoot()`
- **Visibility**: external
- **Source Range**: 167191:280:580
- **Details**: [function__tryGetBaseMerkleRoot.md](./function__tryGetBaseMerkleRoot.md)

**Signature:**
```solidity
///  @notice Try to get Base chain merkle root, with fallback to single-leaf
///  @return root The merkle root for Base chain
function _tryGetBaseMerkleRoot() external returns (bytes32 root);
```

### _tryGetBaseMerkleProofsForChain(address[],bytes[])

- **Signature**: `_tryGetBaseMerkleProofsForChain(address[],bytes[])`
- **Visibility**: external
- **Source Range**: 168702:254:580
- **Details**: [function__tryGetBaseMerkleProofsForChain_address[]_bytes[].md](./function__tryGetBaseMerkleProofsForChain_address[]_bytes[].md)

**Signature:**
```solidity
///  @notice External function to get Base merkle proofs (needed for try-catch)
///  @param hookAddresses Array of hook addresses
///  @param argsForProofs Array of encoded arguments
///  @return proofs Array of merkle proofs
function _tryGetBaseMerkleProofsForChain(address[] memory hookAddresses, bytes[] memory argsForProofs) external returns (bytes32[][] memory proofs);
```

### test_Allocate_Rebalance()

- **Signature**: `test_Allocate_Rebalance()`
- **Visibility**: public
- **Source Range**: 174792:3867:580
- **Details**: [function_test_Allocate_Rebalance.md](./function_test_Allocate_Rebalance.md)

**Signature:**
```solidity
function test_Allocate_Rebalance() public;
```

### test_Allocate_SmallAmounts()

- **Signature**: `test_Allocate_SmallAmounts()`
- **Visibility**: public
- **Source Range**: 178665:3564:580
- **Details**: [function_test_Allocate_SmallAmounts.md](./function_test_Allocate_SmallAmounts.md)

**Signature:**
```solidity
function test_Allocate_SmallAmounts() public;
```

### test_Allocate_LargeAmounts()

- **Signature**: `test_Allocate_LargeAmounts()`
- **Visibility**: public
- **Source Range**: 182235:3568:580
- **Details**: [function_test_Allocate_LargeAmounts.md](./function_test_Allocate_LargeAmounts.md)

**Signature:**
```solidity
function test_Allocate_LargeAmounts() public;
```

### test_Allocate_NewYieldSource()

- **Signature**: `test_Allocate_NewYieldSource()`
- **Visibility**: public
- **Source Range**: 186195:6103:580
- **Details**: [function_test_Allocate_NewYieldSource.md](./function_test_Allocate_NewYieldSource.md)

**Signature:**
```solidity
function test_Allocate_NewYieldSource() public;
```

### test_13_TransferOfShares()

- **Signature**: `test_13_TransferOfShares()`
- **Visibility**: public
- **Source Range**: 192304:1171:580
- **Details**: [function_test_13_TransferOfShares.md](./function_test_13_TransferOfShares.md)

**Signature:**
```solidity
function test_13_TransferOfShares() public;
```

### test_13_TransferFromOfShares()

- **Signature**: `test_13_TransferFromOfShares()`
- **Visibility**: public
- **Source Range**: 193481:1321:580
- **Details**: [function_test_13_TransferFromOfShares.md](./function_test_13_TransferFromOfShares.md)

**Signature:**
```solidity
function test_13_TransferFromOfShares() public;
```

### test_Fix10_DepositAccountingFollowsReceiver()

- **Signature**: `test_Fix10_DepositAccountingFollowsReceiver()`
- **Visibility**: public
- **Source Range**: 195082:995:580
- **Details**: [function_test_Fix10_DepositAccountingFollowsReceiver.md](./function_test_Fix10_DepositAccountingFollowsReceiver.md)

**Signature:**
```solidity
/// @notice Test that deposit accounting follows the minted receiver
function test_Fix10_DepositAccountingFollowsReceiver() public;
```

### test_Fix10_ReceiverCanRedeemAfterReceivingDeposit()

- **Signature**: `test_Fix10_ReceiverCanRedeemAfterReceivingDeposit()`
- **Visibility**: public
- **Source Range**: 196184:2343:580
- **Details**: [function_test_Fix10_ReceiverCanRedeemAfterReceivingDeposit.md](./function_test_Fix10_ReceiverCanRedeemAfterReceivingDeposit.md)

**Signature:**
```solidity
/// @notice Test that receiver can successfully redeem after receiving deposit from another user
function test_Fix10_ReceiverCanRedeemAfterReceivingDeposit() public;
```

### test_Fix15_RevertWhen_ControllerNotEqualOwner()

- **Signature**: `test_Fix15_RevertWhen_ControllerNotEqualOwner()`
- **Visibility**: public
- **Source Range**: 198807:979:580
- **Details**: [function_test_Fix15_RevertWhen_ControllerNotEqualOwner.md](./function_test_Fix15_RevertWhen_ControllerNotEqualOwner.md)

**Signature:**
```solidity
/// @notice Test that requestRedeem reverts when controller != owner
function test_Fix15_RevertWhen_ControllerNotEqualOwner() public;
```

### test_Fix15_SucceedsWhen_ControllerEqualsOwner()

- **Signature**: `test_Fix15_SucceedsWhen_ControllerEqualsOwner()`
- **Visibility**: public
- **Source Range**: 199866:1070:580
- **Details**: [function_test_Fix15_SucceedsWhen_ControllerEqualsOwner.md](./function_test_Fix15_SucceedsWhen_ControllerEqualsOwner.md)

**Signature:**
```solidity
/// @notice Test that requestRedeem succeeds when controller == owner
function test_Fix15_SucceedsWhen_ControllerEqualsOwner() public;
```

### test_Fix15_FulfillmentWorksWithMatchedControllerOwner()

- **Signature**: `test_Fix15_FulfillmentWorksWithMatchedControllerOwner()`
- **Visibility**: public
- **Source Range**: 201046:1865:580
- **Details**: [function_test_Fix15_FulfillmentWorksWithMatchedControllerOwner.md](./function_test_Fix15_FulfillmentWorksWithMatchedControllerOwner.md)

**Signature:**
```solidity
/// @notice Test that fulfillment works correctly when controller == owner (no INSUFFICIENT_SHARES)
function test_Fix15_FulfillmentWorksWithMatchedControllerOwner() public;
```

### test_Fix1_TransferDoesNotAffectRequestClaimState()

- **Signature**: `test_Fix1_TransferDoesNotAffectRequestClaimState()`
- **Visibility**: public
- **Source Range**: 203203:3118:580
- **Details**: [function_test_Fix1_TransferDoesNotAffectRequestClaimState.md](./function_test_Fix1_TransferDoesNotAffectRequestClaimState.md)

**Signature:**
```solidity
/// @notice Test that transfer only moves accumulators, never touches request/claim state
function test_Fix1_TransferDoesNotAffectRequestClaimState() public;
```

### test_Fix1_TransferMovesAccumulatorsProRata()

- **Signature**: `test_Fix1_TransferMovesAccumulatorsProRata()`
- **Visibility**: public
- **Source Range**: 206421:1005:580
- **Details**: [function_test_Fix1_TransferMovesAccumulatorsProRata.md](./function_test_Fix1_TransferMovesAccumulatorsProRata.md)

**Signature:**
```solidity
/// @notice Test that transfer moves accumulators pro-rata and conserves total cost basis
function test_Fix1_TransferMovesAccumulatorsProRata() public;
```

### test_Fix1_ZeroValueTransferIsNoOp()

- **Signature**: `test_Fix1_ZeroValueTransferIsNoOp()`
- **Visibility**: public
- **Source Range**: 207489:1684:580
- **Details**: [function_test_Fix1_ZeroValueTransferIsNoOp.md](./function_test_Fix1_ZeroValueTransferIsNoOp.md)

**Signature:**
```solidity
/// @notice Test that zero-value transfer is a no-op
function test_Fix1_ZeroValueTransferIsNoOp() public;
```

### test_Fix1_AuditAttackScenarioFails()

- **Signature**: `test_Fix1_AuditAttackScenarioFails()`
- **Visibility**: public
- **Source Range**: 209270:3059:580
- **Details**: [function_test_Fix1_AuditAttackScenarioFails.md](./function_test_Fix1_AuditAttackScenarioFails.md)

**Signature:**
```solidity
/// @notice Test that audit #1 attack scenario fails - no clone/overwrite of claimable
function test_Fix1_AuditAttackScenarioFails() public;
```

### test_Fix45_CancelReRequestFulfillWorks()

- **Signature**: `test_Fix45_CancelReRequestFulfillWorks()`
- **Visibility**: public
- **Source Range**: 212605:3171:580
- **Details**: [function_test_Fix45_CancelReRequestFulfillWorks.md](./function_test_Fix45_CancelReRequestFulfillWorks.md)

**Signature:**
```solidity
/// @notice Test that cancel → re-request → fulfill works (no permanent lockout)
function test_Fix45_CancelReRequestFulfillWorks() public;
```

### test_Fix45_CancelPreservesClaimableState()

- **Signature**: `test_Fix45_CancelPreservesClaimableState()`
- **Visibility**: public
- **Source Range**: 215872:2905:580
- **Details**: [function_test_Fix45_CancelPreservesClaimableState.md](./function_test_Fix45_CancelPreservesClaimableState.md)

**Signature:**
```solidity
/// @notice Test that maxWithdraw and averageWithdrawPrice remain unchanged by cancel
function test_Fix45_CancelPreservesClaimableState() public;
```

### test_Fix45_CancelPreservesAccumulators()

- **Signature**: `test_Fix45_CancelPreservesAccumulators()`
- **Visibility**: public
- **Source Range**: 218849:1686:580
- **Details**: [function_test_Fix45_CancelPreservesAccumulators.md](./function_test_Fix45_CancelPreservesAccumulators.md)

**Signature:**
```solidity
/// @notice Test that accumulators remain unchanged by cancel
function test_Fix45_CancelPreservesAccumulators() public;
```

### test_Fix45_MultipleCancelCycles()

- **Signature**: `test_Fix45_MultipleCancelCycles()`
- **Visibility**: public
- **Source Range**: 220605:2747:580
- **Details**: [function_test_Fix45_MultipleCancelCycles.md](./function_test_Fix45_MultipleCancelCycles.md)

**Signature:**
```solidity
/// @notice Test that multiple cancel cycles work correctly
function test_Fix45_MultipleCancelCycles() public;
```

### test_FulfillRedemptionWithPendingCancellation()

- **Signature**: `test_FulfillRedemptionWithPendingCancellation()`
- **Visibility**: public
- **Source Range**: 223528:2428:580
- **Details**: [function_test_FulfillRedemptionWithPendingCancellation.md](./function_test_FulfillRedemptionWithPendingCancellation.md)

**Signature:**
```solidity
/// @notice Test fulfilling a redemption with a pending cancellation (attempted griefing)
///  @dev The redemption should succeed despite the pending cancellation
function test_FulfillRedemptionWithPendingCancellation() public;
```

### test_CompleteCancellationFlow()

- **Signature**: `test_CompleteCancellationFlow()`
- **Visibility**: public
- **Source Range**: 226133:4602:580
- **Details**: [function_test_CompleteCancellationFlow.md](./function_test_CompleteCancellationFlow.md)

**Signature:**
```solidity
/// @notice Test complete cancellation flow: request → cancel → fulfill cancel → claim cancel
///  @dev Tests the full lifecycle of a redemption cancellation
function test_CompleteCancellationFlow() public;
```

### test_RedeemFulfilledBeforeCancellation()

- **Signature**: `test_RedeemFulfilledBeforeCancellation()`
- **Visibility**: public
- **Source Range**: 230933:3914:580
- **Details**: [function_test_RedeemFulfilledBeforeCancellation.md](./function_test_RedeemFulfilledBeforeCancellation.md)

**Signature:**
```solidity
/// @notice Test race condition: redeem fulfilled before cancellation can be processed
///  @dev When redemption is fulfilled first, cancellation fulfillment should fail/be ineffective
function test_RedeemFulfilledBeforeCancellation() public;
```

### test_7540Underlying_Fulfill_From_Liquidity()

- **Signature**: `test_7540Underlying_Fulfill_From_Liquidity()`
- **Visibility**: public
- **Source Range**: 235897:3104:580
- **Details**: [function_test_7540Underlying_Fulfill_From_Liquidity.md](./function_test_7540Underlying_Fulfill_From_Liquidity.md)

**Signature:**
```solidity
function test_7540Underlying_Fulfill_From_Liquidity() public;
```

### test_MultipleUsers_Redeem_Half_From_Liquidity()

- **Signature**: `test_MultipleUsers_Redeem_Half_From_Liquidity()`
- **Visibility**: public
- **Source Range**: 239007:2389:580
- **Details**: [function_test_MultipleUsers_Redeem_Half_From_Liquidity.md](./function_test_MultipleUsers_Redeem_Half_From_Liquidity.md)

**Signature:**
```solidity
function test_MultipleUsers_Redeem_Half_From_Liquidity() public;
```

### test_MultipleUsers_Redeem_From_Liquidity()

- **Signature**: `test_MultipleUsers_Redeem_From_Liquidity()`
- **Visibility**: public
- **Source Range**: 241402:2278:580
- **Details**: [function_test_MultipleUsers_Redeem_From_Liquidity.md](./function_test_MultipleUsers_Redeem_From_Liquidity.md)

**Signature:**
```solidity
function test_MultipleUsers_Redeem_From_Liquidity() public;
```

### test_MultipleUsers_Redeem_From_Liquidity_WithAllocation()

- **Signature**: `test_MultipleUsers_Redeem_From_Liquidity_WithAllocation()`
- **Visibility**: public
- **Source Range**: 243686:4025:580
- **Details**: [function_test_MultipleUsers_Redeem_From_Liquidity_WithAllocation.md](./function_test_MultipleUsers_Redeem_From_Liquidity_WithAllocation.md)

**Signature:**
```solidity
function test_MultipleUsers_Redeem_From_Liquidity_WithAllocation() public;
```

### test_1_DynamicAllocation()

- **Signature**: `test_1_DynamicAllocation()`
- **Visibility**: public
- **Source Range**: 254802:5488:580
- **Details**: [function_test_1_DynamicAllocation.md](./function_test_1_DynamicAllocation.md)

**Signature:**
```solidity
function test_1_DynamicAllocation() public;
```

### test_2_MultipleOperations_RandomAmounts(uint256)

- **Signature**: `test_2_MultipleOperations_RandomAmounts(uint256)`
- **Visibility**: public
- **Source Range**: 269140:4385:580
- **Details**: [function_test_2_MultipleOperations_RandomAmounts_uint256.md](./function_test_2_MultipleOperations_RandomAmounts_uint256.md)

**Signature:**
```solidity
function test_2_MultipleOperations_RandomAmounts(uint256 seed) public;
```

### test_3_UnderlyingVaults_StressTest()

- **Signature**: `test_3_UnderlyingVaults_StressTest()`
- **Visibility**: public
- **Source Range**: 273531:6824:580
- **Details**: [function_test_3_UnderlyingVaults_StressTest.md](./function_test_3_UnderlyingVaults_StressTest.md)

**Signature:**
```solidity
function test_3_UnderlyingVaults_StressTest() public;
```

### test_4_Rebalance_Test()

- **Signature**: `test_4_Rebalance_Test()`
- **Visibility**: public
- **Source Range**: 280361:5200:580
- **Details**: [function_test_4_Rebalance_Test.md](./function_test_4_Rebalance_Test.md)

**Signature:**
```solidity
function test_4_Rebalance_Test() public;
```

### test_5_EdgeCases_Small_Amounts()

- **Signature**: `test_5_EdgeCases_Small_Amounts()`
- **Visibility**: public
- **Source Range**: 285567:1375:580
- **Details**: [function_test_5_EdgeCases_Small_Amounts.md](./function_test_5_EdgeCases_Small_Amounts.md)

**Signature:**
```solidity
function test_5_EdgeCases_Small_Amounts() public;
```

### test_5_EdgeCases_Large_Amounts()

- **Signature**: `test_5_EdgeCases_Large_Amounts()`
- **Visibility**: public
- **Source Range**: 286948:1344:580
- **Details**: [function_test_5_EdgeCases_Large_Amounts.md](./function_test_5_EdgeCases_Large_Amounts.md)

**Signature:**
```solidity
function test_5_EdgeCases_Large_Amounts() public;
```

### test_6_yieldAccumulation()

- **Signature**: `test_6_yieldAccumulation()`
- **Visibility**: public
- **Source Range**: 288298:9220:580
- **Details**: [function_test_6_yieldAccumulation.md](./function_test_6_yieldAccumulation.md)

**Signature:**
```solidity
function test_6_yieldAccumulation() public;
```

### test_6_yieldAccumulation_WithRebalancing()

- **Signature**: `test_6_yieldAccumulation_WithRebalancing()`
- **Visibility**: public
- **Source Range**: 297524:9167:580
- **Details**: [function_test_6_yieldAccumulation_WithRebalancing.md](./function_test_6_yieldAccumulation_WithRebalancing.md)

**Signature:**
```solidity
function test_6_yieldAccumulation_WithRebalancing() public;
```

### test_9_VaultLifecycle_FullAlocateOverTime_()

- **Signature**: `test_9_VaultLifecycle_FullAlocateOverTime_()`
- **Visibility**: public
- **Source Range**: 306697:10063:580
- **Details**: [function_test_9_VaultLifecycle_FullAlocateOverTime_.md](./function_test_9_VaultLifecycle_FullAlocateOverTime_.md)

**Signature:**
```solidity
function test_9_VaultLifecycle_FullAlocateOverTime_() public;
```

### test_9_VaultLifecycle_AddAndRemoveOverTime()

- **Signature**: `test_9_VaultLifecycle_AddAndRemoveOverTime()`
- **Visibility**: public
- **Source Range**: 316766:10676:580
- **Details**: [function_test_9_VaultLifecycle_AddAndRemoveOverTime.md](./function_test_9_VaultLifecycle_AddAndRemoveOverTime.md)

**Signature:**
```solidity
function test_9_VaultLifecycle_AddAndRemoveOverTime() public;
```

### test_10_RuggableVault_Deposit()

- **Signature**: `test_10_RuggableVault_Deposit()`
- **Visibility**: public
- **Source Range**: 329799:3432:580
- **Details**: [function_test_10_RuggableVault_Deposit.md](./function_test_10_RuggableVault_Deposit.md)

**Signature:**
```solidity
function test_10_RuggableVault_Deposit() public;
```

### test_10_RuggableVault_WithdrawX()

- **Signature**: `test_10_RuggableVault_WithdrawX()`
- **Visibility**: public
- **Source Range**: 333237:1842:580
- **Details**: [function_test_10_RuggableVault_WithdrawX.md](./function_test_10_RuggableVault_WithdrawX.md)

**Signature:**
```solidity
function test_10_RuggableVault_WithdrawX() public;
```

### test_10_RuggableVault_Withdraw_ConvertDistortion()

- **Signature**: `test_10_RuggableVault_Withdraw_ConvertDistortion()`
- **Visibility**: public
- **Source Range**: 335085:1986:580
- **Details**: [function_test_10_RuggableVault_Withdraw_ConvertDistortion.md](./function_test_10_RuggableVault_Withdraw_ConvertDistortion.md)

**Signature:**
```solidity
function test_10_RuggableVault_Withdraw_ConvertDistortion() public;
```

### test_11_Allocate_NewYieldSource()

- **Signature**: `test_11_Allocate_NewYieldSource()`
- **Visibility**: public
- **Source Range**: 337077:9654:580
- **Details**: [function_test_11_Allocate_NewYieldSource.md](./function_test_11_Allocate_NewYieldSource.md)

**Signature:**
```solidity
function test_11_Allocate_NewYieldSource() public;
```

### test_12_multiMillionDeposits()

- **Signature**: `test_12_multiMillionDeposits()`
- **Visibility**: public
- **Source Range**: 346737:6874:580
- **Details**: [function_test_12_multiMillionDeposits.md](./function_test_12_multiMillionDeposits.md)

**Signature:**
```solidity
function test_12_multiMillionDeposits() public;
```

### test_MaxDeposit_WhenPaused()

- **Signature**: `test_MaxDeposit_WhenPaused()`
- **Visibility**: public
- **Source Range**: 377782:2069:580
- **Details**: [function_test_MaxDeposit_WhenPaused.md](./function_test_MaxDeposit_WhenPaused.md)

**Signature:**
```solidity
/// @notice Test that maxDeposit returns 0 when vault is paused
function test_MaxDeposit_WhenPaused() public;
```

### test_MaxMint_WhenPaused()

- **Signature**: `test_MaxMint_WhenPaused()`
- **Visibility**: public
- **Source Range**: 379922:2041:580
- **Details**: [function_test_MaxMint_WhenPaused.md](./function_test_MaxMint_WhenPaused.md)

**Signature:**
```solidity
/// @notice Test that maxMint returns 0 when vault is paused
function test_MaxMint_WhenPaused() public;
```

### test_PauseUnpause_WithStalePPS_ComprehensiveCoverage()

- **Signature**: `test_PauseUnpause_WithStalePPS_ComprehensiveCoverage()`
- **Visibility**: public
- **Source Range**: 382058:8881:580
- **Details**: [function_test_PauseUnpause_WithStalePPS_ComprehensiveCoverage.md](./function_test_PauseUnpause_WithStalePPS_ComprehensiveCoverage.md)

**Signature:**
```solidity
/// @notice Comprehensive test for pause/unpause functionality with stale PPS checks
function test_PauseUnpause_WithStalePPS_ComprehensiveCoverage() public;
```

### test_PPSExpiration_OperationsRevert()

- **Signature**: `test_PPSExpiration_OperationsRevert()`
- **Visibility**: public
- **Source Range**: 391047:5716:580
- **Details**: [function_test_PPSExpiration_OperationsRevert.md](./function_test_PPSExpiration_OperationsRevert.md)

**Signature:**
```solidity
/// @notice Test PPS expiration - operations should revert with PPS_EXPIRED after validity period
function test_PPSExpiration_OperationsRevert() public;
```

### test_DustBugInClaimRedeem()

- **Signature**: `test_DustBugInClaimRedeem()`
- **Visibility**: public
- **Source Range**: 399334:4313:580
- **Details**: [function_test_DustBugInClaimRedeem.md](./function_test_DustBugInClaimRedeem.md)

**Signature:**
```solidity
/// @notice Test that exposes the dust bug in _handleClaimRedeem function
///  @dev This test creates a scenario where the strategy balance is reduced below what users can claim,
///       but the difference is within the tolerance constant, causing the dust collection logic to trigger
function test_DustBugInClaimRedeem() public;
```

### test_DustBugMaxWithdrawAccounting()

- **Signature**: `test_DustBugMaxWithdrawAccounting()`
- **Visibility**: public
- **Source Range**: 403938:2091:580
- **Details**: [function_test_DustBugMaxWithdrawAccounting.md](./function_test_DustBugMaxWithdrawAccounting.md)

**Signature:**
```solidity
/// @notice Test the specific dust bug in maxWithdraw accounting
///  @dev This test demonstrates the core issue: maxWithdraw is reduced by actualAmountToClaim
///       instead of assetsToClaim, causing accounting inconsistencies
function test_DustBugMaxWithdrawAccounting() public;
```

### test_Deposit_WithMgmtFee_SkimsAndMintsNet()

- **Signature**: `test_Deposit_WithMgmtFee_SkimsAndMintsNet()`
- **Visibility**: public
- **Source Range**: 406302:993:580
- **Details**: [function_test_Deposit_WithMgmtFee_SkimsAndMintsNet.md](./function_test_Deposit_WithMgmtFee_SkimsAndMintsNet.md)

**Signature:**
```solidity
/// @notice Test that deposit skims entry fee to recipient and mints net shares
function test_Deposit_WithMgmtFee_SkimsAndMintsNet() public;
```

### test_PreviewDeposit_WithMgmtFee_FeeCeil()

- **Signature**: `test_PreviewDeposit_WithMgmtFee_FeeCeil()`
- **Visibility**: public
- **Source Range**: 407385:453:580
- **Details**: [function_test_PreviewDeposit_WithMgmtFee_FeeCeil.md](./function_test_PreviewDeposit_WithMgmtFee_FeeCeil.md)

**Signature:**
```solidity
/// @notice Test that previewDeposit reflects entry fee precisely (ceil on fee)
function test_PreviewDeposit_WithMgmtFee_FeeCeil() public;
```

### test_ChangeFeeRecipient_RevertCases()

- **Signature**: `test_ChangeFeeRecipient_RevertCases()`
- **Visibility**: public
- **Source Range**: 408027:177:580
- **Details**: [function_test_ChangeFeeRecipient_RevertCases.md](./function_test_ChangeFeeRecipient_RevertCases.md)

**Signature:**
```solidity
function test_ChangeFeeRecipient_RevertCases() public;
```

### test_ChangeFeeRecipient_Success()

- **Signature**: `test_ChangeFeeRecipient_Success()`
- **Visibility**: public
- **Source Range**: 408210:303:580
- **Details**: [function_test_ChangeFeeRecipient_Success.md](./function_test_ChangeFeeRecipient_Success.md)

**Signature:**
```solidity
function test_ChangeFeeRecipient_Success() public;
```

### test_ResetHighWaterMark_Success_Strategy()

- **Signature**: `test_ResetHighWaterMark_Success_Strategy()`
- **Visibility**: public
- **Source Range**: 408519:667:580
- **Details**: [function_test_ResetHighWaterMark_Success_Strategy.md](./function_test_ResetHighWaterMark_Success_Strategy.md)

**Signature:**
```solidity
function test_ResetHighWaterMark_Success_Strategy() public;
```

### test_ResetHighWaterMark_Success_FromGovernor()

- **Signature**: `test_ResetHighWaterMark_Success_FromGovernor()`
- **Visibility**: public
- **Source Range**: 409192:616:580
- **Details**: [function_test_ResetHighWaterMark_Success_FromGovernor.md](./function_test_ResetHighWaterMark_Success_FromGovernor.md)

**Signature:**
```solidity
function test_ResetHighWaterMark_Success_FromGovernor() public;
```

### test_ResetHighWaterMark_RevertUnauthorized()

- **Signature**: `test_ResetHighWaterMark_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 409814:205:580
- **Details**: [function_test_ResetHighWaterMark_RevertUnauthorized.md](./function_test_ResetHighWaterMark_RevertUnauthorized.md)

**Signature:**
```solidity
function test_ResetHighWaterMark_RevertUnauthorized() public;
```

### test_ExecuteHooks_AcceptsPayable()

- **Signature**: `test_ExecuteHooks_AcceptsPayable()`
- **Visibility**: public
- **Source Range**: 410214:1563:580
- **Details**: [function_test_ExecuteHooks_AcceptsPayable.md](./function_test_ExecuteHooks_AcceptsPayable.md)

**Signature:**
```solidity
function test_ExecuteHooks_AcceptsPayable() public;
```

### test_ReceiveFunction_AcceptsETH()

- **Signature**: `test_ReceiveFunction_AcceptsETH()`
- **Visibility**: public
- **Source Range**: 411783:569:580
- **Details**: [function_test_ReceiveFunction_AcceptsETH.md](./function_test_ReceiveFunction_AcceptsETH.md)

**Signature:**
```solidity
function test_ReceiveFunction_AcceptsETH() public;
```

### test_RevertWhen_ExecuteHooks_WithoutPayable()

- **Signature**: `test_RevertWhen_ExecuteHooks_WithoutPayable()`
- **Visibility**: public
- **Source Range**: 412358:733:580
- **Details**: [function_test_RevertWhen_ExecuteHooks_WithoutPayable.md](./function_test_RevertWhen_ExecuteHooks_WithoutPayable.md)

**Signature:**
```solidity
function test_RevertWhen_ExecuteHooks_WithoutPayable() public;
```

### test_executeHooks_WithNativeETHHook()

- **Signature**: `test_executeHooks_WithNativeETHHook()`
- **Visibility**: public
- **Source Range**: 413097:2420:580
- **Details**: [function_test_executeHooks_WithNativeETHHook.md](./function_test_executeHooks_WithNativeETHHook.md)

**Signature:**
```solidity
function test_executeHooks_WithNativeETHHook() public;
```

### test_7540Underlying_E2E_Flow()

- **Signature**: `test_7540Underlying_E2E_Flow()`
- **Visibility**: public
- **Source Range**: 416122:2289:580
- **Details**: [function_test_7540Underlying_E2E_Flow.md](./function_test_7540Underlying_E2E_Flow.md)

**Signature:**
```solidity
function test_7540Underlying_E2E_Flow() public;
```

### test_EmergencyAssetRecovery_PauseRedeemAndBatchTransfer()

- **Signature**: `test_EmergencyAssetRecovery_PauseRedeemAndBatchTransfer()`
- **Visibility**: public
- **Source Range**: 435964:14047:580
- **Details**: [function_test_EmergencyAssetRecovery_PauseRedeemAndBatchTransfer.md](./function_test_EmergencyAssetRecovery_PauseRedeemAndBatchTransfer.md)

**Signature:**
```solidity
/// @notice Test emergency asset recovery flow through pause, redeem, and batch transfer
///  @dev This test covers:
///  1. Pause the vault with an extreme PPS outlier
///  2. Redeem from all UYS into free assets
///  3. Record user accounting at this point
///  4. Perform a batch transfer to strip all assets from the vault to escrow address
function test_EmergencyAssetRecovery_PauseRedeemAndBatchTransfer() public;
```

### test_SkimFeeFlow_BasicDepositSkimRedeem()

- **Signature**: `test_SkimFeeFlow_BasicDepositSkimRedeem()`
- **Visibility**: public
- **Source Range**: 453564:4063:580
- **Details**: [function_test_SkimFeeFlow_BasicDepositSkimRedeem.md](./function_test_SkimFeeFlow_BasicDepositSkimRedeem.md)

**Signature:**
```solidity
/// @notice Test 1.1: Basic deposit-skim-redeem flow using proper 2-step redemption
function test_SkimFeeFlow_BasicDepositSkimRedeem() public;
```

### test_SkimFeeFlow_MultiplePPSUpdatesBeforeSkim()

- **Signature**: `test_SkimFeeFlow_MultiplePPSUpdatesBeforeSkim()`
- **Visibility**: public
- **Source Range**: 457699:2802:580
- **Details**: [function_test_SkimFeeFlow_MultiplePPSUpdatesBeforeSkim.md](./function_test_SkimFeeFlow_MultiplePPSUpdatesBeforeSkim.md)

**Signature:**
```solidity
/// @notice Test 2.1: Multiple PPS updates before single skim
function test_SkimFeeFlow_MultiplePPSUpdatesBeforeSkim() public;
```

### test_SkimFeeFlow_SkimAfterEachPPSUpdate()

- **Signature**: `test_SkimFeeFlow_SkimAfterEachPPSUpdate()`
- **Visibility**: public
- **Source Range**: 460560:3201:580
- **Details**: [function_test_SkimFeeFlow_SkimAfterEachPPSUpdate.md](./function_test_SkimFeeFlow_SkimAfterEachPPSUpdate.md)

**Signature:**
```solidity
/// @notice Test 2.2: Skim after each PPS update
function test_SkimFeeFlow_SkimAfterEachPPSUpdate() public;
```

### test_SkimFeeFlow_ZeroProfit_NoFeesCollected()

- **Signature**: `test_SkimFeeFlow_ZeroProfit_NoFeesCollected()`
- **Visibility**: public
- **Source Range**: 463834:747:580
- **Details**: [function_test_SkimFeeFlow_ZeroProfit_NoFeesCollected.md](./function_test_SkimFeeFlow_ZeroProfit_NoFeesCollected.md)

**Signature:**
```solidity
/// @notice Test 3.1: Zero profit scenario - no fees collected
function test_SkimFeeFlow_ZeroProfit_NoFeesCollected() public;
```

### test_SkimFeeFlow_ZeroTotalSupply_HandledCorrectly()

- **Signature**: `test_SkimFeeFlow_ZeroTotalSupply_HandledCorrectly()`
- **Visibility**: public
- **Source Range**: 464641:575:580
- **Details**: [function_test_SkimFeeFlow_ZeroTotalSupply_HandledCorrectly.md](./function_test_SkimFeeFlow_ZeroTotalSupply_HandledCorrectly.md)

**Signature:**
```solidity
/// @notice Test 3.3: Zero total supply edge case
function test_SkimFeeFlow_ZeroTotalSupply_HandledCorrectly() public;
```

### test_SkimFeeFlow_ZeroFeePercent_NoCollection()

- **Signature**: `test_SkimFeeFlow_ZeroFeePercent_NoCollection()`
- **Visibility**: public
- **Source Range**: 465279:2873:580
- **Details**: [function_test_SkimFeeFlow_ZeroFeePercent_NoCollection.md](./function_test_SkimFeeFlow_ZeroFeePercent_NoCollection.md)

**Signature:**
```solidity
/// @notice Test 3.4: Zero fee percent configuration
function test_SkimFeeFlow_ZeroFeePercent_NoCollection() public;
```

### test_SkimFeeFlow_OnlyManagerCanSkim()

- **Signature**: `test_SkimFeeFlow_OnlyManagerCanSkim()`
- **Visibility**: public
- **Source Range**: 468211:276:580
- **Details**: [function_test_SkimFeeFlow_OnlyManagerCanSkim.md](./function_test_SkimFeeFlow_OnlyManagerCanSkim.md)

**Signature:**
```solidity
/// @notice Test 4.1: Only manager can skim fees
function test_SkimFeeFlow_OnlyManagerCanSkim() public;
```

### test_SkimFeeFlow_ManagerCanSkimAnytime()

- **Signature**: `test_SkimFeeFlow_ManagerCanSkimAnytime()`
- **Visibility**: public
- **Source Range**: 468551:1188:580
- **Details**: [function_test_SkimFeeFlow_ManagerCanSkimAnytime.md](./function_test_SkimFeeFlow_ManagerCanSkimAnytime.md)

**Signature:**
```solidity
/// @notice Test 4.2: Manager can skim multiple times
function test_SkimFeeFlow_ManagerCanSkimAnytime() public;
```

### test_SkimFeeFlow_RedemptionPreviewsNoFees()

- **Signature**: `test_SkimFeeFlow_RedemptionPreviewsNoFees()`
- **Visibility**: public
- **Source Range**: 469804:1452:580
- **Details**: [function_test_SkimFeeFlow_RedemptionPreviewsNoFees.md](./function_test_SkimFeeFlow_RedemptionPreviewsNoFees.md)

**Signature:**
```solidity
/// @notice Test 6.1: Redemption previews show no fees
function test_SkimFeeFlow_RedemptionPreviewsNoFees() public;
```

### test_SkimFeeFlow_FulfillmentGivesFullAssets()

- **Signature**: `test_SkimFeeFlow_FulfillmentGivesFullAssets()`
- **Visibility**: public
- **Source Range**: 471344:1691:580
- **Details**: [function_test_SkimFeeFlow_FulfillmentGivesFullAssets.md](./function_test_SkimFeeFlow_FulfillmentGivesFullAssets.md)

**Signature:**
```solidity
/// @notice Test 6.2: Fulfillment gives full assets despite unrealized profit
function test_SkimFeeFlow_FulfillmentGivesFullAssets() public;
```

### test_SkimFeeFlow_HWMResetAfterSkim()

- **Signature**: `test_SkimFeeFlow_HWMResetAfterSkim()`
- **Visibility**: public
- **Source Range**: 473099:4768:580
- **Details**: [function_test_SkimFeeFlow_HWMResetAfterSkim.md](./function_test_SkimFeeFlow_HWMResetAfterSkim.md)

**Signature:**
```solidity
/// @notice Test 7.1: HWM resets correctly after skim
function test_SkimFeeFlow_HWMResetAfterSkim() public;
```

### test_SkimFeeFlow_GasEfficiency()

- **Signature**: `test_SkimFeeFlow_GasEfficiency()`
- **Visibility**: public
- **Source Range**: 477926:6105:580
- **Details**: [function_test_SkimFeeFlow_GasEfficiency.md](./function_test_SkimFeeFlow_GasEfficiency.md)

**Signature:**
```solidity
/// @notice Test gas efficiency of new fee model
function test_SkimFeeFlow_GasEfficiency() public;
```

### test_SkimFeeFlow_EventEmission()

- **Signature**: `test_SkimFeeFlow_EventEmission()`
- **Visibility**: public
- **Source Range**: 484137:2147:580
- **Details**: [function_test_SkimFeeFlow_EventEmission.md](./function_test_SkimFeeFlow_EventEmission.md)

**Signature:**
```solidity
/// @notice Test 9.1: Event emission during fee skim (simplified - focus on skim functionality)
function test_SkimFeeFlow_EventEmission() public;
```

### test_SkimFeeFlow_PPSUpdatedAutomatically()

- **Signature**: `test_SkimFeeFlow_PPSUpdatedAutomatically()`
- **Visibility**: public
- **Source Range**: 486667:2605:580
- **Details**: [function_test_SkimFeeFlow_PPSUpdatedAutomatically.md](./function_test_SkimFeeFlow_PPSUpdatedAutomatically.md)

**Signature:**
```solidity
/// @notice Test that PPS is automatically updated after skimming
function test_SkimFeeFlow_PPSUpdatedAutomatically() public;
```

### test_SkimFeeFlow_PPSUpdateEventEmitted()

- **Signature**: `test_SkimFeeFlow_PPSUpdateEventEmitted()`
- **Visibility**: public
- **Source Range**: 489341:1494:580
- **Details**: [function_test_SkimFeeFlow_PPSUpdateEventEmitted.md](./function_test_SkimFeeFlow_PPSUpdateEventEmitted.md)

**Signature:**
```solidity
/// @notice Test that PPSUpdatedAfterSkim event is emitted
function test_SkimFeeFlow_PPSUpdateEventEmitted() public;
```

### test_SkimFeeFlow_ZeroFee_NoPPSUpdate()

- **Signature**: `test_SkimFeeFlow_ZeroFee_NoPPSUpdate()`
- **Visibility**: public
- **Source Range**: 490900:771:580
- **Details**: [function_test_SkimFeeFlow_ZeroFee_NoPPSUpdate.md](./function_test_SkimFeeFlow_ZeroFee_NoPPSUpdate.md)

**Signature:**
```solidity
/// @notice Test that zero fee skim doesn't update PPS
function test_SkimFeeFlow_ZeroFee_NoPPSUpdate() public;
```

### test_SkimFeeFlow_OnlyStrategyCanUpdatePPS()

- **Signature**: `test_SkimFeeFlow_OnlyStrategyCanUpdatePPS()`
- **Visibility**: public
- **Source Range**: 491768:415:580
- **Details**: [function_test_SkimFeeFlow_OnlyStrategyCanUpdatePPS.md](./function_test_SkimFeeFlow_OnlyStrategyCanUpdatePPS.md)

**Signature:**
```solidity
/// @notice Test access control - only registered strategy can call updatePPSAfterSkim
function test_SkimFeeFlow_OnlyStrategyCanUpdatePPS() public;
```

### test_SkimFeeFlow_PPSMustDecrease()

- **Signature**: `test_SkimFeeFlow_PPSMustDecrease()`
- **Visibility**: public
- **Source Range**: 492244:913:580
- **Details**: [function_test_SkimFeeFlow_PPSMustDecrease.md](./function_test_SkimFeeFlow_PPSMustDecrease.md)

**Signature:**
```solidity
/// @notice Test that PPS must decrease after skim
function test_SkimFeeFlow_PPSMustDecrease() public;
```

### test_SkimFeeFlow_PPSDeductionBounded()

- **Signature**: `test_SkimFeeFlow_PPSDeductionBounded()`
- **Visibility**: public
- **Source Range**: 493237:1056:580
- **Details**: [function_test_SkimFeeFlow_PPSDeductionBounded.md](./function_test_SkimFeeFlow_PPSDeductionBounded.md)

**Signature:**
```solidity
/// @notice Test that PPS deduction is bounded by MAX_PERFORMANCE_FEE
function test_SkimFeeFlow_PPSDeductionBounded() public;
```

### test_SkimFeeFlow_EIP4626ConsistencyAfterSkim()

- **Signature**: `test_SkimFeeFlow_EIP4626ConsistencyAfterSkim()`
- **Visibility**: public
- **Source Range**: 494352:2220:580
- **Details**: [function_test_SkimFeeFlow_EIP4626ConsistencyAfterSkim.md](./function_test_SkimFeeFlow_EIP4626ConsistencyAfterSkim.md)

**Signature:**
```solidity
/// @notice Test EIP-4626 consistency after skim
function test_SkimFeeFlow_EIP4626ConsistencyAfterSkim() public;
```

### test_FulfillRedeemRequests_RevertsOnZeroSharesWithNonZeroAssets()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnZeroSharesWithNonZeroAssets()`
- **Visibility**: public
- **Source Range**: 496875:2256:580
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnZeroSharesWithNonZeroAssets.md](./function_test_FulfillRedeemRequests_RevertsOnZeroSharesWithNonZeroAssets.md)

**Signature:**
```solidity
/// @notice Test that fulfillRedeemRequests reverts when trying to fulfill zero-share controllers with non-zero
///  assets @dev This tests the fix for the vulnerability where managers could strand funds by providing non-zero
///  totalAssetsOut for controllers with zero pending shares
function test_FulfillRedeemRequests_RevertsOnZeroSharesWithNonZeroAssets() public;
```

### test_FulfillRedeemRequests_SucceedsWithOnlyValidControllers()

- **Signature**: `test_FulfillRedeemRequests_SucceedsWithOnlyValidControllers()`
- **Visibility**: public
- **Source Range**: 499346:1714:580
- **Details**: [function_test_FulfillRedeemRequests_SucceedsWithOnlyValidControllers.md](./function_test_FulfillRedeemRequests_SucceedsWithOnlyValidControllers.md)

**Signature:**
```solidity
/// @notice Test that fulfillRedeemRequests succeeds when only fulfilling controllers with pending shares
///  @dev This ensures the fix allows normal operation when only valid controllers are included
function test_FulfillRedeemRequests_SucceedsWithOnlyValidControllers() public;
```

### test_SetOperator7540Hook_ExecuteViaStrategy()

- **Signature**: `test_SetOperator7540Hook_ExecuteViaStrategy()`
- **Visibility**: public
- **Source Range**: 501621:2180:580
- **Details**: [function_test_SetOperator7540Hook_ExecuteViaStrategy.md](./function_test_SetOperator7540Hook_ExecuteViaStrategy.md)

**Signature:**
```solidity
/// @notice Test SetOperator7540Hook execution via strategy.executeHooks
///  @dev This test demonstrates setting an operator on the SuperVault via the SetOperator7540Hook
function test_SetOperator7540Hook_ExecuteViaStrategy() public;
```

### test_SetOperator7540Hook_RevokeOperator()

- **Signature**: `test_SetOperator7540Hook_RevokeOperator()`
- **Visibility**: public
- **Source Range**: 503951:2193:580
- **Details**: [function_test_SetOperator7540Hook_RevokeOperator.md](./function_test_SetOperator7540Hook_RevokeOperator.md)

**Signature:**
```solidity
/// @notice Test SetOperator7540Hook to revoke an operator
///  @dev This test demonstrates revoking an operator that was previously set
function test_SetOperator7540Hook_RevokeOperator() public;
```

### test_SetOperator7540Hook_MultipleOperators()

- **Signature**: `test_SetOperator7540Hook_MultipleOperators()`
- **Visibility**: public
- **Source Range**: 506227:2034:580
- **Details**: [function_test_SetOperator7540Hook_MultipleOperators.md](./function_test_SetOperator7540Hook_MultipleOperators.md)

**Signature:**
```solidity
/// @notice Test SetOperator7540Hook with multiple operators in sequence
function test_SetOperator7540Hook_MultipleOperators() public;
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
