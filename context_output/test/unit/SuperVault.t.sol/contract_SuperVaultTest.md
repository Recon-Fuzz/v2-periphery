# Contract: SuperVaultTest

## Metadata

- **Name**: SuperVaultTest
- **Type**: Contract
- **Path**: test/unit/SuperVault.t.sol
- **Documentation**: @title SuperVaultTest
   @notice Unit tests for SuperVault contract

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

### vault

```solidity
SuperVault internal vault
```

**SuperVault**: [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

### strategy

```solidity
SuperVaultStrategy internal strategy
```

**SuperVaultStrategy**: [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

### asset

```solidity
MockERC20 internal asset
```

**MockERC20**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

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

### user

```solidity
address internal user
```

### manager

```solidity
address internal manager
```

### superBank

```solidity
address internal superBank
```

### superOracle

```solidity
address internal superOracle
```

### upToken

```solidity
address internal upToken
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

## Public/External Functions

### setUp()

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2131:3461:660
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
/// @notice Sets up the test environment before each test case
function setUp() public;
```

### test_PendingCancelRedeemRequest_InitialState()

- **Signature**: `test_PendingCancelRedeemRequest_InitialState()`
- **Visibility**: public
- **Source Range**: 5874:586:660
- **Details**: [function_test_PendingCancelRedeemRequest_InitialState.md](./function_test_PendingCancelRedeemRequest_InitialState.md)

**Signature:**
```solidity
/// @notice Tests pendingCancelRedeemRequest returns false when no cancel request is pending
function test_PendingCancelRedeemRequest_InitialState() public;
```

### test_PendingCancelRedeemRequest_AfterCancelRequest()

- **Signature**: `test_PendingCancelRedeemRequest_AfterCancelRequest()`
- **Visibility**: public
- **Source Range**: 6557:1063:660
- **Details**: [function_test_PendingCancelRedeemRequest_AfterCancelRequest.md](./function_test_PendingCancelRedeemRequest_AfterCancelRequest.md)

**Signature:**
```solidity
/// @notice Tests pendingCancelRedeemRequest returns true after cancel request is made
function test_PendingCancelRedeemRequest_AfterCancelRequest() public;
```

### test_PendingCancelRedeemRequest_AfterFulfillment()

- **Signature**: `test_PendingCancelRedeemRequest_AfterFulfillment()`
- **Visibility**: public
- **Source Range**: 7718:1282:660
- **Details**: [function_test_PendingCancelRedeemRequest_AfterFulfillment.md](./function_test_PendingCancelRedeemRequest_AfterFulfillment.md)

**Signature:**
```solidity
/// @notice Tests pendingCancelRedeemRequest returns true after fulfillment until claim
function test_PendingCancelRedeemRequest_AfterFulfillment() public;
```

### test_PendingCancelRedeemRequest_AfterClaim()

- **Signature**: `test_PendingCancelRedeemRequest_AfterClaim()`
- **Visibility**: public
- **Source Range**: 9094:1391:660
- **Details**: [function_test_PendingCancelRedeemRequest_AfterClaim.md](./function_test_PendingCancelRedeemRequest_AfterClaim.md)

**Signature:**
```solidity
/// @notice Tests pendingCancelRedeemRequest returns false after claim is completed
function test_PendingCancelRedeemRequest_AfterClaim() public;
```

### test_PendingCancelRedeemRequest_RequestIdIgnored()

- **Signature**: `test_PendingCancelRedeemRequest_RequestIdIgnored()`
- **Visibility**: public
- **Source Range**: 10583:1136:660
- **Details**: [function_test_PendingCancelRedeemRequest_RequestIdIgnored.md](./function_test_PendingCancelRedeemRequest_RequestIdIgnored.md)

**Signature:**
```solidity
/// @notice Tests pendingCancelRedeemRequest with request ID parameter (always ignored)
function test_PendingCancelRedeemRequest_RequestIdIgnored() public;
```

### test_PendingCancelRedeemRequest_MultipleUsers()

- **Signature**: `test_PendingCancelRedeemRequest_MultipleUsers()`
- **Visibility**: public
- **Source Range**: 11807:1278:660
- **Details**: [function_test_PendingCancelRedeemRequest_MultipleUsers.md](./function_test_PendingCancelRedeemRequest_MultipleUsers.md)

**Signature:**
```solidity
/// @notice Tests pendingCancelRedeemRequest for multiple users independently
function test_PendingCancelRedeemRequest_MultipleUsers() public;
```

### test_MaxMint_ReturnsMaxWhenDepositsAccepted()

- **Signature**: `test_MaxMint_ReturnsMaxWhenDepositsAccepted()`
- **Visibility**: public
- **Source Range**: 13353:665:660
- **Details**: [function_test_MaxMint_ReturnsMaxWhenDepositsAccepted.md](./function_test_MaxMint_ReturnsMaxWhenDepositsAccepted.md)

**Signature:**
```solidity
/// @notice Tests maxMint returns type(uint256).max when deposits can be accepted (initial state)
function test_MaxMint_ReturnsMaxWhenDepositsAccepted() public;
```

### test_MaxMint_ReturnsZeroWhenStrategyPaused()

- **Signature**: `test_MaxMint_ReturnsZeroWhenStrategyPaused()`
- **Visibility**: public
- **Source Range**: 14088:837:660
- **Details**: [function_test_MaxMint_ReturnsZeroWhenStrategyPaused.md](./function_test_MaxMint_ReturnsZeroWhenStrategyPaused.md)

**Signature:**
```solidity
/// @notice Tests maxMint returns 0 when strategy is paused
function test_MaxMint_ReturnsZeroWhenStrategyPaused() public;
```

### test_MaxMint_ReturnsZeroWhenPPSStale()

- **Signature**: `test_MaxMint_ReturnsZeroWhenPPSStale()`
- **Visibility**: public
- **Source Range**: 15029:903:660
- **Details**: [function_test_MaxMint_ReturnsZeroWhenPPSStale.md](./function_test_MaxMint_ReturnsZeroWhenPPSStale.md)

**Signature:**
```solidity
/// @notice Tests maxMint returns 0 when PPS is stale (strategy unpaused but PPS not updated)
function test_MaxMint_ReturnsZeroWhenPPSStale() public;
```

### test_MaxMint_ReturnsZeroWhenPausedAndStale()

- **Signature**: `test_MaxMint_ReturnsZeroWhenPausedAndStale()`
- **Visibility**: public
- **Source Range**: 16024:739:660
- **Details**: [function_test_MaxMint_ReturnsZeroWhenPausedAndStale.md](./function_test_MaxMint_ReturnsZeroWhenPausedAndStale.md)

**Signature:**
```solidity
/// @notice Tests maxMint returns 0 when both strategy is paused and PPS is stale
function test_MaxMint_ReturnsZeroWhenPausedAndStale() public;
```

### test_MaxMint_AddressParameterIgnored()

- **Signature**: `test_MaxMint_AddressParameterIgnored()`
- **Visibility**: public
- **Source Range**: 16843:792:660
- **Details**: [function_test_MaxMint_AddressParameterIgnored.md](./function_test_MaxMint_AddressParameterIgnored.md)

**Signature:**
```solidity
/// @notice Tests maxMint with different addresses returns same value
function test_MaxMint_AddressParameterIgnored() public;
```

### test_MaxMint_StateTransitions()

- **Signature**: `test_MaxMint_StateTransitions()`
- **Visibility**: public
- **Source Range**: 17708:1062:660
- **Details**: [function_test_MaxMint_StateTransitions.md](./function_test_MaxMint_StateTransitions.md)

**Signature:**
```solidity
/// @notice Tests maxMint transitions between states correctly
function test_MaxMint_StateTransitions() public;
```

### test_PreviewMint_NormalCase()

- **Signature**: `test_PreviewMint_NormalCase()`
- **Visibility**: public
- **Source Range**: 19041:2140:660
- **Details**: [function_test_PreviewMint_NormalCase.md](./function_test_PreviewMint_NormalCase.md)

**Signature:**
```solidity
/// @notice Tests previewMint returns correct gross assets when managementFeeBps < BPS_PRECISION
function test_PreviewMint_NormalCase() public;
```

### test_PreviewMint_EdgeCaseImpossibleFee()

- **Signature**: `test_PreviewMint_EdgeCaseImpossibleFee()`
- **Visibility**: public
- **Source Range**: 21270:2049:660
- **Details**: [function_test_PreviewMint_EdgeCaseImpossibleFee.md](./function_test_PreviewMint_EdgeCaseImpossibleFee.md)

**Signature:**
```solidity
/// @notice Tests previewMint returns 0 when managementFeeBps >= BPS_PRECISION
function test_PreviewMint_EdgeCaseImpossibleFee() public;
```

### test_Deposit_RevertsOnZeroAmount()

- **Signature**: `test_Deposit_RevertsOnZeroAmount()`
- **Visibility**: public
- **Source Range**: 23579:500:660
- **Details**: [function_test_Deposit_RevertsOnZeroAmount.md](./function_test_Deposit_RevertsOnZeroAmount.md)

**Signature:**
```solidity
/// @notice Tests deposit reverts when assets is 0
///  @dev Covers SuperVault.sol:145
function test_Deposit_RevertsOnZeroAmount() public;
```

### test_Deposit_RevertsOnZeroSharesReturned()

- **Signature**: `test_Deposit_RevertsOnZeroSharesReturned()`
- **Visibility**: public
- **Source Range**: 24514:1731:660
- **Details**: [function_test_Deposit_RevertsOnZeroSharesReturned.md](./function_test_Deposit_RevertsOnZeroSharesReturned.md)

**Signature:**
```solidity
/// @notice Tests deposit reverts when shares calculation rounds to 0
///  @dev Covers SuperVault.sol:152 (defensive check)
///  @dev Note: The strategy validates shares != 0 first (SuperVaultStrategy.sol:187), so it reverts
///       with INVALID_AMOUNT before the vault's check at line 152 is reached. The vault's check
///       is a defensive secondary validation in case the strategy implementation changes.
function test_Deposit_RevertsOnZeroSharesReturned() public;
```

### test_Withdraw_RevertsOnZeroAddressReceiver()

- **Signature**: `test_Withdraw_RevertsOnZeroAddressReceiver()`
- **Visibility**: public
- **Source Range**: 26479:1356:660
- **Details**: [function_test_Withdraw_RevertsOnZeroAddressReceiver.md](./function_test_Withdraw_RevertsOnZeroAddressReceiver.md)

**Signature:**
```solidity
/// @notice Tests withdraw reverts when receiver is address(0)
function test_Withdraw_RevertsOnZeroAddressReceiver() public;
```

### test_Withdraw_RevertsOnZeroAverageWithdrawPrice()

- **Signature**: `test_Withdraw_RevertsOnZeroAverageWithdrawPrice()`
- **Visibility**: public
- **Source Range**: 27937:932:660
- **Details**: [function_test_Withdraw_RevertsOnZeroAverageWithdrawPrice.md](./function_test_Withdraw_RevertsOnZeroAverageWithdrawPrice.md)

**Signature:**
```solidity
/// @notice Tests withdraw reverts when averageWithdrawPrice is 0 (no fulfilled redemption)
function test_Withdraw_RevertsOnZeroAverageWithdrawPrice() public;
```

### test_Withdraw_OperatorSucceedsWithReceiverEqualController()

- **Signature**: `test_Withdraw_OperatorSucceedsWithReceiverEqualController()`
- **Visibility**: public
- **Source Range**: 28963:1683:660
- **Details**: [function_test_Withdraw_OperatorSucceedsWithReceiverEqualController.md](./function_test_Withdraw_OperatorSucceedsWithReceiverEqualController.md)

**Signature:**
```solidity
/// @notice Tests withdraw succeeds when operator calls with receiver == controller
function test_Withdraw_OperatorSucceedsWithReceiverEqualController() public;
```

### test_Withdraw_OperatorRevertsWithReceiverNotEqualController()

- **Signature**: `test_Withdraw_OperatorRevertsWithReceiverNotEqualController()`
- **Visibility**: public
- **Source Range**: 30739:1576:660
- **Details**: [function_test_Withdraw_OperatorRevertsWithReceiverNotEqualController.md](./function_test_Withdraw_OperatorRevertsWithReceiverNotEqualController.md)

**Signature:**
```solidity
/// @notice Tests withdraw reverts when operator calls with receiver != controller
function test_Withdraw_OperatorRevertsWithReceiverNotEqualController() public;
```

### test_Withdraw_ControllerSucceedsWithArbitraryReceiver()

- **Signature**: `test_Withdraw_ControllerSucceedsWithArbitraryReceiver()`
- **Visibility**: public
- **Source Range**: 32407:1674:660
- **Details**: [function_test_Withdraw_ControllerSucceedsWithArbitraryReceiver.md](./function_test_Withdraw_ControllerSucceedsWithArbitraryReceiver.md)

**Signature:**
```solidity
/// @notice Tests withdraw succeeds when controller calls with arbitrary receiver
function test_Withdraw_ControllerSucceedsWithArbitraryReceiver() public;
```

### test_Withdraw_NonOperatorReverts()

- **Signature**: `test_Withdraw_NonOperatorReverts()`
- **Visibility**: public
- **Source Range**: 34174:1402:660
- **Details**: [function_test_Withdraw_NonOperatorReverts.md](./function_test_Withdraw_NonOperatorReverts.md)

**Signature:**
```solidity
/// @notice Tests withdraw reverts when non-operator calls on behalf of controller
function test_Withdraw_NonOperatorReverts() public;
```

### test_Redeem_OperatorSucceedsWithReceiverEqualController()

- **Signature**: `test_Redeem_OperatorSucceedsWithReceiverEqualController()`
- **Visibility**: public
- **Source Range**: 35668:1658:660
- **Details**: [function_test_Redeem_OperatorSucceedsWithReceiverEqualController.md](./function_test_Redeem_OperatorSucceedsWithReceiverEqualController.md)

**Signature:**
```solidity
/// @notice Tests redeem succeeds when operator calls with receiver == controller
function test_Redeem_OperatorSucceedsWithReceiverEqualController() public;
```

### test_Redeem_OperatorRevertsWithReceiverNotEqualController()

- **Signature**: `test_Redeem_OperatorRevertsWithReceiverNotEqualController()`
- **Visibility**: public
- **Source Range**: 37417:1569:660
- **Details**: [function_test_Redeem_OperatorRevertsWithReceiverNotEqualController.md](./function_test_Redeem_OperatorRevertsWithReceiverNotEqualController.md)

**Signature:**
```solidity
/// @notice Tests redeem reverts when operator calls with receiver != controller
function test_Redeem_OperatorRevertsWithReceiverNotEqualController() public;
```

### test_Redeem_ControllerSucceedsWithArbitraryReceiver()

- **Signature**: `test_Redeem_ControllerSucceedsWithArbitraryReceiver()`
- **Visibility**: public
- **Source Range**: 39076:1627:660
- **Details**: [function_test_Redeem_ControllerSucceedsWithArbitraryReceiver.md](./function_test_Redeem_ControllerSucceedsWithArbitraryReceiver.md)

**Signature:**
```solidity
/// @notice Tests redeem succeeds when controller calls with arbitrary receiver
function test_Redeem_ControllerSucceedsWithArbitraryReceiver() public;
```

### test_Redeem_NonOperatorReverts()

- **Signature**: `test_Redeem_NonOperatorReverts()`
- **Visibility**: public
- **Source Range**: 40794:1395:660
- **Details**: [function_test_Redeem_NonOperatorReverts.md](./function_test_Redeem_NonOperatorReverts.md)

**Signature:**
```solidity
/// @notice Tests redeem reverts when non-operator calls on behalf of controller
function test_Redeem_NonOperatorReverts() public;
```

### test_SuperVaultStrategy_Constructor_RevertsOnZeroAddress()

- **Signature**: `test_SuperVaultStrategy_Constructor_RevertsOnZeroAddress()`
- **Visibility**: public
- **Source Range**: 42460:496:660
- **Details**: [function_test_SuperVaultStrategy_Constructor_RevertsOnZeroAddress.md](./function_test_SuperVaultStrategy_Constructor_RevertsOnZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests SuperVaultStrategy constructor reverts when superGovernor is address(0)
function test_SuperVaultStrategy_Constructor_RevertsOnZeroAddress() public;
```

### test_SuperVaultStrategy_Initialize_RevertsOnZeroVaultAddress()

- **Signature**: `test_SuperVaultStrategy_Initialize_RevertsOnZeroVaultAddress()`
- **Visibility**: public
- **Source Range**: 43054:1158:660
- **Details**: [function_test_SuperVaultStrategy_Initialize_RevertsOnZeroVaultAddress.md](./function_test_SuperVaultStrategy_Initialize_RevertsOnZeroVaultAddress.md)

**Signature:**
```solidity
/// @notice Tests SuperVaultStrategy initialize reverts when vaultAddress is address(0)
function test_SuperVaultStrategy_Initialize_RevertsOnZeroVaultAddress() public;
```

### test_SuperVaultStrategy_Initialize_RevertsOnInvalidPerformanceFeeBps()

- **Signature**: `test_SuperVaultStrategy_Initialize_RevertsOnInvalidPerformanceFeeBps()`
- **Visibility**: public
- **Source Range**: 44323:1184:660
- **Details**: [function_test_SuperVaultStrategy_Initialize_RevertsOnInvalidPerformanceFeeBps.md](./function_test_SuperVaultStrategy_Initialize_RevertsOnInvalidPerformanceFeeBps.md)

**Signature:**
```solidity
/// @notice Tests SuperVaultStrategy initialize reverts when performanceFeeBps > MAX_PERFORMANCE_FEE
function test_SuperVaultStrategy_Initialize_RevertsOnInvalidPerformanceFeeBps() public;
```

### test_SuperVaultStrategy_Initialize_RevertsOnInvalidManagementFeeBps()

- **Signature**: `test_SuperVaultStrategy_Initialize_RevertsOnInvalidManagementFeeBps()`
- **Visibility**: public
- **Source Range**: 45611:1178:660
- **Details**: [function_test_SuperVaultStrategy_Initialize_RevertsOnInvalidManagementFeeBps.md](./function_test_SuperVaultStrategy_Initialize_RevertsOnInvalidManagementFeeBps.md)

**Signature:**
```solidity
/// @notice Tests SuperVaultStrategy initialize reverts when managementFeeBps > BPS_PRECISION
function test_SuperVaultStrategy_Initialize_RevertsOnInvalidManagementFeeBps() public;
```

### test_SuperVaultStrategy_Initialize_RevertsOnZeroRecipientWithFees()

- **Signature**: `test_SuperVaultStrategy_Initialize_RevertsOnZeroRecipientWithFees()`
- **Visibility**: public
- **Source Range**: 46999:1182:660
- **Details**: [function_test_SuperVaultStrategy_Initialize_RevertsOnZeroRecipientWithFees.md](./function_test_SuperVaultStrategy_Initialize_RevertsOnZeroRecipientWithFees.md)

**Signature:**
```solidity
/// @notice Tests SuperVaultStrategy initialize reverts when fees > 0 and recipient is address(0)
///  @dev Covers SuperVaultStrategy.sol:124-127 (initialization validation that protects line 178)
function test_SuperVaultStrategy_Initialize_RevertsOnZeroRecipientWithFees() public;
```

### test_SuperVaultStrategy_Initialize_AllowsZeroRecipientWithZeroFees()

- **Signature**: `test_SuperVaultStrategy_Initialize_AllowsZeroRecipientWithZeroFees()`
- **Visibility**: public
- **Source Range**: 48381:1616:660
- **Details**: [function_test_SuperVaultStrategy_Initialize_AllowsZeroRecipientWithZeroFees.md](./function_test_SuperVaultStrategy_Initialize_AllowsZeroRecipientWithZeroFees.md)

**Signature:**
```solidity
/// @notice Tests SuperVaultStrategy initialize allows address(0) recipient when both fees are 0
///  @dev This is allowed because recipient can be configured later via fee config update
function test_SuperVaultStrategy_Initialize_AllowsZeroRecipientWithZeroFees() public;
```

### test_SuperVaultStrategy_Initialize_RevertsOnInvalidAsset()

- **Signature**: `test_SuperVaultStrategy_Initialize_RevertsOnInvalidAsset()`
- **Visibility**: public
- **Source Range**: 50095:1514:660
- **Details**: [function_test_SuperVaultStrategy_Initialize_RevertsOnInvalidAsset.md](./function_test_SuperVaultStrategy_Initialize_RevertsOnInvalidAsset.md)

**Signature:**
```solidity
/// @notice Tests SuperVaultStrategy initialize reverts when asset has invalid decimals
function test_SuperVaultStrategy_Initialize_RevertsOnInvalidAsset() public;
```

### test_HandleOperations4626Deposit_RevertsOnZeroAssets()

- **Signature**: `test_HandleOperations4626Deposit_RevertsOnZeroAssets()`
- **Visibility**: public
- **Source Range**: 51831:632:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsOnZeroAssets.md](./function_test_HandleOperations4626Deposit_RevertsOnZeroAssets.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when assetsGross is 0
///  @dev Covers SuperVaultStrategy.sol:158
///  @dev Note: SuperVault.deposit checks for zero first and reverts with ZERO_AMOUNT
function test_HandleOperations4626Deposit_RevertsOnZeroAssets() public;
```

### test_HandleOperations4626Deposit_RevertsOnZeroAddressController()

- **Signature**: `test_HandleOperations4626Deposit_RevertsOnZeroAddressController()`
- **Visibility**: public
- **Source Range**: 52719:707:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsOnZeroAddressController.md](./function_test_HandleOperations4626Deposit_RevertsOnZeroAddressController.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when controller is address(0)
///  @dev Covers SuperVaultStrategy.sol:159
///  @dev This tests the defensive validation in the strategy by attempting to call with address(0) as receiver
function test_HandleOperations4626Deposit_RevertsOnZeroAddressController() public;
```

### test_HandleOperations4626Deposit_RevertsWhenGlobalHooksVetoed()

- **Signature**: `test_HandleOperations4626Deposit_RevertsWhenGlobalHooksVetoed()`
- **Visibility**: public
- **Source Range**: 53574:1093:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsWhenGlobalHooksVetoed.md](./function_test_HandleOperations4626Deposit_RevertsWhenGlobalHooksVetoed.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when global hooks root is vetoed
///  @dev Covers SuperVaultStrategy.sol:163-165
function test_HandleOperations4626Deposit_RevertsWhenGlobalHooksVetoed() public;
```

### test_HandleOperations4626Deposit_RevertsOnZeroAssetsNet()

- **Signature**: `test_HandleOperations4626Deposit_RevertsOnZeroAssetsNet()`
- **Visibility**: public
- **Source Range**: 54823:1457:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsOnZeroAssetsNet.md](./function_test_HandleOperations4626Deposit_RevertsOnZeroAssetsNet.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when assetsNet becomes 0 after fee deduction
///  @dev Covers SuperVaultStrategy.sol:174
function test_HandleOperations4626Deposit_RevertsOnZeroAssetsNet() public;
```

### test_HandleOperations4626Deposit_RevertsOnZeroPPS()

- **Signature**: `test_HandleOperations4626Deposit_RevertsOnZeroPPS()`
- **Visibility**: public
- **Source Range**: 56405:1987:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsOnZeroPPS.md](./function_test_HandleOperations4626Deposit_RevertsOnZeroPPS.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when PPS is 0
///  @dev Covers SuperVaultStrategy.sol:185
function test_HandleOperations4626Deposit_RevertsOnZeroPPS() public;
```

### test_HandleOperations4626Deposit_RevertsOnZeroSharesNet()

- **Signature**: `test_HandleOperations4626Deposit_RevertsOnZeroSharesNet()`
- **Visibility**: public
- **Source Range**: 58530:1662:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsOnZeroSharesNet.md](./function_test_HandleOperations4626Deposit_RevertsOnZeroSharesNet.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when sharesNet rounds to 0
///  @dev Covers SuperVaultStrategy.sol:187
function test_HandleOperations4626Deposit_RevertsOnZeroSharesNet() public;
```

### test_HandleOperations4626Deposit_RevertsOnAccessDenied()

- **Signature**: `test_HandleOperations4626Deposit_RevertsOnAccessDenied()`
- **Visibility**: public
- **Source Range**: 60360:409:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsOnAccessDenied.md](./function_test_HandleOperations4626Deposit_RevertsOnAccessDenied.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when called by non-vault address
///  @dev Covers SuperVaultStrategy.sol:156 - _requireVault() check
function test_HandleOperations4626Deposit_RevertsOnAccessDenied() public;
```

### test_HandleOperations4626Deposit_RevertsWhenStrategyPaused()

- **Signature**: `test_HandleOperations4626Deposit_RevertsWhenStrategyPaused()`
- **Visibility**: public
- **Source Range**: 60941:837:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsWhenStrategyPaused.md](./function_test_HandleOperations4626Deposit_RevertsWhenStrategyPaused.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when strategy is paused
///  @dev Covers SuperVaultStrategy.sol:167 -> 1091 - STRATEGY_PAUSED validation
function test_HandleOperations4626Deposit_RevertsWhenStrategyPaused() public;
```

### test_HandleOperations4626Deposit_RevertsWhenPPSStale()

- **Signature**: `test_HandleOperations4626Deposit_RevertsWhenPPSStale()`
- **Visibility**: public
- **Source Range**: 61938:1095:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsWhenPPSStale.md](./function_test_HandleOperations4626Deposit_RevertsWhenPPSStale.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when PPS is stale
///  @dev Covers SuperVaultStrategy.sol:167 -> 1092 - STALE_PPS validation
function test_HandleOperations4626Deposit_RevertsWhenPPSStale() public;
```

### test_HandleOperations4626Deposit_RevertsWhenPPSExpired()

- **Signature**: `test_HandleOperations4626Deposit_RevertsWhenPPSExpired()`
- **Visibility**: public
- **Source Range**: 63233:976:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsWhenPPSExpired.md](./function_test_HandleOperations4626Deposit_RevertsWhenPPSExpired.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when PPS has not been updated within ppsExpiration time
///  @dev Covers SuperVaultStrategy.sol:167 -> 1093 - PPS_EXPIRED validation
function test_HandleOperations4626Deposit_RevertsWhenPPSExpired() public;
```

### test_HandleOperations4626Deposit_RevertsOnZeroRecipientAtRuntime()

- **Signature**: `test_HandleOperations4626Deposit_RevertsOnZeroRecipientAtRuntime()`
- **Visibility**: public
- **Source Range**: 64396:2744:660
- **Details**: [function_test_HandleOperations4626Deposit_RevertsOnZeroRecipientAtRuntime.md](./function_test_HandleOperations4626Deposit_RevertsOnZeroRecipientAtRuntime.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Deposit reverts when recipient is address(0) at runtime
///  @dev Covers SuperVaultStrategy.sol:178 - defensive check for fee recipient
function test_HandleOperations4626Deposit_RevertsOnZeroRecipientAtRuntime() public;
```

### test_HandleOperations4626Mint_RevertsOnZeroShares()

- **Signature**: `test_HandleOperations4626Mint_RevertsOnZeroShares()`
- **Visibility**: public
- **Source Range**: 67445:572:660
- **Details**: [function_test_HandleOperations4626Mint_RevertsOnZeroShares.md](./function_test_HandleOperations4626Mint_RevertsOnZeroShares.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Mint reverts when sharesNet is 0
///  @dev Covers SuperVaultStrategy.sol:206
function test_HandleOperations4626Mint_RevertsOnZeroShares() public;
```

### test_HandleOperations4626Mint_RevertsOnZeroAddressController()

- **Signature**: `test_HandleOperations4626Mint_RevertsOnZeroAddressController()`
- **Visibility**: public
- **Source Range**: 68155:532:660
- **Details**: [function_test_HandleOperations4626Mint_RevertsOnZeroAddressController.md](./function_test_HandleOperations4626Mint_RevertsOnZeroAddressController.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Mint reverts when controller is address(0)
///  @dev Covers SuperVaultStrategy.sol:207
function test_HandleOperations4626Mint_RevertsOnZeroAddressController() public;
```

### test_HandleOperations4626Mint_RevertsWhenGlobalHooksVetoed()

- **Signature**: `test_HandleOperations4626Mint_RevertsWhenGlobalHooksVetoed()`
- **Visibility**: public
- **Source Range**: 68832:1083:660
- **Details**: [function_test_HandleOperations4626Mint_RevertsWhenGlobalHooksVetoed.md](./function_test_HandleOperations4626Mint_RevertsWhenGlobalHooksVetoed.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Mint reverts when global hooks root is vetoed
///  @dev Covers SuperVaultStrategy.sol:211-213
function test_HandleOperations4626Mint_RevertsWhenGlobalHooksVetoed() public;
```

### test_HandleOperations4626Mint_ProcessesFeesCorrectly()

- **Signature**: `test_HandleOperations4626Mint_ProcessesFeesCorrectly()`
- **Visibility**: public
- **Source Range**: 70089:1574:660
- **Details**: [function_test_HandleOperations4626Mint_ProcessesFeesCorrectly.md](./function_test_HandleOperations4626Mint_ProcessesFeesCorrectly.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Mint successfully processes fees when feeBps != 0
///  @dev Covers SuperVaultStrategy.sol:219-227 - the fee transfer block
function test_HandleOperations4626Mint_ProcessesFeesCorrectly() public;
```

### test_HandleOperations4626Mint_RevertsOnAccessDenied()

- **Signature**: `test_HandleOperations4626Mint_RevertsOnAccessDenied()`
- **Visibility**: public
- **Source Range**: 71828:416:660
- **Details**: [function_test_HandleOperations4626Mint_RevertsOnAccessDenied.md](./function_test_HandleOperations4626Mint_RevertsOnAccessDenied.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Mint reverts when called by non-vault address
///  @dev Covers SuperVaultStrategy.sol:204 - _requireVault() check
function test_HandleOperations4626Mint_RevertsOnAccessDenied() public;
```

### test_HandleOperations4626Mint_RevertsWhenStrategyPaused()

- **Signature**: `test_HandleOperations4626Mint_RevertsWhenStrategyPaused()`
- **Visibility**: public
- **Source Range**: 72413:678:660
- **Details**: [function_test_HandleOperations4626Mint_RevertsWhenStrategyPaused.md](./function_test_HandleOperations4626Mint_RevertsWhenStrategyPaused.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Mint reverts when strategy is paused
///  @dev Covers SuperVaultStrategy.sol:215 -> 1091 - STRATEGY_PAUSED validation
function test_HandleOperations4626Mint_RevertsWhenStrategyPaused() public;
```

### test_HandleOperations4626Mint_RevertsWhenPPSStale()

- **Signature**: `test_HandleOperations4626Mint_RevertsWhenPPSStale()`
- **Visibility**: public
- **Source Range**: 73248:789:660
- **Details**: [function_test_HandleOperations4626Mint_RevertsWhenPPSStale.md](./function_test_HandleOperations4626Mint_RevertsWhenPPSStale.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Mint reverts when PPS is stale
///  @dev Covers SuperVaultStrategy.sol:215 -> 1092 - STALE_PPS validation
function test_HandleOperations4626Mint_RevertsWhenPPSStale() public;
```

### test_HandleOperations4626Mint_RevertsWhenPPSExpired()

- **Signature**: `test_HandleOperations4626Mint_RevertsWhenPPSExpired()`
- **Visibility**: public
- **Source Range**: 74199:662:660
- **Details**: [function_test_HandleOperations4626Mint_RevertsWhenPPSExpired.md](./function_test_HandleOperations4626Mint_RevertsWhenPPSExpired.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Mint reverts when PPS has expired
///  @dev Covers SuperVaultStrategy.sol:215 -> 1093 - PPS_EXPIRED validation
function test_HandleOperations4626Mint_RevertsWhenPPSExpired() public;
```

### test_HandleOperations4626Mint_RevertsOnZeroRecipientInFeeBlock()

- **Signature**: `test_HandleOperations4626Mint_RevertsOnZeroRecipientInFeeBlock()`
- **Visibility**: public
- **Source Range**: 75054:1915:660
- **Details**: [function_test_HandleOperations4626Mint_RevertsOnZeroRecipientInFeeBlock.md](./function_test_HandleOperations4626Mint_RevertsOnZeroRecipientInFeeBlock.md)

**Signature:**
```solidity
/// @notice Tests handleOperations4626Mint reverts when recipient is address(0) in fee block
///  @dev Covers SuperVaultStrategy.sol:223 - recipient validation inside fee transfer
function test_HandleOperations4626Mint_RevertsOnZeroRecipientInFeeBlock() public;
```

### test_QuoteMintAssetsGross_RevertsOnZeroPPS()

- **Signature**: `test_QuoteMintAssetsGross_RevertsOnZeroPPS()`
- **Visibility**: public
- **Source Range**: 77260:656:660
- **Details**: [function_test_QuoteMintAssetsGross_RevertsOnZeroPPS.md](./function_test_QuoteMintAssetsGross_RevertsOnZeroPPS.md)

**Signature:**
```solidity
/// @notice Tests quoteMintAssetsGross reverts when PPS is 0
///  @dev Covers SuperVaultStrategy.sol:237
function test_QuoteMintAssetsGross_RevertsOnZeroPPS() public;
```

### test_QuoteMintAssetsGross_RevertsOnZeroAssetsNet()

- **Signature**: `test_QuoteMintAssetsGross_RevertsOnZeroAssetsNet()`
- **Visibility**: public
- **Source Range**: 78047:1166:660
- **Details**: [function_test_QuoteMintAssetsGross_RevertsOnZeroAssetsNet.md](./function_test_QuoteMintAssetsGross_RevertsOnZeroAssetsNet.md)

**Signature:**
```solidity
/// @notice Tests quoteMintAssetsGross reverts when assetsNet rounds to 0
///  @dev Covers SuperVaultStrategy.sol:239
function test_QuoteMintAssetsGross_RevertsOnZeroAssetsNet() public;
```

### test_QuoteMintAssetsGross_ZeroFees()

- **Signature**: `test_QuoteMintAssetsGross_ZeroFees()`
- **Visibility**: public
- **Source Range**: 79377:784:660
- **Details**: [function_test_QuoteMintAssetsGross_ZeroFees.md](./function_test_QuoteMintAssetsGross_ZeroFees.md)

**Signature:**
```solidity
/// @notice Tests quoteMintAssetsGross returns correct values when feeBps is 0
///  @dev Covers SuperVaultStrategy.sol:242 - early return when no fees
function test_QuoteMintAssetsGross_ZeroFees() public view;
```

### test_QuoteMintAssetsGross_RevertsOnInvalidFeeBps()

- **Signature**: `test_QuoteMintAssetsGross_RevertsOnInvalidFeeBps()`
- **Visibility**: public
- **Source Range**: 80294:1138:660
- **Details**: [function_test_QuoteMintAssetsGross_RevertsOnInvalidFeeBps.md](./function_test_QuoteMintAssetsGross_RevertsOnInvalidFeeBps.md)

**Signature:**
```solidity
/// @notice Tests quoteMintAssetsGross reverts when feeBps >= BPS_PRECISION
///  @dev Covers SuperVaultStrategy.sol:243
function test_QuoteMintAssetsGross_RevertsOnInvalidFeeBps() public;
```

### test_QuoteMintAssetsGross_WithFees()

- **Signature**: `test_QuoteMintAssetsGross_WithFees()`
- **Visibility**: public
- **Source Range**: 81606:2397:660
- **Details**: [function_test_QuoteMintAssetsGross_WithFees.md](./function_test_QuoteMintAssetsGross_WithFees.md)

**Signature:**
```solidity
/// @notice Tests quoteMintAssetsGross calculates correct values with non-zero fees
///  @dev Covers SuperVaultStrategy.sol:244-245 - fee calculation and return
function test_QuoteMintAssetsGross_WithFees() public;
```

### test_QuoteMintAssetsGross_VariousFees()

- **Signature**: `test_QuoteMintAssetsGross_VariousFees()`
- **Visibility**: public
- **Source Range**: 84146:1832:660
- **Details**: [function_test_QuoteMintAssetsGross_VariousFees.md](./function_test_QuoteMintAssetsGross_VariousFees.md)

**Signature:**
```solidity
/// @notice Tests quoteMintAssetsGross with various fee percentages
///  @dev Covers edge cases and validates formula correctness
function test_QuoteMintAssetsGross_VariousFees() public;
```

### test_ExecuteHooks_RevertsOnZeroLength()

- **Signature**: `test_ExecuteHooks_RevertsOnZeroLength()`
- **Visibility**: public
- **Source Range**: 86265:633:660
- **Details**: [function_test_ExecuteHooks_RevertsOnZeroLength.md](./function_test_ExecuteHooks_RevertsOnZeroLength.md)

**Signature:**
```solidity
/// @notice Tests executeHooks reverts when hooks array is empty
///  @dev Covers SuperVaultStrategy.sol:275
function test_ExecuteHooks_RevertsOnZeroLength() public;
```

### test_ExecuteHooks_RevertsOnHookCalldataLengthMismatch()

- **Signature**: `test_ExecuteHooks_RevertsOnHookCalldataLengthMismatch()`
- **Visibility**: public
- **Source Range**: 87046:1071:660
- **Details**: [function_test_ExecuteHooks_RevertsOnHookCalldataLengthMismatch.md](./function_test_ExecuteHooks_RevertsOnHookCalldataLengthMismatch.md)

**Signature:**
```solidity
/// @notice Tests executeHooks reverts when hookCalldata length doesn't match hooks length
///  @dev Covers SuperVaultStrategy.sol:276
function test_ExecuteHooks_RevertsOnHookCalldataLengthMismatch() public;
```

### test_ExecuteHooks_RevertsOnExpectedAssetsLengthMismatch()

- **Signature**: `test_ExecuteHooks_RevertsOnExpectedAssetsLengthMismatch()`
- **Visibility**: public
- **Source Range**: 88278:1116:660
- **Details**: [function_test_ExecuteHooks_RevertsOnExpectedAssetsLengthMismatch.md](./function_test_ExecuteHooks_RevertsOnExpectedAssetsLengthMismatch.md)

**Signature:**
```solidity
/// @notice Tests executeHooks reverts when expectedAssetsOrSharesOut length doesn't match hooks length
///  @dev Covers SuperVaultStrategy.sol:277
function test_ExecuteHooks_RevertsOnExpectedAssetsLengthMismatch() public;
```

### test_ExecuteHooks_RevertsOnGlobalProofsLengthMismatch()

- **Signature**: `test_ExecuteHooks_RevertsOnGlobalProofsLengthMismatch()`
- **Visibility**: public
- **Source Range**: 89542:1101:660
- **Details**: [function_test_ExecuteHooks_RevertsOnGlobalProofsLengthMismatch.md](./function_test_ExecuteHooks_RevertsOnGlobalProofsLengthMismatch.md)

**Signature:**
```solidity
/// @notice Tests executeHooks reverts when globalProofs length doesn't match hooks length
///  @dev Covers SuperVaultStrategy.sol:278
function test_ExecuteHooks_RevertsOnGlobalProofsLengthMismatch() public;
```

### test_ExecuteHooks_RevertsOnStrategyProofsLengthMismatch()

- **Signature**: `test_ExecuteHooks_RevertsOnStrategyProofsLengthMismatch()`
- **Visibility**: public
- **Source Range**: 90793:1105:660
- **Details**: [function_test_ExecuteHooks_RevertsOnStrategyProofsLengthMismatch.md](./function_test_ExecuteHooks_RevertsOnStrategyProofsLengthMismatch.md)

**Signature:**
```solidity
/// @notice Tests executeHooks reverts when strategyProofs length doesn't match hooks length
///  @dev Covers SuperVaultStrategy.sol:279
function test_ExecuteHooks_RevertsOnStrategyProofsLengthMismatch() public;
```

### test_ExecuteHooks_RevertsOnInvalidHook()

- **Signature**: `test_ExecuteHooks_RevertsOnInvalidHook()`
- **Visibility**: public
- **Source Range**: 91977:1174:660
- **Details**: [function_test_ExecuteHooks_RevertsOnInvalidHook.md](./function_test_ExecuteHooks_RevertsOnInvalidHook.md)

**Signature:**
```solidity
/// @notice Tests executeHooks reverts when a hook is not registered
function test_ExecuteHooks_RevertsOnInvalidHook() public;
```

### test_FulfillRedeemRequests_RevertsOnEmptyControllersArray()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnEmptyControllersArray()`
- **Visibility**: public
- **Source Range**: 93483:490:660
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnEmptyControllersArray.md](./function_test_FulfillRedeemRequests_RevertsOnEmptyControllersArray.md)

**Signature:**
```solidity
/// @notice Tests fulfillRedeemRequests reverts when controllers array is empty
///  @dev Covers SuperVaultStrategy.sol:329 (len == 0 condition)
function test_FulfillRedeemRequests_RevertsOnEmptyControllersArray() public;
```

### test_FulfillRedeemRequests_RevertsOnArrayLengthMismatch()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnArrayLengthMismatch()`
- **Visibility**: public
- **Source Range**: 94150:694:660
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnArrayLengthMismatch.md](./function_test_FulfillRedeemRequests_RevertsOnArrayLengthMismatch.md)

**Signature:**
```solidity
/// @notice Tests fulfillRedeemRequests reverts when array lengths don't match
///  @dev Covers SuperVaultStrategy.sol:329 (totalAssetsOut.length != len condition)
function test_FulfillRedeemRequests_RevertsOnArrayLengthMismatch() public;
```

### test_FulfillRedeemRequests_RevertsOnZeroPPS()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnZeroPPS()`
- **Visibility**: public
- **Source Range**: 94963:1285:660
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnZeroPPS.md](./function_test_FulfillRedeemRequests_RevertsOnZeroPPS.md)

**Signature:**
```solidity
/// @notice Tests fulfillRedeemRequests reverts when PPS is 0
///  @dev Covers SuperVaultStrategy.sol:333
function test_FulfillRedeemRequests_RevertsOnZeroPPS() public;
```

### test_FulfillRedeemRequests_RevertsOnControllersNotSorted()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnControllersNotSorted()`
- **Visibility**: public
- **Source Range**: 96450:1871:660
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnControllersNotSorted.md](./function_test_FulfillRedeemRequests_RevertsOnControllersNotSorted.md)

**Signature:**
```solidity
/// @notice Tests fulfillRedeemRequests reverts when controllers are not sorted in ascending order
///  @dev Covers SuperVaultStrategy.sol:338 (controllers[i] < controllers[i-1] condition)
function test_FulfillRedeemRequests_RevertsOnControllersNotSorted() public;
```

### test_FulfillRedeemRequests_RevertsOnDuplicateControllers()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnDuplicateControllers()`
- **Visibility**: public
- **Source Range**: 99006:2342:660
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnDuplicateControllers.md](./function_test_FulfillRedeemRequests_RevertsOnDuplicateControllers.md)

**Signature:**
```solidity
/// @notice Tests fulfillRedeemRequests reverts when controllers array contains duplicates
///  @dev Covers SuperVaultStrategy.sol:338 (controllers[i] == controllers[i-1] condition)
///  @dev Note: The `<=` operator in the check covers both `<` (not sorted) and `==` (duplicate) cases.
///       Since we successfully test the "not sorted" case above, and `<=` inherently includes `==`,
///       this test demonstrates that the same validation catches duplicates. Due to state modifications
///       in the loop (pendingRedeemRequest reset to 0 after fulfillment), we verify the validation
///       catches duplicates before any other processing occurs.
function test_FulfillRedeemRequests_RevertsOnDuplicateControllers() public;
```

### test_FulfillRedeemRequests_RevertsOnInsufficientLiquidity()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnInsufficientLiquidity()`
- **Visibility**: public
- **Source Range**: 101498:1794:660
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnInsufficientLiquidity.md](./function_test_FulfillRedeemRequests_RevertsOnInsufficientLiquidity.md)

**Signature:**
```solidity
/// @notice Tests fulfillRedeemRequests reverts when strategy has insufficient liquidity
///  @dev Covers SuperVaultStrategy.sol:354-355
function test_FulfillRedeemRequests_RevertsOnInsufficientLiquidity() public;
```

### test_FulfillRedeemRequests_RevertsOnTotalAssetsOutBelowMinimum()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnTotalAssetsOutBelowMinimum()`
- **Visibility**: public
- **Source Range**: 103493:1468:660
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnTotalAssetsOutBelowMinimum.md](./function_test_FulfillRedeemRequests_RevertsOnTotalAssetsOutBelowMinimum.md)

