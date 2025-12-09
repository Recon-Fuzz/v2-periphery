# Contract: SuperGovernorTest

## Metadata

- **Name**: SuperGovernorTest
- **Type**: Contract
- **Path**: test/unit/SuperGovernor.t.sol

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

### aggregator

```solidity
SuperVaultAggregator internal aggregator
```

**SuperVaultAggregator**: [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]

### superGovernor

```solidity
SuperGovernor internal superGovernor
```

**SuperGovernor**: [src/SuperGovernor.sol/contract_SuperGovernor.md]

### upToken

```solidity
MockUp internal upToken
```

**MockUp**: [test/mocks/MockUp.sol/contract_MockUp.md]

### sGovernor

```solidity
address internal sGovernor
```

### governor

```solidity
address internal governor
```

### guardian

```solidity
address internal guardian
```

### oracleManager

```solidity
address internal oracleManager
```

### treasury

```solidity
address internal treasury
```

### user

```solidity
address internal user
```

### hook1

```solidity
address internal hook1
```

### hook2

```solidity
address internal hook2
```

### fulfillHook1

```solidity
address internal fulfillHook1
```

### fulfillHook2

```solidity
address internal fulfillHook2
```

### validator1

```solidity
address internal validator1
```

### validator2

```solidity
address internal validator2
```

### ppsOracle1

```solidity
address internal ppsOracle1
```

### ppsOracle2

```solidity
address internal ppsOracle2
```

### superVaultAggregator

```solidity
address internal superVaultAggregator
```

### strategy1

```solidity
address internal strategy1
```

### newManager

```solidity
address internal newManager
```

### manager

```solidity
address internal manager
```

### superBank

```solidity
address internal superBank
```

### SUPER_GOVERNOR_ROLE

```solidity
bytes32 internal constant SUPER_GOVERNOR_ROLE = keccak256("SUPER_GOVERNOR_ROLE")
```

### GOVERNOR_ROLE

```solidity
bytes32 internal constant GOVERNOR_ROLE = keccak256("GOVERNOR_ROLE")
```

### BANK_MANAGER_ROLE

```solidity
bytes32 internal constant BANK_MANAGER_ROLE = keccak256("BANK_MANAGER_ROLE")
```

### ORACLE_MANAGER_ROLE

```solidity
bytes32 internal constant ORACLE_MANAGER_ROLE = keccak256("ORACLE_MANAGER_ROLE")
```

### SUPER_VAULT_AGGREGATOR

```solidity
bytes32 internal constant SUPER_VAULT_AGGREGATOR = keccak256("SUPER_VAULT_AGGREGATOR")
```

### TEST_KEY

```solidity
bytes32 internal constant TEST_KEY = keccak256("TEST_KEY")
```

### TIMELOCK

```solidity
uint256 internal constant TIMELOCK = 7 days
```

### BPS_MAX

```solidity
uint256 internal constant BPS_MAX = 10_000
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
- **Source Range**: 2733:3726:659
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
/// @notice Sets up the test environment before each test case.
function setUp() public;
```

### test_constructor_InitialState()

- **Signature**: `test_constructor_InitialState()`
- **Visibility**: public
- **Source Range**: 6713:505:659
- **Details**: [function_test_constructor_InitialState.md](./function_test_constructor_InitialState.md)

**Signature:**
```solidity
/// @notice Tests if the constructor correctly sets initial roles and treasury.
function test_constructor_InitialState() public view;
```

### test_constructor_Revert_ZeroAdmin()

- **Signature**: `test_constructor_Revert_ZeroAdmin()`
- **Visibility**: public
- **Source Range**: 7296:433:659
- **Details**: [function_test_constructor_Revert_ZeroAdmin.md](./function_test_constructor_Revert_ZeroAdmin.md)

**Signature:**
```solidity
/// @notice Tests constructor revert on zero address superGovernor.
function test_constructor_Revert_ZeroAdmin() public;
```

### test_constructor_Revert_ZeroGovernor()

- **Signature**: `test_constructor_Revert_ZeroGovernor()`
- **Visibility**: public
- **Source Range**: 7802:438:659
- **Details**: [function_test_constructor_Revert_ZeroGovernor.md](./function_test_constructor_Revert_ZeroGovernor.md)

**Signature:**
```solidity
/// @notice Tests constructor revert on zero address governor.
function test_constructor_Revert_ZeroGovernor() public;
```

### test_constructor_Revert_ZeroTreasury()

- **Signature**: `test_constructor_Revert_ZeroTreasury()`
- **Visibility**: public
- **Source Range**: 8313:438:659
- **Details**: [function_test_constructor_Revert_ZeroTreasury.md](./function_test_constructor_Revert_ZeroTreasury.md)

**Signature:**
```solidity
/// @notice Tests constructor revert on zero address treasury.
function test_constructor_Revert_ZeroTreasury() public;
```

### test_constructor_Revert_ZeroOracleManager()

- **Signature**: `test_constructor_Revert_ZeroOracleManager()`
- **Visibility**: public
- **Source Range**: 8829:438:659
- **Details**: [function_test_constructor_Revert_ZeroOracleManager.md](./function_test_constructor_Revert_ZeroOracleManager.md)

**Signature:**
```solidity
/// @notice Tests constructor revert on zero address oracleManager.
function test_constructor_Revert_ZeroOracleManager() public;
```

### test_constructor_Revert_ZeroGuardian()

- **Signature**: `test_constructor_Revert_ZeroGuardian()`
- **Visibility**: public
- **Source Range**: 9340:438:659
- **Details**: [function_test_constructor_Revert_ZeroGuardian.md](./function_test_constructor_Revert_ZeroGuardian.md)

**Signature:**
```solidity
/// @notice Tests constructor revert on zero address guardian.
function test_constructor_Revert_ZeroGuardian() public;
```

### test_SupportsInterface_ISuperGovernor()

- **Signature**: `test_SupportsInterface_ISuperGovernor()`
- **Visibility**: public
- **Source Range**: 10125:240:659
- **Details**: [function_test_SupportsInterface_ISuperGovernor.md](./function_test_SupportsInterface_ISuperGovernor.md)

**Signature:**
```solidity
/// @notice Tests supportsInterface returns true for ISuperGovernor interface
///  @dev Covers SuperGovernor.sol:849 - ISuperGovernor interface detection
function test_SupportsInterface_ISuperGovernor() public view;
```

### test_SupportsInterface_IAccessControl()

- **Signature**: `test_SupportsInterface_IAccessControl()`
- **Visibility**: public
- **Source Range**: 10522:240:659
- **Details**: [function_test_SupportsInterface_IAccessControl.md](./function_test_SupportsInterface_IAccessControl.md)

**Signature:**
```solidity
/// @notice Tests supportsInterface returns true for IAccessControl interface
///  @dev Verifies inherited AccessControl interface is supported
function test_SupportsInterface_IAccessControl() public view;
```

### test_SupportsInterface_IERC165()

- **Signature**: `test_SupportsInterface_IERC165()`
- **Visibility**: public
- **Source Range**: 10903:219:659
- **Details**: [function_test_SupportsInterface_IERC165.md](./function_test_SupportsInterface_IERC165.md)

**Signature:**
```solidity
/// @notice Tests supportsInterface returns true for IERC165 interface
///  @dev Verifies ERC-165 interface itself is supported
function test_SupportsInterface_IERC165() public view;
```

### test_SupportsInterface_UnsupportedInterface()

- **Signature**: `test_SupportsInterface_UnsupportedInterface()`
- **Visibility**: public
- **Source Range**: 11283:261:659
- **Details**: [function_test_SupportsInterface_UnsupportedInterface.md](./function_test_SupportsInterface_UnsupportedInterface.md)

**Signature:**
```solidity
/// @notice Tests supportsInterface returns false for unsupported interface
///  @dev Tests with a random interface ID that should not be supported
function test_SupportsInterface_UnsupportedInterface() public view;
```

### test_SupportsInterface_ZeroInterfaceId()

- **Signature**: `test_SupportsInterface_ZeroInterfaceId()`
- **Visibility**: public
- **Source Range**: 11670:224:659
- **Details**: [function_test_SupportsInterface_ZeroInterfaceId.md](./function_test_SupportsInterface_ZeroInterfaceId.md)

**Signature:**
```solidity
/// @notice Tests supportsInterface returns false for zero interface ID
///  @dev Tests edge case with bytes4(0)
function test_SupportsInterface_ZeroInterfaceId() public view;
```

### test_SupportsInterface_InvalidInterfaceId()

- **Signature**: `test_SupportsInterface_InvalidInterfaceId()`
- **Visibility**: public
- **Source Range**: 12067:237:659
- **Details**: [function_test_SupportsInterface_InvalidInterfaceId.md](./function_test_SupportsInterface_InvalidInterfaceId.md)

**Signature:**
```solidity
/// @notice Tests supportsInterface returns false for invalid interface ID
///  @dev Tests with 0xffffffff which is an invalid/reserved interface ID in ERC-165
function test_SupportsInterface_InvalidInterfaceId() public view;
```

### test_SupportsInterface_MultipleKnownInterfaces()

- **Signature**: `test_SupportsInterface_MultipleKnownInterfaces()`
- **Visibility**: public
- **Source Range**: 12440:511:659
- **Details**: [function_test_SupportsInterface_MultipleKnownInterfaces.md](./function_test_SupportsInterface_MultipleKnownInterfaces.md)

**Signature:**
```solidity
/// @notice Tests supportsInterface with multiple known interfaces
///  @dev Verifies all supported interfaces return true
function test_SupportsInterface_MultipleKnownInterfaces() public view;
```

### test_Role_SuperGovernorOnlyFunctions()

- **Signature**: `test_Role_SuperGovernorOnlyFunctions()`
- **Visibility**: public
- **Source Range**: 13206:482:659
- **Details**: [function_test_Role_SuperGovernorOnlyFunctions.md](./function_test_Role_SuperGovernorOnlyFunctions.md)

**Signature:**
```solidity
/// @notice Tests that only SUPER_GOVERNOR_ROLE can call SUPER_GOVERNOR_ROLE functions.
function test_Role_SuperGovernorOnlyFunctions() public;
```

### test_Role_GovernorOnlyFunctions()

- **Signature**: `test_Role_GovernorOnlyFunctions()`
- **Visibility**: public
- **Source Range**: 13774:797:659
- **Details**: [function_test_Role_GovernorOnlyFunctions.md](./function_test_Role_GovernorOnlyFunctions.md)

**Signature:**
```solidity
/// @notice Tests that only GOVERNOR_ROLE can call GOVERNOR_ROLE functions.
function test_Role_GovernorOnlyFunctions() public;
```

### test_Role_TransferSuperGovernorRole()

- **Signature**: `test_Role_TransferSuperGovernorRole()`
- **Visibility**: public
- **Source Range**: 14756:3054:659
- **Details**: [function_test_Role_TransferSuperGovernorRole.md](./function_test_Role_TransferSuperGovernorRole.md)

**Signature:**
```solidity
/// @notice Tests transferring SUPER_GOVERNOR_ROLE to a new address after deployment
///  @dev Demonstrates the complete role transfer process including DEFAULT_ADMIN_ROLE
function test_Role_TransferSuperGovernorRole() public;
```

### test_Role_TransferSuperGovernorRole_Revert_Unauthorized()

