# Contract: SuperVaultAggregatorTest

## Metadata

- **Name**: SuperVaultAggregatorTest
- **Type**: Contract
- **Path**: test/unit/SuperVaultAggregator.t.sol

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

### superGovernor

```solidity
SuperGovernor internal superGovernor
```

**SuperGovernor**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

### superVaultAggregator

```solidity
SuperVaultAggregator internal superVaultAggregator
```

**SuperVaultAggregator**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

### ecdsaPPSOracle

```solidity
ECDSAPPSOracle internal ecdsaPPSOracle
```

**ECDSAPPSOracle**: [src/oracles/ECDSAPPSOracle.sol/contract_ECDSAPPSOracle.md]

### sGovernor

```solidity
address internal sGovernor
```

### governor

```solidity
address internal governor
```

### treasury

```solidity
address internal treasury
```

### oracleManager

```solidity
address internal oracleManager
```

### user

```solidity
address internal user
```

### manager

```solidity
address internal manager
```

### secondaryManager

```solidity
address internal secondaryManager
```

### protectedKeeper1

```solidity
address internal protectedKeeper1
```

### protectedKeeper2

```solidity
address internal protectedKeeper2
```

### normalKeeper1

```solidity
address internal normalKeeper1
```

### normalKeeper2

```solidity
address internal normalKeeper2
```

### strategy

```solidity
address internal strategy
```

### upToken

```solidity
address internal upToken
```

### superBank

```solidity
address internal superBank
```

### superOracle

```solidity
address internal superOracle
```

### gasOracle

```solidity
address internal gasOracle
```

### SUPER_GOVERNOR_ROLE

```solidity
bytes32 internal constant SUPER_GOVERNOR_ROLE = keccak256("SUPER_GOVERNOR_ROLE")
```

### GOVERNOR_ROLE

```solidity
bytes32 internal constant GOVERNOR_ROLE = keccak256("GOVERNOR_ROLE")
```

### asset

```solidity
MockERC20 internal asset
```

**MockERC20**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

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

### MinUpdateIntervalChangeProposed

```solidity
/// @notice Event declaration for MinUpdateIntervalChangeProposed
event MinUpdateIntervalChangeProposed(address indexed strategy, address indexed proposer, uint256 newMinUpdateInterval, uint256 effectiveTime);
```

### MinUpdateIntervalChanged

```solidity
/// @notice Event declaration for MinUpdateIntervalChanged
event MinUpdateIntervalChanged(address indexed strategy, uint256 oldMinUpdateInterval, uint256 newMinUpdateInterval);
```

### MinUpdateIntervalChangeCancelled

```solidity
/// @notice Event declaration for MinUpdateIntervalChangeCancelled
event MinUpdateIntervalChangeCancelled(address indexed strategy, uint256 cancelledInterval);
```

### MinUpdateIntervalChangeRejected

```solidity
/// @notice Event declaration for MinUpdateIntervalChangeRejected
event MinUpdateIntervalChangeRejected(address indexed strategy, uint256 proposedInterval, uint256 currentMaxStaleness);
```

### UpdateTooFrequent

```solidity
/// @notice Event declaration for UpdateTooFrequent
event UpdateTooFrequent();
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

## Public/External Functions

### setUp()

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2531:4322:661
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
/// @notice Sets up the test environment before each test case.
function setUp() public;
```

### test_Constructor_RevertZeroAddressSuperGovernor()

- **Signature**: `test_Constructor_RevertZeroAddressSuperGovernor()`
- **Visibility**: public
- **Source Range**: 7105:1244:661
- **Details**: [function_test_Constructor_RevertZeroAddressSuperGovernor.md](./function_test_Constructor_RevertZeroAddressSuperGovernor.md)

**Signature:**
```solidity
/// @notice Tests that constructor reverts when superGovernor is zero address
function test_Constructor_RevertZeroAddressSuperGovernor() public;
```

### test_Constructor_RevertZeroAddressVaultImpl()

- **Signature**: `test_Constructor_RevertZeroAddressVaultImpl()`
- **Visibility**: public
- **Source Range**: 8433:974:661
- **Details**: [function_test_Constructor_RevertZeroAddressVaultImpl.md](./function_test_Constructor_RevertZeroAddressVaultImpl.md)

**Signature:**
```solidity
/// @notice Tests that constructor reverts when vaultImpl is zero address
function test_Constructor_RevertZeroAddressVaultImpl() public;
```

### test_Constructor_RevertZeroAddressStrategyImpl()

- **Signature**: `test_Constructor_RevertZeroAddressStrategyImpl()`
- **Visibility**: public
- **Source Range**: 9494:947:661
- **Details**: [function_test_Constructor_RevertZeroAddressStrategyImpl.md](./function_test_Constructor_RevertZeroAddressStrategyImpl.md)

**Signature:**
```solidity
/// @notice Tests that constructor reverts when strategyImpl is zero address
function test_Constructor_RevertZeroAddressStrategyImpl() public;
```

### test_Constructor_RevertZeroAddressEscrowImpl()

- **Signature**: `test_Constructor_RevertZeroAddressEscrowImpl()`
- **Visibility**: public
- **Source Range**: 10526:1043:661
- **Details**: [function_test_Constructor_RevertZeroAddressEscrowImpl.md](./function_test_Constructor_RevertZeroAddressEscrowImpl.md)

**Signature:**
```solidity
/// @notice Tests that constructor reverts when escrowImpl is zero address
function test_Constructor_RevertZeroAddressEscrowImpl() public;
```

### test_CreateVault_RevertEmptyName()

- **Signature**: `test_CreateVault_RevertEmptyName()`
- **Visibility**: public
- **Source Range**: 11808:711:661
- **Details**: [function_test_CreateVault_RevertEmptyName.md](./function_test_CreateVault_RevertEmptyName.md)

**Signature:**
```solidity
/// @notice Tests that createVault reverts when name is empty
function test_CreateVault_RevertEmptyName() public;
```

### test_createVault_RevertInvalidAsset()

- **Signature**: `test_createVault_RevertInvalidAsset()`
- **Visibility**: public
- **Source Range**: 12525:716:661
- **Details**: [function_test_createVault_RevertInvalidAsset.md](./function_test_createVault_RevertInvalidAsset.md)

**Signature:**
```solidity
function test_createVault_RevertInvalidAsset() public;
```

### test_CreateVault_RevertEmptySymbol()

- **Signature**: `test_CreateVault_RevertEmptySymbol()`
- **Visibility**: public
- **Source Range**: 13315:719:661
- **Details**: [function_test_CreateVault_RevertEmptySymbol.md](./function_test_CreateVault_RevertEmptySymbol.md)

**Signature:**
```solidity
/// @notice Tests that createVault reverts when symbol is empty
function test_CreateVault_RevertEmptySymbol() public;
```

### test_CreateVault_RevertEmptyNameAndSymbol()

- **Signature**: `test_CreateVault_RevertEmptyNameAndSymbol()`
- **Visibility**: public
- **Source Range**: 14123:716:661
- **Details**: [function_test_CreateVault_RevertEmptyNameAndSymbol.md](./function_test_CreateVault_RevertEmptyNameAndSymbol.md)

**Signature:**
```solidity
/// @notice Tests that createVault reverts when both name and symbol are empty
function test_CreateVault_RevertEmptyNameAndSymbol() public;
```

### test_CreateVault_RevertInvalidAsset()

- **Signature**: `test_CreateVault_RevertInvalidAsset()`
- **Visibility**: public
- **Source Range**: 14934:811:661
- **Details**: [function_test_CreateVault_RevertInvalidAsset.md](./function_test_CreateVault_RevertInvalidAsset.md)

**Signature:**
```solidity
/// @notice Tests that createVault reverts when asset has no valid decimals function
function test_CreateVault_RevertInvalidAsset() public;
```

### test_CreateVault_RevertMaxStalenessTooLow()

- **Signature**: `test_CreateVault_RevertMaxStalenessTooLow()`
- **Visibility**: public
- **Source Range**: 15852:971:661
- **Details**: [function_test_CreateVault_RevertMaxStalenessTooLow.md](./function_test_CreateVault_RevertMaxStalenessTooLow.md)

**Signature:**
```solidity
/// @notice Tests that createVault reverts when maxStaleness is below minimum required staleness
function test_CreateVault_RevertMaxStalenessTooLow() public;
```

### test_CreateVault_Revert_SecondaryManagerIsPrimaryManager()

- **Signature**: `test_CreateVault_Revert_SecondaryManagerIsPrimaryManager()`
- **Visibility**: public
- **Source Range**: 16930:871:661
- **Details**: [function_test_CreateVault_Revert_SecondaryManagerIsPrimaryManager.md](./function_test_CreateVault_Revert_SecondaryManagerIsPrimaryManager.md)

**Signature:**
```solidity
/// @notice Tests that createVault reverts when secondary manager is already the primary manager
function test_CreateVault_Revert_SecondaryManagerIsPrimaryManager() public;
```

### test_CreateVault_Revert_SecondaryManagerIsZeroAddress()

- **Signature**: `test_CreateVault_Revert_SecondaryManagerIsZeroAddress()`
- **Visibility**: public
- **Source Range**: 17807:848:661
- **Details**: [function_test_CreateVault_Revert_SecondaryManagerIsZeroAddress.md](./function_test_CreateVault_Revert_SecondaryManagerIsZeroAddress.md)

**Signature:**
```solidity
function test_CreateVault_Revert_SecondaryManagerIsZeroAddress() public;
```

### test_CreateVault_Revert_SecondaryManagerAlreadyExists()

- **Signature**: `test_CreateVault_Revert_SecondaryManagerAlreadyExists()`
- **Visibility**: public
- **Source Range**: 18661:913:661
- **Details**: [function_test_CreateVault_Revert_SecondaryManagerAlreadyExists.md](./function_test_CreateVault_Revert_SecondaryManagerAlreadyExists.md)

**Signature:**
```solidity
function test_CreateVault_Revert_SecondaryManagerAlreadyExists() public;
```

### test_CreateVault_RevertInvalidMinUpdateInterval()

- **Signature**: `test_CreateVault_RevertInvalidMinUpdateInterval()`
- **Visibility**: public
- **Source Range**: 19580:967:661
- **Details**: [function_test_CreateVault_RevertInvalidMinUpdateInterval.md](./function_test_CreateVault_RevertInvalidMinUpdateInterval.md)

**Signature:**
```solidity
function test_CreateVault_RevertInvalidMinUpdateInterval() public;
```

### test_CreateVault_RevertTooManySecondaryManagers()

- **Signature**: `test_CreateVault_RevertTooManySecondaryManagers()`
- **Visibility**: public
- **Source Range**: 20646:1065:661
- **Details**: [function_test_CreateVault_RevertTooManySecondaryManagers.md](./function_test_CreateVault_RevertTooManySecondaryManagers.md)

**Signature:**
```solidity
/// @notice Tests that createVault reverts when too many secondary managers are provided
function test_CreateVault_RevertTooManySecondaryManagers() public;
```

### test_UpdatePPSAfterSkim_RevertZeroPPS()

- **Signature**: `test_UpdatePPSAfterSkim_RevertZeroPPS()`
- **Visibility**: public
- **Source Range**: 21965:558:661
- **Details**: [function_test_UpdatePPSAfterSkim_RevertZeroPPS.md](./function_test_UpdatePPSAfterSkim_RevertZeroPPS.md)

**Signature:**
```solidity
/// @notice Tests that updatePPSAfterSkim reverts when newPPS is zero
function test_UpdatePPSAfterSkim_RevertZeroPPS() public;
```

### test_UpdatePPSAfterSkim_RevertZeroFeeAmount()

- **Signature**: `test_UpdatePPSAfterSkim_RevertZeroFeeAmount()`
- **Visibility**: public
- **Source Range**: 22606:782:661
- **Details**: [function_test_UpdatePPSAfterSkim_RevertZeroFeeAmount.md](./function_test_UpdatePPSAfterSkim_RevertZeroFeeAmount.md)

**Signature:**
```solidity
/// @notice Tests that updatePPSAfterSkim reverts when feeAmount is zero
function test_UpdatePPSAfterSkim_RevertZeroFeeAmount() public;
```