**Signature:**
```solidity
/// @notice Tests fulfillRedeemRequests reverts when totalAssetsOut is below minimum (slippage bound)
///  @dev Covers SuperVaultStrategy.sol:786 (totalAssetsOut < minAssetsOut condition)
function test_FulfillRedeemRequests_RevertsOnTotalAssetsOutBelowMinimum() public;
```

### test_FulfillRedeemRequests_RevertsOnTotalAssetsOutAboveTheoretical()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnTotalAssetsOutAboveTheoretical()`
- **Visibility**: public
- **Source Range**: 105161:1394:660
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnTotalAssetsOutAboveTheoretical.md](./function_test_FulfillRedeemRequests_RevertsOnTotalAssetsOutAboveTheoretical.md)

**Signature:**
```solidity
/// @notice Tests fulfillRedeemRequests reverts when totalAssetsOut exceeds theoretical maximum
///  @dev Covers SuperVaultStrategy.sol:786 (totalAssetsOut > theoreticalAssets condition)
function test_FulfillRedeemRequests_RevertsOnTotalAssetsOutAboveTheoretical() public;
```

### test_SkimPerformanceFee_RevertsOnZeroPPS()

- **Signature**: `test_SkimPerformanceFee_RevertsOnZeroPPS()`
- **Visibility**: public
- **Source Range**: 106842:1631:660
- **Details**: [function_test_SkimPerformanceFee_RevertsOnZeroPPS.md](./function_test_SkimPerformanceFee_RevertsOnZeroPPS.md)