- **Signature**: `test_Role_TransferSuperGovernorRole_Revert_Unauthorized()`
- **Visibility**: public
- **Source Range**: 17889:570:659
- **Details**: [function_test_Role_TransferSuperGovernorRole_Revert_Unauthorized.md](./function_test_Role_TransferSuperGovernorRole_Revert_Unauthorized.md)

**Signature:**
```solidity
/// @notice Tests that non-admin cannot transfer SUPER_GOVERNOR_ROLE
function test_Role_TransferSuperGovernorRole_Revert_Unauthorized() public;
```

### test_AddressRegistry_SetAndGetAddress()

- **Signature**: `test_AddressRegistry_SetAndGetAddress()`
- **Visibility**: public
- **Source Range**: 18688:338:659
- **Details**: [function_test_AddressRegistry_SetAndGetAddress.md](./function_test_AddressRegistry_SetAndGetAddress.md)

**Signature:**
```solidity
/// @notice Tests setting and getting an address.
function test_AddressRegistry_SetAndGetAddress() public;
```

### test_AddressRegistry_SetAddress_AccessControl()

- **Signature**: `test_AddressRegistry_SetAddress_AccessControl()`
- **Visibility**: public
- **Source Range**: 19099:585:659
- **Details**: [function_test_AddressRegistry_SetAddress_AccessControl.md](./function_test_AddressRegistry_SetAddress_AccessControl.md)

**Signature:**
```solidity
/// @notice Tests setting an address with SUPER_GOVERNOR_ROLE.
function test_AddressRegistry_SetAddress_AccessControl() public;
```

### test_AddressRegistry_SetAddress_Revert_ZeroAddress()