### test_UpdatePPSAfterSkim_RevertWhenPaused()

- **Signature**: `test_UpdatePPSAfterSkim_RevertWhenPaused()`
- **Visibility**: public
- **Source Range**: 23472:830:661
- **Details**: [function_test_UpdatePPSAfterSkim_RevertWhenPaused.md](./function_test_UpdatePPSAfterSkim_RevertWhenPaused.md)

**Signature:**
```solidity
/// @notice Tests that updatePPSAfterSkim reverts when strategy is paused
function test_UpdatePPSAfterSkim_RevertWhenPaused() public;
```

### test_UpdatePPSAfterSkim_RevertWhenPPSStale()

- **Signature**: `test_UpdatePPSAfterSkim_RevertWhenPPSStale()`
- **Visibility**: public
- **Source Range**: 24380:1219:661
- **Details**: [function_test_UpdatePPSAfterSkim_RevertWhenPPSStale.md](./function_test_UpdatePPSAfterSkim_RevertWhenPPSStale.md)

**Signature:**
```solidity
/// @notice Tests that updatePPSAfterSkim reverts when PPS is stale
function test_UpdatePPSAfterSkim_RevertWhenPPSStale() public;
```

### test_ClaimUpkeep_RevertUnauthorizedCaller()

- **Signature**: `test_ClaimUpkeep_RevertUnauthorizedCaller()`
- **Visibility**: public
- **Source Range**: 25851:679:661
- **Details**: [function_test_ClaimUpkeep_RevertUnauthorizedCaller.md](./function_test_ClaimUpkeep_RevertUnauthorizedCaller.md)

**Signature:**
```solidity
/// @notice Tests that claimUpkeep reverts when caller is not SUPER_GOVERNOR
function test_ClaimUpkeep_RevertUnauthorizedCaller() public;
```

### test_ClaimUpkeep_RevertInsufficientUpkeep()

- **Signature**: `test_ClaimUpkeep_RevertInsufficientUpkeep()`
- **Visibility**: public
- **Source Range**: 26618:434:661
- **Details**: [function_test_ClaimUpkeep_RevertInsufficientUpkeep.md](./function_test_ClaimUpkeep_RevertInsufficientUpkeep.md)

**Signature:**
```solidity
/// @notice Tests that claimUpkeep reverts when insufficient claimable upkeep
function test_ClaimUpkeep_RevertInsufficientUpkeep() public;
```

### test_ClaimUpkeep_Success()

- **Signature**: `test_ClaimUpkeep_Success()`
- **Visibility**: public
- **Source Range**: 27149:2336:661
- **Details**: [function_test_ClaimUpkeep_Success.md](./function_test_ClaimUpkeep_Success.md)

**Signature:**
```solidity
/// @notice Tests successful upkeep claim with proper state changes and event emission
function test_ClaimUpkeep_Success() public;
```

### test_ExecuteWithdrawUpkeep_RevertZeroAmount()

- **Signature**: `test_ExecuteWithdrawUpkeep_RevertZeroAmount()`
- **Visibility**: public
- **Source Range**: 29752:2326:661
- **Details**: [function_test_ExecuteWithdrawUpkeep_RevertZeroAmount.md](./function_test_ExecuteWithdrawUpkeep_RevertZeroAmount.md)

**Signature:**
```solidity
/// @notice Tests that executeWithdrawUpkeep reverts when withdrawal amount becomes zero
function test_ExecuteWithdrawUpkeep_RevertZeroAmount() public;
```

### test_AddSecondaryManager_RevertZeroAddress()