**Signature:**
```solidity
/// @notice Tests skimPerformanceFee reverts when PPS is 0
///  @dev Covers SuperVaultStrategy.sol:394
function test_SkimPerformanceFee_RevertsOnZeroPPS() public;
```

### test_SkimPerformanceFee_RevertsOnInsufficientFreeAssets()

- **Signature**: `test_SkimPerformanceFee_RevertsOnInsufficientFreeAssets()`
- **Visibility**: public
- **Source Range**: 108621:2337:660
- **Details**: [function_test_SkimPerformanceFee_RevertsOnInsufficientFreeAssets.md](./function_test_SkimPerformanceFee_RevertsOnInsufficientFreeAssets.md)

**Signature:**
```solidity
/// @notice Tests skimPerformanceFee reverts when strategy doesn't have enough free assets
///  @dev Covers SuperVaultStrategy.sol:427
function test_SkimPerformanceFee_RevertsOnInsufficientFreeAssets() public;
```

### test_ManageYieldSources_RevertsOnNonPrimaryManager()

- **Signature**: `test_ManageYieldSources_RevertsOnNonPrimaryManager()`
- **Visibility**: public
- **Source Range**: 111683:687:660
- **Details**: [function_test_ManageYieldSources_RevertsOnNonPrimaryManager.md](./function_test_ManageYieldSources_RevertsOnNonPrimaryManager.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSources reverts when caller is not primary manager
///  @dev Covers SuperVaultStrategy.sol:474 (_isPrimaryManager check)
function test_ManageYieldSources_RevertsOnNonPrimaryManager() public;
```

### test_ManageYieldSource_RevertsOnNonPrimaryManager()

- **Signature**: `test_ManageYieldSource_RevertsOnNonPrimaryManager()`
- **Visibility**: public
- **Source Range**: 112543:363:660
- **Details**: [function_test_ManageYieldSource_RevertsOnNonPrimaryManager.md](./function_test_ManageYieldSource_RevertsOnNonPrimaryManager.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSource (singular) reverts when caller is not primary manager
///  @dev Covers SuperVaultStrategy.sol:462 (_isPrimaryManager check)
function test_ManageYieldSource_RevertsOnNonPrimaryManager() public;
```

### test_ManageYieldSources_RevertsOnZeroLength()

- **Signature**: `test_ManageYieldSources_RevertsOnZeroLength()`
- **Visibility**: public
- **Source Range**: 113036:577:660
- **Details**: [function_test_ManageYieldSources_RevertsOnZeroLength.md](./function_test_ManageYieldSources_RevertsOnZeroLength.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSources reverts when sources array is empty
///  @dev Covers SuperVaultStrategy.sol:477
function test_ManageYieldSources_RevertsOnZeroLength() public;
```

### test_ManageYieldSources_RevertsOnOraclesLengthMismatch()

- **Signature**: `test_ManageYieldSources_RevertsOnOraclesLengthMismatch()`
- **Visibility**: public
- **Source Range**: 113763:900:660
- **Details**: [function_test_ManageYieldSources_RevertsOnOraclesLengthMismatch.md](./function_test_ManageYieldSources_RevertsOnOraclesLengthMismatch.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSources reverts when oracles array length doesn't match sources
///  @dev Covers SuperVaultStrategy.sol:478
function test_ManageYieldSources_RevertsOnOraclesLengthMismatch() public;
```

### test_ManageYieldSources_RevertsOnActionTypesLengthMismatch()

- **Signature**: `test_ManageYieldSources_RevertsOnActionTypesLengthMismatch()`
- **Visibility**: public
- **Source Range**: 114817:1031:660
- **Details**: [function_test_ManageYieldSources_RevertsOnActionTypesLengthMismatch.md](./function_test_ManageYieldSources_RevertsOnActionTypesLengthMismatch.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSources reverts when actionTypes array length doesn't match sources
///  @dev Covers SuperVaultStrategy.sol:479
function test_ManageYieldSources_RevertsOnActionTypesLengthMismatch() public;
```

### test_ManageYieldSource_RevertsOnZeroAddressSource()

- **Signature**: `test_ManageYieldSource_RevertsOnZeroAddressSource()`
- **Visibility**: public
- **Source Range**: 116026:391:660
- **Details**: [function_test_ManageYieldSource_RevertsOnZeroAddressSource.md](./function_test_ManageYieldSource_RevertsOnZeroAddressSource.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSource reverts when adding with source = address(0)
///  @dev Covers SuperVaultStrategy.sol:853 - ZERO_ADDRESS check in _addYieldSource
function test_ManageYieldSource_RevertsOnZeroAddressSource() public;
```

### test_ManageYieldSource_RevertsOnZeroAddressOracle_Add()

- **Signature**: `test_ManageYieldSource_RevertsOnZeroAddressOracle_Add()`
- **Visibility**: public
- **Source Range**: 116595:405:660
- **Details**: [function_test_ManageYieldSource_RevertsOnZeroAddressOracle_Add.md](./function_test_ManageYieldSource_RevertsOnZeroAddressOracle_Add.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSource reverts when adding with oracle = address(0)
///  @dev Covers SuperVaultStrategy.sol:853 - ZERO_ADDRESS check in _addYieldSource
function test_ManageYieldSource_RevertsOnZeroAddressOracle_Add() public;
```

### test_ManageYieldSource_RevertsOnDuplicateSource()

- **Signature**: `test_ManageYieldSource_RevertsOnDuplicateSource()`
- **Visibility**: public
- **Source Range**: 117191:628:660
- **Details**: [function_test_ManageYieldSource_RevertsOnDuplicateSource.md](./function_test_ManageYieldSource_RevertsOnDuplicateSource.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSource reverts when adding duplicate yield source
///  @dev Covers SuperVaultStrategy.sol:854 - YIELD_SOURCE_ALREADY_EXISTS check in _addYieldSource
function test_ManageYieldSource_RevertsOnDuplicateSource() public;
```

### test_ManageYieldSource_RevertsOnZeroAddressOracle_Update()

- **Signature**: `test_ManageYieldSource_RevertsOnZeroAddressOracle_Update()`
- **Visibility**: public
- **Source Range**: 118008:627:660
- **Details**: [function_test_ManageYieldSource_RevertsOnZeroAddressOracle_Update.md](./function_test_ManageYieldSource_RevertsOnZeroAddressOracle_Update.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSource reverts when updating with oracle = address(0)
///  @dev Covers SuperVaultStrategy.sol:865 - ZERO_ADDRESS check in _updateYieldSourceOracle
function test_ManageYieldSource_RevertsOnZeroAddressOracle_Update() public;
```

### test_ManageYieldSource_RevertsOnNonExistentSource_Update()

- **Signature**: `test_ManageYieldSource_RevertsOnNonExistentSource_Update()`
- **Visibility**: public
- **Source Range**: 118835:473:660
- **Details**: [function_test_ManageYieldSource_RevertsOnNonExistentSource_Update.md](./function_test_ManageYieldSource_RevertsOnNonExistentSource_Update.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSource reverts when updating non-existent yield source
///  @dev Covers SuperVaultStrategy.sol:867 - YIELD_SOURCE_NOT_FOUND check in _updateYieldSourceOracle
function test_ManageYieldSource_RevertsOnNonExistentSource_Update() public;
```

### test_ManageYieldSource_RevertsOnNonExistentSource_Remove()

- **Signature**: `test_ManageYieldSource_RevertsOnNonExistentSource_Remove()`
- **Visibility**: public
- **Source Range**: 119502:423:660
- **Details**: [function_test_ManageYieldSource_RevertsOnNonExistentSource_Remove.md](./function_test_ManageYieldSource_RevertsOnNonExistentSource_Remove.md)

**Signature:**
```solidity
/// @notice Tests manageYieldSource reverts when removing non-existent yield source
///  @dev Covers SuperVaultStrategy.sol:876 - YIELD_SOURCE_NOT_FOUND check in _removeYieldSource
function test_ManageYieldSource_RevertsOnNonExistentSource_Remove() public;
```

### test_ManageYieldSource_RevertsOnEnumerableSetAddFailure()

- **Signature**: `test_ManageYieldSource_RevertsOnEnumerableSetAddFailure()`
- **Visibility**: public
- **Source Range**: 120228:2322:660
- **Details**: [function_test_ManageYieldSource_RevertsOnEnumerableSetAddFailure.md](./function_test_ManageYieldSource_RevertsOnEnumerableSetAddFailure.md)

**Signature:**
```solidity
/// @notice Tests _addYieldSource reverts when EnumerableSet.add() fails (defensive check)
///  @dev Covers SuperVaultStrategy.sol:856 - EnumerableSet consistency check in _addYieldSource
///  @dev This tests inconsistent state where mapping is cleared but set still contains the source
function test_ManageYieldSource_RevertsOnEnumerableSetAddFailure() public;
```

### test_ManageYieldSource_RevertsOnEnumerableSetRemoveFailure()

- **Signature**: `test_ManageYieldSource_RevertsOnEnumerableSetRemoveFailure()`
- **Visibility**: public
- **Source Range**: 122862:1979:660
- **Details**: [function_test_ManageYieldSource_RevertsOnEnumerableSetRemoveFailure.md](./function_test_ManageYieldSource_RevertsOnEnumerableSetRemoveFailure.md)

**Signature:**
```solidity
/// @notice Tests _removeYieldSource reverts when EnumerableSet.remove() fails (defensive check)
///  @dev Covers SuperVaultStrategy.sol:882 - EnumerableSet consistency check in _removeYieldSource
///  @dev This tests inconsistent state where mapping has value but set doesn't contain the source
function test_ManageYieldSource_RevertsOnEnumerableSetRemoveFailure() public;
```

### test_ProposeVaultFeeConfigUpdate_RevertsOnNonPrimaryManager()

- **Signature**: `test_ProposeVaultFeeConfigUpdate_RevertsOnNonPrimaryManager()`
- **Visibility**: public
- **Source Range**: 125183:326:660
- **Details**: [function_test_ProposeVaultFeeConfigUpdate_RevertsOnNonPrimaryManager.md](./function_test_ProposeVaultFeeConfigUpdate_RevertsOnNonPrimaryManager.md)

**Signature:**
```solidity
/// @notice Tests proposeVaultFeeConfigUpdate reverts when caller is not primary manager
///  @dev Covers SuperVaultStrategy.sol:494 (_isPrimaryManager check)
function test_ProposeVaultFeeConfigUpdate_RevertsOnNonPrimaryManager() public;
```

### test_ExecuteVaultFeeConfigUpdate_RevertsOnNonPrimaryManager()

- **Signature**: `test_ExecuteVaultFeeConfigUpdate_RevertsOnNonPrimaryManager()`
- **Visibility**: public
- **Source Range**: 125681:643:660
- **Details**: [function_test_ExecuteVaultFeeConfigUpdate_RevertsOnNonPrimaryManager.md](./function_test_ExecuteVaultFeeConfigUpdate_RevertsOnNonPrimaryManager.md)

**Signature:**
```solidity
/// @notice Tests executeVaultFeeConfigUpdate reverts when caller is not primary manager
///  @dev Covers SuperVaultStrategy.sol:508 (_isPrimaryManager check)
function test_ExecuteVaultFeeConfigUpdate_RevertsOnNonPrimaryManager() public;
```

### test_ExecuteVaultFeeConfigUpdate_RevertsOnInvalidTimestamp()

- **Signature**: `test_ExecuteVaultFeeConfigUpdate_RevertsOnInvalidTimestamp()`
- **Visibility**: public
- **Source Range**: 126469:1441:660
- **Details**: [function_test_ExecuteVaultFeeConfigUpdate_RevertsOnInvalidTimestamp.md](./function_test_ExecuteVaultFeeConfigUpdate_RevertsOnInvalidTimestamp.md)

**Signature:**
```solidity
/// @notice Tests executeVaultFeeConfigUpdate reverts when called before effective time
///  @dev Covers SuperVaultStrategy.sol:510
function test_ExecuteVaultFeeConfigUpdate_RevertsOnInvalidTimestamp() public;
```

### test_ExecuteVaultFeeConfigUpdate_RevertsOnZeroAddressRecipient()

- **Signature**: `test_ExecuteVaultFeeConfigUpdate_RevertsOnZeroAddressRecipient()`
- **Visibility**: public
- **Source Range**: 128162:1701:660
- **Details**: [function_test_ExecuteVaultFeeConfigUpdate_RevertsOnZeroAddressRecipient.md](./function_test_ExecuteVaultFeeConfigUpdate_RevertsOnZeroAddressRecipient.md)

**Signature:**
```solidity
/// @notice Tests executeVaultFeeConfigUpdate reverts when proposed recipient is zero address
///  @dev Covers SuperVaultStrategy.sol:511
///  @dev This is a defensive check since proposeFeeConfigUpdate already validates recipient != 0
function test_ExecuteVaultFeeConfigUpdate_RevertsOnZeroAddressRecipient() public;
```

### test_ProposePPSExpiration_RevertsOnNonManager()

- **Signature**: `test_ProposePPSExpiration_RevertsOnNonManager()`
- **Visibility**: public
- **Source Range**: 130346:341:660
- **Details**: [function_test_ProposePPSExpiration_RevertsOnNonManager.md](./function_test_ProposePPSExpiration_RevertsOnNonManager.md)

**Signature:**
```solidity
/// @notice Tests proposePPSExpiration reverts when caller is not manager
///  @dev Covers SuperVaultStrategy.sol:890
function test_ProposePPSExpiration_RevertsOnNonManager() public;
```

### test_ProposePPSExpiration_RevertsOnThresholdTooLow()

- **Signature**: `test_ProposePPSExpiration_RevertsOnThresholdTooLow()`
- **Visibility**: public
- **Source Range**: 130865:363:660
- **Details**: [function_test_ProposePPSExpiration_RevertsOnThresholdTooLow.md](./function_test_ProposePPSExpiration_RevertsOnThresholdTooLow.md)

**Signature:**
```solidity
/// @notice Tests proposePPSExpiration reverts when threshold is below minimum
///  @dev Covers SuperVaultStrategy.sol:892 - MIN_PPS_EXPIRATION_THRESHOLD = 1 minute
function test_ProposePPSExpiration_RevertsOnThresholdTooLow() public;
```

### test_ProposePPSExpiration_RevertsOnThresholdTooHigh()

- **Signature**: `test_ProposePPSExpiration_RevertsOnThresholdTooHigh()`
- **Visibility**: public
- **Source Range**: 131404:360:660
- **Details**: [function_test_ProposePPSExpiration_RevertsOnThresholdTooHigh.md](./function_test_ProposePPSExpiration_RevertsOnThresholdTooHigh.md)

**Signature:**
```solidity
/// @notice Tests proposePPSExpiration reverts when threshold is above maximum
///  @dev Covers SuperVaultStrategy.sol:892 - MAX_PPS_EXPIRATION_THRESHOLD = 1 week
function test_ProposePPSExpiration_RevertsOnThresholdTooHigh() public;
```

### test_ProposePPSExpiration_SucceedsWithValidThreshold()

- **Signature**: `test_ProposePPSExpiration_SucceedsWithValidThreshold()`
- **Visibility**: public
- **Source Range**: 131894:320:660
- **Details**: [function_test_ProposePPSExpiration_SucceedsWithValidThreshold.md](./function_test_ProposePPSExpiration_SucceedsWithValidThreshold.md)

**Signature:**
```solidity
/// @notice Tests proposePPSExpiration succeeds with valid threshold
///  @dev Covers SuperVaultStrategy.sol:897-898
function test_ProposePPSExpiration_SucceedsWithValidThreshold() public;
```

### test_ProposePPSExpiration_SucceedsWithMinimumThreshold()

- **Signature**: `test_ProposePPSExpiration_SucceedsWithMinimumThreshold()`
- **Visibility**: public
- **Source Range**: 132357:307:660
- **Details**: [function_test_ProposePPSExpiration_SucceedsWithMinimumThreshold.md](./function_test_ProposePPSExpiration_SucceedsWithMinimumThreshold.md)

**Signature:**
```solidity
/// @notice Tests proposePPSExpiration succeeds with minimum threshold
///  @dev Covers edge case at MIN_PPS_EXPIRATION_THRESHOLD
function test_ProposePPSExpiration_SucceedsWithMinimumThreshold() public;
```

### test_ProposePPSExpiration_SucceedsWithMaximumThreshold()

- **Signature**: `test_ProposePPSExpiration_SucceedsWithMaximumThreshold()`
- **Visibility**: public
- **Source Range**: 132807:305:660
- **Details**: [function_test_ProposePPSExpiration_SucceedsWithMaximumThreshold.md](./function_test_ProposePPSExpiration_SucceedsWithMaximumThreshold.md)

**Signature:**
```solidity
/// @notice Tests proposePPSExpiration succeeds with maximum threshold
///  @dev Covers edge case at MAX_PPS_EXPIRATION_THRESHOLD
function test_ProposePPSExpiration_SucceedsWithMaximumThreshold() public;
```

### test_ProposePPSExpiration_RevertsOnZeroThreshold()

- **Signature**: `test_ProposePPSExpiration_RevertsOnZeroThreshold()`
- **Visibility**: public
- **Source Range**: 133276:275:660
- **Details**: [function_test_ProposePPSExpiration_RevertsOnZeroThreshold.md](./function_test_ProposePPSExpiration_RevertsOnZeroThreshold.md)

**Signature:**
```solidity
/// @notice Tests proposePPSExpiration reverts when threshold is zero
///  @dev Covers SuperVaultStrategy.sol:892 - explicit zero test for lower bound
function test_ProposePPSExpiration_RevertsOnZeroThreshold() public;
```

### test_ProposePPSExpiration_RevertsOnMinMinusOne()

- **Signature**: `test_ProposePPSExpiration_RevertsOnMinMinusOne()`
- **Visibility**: public
- **Source Range**: 133723:338:660
- **Details**: [function_test_ProposePPSExpiration_RevertsOnMinMinusOne.md](./function_test_ProposePPSExpiration_RevertsOnMinMinusOne.md)

**Signature:**
```solidity
/// @notice Tests proposePPSExpiration reverts when threshold is exactly MIN - 1
///  @dev Covers SuperVaultStrategy.sol:892 - boundary test at MIN - 1 second
function test_ProposePPSExpiration_RevertsOnMinMinusOne() public;
```

### test_ProposePPSExpiration_RevertsOnMaxPlusOne()

- **Signature**: `test_ProposePPSExpiration_RevertsOnMaxPlusOne()`
- **Visibility**: public
- **Source Range**: 134233:346:660
- **Details**: [function_test_ProposePPSExpiration_RevertsOnMaxPlusOne.md](./function_test_ProposePPSExpiration_RevertsOnMaxPlusOne.md)

**Signature:**
```solidity
/// @notice Tests proposePPSExpiration reverts when threshold is exactly MAX + 1
///  @dev Covers SuperVaultStrategy.sol:892 - boundary test at MAX + 1 second
function test_ProposePPSExpiration_RevertsOnMaxPlusOne() public;
```

### test_UpdatePPSExpiration_RevertsOnNonManager()

- **Signature**: `test_UpdatePPSExpiration_RevertsOnNonManager()`
- **Visibility**: public
- **Source Range**: 134892:385:660
- **Details**: [function_test_UpdatePPSExpiration_RevertsOnNonManager.md](./function_test_UpdatePPSExpiration_RevertsOnNonManager.md)

**Signature:**
```solidity
/// @notice Tests updatePPSExpiration reverts when caller is not manager
///  @dev Covers SuperVaultStrategy.sol:905
function test_UpdatePPSExpiration_RevertsOnNonManager() public;
```

### test_UpdatePPSExpiration_RevertsOnInvalidTimestamp()

- **Signature**: `test_UpdatePPSExpiration_RevertsOnInvalidTimestamp()`
- **Visibility**: public
- **Source Range**: 135414:555:660
- **Details**: [function_test_UpdatePPSExpiration_RevertsOnInvalidTimestamp.md](./function_test_UpdatePPSExpiration_RevertsOnInvalidTimestamp.md)

**Signature:**
```solidity
/// @notice Tests updatePPSExpiration reverts when called before effective time
///  @dev Covers SuperVaultStrategy.sol:908
function test_UpdatePPSExpiration_RevertsOnInvalidTimestamp() public;
```

### test_UpdatePPSExpiration_RevertsOnZeroProposedThreshold()

- **Signature**: `test_UpdatePPSExpiration_RevertsOnZeroProposedThreshold()`
- **Visibility**: public
- **Source Range**: 136096:768:660
- **Details**: [function_test_UpdatePPSExpiration_RevertsOnZeroProposedThreshold.md](./function_test_UpdatePPSExpiration_RevertsOnZeroProposedThreshold.md)

**Signature:**
```solidity
/// @notice Tests updatePPSExpiration reverts when no proposal exists
///  @dev Covers SuperVaultStrategy.sol:910
function test_UpdatePPSExpiration_RevertsOnZeroProposedThreshold() public;
```

### test_UpdatePPSExpiration_SucceedsAfterTimelock()

- **Signature**: `test_UpdatePPSExpiration_SucceedsAfterTimelock()`
- **Visibility**: public
- **Source Range**: 136994:506:660
- **Details**: [function_test_UpdatePPSExpiration_SucceedsAfterTimelock.md](./function_test_UpdatePPSExpiration_SucceedsAfterTimelock.md)

**Signature:**
```solidity
/// @notice Tests updatePPSExpiration succeeds after timelock passes
///  @dev Covers SuperVaultStrategy.sol:912-915
function test_UpdatePPSExpiration_SucceedsAfterTimelock() public;
```

### test_UpdatePPSExpiration_RevertsOnEffectiveTimeMinusOne()

- **Signature**: `test_UpdatePPSExpiration_RevertsOnEffectiveTimeMinusOne()`
- **Visibility**: public
- **Source Range**: 137683:718:660
- **Details**: [function_test_UpdatePPSExpiration_RevertsOnEffectiveTimeMinusOne.md](./function_test_UpdatePPSExpiration_RevertsOnEffectiveTimeMinusOne.md)

**Signature:**
```solidity
/// @notice Tests updatePPSExpiration reverts when timestamp is exactly effectiveTime - 1
///  @dev Covers SuperVaultStrategy.sol:908 - boundary test for timestamp check
function test_UpdatePPSExpiration_RevertsOnEffectiveTimeMinusOne() public;
```

### test_UpdatePPSExpiration_SucceedsAtExactEffectiveTime()

- **Signature**: `test_UpdatePPSExpiration_SucceedsAtExactEffectiveTime()`
- **Visibility**: public
- **Source Range**: 138581:654:660
- **Details**: [function_test_UpdatePPSExpiration_SucceedsAtExactEffectiveTime.md](./function_test_UpdatePPSExpiration_SucceedsAtExactEffectiveTime.md)

**Signature:**
```solidity
/// @notice Tests updatePPSExpiration succeeds when timestamp is exactly at effectiveTime
///  @dev Covers SuperVaultStrategy.sol:908 - boundary test (>= should pass)
function test_UpdatePPSExpiration_SucceedsAtExactEffectiveTime() public;
```

### test_UpdatePPSExpiration_SucceedsAtEffectiveTimePlusOne()

- **Signature**: `test_UpdatePPSExpiration_SucceedsAtEffectiveTimePlusOne()`
- **Visibility**: public
- **Source Range**: 139426:663:660
- **Details**: [function_test_UpdatePPSExpiration_SucceedsAtEffectiveTimePlusOne.md](./function_test_UpdatePPSExpiration_SucceedsAtEffectiveTimePlusOne.md)

**Signature:**
```solidity
/// @notice Tests updatePPSExpiration succeeds when timestamp is exactly effectiveTime + 1
///  @dev Covers SuperVaultStrategy.sol:908 - boundary test (just past effective time)
function test_UpdatePPSExpiration_SucceedsAtEffectiveTimePlusOne() public;
```

### test_CancelPPSExpirationProposal_RevertsOnNonManager()

- **Signature**: `test_CancelPPSExpirationProposal_RevertsOnNonManager()`
- **Visibility**: public
- **Source Range**: 140430:341:660
- **Details**: [function_test_CancelPPSExpirationProposal_RevertsOnNonManager.md](./function_test_CancelPPSExpirationProposal_RevertsOnNonManager.md)

**Signature:**
```solidity
/// @notice Tests cancelPPSExpirationProposalUpdate reverts when caller is not manager
///  @dev Covers SuperVaultStrategy.sol:922
function test_CancelPPSExpirationProposal_RevertsOnNonManager() public;
```

### test_CancelPPSExpirationProposal_RevertsOnNoProposal()

- **Signature**: `test_CancelPPSExpirationProposal_RevertsOnNoProposal()`
- **Visibility**: public
- **Source Range**: 140912:310:660
- **Details**: [function_test_CancelPPSExpirationProposal_RevertsOnNoProposal.md](./function_test_CancelPPSExpirationProposal_RevertsOnNoProposal.md)

**Signature:**
```solidity
/// @notice Tests cancelPPSExpirationProposalUpdate reverts when no proposal exists
///  @dev Covers SuperVaultStrategy.sol:924
function test_CancelPPSExpirationProposal_RevertsOnNoProposal() public;
```

### test_CancelPPSExpirationProposal_SucceedsWithExistingProposal()

- **Signature**: `test_CancelPPSExpirationProposal_SucceedsWithExistingProposal()`
- **Visibility**: public
- **Source Range**: 141359:436:660
- **Details**: [function_test_CancelPPSExpirationProposal_SucceedsWithExistingProposal.md](./function_test_CancelPPSExpirationProposal_SucceedsWithExistingProposal.md)

**Signature:**
```solidity
/// @notice Tests cancelPPSExpirationProposal succeeds when proposal exists
///  @dev Covers SuperVaultStrategy.sol:926-927
function test_CancelPPSExpirationProposal_SucceedsWithExistingProposal() public;
```

### test_CancelPPSExpirationProposal_ClearsStateVariables()

- **Signature**: `test_CancelPPSExpirationProposal_ClearsStateVariables()`
- **Visibility**: public
- **Source Range**: 141978:1047:660
- **Details**: [function_test_CancelPPSExpirationProposal_ClearsStateVariables.md](./function_test_CancelPPSExpirationProposal_ClearsStateVariables.md)

**Signature:**
```solidity
/// @notice Tests cancelPPSExpirationProposal properly clears state variables
///  @dev Covers SuperVaultStrategy.sol:926-927 - verifies both state variables are cleared
function test_CancelPPSExpirationProposal_ClearsStateVariables() public;
```

### test_CancelPPSExpirationProposal_EmitsEvent()

- **Signature**: `test_CancelPPSExpirationProposal_EmitsEvent()`
- **Visibility**: public
- **Source Range**: 143165:553:660
- **Details**: [function_test_CancelPPSExpirationProposal_EmitsEvent.md](./function_test_CancelPPSExpirationProposal_EmitsEvent.md)

**Signature:**
```solidity
/// @notice Tests cancelPPSExpirationProposal emits correct event
///  @dev Covers SuperVaultStrategy.sol:929 - event emission
function test_CancelPPSExpirationProposal_EmitsEvent() public;
```

### test_CancelPPSExpirationProposal_WithEffectiveTimeEqualOne()

- **Signature**: `test_CancelPPSExpirationProposal_WithEffectiveTimeEqualOne()`
- **Visibility**: public
- **Source Range**: 143902:922:660
- **Details**: [function_test_CancelPPSExpirationProposal_WithEffectiveTimeEqualOne.md](./function_test_CancelPPSExpirationProposal_WithEffectiveTimeEqualOne.md)

**Signature:**
```solidity
/// @notice Tests cancelPPSExpirationProposal with boundary case effectiveTime == 1
///  @dev Covers SuperVaultStrategy.sol:924 - boundary test for non-zero effectiveTime
function test_CancelPPSExpirationProposal_WithEffectiveTimeEqualOne() public;
```

### test_ManagePPSExpiration_FullProposalLifecycle()

- **Signature**: `test_ManagePPSExpiration_FullProposalLifecycle()`
- **Visibility**: public
- **Source Range**: 144950:726:660
- **Details**: [function_test_ManagePPSExpiration_FullProposalLifecycle.md](./function_test_ManagePPSExpiration_FullProposalLifecycle.md)

**Signature:**
```solidity
/// @notice Tests full proposal lifecycle: propose -> cancel -> propose again
///  @dev Covers complete workflow
function test_ManagePPSExpiration_FullProposalLifecycle() public;
```

### test_SetRedeemSlippage_RevertsOnExcessiveSlippage()

- **Signature**: `test_SetRedeemSlippage_RevertsOnExcessiveSlippage()`
- **Visibility**: public
- **Source Range**: 145983:363:660
- **Details**: [function_test_SetRedeemSlippage_RevertsOnExcessiveSlippage.md](./function_test_SetRedeemSlippage_RevertsOnExcessiveSlippage.md)

**Signature:**
```solidity
/// @notice Tests setRedeemSlippage reverts when slippage exceeds BPS_PRECISION
///  @dev Covers SuperVaultStrategy.sol:547
function test_SetRedeemSlippage_RevertsOnExcessiveSlippage() public;
```

### test_SetRedeemSlippage_SucceedsWithValidSlippage()

- **Signature**: `test_SetRedeemSlippage_SucceedsWithValidSlippage()`
- **Visibility**: public
- **Source Range**: 146468:496:660
- **Details**: [function_test_SetRedeemSlippage_SucceedsWithValidSlippage.md](./function_test_SetRedeemSlippage_SucceedsWithValidSlippage.md)

**Signature:**
```solidity
/// @notice Tests setRedeemSlippage succeeds with valid slippage
///  @dev Covers SuperVaultStrategy.sol:549
function test_SetRedeemSlippage_SucceedsWithValidSlippage() public;
```

### test_SetRedeemSlippage_SucceedsWithZeroSlippage()

- **Signature**: `test_SetRedeemSlippage_SucceedsWithZeroSlippage()`
- **Visibility**: public
- **Source Range**: 147081:438:660
- **Details**: [function_test_SetRedeemSlippage_SucceedsWithZeroSlippage.md](./function_test_SetRedeemSlippage_SucceedsWithZeroSlippage.md)

**Signature:**
```solidity
/// @notice Tests setRedeemSlippage succeeds with zero slippage
///  @dev Covers edge case: 0% slippage
function test_SetRedeemSlippage_SucceedsWithZeroSlippage() public;
```

### test_SetRedeemSlippage_SucceedsWithMaximumSlippage()

- **Signature**: `test_SetRedeemSlippage_SucceedsWithMaximumSlippage()`
- **Visibility**: public
- **Source Range**: 147670:478:660
- **Details**: [function_test_SetRedeemSlippage_SucceedsWithMaximumSlippage.md](./function_test_SetRedeemSlippage_SucceedsWithMaximumSlippage.md)

**Signature:**
```solidity
/// @notice Tests setRedeemSlippage succeeds with maximum valid slippage
///  @dev Covers edge case: exactly BPS_PRECISION (10000 = 100%)
function test_SetRedeemSlippage_SucceedsWithMaximumSlippage() public;
```

### test_SetRedeemSlippage_MultipleUsersIndependentSettings()

- **Signature**: `test_SetRedeemSlippage_MultipleUsersIndependentSettings()`
- **Visibility**: public
- **Source Range**: 148290:848:660
- **Details**: [function_test_SetRedeemSlippage_MultipleUsersIndependentSettings.md](./function_test_SetRedeemSlippage_MultipleUsersIndependentSettings.md)

**Signature:**
```solidity
/// @notice Tests setRedeemSlippage allows different users to set different values
///  @dev Verifies per-user storage isolation
function test_SetRedeemSlippage_MultipleUsersIndependentSettings() public;
```

### test_GetYieldSource_ReturnsCorrectOracleForExistingSource()

- **Signature**: `test_GetYieldSource_ReturnsCorrectOracleForExistingSource()`
- **Visibility**: public
- **Source Range**: 149444:901:660
- **Details**: [function_test_GetYieldSource_ReturnsCorrectOracleForExistingSource.md](./function_test_GetYieldSource_ReturnsCorrectOracleForExistingSource.md)

**Signature:**
```solidity
/// @notice Tests getYieldSource returns correct oracle for existing yield source
///  @dev Covers SuperVaultStrategy.sol:581
function test_GetYieldSource_ReturnsCorrectOracleForExistingSource() public;
```

### test_GetYieldSource_ReturnsZeroAddressForNonExistentSource()

- **Signature**: `test_GetYieldSource_ReturnsZeroAddressForNonExistentSource()`
- **Visibility**: public
- **Source Range**: 150486:415:660
- **Details**: [function_test_GetYieldSource_ReturnsZeroAddressForNonExistentSource.md](./function_test_GetYieldSource_ReturnsZeroAddressForNonExistentSource.md)

**Signature:**
```solidity
/// @notice Tests getYieldSource returns zero address for non-existent yield source
///  @dev Verifies default mapping behavior
function test_GetYieldSource_ReturnsZeroAddressForNonExistentSource() public view;
```

### test_GetYieldSource_MultipleYieldSources()

- **Signature**: `test_GetYieldSource_MultipleYieldSources()`
- **Visibility**: public
- **Source Range**: 151034:1408:660
- **Details**: [function_test_GetYieldSource_MultipleYieldSources.md](./function_test_GetYieldSource_MultipleYieldSources.md)

**Signature:**
```solidity
/// @notice Tests getYieldSource with multiple yield sources
///  @dev Verifies correct oracle returned for each source
function test_GetYieldSource_MultipleYieldSources() public;
```

### test_GetYieldSource_AfterOracleUpdate()

- **Signature**: `test_GetYieldSource_AfterOracleUpdate()`
- **Visibility**: public
- **Source Range**: 152554:1389:660
- **Details**: [function_test_GetYieldSource_AfterOracleUpdate.md](./function_test_GetYieldSource_AfterOracleUpdate.md)

**Signature:**
```solidity
/// @notice Tests getYieldSource after oracle update
///  @dev Verifies oracle change is reflected
function test_GetYieldSource_AfterOracleUpdate() public;
```

### test_GetYieldSource_AfterRemoval()

- **Signature**: `test_GetYieldSource_AfterRemoval()`
- **Visibility**: public
- **Source Range**: 154077:1324:660
- **Details**: [function_test_GetYieldSource_AfterRemoval.md](./function_test_GetYieldSource_AfterRemoval.md)

**Signature:**
```solidity
/// @notice Tests getYieldSource after removal returns zero address
///  @dev Verifies removal clears the oracle mapping
function test_GetYieldSource_AfterRemoval() public;
```

### test_GetYieldSourcesCount_ReturnsZeroInitially()

- **Signature**: `test_GetYieldSourcesCount_ReturnsZeroInitially()`
- **Visibility**: public
- **Source Range**: 155709:194:660
- **Details**: [function_test_GetYieldSourcesCount_ReturnsZeroInitially.md](./function_test_GetYieldSourcesCount_ReturnsZeroInitially.md)

**Signature:**
```solidity
/// @notice Tests getYieldSourcesCount returns zero initially
///  @dev Covers SuperVaultStrategy.sol:606 - initial state
function test_GetYieldSourcesCount_ReturnsZeroInitially() public view;
```

### test_GetYieldSourcesCount_ReturnsOneAfterAddingSingleSource()

- **Signature**: `test_GetYieldSourcesCount_ReturnsOneAfterAddingSingleSource()`
- **Visibility**: public
- **Source Range**: 156029:754:660
- **Details**: [function_test_GetYieldSourcesCount_ReturnsOneAfterAddingSingleSource.md](./function_test_GetYieldSourcesCount_ReturnsOneAfterAddingSingleSource.md)

**Signature:**
```solidity
/// @notice Tests getYieldSourcesCount after adding one yield source
///  @dev Covers SuperVaultStrategy.sol:606
function test_GetYieldSourcesCount_ReturnsOneAfterAddingSingleSource() public;
```

### test_GetYieldSourcesCount_ReturnsCorrectCountForMultipleSources()

- **Signature**: `test_GetYieldSourcesCount_ReturnsCorrectCountForMultipleSources()`
- **Visibility**: public
- **Source Range**: 156917:1050:660
- **Details**: [function_test_GetYieldSourcesCount_ReturnsCorrectCountForMultipleSources.md](./function_test_GetYieldSourcesCount_ReturnsCorrectCountForMultipleSources.md)

**Signature:**
```solidity
/// @notice Tests getYieldSourcesCount after adding multiple yield sources
///  @dev Verifies count increments correctly
function test_GetYieldSourcesCount_ReturnsCorrectCountForMultipleSources() public;
```

### test_GetYieldSourcesCount_DecrementsAfterRemoval()

- **Signature**: `test_GetYieldSourcesCount_DecrementsAfterRemoval()`
- **Visibility**: public
- **Source Range**: 158095:1666:660
- **Details**: [function_test_GetYieldSourcesCount_DecrementsAfterRemoval.md](./function_test_GetYieldSourcesCount_DecrementsAfterRemoval.md)

**Signature:**
```solidity
/// @notice Tests getYieldSourcesCount after removing a yield source
///  @dev Verifies count decrements correctly
function test_GetYieldSourcesCount_DecrementsAfterRemoval() public;
```

### test_GetYieldSourcesCount_ComplexOperations()

- **Signature**: `test_GetYieldSourcesCount_ComplexOperations()`
- **Visibility**: public
- **Source Range**: 159913:3258:660
- **Details**: [function_test_GetYieldSourcesCount_ComplexOperations.md](./function_test_GetYieldSourcesCount_ComplexOperations.md)

**Signature:**
```solidity
/// @notice Tests getYieldSourcesCount with complex add/remove operations
///  @dev Verifies count is accurate through multiple operations
function test_GetYieldSourcesCount_ComplexOperations() public;
```

### test_GetYieldSourcesCount_UnchangedAfterOracleUpdate()

- **Signature**: `test_GetYieldSourcesCount_UnchangedAfterOracleUpdate()`
- **Visibility**: public
- **Source Range**: 163330:1114:660
- **Details**: [function_test_GetYieldSourcesCount_UnchangedAfterOracleUpdate.md](./function_test_GetYieldSourcesCount_UnchangedAfterOracleUpdate.md)

**Signature:**
```solidity
/// @notice Tests getYieldSourcesCount after oracle update (should not change count)
///  @dev Verifies that updating oracle doesn't affect count
function test_GetYieldSourcesCount_UnchangedAfterOracleUpdate() public;
```

### test_VaultUnrealizedProfit_ReturnsZeroWhenNoShares()

- **Signature**: `test_VaultUnrealizedProfit_ReturnsZeroWhenNoShares()`
- **Visibility**: public
- **Source Range**: 164754:267:660
- **Details**: [function_test_VaultUnrealizedProfit_ReturnsZeroWhenNoShares.md](./function_test_VaultUnrealizedProfit_ReturnsZeroWhenNoShares.md)

**Signature:**
```solidity
/// @notice Tests vaultUnrealizedProfit returns zero when total supply is zero
///  @dev Covers SuperVaultStrategy.sol:617
function test_VaultUnrealizedProfit_ReturnsZeroWhenNoShares() public view;
```

### test_VaultUnrealizedProfit_ReturnsZeroWhenPPSEqualsHWM()

- **Signature**: `test_VaultUnrealizedProfit_ReturnsZeroWhenPPSEqualsHWM()`
- **Visibility**: public
- **Source Range**: 165151:633:660
- **Details**: [function_test_VaultUnrealizedProfit_ReturnsZeroWhenPPSEqualsHWM.md](./function_test_VaultUnrealizedProfit_ReturnsZeroWhenPPSEqualsHWM.md)

**Signature:**
```solidity
/// @notice Tests vaultUnrealizedProfit returns zero when PPS equals HWM
///  @dev Covers SuperVaultStrategy.sol:622
function test_VaultUnrealizedProfit_ReturnsZeroWhenPPSEqualsHWM() public;
```

### test_VaultUnrealizedProfit_ReturnsZeroWhenPPSBelowHWM()

- **Signature**: `test_VaultUnrealizedProfit_ReturnsZeroWhenPPSBelowHWM()`
- **Visibility**: public
- **Source Range**: 165916:836:660
- **Details**: [function_test_VaultUnrealizedProfit_ReturnsZeroWhenPPSBelowHWM.md](./function_test_VaultUnrealizedProfit_ReturnsZeroWhenPPSBelowHWM.md)

**Signature:**
```solidity
/// @notice Tests vaultUnrealizedProfit returns zero when PPS is below HWM
///  @dev Covers SuperVaultStrategy.sol:622
function test_VaultUnrealizedProfit_ReturnsZeroWhenPPSBelowHWM() public;
```

### test_VaultUnrealizedProfit_CalculatesCorrectProfitOnPPSGrowth()

- **Signature**: `test_VaultUnrealizedProfit_CalculatesCorrectProfitOnPPSGrowth()`
- **Visibility**: public
- **Source Range**: 166894:1540:660
- **Details**: [function_test_VaultUnrealizedProfit_CalculatesCorrectProfitOnPPSGrowth.md](./function_test_VaultUnrealizedProfit_CalculatesCorrectProfitOnPPSGrowth.md)

**Signature:**
```solidity
/// @notice Tests vaultUnrealizedProfit calculates correct profit when PPS grows
///  @dev Covers SuperVaultStrategy.sol:625-626
function test_VaultUnrealizedProfit_CalculatesCorrectProfitOnPPSGrowth() public;
```

### test_VaultUnrealizedProfit_UsesCurrentPPSFromAggregator()

- **Signature**: `test_VaultUnrealizedProfit_UsesCurrentPPSFromAggregator()`
- **Visibility**: public
- **Source Range**: 168593:1217:660
- **Details**: [function_test_VaultUnrealizedProfit_UsesCurrentPPSFromAggregator.md](./function_test_VaultUnrealizedProfit_UsesCurrentPPSFromAggregator.md)

**Signature:**
```solidity
/// @notice Tests vaultUnrealizedProfit uses getPPS from aggregator correctly
///  @dev Covers SuperVaultStrategy.sol:619 - tests the getPPS call
function test_VaultUnrealizedProfit_UsesCurrentPPSFromAggregator() public;
```

### test_VaultUnrealizedProfit_ReturnsZeroWhenPPSIsZero()

- **Signature**: `test_VaultUnrealizedProfit_ReturnsZeroWhenPPSIsZero()`
- **Visibility**: public
- **Source Range**: 169939:851:660
- **Details**: [function_test_VaultUnrealizedProfit_ReturnsZeroWhenPPSIsZero.md](./function_test_VaultUnrealizedProfit_ReturnsZeroWhenPPSIsZero.md)

**Signature:**
```solidity
/// @notice Tests vaultUnrealizedProfit with zero PPS returns zero
///  @dev Tests edge case where getPPS returns 0
function test_VaultUnrealizedProfit_ReturnsZeroWhenPPSIsZero() public;
```

### test_VaultUnrealizedProfit_HandlesLargePPSValues()

- **Signature**: `test_VaultUnrealizedProfit_HandlesLargePPSValues()`
- **Visibility**: public
- **Source Range**: 170910:1210:660
- **Details**: [function_test_VaultUnrealizedProfit_HandlesLargePPSValues.md](./function_test_VaultUnrealizedProfit_HandlesLargePPSValues.md)

**Signature:**
```solidity
/// @notice Tests vaultUnrealizedProfit with large PPS values
///  @dev Tests edge case with large numbers
function test_VaultUnrealizedProfit_HandlesLargePPSValues() public;
```

### test_VaultUnrealizedProfit_MultipleUsers()

- **Signature**: `test_VaultUnrealizedProfit_MultipleUsers()`
- **Visibility**: public
- **Source Range**: 172258:1297:660
- **Details**: [function_test_VaultUnrealizedProfit_MultipleUsers.md](./function_test_VaultUnrealizedProfit_MultipleUsers.md)

**Signature:**
```solidity
/// @notice Tests vaultUnrealizedProfit with multiple users
///  @dev Verifies profit calculation with multiple shareholders
function test_VaultUnrealizedProfit_MultipleUsers() public;
```

### test_VaultUnrealizedProfit_ExactEqualityBoundary()

- **Signature**: `test_VaultUnrealizedProfit_ExactEqualityBoundary()`
- **Visibility**: public
- **Source Range**: 173903:1056:660
- **Details**: [function_test_VaultUnrealizedProfit_ExactEqualityBoundary.md](./function_test_VaultUnrealizedProfit_ExactEqualityBoundary.md)

**Signature:**
```solidity
/// @notice Tests exact boundary: currentPPS exactly equals vaultHwmPps
///  @dev Covers the == part of <= condition
function test_VaultUnrealizedProfit_ExactEqualityBoundary() public;
```

### test_VaultUnrealizedProfit_OneLessThanHWM()

- **Signature**: `test_VaultUnrealizedProfit_OneLessThanHWM()`
- **Visibility**: public
- **Source Range**: 175107:1089:660
- **Details**: [function_test_VaultUnrealizedProfit_OneLessThanHWM.md](./function_test_VaultUnrealizedProfit_OneLessThanHWM.md)

**Signature:**
```solidity
/// @notice Tests boundary: currentPPS is 1 wei less than vaultHwmPps
///  @dev Tests the < part of <= condition at minimal difference
function test_VaultUnrealizedProfit_OneLessThanHWM() public;
```

### test_VaultUnrealizedProfit_OneMoreThanHWM()

- **Signature**: `test_VaultUnrealizedProfit_OneMoreThanHWM()`
- **Visibility**: public
- **Source Range**: 176373:1363:660
- **Details**: [function_test_VaultUnrealizedProfit_OneMoreThanHWM.md](./function_test_VaultUnrealizedProfit_OneMoreThanHWM.md)

**Signature:**
```solidity
/// @notice Tests boundary: currentPPS is 1 wei more than vaultHwmPps (should have profit)
///  @dev Verifies the boundary - just above HWM should calculate profit
function test_VaultUnrealizedProfit_OneMoreThanHWM() public;
```

### test_VaultUnrealizedProfit_PPSEqualToVeryHighHWM()

- **Signature**: `test_VaultUnrealizedProfit_PPSEqualToVeryHighHWM()`
- **Visibility**: public
- **Source Range**: 177849:1086:660
- **Details**: [function_test_VaultUnrealizedProfit_PPSEqualToVeryHighHWM.md](./function_test_VaultUnrealizedProfit_PPSEqualToVeryHighHWM.md)

**Signature:**
```solidity
/// @notice Tests with HWM at maximum reasonable value
///  @dev Tests edge case with very high HWM
function test_VaultUnrealizedProfit_PPSEqualToVeryHighHWM() public;
```

### test_VaultUnrealizedProfit_PPSSignificantlyBelowHWM()

- **Signature**: `test_VaultUnrealizedProfit_PPSSignificantlyBelowHWM()`
- **Visibility**: public
- **Source Range**: 179048:1100:660
- **Details**: [function_test_VaultUnrealizedProfit_PPSSignificantlyBelowHWM.md](./function_test_VaultUnrealizedProfit_PPSSignificantlyBelowHWM.md)

**Signature:**
```solidity
/// @notice Tests PPS significantly below HWM
///  @dev Tests the < condition with large difference
function test_VaultUnrealizedProfit_PPSSignificantlyBelowHWM() public;
```

### test_VaultUnrealizedProfit_MinimalValuesEqual()

- **Signature**: `test_VaultUnrealizedProfit_MinimalValuesEqual()`
- **Visibility**: public
- **Source Range**: 180273:997:660
- **Details**: [function_test_VaultUnrealizedProfit_MinimalValuesEqual.md](./function_test_VaultUnrealizedProfit_MinimalValuesEqual.md)

**Signature:**
```solidity
/// @notice Tests with both PPS and HWM at minimum non-zero value
///  @dev Tests edge case with 1 wei for both
function test_VaultUnrealizedProfit_MinimalValuesEqual() public;
```

### test_VaultUnrealizedProfit_ComprehensiveLessThanOrEqualCases()

- **Signature**: `test_VaultUnrealizedProfit_ComprehensiveLessThanOrEqualCases()`
- **Visibility**: public
- **Source Range**: 181418:2152:660
- **Details**: [function_test_VaultUnrealizedProfit_ComprehensiveLessThanOrEqualCases.md](./function_test_VaultUnrealizedProfit_ComprehensiveLessThanOrEqualCases.md)

**Signature:**
```solidity
/// @notice Tests multiple scenarios where <= condition should return 0
///  @dev Comprehensive test for various PPS/HWM relationships
function test_VaultUnrealizedProfit_ComprehensiveLessThanOrEqualCases() public;
```

### test_ContainsYieldSource()

- **Signature**: `test_ContainsYieldSource()`
- **Visibility**: public
- **Source Range**: 183926:1814:660
- **Details**: [function_test_ContainsYieldSource.md](./function_test_ContainsYieldSource.md)

**Signature:**
```solidity
/// @notice Tests containsYieldSource returns false when source doesn't exist, true after adding, and false after
///  removing @dev Covers SuperVaultStrategy.sol:630-632
function test_ContainsYieldSource() public;
```

### test_PreviewExactRedeemBatch_RevertsOnZeroLength()

- **Signature**: `test_PreviewExactRedeemBatch_RevertsOnZeroLength()`
- **Visibility**: public
- **Source Range**: 186055:390:660
- **Details**: [function_test_PreviewExactRedeemBatch_RevertsOnZeroLength.md](./function_test_PreviewExactRedeemBatch_RevertsOnZeroLength.md)

**Signature:**
```solidity
/// @notice Tests previewExactRedeemBatch reverts when controllers array is empty
///  @dev Covers SuperVaultStrategy.sol:687
function test_PreviewExactRedeemBatch_RevertsOnZeroLength() public;
```

### test_RequestRedeem_RevertsOnZeroShares()

- **Signature**: `test_RequestRedeem_RevertsOnZeroShares()`
- **Visibility**: public
- **Source Range**: 186899:599:660
- **Details**: [function_test_RequestRedeem_RevertsOnZeroShares.md](./function_test_RequestRedeem_RevertsOnZeroShares.md)

**Signature:**
```solidity
/// @notice Tests requestRedeem reverts when shares is zero
///  @dev Covers SuperVaultStrategy.sol:962 - first if statement in _handleRequestRedeem
///  @dev Note: The vault ERC7540 layer checks for ZERO_AMOUNT before reaching the strategy
function test_RequestRedeem_RevertsOnZeroShares() public;
```

### test_RequestRedeem_RevertsOnZeroAddressController()

- **Signature**: `test_RequestRedeem_RevertsOnZeroAddressController()`
- **Visibility**: public
- **Source Range**: 187671:635:660
- **Details**: [function_test_RequestRedeem_RevertsOnZeroAddressController.md](./function_test_RequestRedeem_RevertsOnZeroAddressController.md)

**Signature:**
```solidity
/// @notice Tests requestRedeem reverts when controller is address(0)
///  @dev Covers SuperVaultStrategy.sol:963 - second if statement in _handleRequestRedeem
function test_RequestRedeem_RevertsOnZeroAddressController() public;
```

### test_RequestRedeem_SucceedsWithMinimalPPS()

- **Signature**: `test_RequestRedeem_SucceedsWithMinimalPPS()`
- **Visibility**: public
- **Source Range**: 188712:684:660
- **Details**: [function_test_RequestRedeem_SucceedsWithMinimalPPS.md](./function_test_RequestRedeem_SucceedsWithMinimalPPS.md)

**Signature:**
```solidity
/// @notice Tests requestRedeem with PPS boundary (currentPPS == 1)
///  @dev Covers SuperVaultStrategy.sol:968 - third if statement boundary test
///  @dev Note: Testing currentPPS == 0 is difficult due to storage complexity
///  @dev and represents a corrupted state that shouldn't occur in normal operation
///  @dev This test verifies the success case with minimal PPS (boundary)
function test_RequestRedeem_SucceedsWithMinimalPPS() public;
```

### test_RequestRedeem_SucceedsWithValidParameters()

- **Signature**: `test_RequestRedeem_SucceedsWithValidParameters()`
- **Visibility**: public
- **Source Range**: 189550:628:660
- **Details**: [function_test_RequestRedeem_SucceedsWithValidParameters.md](./function_test_RequestRedeem_SucceedsWithValidParameters.md)

**Signature:**
```solidity
/// @notice Tests requestRedeem succeeds with valid parameters
///  @dev Covers success path for first 3 if statements (all conditions pass)
function test_RequestRedeem_SucceedsWithValidParameters() public;
```

### test_RequestRedeem_SucceedsWithOneShare()

- **Signature**: `test_RequestRedeem_SucceedsWithOneShare()`
- **Visibility**: public
- **Source Range**: 190345:524:660
- **Details**: [function_test_RequestRedeem_SucceedsWithOneShare.md](./function_test_RequestRedeem_SucceedsWithOneShare.md)

**Signature:**
```solidity
/// @notice Tests requestRedeem with shares exactly equal to 1 (boundary test)
///  @dev Covers SuperVaultStrategy.sol:962 - boundary test for shares > 0
function test_RequestRedeem_SucceedsWithOneShare() public;
```

### test_CancelRedeemRequest_RevertsOnZeroAddressController()

- **Signature**: `test_CancelRedeemRequest_RevertsOnZeroAddressController()`
- **Visibility**: public
- **Source Range**: 191346:787:660
- **Details**: [function_test_CancelRedeemRequest_RevertsOnZeroAddressController.md](./function_test_CancelRedeemRequest_RevertsOnZeroAddressController.md)

**Signature:**
```solidity
/// @notice Tests cancelRedeemRequest reverts when controller is address(0)
///  @dev Covers SuperVaultStrategy.sol:995 - first if check in _handleCancelRedeemRequest
///  @dev Note: The vault ERC7540 layer checks for INVALID_CONTROLLER before reaching the strategy
function test_CancelRedeemRequest_RevertsOnZeroAddressController() public;
```

### test_CancelRedeemRequest_RevertsOnNoRedeemRequest()

- **Signature**: `test_CancelRedeemRequest_RevertsOnNoRedeemRequest()`
- **Visibility**: public
- **Source Range**: 192314:634:660
- **Details**: [function_test_CancelRedeemRequest_RevertsOnNoRedeemRequest.md](./function_test_CancelRedeemRequest_RevertsOnNoRedeemRequest.md)

**Signature:**
```solidity
/// @notice Tests cancelRedeemRequest reverts when no redeem request exists
///  @dev Covers SuperVaultStrategy.sol:997 - second if check in _handleCancelRedeemRequest
function test_CancelRedeemRequest_RevertsOnNoRedeemRequest() public;
```

### test_CancelRedeemRequest_RevertsOnCancelAlreadyPending()

- **Signature**: `test_CancelRedeemRequest_RevertsOnCancelAlreadyPending()`
- **Visibility**: public
- **Source Range**: 193126:812:660
- **Details**: [function_test_CancelRedeemRequest_RevertsOnCancelAlreadyPending.md](./function_test_CancelRedeemRequest_RevertsOnCancelAlreadyPending.md)

**Signature:**
```solidity
/// @notice Tests cancelRedeemRequest reverts when cancel already pending
///  @dev Covers SuperVaultStrategy.sol:998 - third if check in _handleCancelRedeemRequest
function test_CancelRedeemRequest_RevertsOnCancelAlreadyPending() public;
```

### test_CancelRedeemRequest_SucceedsWithValidRequest()

- **Signature**: `test_CancelRedeemRequest_SucceedsWithValidRequest()`
- **Visibility**: public
- **Source Range**: 194100:801:660
- **Details**: [function_test_CancelRedeemRequest_SucceedsWithValidRequest.md](./function_test_CancelRedeemRequest_SucceedsWithValidRequest.md)

**Signature:**
```solidity
/// @notice Tests cancelRedeemRequest succeeds with valid conditions
///  @dev Covers success path for all 3 if checks in _handleCancelRedeemRequest
function test_CancelRedeemRequest_SucceedsWithValidRequest() public;
```

### test_CancelRedeemRequest_SucceedsWithMinimalRedeemRequest()

- **Signature**: `test_CancelRedeemRequest_SucceedsWithMinimalRedeemRequest()`
- **Visibility**: public
- **Source Range**: 195086:841:660
- **Details**: [function_test_CancelRedeemRequest_SucceedsWithMinimalRedeemRequest.md](./function_test_CancelRedeemRequest_SucceedsWithMinimalRedeemRequest.md)

**Signature:**
```solidity
/// @notice Tests cancelRedeemRequest with pendingRedeemRequest exactly equal to 1
///  @dev Covers SuperVaultStrategy.sol:997 - boundary test for pendingRedeemRequest > 0
function test_CancelRedeemRequest_SucceedsWithMinimalRedeemRequest() public;
```

### test_ClaimCancelRedeem_RevertsOnZeroAddressController()

- **Signature**: `test_ClaimCancelRedeem_RevertsOnZeroAddressController()`
- **Visibility**: public
- **Source Range**: 196407:1098:660
- **Details**: [function_test_ClaimCancelRedeem_RevertsOnZeroAddressController.md](./function_test_ClaimCancelRedeem_RevertsOnZeroAddressController.md)

**Signature:**
```solidity
/// @notice Tests claimCancelRedeem reverts when controller is address(0)
///  @dev Covers SuperVaultStrategy.sol:1007 - first if statement in _handleClaimCancelRedeem
///  @dev Note: The vault ERC7540 layer checks for INVALID_CONTROLLER before reaching the strategy
function test_ClaimCancelRedeem_RevertsOnZeroAddressController() public;
```

### test_ClaimCancelRedeem_RevertsOnNoClaimableRequest()

- **Signature**: `test_ClaimCancelRedeem_RevertsOnNoClaimableRequest()`
- **Visibility**: public
- **Source Range**: 197697:669:660
- **Details**: [function_test_ClaimCancelRedeem_RevertsOnNoClaimableRequest.md](./function_test_ClaimCancelRedeem_RevertsOnNoClaimableRequest.md)

**Signature:**
```solidity
/// @notice Tests claimCancelRedeem reverts when no claimable cancel request exists
///  @dev Covers SuperVaultStrategy.sol:1010 - second if statement in _handleClaimCancelRedeem
function test_ClaimCancelRedeem_RevertsOnNoClaimableRequest() public;
```

### test_ClaimCancelRedeem_RequiresPendingFlagTrue()

- **Signature**: `test_ClaimCancelRedeem_RequiresPendingFlagTrue()`
- **Visibility**: public
- **Source Range**: 199222:1628:660
- **Details**: [function_test_ClaimCancelRedeem_RequiresPendingFlagTrue.md](./function_test_ClaimCancelRedeem_RequiresPendingFlagTrue.md)

**Signature:**
```solidity
/// @notice Tests that line 1012 check exists (defensive check for pendingCancelRedeemRequest flag)
///  @dev Covers SuperVaultStrategy.sol:1012 - third if statement in _handleClaimCancelRedeem
///  @dev This is a defensive check: if (!state.pendingCancelRedeemRequest) revert
///  CANCELLATION_REDEEM_REQUEST_PENDING() @dev The check ensures pendingCancelRedeemRequest is true when claiming
///  @dev This condition cannot be triggered through normal operations since:
///  @dev - fulfillCancelRedeemRequests keeps pendingCancelRedeemRequest = true
///  @dev - Only claimCancelRedeemRequest sets it to false (after passing all checks)
///  @dev - So having claimable > 0 with pending = false would require corrupted state
///  @dev Instead, we verify the check exists by ensuring the success path requires pending = true
function test_ClaimCancelRedeem_RequiresPendingFlagTrue() public;
```

### test_ClaimCancelRedeem_SucceedsWithValidRequest()

- **Signature**: `test_ClaimCancelRedeem_SucceedsWithValidRequest()`
- **Visibility**: public
- **Source Range**: 201019:1182:660
- **Details**: [function_test_ClaimCancelRedeem_SucceedsWithValidRequest.md](./function_test_ClaimCancelRedeem_SucceedsWithValidRequest.md)

**Signature:**
```solidity
/// @notice Tests claimCancelRedeem succeeds with valid fulfilled request
///  @dev Covers success path for all 3 if statements in _handleClaimCancelRedeem
function test_ClaimCancelRedeem_SucceedsWithValidRequest() public;
```

### test_ClaimCancelRedeem_SucceedsWithMinimalClaimable()

- **Signature**: `test_ClaimCancelRedeem_SucceedsWithMinimalClaimable()`
- **Visibility**: public
- **Source Range**: 202382:1168:660
- **Details**: [function_test_ClaimCancelRedeem_SucceedsWithMinimalClaimable.md](./function_test_ClaimCancelRedeem_SucceedsWithMinimalClaimable.md)

**Signature:**
```solidity
/// @notice Tests claimCancelRedeem with claimableCancelRedeemRequest exactly equal to 1
///  @dev Covers SuperVaultStrategy.sol:1010 - boundary test for claimable > 0
function test_ClaimCancelRedeem_SucceedsWithMinimalClaimable() public;
```

### test_ClaimCancelRedeem_OperatorSucceedsWithReceiverEqualController()

- **Signature**: `test_ClaimCancelRedeem_OperatorSucceedsWithReceiverEqualController()`
- **Visibility**: public
- **Source Range**: 203660:1647:660
- **Details**: [function_test_ClaimCancelRedeem_OperatorSucceedsWithReceiverEqualController.md](./function_test_ClaimCancelRedeem_OperatorSucceedsWithReceiverEqualController.md)

**Signature:**
```solidity
/// @notice Tests claimCancelRedeemRequest succeeds when operator calls with receiver == controller
function test_ClaimCancelRedeem_OperatorSucceedsWithReceiverEqualController() public;
```

### test_ClaimCancelRedeem_OperatorRevertsWithReceiverNotEqualController()

- **Signature**: `test_ClaimCancelRedeem_OperatorRevertsWithReceiverNotEqualController()`
- **Visibility**: public
- **Source Range**: 205416:1518:660
- **Details**: [function_test_ClaimCancelRedeem_OperatorRevertsWithReceiverNotEqualController.md](./function_test_ClaimCancelRedeem_OperatorRevertsWithReceiverNotEqualController.md)

**Signature:**
```solidity
/// @notice Tests claimCancelRedeemRequest reverts when operator calls with receiver != controller
function test_ClaimCancelRedeem_OperatorRevertsWithReceiverNotEqualController() public;
```

### test_ClaimCancelRedeem_ControllerSucceedsWithArbitraryReceiver()

- **Signature**: `test_ClaimCancelRedeem_ControllerSucceedsWithArbitraryReceiver()`
- **Visibility**: public
- **Source Range**: 207042:1623:660
- **Details**: [function_test_ClaimCancelRedeem_ControllerSucceedsWithArbitraryReceiver.md](./function_test_ClaimCancelRedeem_ControllerSucceedsWithArbitraryReceiver.md)

**Signature:**
```solidity
/// @notice Tests claimCancelRedeemRequest succeeds when controller calls with arbitrary receiver
function test_ClaimCancelRedeem_ControllerSucceedsWithArbitraryReceiver() public;
```

### test_ClaimCancelRedeem_NonOperatorReverts()

- **Signature**: `test_ClaimCancelRedeem_NonOperatorReverts()`
- **Visibility**: public
- **Source Range**: 208774:1329:660
- **Details**: [function_test_ClaimCancelRedeem_NonOperatorReverts.md](./function_test_ClaimCancelRedeem_NonOperatorReverts.md)

**Signature:**
```solidity
/// @notice Tests claimCancelRedeemRequest reverts when non-operator calls on behalf of controller
function test_ClaimCancelRedeem_NonOperatorReverts() public;
```

### test_FulfillRedeemRequests_RevertsOnZeroShareFulfillment()

- **Signature**: `test_FulfillRedeemRequests_RevertsOnZeroShareFulfillment()`
- **Visibility**: public
- **Source Range**: 210317:941:660
- **Details**: [function_test_FulfillRedeemRequests_RevertsOnZeroShareFulfillment.md](./function_test_FulfillRedeemRequests_RevertsOnZeroShareFulfillment.md)

**Signature:**
```solidity
/// @notice Tests fulfillRedeemRequests reverts when controller has zero pending shares
///  @dev Covers SuperVaultStrategy.sol:345 - if (pendingShares == 0) revert ZERO_SHARE_FULFILLMENT_DISALLOWED()
function test_FulfillRedeemRequests_RevertsOnZeroShareFulfillment() public;
```

### test_ResetHighWaterMark_UpdatesHWMToCurrentPPS()

- **Signature**: `test_ResetHighWaterMark_UpdatesHWMToCurrentPPS()`
- **Visibility**: public
- **Source Range**: 211626:1004:660
- **Details**: [function_test_ResetHighWaterMark_UpdatesHWMToCurrentPPS.md](./function_test_ResetHighWaterMark_UpdatesHWMToCurrentPPS.md)

**Signature:**
```solidity
/// @notice Tests that resetHighWaterMark updates HWM to current PPS
///  @dev Verifies the integration between SuperGovernor -> SuperVaultAggregator -> SuperVaultStrategy
function test_ResetHighWaterMark_UpdatesHWMToCurrentPPS() public;
```

### test_ResetHighWaterMark_RevertsForNonGovernor()

- **Signature**: `test_ResetHighWaterMark_RevertsForNonGovernor()`
- **Visibility**: public
- **Source Range**: 212716:481:660
- **Details**: [function_test_ResetHighWaterMark_RevertsForNonGovernor.md](./function_test_ResetHighWaterMark_RevertsForNonGovernor.md)

**Signature:**
```solidity
/// @notice Tests that only SUPER_GOVERNOR_ROLE can call resetHighWaterMark
function test_ResetHighWaterMark_RevertsForNonGovernor() public;
```

### test_ChangePrimaryManager_ViaGovernance()

- **Signature**: `test_ChangePrimaryManager_ViaGovernance()`
- **Visibility**: public
- **Source Range**: 213282:886:660
- **Details**: [function_test_ChangePrimaryManager_ViaGovernance.md](./function_test_ChangePrimaryManager_ViaGovernance.md)

**Signature:**
```solidity
/// @notice Tests that changePrimaryManager works correctly via governance
function test_ChangePrimaryManager_ViaGovernance() public;
```

### test_ChangePrimaryManager_ThenResetHighWaterMark()

- **Signature**: `test_ChangePrimaryManager_ThenResetHighWaterMark()`
- **Visibility**: public
- **Source Range**: 214344:1145:660
- **Details**: [function_test_ChangePrimaryManager_ThenResetHighWaterMark.md](./function_test_ChangePrimaryManager_ThenResetHighWaterMark.md)

**Signature:**
```solidity
/// @notice Tests the complete flow of changePrimaryManager + resetHighWaterMark
///  @dev This is the recommended pattern when replacing a manager with PPS < HWM
function test_ChangePrimaryManager_ThenResetHighWaterMark() public;
```

### test_ChangePrimaryManager_BatchedViaMultisig()

- **Signature**: `test_ChangePrimaryManager_BatchedViaMultisig()`
- **Visibility**: public
- **Source Range**: 215673:3215:660
- **Details**: [function_test_ChangePrimaryManager_BatchedViaMultisig.md](./function_test_ChangePrimaryManager_BatchedViaMultisig.md)

**Signature:**
```solidity
/// @notice Tests batched changePrimaryManager + resetHighWaterMark via multisig
///  @dev Simulates a real-world scenario where governance uses a multisig to batch calls
function test_ChangePrimaryManager_BatchedViaMultisig() public;
```

### test_ChangePrimaryManager_ClearsPendingProposals()

- **Signature**: `test_ChangePrimaryManager_ClearsPendingProposals()`
- **Visibility**: public
- **Source Range**: 218971:1596:660
- **Details**: [function_test_ChangePrimaryManager_ClearsPendingProposals.md](./function_test_ChangePrimaryManager_ClearsPendingProposals.md)

**Signature:**
```solidity
/// @notice Tests that changePrimaryManager clears all pending proposals
function test_ChangePrimaryManager_ClearsPendingProposals() public;
```

### test_ChangePrimaryManager_ClearsSecondaryManagers()

- **Signature**: `test_ChangePrimaryManager_ClearsSecondaryManagers()`
- **Visibility**: public
- **Source Range**: 220651:1367:660
- **Details**: [function_test_ChangePrimaryManager_ClearsSecondaryManagers.md](./function_test_ChangePrimaryManager_ClearsSecondaryManagers.md)

**Signature:**
```solidity
/// @notice Tests that changePrimaryManager clears all secondary managers
function test_ChangePrimaryManager_ClearsSecondaryManagers() public;
```

### test_ResetHighWaterMark_EmitsEvent()

- **Signature**: `test_ResetHighWaterMark_EmitsEvent()`
- **Visibility**: public
- **Source Range**: 222080:379:660
- **Details**: [function_test_ResetHighWaterMark_EmitsEvent.md](./function_test_ResetHighWaterMark_EmitsEvent.md)

**Signature:**
```solidity
/// @notice Tests resetHighWaterMark event emission
function test_ResetHighWaterMark_EmitsEvent() public;
```

### test_ResetHighWaterMark_AggregatorRevertsForNonGovernor()

- **Signature**: `test_ResetHighWaterMark_AggregatorRevertsForNonGovernor()`
- **Visibility**: public
- **Source Range**: 222567:649:660
- **Details**: [function_test_ResetHighWaterMark_AggregatorRevertsForNonGovernor.md](./function_test_ResetHighWaterMark_AggregatorRevertsForNonGovernor.md)

**Signature:**
```solidity
/// @notice Tests that resetHighWaterMark cannot be called directly on aggregator by non-governor
function test_ResetHighWaterMark_AggregatorRevertsForNonGovernor() public;
```

### test_ResetHighWaterMark_RevertsForZeroAddress()

- **Signature**: `test_ResetHighWaterMark_RevertsForZeroAddress()`
- **Visibility**: public
- **Source Range**: 223312:220:660
- **Details**: [function_test_ResetHighWaterMark_RevertsForZeroAddress.md](./function_test_ResetHighWaterMark_RevertsForZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests that resetHighWaterMark reverts for invalid (zero address) strategy
function test_ResetHighWaterMark_RevertsForZeroAddress() public;
```

### test_ResetHighWaterMark_RevertsForUnknownStrategy()

- **Signature**: `test_ResetHighWaterMark_RevertsForUnknownStrategy()`
- **Visibility**: public
- **Source Range**: 223618:306:660
- **Details**: [function_test_ResetHighWaterMark_RevertsForUnknownStrategy.md](./function_test_ResetHighWaterMark_RevertsForUnknownStrategy.md)

**Signature:**
```solidity
/// @notice Tests that resetHighWaterMark reverts for non-existent strategy
function test_ResetHighWaterMark_RevertsForUnknownStrategy() public;
```

### test_NewManager_CanOperateAfterGovernanceTakeover()

- **Signature**: `test_NewManager_CanOperateAfterGovernanceTakeover()`
- **Visibility**: public
- **Source Range**: 224007:907:660
- **Details**: [function_test_NewManager_CanOperateAfterGovernanceTakeover.md](./function_test_NewManager_CanOperateAfterGovernanceTakeover.md)

**Signature:**
```solidity
/// @notice Tests that new manager can operate after governance takeover
function test_NewManager_CanOperateAfterGovernanceTakeover() public;
```

### test_OldManager_LosesControlAfterGovernanceTakeover()

- **Signature**: `test_OldManager_LosesControlAfterGovernanceTakeover()`
- **Visibility**: public
- **Source Range**: 224999:612:660
- **Details**: [function_test_OldManager_LosesControlAfterGovernanceTakeover.md](./function_test_OldManager_LosesControlAfterGovernanceTakeover.md)

**Signature:**
```solidity
/// @notice Tests that old manager loses control after governance takeover
function test_OldManager_LosesControlAfterGovernanceTakeover() public;
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