- **Signature**: `test_AddressRegistry_SetAddress_Revert_ZeroAddress()`
- **Visibility**: public
- **Source Range**: 19758:227:659
- **Details**: [function_test_AddressRegistry_SetAddress_Revert_ZeroAddress.md](./function_test_AddressRegistry_SetAddress_Revert_ZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests reverting when setting address to address(0).
function test_AddressRegistry_SetAddress_Revert_ZeroAddress() public;
```

### test_AddressRegistry_GetAddress_Revert_NotFound()

- **Signature**: `test_AddressRegistry_GetAddress_Revert_NotFound()`
- **Visibility**: public
- **Source Range**: 20060:203:659
- **Details**: [function_test_AddressRegistry_GetAddress_Revert_NotFound.md](./function_test_AddressRegistry_GetAddress_Revert_NotFound.md)

**Signature:**
```solidity
/// @notice Tests reverting when getting a non-existent address.
function test_AddressRegistry_GetAddress_Revert_NotFound() public;
```

### test_RoleGetters()

- **Signature**: `test_RoleGetters()`
- **Visibility**: public
- **Source Range**: 20428:379:659
- **Details**: [function_test_RoleGetters.md](./function_test_RoleGetters.md)

**Signature:**
```solidity
function test_RoleGetters() public view;
```

### test_IsGuardian()

- **Signature**: `test_IsGuardian()`
- **Visibility**: public
- **Source Range**: 20813:333:659
- **Details**: [function_test_IsGuardian.md](./function_test_IsGuardian.md)

**Signature:**
```solidity
function test_IsGuardian() public view;
```

### test_ManagerTakeover_ChangeManager()

- **Signature**: `test_ManagerTakeover_ChangeManager()`
- **Visibility**: public
- **Source Range**: 21377:377:659
- **Details**: [function_test_ManagerTakeover_ChangeManager.md](./function_test_ManagerTakeover_ChangeManager.md)

**Signature:**
```solidity
/// @notice Tests changing a manager for a strategy
function test_ManagerTakeover_ChangeManager() public;
```

### test_ManagerTakeover_Freeze()

- **Signature**: `test_ManagerTakeover_Freeze()`
- **Visibility**: public
- **Source Range**: 21809:333:659
- **Details**: [function_test_ManagerTakeover_Freeze.md](./function_test_ManagerTakeover_Freeze.md)

**Signature:**
```solidity
/// @notice Tests freezing manager takeovers
function test_ManagerTakeover_Freeze() public;
```

### test_ManagerTakeover_Revert_AlreadyFrozen()

- **Signature**: `test_ManagerTakeover_Revert_AlreadyFrozen()`
- **Visibility**: public
- **Source Range**: 22235:350:659
- **Details**: [function_test_ManagerTakeover_Revert_AlreadyFrozen.md](./function_test_ManagerTakeover_Revert_AlreadyFrozen.md)

**Signature:**
```solidity
/// @notice Tests reverting when trying to freeze already frozen manager takeovers
function test_ManagerTakeover_Revert_AlreadyFrozen() public;
```

### test_ManagerTakeover_Revert_FrozenChangeAttempt()

- **Signature**: `test_ManagerTakeover_Revert_FrozenChangeAttempt()`
- **Visibility**: public
- **Source Range**: 22666:581:659
- **Details**: [function_test_ManagerTakeover_Revert_FrozenChangeAttempt.md](./function_test_ManagerTakeover_Revert_FrozenChangeAttempt.md)

**Signature:**
```solidity
/// @notice Tests reverting when trying to change manager after freeze
function test_ManagerTakeover_Revert_FrozenChangeAttempt() public;
```

### test_ChangePrimaryManager_RevertsWhenAggregatorNotSet()

- **Signature**: `test_ChangePrimaryManager_RevertsWhenAggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 23433:840:659
- **Details**: [function_test_ChangePrimaryManager_RevertsWhenAggregatorNotSet.md](./function_test_ChangePrimaryManager_RevertsWhenAggregatorNotSet.md)

**Signature:**
```solidity
/// @notice Tests changePrimaryManager reverts when aggregator is not set
///  @dev Covers SuperGovernor.sol:190 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
function test_ChangePrimaryManager_RevertsWhenAggregatorNotSet() public;
```

### test_ChangePrimaryManager_RevertsOnUnauthorized()

- **Signature**: `test_ChangePrimaryManager_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 24447:1026:659
- **Details**: [function_test_ChangePrimaryManager_RevertsOnUnauthorized.md](./function_test_ChangePrimaryManager_RevertsOnUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests changePrimaryManager reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:185 - onlyRole(_SUPER_GOVERNOR_ROLE) modifier
function test_ChangePrimaryManager_RevertsOnUnauthorized() public;
```

### test_ChangePrimaryManager_SuccessWithAllConditions()

- **Signature**: `test_ChangePrimaryManager_SuccessWithAllConditions()`
- **Visibility**: public
- **Source Range**: 25662:1192:659
- **Details**: [function_test_ChangePrimaryManager_SuccessWithAllConditions.md](./function_test_ChangePrimaryManager_SuccessWithAllConditions.md)

**Signature:**
```solidity
/// @notice Tests changePrimaryManager success path with all checks passing
///  @dev Comprehensive test covering all conditions: not frozen, aggregator set, authorized caller
function test_ChangePrimaryManager_SuccessWithAllConditions() public;
```

### test_ChangePrimaryManager_WithZeroAddressManager()

- **Signature**: `test_ChangePrimaryManager_WithZeroAddressManager()`
- **Visibility**: public
- **Source Range**: 27035:562:659
- **Details**: [function_test_ChangePrimaryManager_WithZeroAddressManager.md](./function_test_ChangePrimaryManager_WithZeroAddressManager.md)

**Signature:**
```solidity
/// @notice Tests changePrimaryManager with zero address as new manager
///  @dev Tests edge case with zero address (should be caught by aggregator, not SuperGovernor)
function test_ChangePrimaryManager_WithZeroAddressManager() public;
```

### test_ChangePrimaryManager_WithZeroAddressFeeRecipient()

- **Signature**: `test_ChangePrimaryManager_WithZeroAddressFeeRecipient()`
- **Visibility**: public
- **Source Range**: 27681:259:659
- **Details**: [function_test_ChangePrimaryManager_WithZeroAddressFeeRecipient.md](./function_test_ChangePrimaryManager_WithZeroAddressFeeRecipient.md)

**Signature:**
```solidity
/// @notice Tests changePrimaryManager with zero address as fee recipient
function test_ChangePrimaryManager_WithZeroAddressFeeRecipient() public;
```

### test_HighWaterMarkReset_Revert_NotGovernor()

- **Signature**: `test_HighWaterMarkReset_Revert_NotGovernor()`
- **Visibility**: public
- **Source Range**: 28235:301:659
- **Details**: [function_test_HighWaterMarkReset_Revert_NotGovernor.md](./function_test_HighWaterMarkReset_Revert_NotGovernor.md)

**Signature:**
```solidity
/// @notice Tests resetting the high-water mark PPS to the current PPS when the caller is not the SuperGovernor
function test_HighWaterMarkReset_Revert_NotGovernor() public;
```

### test_HighWaterMarkReset_Revert_InvalidStrategy()

- **Signature**: `test_HighWaterMarkReset_Revert_InvalidStrategy()`
- **Visibility**: public
- **Source Range**: 28646:221:659
- **Details**: [function_test_HighWaterMarkReset_Revert_InvalidStrategy.md](./function_test_HighWaterMarkReset_Revert_InvalidStrategy.md)

**Signature:**
```solidity
/// @notice Tests resetting the high-water mark PPS to the current PPS when the strategy is not set
function test_HighWaterMarkReset_Revert_InvalidStrategy() public;
```

### test_HighWaterMarkReset_Revert_AggregatorNotSet()

- **Signature**: `test_HighWaterMarkReset_Revert_AggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 28979:810:659
- **Details**: [function_test_HighWaterMarkReset_Revert_AggregatorNotSet.md](./function_test_HighWaterMarkReset_Revert_AggregatorNotSet.md)

**Signature:**
```solidity
/// @notice Tests resetting the high-water mark PPS to the current PPS when the aggregator is not set
function test_HighWaterMarkReset_Revert_AggregatorNotSet() public;
```

### test_HighWaterMarkReset_Success()

- **Signature**: `test_HighWaterMarkReset_Success()`
- **Visibility**: public
- **Source Range**: 29870:397:659
- **Details**: [function_test_HighWaterMarkReset_Success.md](./function_test_HighWaterMarkReset_Success.md)

**Signature:**
```solidity
/// @notice Tests resetting the high-water mark PPS to the current PPS
function test_HighWaterMarkReset_Success() public;
```

### test_HookManagement_RegisterHook()

- **Signature**: `test_HookManagement_RegisterHook()`
- **Visibility**: public
- **Source Range**: 30482:317:659
- **Details**: [function_test_HookManagement_RegisterHook.md](./function_test_HookManagement_RegisterHook.md)

**Signature:**
```solidity
/// @notice Tests registering a hook
function test_HookManagement_RegisterHook() public;
```

### test_HookManagement_Revert_ZeroAddress()

- **Signature**: `test_HookManagement_Revert_ZeroAddress()`
- **Visibility**: public
- **Source Range**: 30879:206:659
- **Details**: [function_test_HookManagement_Revert_ZeroAddress.md](./function_test_HookManagement_Revert_ZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests reverting when registering a hook with zero address
function test_HookManagement_Revert_ZeroAddress() public;
```

### test_HookManagement_AlreadyRegistered_NoEvent()

- **Signature**: `test_HookManagement_AlreadyRegistered_NoEvent()`
- **Visibility**: public
- **Source Range**: 31177:559:659
- **Details**: [function_test_HookManagement_AlreadyRegistered_NoEvent.md](./function_test_HookManagement_AlreadyRegistered_NoEvent.md)

**Signature:**
```solidity
/// @notice Tests that registering an already registered hook doesn't emit events
function test_HookManagement_AlreadyRegistered_NoEvent() public;
```

### test_HookManagement_FulfillHookAlreadyRegistered_NoEvent()

- **Signature**: `test_HookManagement_FulfillHookAlreadyRegistered_NoEvent()`
- **Visibility**: public
- **Source Range**: 31845:632:659
- **Details**: [function_test_HookManagement_FulfillHookAlreadyRegistered_NoEvent.md](./function_test_HookManagement_FulfillHookAlreadyRegistered_NoEvent.md)

**Signature:**
```solidity
/// @notice Tests that registering an already registered fulfill requests hook doesn't emit events
function test_HookManagement_FulfillHookAlreadyRegistered_NoEvent() public;
```

### test_HookManagement_UnregisterHook()

- **Signature**: `test_HookManagement_UnregisterHook()`
- **Visibility**: public
- **Source Range**: 32526:453:659
- **Details**: [function_test_HookManagement_UnregisterHook.md](./function_test_HookManagement_UnregisterHook.md)

**Signature:**
```solidity
/// @notice Tests unregistering a hook
function test_HookManagement_UnregisterHook() public;
```

### test_HookManagement_FixedInvariantMaintenance()

- **Signature**: `test_HookManagement_FixedInvariantMaintenance()`
- **Visibility**: public
- **Source Range**: 33091:1457:659
- **Details**: [function_test_HookManagement_FixedInvariantMaintenance.md](./function_test_HookManagement_FixedInvariantMaintenance.md)

**Signature:**
```solidity
/// @notice Tests the fix for the dangerous hook registration behavior where sets can get out of sync
function test_HookManagement_FixedInvariantMaintenance() public;
```

### test_HookManagement_GetRegisteredHooks()

- **Signature**: `test_HookManagement_GetRegisteredHooks()`
- **Visibility**: public
- **Source Range**: 34613:558:659
- **Details**: [function_test_HookManagement_GetRegisteredHooks.md](./function_test_HookManagement_GetRegisteredHooks.md)

**Signature:**
```solidity
/// @notice Tests getting the list of registered hooks
function test_HookManagement_GetRegisteredHooks() public;
```

### test_ChangeHooksRootUpdateTimelock()

- **Signature**: `test_ChangeHooksRootUpdateTimelock()`
- **Visibility**: public
- **Source Range**: 35177:274:659
- **Details**: [function_test_ChangeHooksRootUpdateTimelock.md](./function_test_ChangeHooksRootUpdateTimelock.md)

**Signature:**
```solidity
function test_ChangeHooksRootUpdateTimelock() public;
```

### test_ChangeHooksRootUpdateTimelock_RevertsWhenAggregatorNotSet()

- **Signature**: `test_ChangeHooksRootUpdateTimelock_RevertsWhenAggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 35650:757:659
- **Details**: [function_test_ChangeHooksRootUpdateTimelock_RevertsWhenAggregatorNotSet.md](./function_test_ChangeHooksRootUpdateTimelock_RevertsWhenAggregatorNotSet.md)

**Signature:**
```solidity
/// @notice Tests changeHooksRootUpdateTimelock reverts when aggregator is not set
///  @dev Covers SuperGovernor.sol:210-211 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
function test_ChangeHooksRootUpdateTimelock_RevertsWhenAggregatorNotSet() public;
```

### test_ChangeHooksRootUpdateTimelock_RevertsOnUnauthorized()

- **Signature**: `test_ChangeHooksRootUpdateTimelock_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 36590:696:659
- **Details**: [function_test_ChangeHooksRootUpdateTimelock_RevertsOnUnauthorized.md](./function_test_ChangeHooksRootUpdateTimelock_RevertsOnUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests changeHooksRootUpdateTimelock reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:209 - onlyRole(_SUPER_GOVERNOR_ROLE) modifier
function test_ChangeHooksRootUpdateTimelock_RevertsOnUnauthorized() public;
```

### test_ChangeHooksRootUpdateTimelock_AllowsZeroTimelock()

- **Signature**: `test_ChangeHooksRootUpdateTimelock_AllowsZeroTimelock()`
- **Visibility**: public
- **Source Range**: 37471:312:659
- **Details**: [function_test_ChangeHooksRootUpdateTimelock_AllowsZeroTimelock.md](./function_test_ChangeHooksRootUpdateTimelock_AllowsZeroTimelock.md)

**Signature:**
```solidity
/// @notice Tests changeHooksRootUpdateTimelock allows zero timelock (emergency use)
///  @dev Verifies that zero timelock is intentionally allowed for SUPER_GOVERNOR_ROLE
function test_ChangeHooksRootUpdateTimelock_AllowsZeroTimelock() public;
```

### test_ProposeGlobalHooksRoot_Success()

- **Signature**: `test_ProposeGlobalHooksRoot_Success()`
- **Visibility**: public
- **Source Range**: 37893:354:659
- **Details**: [function_test_ProposeGlobalHooksRoot_Success.md](./function_test_ProposeGlobalHooksRoot_Success.md)

**Signature:**
```solidity
/// @notice Tests proposeGlobalHooksRoot success path
///  @dev Covers SuperGovernor.sol:220-225
function test_ProposeGlobalHooksRoot_Success() public;
```

### test_ProposeGlobalHooksRoot_RevertsWhenAggregatorNotSet()

- **Signature**: `test_ProposeGlobalHooksRoot_RevertsWhenAggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 38439:1010:659
- **Details**: [function_test_ProposeGlobalHooksRoot_RevertsWhenAggregatorNotSet.md](./function_test_ProposeGlobalHooksRoot_RevertsWhenAggregatorNotSet.md)

**Signature:**
```solidity
/// @notice Tests proposeGlobalHooksRoot reverts when aggregator is not set
///  @dev Covers SuperGovernor.sol:221-222 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
function test_ProposeGlobalHooksRoot_RevertsWhenAggregatorNotSet() public;
```

### test_ProposeGlobalHooksRoot_RevertsOnUnauthorized()

- **Signature**: `test_ProposeGlobalHooksRoot_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 39619:731:659
- **Details**: [function_test_ProposeGlobalHooksRoot_RevertsOnUnauthorized.md](./function_test_ProposeGlobalHooksRoot_RevertsOnUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests proposeGlobalHooksRoot reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:220 - onlyRole(_GOVERNOR_ROLE) modifier
function test_ProposeGlobalHooksRoot_RevertsOnUnauthorized() public;
```

### test_SetGlobalHooksVetoStatus()

- **Signature**: `test_SetGlobalHooksVetoStatus()`
- **Visibility**: public
- **Source Range**: 40356:262:659
- **Details**: [function_test_SetGlobalHooksVetoStatus.md](./function_test_SetGlobalHooksVetoStatus.md)

**Signature:**
```solidity
function test_SetGlobalHooksVetoStatus() public;
```

### test_SetGlobalHooksVetoStatus_RevertsWhenAggregatorNotSet()

- **Signature**: `test_SetGlobalHooksVetoStatus_RevertsWhenAggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 40816:746:659
- **Details**: [function_test_SetGlobalHooksVetoStatus_RevertsWhenAggregatorNotSet.md](./function_test_SetGlobalHooksVetoStatus_RevertsWhenAggregatorNotSet.md)

**Signature:**
```solidity
/// @notice Tests setGlobalHooksRootVetoStatus reverts when aggregator is not set
///  @dev Covers SuperGovernor.sol:229-230 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
function test_SetGlobalHooksVetoStatus_RevertsWhenAggregatorNotSet() public;
```

### test_SetGlobalHooksVetoStatus_RevertsOnUnauthorized()

- **Signature**: `test_SetGlobalHooksVetoStatus_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 41738:737:659
- **Details**: [function_test_SetGlobalHooksVetoStatus_RevertsOnUnauthorized.md](./function_test_SetGlobalHooksVetoStatus_RevertsOnUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests setGlobalHooksRootVetoStatus reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:228 - onlyRole(_GUARDIAN_ROLE) modifier
function test_SetGlobalHooksVetoStatus_RevertsOnUnauthorized() public;
```

### test_SetStrategyHooksVetoStatus()

- **Signature**: `test_SetStrategyHooksVetoStatus()`
- **Visibility**: public
- **Source Range**: 42481:308:659
- **Details**: [function_test_SetStrategyHooksVetoStatus.md](./function_test_SetStrategyHooksVetoStatus.md)

**Signature:**
```solidity
function test_SetStrategyHooksVetoStatus() public;
```

### test_SetStrategyHooksVetoStatus_RevertsOnZeroStrategy()

- **Signature**: `test_SetStrategyHooksVetoStatus_RevertsOnZeroStrategy()`
- **Visibility**: public
- **Source Range**: 42983:245:659
- **Details**: [function_test_SetStrategyHooksVetoStatus_RevertsOnZeroStrategy.md](./function_test_SetStrategyHooksVetoStatus_RevertsOnZeroStrategy.md)

**Signature:**
```solidity
/// @notice Tests setStrategyHooksRootVetoStatus reverts when strategy is zero address
///  @dev Covers SuperGovernor.sol:237 - if (strategy == address(0)) revert INVALID_ADDRESS()
function test_SetStrategyHooksVetoStatus_RevertsOnZeroStrategy() public;
```

### test_SetStrategyHooksVetoStatus_RevertsWhenAggregatorNotSet()

- **Signature**: `test_SetStrategyHooksVetoStatus_RevertsWhenAggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 43428:761:659
- **Details**: [function_test_SetStrategyHooksVetoStatus_RevertsWhenAggregatorNotSet.md](./function_test_SetStrategyHooksVetoStatus_RevertsWhenAggregatorNotSet.md)

**Signature:**
```solidity
/// @notice Tests setStrategyHooksRootVetoStatus reverts when aggregator is not set
///  @dev Covers SuperGovernor.sol:239-240 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
function test_SetStrategyHooksVetoStatus_RevertsWhenAggregatorNotSet() public;
```

### test_SetStrategyHooksVetoStatus_RevertsOnUnauthorized()

- **Signature**: `test_SetStrategyHooksVetoStatus_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 44367:765:659
- **Details**: [function_test_SetStrategyHooksVetoStatus_RevertsOnUnauthorized.md](./function_test_SetStrategyHooksVetoStatus_RevertsOnUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests setStrategyHooksRootVetoStatus reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:236 - onlyRole(_GUARDIAN_ROLE) modifier
function test_SetStrategyHooksVetoStatus_RevertsOnUnauthorized() public;
```

### test_ExecuteUpkeepClaim_PassesAggregatorCheck()

- **Signature**: `test_ExecuteUpkeepClaim_PassesAggregatorCheck()`
- **Visibility**: public
- **Source Range**: 45480:836:659
- **Details**: [function_test_ExecuteUpkeepClaim_PassesAggregatorCheck.md](./function_test_ExecuteUpkeepClaim_PassesAggregatorCheck.md)

**Signature:**
```solidity
/// @notice Tests executeUpkeepClaim passes aggregator check when set
///  @dev Covers SuperGovernor.sol:513 - aggregator check passes when aggregator is set
///  Note: May fail with INSUFFICIENT_UPKEEP if no upkeep balance exists, but that validates
///  the aggregator check passed (since CONTRACT_NOT_FOUND would occur first)
function test_ExecuteUpkeepClaim_PassesAggregatorCheck() public;
```

### test_ExecuteUpkeepClaim_RevertsWhenAggregatorNotSet()

- **Signature**: `test_ExecuteUpkeepClaim_RevertsWhenAggregatorNotSet()`
- **Visibility**: public
- **Source Range**: 46500:887:659
- **Details**: [function_test_ExecuteUpkeepClaim_RevertsWhenAggregatorNotSet.md](./function_test_ExecuteUpkeepClaim_RevertsWhenAggregatorNotSet.md)

**Signature:**
```solidity
/// @notice Tests executeUpkeepClaim reverts when aggregator is not set
///  @dev Covers SuperGovernor.sol:513 - if (aggregator == address(0)) revert CONTRACT_NOT_FOUND()
function test_ExecuteUpkeepClaim_RevertsWhenAggregatorNotSet() public;
```

### test_ExecuteUpkeepClaim_RevertsOnUnauthorized()

- **Signature**: `test_ExecuteUpkeepClaim_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 47553:568:659
- **Details**: [function_test_ExecuteUpkeepClaim_RevertsOnUnauthorized.md](./function_test_ExecuteUpkeepClaim_RevertsOnUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests executeUpkeepClaim reverts when called by unauthorized user
///  @dev Covers SuperGovernor.sol:511 - onlyRole(_GOVERNOR_ROLE) modifier
function test_ExecuteUpkeepClaim_RevertsOnUnauthorized() public;
```

### test_ExecuteUpkeepClaim_WithZeroAmount()

- **Signature**: `test_ExecuteUpkeepClaim_WithZeroAmount()`
- **Visibility**: public
- **Source Range**: 48235:189:659
- **Details**: [function_test_ExecuteUpkeepClaim_WithZeroAmount.md](./function_test_ExecuteUpkeepClaim_WithZeroAmount.md)

**Signature:**
```solidity
/// @notice Tests executeUpkeepClaim with zero amount
///  @dev Edge case test for zero claim amount
function test_ExecuteUpkeepClaim_WithZeroAmount() public;
```

### test_ExecuteUpkeepClaim_Success()

- **Signature**: `test_ExecuteUpkeepClaim_Success()`
- **Visibility**: public
- **Source Range**: 48594:747:659
- **Details**: [function_test_ExecuteUpkeepClaim_Success.md](./function_test_ExecuteUpkeepClaim_Success.md)

**Signature:**
```solidity
/// @notice Tests executeUpkeepClaim successfully delegates to aggregator
///  @dev Covers SuperGovernor.sol:511-516 success path with aggregator delegation
function test_ExecuteUpkeepClaim_Success() public;
```

### test_ExecuteUpkeepClaim_ZeroAmountDelegation()

- **Signature**: `test_ExecuteUpkeepClaim_ZeroAmountDelegation()`
- **Visibility**: public
- **Source Range**: 49492:740:659
- **Details**: [function_test_ExecuteUpkeepClaim_ZeroAmountDelegation.md](./function_test_ExecuteUpkeepClaim_ZeroAmountDelegation.md)

**Signature:**
```solidity
/// @notice Tests executeUpkeepClaim with zero amount delegates correctly
///  @dev Verifies zero amount is properly passed to aggregator
function test_ExecuteUpkeepClaim_ZeroAmountDelegation() public;
```

### test_ExecuteUpkeepClaim_LargeAmount()

- **Signature**: `test_ExecuteUpkeepClaim_LargeAmount()`
- **Visibility**: public
- **Source Range**: 50367:814:659
- **Details**: [function_test_ExecuteUpkeepClaim_LargeAmount.md](./function_test_ExecuteUpkeepClaim_LargeAmount.md)

**Signature:**
```solidity
/// @notice Tests executeUpkeepClaim with large amount
///  @dev Verifies large amounts are properly passed to aggregator
function test_ExecuteUpkeepClaim_LargeAmount() public;
```

### test_ValidatorManagement_SetValidatorConfig()

- **Signature**: `test_ValidatorManagement_SetValidatorConfig()`
- **Visibility**: public
- **Source Range**: 51414:863:659
- **Details**: [function_test_ValidatorManagement_SetValidatorConfig.md](./function_test_ValidatorManagement_SetValidatorConfig.md)

**Signature:**
```solidity
/// @notice Tests setting validator configuration
function test_ValidatorManagement_SetValidatorConfig() public;
```

### test_ValidatorManagement_GetValidatorAt()

- **Signature**: `test_ValidatorManagement_GetValidatorAt()`
- **Visibility**: public
- **Source Range**: 52354:1782:659
- **Details**: [function_test_ValidatorManagement_GetValidatorAt.md](./function_test_ValidatorManagement_GetValidatorAt.md)

**Signature:**
```solidity
/// @notice Tests getting validators by index using getValidatorAt
function test_ValidatorManagement_GetValidatorAt() public;
```

### test_ValidatorManagement_Revert_ZeroAddress()

- **Signature**: `test_ValidatorManagement_Revert_ZeroAddress()`
- **Visibility**: public
- **Source Range**: 54222:439:659
- **Details**: [function_test_ValidatorManagement_Revert_ZeroAddress.md](./function_test_ValidatorManagement_Revert_ZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests reverting when setting validator config with zero address
function test_ValidatorManagement_Revert_ZeroAddress() public;
```

### test_ValidatorManagement_Revert_DuplicateValidators()

- **Signature**: `test_ValidatorManagement_Revert_DuplicateValidators()`
- **Visibility**: public
- **Source Range**: 54742:608:659
- **Details**: [function_test_ValidatorManagement_Revert_DuplicateValidators.md](./function_test_ValidatorManagement_Revert_DuplicateValidators.md)

**Signature:**
```solidity
/// @notice Tests reverting when adding duplicate validators in config
function test_ValidatorManagement_Revert_DuplicateValidators() public;
```

### test_ValidatorManagement_RemoveValidatorByConfig()

- **Signature**: `test_ValidatorManagement_RemoveValidatorByConfig()`
- **Visibility**: public
- **Source Range**: 55417:1044:659
- **Details**: [function_test_ValidatorManagement_RemoveValidatorByConfig.md](./function_test_ValidatorManagement_RemoveValidatorByConfig.md)

**Signature:**
```solidity
/// @notice Tests removing validators by updating config
function test_ValidatorManagement_RemoveValidatorByConfig() public;
```

### test_ValidatorManagement_UpdateConfigWithMultiple()

- **Signature**: `test_ValidatorManagement_UpdateConfigWithMultiple()`
- **Visibility**: public
- **Source Range**: 56540:1305:659
- **Details**: [function_test_ValidatorManagement_UpdateConfigWithMultiple.md](./function_test_ValidatorManagement_UpdateConfigWithMultiple.md)

**Signature:**
```solidity
/// @notice Tests updating validator config with multiple validators
function test_ValidatorManagement_UpdateConfigWithMultiple() public;
```

### test_ValidatorManagement_Revert_EmptyValidatorArray()

- **Signature**: `test_ValidatorManagement_Revert_EmptyValidatorArray()`
- **Visibility**: public
- **Source Range**: 57924:370:659
- **Details**: [function_test_ValidatorManagement_Revert_EmptyValidatorArray.md](./function_test_ValidatorManagement_Revert_EmptyValidatorArray.md)

**Signature:**
```solidity
/// @notice Tests reverting when trying to set empty validator array
function test_ValidatorManagement_Revert_EmptyValidatorArray() public;
```

### test_ValidatorManagement_Revert_ArrayLengthMismatch()

- **Signature**: `test_ValidatorManagement_Revert_ArrayLengthMismatch()`
- **Visibility**: public
- **Source Range**: 58385:509:659
- **Details**: [function_test_ValidatorManagement_Revert_ArrayLengthMismatch.md](./function_test_ValidatorManagement_Revert_ArrayLengthMismatch.md)

**Signature:**
```solidity
/// @notice Tests reverting when validator and public key array lengths mismatch
function test_ValidatorManagement_Revert_ArrayLengthMismatch() public;
```

### test_ValidatorManagement_Revert_QuorumExceedsValidators()

- **Signature**: `test_ValidatorManagement_Revert_QuorumExceedsValidators()`
- **Visibility**: public
- **Source Range**: 58968:547:659
- **Details**: [function_test_ValidatorManagement_Revert_QuorumExceedsValidators.md](./function_test_ValidatorManagement_Revert_QuorumExceedsValidators.md)

**Signature:**
```solidity
/// @notice Tests reverting when quorum exceeds validator count
function test_ValidatorManagement_Revert_QuorumExceedsValidators() public;
```

### test_ValidatorManagement_QuorumEqualsValidators()

- **Signature**: `test_ValidatorManagement_QuorumEqualsValidators()`
- **Visibility**: public
- **Source Range**: 59589:734:659
- **Details**: [function_test_ValidatorManagement_QuorumEqualsValidators.md](./function_test_ValidatorManagement_QuorumEqualsValidators.md)

**Signature:**
```solidity
/// @notice Tests edge case where quorum equals validator count
function test_ValidatorManagement_QuorumEqualsValidators() public;
```

### test_ValidatorManagement_MinimumQuorum()

- **Signature**: `test_ValidatorManagement_MinimumQuorum()`
- **Visibility**: public
- **Source Range**: 60378:617:659
- **Details**: [function_test_ValidatorManagement_MinimumQuorum.md](./function_test_ValidatorManagement_MinimumQuorum.md)

**Signature:**
```solidity
/// @notice Tests edge case with quorum of 1
function test_ValidatorManagement_MinimumQuorum() public;
```

### test_ValidatorManagement_VersionTracking()

- **Signature**: `test_ValidatorManagement_VersionTracking()`
- **Visibility**: public
- **Source Range**: 61071:822:659
- **Details**: [function_test_ValidatorManagement_VersionTracking.md](./function_test_ValidatorManagement_VersionTracking.md)

**Signature:**
```solidity
/// @notice Tests version tracking across multiple config updates
function test_ValidatorManagement_VersionTracking() public;
```

### test_ValidatorManagement_PublicKeysStorage()

- **Signature**: `test_ValidatorManagement_PublicKeysStorage()`
- **Visibility**: public
- **Source Range**: 61955:793:659
- **Details**: [function_test_ValidatorManagement_PublicKeysStorage.md](./function_test_ValidatorManagement_PublicKeysStorage.md)

**Signature:**
```solidity
/// @notice Tests public keys storage and retrieval
function test_ValidatorManagement_PublicKeysStorage() public;
```

### test_ValidatorManagement_OffchainConfigEmission()

- **Signature**: `test_ValidatorManagement_OffchainConfigEmission()`
- **Visibility**: public
- **Source Range**: 62824:711:659
- **Details**: [function_test_ValidatorManagement_OffchainConfigEmission.md](./function_test_ValidatorManagement_OffchainConfigEmission.md)

**Signature:**
```solidity
/// @notice Tests offchain config parameter emission (not stored)
function test_ValidatorManagement_OffchainConfigEmission() public;
```

### test_ValidatorManagement_ValidatorClearing()

- **Signature**: `test_ValidatorManagement_ValidatorClearing()`
- **Visibility**: public
- **Source Range**: 63628:1721:659
- **Details**: [function_test_ValidatorManagement_ValidatorClearing.md](./function_test_ValidatorManagement_ValidatorClearing.md)

**Signature:**
```solidity
/// @notice Tests that old validators are properly cleared when setting new config
function test_ValidatorManagement_ValidatorClearing() public;
```

### test_ValidatorManagement_LargeValidatorSet()

- **Signature**: `test_ValidatorManagement_LargeValidatorSet()`
- **Visibility**: public
- **Source Range**: 65429:1066:659
- **Details**: [function_test_ValidatorManagement_LargeValidatorSet.md](./function_test_ValidatorManagement_LargeValidatorSet.md)

**Signature:**
```solidity
/// @notice Tests setting validator config with a large validator set
function test_ValidatorManagement_LargeValidatorSet() public;
```

### test_ValidatorManagement_EventEmissionWithQuorum()

- **Signature**: `test_ValidatorManagement_EventEmissionWithQuorum()`
- **Visibility**: public
- **Source Range**: 66585:966:659
- **Details**: [function_test_ValidatorManagement_EventEmissionWithQuorum.md](./function_test_ValidatorManagement_EventEmissionWithQuorum.md)

**Signature:**
```solidity
/// @notice Tests that ValidatorConfigSet event is emitted with quorum included
function test_ValidatorManagement_EventEmissionWithQuorum() public;
```

### test_PPSOracleManagement_ProposeActivePPSOracle()

- **Signature**: `test_PPSOracleManagement_ProposeActivePPSOracle()`
- **Visibility**: public
- **Source Range**: 67787:611:659
- **Details**: [function_test_PPSOracleManagement_ProposeActivePPSOracle.md](./function_test_PPSOracleManagement_ProposeActivePPSOracle.md)

**Signature:**
```solidity
/// @notice Tests proposing a new active PPS Oracle
function test_PPSOracleManagement_ProposeActivePPSOracle() public;
```

### test_SetActivePPSOracle_Revert_MustUseTimelock()

- **Signature**: `test_SetActivePPSOracle_Revert_MustUseTimelock()`
- **Visibility**: public
- **Source Range**: 68404:317:659
- **Details**: [function_test_SetActivePPSOracle_Revert_MustUseTimelock.md](./function_test_SetActivePPSOracle_Revert_MustUseTimelock.md)

**Signature:**
```solidity
function test_SetActivePPSOracle_Revert_MustUseTimelock() public;
```

### test_PPSOracleManagement_Revert_ProposeZeroAddress()

- **Signature**: `test_PPSOracleManagement_Revert_ProposeZeroAddress()`
- **Visibility**: public
- **Source Range**: 68805:229:659
- **Details**: [function_test_PPSOracleManagement_Revert_ProposeZeroAddress.md](./function_test_PPSOracleManagement_Revert_ProposeZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests reverting when proposing a PPS Oracle with zero address
function test_PPSOracleManagement_Revert_ProposeZeroAddress() public;
```

### test_PPSOracleManagement_Revert_SetActiveZeroAddress()

- **Signature**: `test_PPSOracleManagement_Revert_SetActiveZeroAddress()`
- **Visibility**: public
- **Source Range**: 69216:227:659
- **Details**: [function_test_PPSOracleManagement_Revert_SetActiveZeroAddress.md](./function_test_PPSOracleManagement_Revert_SetActiveZeroAddress.md)

**Signature:**
```solidity
/// @notice Tests reverting when setting active PPS Oracle with zero address
///  @dev Covers SuperGovernor.sol:427 - if (oracle == address(0)) revert INVALID_ADDRESS()
function test_PPSOracleManagement_Revert_SetActiveZeroAddress() public;
```

### test_PPSOracleManagement_ExecuteActivePPSOracleChange()

- **Signature**: `test_PPSOracleManagement_ExecuteActivePPSOracleChange()`
- **Visibility**: public
- **Source Range**: 69501:919:659
- **Details**: [function_test_PPSOracleManagement_ExecuteActivePPSOracleChange.md](./function_test_PPSOracleManagement_ExecuteActivePPSOracleChange.md)

**Signature:**
```solidity
/// @notice Tests executing a PPS Oracle change
function test_PPSOracleManagement_ExecuteActivePPSOracleChange() public;
```

### test_PPSOracleManagement_Revert_ExecuteNoProposal()

- **Signature**: `test_PPSOracleManagement_Revert_ExecuteNoProposal()`
- **Visibility**: public
- **Source Range**: 70492:202:659
- **Details**: [function_test_PPSOracleManagement_Revert_ExecuteNoProposal.md](./function_test_PPSOracleManagement_Revert_ExecuteNoProposal.md)

**Signature:**
```solidity
/// @notice Tests reverting when executing without a proposal
function test_PPSOracleManagement_Revert_ExecuteNoProposal() public;
```

### test_PPSOracleManagement_Revert_ExecuteBeforeTimelock()

- **Signature**: `test_PPSOracleManagement_Revert_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 70770:378:659
- **Details**: [function_test_PPSOracleManagement_Revert_ExecuteBeforeTimelock.md](./function_test_PPSOracleManagement_Revert_ExecuteBeforeTimelock.md)

**Signature:**
```solidity
/// @notice Tests reverting when executing before timelock expiry
function test_PPSOracleManagement_Revert_ExecuteBeforeTimelock() public;
```

### test_ValidatorManagement_SetValidatorConfigWithQuorum()

- **Signature**: `test_ValidatorManagement_SetValidatorConfigWithQuorum()`
- **Visibility**: public
- **Source Range**: 71229:1233:659
- **Details**: [function_test_ValidatorManagement_SetValidatorConfigWithQuorum.md](./function_test_ValidatorManagement_SetValidatorConfigWithQuorum.md)

**Signature:**
```solidity
/// @notice Tests setting the validator configuration including quorum
function test_ValidatorManagement_SetValidatorConfigWithQuorum() public;
```

### test_GasInfo_SetGasInfo_Success()

- **Signature**: `test_GasInfo_SetGasInfo_Success()`
- **Visibility**: public
- **Source Range**: 72692:395:659
- **Details**: [function_test_GasInfo_SetGasInfo_Success.md](./function_test_GasInfo_SetGasInfo_Success.md)

**Signature:**
```solidity
/// @notice Tests setting gas info successfully
function test_GasInfo_SetGasInfo_Success() public;
```

### test_GasInfo_SetGasInfo_RevertsOnZeroOracle()

- **Signature**: `test_GasInfo_SetGasInfo_RevertsOnZeroOracle()`
- **Visibility**: public
- **Source Range**: 73267:275:659
- **Details**: [function_test_GasInfo_SetGasInfo_RevertsOnZeroOracle.md](./function_test_GasInfo_SetGasInfo_RevertsOnZeroOracle.md)

**Signature:**
```solidity
/// @notice Tests reverting when setting gas info with zero address oracle
///  @dev Covers SuperGovernor.sol:523 - if (oracle == address(0)) revert INVALID_ADDRESS()
function test_GasInfo_SetGasInfo_RevertsOnZeroOracle() public;
```

### test_GasInfo_SetGasInfo_RevertsOnZeroGas()

- **Signature**: `test_GasInfo_SetGasInfo_RevertsOnZeroGas()`
- **Visibility**: public
- **Source Range**: 73730:256:659
- **Details**: [function_test_GasInfo_SetGasInfo_RevertsOnZeroGas.md](./function_test_GasInfo_SetGasInfo_RevertsOnZeroGas.md)

**Signature:**
```solidity
/// @notice Tests reverting when setting gas info with zero gas increase
///  @dev Covers SuperGovernor.sol:524 - if (gasIncreasePerEntryBatch == 0) revert INVALID_GAS_INFO()
function test_GasInfo_SetGasInfo_RevertsOnZeroGas() public;
```

### test_GasInfo_SetGasInfo_AccessControl()

- **Signature**: `test_GasInfo_SetGasInfo_AccessControl()`
- **Visibility**: public
- **Source Range**: 74112:1211:659
- **Details**: [function_test_GasInfo_SetGasInfo_AccessControl.md](./function_test_GasInfo_SetGasInfo_AccessControl.md)

**Signature:**
```solidity
/// @notice Tests setGasInfo access control
///  @dev Covers SuperGovernor.sol:522 - onlyRole(_GAS_MANAGER_ROLE)
function test_GasInfo_SetGasInfo_AccessControl() public;
```

### test_GasInfo_SetGasInfo_EmitsEvent()

- **Signature**: `test_GasInfo_SetGasInfo_EmitsEvent()`
- **Visibility**: public
- **Source Range**: 75476:362:659
- **Details**: [function_test_GasInfo_SetGasInfo_EmitsEvent.md](./function_test_GasInfo_SetGasInfo_EmitsEvent.md)

**Signature:**
```solidity
/// @notice Tests setGasInfo emits correct event
///  @dev Covers SuperGovernor.sol:527 - emit GasInfoSet(oracle, gasIncreasePerEntryBatch)
function test_GasInfo_SetGasInfo_EmitsEvent() public;
```

### test_GasInfo_SetGasInfo_MultipleUpdates()

- **Signature**: `test_GasInfo_SetGasInfo_MultipleUpdates()`
- **Visibility**: public
- **Source Range**: 76001:880:659
- **Details**: [function_test_GasInfo_SetGasInfo_MultipleUpdates.md](./function_test_GasInfo_SetGasInfo_MultipleUpdates.md)

**Signature:**
```solidity
/// @notice Tests updating gas info multiple times for the same oracle
///  @dev Verifies that gas info can be updated and the latest value is stored
function test_GasInfo_SetGasInfo_MultipleUpdates() public;
```

### test_GasInfo_SetGasInfo_LargeValue()

- **Signature**: `test_GasInfo_SetGasInfo_LargeValue()`
- **Visibility**: public
- **Source Range**: 77010:359:659
- **Details**: [function_test_GasInfo_SetGasInfo_LargeValue.md](./function_test_GasInfo_SetGasInfo_LargeValue.md)

**Signature:**
```solidity
/// @notice Tests setGasInfo with large gas values
///  @dev Verifies that large uint256 values are properly stored
function test_GasInfo_SetGasInfo_LargeValue() public;
```

### test_GasInfo_SetGasInfo_MultipleOracles()

- **Signature**: `test_GasInfo_SetGasInfo_MultipleOracles()`
- **Visibility**: public
- **Source Range**: 77516:914:659
- **Details**: [function_test_GasInfo_SetGasInfo_MultipleOracles.md](./function_test_GasInfo_SetGasInfo_MultipleOracles.md)

**Signature:**
```solidity
/// @notice Tests setGasInfo with multiple different oracles
///  @dev Verifies that gas info is stored independently for each oracle
function test_GasInfo_SetGasInfo_MultipleOracles() public;
```

### test_FeeManagement_ProposeFee()

- **Signature**: `test_FeeManagement_ProposeFee()`
- **Visibility**: public
- **Source Range**: 78645:520:659
- **Details**: [function_test_FeeManagement_ProposeFee.md](./function_test_FeeManagement_ProposeFee.md)

**Signature:**
```solidity
/// @notice Tests proposing a new fee
function test_FeeManagement_ProposeFee() public;
```

### test_FeeManagement_Revert_InvalidFeeValue()

- **Signature**: `test_FeeManagement_Revert_InvalidFeeValue()`
- **Visibility**: public
- **Source Range**: 79239:341:659
- **Details**: [function_test_FeeManagement_Revert_InvalidFeeValue.md](./function_test_FeeManagement_Revert_InvalidFeeValue.md)

**Signature:**
```solidity
/// @notice Tests reverting when proposing an invalid fee value
function test_FeeManagement_Revert_InvalidFeeValue() public;
```

### test_FeeManagement_ExecuteFeeUpdate()

- **Signature**: `test_FeeManagement_ExecuteFeeUpdate()`
- **Visibility**: public
- **Source Range**: 79631:633:659
- **Details**: [function_test_FeeManagement_ExecuteFeeUpdate.md](./function_test_FeeManagement_ExecuteFeeUpdate.md)

**Signature:**
```solidity
/// @notice Tests executing a fee update
function test_FeeManagement_ExecuteFeeUpdate() public;
```

### test_FeeManagement_Revert_ExecuteNoProposal()

- **Signature**: `test_FeeManagement_Revert_ExecuteNoProposal()`
- **Visibility**: public
- **Source Range**: 80349:267:659
- **Details**: [function_test_FeeManagement_Revert_ExecuteNoProposal.md](./function_test_FeeManagement_Revert_ExecuteNoProposal.md)

**Signature:**
```solidity
/// @notice Tests reverting when executing a fee update without a proposal
function test_FeeManagement_Revert_ExecuteNoProposal() public;
```

### test_FeeManagement_Revert_ExecuteBeforeTimelock()

- **Signature**: `test_FeeManagement_Revert_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 80705:458:659
- **Details**: [function_test_FeeManagement_Revert_ExecuteBeforeTimelock.md](./function_test_FeeManagement_Revert_ExecuteBeforeTimelock.md)

**Signature:**
```solidity
/// @notice Tests reverting when executing a fee update before timelock expiry
function test_FeeManagement_Revert_ExecuteBeforeTimelock() public;
```

### test_UpkeepPayments_GetProposedStatus_InitialState()

- **Signature**: `test_UpkeepPayments_GetProposedStatus_InitialState()`
- **Visibility**: public
- **Source Range**: 81489:321:659
- **Details**: [function_test_UpkeepPayments_GetProposedStatus_InitialState.md](./function_test_UpkeepPayments_GetProposedStatus_InitialState.md)

**Signature:**
```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus returns initial state
///  @dev Verifies default values before any proposal is made
function test_UpkeepPayments_GetProposedStatus_InitialState() public view;
```

### test_UpkeepPayments_GetProposedStatus_AfterProposeEnable()

- **Signature**: `test_UpkeepPayments_GetProposedStatus_AfterProposeEnable()`
- **Visibility**: public
- **Source Range**: 81973:472:659
- **Details**: [function_test_UpkeepPayments_GetProposedStatus_AfterProposeEnable.md](./function_test_UpkeepPayments_GetProposedStatus_AfterProposeEnable.md)

**Signature:**
```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus after proposing to enable
///  @dev Verifies getter returns correct values after proposal to enable
function test_UpkeepPayments_GetProposedStatus_AfterProposeEnable() public;
```

### test_UpkeepPayments_GetProposedStatus_AfterProposeDisable()

- **Signature**: `test_UpkeepPayments_GetProposedStatus_AfterProposeDisable()`
- **Visibility**: public
- **Source Range**: 82610:476:659
- **Details**: [function_test_UpkeepPayments_GetProposedStatus_AfterProposeDisable.md](./function_test_UpkeepPayments_GetProposedStatus_AfterProposeDisable.md)

**Signature:**
```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus after proposing to disable
///  @dev Verifies getter returns correct values after proposal to disable
function test_UpkeepPayments_GetProposedStatus_AfterProposeDisable() public;
```

### test_UpkeepPayments_ExecuteBeforeTimelock()

- **Signature**: `test_UpkeepPayments_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 83092:599:659
- **Details**: [function_test_UpkeepPayments_ExecuteBeforeTimelock.md](./function_test_UpkeepPayments_ExecuteBeforeTimelock.md)

**Signature:**
```solidity
function test_UpkeepPayments_ExecuteBeforeTimelock() public;
```

### test_UpkeepPayments_GetProposedStatus_AfterExecution()

- **Signature**: `test_UpkeepPayments_GetProposedStatus_AfterExecution()`
- **Visibility**: public
- **Source Range**: 83833:953:659
- **Details**: [function_test_UpkeepPayments_GetProposedStatus_AfterExecution.md](./function_test_UpkeepPayments_GetProposedStatus_AfterExecution.md)

**Signature:**
```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus after execution
///  @dev Verifies getter returns reset values after execution
function test_UpkeepPayments_GetProposedStatus_AfterExecution() public;
```

### test_UpkeepPayments_GetProposedStatus_MultipleProposals()

- **Signature**: `test_UpkeepPayments_GetProposedStatus_MultipleProposals()`
- **Visibility**: public
- **Source Range**: 84932:1784:659
- **Details**: [function_test_UpkeepPayments_GetProposedStatus_MultipleProposals.md](./function_test_UpkeepPayments_GetProposedStatus_MultipleProposals.md)

**Signature:**
```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus with multiple proposals
///  @dev Verifies latest proposal overrides previous ones
function test_UpkeepPayments_GetProposedStatus_MultipleProposals() public;
```

### test_UpkeepPayments_GetProposedStatus_AfterTimelockWithoutExecution()

- **Signature**: `test_UpkeepPayments_GetProposedStatus_AfterTimelockWithoutExecution()`
- **Visibility**: public
- **Source Range**: 86900:661:659
- **Details**: [function_test_UpkeepPayments_GetProposedStatus_AfterTimelockWithoutExecution.md](./function_test_UpkeepPayments_GetProposedStatus_AfterTimelockWithoutExecution.md)

**Signature:**
```solidity
/// @notice Tests getProposedUpkeepPaymentsStatus with time warp but no execution
///  @dev Verifies proposal values persist even after timelock expires without execution
function test_UpkeepPayments_GetProposedStatus_AfterTimelockWithoutExecution() public;
```

### test_MerkleRoot_ProposeMerkleRoot()

- **Signature**: `test_MerkleRoot_ProposeMerkleRoot()`
- **Visibility**: public
- **Source Range**: 87811:843:659
- **Details**: [function_test_MerkleRoot_ProposeMerkleRoot.md](./function_test_MerkleRoot_ProposeMerkleRoot.md)

**Signature:**
```solidity
/// @notice Tests proposing a new SuperBank hook merkle root
function test_MerkleRoot_ProposeMerkleRoot() public;
```

### test_MerkleRoot_Revert_HookNotApproved()

- **Signature**: `test_MerkleRoot_Revert_HookNotApproved()`
- **Visibility**: public
- **Source Range**: 88746:291:659
- **Details**: [function_test_MerkleRoot_Revert_HookNotApproved.md](./function_test_MerkleRoot_Revert_HookNotApproved.md)

**Signature:**
```solidity
/// @notice Tests reverting when proposing a merkle root for an unregistered hook
function test_MerkleRoot_Revert_HookNotApproved() public;
```

### test_MerkleRoot_ExecuteMerkleRootUpdate()

- **Signature**: `test_MerkleRoot_ExecuteMerkleRootUpdate()`
- **Visibility**: public
- **Source Range**: 89096:791:659
- **Details**: [function_test_MerkleRoot_ExecuteMerkleRootUpdate.md](./function_test_MerkleRoot_ExecuteMerkleRootUpdate.md)

**Signature:**
```solidity
/// @notice Tests executing a merkle root update
function test_MerkleRoot_ExecuteMerkleRootUpdate() public;
```

### test_MerkleRoot_Revert_NotApproved()

- **Signature**: `test_MerkleRoot_Revert_NotApproved()`
- **Visibility**: public
- **Source Range**: 89893:399:659
- **Details**: [function_test_MerkleRoot_Revert_NotApproved.md](./function_test_MerkleRoot_Revert_NotApproved.md)

**Signature:**
```solidity
function test_MerkleRoot_Revert_NotApproved() public;
```

### test_MerkleRoot_Revert_ExecuteHookNotApproved()

- **Signature**: `test_MerkleRoot_Revert_ExecuteHookNotApproved()`
- **Visibility**: public
- **Source Range**: 90391:206:659
- **Details**: [function_test_MerkleRoot_Revert_ExecuteHookNotApproved.md](./function_test_MerkleRoot_Revert_ExecuteHookNotApproved.md)

**Signature:**
```solidity
/// @notice Tests reverting when executing a merkle root update for an unregistered hook
function test_MerkleRoot_Revert_ExecuteHookNotApproved() public;
```

### test_MerkleRoot_Revert_ExecuteNoProposal()

- **Signature**: `test_MerkleRoot_Revert_ExecuteNoProposal()`
- **Visibility**: public
- **Source Range**: 90681:353:659
- **Details**: [function_test_MerkleRoot_Revert_ExecuteNoProposal.md](./function_test_MerkleRoot_Revert_ExecuteNoProposal.md)

**Signature:**
```solidity
/// @notice Tests reverting when executing without a merkle root proposal
function test_MerkleRoot_Revert_ExecuteNoProposal() public;
```

### test_MerkleRoot_Revert_ExecuteBeforeTimelock()

- **Signature**: `test_MerkleRoot_Revert_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 91131:555:659
- **Details**: [function_test_MerkleRoot_Revert_ExecuteBeforeTimelock.md](./function_test_MerkleRoot_Revert_ExecuteBeforeTimelock.md)

**Signature:**
```solidity
/// @notice Tests reverting when executing a merkle root update before timelock expiry
function test_MerkleRoot_Revert_ExecuteBeforeTimelock() public;
```

### test_MinStalenesManagement_ProposeMinStaleness()

- **Signature**: `test_MinStalenesManagement_ProposeMinStaleness()`
- **Visibility**: public
- **Source Range**: 91931:680:659
- **Details**: [function_test_MinStalenesManagement_ProposeMinStaleness.md](./function_test_MinStalenesManagement_ProposeMinStaleness.md)

**Signature:**
```solidity
/// @notice Tests proposing a new minimum staleness value
function test_MinStalenesManagement_ProposeMinStaleness() public;
```

### test_MinStalenesManagement_ProposeAccessControl()

- **Signature**: `test_MinStalenesManagement_ProposeAccessControl()`
- **Visibility**: public
- **Source Range**: 92705:882:659
- **Details**: [function_test_MinStalenesManagement_ProposeAccessControl.md](./function_test_MinStalenesManagement_ProposeAccessControl.md)

**Signature:**
```solidity
/// @notice Tests access control for proposeMinStaleness (only SUPER_GOVERNOR_ROLE)
function test_MinStalenesManagement_ProposeAccessControl() public;
```

### test_MinStalenesManagement_ExecuteMinStalenesChange()

- **Signature**: `test_MinStalenesManagement_ExecuteMinStalenesChange()`
- **Visibility**: public
- **Source Range**: 93652:1033:659
- **Details**: [function_test_MinStalenesManagement_ExecuteMinStalenesChange.md](./function_test_MinStalenesManagement_ExecuteMinStalenesChange.md)

**Signature:**
```solidity
/// @notice Tests executing a minimum staleness change
function test_MinStalenesManagement_ExecuteMinStalenesChange() public;
```

### test_MinStalenessManagement_Revert_ExecuteNoProposal()

- **Signature**: `test_MinStalenessManagement_Revert_ExecuteNoProposal()`
- **Visibility**: public
- **Source Range**: 94757:205:659
- **Details**: [function_test_MinStalenessManagement_Revert_ExecuteNoProposal.md](./function_test_MinStalenessManagement_Revert_ExecuteNoProposal.md)

**Signature:**
```solidity
/// @notice Tests reverting when executing without a proposal
function test_MinStalenessManagement_Revert_ExecuteNoProposal() public;
```

### test_MinStalenessManagement_Revert_ExecuteBeforeTimelock()

- **Signature**: `test_MinStalenessManagement_Revert_ExecuteBeforeTimelock()`
- **Visibility**: public
- **Source Range**: 95038:425:659
- **Details**: [function_test_MinStalenessManagement_Revert_ExecuteBeforeTimelock.md](./function_test_MinStalenessManagement_Revert_ExecuteBeforeTimelock.md)

**Signature:**
```solidity
/// @notice Tests reverting when executing before timelock expiry
function test_MinStalenessManagement_Revert_ExecuteBeforeTimelock() public;
```

### test_MinStalenessManagement_InitialValue()

- **Signature**: `test_MinStalenessManagement_InitialValue()`
- **Visibility**: public
- **Source Range**: 95527:253:659
- **Details**: [function_test_MinStalenessManagement_InitialValue.md](./function_test_MinStalenessManagement_InitialValue.md)

**Signature:**
```solidity
/// @notice Tests the initial minimum staleness value
function test_MinStalenessManagement_InitialValue() public view;
```

### test_MinStalenessManagement_PublicExecution()

- **Signature**: `test_MinStalenessManagement_PublicExecution()`
- **Visibility**: public
- **Source Range**: 95859:512:659
- **Details**: [function_test_MinStalenessManagement_PublicExecution.md](./function_test_MinStalenessManagement_PublicExecution.md)

**Signature:**
```solidity
/// @notice Tests that execution is public (can be called by anyone)
function test_MinStalenessManagement_PublicExecution() public;
```

### test_OracleStalenesValidation_RoleAssignments()

- **Signature**: `test_OracleStalenesValidation_RoleAssignments()`
- **Visibility**: public
- **Source Range**: 96629:416:659
- **Details**: [function_test_OracleStalenesValidation_RoleAssignments.md](./function_test_OracleStalenesValidation_RoleAssignments.md)

**Signature:**
```solidity
/// @notice Tests that roles are properly assigned for oracle tests
function test_OracleStalenesValidation_RoleAssignments() public view;
```

### test_OracleStalenesValidation_SetOracleMaxStaleness_Success()

- **Signature**: `test_OracleStalenesValidation_SetOracleMaxStaleness_Success()`
- **Visibility**: public
- **Source Range**: 97122:823:659
- **Details**: [function_test_OracleStalenesValidation_SetOracleMaxStaleness_Success.md](./function_test_OracleStalenesValidation_SetOracleMaxStaleness_Success.md)

**Signature:**
```solidity
/// @notice Tests setOracleMaxStaleness with valid staleness value
function test_OracleStalenesValidation_SetOracleMaxStaleness_Success() public;
```

### test_OracleStalenesValidation_SetOracleMaxStaleness_Revert_TooLow()

- **Signature**: `test_OracleStalenesValidation_SetOracleMaxStaleness_Revert_TooLow()`
- **Visibility**: public
- **Source Range**: 98029:692:659
- **Details**: [function_test_OracleStalenesValidation_SetOracleMaxStaleness_Revert_TooLow.md](./function_test_OracleStalenesValidation_SetOracleMaxStaleness_Revert_TooLow.md)

**Signature:**
```solidity
/// @notice Tests setOracleMaxStaleness reverts when staleness is too low
function test_OracleStalenesValidation_SetOracleMaxStaleness_Revert_TooLow() public;
```

### test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Success()

- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Success()`
- **Visibility**: public
- **Source Range**: 98802:724:659
- **Details**: [function_test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Success.md](./function_test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Success.md)

**Signature:**
```solidity
/// @notice Tests setOracleFeedMaxStaleness with valid staleness value
function test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Success() public;
```

### test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_TooLow()

- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_TooLow()`
- **Visibility**: public
- **Source Range**: 99614:625:659
- **Details**: [function_test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_TooLow.md](./function_test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_TooLow.md)

**Signature:**
```solidity
/// @notice Tests setOracleFeedMaxStaleness reverts when staleness is too low
function test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_TooLow() public;
```

### test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_ZeroFeed()

- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_ZeroFeed()`
- **Visibility**: public
- **Source Range**: 100324:552:659
- **Details**: [function_test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_ZeroFeed.md](./function_test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_ZeroFeed.md)

**Signature:**
```solidity
/// @notice Tests setOracleFeedMaxStaleness reverts with zero feed address
function test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_ZeroFeed() public;
```

### test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Success()

- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Success()`
- **Visibility**: public
- **Source Range**: 100967:852:659
- **Details**: [function_test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Success.md](./function_test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Success.md)

**Signature:**
```solidity
/// @notice Tests setOracleFeedMaxStalenessBatch with all valid staleness values
function test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Success() public;
```

### test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OneTooLow()

- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OneTooLow()`
- **Visibility**: public
- **Source Range**: 101916:867:659
- **Details**: [function_test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OneTooLow.md](./function_test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OneTooLow.md)

**Signature:**
```solidity
/// @notice Tests setOracleFeedMaxStalenessBatch reverts when any staleness is too low
function test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OneTooLow() public;
```

### test_OracleStalenesValidation_AfterMinStalenesChange()

- **Signature**: `test_OracleStalenesValidation_AfterMinStalenesChange()`
- **Visibility**: public
- **Source Range**: 102872:1226:659
- **Details**: [function_test_OracleStalenesValidation_AfterMinStalenesChange.md](./function_test_OracleStalenesValidation_AfterMinStalenesChange.md)

**Signature:**
```solidity
/// @notice Tests oracle staleness validation after changing minimum staleness
function test_OracleStalenesValidation_AfterMinStalenesChange() public;
```

### f()

- **Signature**: `f()`
- **Visibility**: public
- **Source Range**: 104172:1535:659
- **Details**: [function_f.md](./function_f.md)

**Signature:**
```solidity
/// @notice Tests access control for oracle staleness functions
function f() public;
```

### test_OracleStalenesValidation_Revert_OracleNotSet()

- **Signature**: `test_OracleStalenesValidation_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 105780:277:659
- **Details**: [function_test_OracleStalenesValidation_Revert_OracleNotSet.md](./function_test_OracleStalenesValidation_Revert_OracleNotSet.md)

**Signature:**
```solidity
/// @notice Tests reverting when oracle is not set in registry
function test_OracleStalenesValidation_Revert_OracleNotSet() public;
```

### test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_OracleNotSet()

- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 106252:358:659
- **Details**: [function_test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_OracleNotSet.md](./function_test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_OracleNotSet.md)

**Signature:**
```solidity
/// @notice Tests setOracleFeedMaxStaleness reverts when oracle is not set in registry
///  @dev Covers SuperGovernor.sol:259 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
function test_OracleStalenesValidation_SetOracleFeedMaxStaleness_Revert_OracleNotSet() public;
```

### test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OracleNotSet()

- **Signature**: `test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 106810:536:659
- **Details**: [function_test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OracleNotSet.md](./function_test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OracleNotSet.md)

**Signature:**
```solidity
/// @notice Tests setOracleFeedMaxStalenessBatch reverts when oracle is not set in registry
///  @dev Covers SuperGovernor.sol:278 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
function test_OracleStalenesValidation_SetOracleFeedMaxStalenessBatch_Revert_OracleNotSet() public;
```

### test_OracleUpdateManagement_QueueOracleUpdate_Success()

- **Signature**: `test_OracleUpdateManagement_QueueOracleUpdate_Success()`
- **Visibility**: public
- **Source Range**: 107591:1568:659
- **Details**: [function_test_OracleUpdateManagement_QueueOracleUpdate_Success.md](./function_test_OracleUpdateManagement_QueueOracleUpdate_Success.md)

**Signature:**
```solidity
/// @notice Tests queueOracleUpdate with valid parameters
function test_OracleUpdateManagement_QueueOracleUpdate_Success() public;
```

### test_OracleUpdateManagement_QueueOracleUpdate_Revert_OracleNotSet()

- **Signature**: `test_OracleUpdateManagement_QueueOracleUpdate_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 109248:633:659
- **Details**: [function_test_OracleUpdateManagement_QueueOracleUpdate_Revert_OracleNotSet.md](./function_test_OracleUpdateManagement_QueueOracleUpdate_Revert_OracleNotSet.md)

**Signature:**
```solidity
/// @notice Tests queueOracleUpdate reverts when oracle is not set in registry
function test_OracleUpdateManagement_QueueOracleUpdate_Revert_OracleNotSet() public;
```

### test_OracleUpdateManagement_QueueOracleUpdate_AccessControl()

- **Signature**: `test_OracleUpdateManagement_QueueOracleUpdate_AccessControl()`
- **Visibility**: public
- **Source Range**: 109978:1662:659
- **Details**: [function_test_OracleUpdateManagement_QueueOracleUpdate_AccessControl.md](./function_test_OracleUpdateManagement_QueueOracleUpdate_AccessControl.md)

**Signature:**
```solidity
/// @notice Tests queueOracleUpdate access control - only ORACLE_MANAGER_ROLE can call
function test_OracleUpdateManagement_QueueOracleUpdate_AccessControl() public;
```

### test_OracleUpdateManagement_QueueOracleUpdate_EmptyArrays()

- **Signature**: `test_OracleUpdateManagement_QueueOracleUpdate_EmptyArrays()`
- **Visibility**: public
- **Source Range**: 111704:1116:659
- **Details**: [function_test_OracleUpdateManagement_QueueOracleUpdate_EmptyArrays.md](./function_test_OracleUpdateManagement_QueueOracleUpdate_EmptyArrays.md)

**Signature:**
```solidity
/// @notice Tests queueOracleUpdate with empty arrays
function test_OracleUpdateManagement_QueueOracleUpdate_EmptyArrays() public;
```

### test_OracleUpdateManagement_ExecuteOracleUpdate_Success()

- **Signature**: `test_OracleUpdateManagement_ExecuteOracleUpdate_Success()`
- **Visibility**: public
- **Source Range**: 112885:1131:659
- **Details**: [function_test_OracleUpdateManagement_ExecuteOracleUpdate_Success.md](./function_test_OracleUpdateManagement_ExecuteOracleUpdate_Success.md)

**Signature:**
```solidity
/// @notice Tests executeOracleUpdate with valid setup
function test_OracleUpdateManagement_ExecuteOracleUpdate_Success() public;
```

### test_OracleUpdateManagement_ExecuteOracleUpdate_Revert_OracleNotSet()

- **Signature**: `test_OracleUpdateManagement_ExecuteOracleUpdate_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 114107:240:659
- **Details**: [function_test_OracleUpdateManagement_ExecuteOracleUpdate_Revert_OracleNotSet.md](./function_test_OracleUpdateManagement_ExecuteOracleUpdate_Revert_OracleNotSet.md)

**Signature:**
```solidity
/// @notice Tests executeOracleUpdate reverts when oracle is not set in registry
function test_OracleUpdateManagement_ExecuteOracleUpdate_Revert_OracleNotSet() public;
```

### test_OracleUpdateManagement_ExecuteOracleUpdate_AccessControl()

- **Signature**: `test_OracleUpdateManagement_ExecuteOracleUpdate_AccessControl()`
- **Visibility**: public
- **Source Range**: 114446:1230:659
- **Details**: [function_test_OracleUpdateManagement_ExecuteOracleUpdate_AccessControl.md](./function_test_OracleUpdateManagement_ExecuteOracleUpdate_AccessControl.md)

**Signature:**
```solidity
/// @notice Tests executeOracleUpdate access control - only ORACLE_MANAGER_ROLE can call
function test_OracleUpdateManagement_ExecuteOracleUpdate_AccessControl() public;
```

### test_OracleUpdateManagement_QueueOracleProviderRemoval_Revert_OracleNotSet()

- **Signature**: `test_OracleUpdateManagement_QueueOracleProviderRemoval_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 115872:366:659
- **Details**: [function_test_OracleUpdateManagement_QueueOracleProviderRemoval_Revert_OracleNotSet.md](./function_test_OracleUpdateManagement_QueueOracleProviderRemoval_Revert_OracleNotSet.md)

**Signature:**
```solidity
/// @notice Tests queueOracleProviderRemoval reverts when oracle is not set in registry
///  @dev Covers SuperGovernor.sol:310 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
function test_OracleUpdateManagement_QueueOracleProviderRemoval_Revert_OracleNotSet() public;
```

### test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Revert_OracleNotSet()

- **Signature**: `test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 116436:258:659
- **Details**: [function_test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Revert_OracleNotSet.md](./function_test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Revert_OracleNotSet.md)

**Signature:**
```solidity
/// @notice Tests executeOracleProviderRemoval reverts when oracle is not set in registry
///  @dev Covers SuperGovernor.sol:470 - if (oracle == address(0)) revert CONTRACT_NOT_FOUND()
function test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Revert_OracleNotSet() public;
```

### test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Success()

- **Signature**: `test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Success()`
- **Visibility**: public
- **Source Range**: 116866:680:659
- **Details**: [function_test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Success.md](./function_test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Success.md)

**Signature:**
```solidity
/// @notice Tests executeOracleProviderRemoval successfully delegates to oracle
///  @dev Covers SuperGovernor.sol:468-473 success path with oracle delegation
function test_OracleUpdateManagement_ExecuteOracleProviderRemoval_Success() public;
```

### test_OracleUpdateManagement_CancelOracleProviderRemoval()

- **Signature**: `test_OracleUpdateManagement_CancelOracleProviderRemoval()`
- **Visibility**: public
- **Source Range**: 117552:1930:659
- **Details**: [function_test_OracleUpdateManagement_CancelOracleProviderRemoval.md](./function_test_OracleUpdateManagement_CancelOracleProviderRemoval.md)

**Signature:**
```solidity
function test_OracleUpdateManagement_CancelOracleProviderRemoval() public;
```

### test_CancelOracleProviderRemoval_AccessControl()

- **Signature**: `test_CancelOracleProviderRemoval_AccessControl()`
- **Visibility**: public
- **Source Range**: 119488:620:659
- **Details**: [function_test_CancelOracleProviderRemoval_AccessControl.md](./function_test_CancelOracleProviderRemoval_AccessControl.md)

**Signature:**
```solidity
function test_CancelOracleProviderRemoval_AccessControl() public;
```

### test_CancelOracleProviderRemoval_Revert_ContractNotFound()

- **Signature**: `test_CancelOracleProviderRemoval_Revert_ContractNotFound()`
- **Visibility**: public
- **Source Range**: 120114:237:659
- **Details**: [function_test_CancelOracleProviderRemoval_Revert_ContractNotFound.md](./function_test_CancelOracleProviderRemoval_Revert_ContractNotFound.md)

**Signature:**
```solidity
function test_CancelOracleProviderRemoval_Revert_ContractNotFound() public;
```

### test_OracleUpdateManagement_ExecuteOracleProviderRemoval_AccessControl()

- **Signature**: `test_OracleUpdateManagement_ExecuteOracleProviderRemoval_AccessControl()`
- **Visibility**: public
- **Source Range**: 120498:1601:659
- **Details**: [function_test_OracleUpdateManagement_ExecuteOracleProviderRemoval_AccessControl.md](./function_test_OracleUpdateManagement_ExecuteOracleProviderRemoval_AccessControl.md)

**Signature:**
```solidity
/// @notice Tests executeOracleProviderRemoval access control
///  @dev Covers SuperGovernor.sol:468 - onlyRole(_ORACLE_MANAGER_ROLE)
function test_OracleUpdateManagement_ExecuteOracleProviderRemoval_AccessControl() public;
```

### test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Revert_OracleNotSet()

- **Signature**: `test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Revert_OracleNotSet()`
- **Visibility**: public
- **Source Range**: 122295:601:659
- **Details**: [function_test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Revert_OracleNotSet.md](./function_test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Revert_OracleNotSet.md)

**Signature:**
```solidity
/// @notice Tests batchSetOracleUptimeFeed reverts when oracle is not set in registry
///  @dev Covers SuperGovernor.sol:325 - if (oracleL2 == address(0)) revert CONTRACT_NOT_FOUND()
function test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Revert_OracleNotSet() public;
```

### test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Success()

- **Signature**: `test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Success()`
- **Visibility**: public
- **Source Range**: 123022:1194:659
- **Details**: [function_test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Success.md](./function_test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Success.md)

**Signature:**
```solidity
/// @notice Tests batchSetOracleUptimeFeed success path
///  @dev Covers SuperGovernor.sol:316-328 complete flow
function test_OracleUpdateManagement_BatchSetOracleUptimeFeed_Success() public;
```

### test_OracleUpdateManagement_BatchSetOracleUptimeFeed_AccessControl()

- **Signature**: `test_OracleUpdateManagement_BatchSetOracleUptimeFeed_AccessControl()`
- **Visibility**: public
- **Source Range**: 124368:1265:659
- **Details**: [function_test_OracleUpdateManagement_BatchSetOracleUptimeFeed_AccessControl.md](./function_test_OracleUpdateManagement_BatchSetOracleUptimeFeed_AccessControl.md)

**Signature:**
```solidity
/// @notice Tests batchSetOracleUptimeFeed access control
///  @dev Covers SuperGovernor.sol:322 - onlyRole(_ORACLE_MANAGER_ROLE) modifier
function test_OracleUpdateManagement_BatchSetOracleUptimeFeed_AccessControl() public;
```

### test_OracleUpdateManagement_BatchSetOracleUptimeFeed_EmptyArrays()

- **Signature**: `test_OracleUpdateManagement_BatchSetOracleUptimeFeed_EmptyArrays()`
- **Visibility**: public
- **Source Range**: 125757:671:659
- **Details**: [function_test_OracleUpdateManagement_BatchSetOracleUptimeFeed_EmptyArrays.md](./function_test_OracleUpdateManagement_BatchSetOracleUptimeFeed_EmptyArrays.md)

**Signature:**
```solidity
/// @notice Tests batchSetOracleUptimeFeed with empty arrays
///  @dev Tests edge case with empty input arrays
function test_OracleUpdateManagement_BatchSetOracleUptimeFeed_EmptyArrays() public;
```

### test_OracleUpdateManagement_ExecuteOracleUpdate_WithoutQueue()

- **Signature**: `test_OracleUpdateManagement_ExecuteOracleUpdate_WithoutQueue()`
- **Visibility**: public
- **Source Range**: 126547:632:659
- **Details**: [function_test_OracleUpdateManagement_ExecuteOracleUpdate_WithoutQueue.md](./function_test_OracleUpdateManagement_ExecuteOracleUpdate_WithoutQueue.md)

**Signature:**
```solidity
/// @notice Tests executeOracleUpdate can be called without queuing first (depends on oracle implementation)
function test_OracleUpdateManagement_ExecuteOracleUpdate_WithoutQueue() public;
```

### test_OracleUpdateManagement_CompleteFlow()

- **Signature**: `test_OracleUpdateManagement_CompleteFlow()`
- **Visibility**: public
- **Source Range**: 127259:1657:659
- **Details**: [function_test_OracleUpdateManagement_CompleteFlow.md](./function_test_OracleUpdateManagement_CompleteFlow.md)

**Signature:**
```solidity
/// @notice Tests the complete flow: queue then execute oracle update
function test_OracleUpdateManagement_CompleteFlow() public;
```

### test_OracleUpdateManagement_MultipleQueueOperations()

- **Signature**: `test_OracleUpdateManagement_MultipleQueueOperations()`
- **Visibility**: public
- **Source Range**: 128998:2096:659
- **Details**: [function_test_OracleUpdateManagement_MultipleQueueOperations.md](./function_test_OracleUpdateManagement_MultipleQueueOperations.md)

**Signature:**
```solidity
/// @notice Tests multiple queue operations (should overwrite previous)
function test_OracleUpdateManagement_MultipleQueueOperations() public;
```

### test_QueueOracleProviderRemoval()

- **Signature**: `test_QueueOracleProviderRemoval()`
- **Visibility**: public
- **Source Range**: 131100:354:659
- **Details**: [function_test_QueueOracleProviderRemoval.md](./function_test_QueueOracleProviderRemoval.md)

**Signature:**
```solidity
function test_QueueOracleProviderRemoval() public;
```

### test_ExecuteUpkeepPaymentsChange_NoPendingChange()

- **Signature**: `test_ExecuteUpkeepPaymentsChange_NoPendingChange()`
- **Visibility**: public
- **Source Range**: 131660:245:659
- **Details**: [function_test_ExecuteUpkeepPaymentsChange_NoPendingChange.md](./function_test_ExecuteUpkeepPaymentsChange_NoPendingChange.md)

**Signature:**
```solidity
/// @notice Tests executeUpkeepPaymentsChange reverts when no change is pending
///  @dev Covers SuperGovernor.sol:543 - if (_upkeepPaymentsChangeEffectiveTime == 0) revert NO_PENDING_CHANGE()
function test_ExecuteUpkeepPaymentsChange_NoPendingChange() public;
```

### test_ProposeSuperBankHookMerkleRoot_ZeroProposedRoot()

- **Signature**: `test_ProposeSuperBankHookMerkleRoot_ZeroProposedRoot()`
- **Visibility**: public
- **Source Range**: 132110:451:659
- **Details**: [function_test_ProposeSuperBankHookMerkleRoot_ZeroProposedRoot.md](./function_test_ProposeSuperBankHookMerkleRoot_ZeroProposedRoot.md)

**Signature:**
```solidity
/// @notice Tests proposeSuperBankHookMerkleRoot reverts when proposed root is zero
///  @dev Covers SuperGovernor.sol:603 - if (proposedRoot == bytes32(0)) revert ZERO_PROPOSED_MERKLE_ROOT()
function test_ProposeSuperBankHookMerkleRoot_ZeroProposedRoot() public;
```

### test_GetUpkeepCostPerSingleUpdate_SuperOracleNotFound()

- **Signature**: `test_GetUpkeepCostPerSingleUpdate_SuperOracleNotFound()`
- **Visibility**: public
- **Source Range**: 132756:321:659
- **Details**: [function_test_GetUpkeepCostPerSingleUpdate_SuperOracleNotFound.md](./function_test_GetUpkeepCostPerSingleUpdate_SuperOracleNotFound.md)

**Signature:**
```solidity
/// @notice Tests getUpkeepCostPerSingleUpdate reverts when SUPER_ORACLE not found
///  @dev Covers SuperGovernor.sol:863 - if (oracle == address(0)) revert SUPER_ORACLE_NOT_FOUND()
function test_GetUpkeepCostPerSingleUpdate_SuperOracleNotFound() public;
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