- **Signature**: `test_AddSecondaryManager_RevertZeroAddress()`
- **Visibility**: public
- **Source Range**: 32339:237:661
- **Details**: [function_test_AddSecondaryManager_RevertZeroAddress.md](./function_test_AddSecondaryManager_RevertZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests that addSecondaryManager reverts when manager address is zero
function test_AddSecondaryManager_RevertZeroAddress() public;
```

### test_AddSecondaryManager_RevertMainManagerAlreadyExists()

- **Signature**: `test_AddSecondaryManager_RevertMainManagerAlreadyExists()`
- **Visibility**: public
- **Source Range**: 32686:487:661
- **Details**: [function_test_AddSecondaryManager_RevertMainManagerAlreadyExists.md](./function_test_AddSecondaryManager_RevertMainManagerAlreadyExists.md)

**Signature:**
```solidity
/// @notice Tests that addSecondaryManager reverts when trying to add the main manager as secondary
function test_AddSecondaryManager_RevertMainManagerAlreadyExists() public;
```

### test_AddSecondaryManager_RevertDuplicateSecondaryManager()

- **Signature**: `test_AddSecondaryManager_RevertDuplicateSecondaryManager()`
- **Visibility**: public
- **Source Range**: 33281:1055:661
- **Details**: [function_test_AddSecondaryManager_RevertDuplicateSecondaryManager.md](./function_test_AddSecondaryManager_RevertDuplicateSecondaryManager.md)

**Signature:**
```solidity
/// @notice Tests that addSecondaryManager reverts when trying to add duplicate secondary manager
function test_AddSecondaryManager_RevertDuplicateSecondaryManager() public;
```

### test_RemoveSecondaryManager_RevertUnauthorized()

- **Signature**: `test_RemoveSecondaryManager_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 34432:1309:661
- **Details**: [function_test_RemoveSecondaryManager_RevertUnauthorized.md](./function_test_RemoveSecondaryManager_RevertUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests that removeSecondaryManager reverts when caller is not main manager
function test_RemoveSecondaryManager_RevertUnauthorized() public;
```

### test_RemoveSecondaryManager_RevertManagerNotFound()

- **Signature**: `test_RemoveSecondaryManager_RevertManagerNotFound()`
- **Visibility**: public
- **Source Range**: 35831:964:661
- **Details**: [function_test_RemoveSecondaryManager_RevertManagerNotFound.md](./function_test_RemoveSecondaryManager_RevertManagerNotFound.md)

**Signature:**
```solidity
/// @notice Tests that removeSecondaryManager reverts when manager is not found
function test_RemoveSecondaryManager_RevertManagerNotFound() public;
```

### test_UpdateDeviationThreshold_RevertUnauthorized()

- **Signature**: `test_UpdateDeviationThreshold_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 36893:939:661
- **Details**: [function_test_UpdateDeviationThreshold_RevertUnauthorized.md](./function_test_UpdateDeviationThreshold_RevertUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests that updateDeviationThreshold reverts when caller is not main manager
function test_UpdateDeviationThreshold_RevertUnauthorized() public;
```

### test_ChangePrimaryManager_RevertZeroAddressStrategy()

- **Signature**: `test_ChangePrimaryManager_RevertZeroAddressStrategy()`
- **Visibility**: public
- **Source Range**: 38141:509:661
- **Details**: [function_test_ChangePrimaryManager_RevertZeroAddressStrategy.md](./function_test_ChangePrimaryManager_RevertZeroAddressStrategy.md)

**Signature:**
```solidity
/// @notice Tests that changePrimaryManager reverts when strategy is zero address (caught by validStrategy modifier)
function test_ChangePrimaryManager_RevertZeroAddressStrategy() public;
```

### test_ChangePrimaryManager_RevertZeroAddressNewManager()

- **Signature**: `test_ChangePrimaryManager_RevertZeroAddressNewManager()`
- **Visibility**: public
- **Source Range**: 38744:347:661
- **Details**: [function_test_ChangePrimaryManager_RevertZeroAddressNewManager.md](./function_test_ChangePrimaryManager_RevertZeroAddressNewManager.md)

**Signature:**
```solidity
/// @notice Tests that changePrimaryManager reverts when newManager is zero address
function test_ChangePrimaryManager_RevertZeroAddressNewManager() public;
```

### test_ChangePrimaryManager_RevertZeroAddressFeeRecipient()

- **Signature**: `test_ChangePrimaryManager_RevertZeroAddressFeeRecipient()`
- **Visibility**: public
- **Source Range**: 39187:343:661
- **Details**: [function_test_ChangePrimaryManager_RevertZeroAddressFeeRecipient.md](./function_test_ChangePrimaryManager_RevertZeroAddressFeeRecipient.md)

**Signature:**
```solidity
/// @notice Tests that changePrimaryManager reverts when feeRecipient is zero address
function test_ChangePrimaryManager_RevertZeroAddressFeeRecipient() public;
```

### test_ProposeChangePrimaryManager_RevertZeroAddress()

- **Signature**: `test_ProposeChangePrimaryManager_RevertZeroAddress()`
- **Visibility**: public
- **Source Range**: 39631:344:661
- **Details**: [function_test_ProposeChangePrimaryManager_RevertZeroAddress.md](./function_test_ProposeChangePrimaryManager_RevertZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests that proposeChangePrimaryManager reverts when newManager is zero address
function test_ProposeChangePrimaryManager_RevertZeroAddress() public;
```

### test_ExecuteChangePrimaryManager_RevertNoPendingChange()

- **Signature**: `test_ExecuteChangePrimaryManager_RevertNoPendingChange()`
- **Visibility**: public
- **Source Range**: 40083:281:661
- **Details**: [function_test_ExecuteChangePrimaryManager_RevertNoPendingChange.md](./function_test_ExecuteChangePrimaryManager_RevertNoPendingChange.md)

**Signature:**
```solidity
/// @notice Tests that executeChangePrimaryManager reverts when there's no pending manager change
function test_ExecuteChangePrimaryManager_RevertNoPendingChange() public;
```

### test_ExecuteChangePrimaryManager_RevertTimelockNotExpired()

- **Signature**: `test_ExecuteChangePrimaryManager_RevertTimelockNotExpired()`
- **Visibility**: public
- **Source Range**: 40462:837:661
- **Details**: [function_test_ExecuteChangePrimaryManager_RevertTimelockNotExpired.md](./function_test_ExecuteChangePrimaryManager_RevertTimelockNotExpired.md)

**Signature:**
```solidity
/// @notice Tests that executeChangePrimaryManager reverts when timelock hasn't expired
function test_ExecuteChangePrimaryManager_RevertTimelockNotExpired() public;
```

### test_ExecuteChangePrimaryManager_Success()

- **Signature**: `test_ExecuteChangePrimaryManager_Success()`
- **Visibility**: public
- **Source Range**: 41624:1037:661
- **Details**: [function_test_ExecuteChangePrimaryManager_Success.md](./function_test_ExecuteChangePrimaryManager_Success.md)

**Signature:**
```solidity
/// @notice Tests that executeChangePrimaryManager succeeds with valid non-zero addresses
///  @dev This test validates the defense-in-depth zero address check in executeChangePrimaryManager
///  @dev The check protects against any future code changes that might bypass proposeChangePrimaryManager validation
function test_ExecuteChangePrimaryManager_Success() public;
```

### test_ResetHighWaterMark_RevertUnauthorized()

- **Signature**: `test_ResetHighWaterMark_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 42928:238:661
- **Details**: [function_test_ResetHighWaterMark_RevertUnauthorized.md](./function_test_ResetHighWaterMark_RevertUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests that resetHighWaterMark reverts when caller is not SuperGovernor
function test_ResetHighWaterMark_RevertUnauthorized() public;
```

### test_ResetHighWaterMark_RevertInvalidStrategy()

- **Signature**: `test_ResetHighWaterMark_RevertInvalidStrategy()`
- **Visibility**: public
- **Source Range**: 43259:328:661
- **Details**: [function_test_ResetHighWaterMark_RevertInvalidStrategy.md](./function_test_ResetHighWaterMark_RevertInvalidStrategy.md)

**Signature:**
```solidity
/// @notice Tests that resetHighWaterMark reverts when strategy is invalid address
function test_ResetHighWaterMark_RevertInvalidStrategy() public;
```

### test_ResetHighWaterMark_Success()

- **Signature**: `test_ResetHighWaterMark_Success()`
- **Visibility**: public
- **Source Range**: 43679:610:661
- **Details**: [function_test_ResetHighWaterMark_Success.md](./function_test_ResetHighWaterMark_Success.md)

**Signature:**
```solidity
/// @notice Tests that resetHighWaterMark succeeds when strategy is valid address
function test_ResetHighWaterMark_Success() public;
```

### test_SetHooksRootUpdateTimelock_RevertUnauthorized()

- **Signature**: `test_SetHooksRootUpdateTimelock_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 44390:837:661
- **Details**: [function_test_SetHooksRootUpdateTimelock_RevertUnauthorized.md](./function_test_SetHooksRootUpdateTimelock_RevertUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests that setHooksRootUpdateTimelock reverts when caller is not SuperGovernor
function test_SetHooksRootUpdateTimelock_RevertUnauthorized() public;
```

### test_ProposeGlobalHooksRoot_RevertUnauthorized()

- **Signature**: `test_ProposeGlobalHooksRoot_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 45324:835:661
- **Details**: [function_test_ProposeGlobalHooksRoot_RevertUnauthorized.md](./function_test_ProposeGlobalHooksRoot_RevertUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests that proposeGlobalHooksRoot reverts when caller is not SuperGovernor
function test_ProposeGlobalHooksRoot_RevertUnauthorized() public;
```

### test_ExecuteGlobalHooksRootUpdate_RevertNoPendingProposal()

- **Signature**: `test_ExecuteGlobalHooksRootUpdate_RevertNoPendingProposal()`
- **Visibility**: public
- **Source Range**: 46262:281:661
- **Details**: [function_test_ExecuteGlobalHooksRootUpdate_RevertNoPendingProposal.md](./function_test_ExecuteGlobalHooksRootUpdate_RevertNoPendingProposal.md)

**Signature:**
```solidity
/// @notice Tests that executeGlobalHooksRootUpdate reverts when there's no pending proposal
function test_ExecuteGlobalHooksRootUpdate_RevertNoPendingProposal() public;
```

### test_ExecuteGlobalHooksRootUpdate_RevertTimelockNotReady()

- **Signature**: `test_ExecuteGlobalHooksRootUpdate_RevertTimelockNotReady()`
- **Visibility**: public
- **Source Range**: 46642:840:661
- **Details**: [function_test_ExecuteGlobalHooksRootUpdate_RevertTimelockNotReady.md](./function_test_ExecuteGlobalHooksRootUpdate_RevertTimelockNotReady.md)

**Signature:**
```solidity
/// @notice Tests that executeGlobalHooksRootUpdate reverts when timelock hasn't expired
function test_ExecuteGlobalHooksRootUpdate_RevertTimelockNotReady() public;
```

### test_SetGlobalHooksRootVetoStatus_RevertUnauthorized()

- **Signature**: `test_SetGlobalHooksRootVetoStatus_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 47585:835:661
- **Details**: [function_test_SetGlobalHooksRootVetoStatus_RevertUnauthorized.md](./function_test_SetGlobalHooksRootVetoStatus_RevertUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests that setGlobalHooksRootVetoStatus reverts when caller is not SuperGovernor
function test_SetGlobalHooksRootVetoStatus_RevertUnauthorized() public;
```

### test_SetGlobalHooksRootVetoStatus_NoChangeSucceeds()

- **Signature**: `test_SetGlobalHooksRootVetoStatus_NoChangeSucceeds()`
- **Visibility**: public
- **Source Range**: 48518:903:661
- **Details**: [function_test_SetGlobalHooksRootVetoStatus_NoChangeSucceeds.md](./function_test_SetGlobalHooksRootVetoStatus_NoChangeSucceeds.md)

**Signature:**
```solidity
/// @notice Tests that setGlobalHooksRootVetoStatus succeeds when status doesn't change
function test_SetGlobalHooksRootVetoStatus_NoChangeSucceeds() public;
```

### test_ProposeStrategyHooksRoot_RevertUnauthorized()

- **Signature**: `test_ProposeStrategyHooksRoot_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 49519:930:661
- **Details**: [function_test_ProposeStrategyHooksRoot_RevertUnauthorized.md](./function_test_ProposeStrategyHooksRoot_RevertUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests that proposeStrategyHooksRoot reverts when caller is not main manager
function test_ProposeStrategyHooksRoot_RevertUnauthorized() public;
```

### test_ExecuteStrategyHooksRootUpdate_RevertNoPendingProposal()

- **Signature**: `test_ExecuteStrategyHooksRootUpdate_RevertNoPendingProposal()`
- **Visibility**: public
- **Source Range**: 50554:289:661
- **Details**: [function_test_ExecuteStrategyHooksRootUpdate_RevertNoPendingProposal.md](./function_test_ExecuteStrategyHooksRootUpdate_RevertNoPendingProposal.md)

**Signature:**
```solidity
/// @notice Tests that executeStrategyHooksRootUpdate reverts when there's no pending proposal
function test_ExecuteStrategyHooksRootUpdate_RevertNoPendingProposal() public;
```

### test_ExecuteStrategyHooksRootUpdate_RevertTimelockNotReady()

- **Signature**: `test_ExecuteStrategyHooksRootUpdate_RevertTimelockNotReady()`
- **Visibility**: public
- **Source Range**: 50944:868:661
- **Details**: [function_test_ExecuteStrategyHooksRootUpdate_RevertTimelockNotReady.md](./function_test_ExecuteStrategyHooksRootUpdate_RevertTimelockNotReady.md)

**Signature:**
```solidity
/// @notice Tests that executeStrategyHooksRootUpdate reverts when timelock hasn't expired
function test_ExecuteStrategyHooksRootUpdate_RevertTimelockNotReady() public;
```

### test_SetStrategyHooksRootVetoStatus_RevertUnauthorized()

- **Signature**: `test_SetStrategyHooksRootVetoStatus_RevertUnauthorized()`
- **Visibility**: public
- **Source Range**: 51917:873:661
- **Details**: [function_test_SetStrategyHooksRootVetoStatus_RevertUnauthorized.md](./function_test_SetStrategyHooksRootVetoStatus_RevertUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests that setStrategyHooksRootVetoStatus reverts when caller is not SuperGovernor
function test_SetStrategyHooksRootVetoStatus_RevertUnauthorized() public;
```

### test_SetStrategyHooksRootVetoStatus_NoChangeSucceeds()

- **Signature**: `test_SetStrategyHooksRootVetoStatus_NoChangeSucceeds()`
- **Visibility**: public
- **Source Range**: 52890:1020:661
- **Details**: [function_test_SetStrategyHooksRootVetoStatus_NoChangeSucceeds.md](./function_test_SetStrategyHooksRootVetoStatus_NoChangeSucceeds.md)

**Signature:**
```solidity
/// @notice Tests that setStrategyHooksRootVetoStatus succeeds when status doesn't change
function test_SetStrategyHooksRootVetoStatus_NoChangeSucceeds() public;
```

### test_ProposeMinUpdateIntervalChange_RevertWhenIntervalTooLarge()

- **Signature**: `test_ProposeMinUpdateIntervalChange_RevertWhenIntervalTooLarge()`
- **Visibility**: public
- **Source Range**: 54015:869:661
- **Details**: [function_test_ProposeMinUpdateIntervalChange_RevertWhenIntervalTooLarge.md](./function_test_ProposeMinUpdateIntervalChange_RevertWhenIntervalTooLarge.md)

**Signature:**
```solidity
/// @notice Tests that proposeMinUpdateIntervalChange reverts when newInterval >= maxStaleness
function test_ProposeMinUpdateIntervalChange_RevertWhenIntervalTooLarge() public;
```

### test_GetCurrentNonce()

- **Signature**: `test_GetCurrentNonce()`
- **Visibility**: public
- **Source Range**: 54974:1127:661
- **Details**: [function_test_GetCurrentNonce.md](./function_test_GetCurrentNonce.md)

**Signature:**
```solidity
/// @notice Tests that getCurrentNonce returns the correct vault creation nonce
function test_GetCurrentNonce() public;
```

### test_GetDeviationThreshold()

- **Signature**: `test_GetDeviationThreshold()`
- **Visibility**: public
- **Source Range**: 56196:726:661
- **Details**: [function_test_GetDeviationThreshold.md](./function_test_GetDeviationThreshold.md)

**Signature:**
```solidity
/// @notice Tests that getDeviationThreshold returns the correct deviation threshold
function test_GetDeviationThreshold() public;
```

### test_IsSecondaryManager()

- **Signature**: `test_IsSecondaryManager()`
- **Visibility**: public
- **Source Range**: 57014:1406:661
- **Details**: [function_test_IsSecondaryManager.md](./function_test_IsSecondaryManager.md)

**Signature:**
```solidity
/// @notice Tests that isSecondaryManager correctly identifies secondary managers
function test_IsSecondaryManager() public;
```

### test_GetAllSuperVaults()

- **Signature**: `test_GetAllSuperVaults()`
- **Visibility**: public
- **Source Range**: 58497:621:661
- **Details**: [function_test_GetAllSuperVaults.md](./function_test_GetAllSuperVaults.md)

**Signature:**
```solidity
/// @notice Tests getAllSuperVaults and superVaults indexed access
function test_GetAllSuperVaults() public;
```

### test_GetAllSuperVaultStrategies()

- **Signature**: `test_GetAllSuperVaultStrategies()`
- **Visibility**: public
- **Source Range**: 59213:770:661
- **Details**: [function_test_GetAllSuperVaultStrategies.md](./function_test_GetAllSuperVaultStrategies.md)

**Signature:**
```solidity
/// @notice Tests getAllSuperVaultStrategies and superVaultStrategies indexed access
function test_GetAllSuperVaultStrategies() public;
```

### test_GetAllSuperVaultEscrows()

- **Signature**: `test_GetAllSuperVaultEscrows()`
- **Visibility**: public
- **Source Range**: 60072:654:661
- **Details**: [function_test_GetAllSuperVaultEscrows.md](./function_test_GetAllSuperVaultEscrows.md)

**Signature:**
```solidity
/// @notice Tests getAllSuperVaultEscrows and superVaultEscrows indexed access
function test_GetAllSuperVaultEscrows() public;
```

### test_GetSuperVaultsCount()

- **Signature**: `test_GetSuperVaultsCount()`
- **Visibility**: public
- **Source Range**: 60800:1246:661
- **Details**: [function_test_GetSuperVaultsCount.md](./function_test_GetSuperVaultsCount.md)

**Signature:**
```solidity
/// @notice Tests getSuperVaultsCount returns the correct count
function test_GetSuperVaultsCount() public;
```

### test_GetSuperVaultStrategiesCount()

- **Signature**: `test_GetSuperVaultStrategiesCount()`
- **Visibility**: public
- **Source Range**: 62129:1357:661
- **Details**: [function_test_GetSuperVaultStrategiesCount.md](./function_test_GetSuperVaultStrategiesCount.md)

**Signature:**
```solidity
/// @notice Tests getSuperVaultStrategiesCount returns the correct count
function test_GetSuperVaultStrategiesCount() public;
```

### test_GetSuperVaultEscrowsCount()

- **Signature**: `test_GetSuperVaultEscrowsCount()`
- **Visibility**: public
- **Source Range**: 63566:1324:661
- **Details**: [function_test_GetSuperVaultEscrowsCount.md](./function_test_GetSuperVaultEscrowsCount.md)

**Signature:**
```solidity
/// @notice Tests getSuperVaultEscrowsCount returns the correct count
function test_GetSuperVaultEscrowsCount() public;
```

### test_ValidateHooks_GlobalRootVetoed()

- **Signature**: `test_ValidateHooks_GlobalRootVetoed()`
- **Visibility**: public
- **Source Range**: 64983:1569:661
- **Details**: [function_test_ValidateHooks_GlobalRootVetoed.md](./function_test_ValidateHooks_GlobalRootVetoed.md)

**Signature:**
```solidity
/// @notice Tests validateHooks returns all false when global hooks root is vetoed
function test_ValidateHooks_GlobalRootVetoed() public;
```

### test_ValidateHooks_StrategyRootVetoed()

- **Signature**: `test_ValidateHooks_StrategyRootVetoed()`
- **Visibility**: public
- **Source Range**: 66647:1267:661
- **Details**: [function_test_ValidateHooks_StrategyRootVetoed.md](./function_test_ValidateHooks_StrategyRootVetoed.md)

**Signature:**
```solidity
/// @notice Tests validateHooks returns all false when strategy hooks root is vetoed
function test_ValidateHooks_StrategyRootVetoed() public;
```

### test_GetGlobalHooksRoot()

- **Signature**: `test_GetGlobalHooksRoot()`
- **Visibility**: public
- **Source Range**: 67999:1118:661
- **Details**: [function_test_GetGlobalHooksRoot.md](./function_test_GetGlobalHooksRoot.md)

**Signature:**
```solidity
/// @notice Tests getGlobalHooksRoot returns the current global hooks root
function test_GetGlobalHooksRoot() public;
```

### test_GetProposedGlobalHooksRoot()

- **Signature**: `test_GetProposedGlobalHooksRoot()`
- **Visibility**: public
- **Source Range**: 69213:867:661
- **Details**: [function_test_GetProposedGlobalHooksRoot.md](./function_test_GetProposedGlobalHooksRoot.md)

**Signature:**
```solidity
/// @notice Tests getProposedGlobalHooksRoot returns proposed root and effective time
function test_GetProposedGlobalHooksRoot() public;
```

### test_IsGlobalHooksRootActive()

- **Signature**: `test_IsGlobalHooksRootActive()`
- **Visibility**: public
- **Source Range**: 70155:1046:661
- **Details**: [function_test_IsGlobalHooksRootActive.md](./function_test_IsGlobalHooksRootActive.md)

**Signature:**
```solidity
/// @notice Tests isGlobalHooksRootActive returns correct status
function test_IsGlobalHooksRootActive() public;
```

### test_GetStrategyHooksRoot()

- **Signature**: `test_GetStrategyHooksRoot()`
- **Visibility**: public
- **Source Range**: 71287:1116:661
- **Details**: [function_test_GetStrategyHooksRoot.md](./function_test_GetStrategyHooksRoot.md)

**Signature:**
```solidity
/// @notice Tests getStrategyHooksRoot returns strategy-specific hooks root
function test_GetStrategyHooksRoot() public;
```

### test_ChangePrimaryManager_ClearsPendingProposals()

- **Signature**: `test_ChangePrimaryManager_ClearsPendingProposals()`
- **Visibility**: public
- **Source Range**: 72486:908:661
- **Details**: [function_test_ChangePrimaryManager_ClearsPendingProposals.md](./function_test_ChangePrimaryManager_ClearsPendingProposals.md)

**Signature:**
```solidity
/// @notice Tests emergency manager replacement clears pending proposals
function test_ChangePrimaryManager_ClearsPendingProposals() public;
```

### test_ChangePrimaryManager_ClearsSecondaryManagers()

- **Signature**: `test_ChangePrimaryManager_ClearsSecondaryManagers()`
- **Visibility**: public
- **Source Range**: 73474:1777:661
- **Details**: [function_test_ChangePrimaryManager_ClearsSecondaryManagers.md](./function_test_ChangePrimaryManager_ClearsSecondaryManagers.md)

**Signature:**
```solidity
/// @notice Tests emergency replacement clears all secondary managers
function test_ChangePrimaryManager_ClearsSecondaryManagers() public;
```

### test_ChangePrimaryManager_UpdatesFeeRecipient()

- **Signature**: `test_ChangePrimaryManager_UpdatesFeeRecipient()`
- **Visibility**: public
- **Source Range**: 75257:707:661
- **Details**: [function_test_ChangePrimaryManager_UpdatesFeeRecipient.md](./function_test_ChangePrimaryManager_UpdatesFeeRecipient.md)

**Signature:**
```solidity
function test_ChangePrimaryManager_UpdatesFeeRecipient() public;
```

### test_ExecuteChangePriamryManager_UpdatesFeeRecipient()

- **Signature**: `test_ExecuteChangePriamryManager_UpdatesFeeRecipient()`
- **Visibility**: public
- **Source Range**: 75970:615:661
- **Details**: [function_test_ExecuteChangePriamryManager_UpdatesFeeRecipient.md](./function_test_ExecuteChangePriamryManager_UpdatesFeeRecipient.md)

**Signature:**
```solidity
function test_ExecuteChangePriamryManager_UpdatesFeeRecipient() public;
```

### test_AddTooManySecondaryManagers()

- **Signature**: `test_AddTooManySecondaryManagers()`
- **Visibility**: public
- **Source Range**: 76665:733:661
- **Details**: [function_test_AddTooManySecondaryManagers.md](./function_test_AddTooManySecondaryManagers.md)

**Signature:**
```solidity
/// @notice Tests emergency replacement clears all secondary managers
function test_AddTooManySecondaryManagers() public;
```

### test_AddSecondaryManager()

- **Signature**: `test_AddSecondaryManager()`
- **Visibility**: public
- **Source Range**: 77404:1075:661
- **Details**: [function_test_AddSecondaryManager.md](./function_test_AddSecondaryManager.md)

**Signature:**
```solidity
function test_AddSecondaryManager() public;
```

### test_ChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager()

- **Signature**: `test_ChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager()`
- **Visibility**: public
- **Source Range**: 78590:305:661
- **Details**: [function_test_ChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager.md](./function_test_ChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager.md)

**Signature:**
```solidity
/// @notice Tests changePrimaryManager reverts if new primary manager is already the primary manager
function test_ChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager() public;
```

### test_ChangePrimaryManager_ClearsPendingHookProposals()

- **Signature**: `test_ChangePrimaryManager_ClearsPendingHookProposals()`
- **Visibility**: public
- **Source Range**: 78980:1242:661
- **Details**: [function_test_ChangePrimaryManager_ClearsPendingHookProposals.md](./function_test_ChangePrimaryManager_ClearsPendingHookProposals.md)

**Signature:**
```solidity
/// @notice Tests emergency replacement clears pending hook root proposals
function test_ChangePrimaryManager_ClearsPendingHookProposals() public;
```

### test_ProposeChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager()

- **Signature**: `test_ProposeChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager()`
- **Visibility**: public
- **Source Range**: 80345:416:661
- **Details**: [function_test_ProposeChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager.md](./function_test_ProposeChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager.md)

**Signature:**
```solidity
/// @notice Tests that proposeChangePrimaryManager reverts if new primary manager is already the primary manager
function test_ProposeChangePrimaryManager_RevertIfNewPrimaryManagerIsAlreadyThePrimaryManager() public;
```

### test_ExecuteChangePrimaryManager()

- **Signature**: `test_ExecuteChangePrimaryManager()`
- **Visibility**: public
- **Source Range**: 80897:2967:661
- **Details**: [function_test_ExecuteChangePrimaryManager.md](./function_test_ExecuteChangePrimaryManager.md)

**Signature:**
```solidity
/// @notice Tests that executeChangePrimaryManager removes old primary manager and sets new primary manager and fee recipient
function test_ExecuteChangePrimaryManager() public;
```

### test_ExecuteChangePrimaryManager_ClearsPendingHooksRootProposal()

- **Signature**: `test_ExecuteChangePrimaryManager_ClearsPendingHooksRootProposal()`
- **Visibility**: public
- **Source Range**: 84046:1413:661
- **Details**: [function_test_ExecuteChangePrimaryManager_ClearsPendingHooksRootProposal.md](./function_test_ExecuteChangePrimaryManager_ClearsPendingHooksRootProposal.md)

**Signature:**
```solidity
/// @notice Tests that executeChangePrimaryManager clears pending hooks root proposal
///  @dev This prevents stale proposals from being executed after manager handover
function test_ExecuteChangePrimaryManager_ClearsPendingHooksRootProposal() public;
```

### test_ExecuteChangePrimaryManager_ClearsPendingMinUpdateIntervalProposal()

- **Signature**: `test_ExecuteChangePrimaryManager_ClearsPendingMinUpdateIntervalProposal()`
- **Visibility**: public
- **Source Range**: 85648:1524:661
- **Details**: [function_test_ExecuteChangePrimaryManager_ClearsPendingMinUpdateIntervalProposal.md](./function_test_ExecuteChangePrimaryManager_ClearsPendingMinUpdateIntervalProposal.md)

**Signature:**
```solidity
/// @notice Tests that executeChangePrimaryManager clears pending minUpdateInterval proposal
///  @dev This prevents stale proposals from being executed after manager handover
function test_ExecuteChangePrimaryManager_ClearsPendingMinUpdateIntervalProposal() public;
```

### test_ExecuteChangePrimaryManager_ClearsBothPendingProposals()

- **Signature**: `test_ExecuteChangePrimaryManager_ClearsBothPendingProposals()`
- **Visibility**: public
- **Source Range**: 87382:2186:661
- **Details**: [function_test_ExecuteChangePrimaryManager_ClearsBothPendingProposals.md](./function_test_ExecuteChangePrimaryManager_ClearsBothPendingProposals.md)

**Signature:**
```solidity
/// @notice Tests that executeChangePrimaryManager clears both pending proposals atomically
///  @dev This prevents stale proposals from being front-run in the same transaction as manager handover
function test_ExecuteChangePrimaryManager_ClearsBothPendingProposals() public;
```

### test_CancelChangePrimaryManager_Success()

- **Signature**: `test_CancelChangePrimaryManager_Success()`
- **Visibility**: public
- **Source Range**: 89840:984:661
- **Details**: [function_test_CancelChangePrimaryManager_Success.md](./function_test_CancelChangePrimaryManager_Success.md)

**Signature:**
```solidity
/// @notice Tests that mainManager can cancel a pending manager change proposal
function test_CancelChangePrimaryManager_Success() public;
```

### test_CancelChangePrimaryManager_OnlyMainManager()

- **Signature**: `test_CancelChangePrimaryManager_OnlyMainManager()`
- **Visibility**: public
- **Source Range**: 90897:999:661
- **Details**: [function_test_CancelChangePrimaryManager_OnlyMainManager.md](./function_test_CancelChangePrimaryManager_OnlyMainManager.md)

**Signature:**
```solidity
/// @notice Tests that only the current mainManager can cancel
function test_CancelChangePrimaryManager_OnlyMainManager() public;
```

### test_CancelChangePrimaryManager_RequiresPendingProposal()

- **Signature**: `test_CancelChangePrimaryManager_RequiresPendingProposal()`
- **Visibility**: public
- **Source Range**: 91967:965:661
- **Details**: [function_test_CancelChangePrimaryManager_RequiresPendingProposal.md](./function_test_CancelChangePrimaryManager_RequiresPendingProposal.md)

**Signature:**
```solidity
/// @notice Tests that canceling requires a pending proposal
function test_CancelChangePrimaryManager_RequiresPendingProposal() public;
```

### test_CancelChangePrimaryManager_SocialEngineeringProtection()

- **Signature**: `test_CancelChangePrimaryManager_SocialEngineeringProtection()`
- **Visibility**: public
- **Source Range**: 92999:1769:661
- **Details**: [function_test_CancelChangePrimaryManager_SocialEngineeringProtection.md](./function_test_CancelChangePrimaryManager_SocialEngineeringProtection.md)

**Signature:**
```solidity
/// @notice Tests social engineering protection scenario
function test_CancelChangePrimaryManager_SocialEngineeringProtection() public;
```

### test_CancelChangePrimaryManager_CanRepropose()

- **Signature**: `test_CancelChangePrimaryManager_CanRepropose()`
- **Visibility**: public
- **Source Range**: 94839:814:661
- **Details**: [function_test_CancelChangePrimaryManager_CanRepropose.md](./function_test_CancelChangePrimaryManager_CanRepropose.md)

**Signature:**
```solidity
/// @notice Tests that cancelled proposal can be re-proposed
function test_CancelChangePrimaryManager_CanRepropose() public;
```

### test_ChangePrimaryManager_PreventsAttackScenario()

- **Signature**: `test_ChangePrimaryManager_PreventsAttackScenario()`
- **Visibility**: public
- **Source Range**: 95752:2316:661
- **Details**: [function_test_ChangePrimaryManager_PreventsAttackScenario.md](./function_test_ChangePrimaryManager_PreventsAttackScenario.md)

**Signature:**
```solidity
/// @notice Tests the complete attack scenario - malicious manager cannot regain control
function test_ChangePrimaryManager_PreventsAttackScenario() public;
```

### test_ProposeChangePrimaryManager_RevertZeroAddressFeeRecipient()

- **Signature**: `test_ProposeChangePrimaryManager_RevertZeroAddressFeeRecipient()`
- **Visibility**: public
- **Source Range**: 98074:283:661
- **Details**: [function_test_ProposeChangePrimaryManager_RevertZeroAddressFeeRecipient.md](./function_test_ProposeChangePrimaryManager_RevertZeroAddressFeeRecipient.md)

**Signature:**
```solidity
function test_ProposeChangePrimaryManager_RevertZeroAddressFeeRecipient() public;
```

### test_ChangePrimaryManager_OnlySuperGovernor()

- **Signature**: `test_ChangePrimaryManager_OnlySuperGovernor()`
- **Visibility**: public
- **Source Range**: 98439:1225:661
- **Details**: [function_test_ChangePrimaryManager_OnlySuperGovernor.md](./function_test_ChangePrimaryManager_OnlySuperGovernor.md)

**Signature:**
```solidity
/// @notice Tests that only SuperGovernor can call changePrimaryManager
function test_ChangePrimaryManager_OnlySuperGovernor() public;
```

### test_ChangePrimaryManager_RevertZeroAddress()

- **Signature**: `test_ChangePrimaryManager_RevertZeroAddress()`
- **Visibility**: public
- **Source Range**: 99740:263:661
- **Details**: [function_test_ChangePrimaryManager_RevertZeroAddress.md](./function_test_ChangePrimaryManager_RevertZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests emergency replacement with zero address reverts
function test_ChangePrimaryManager_RevertZeroAddress() public;
```

### test_ChangePrimaryManager_RevertUnknownStrategy()

- **Signature**: `test_ChangePrimaryManager_RevertUnknownStrategy()`
- **Visibility**: public
- **Source Range**: 100083:493:661
- **Details**: [function_test_ChangePrimaryManager_RevertUnknownStrategy.md](./function_test_ChangePrimaryManager_RevertUnknownStrategy.md)

**Signature:**
```solidity
/// @notice Tests emergency replacement with unknown strategy reverts
function test_ChangePrimaryManager_RevertUnknownStrategy() public;
```

### test_ChangePrimaryManager_NoPendingProposals()

- **Signature**: `test_ChangePrimaryManager_NoPendingProposals()`
- **Visibility**: public
- **Source Range**: 100664:611:661
- **Details**: [function_test_ChangePrimaryManager_NoPendingProposals.md](./function_test_ChangePrimaryManager_NoPendingProposals.md)

**Signature:**
```solidity
/// @notice Tests emergency replacement works when no pending proposals exist
function test_ChangePrimaryManager_NoPendingProposals() public;
```

### test_ChangePrimaryManager_NoSecondaryManagers()

- **Signature**: `test_ChangePrimaryManager_NoSecondaryManagers()`
- **Visibility**: public
- **Source Range**: 101364:1000:661
- **Details**: [function_test_ChangePrimaryManager_NoSecondaryManagers.md](./function_test_ChangePrimaryManager_NoSecondaryManagers.md)

**Signature:**
```solidity
/// @notice Tests emergency replacement works when no secondary managers exist
function test_ChangePrimaryManager_NoSecondaryManagers() public;
```

### test_ChangePrimaryManager_EmitsEvents()

- **Signature**: `test_ChangePrimaryManager_EmitsEvents()`
- **Visibility**: public
- **Source Range**: 102439:1101:661
- **Details**: [function_test_ChangePrimaryManager_EmitsEvents.md](./function_test_ChangePrimaryManager_EmitsEvents.md)

**Signature:**
```solidity
/// @notice Tests that emergency replacement emits proper events
function test_ChangePrimaryManager_EmitsEvents() public;
```

### test_BatchForwardPPS_Revert_NonMonotonicTimestamp()

- **Signature**: `test_BatchForwardPPS_Revert_NonMonotonicTimestamp()`
- **Visibility**: public
- **Source Range**: 103816:2405:661
- **Details**: [function_test_BatchForwardPPS_Revert_NonMonotonicTimestamp.md](./function_test_BatchForwardPPS_Revert_NonMonotonicTimestamp.md)

**Signature:**
```solidity
/// @notice Tests that batch PPS updates with non-monotonic timestamps are rejected
function test_BatchForwardPPS_Revert_NonMonotonicTimestamp() public;
```

### test_BatchForwardPPS_TimestampEvents()

- **Signature**: `test_BatchForwardPPS_TimestampEvents()`
- **Visibility**: public
- **Source Range**: 106275:3821:661
- **Details**: [function_test_BatchForwardPPS_TimestampEvents.md](./function_test_BatchForwardPPS_TimestampEvents.md)

**Signature:**
```solidity
/// @notice Tests timestamp event emissions
function test_BatchForwardPPS_TimestampEvents() public;
```

### test_ForwardPPS_InsufficientUpkeep()

- **Signature**: `test_ForwardPPS_InsufficientUpkeep()`
- **Visibility**: public
- **Source Range**: 110102:1904:661
- **Details**: [function_test_ForwardPPS_InsufficientUpkeep.md](./function_test_ForwardPPS_InsufficientUpkeep.md)

**Signature:**
```solidity
function test_ForwardPPS_InsufficientUpkeep() public;
```

### test_GetUpkeepCost_RevertsWhenUpkeepTokenNotSet()

- **Signature**: `test_GetUpkeepCost_RevertsWhenUpkeepTokenNotSet()`
- **Visibility**: public
- **Source Range**: 112113:1540:661
- **Details**: [function_test_GetUpkeepCost_RevertsWhenUpkeepTokenNotSet.md](./function_test_GetUpkeepCost_RevertsWhenUpkeepTokenNotSet.md)

**Signature:**
```solidity
/// @notice Tests that getUpkeepCostPerSingleUpdate reverts when UPKEEP_TOKEN address is not set
function test_GetUpkeepCost_RevertsWhenUpkeepTokenNotSet() public;
```

### test_BatchForwardPPS_Success_MonotonicTimestamps()

- **Signature**: `test_BatchForwardPPS_Success_MonotonicTimestamps()`
- **Visibility**: public
- **Source Range**: 113742:2273:661
- **Details**: [function_test_BatchForwardPPS_Success_MonotonicTimestamps.md](./function_test_BatchForwardPPS_Success_MonotonicTimestamps.md)

**Signature:**
```solidity
/// @notice Tests that batch PPS updates with all monotonic timestamps succeed
function test_BatchForwardPPS_Success_MonotonicTimestamps() public;
```

### test_BatchForwardPPS_GasScaling()

- **Signature**: `test_BatchForwardPPS_GasScaling()`
- **Visibility**: public
- **Source Range**: 116101:5707:661
- **Details**: [function_test_BatchForwardPPS_GasScaling.md](./function_test_BatchForwardPPS_GasScaling.md)

**Signature:**
```solidity
/// @notice Tests gas scaling of batchForwardPPS with different array sizes
function test_BatchForwardPPS_GasScaling() public;
```

### test_BatchForwardPPS_StaleStrategy_UpkeepCostZero()

- **Signature**: `test_BatchForwardPPS_StaleStrategy_UpkeepCostZero()`
- **Visibility**: public
- **Source Range**: 121904:3541:661
- **Details**: [function_test_BatchForwardPPS_StaleStrategy_UpkeepCostZero.md](./function_test_BatchForwardPPS_StaleStrategy_UpkeepCostZero.md)

**Signature:**
```solidity
/// @notice Tests that batch PPS updates with stale strategy have upkeepCost set to 0
function test_BatchForwardPPS_StaleStrategy_UpkeepCostZero() public;
```

### test_StrategyPauseAndUnpause_RevertCases()

- **Signature**: `test_StrategyPauseAndUnpause_RevertCases()`
- **Visibility**: public
- **Source Range**: 125636:953:661
- **Details**: [function_test_StrategyPauseAndUnpause_RevertCases.md](./function_test_StrategyPauseAndUnpause_RevertCases.md)

**Signature:**
```solidity
function test_StrategyPauseAndUnpause_RevertCases() public;
```

### test_Upkeep_RevertCases()

- **Signature**: `test_Upkeep_RevertCases()`
- **Visibility**: public
- **Source Range**: 126784:334:661
- **Details**: [function_test_Upkeep_RevertCases.md](./function_test_Upkeep_RevertCases.md)

**Signature:**
```solidity
function test_Upkeep_RevertCases() public;
```

### test_WithdrawUpkeep_RevertCases()

- **Signature**: `test_WithdrawUpkeep_RevertCases()`
- **Visibility**: public
- **Source Range**: 127124:1221:661
- **Details**: [function_test_WithdrawUpkeep_RevertCases.md](./function_test_WithdrawUpkeep_RevertCases.md)

**Signature:**
```solidity
function test_WithdrawUpkeep_RevertCases() public;
```

### test_PerStrategyUpkeep_AttackerCreatesVaultWithVictim()

- **Signature**: `test_PerStrategyUpkeep_AttackerCreatesVaultWithVictim()`
- **Visibility**: public
- **Source Range**: 128645:2853:661
- **Details**: [function_test_PerStrategyUpkeep_AttackerCreatesVaultWithVictim.md](./function_test_PerStrategyUpkeep_AttackerCreatesVaultWithVictim.md)

**Signature:**
```solidity
/// @notice Test: Attacker creates vault with victim as mainManager → strategy has $0 balance
function test_PerStrategyUpkeep_AttackerCreatesVaultWithVictim() public;
```

### test_PerStrategyUpkeep_SecondaryManagerCannotWithdraw()

- **Signature**: `test_PerStrategyUpkeep_SecondaryManagerCannotWithdraw()`
- **Visibility**: public
- **Source Range**: 131582:1336:661
- **Details**: [function_test_PerStrategyUpkeep_SecondaryManagerCannotWithdraw.md](./function_test_PerStrategyUpkeep_SecondaryManagerCannotWithdraw.md)

**Signature:**
```solidity
/// @notice Test: Secondary manager attempts withdrawUpkeep() → reverts
function test_PerStrategyUpkeep_SecondaryManagerCannotWithdraw() public;
```

### test_PerStrategyUpkeep_NonManagerCannotWithdraw()

- **Signature**: `test_PerStrategyUpkeep_NonManagerCannotWithdraw()`
- **Visibility**: public
- **Source Range**: 132981:824:661
- **Details**: [function_test_PerStrategyUpkeep_NonManagerCannotWithdraw.md](./function_test_PerStrategyUpkeep_NonManagerCannotWithdraw.md)

**Signature:**
```solidity
/// @notice Test: Non-manager cannot withdraw upkeep
function test_PerStrategyUpkeep_NonManagerCannotWithdraw() public;
```

### test_PerStrategyUpkeep_CrossStrategyIsolation()

- **Signature**: `test_PerStrategyUpkeep_CrossStrategyIsolation()`
- **Visibility**: public
- **Source Range**: 133896:2475:661
- **Details**: [function_test_PerStrategyUpkeep_CrossStrategyIsolation.md](./function_test_PerStrategyUpkeep_CrossStrategyIsolation.md)

**Signature:**
```solidity
/// @notice Test: Cross-strategy isolation - strategies cannot affect each other
function test_PerStrategyUpkeep_CrossStrategyIsolation() public;
```

### test_PerStrategyUpkeep_PermissionlessDeposit()

- **Signature**: `test_PerStrategyUpkeep_PermissionlessDeposit()`
- **Visibility**: public
- **Source Range**: 136458:1003:661
- **Details**: [function_test_PerStrategyUpkeep_PermissionlessDeposit.md](./function_test_PerStrategyUpkeep_PermissionlessDeposit.md)

**Signature:**
```solidity
/// @notice Test: Anyone can deposit upkeep to any strategy (permissionless)
function test_PerStrategyUpkeep_PermissionlessDeposit() public;
```

### test_PerStrategyUpkeep_ManagerTakeoverInheritance()

- **Signature**: `test_PerStrategyUpkeep_ManagerTakeoverInheritance()`
- **Visibility**: public
- **Source Range**: 137536:1760:661
- **Details**: [function_test_PerStrategyUpkeep_ManagerTakeoverInheritance.md](./function_test_PerStrategyUpkeep_ManagerTakeoverInheritance.md)

**Signature:**
```solidity
/// @notice Test: Manager takeover scenario - upkeep inheritance
function test_PerStrategyUpkeep_ManagerTakeoverInheritance() public;
```

### test_PerStrategyUpkeep_VictimCanWithdrawDuringTimelock()

- **Signature**: `test_PerStrategyUpkeep_VictimCanWithdrawDuringTimelock()`
- **Visibility**: public
- **Source Range**: 139373:1542:661
- **Details**: [function_test_PerStrategyUpkeep_VictimCanWithdrawDuringTimelock.md](./function_test_PerStrategyUpkeep_VictimCanWithdrawDuringTimelock.md)

**Signature:**
```solidity
/// @notice Test: Victim can withdraw upkeep during 7-day timelock
function test_PerStrategyUpkeep_VictimCanWithdrawDuringTimelock() public;
```

### test_UpkeepDeposited_EmitsCorrectDepositor()

- **Signature**: `test_UpkeepDeposited_EmitsCorrectDepositor()`
- **Visibility**: public
- **Source Range**: 141186:825:661
- **Details**: [function_test_UpkeepDeposited_EmitsCorrectDepositor.md](./function_test_UpkeepDeposited_EmitsCorrectDepositor.md)

**Signature:**
```solidity
/// @notice Test: UpkeepDeposited event is emitted with correct depositor
function test_UpkeepDeposited_EmitsCorrectDepositor() public;
```

### test_UpkeepWithdrawn_EmitsCorrectWithdrawer()

- **Signature**: `test_UpkeepWithdrawn_EmitsCorrectWithdrawer()`
- **Visibility**: public
- **Source Range**: 142108:1367:661
- **Details**: [function_test_UpkeepWithdrawn_EmitsCorrectWithdrawer.md](./function_test_UpkeepWithdrawn_EmitsCorrectWithdrawer.md)

**Signature:**
```solidity
/// @notice Test: UpkeepWithdrawn event is emitted with correct withdrawer (initiator)
function test_UpkeepWithdrawn_EmitsCorrectWithdrawer() public;
```

### test_UpkeepDeposited_MultipleDepositors()

- **Signature**: `test_UpkeepDeposited_MultipleDepositors()`
- **Visibility**: public
- **Source Range**: 143556:1195:661
- **Details**: [function_test_UpkeepDeposited_MultipleDepositors.md](./function_test_UpkeepDeposited_MultipleDepositors.md)

**Signature:**
```solidity
/// @notice Test: Multiple depositors emit correct depositor addresses
function test_UpkeepDeposited_MultipleDepositors() public;
```

### test_ValidateHook_SingleLeafGlobalTree()

- **Signature**: `test_ValidateHook_SingleLeafGlobalTree()`
- **Visibility**: public
- **Source Range**: 145033:1368:661
- **Details**: [function_test_ValidateHook_SingleLeafGlobalTree.md](./function_test_ValidateHook_SingleLeafGlobalTree.md)

**Signature:**
```solidity
/// @notice Tests hook validation with single-leaf merkle tree (empty global proof)
function test_ValidateHook_SingleLeafGlobalTree() public;
```

### test_ValidateHook_SingleLeafStrategyTree()

- **Signature**: `test_ValidateHook_SingleLeafStrategyTree()`
- **Visibility**: public
- **Source Range**: 146497:1342:661
- **Details**: [function_test_ValidateHook_SingleLeafStrategyTree.md](./function_test_ValidateHook_SingleLeafStrategyTree.md)

**Signature:**
```solidity
/// @notice Tests hook validation with single-leaf merkle tree (empty strategy proof)
function test_ValidateHook_SingleLeafStrategyTree() public;
```

### test_ValidateHook_SingleLeafTreeWrongLeaf()

- **Signature**: `test_ValidateHook_SingleLeafTreeWrongLeaf()`
- **Visibility**: public
- **Source Range**: 147935:1597:661
- **Details**: [function_test_ValidateHook_SingleLeafTreeWrongLeaf.md](./function_test_ValidateHook_SingleLeafTreeWrongLeaf.md)

**Signature:**
```solidity
/// @notice Tests hook validation fails when leaf doesn't match single-leaf tree root
function test_ValidateHook_SingleLeafTreeWrongLeaf() public;
```

### test_ValidateHook_VetoedRoots()

- **Signature**: `test_ValidateHook_VetoedRoots()`
- **Visibility**: public
- **Source Range**: 149594:1735:661
- **Details**: [function_test_ValidateHook_VetoedRoots.md](./function_test_ValidateHook_VetoedRoots.md)

**Signature:**
```solidity
/// @notice Tests hook validation with vetoed roots
function test_ValidateHook_VetoedRoots() public;
```

### test_ValidateHook_OneRootVetoed()

- **Signature**: `test_ValidateHook_OneRootVetoed()`
- **Visibility**: public
- **Source Range**: 151420:1372:661
- **Details**: [function_test_ValidateHook_OneRootVetoed.md](./function_test_ValidateHook_OneRootVetoed.md)

**Signature:**
```solidity
/// @notice Tests hook validation when one root is vetoed but the other is valid
function test_ValidateHook_OneRootVetoed() public;
```

### test_ValidateHooks_BatchValidation()

- **Signature**: `test_ValidateHooks_BatchValidation()`
- **Visibility**: public
- **Source Range**: 152890:2804:661
- **Details**: [function_test_ValidateHooks_BatchValidation.md](./function_test_ValidateHooks_BatchValidation.md)

**Signature:**
```solidity
/// @notice Tests batch hook validation with mixed single-leaf and multi-leaf scenarios
function test_ValidateHooks_BatchValidation() public;
```

### test_ChangeGlobalLeavesStatus_Success()

- **Signature**: `test_ChangeGlobalLeavesStatus_Success()`
- **Visibility**: public
- **Source Range**: 155939:836:661
- **Details**: [function_test_ChangeGlobalLeavesStatus_Success.md](./function_test_ChangeGlobalLeavesStatus_Success.md)

**Signature:**
```solidity
/// @notice Tests successfully changing global leaves status
function test_ChangeGlobalLeavesStatus_Success() public;
```

### test_ChangeGlobalLeavesStatus_Revert_UnauthorizedCaller()

- **Signature**: `test_ChangeGlobalLeavesStatus_Revert_UnauthorizedCaller()`
- **Visibility**: public
- **Source Range**: 156861:779:661
- **Details**: [function_test_ChangeGlobalLeavesStatus_Revert_UnauthorizedCaller.md](./function_test_ChangeGlobalLeavesStatus_Revert_UnauthorizedCaller.md)

**Signature:**
```solidity
/// @notice Tests that only primary manager can change global leaves status
function test_ChangeGlobalLeavesStatus_Revert_UnauthorizedCaller() public;
```

### test_ChangeGlobalLeavesStatus_Revert_MismatchedArrays()

- **Signature**: `test_ChangeGlobalLeavesStatus_Revert_MismatchedArrays()`
- **Visibility**: public
- **Source Range**: 157705:502:661
- **Details**: [function_test_ChangeGlobalLeavesStatus_Revert_MismatchedArrays.md](./function_test_ChangeGlobalLeavesStatus_Revert_MismatchedArrays.md)

**Signature:**
```solidity
/// @notice Tests that mismatched array lengths revert
function test_ChangeGlobalLeavesStatus_Revert_MismatchedArrays() public;
```

### test_ChangeGlobalLeavesStatus_Revert_UnknownStrategy()

- **Signature**: `test_ChangeGlobalLeavesStatus_Revert_UnknownStrategy()`
- **Visibility**: public
- **Source Range**: 158265:519:661
- **Details**: [function_test_ChangeGlobalLeavesStatus_Revert_UnknownStrategy.md](./function_test_ChangeGlobalLeavesStatus_Revert_UnknownStrategy.md)

**Signature:**
```solidity
/// @notice Tests that unknown strategy reverts
function test_ChangeGlobalLeavesStatus_Revert_UnknownStrategy() public;
```

### test_ValidateHook_BannedGlobalLeaf()

- **Signature**: `test_ValidateHook_BannedGlobalLeaf()`
- **Visibility**: public
- **Source Range**: 158854:2244:661
- **Details**: [function_test_ValidateHook_BannedGlobalLeaf.md](./function_test_ValidateHook_BannedGlobalLeaf.md)

**Signature:**
```solidity
/// @notice Tests hook validation with banned global leaves
function test_ValidateHook_BannedGlobalLeaf() public;
```

### test_ValidateHook_UnbannedGlobalLeaf()

- **Signature**: `test_ValidateHook_UnbannedGlobalLeaf()`
- **Visibility**: public
- **Source Range**: 161170:1971:661
- **Details**: [function_test_ValidateHook_UnbannedGlobalLeaf.md](./function_test_ValidateHook_UnbannedGlobalLeaf.md)

**Signature:**
```solidity
/// @notice Tests hook validation with unbanned global leaves
function test_ValidateHook_UnbannedGlobalLeaf() public;
```

### test_ValidateHooks_BannedGlobalLeaves()

- **Signature**: `test_ValidateHooks_BannedGlobalLeaves()`
- **Visibility**: public
- **Source Range**: 163217:2988:661
- **Details**: [function_test_ValidateHooks_BannedGlobalLeaves.md](./function_test_ValidateHooks_BannedGlobalLeaves.md)

**Signature:**
```solidity
/// @notice Tests batch hook validation with banned global leaves
function test_ValidateHooks_BannedGlobalLeaves() public;
```

### test_ValidateHook_StrategyLeafNotAffectedByGlobalBan()

- **Signature**: `test_ValidateHook_StrategyLeafNotAffectedByGlobalBan()`
- **Visibility**: public
- **Source Range**: 166294:1516:661
- **Details**: [function_test_ValidateHook_StrategyLeafNotAffectedByGlobalBan.md](./function_test_ValidateHook_StrategyLeafNotAffectedByGlobalBan.md)

**Signature:**
```solidity
/// @notice Tests that strategy leaves are not affected by global leaf banning
function test_ValidateHook_StrategyLeafNotAffectedByGlobalBan() public;
```

### test_ChangeGlobalLeavesStatus_MultipleLeavesToggle()

- **Signature**: `test_ChangeGlobalLeavesStatus_MultipleLeavesToggle()`
- **Visibility**: public
- **Source Range**: 167876:1113:661
- **Details**: [function_test_ChangeGlobalLeavesStatus_MultipleLeavesToggle.md](./function_test_ChangeGlobalLeavesStatus_MultipleLeavesToggle.md)

**Signature:**
```solidity
/// @notice Tests multiple leaves banning and unbanning
function test_ChangeGlobalLeavesStatus_MultipleLeavesToggle() public;
```

### test_ChangeGlobalLeavesStatus_StrategyIndependence()

- **Signature**: `test_ChangeGlobalLeavesStatus_StrategyIndependence()`
- **Visibility**: public
- **Source Range**: 169074:2440:661
- **Details**: [function_test_ChangeGlobalLeavesStatus_StrategyIndependence.md](./function_test_ChangeGlobalLeavesStatus_StrategyIndependence.md)

**Signature:**
```solidity
/// @notice Tests that different strategies have independent banned leaves
function test_ChangeGlobalLeavesStatus_StrategyIndependence() public;
```

### test_ChangeGlobalLeavesStatus_EmptyArrays()

- **Signature**: `test_ChangeGlobalLeavesStatus_EmptyArrays()`
- **Visibility**: public
- **Source Range**: 171577:417:661
- **Details**: [function_test_ChangeGlobalLeavesStatus_EmptyArrays.md](./function_test_ChangeGlobalLeavesStatus_EmptyArrays.md)

**Signature:**
```solidity
/// @notice Tests empty arrays are handled correctly
function test_ChangeGlobalLeavesStatus_EmptyArrays() public;
```

### test_ProposeWithdrawUpkeep_Success()

- **Signature**: `test_ProposeWithdrawUpkeep_Success()`
- **Visibility**: public
- **Source Range**: 172259:964:661
- **Details**: [function_test_ProposeWithdrawUpkeep_Success.md](./function_test_ProposeWithdrawUpkeep_Success.md)

**Signature:**
```solidity
/// @notice Tests successful upkeep withdrawal proposal
function test_ProposeWithdrawUpkeep_Success() public;
```

### test_ProposeWithdrawUpkeep_OnlyMainManager()

- **Signature**: `test_ProposeWithdrawUpkeep_OnlyMainManager()`
- **Visibility**: public
- **Source Range**: 173297:778:661
- **Details**: [function_test_ProposeWithdrawUpkeep_OnlyMainManager.md](./function_test_ProposeWithdrawUpkeep_OnlyMainManager.md)

**Signature:**
```solidity
/// @notice Tests that only main manager can propose withdrawal
function test_ProposeWithdrawUpkeep_OnlyMainManager() public;
```

### test_ExecuteWithdrawUpkeep_AfterTimelock()

- **Signature**: `test_ExecuteWithdrawUpkeep_AfterTimelock()`
- **Visibility**: public
- **Source Range**: 174150:1470:661
- **Details**: [function_test_ExecuteWithdrawUpkeep_AfterTimelock.md](./function_test_ExecuteWithdrawUpkeep_AfterTimelock.md)

**Signature:**
```solidity
/// @notice Tests successful withdrawal execution after timelock
function test_ExecuteWithdrawUpkeep_AfterTimelock() public;
```

### test_ExecuteWithdrawUpkeep_BeforeTimelock_Reverts()

- **Signature**: `test_ExecuteWithdrawUpkeep_BeforeTimelock_Reverts()`
- **Visibility**: public
- **Source Range**: 175687:739:661
- **Details**: [function_test_ExecuteWithdrawUpkeep_BeforeTimelock_Reverts.md](./function_test_ExecuteWithdrawUpkeep_BeforeTimelock_Reverts.md)

**Signature:**
```solidity
/// @notice Tests that execution before timelock reverts
function test_ExecuteWithdrawUpkeep_BeforeTimelock_Reverts() public;
```

### test_ExecuteWithdrawUpkeep_SendsToInitiator_NotCaller()

- **Signature**: `test_ExecuteWithdrawUpkeep_SendsToInitiator_NotCaller()`
- **Visibility**: public
- **Source Range**: 176495:1181:661
- **Details**: [function_test_ExecuteWithdrawUpkeep_SendsToInitiator_NotCaller.md](./function_test_ExecuteWithdrawUpkeep_SendsToInitiator_NotCaller.md)

**Signature:**
```solidity
/// @notice Tests that funds go to initiator, not executor
function test_ExecuteWithdrawUpkeep_SendsToInitiator_NotCaller() public;
```

### test_ChangePrimaryManager_CancelsPendingWithdrawal()

- **Signature**: `test_ChangePrimaryManager_CancelsPendingWithdrawal()`
- **Visibility**: public
- **Source Range**: 177756:1568:661
- **Details**: [function_test_ChangePrimaryManager_CancelsPendingWithdrawal.md](./function_test_ChangePrimaryManager_CancelsPendingWithdrawal.md)

**Signature:**
```solidity
/// @notice Tests that governance takeover cancels pending withdrawal
function test_ChangePrimaryManager_CancelsPendingWithdrawal() public;
```

### test_ExecuteChangePrimaryManager_CancelsPendingWithdrawal()

- **Signature**: `test_ExecuteChangePrimaryManager_CancelsPendingWithdrawal()`
- **Visibility**: public
- **Source Range**: 179406:1475:661
- **Details**: [function_test_ExecuteChangePrimaryManager_CancelsPendingWithdrawal.md](./function_test_ExecuteChangePrimaryManager_CancelsPendingWithdrawal.md)

**Signature:**
```solidity
/// @notice Tests that democratic transition cancels pending withdrawal
function test_ExecuteChangePrimaryManager_CancelsPendingWithdrawal() public;
```

### test_GovernanceTakeover_CanWithdrawForfeitedUpkeep()

- **Signature**: `test_GovernanceTakeover_CanWithdrawForfeitedUpkeep()`
- **Visibility**: public
- **Source Range**: 180970:1627:661
- **Details**: [function_test_GovernanceTakeover_CanWithdrawForfeitedUpkeep.md](./function_test_GovernanceTakeover_CanWithdrawForfeitedUpkeep.md)

**Signature:**
```solidity
/// @notice Tests that governance can withdraw forfeited upkeep after takeover
function test_GovernanceTakeover_CanWithdrawForfeitedUpkeep() public;
```

### test_BatchForwardPPS_FairCostDistribution_WithStaleEntries()

- **Signature**: `test_BatchForwardPPS_FairCostDistribution_WithStaleEntries()`
- **Visibility**: public
- **Source Range**: 182955:8695:661
- **Details**: [function_test_BatchForwardPPS_FairCostDistribution_WithStaleEntries.md](./function_test_BatchForwardPPS_FairCostDistribution_WithStaleEntries.md)

**Signature:**
```solidity
/// @notice Test fair cost distribution in batchForwardPPS with mixed stale and fresh entries
///  @dev Validates that only non-stale entries are charged and costs are distributed fairly
function test_BatchForwardPPS_FairCostDistribution_WithStaleEntries() public;
```

### test_BatchForwardPPS_Revert_MaxStrategiesExceeded()

- **Signature**: `test_BatchForwardPPS_Revert_MaxStrategiesExceeded()`
- **Visibility**: public
- **Source Range**: 191744:1270:661
- **Details**: [function_test_BatchForwardPPS_Revert_MaxStrategiesExceeded.md](./function_test_BatchForwardPPS_Revert_MaxStrategiesExceeded.md)

**Signature:**
```solidity
/// @notice Tests that batch PPS updates revert when exceeding MAX_STRATEGIES limit
function test_BatchForwardPPS_Revert_MaxStrategiesExceeded() public;
```

### test_BatchForwardPPS_ArraySize1()

- **Signature**: `test_BatchForwardPPS_ArraySize1()`
- **Visibility**: public
- **Source Range**: 193076:3114:661
- **Details**: [function_test_BatchForwardPPS_ArraySize1.md](./function_test_BatchForwardPPS_ArraySize1.md)

**Signature:**
```solidity
/// @notice Tests batchForwardPPS with array size 1
function test_BatchForwardPPS_ArraySize1() public;
```

### test_ForwardPPS_Pause_Unpause_PPS_Update()

- **Signature**: `test_ForwardPPS_Pause_Unpause_PPS_Update()`
- **Visibility**: public
- **Source Range**: 196196:3334:661
- **Details**: [function_test_ForwardPPS_Pause_Unpause_PPS_Update.md](./function_test_ForwardPPS_Pause_Unpause_PPS_Update.md)

**Signature:**
```solidity
function test_ForwardPPS_Pause_Unpause_PPS_Update() public;
```

### test_ProposeMinUpdateIntervalChange_Success()

- **Signature**: `test_ProposeMinUpdateIntervalChange_Success()`
- **Visibility**: public
- **Source Range**: 199780:745:661
- **Details**: [function_test_ProposeMinUpdateIntervalChange_Success.md](./function_test_ProposeMinUpdateIntervalChange_Success.md)

**Signature:**
```solidity
/// @notice Test 1: Main manager proposes valid change
function test_ProposeMinUpdateIntervalChange_Success() public;
```

### test_ExecuteMinUpdateIntervalChange_Success()

- **Signature**: `test_ExecuteMinUpdateIntervalChange_Success()`
- **Visibility**: public
- **Source Range**: 200595:1104:661
- **Details**: [function_test_ExecuteMinUpdateIntervalChange_Success.md](./function_test_ExecuteMinUpdateIntervalChange_Success.md)

**Signature:**
```solidity
/// @notice Test 2: Propose and execute change successfully
function test_ExecuteMinUpdateIntervalChange_Success() public;
```

### test_GetProposedMinUpdateInterval()

- **Signature**: `test_GetProposedMinUpdateInterval()`
- **Visibility**: public
- **Source Range**: 201762:810:661
- **Details**: [function_test_GetProposedMinUpdateInterval.md](./function_test_GetProposedMinUpdateInterval.md)

**Signature:**
```solidity
/// @notice Test 3: Get proposed min update interval
function test_GetProposedMinUpdateInterval() public;
```

### test_MinUpdateIntervalChange_MultipleCycles()

- **Signature**: `test_MinUpdateIntervalChange_MultipleCycles()`
- **Visibility**: public
- **Source Range**: 202638:1118:661
- **Details**: [function_test_MinUpdateIntervalChange_MultipleCycles.md](./function_test_MinUpdateIntervalChange_MultipleCycles.md)

**Signature:**
```solidity
/// @notice Test 4: Multiple propose and execute cycles
function test_MinUpdateIntervalChange_MultipleCycles() public;
```

### test_ProposeMinUpdateIntervalChange_OnlyMainManager()

- **Signature**: `test_ProposeMinUpdateIntervalChange_OnlyMainManager()`
- **Visibility**: public
- **Source Range**: 203816:557:661
- **Details**: [function_test_ProposeMinUpdateIntervalChange_OnlyMainManager.md](./function_test_ProposeMinUpdateIntervalChange_OnlyMainManager.md)

**Signature:**
```solidity
/// @notice Test 5: Only main manager can propose
function test_ProposeMinUpdateIntervalChange_OnlyMainManager() public;
```

### test_ProposeMinUpdateIntervalChange_InvalidStrategy()

- **Signature**: `test_ProposeMinUpdateIntervalChange_InvalidStrategy()`
- **Visibility**: public
- **Source Range**: 204428:306:661
- **Details**: [function_test_ProposeMinUpdateIntervalChange_InvalidStrategy.md](./function_test_ProposeMinUpdateIntervalChange_InvalidStrategy.md)

**Signature:**
```solidity
/// @notice Test 6: Invalid strategy reverts
function test_ProposeMinUpdateIntervalChange_InvalidStrategy() public;
```

### test_ProposeMinUpdateIntervalChange_ExceedsMaxStaleness()

- **Signature**: `test_ProposeMinUpdateIntervalChange_ExceedsMaxStaleness()`
- **Visibility**: public
- **Source Range**: 204802:643:661
- **Details**: [function_test_ProposeMinUpdateIntervalChange_ExceedsMaxStaleness.md](./function_test_ProposeMinUpdateIntervalChange_ExceedsMaxStaleness.md)

**Signature:**
```solidity
/// @notice Test 7: Interval exceeds maxStaleness reverts
function test_ProposeMinUpdateIntervalChange_ExceedsMaxStaleness() public;
```

### test_ExecuteMinUpdateIntervalChange_NoProposal()

- **Signature**: `test_ExecuteMinUpdateIntervalChange_NoProposal()`
- **Visibility**: public
- **Source Range**: 205508:238:661
- **Details**: [function_test_ExecuteMinUpdateIntervalChange_NoProposal.md](./function_test_ExecuteMinUpdateIntervalChange_NoProposal.md)

**Signature:**
```solidity
/// @notice Test 8: Execute without proposal reverts
function test_ExecuteMinUpdateIntervalChange_NoProposal() public;
```

### test_ExecuteMinUpdateIntervalChange_TimelockNotExpired()

- **Signature**: `test_ExecuteMinUpdateIntervalChange_TimelockNotExpired()`
- **Visibility**: public
- **Source Range**: 205808:618:661
- **Details**: [function_test_ExecuteMinUpdateIntervalChange_TimelockNotExpired.md](./function_test_ExecuteMinUpdateIntervalChange_TimelockNotExpired.md)

**Signature:**
```solidity
/// @notice Test 9: Execute before timelock reverts
function test_ExecuteMinUpdateIntervalChange_TimelockNotExpired() public;
```

### test_ProposeMinUpdateIntervalChange_AllowZero()

- **Signature**: `test_ProposeMinUpdateIntervalChange_AllowZero()`
- **Visibility**: public
- **Source Range**: 206484:401:661
- **Details**: [function_test_ProposeMinUpdateIntervalChange_AllowZero.md](./function_test_ProposeMinUpdateIntervalChange_AllowZero.md)

**Signature:**
```solidity
/// @notice Test 10: Allow zero as new interval
function test_ProposeMinUpdateIntervalChange_AllowZero() public;
```

### test_ProposeMinUpdateIntervalChange_OverwritePendingProposal()

- **Signature**: `test_ProposeMinUpdateIntervalChange_OverwritePendingProposal()`
- **Visibility**: public
- **Source Range**: 206957:985:661
- **Details**: [function_test_ProposeMinUpdateIntervalChange_OverwritePendingProposal.md](./function_test_ProposeMinUpdateIntervalChange_OverwritePendingProposal.md)

**Signature:**
```solidity
/// @notice Test 11: New proposal overwrites pending proposal
function test_ProposeMinUpdateIntervalChange_OverwritePendingProposal() public;
```

### test_ChangePrimaryManager_ClearsMinUpdateIntervalProposal()

- **Signature**: `test_ChangePrimaryManager_ClearsMinUpdateIntervalProposal()`
- **Visibility**: public
- **Source Range**: 208009:1230:661
- **Details**: [function_test_ChangePrimaryManager_ClearsMinUpdateIntervalProposal.md](./function_test_ChangePrimaryManager_ClearsMinUpdateIntervalProposal.md)

**Signature:**
```solidity
/// @notice Test 12: Manager replacement clears proposal
function test_ChangePrimaryManager_ClearsMinUpdateIntervalProposal() public;
```

### test_ExecuteMinUpdateIntervalChange_SilentlyClearsInvalidProposal()

- **Signature**: `test_ExecuteMinUpdateIntervalChange_SilentlyClearsInvalidProposal()`
- **Visibility**: public
- **Source Range**: 209355:1363:661
- **Details**: [function_test_ExecuteMinUpdateIntervalChange_SilentlyClearsInvalidProposal.md](./function_test_ExecuteMinUpdateIntervalChange_SilentlyClearsInvalidProposal.md)

**Signature:**
```solidity
/// @notice Test 13: Execute silently clears proposal if validation fails (e.g., if maxStaleness changed)
function test_ExecuteMinUpdateIntervalChange_SilentlyClearsInvalidProposal() public;
```

### test_MinUpdateIntervalChange_ImmediatelyEffective()

- **Signature**: `test_MinUpdateIntervalChange_ImmediatelyEffective()`
- **Visibility**: public
- **Source Range**: 210791:1114:661
- **Details**: [function_test_MinUpdateIntervalChange_ImmediatelyEffective.md](./function_test_MinUpdateIntervalChange_ImmediatelyEffective.md)

**Signature:**
```solidity
/// @notice Test 14: Changed interval is immediately effective
function test_MinUpdateIntervalChange_ImmediatelyEffective() public;
```

### test_ForwardPPS_UsesMinOfIntervalAndStaleness()

- **Signature**: `test_ForwardPPS_UsesMinOfIntervalAndStaleness()`
- **Visibility**: public
- **Source Range**: 212008:2470:661
- **Details**: [function_test_ForwardPPS_UsesMinOfIntervalAndStaleness.md](./function_test_ForwardPPS_UsesMinOfIntervalAndStaleness.md)

**Signature:**
```solidity
/// @notice Test 15: _forwardPPS uses min(minUpdateInterval, maxStaleness) for rate limiting
function test_ForwardPPS_UsesMinOfIntervalAndStaleness() public;
```

### test_CancelMinUpdateIntervalChange_Success()

- **Signature**: `test_CancelMinUpdateIntervalChange_Success()`
- **Visibility**: public
- **Source Range**: 214550:1188:661
- **Details**: [function_test_CancelMinUpdateIntervalChange_Success.md](./function_test_CancelMinUpdateIntervalChange_Success.md)

**Signature:**
```solidity
/// @notice Test 16: Cancel minUpdateInterval change proposal
function test_CancelMinUpdateIntervalChange_Success() public;
```

### test_CancelMinUpdateIntervalChange_OnlyMainManager()

- **Signature**: `test_CancelMinUpdateIntervalChange_OnlyMainManager()`
- **Visibility**: public
- **Source Range**: 215798:440:661
- **Details**: [function_test_CancelMinUpdateIntervalChange_OnlyMainManager.md](./function_test_CancelMinUpdateIntervalChange_OnlyMainManager.md)

**Signature:**
```solidity
/// @notice Test 17: Only main manager can cancel
function test_CancelMinUpdateIntervalChange_OnlyMainManager() public;
```

### test_CancelMinUpdateIntervalChange_NoProposal()

- **Signature**: `test_CancelMinUpdateIntervalChange_NoProposal()`
- **Visibility**: public
- **Source Range**: 216305:312:661
- **Details**: [function_test_CancelMinUpdateIntervalChange_NoProposal.md](./function_test_CancelMinUpdateIntervalChange_NoProposal.md)

**Signature:**
```solidity
/// @notice Test 18: Cannot cancel if no proposal exists
function test_CancelMinUpdateIntervalChange_NoProposal() public;
```

### test_ExecuteMinUpdateIntervalChange_EmitsRejectionEvent()

- **Signature**: `test_ExecuteMinUpdateIntervalChange_EmitsRejectionEvent()`
- **Visibility**: public
- **Source Range**: 216702:941:661
- **Details**: [function_test_ExecuteMinUpdateIntervalChange_EmitsRejectionEvent.md](./function_test_ExecuteMinUpdateIntervalChange_EmitsRejectionEvent.md)

**Signature:**
```solidity
/// @notice Test 19: Rejection event emitted when proposal becomes invalid
function test_ExecuteMinUpdateIntervalChange_EmitsRejectionEvent() public;
```

### test_ForwardPPS_AberrantPPS_NotStored()

- **Signature**: `test_ForwardPPS_AberrantPPS_NotStored()`
- **Visibility**: public
- **Source Range**: 218623:1735:661
- **Details**: [function_test_ForwardPPS_AberrantPPS_NotStored.md](./function_test_ForwardPPS_AberrantPPS_NotStored.md)

**Signature:**
```solidity
/// @notice Test that aberrant PPS is NOT stored when validation fails
function test_ForwardPPS_AberrantPPS_NotStored() public;
```

### test_SkimTimelock_RevertsWithin12Hours()

- **Signature**: `test_SkimTimelock_RevertsWithin12Hours()`
- **Visibility**: public
- **Source Range**: 220425:2800:661
- **Details**: [function_test_SkimTimelock_RevertsWithin12Hours.md](./function_test_SkimTimelock_RevertsWithin12Hours.md)

**Signature:**
```solidity
/// @notice Test that skim reverts within 12h of unpause
function test_SkimTimelock_RevertsWithin12Hours() public;
```

### test_ForwardPPS_SkipsC1CheckWhenStale()

- **Signature**: `test_ForwardPPS_SkipsC1CheckWhenStale()`
- **Visibility**: public
- **Source Range**: 223313:2062:661
- **Details**: [function_test_ForwardPPS_SkipsC1CheckWhenStale.md](./function_test_ForwardPPS_SkipsC1CheckWhenStale.md)

**Signature:**
```solidity
/// @notice Test that first PPS update after unpause skips C1 deviation check
function test_ForwardPPS_SkipsC1CheckWhenStale() public;
```

### test_ForwardPPS_RejectUpdateWhenPaused()

- **Signature**: `test_ForwardPPS_RejectUpdateWhenPaused()`
- **Visibility**: public
- **Source Range**: 225485:2027:661
- **Details**: [function_test_ForwardPPS_RejectUpdateWhenPaused.md](./function_test_ForwardPPS_RejectUpdateWhenPaused.md)

**Signature:**
```solidity
/// @notice Test that PPS update is explicitly rejected when strategy is paused (early return path)
function test_ForwardPPS_RejectUpdateWhenPaused() public;
```

### test_ForwardPPS_DontStoreAberrantPPS_MNCheck()

- **Signature**: `test_ForwardPPS_DontStoreAberrantPPS_MNCheck()`
- **Visibility**: public
- **Source Range**: 227602:2137:661
- **Details**: [function_test_ForwardPPS_DontStoreAberrantPPS_MNCheck.md](./function_test_ForwardPPS_DontStoreAberrantPPS_MNCheck.md)

**Signature:**
```solidity
/// @notice Test that aberrant PPS is not stored when M/N threshold check fails
function test_ForwardPPS_DontStoreAberrantPPS_MNCheck() public;
```

### test_ForwardPPS_MultipleFailuresDontOverwritePPS()

- **Signature**: `test_ForwardPPS_MultipleFailuresDontOverwritePPS()`
- **Visibility**: public
- **Source Range**: 229832:2752:661
- **Details**: [function_test_ForwardPPS_MultipleFailuresDontOverwritePPS.md](./function_test_ForwardPPS_MultipleFailuresDontOverwritePPS.md)

**Signature:**
```solidity
/// @notice Test that multiple consecutive validation failures don't overwrite PPS
function test_ForwardPPS_MultipleFailuresDontOverwritePPS() public;
```

### test_ForwardPPS_UpkeepFailureDoesntStorePPS()

- **Signature**: `test_ForwardPPS_UpkeepFailureDoesntStorePPS()`
- **Visibility**: public
- **Source Range**: 232967:807:661
- **Details**: [function_test_ForwardPPS_UpkeepFailureDoesntStorePPS.md](./function_test_ForwardPPS_UpkeepFailureDoesntStorePPS.md)

**Signature:**
```solidity
/// @notice Test upkeep failure path doesn't store PPS
///  @dev Upkeep failure path is covered by existing logic at lines 1180-1186 in SuperVaultAggregator.sol
///  @dev This test validates the logic exists but upkeep is disabled by default in test environment
///  @dev The upkeep failure path follows the same pause + stale pattern as other validation failures
function test_ForwardPPS_UpkeepFailureDoesntStorePPS() public view;
```

### test_ForwardPPS_AlreadyPausedSkipsValidation()

- **Signature**: `test_ForwardPPS_AlreadyPausedSkipsValidation()`
- **Visibility**: public
- **Source Range**: 233854:1837:661
- **Details**: [function_test_ForwardPPS_AlreadyPausedSkipsValidation.md](./function_test_ForwardPPS_AlreadyPausedSkipsValidation.md)

**Signature:**
```solidity
/// @notice Test that already paused strategy skips validation checks
function test_ForwardPPS_AlreadyPausedSkipsValidation() public;
```

### test_ForwardPPS_UpkeepCostFailure_ContinuesWithoutCharge()

- **Signature**: `test_ForwardPPS_UpkeepCostFailure_ContinuesWithoutCharge()`
- **Visibility**: public
- **Source Range**: 235875:2768:661
- **Details**: [function_test_ForwardPPS_UpkeepCostFailure_ContinuesWithoutCharge.md](./function_test_ForwardPPS_UpkeepCostFailure_ContinuesWithoutCharge.md)

**Signature:**
```solidity
/// @notice Test that PPS updates succeed even when upkeep cost calculation fails (try-catch)
///  @dev Security fix: Validates resilience against oracle misconfiguration
function test_ForwardPPS_UpkeepCostFailure_ContinuesWithoutCharge() public;
```

### test_AuthorizeOperator_ReturnsTrue()

- **Signature**: `test_AuthorizeOperator_ReturnsTrue()`
- **Visibility**: public
- **Source Range**: 238744:1731:661
- **Details**: [function_test_AuthorizeOperator_ReturnsTrue.md](./function_test_AuthorizeOperator_ReturnsTrue.md)

**Signature:**
```solidity
/// @notice Tests that authorizeOperator returns true and correctly authorizes an operator
function test_AuthorizeOperator_ReturnsTrue() public;
```

### test_PendingCancelRedeemRequest()

- **Signature**: `test_PendingCancelRedeemRequest()`
- **Visibility**: public
- **Source Range**: 240566:2565:661
- **Details**: [function_test_PendingCancelRedeemRequest.md](./function_test_PendingCancelRedeemRequest.md)

**Signature:**
```solidity
/// @notice Tests that pendingCancelRedeemRequest returns correct boolean values
function test_PendingCancelRedeemRequest() public;
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
