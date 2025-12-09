# Contract: SuperOracleTest

## Metadata

- **Name**: SuperOracleTest
- **Type**: Contract
- **Path**: test/oracles/SuperOracle.t.sol

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

### AVERAGE_PROVIDER

```solidity
bytes32 public constant AVERAGE_PROVIDER = keccak256("AVERAGE_PROVIDER")
```

### PROVIDER_1

```solidity
bytes32 public constant PROVIDER_1 = bytes32(keccak256("Provider 1"))
```

### PROVIDER_2

```solidity
bytes32 public constant PROVIDER_2 = bytes32(keccak256("Provider 2"))
```

### PROVIDER_3

```solidity
bytes32 public constant PROVIDER_3 = bytes32(keccak256("Provider 3"))
```

### NEW_PROVIDER

```solidity
bytes32 public constant NEW_PROVIDER = bytes32(keccak256("New Provider"))
```

### superOracle

```solidity
SuperOracle public superOracle
```

**SuperOracle**: [src/oracles/SuperOracle.sol/contract_SuperOracle.md]

### mockFeed1

```solidity
MockAggregator public mockFeed1
```

**MockAggregator**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

### mockFeed2

```solidity
MockAggregator public mockFeed2
```

**MockAggregator**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

### mockFeed3

```solidity
MockAggregator public mockFeed3
```

**MockAggregator**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

### mockFeed4

```solidity
MockAggregator public mockFeed4
```

**MockAggregator**: [test/mocks/MockAggregator.sol/contract_MockAggregator.md]

### mockETH

```solidity
MockERC20 public mockETH
```

**MockERC20**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

### mockUSD

```solidity
MockERC20 public mockUSD
```

**MockERC20**: [test/mocks/MockERC20.sol/contract_MockERC20.md]

### mockBTC

```solidity
MockERC20 public mockBTC
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
- **Source Range**: 1212:1767:624
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() public;
```

### test_GetQuote()

- **Signature**: `test_GetQuote()`
- **Visibility**: public
- **Source Range**: 2985:307:624
- **Details**: [function_test_GetQuote.md](./function_test_GetQuote.md)

**Signature:**
```solidity
function test_GetQuote() public view;
```

### test_GetQuoteWithInsufficientGasCheck()

- **Signature**: `test_GetQuoteWithInsufficientGasCheck()`
- **Visibility**: public
- **Source Range**: 3298:2201:624
- **Details**: [function_test_GetQuoteWithInsufficientGasCheck.md](./function_test_GetQuoteWithInsufficientGasCheck.md)

**Signature:**
```solidity
function test_GetQuoteWithInsufficientGasCheck() public view;
```

### testOracleGasCheckDirectly()

- **Signature**: `testOracleGasCheckDirectly()`
- **Visibility**: external
- **Source Range**: 5588:2015:624
- **Details**: [function_testOracleGasCheckDirectly.md](./function_testOracleGasCheckDirectly.md)

**Signature:**
```solidity
function testOracleGasCheckDirectly() external view;
```

### test_GetQuoteFromProvider()

- **Signature**: `test_GetQuoteFromProvider()`
- **Visibility**: public
- **Source Range**: 7798:1281:624
- **Details**: [function_test_GetQuoteFromProvider.md](./function_test_GetQuoteFromProvider.md)

**Signature:**
```solidity
function test_GetQuoteFromProvider() public view;
```

### test_GetQuoteFromProvider_RevertsOnNoOracleConfiguredForPair()

- **Signature**: `test_GetQuoteFromProvider_RevertsOnNoOracleConfiguredForPair()`
- **Visibility**: public
- **Source Range**: 9309:558:624
- **Details**: [function_test_GetQuoteFromProvider_RevertsOnNoOracleConfiguredForPair.md](./function_test_GetQuoteFromProvider_RevertsOnNoOracleConfiguredForPair.md)

**Signature:**
```solidity
/// @notice Tests getQuoteFromProvider reverts when provider is registered but has no oracle for the requested pair
///  @dev Covers SuperOracleBase.sol:287 - if (_oracle == address(0)) revert NO_ORACLES_CONFIGURED()
function test_GetQuoteFromProvider_RevertsOnNoOracleConfiguredForPair() public;
```

### test_GetActiveProviders()

- **Signature**: `test_GetActiveProviders()`
- **Visibility**: public
- **Source Range**: 10062:868:624
- **Details**: [function_test_GetActiveProviders.md](./function_test_GetActiveProviders.md)

**Signature:**
```solidity
function test_GetActiveProviders() public view;
```

### test_AddingNewProvider()

- **Signature**: `test_AddingNewProvider()`
- **Visibility**: public
- **Source Range**: 10936:1737:624
- **Details**: [function_test_AddingNewProvider.md](./function_test_AddingNewProvider.md)

**Signature:**
```solidity
function test_AddingNewProvider() public;
```

### test_RemovingProvider()

- **Signature**: `test_RemovingProvider()`
- **Visibility**: public
- **Source Range**: 12679:1955:624
- **Details**: [function_test_RemovingProvider.md](./function_test_RemovingProvider.md)

**Signature:**
```solidity
function test_RemovingProvider() public;
```

### test_SetMaxStaleness()

- **Signature**: `test_SetMaxStaleness()`
- **Visibility**: public
- **Source Range**: 14829:325:624
- **Details**: [function_test_SetMaxStaleness.md](./function_test_SetMaxStaleness.md)

**Signature:**
```solidity
function test_SetMaxStaleness() public;
```

### test_SetFeedMaxStaleness()

- **Signature**: `test_SetFeedMaxStaleness()`
- **Visibility**: public
- **Source Range**: 15160:364:624
- **Details**: [function_test_SetFeedMaxStaleness.md](./function_test_SetFeedMaxStaleness.md)

**Signature:**
```solidity
function test_SetFeedMaxStaleness() public;
```

### test_StalenessBatchUpdate()

- **Signature**: `test_StalenessBatchUpdate()`
- **Visibility**: public
- **Source Range**: 15530:693:624
- **Details**: [function_test_StalenessBatchUpdate.md](./function_test_StalenessBatchUpdate.md)

**Signature:**
```solidity
function test_StalenessBatchUpdate() public;
```

### test_RevertIfStaleData()

- **Signature**: `test_RevertIfStaleData()`
- **Visibility**: public
- **Source Range**: 16229:1221:624
- **Details**: [function_test_RevertIfStaleData.md](./function_test_RevertIfStaleData.md)

**Signature:**
```solidity
function test_RevertIfStaleData() public;
```

### test_QueueOracleUpdate()

- **Signature**: `test_QueueOracleUpdate()`
- **Visibility**: public
- **Source Range**: 17635:1229:624
- **Details**: [function_test_QueueOracleUpdate.md](./function_test_QueueOracleUpdate.md)

**Signature:**
```solidity
function test_QueueOracleUpdate() public;
```

### test_RevertIfZeroAddress()

- **Signature**: `test_RevertIfZeroAddress()`
- **Visibility**: public
- **Source Range**: 19050:602:624
- **Details**: [function_test_RevertIfZeroAddress.md](./function_test_RevertIfZeroAddress.md)

**Signature:**
```solidity
function test_RevertIfZeroAddress() public;
```

### test_RevertIfZeroProvider()

- **Signature**: `test_RevertIfZeroProvider()`
- **Visibility**: public
- **Source Range**: 19658:610:624
- **Details**: [function_test_RevertIfZeroProvider.md](./function_test_RevertIfZeroProvider.md)

**Signature:**
```solidity
function test_RevertIfZeroProvider() public;
```

### test_RevertIfAverageProvider()

- **Signature**: `test_RevertIfAverageProvider()`
- **Visibility**: public
- **Source Range**: 20274:667:624
- **Details**: [function_test_RevertIfAverageProvider.md](./function_test_RevertIfAverageProvider.md)

**Signature:**
```solidity
function test_RevertIfAverageProvider() public;
```

### test_RevertIfArrayLengthMismatch()

- **Signature**: `test_RevertIfArrayLengthMismatch()`
- **Visibility**: public
- **Source Range**: 20947:678:624
- **Details**: [function_test_RevertIfArrayLengthMismatch.md](./function_test_RevertIfArrayLengthMismatch.md)

**Signature:**
```solidity
function test_RevertIfArrayLengthMismatch() public;
```

### test_RevertIfNoOraclesConfigured()

- **Signature**: `test_RevertIfNoOraclesConfigured()`
- **Visibility**: public
- **Source Range**: 21631:363:624
- **Details**: [function_test_RevertIfNoOraclesConfigured.md](./function_test_RevertIfNoOraclesConfigured.md)

**Signature:**
```solidity
function test_RevertIfNoOraclesConfigured() public;
```

### test_RevertIfMaxStalenessExceeded()

- **Signature**: `test_RevertIfMaxStalenessExceeded()`
- **Visibility**: public
- **Source Range**: 22000:348:624
- **Details**: [function_test_RevertIfMaxStalenessExceeded.md](./function_test_RevertIfMaxStalenessExceeded.md)

**Signature:**
```solidity
function test_RevertIfMaxStalenessExceeded() public;
```

### test_RevertIfAllProvidersInvalid()

- **Signature**: `test_RevertIfAllProvidersInvalid()`
- **Visibility**: public
- **Source Range**: 22354:582:624
- **Details**: [function_test_RevertIfAllProvidersInvalid.md](./function_test_RevertIfAllProvidersInvalid.md)

**Signature:**
```solidity
function test_RevertIfAllProvidersInvalid() public;
```

### test_DeviationCalculation()

- **Signature**: `test_DeviationCalculation()`
- **Visibility**: public
- **Source Range**: 22942:476:624
- **Details**: [function_test_DeviationCalculation.md](./function_test_DeviationCalculation.md)

**Signature:**
```solidity
function test_DeviationCalculation() public view;
```

### test_TimelockedProviderRemoval()

- **Signature**: `test_TimelockedProviderRemoval()`
- **Visibility**: public
- **Source Range**: 23424:1383:624
- **Details**: [function_test_TimelockedProviderRemoval.md](./function_test_TimelockedProviderRemoval.md)

**Signature:**
```solidity
function test_TimelockedProviderRemoval() public;
```

### test_ProviderRemovalTimelockPeriod()

- **Signature**: `test_ProviderRemovalTimelockPeriod()`
- **Visibility**: public
- **Source Range**: 24813:1289:624
- **Details**: [function_test_ProviderRemovalTimelockPeriod.md](./function_test_ProviderRemovalTimelockPeriod.md)

**Signature:**
```solidity
function test_ProviderRemovalTimelockPeriod() public;
```

### test_NegativeOracleValues()

- **Signature**: `test_NegativeOracleValues()`
- **Visibility**: public
- **Source Range**: 26108:957:624
- **Details**: [function_test_NegativeOracleValues.md](./function_test_NegativeOracleValues.md)

**Signature:**
```solidity
function test_NegativeOracleValues() public;
```

### test_MultipleProviderRemoval()

- **Signature**: `test_MultipleProviderRemoval()`
- **Visibility**: public
- **Source Range**: 27071:1997:624
- **Details**: [function_test_MultipleProviderRemoval.md](./function_test_MultipleProviderRemoval.md)

**Signature:**
```solidity
function test_MultipleProviderRemoval() public;
```

### test_CancelProviderRemoval()

- **Signature**: `test_CancelProviderRemoval()`
- **Visibility**: public
- **Source Range**: 29074:2468:624
- **Details**: [function_test_CancelProviderRemoval.md](./function_test_CancelProviderRemoval.md)

**Signature:**
```solidity
function test_CancelProviderRemoval() public;
```

### test_CancelProviderRemoval_Revert_NoPendingUpdate()

- **Signature**: `test_CancelProviderRemoval_Revert_NoPendingUpdate()`
- **Visibility**: public
- **Source Range**: 31548:243:624
- **Details**: [function_test_CancelProviderRemoval_Revert_NoPendingUpdate.md](./function_test_CancelProviderRemoval_Revert_NoPendingUpdate.md)

**Signature:**
```solidity
function test_CancelProviderRemoval_Revert_NoPendingUpdate() public;
```

### test_CancelProviderRemoval_Revert_OnlyOwner()

- **Signature**: `test_CancelProviderRemoval_Revert_OnlyOwner()`
- **Visibility**: public
- **Source Range**: 31797:430:624
- **Details**: [function_test_CancelProviderRemoval_Revert_OnlyOwner.md](./function_test_CancelProviderRemoval_Revert_OnlyOwner.md)

**Signature:**
```solidity
function test_CancelProviderRemoval_Revert_OnlyOwner() public;
```

### test_ExecuteProviderRemoval_RevertsOnUnauthorized()

- **Signature**: `test_ExecuteProviderRemoval_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 32433:1004:624
- **Details**: [function_test_ExecuteProviderRemoval_RevertsOnUnauthorized.md](./function_test_ExecuteProviderRemoval_RevertsOnUnauthorized.md)

**Signature:**
```solidity
/// @notice Tests executeProviderRemoval reverts when called by non-governor
///  @dev Covers SuperOracleBase.sol:209 - if (msg.sender != SUPER_GOVERNOR) revert UNAUTHORIZED_UPDATE_AUTHORITY()
function test_ExecuteProviderRemoval_RevertsOnUnauthorized() public;
```

### test_DecimalConversion()

- **Signature**: `test_DecimalConversion()`
- **Visibility**: public
- **Source Range**: 33443:1399:624
- **Details**: [function_test_DecimalConversion.md](./function_test_DecimalConversion.md)

**Signature:**
```solidity
function test_DecimalConversion() public;
```

### test_SkippingProvidersWithoutOracleAddress()

- **Signature**: `test_SkippingProvidersWithoutOracleAddress()`
- **Visibility**: public
- **Source Range**: 34848:3068:624
- **Details**: [function_test_SkippingProvidersWithoutOracleAddress.md](./function_test_SkippingProvidersWithoutOracleAddress.md)

**Signature:**
```solidity
function test_SkippingProvidersWithoutOracleAddress() public;
```

### test_RevertIfZeroArrayLength()

- **Signature**: `test_RevertIfZeroArrayLength()`
- **Visibility**: public
- **Source Range**: 37946:603:624
- **Details**: [function_test_RevertIfZeroArrayLength.md](./function_test_RevertIfZeroArrayLength.md)

**Signature:**
```solidity
function test_RevertIfZeroArrayLength() public;
```

### test_RevertOnExecuteWithNoPendingUpdate()

- **Signature**: `test_RevertOnExecuteWithNoPendingUpdate()`
- **Visibility**: public
- **Source Range**: 38555:425:624
- **Details**: [function_test_RevertOnExecuteWithNoPendingUpdate.md](./function_test_RevertOnExecuteWithNoPendingUpdate.md)

**Signature:**
```solidity
function test_RevertOnExecuteWithNoPendingUpdate() public;
```

### test_executeOracleUpdate_RevertsOnUnauthorized()

- **Signature**: `test_executeOracleUpdate_RevertsOnUnauthorized()`
- **Visibility**: public
- **Source Range**: 38986:921:624
- **Details**: [function_test_executeOracleUpdate_RevertsOnUnauthorized.md](./function_test_executeOracleUpdate_RevertsOnUnauthorized.md)

**Signature:**
```solidity
function test_executeOracleUpdate_RevertsOnUnauthorized() public;
```

### test_OnlyOwnerCanPerformAdminActions()

- **Signature**: `test_OnlyOwnerCanPerformAdminActions()`
- **Visibility**: public
- **Source Range**: 39913:1583:624
- **Details**: [function_test_OnlyOwnerCanPerformAdminActions.md](./function_test_OnlyOwnerCanPerformAdminActions.md)

**Signature:**
```solidity
function test_OnlyOwnerCanPerformAdminActions() public;
```

### test_DefaultFeedStalenessWhenZeroProvided()

- **Signature**: `test_DefaultFeedStalenessWhenZeroProvided()`
- **Visibility**: public
- **Source Range**: 41502:622:624
- **Details**: [function_test_DefaultFeedStalenessWhenZeroProvided.md](./function_test_DefaultFeedStalenessWhenZeroProvided.md)

**Signature:**
```solidity
function test_DefaultFeedStalenessWhenZeroProvided() public;
```

### test_SingleElementArrayOracles()

- **Signature**: `test_SingleElementArrayOracles()`
- **Visibility**: public
- **Source Range**: 42130:1481:624
- **Details**: [function_test_SingleElementArrayOracles.md](./function_test_SingleElementArrayOracles.md)

**Signature:**
```solidity
function test_SingleElementArrayOracles() public;
```

### test_StdDevWithSingleProvider()

- **Signature**: `test_StdDevWithSingleProvider()`
- **Visibility**: public
- **Source Range**: 43617:844:624
- **Details**: [function_test_StdDevWithSingleProvider.md](./function_test_StdDevWithSingleProvider.md)

**Signature:**
```solidity
function test_StdDevWithSingleProvider() public;
```

### test_RevertIfQuoteForRemovedProvider()

- **Signature**: `test_RevertIfQuoteForRemovedProvider()`
- **Visibility**: public
- **Source Range**: 44467:973:624
- **Details**: [function_test_RevertIfQuoteForRemovedProvider.md](./function_test_RevertIfQuoteForRemovedProvider.md)

**Signature:**
```solidity
function test_RevertIfQuoteForRemovedProvider() public;
```

### test_ZeroAnswerInOracle()

- **Signature**: `test_ZeroAnswerInOracle()`
- **Visibility**: public
- **Source Range**: 45446:972:624
- **Details**: [function_test_ZeroAnswerInOracle.md](./function_test_ZeroAnswerInOracle.md)

**Signature:**
```solidity
function test_ZeroAnswerInOracle() public;
```

### test_HundredPercentDeviationCase()

- **Signature**: `test_HundredPercentDeviationCase()`
- **Visibility**: public
- **Source Range**: 46424:580:624
- **Details**: [function_test_HundredPercentDeviationCase.md](./function_test_HundredPercentDeviationCase.md)

**Signature:**
```solidity
function test_HundredPercentDeviationCase() public;
```

### test_OracleUpdateWithExistingProvider()

- **Signature**: `test_OracleUpdateWithExistingProvider()`
- **Visibility**: public
- **Source Range**: 47010:1154:624
- **Details**: [function_test_OracleUpdateWithExistingProvider.md](./function_test_OracleUpdateWithExistingProvider.md)

**Signature:**
```solidity
function test_OracleUpdateWithExistingProvider() public;
```

### test_FuzzMulDivNoOverflowWithRealisticBounds(uint128,uint128)

- **Signature**: `test_FuzzMulDivNoOverflowWithRealisticBounds(uint128,uint128)`
- **Visibility**: public
- **Source Range**: 48344:1433:624
- **Details**: [function_test_FuzzMulDivNoOverflowWithRealisticBounds_uint128_uint128.md](./function_test_FuzzMulDivNoOverflowWithRealisticBounds_uint128_uint128.md)

**Signature:**
```solidity
function test_FuzzMulDivNoOverflowWithRealisticBounds(uint128 baseAmount_, uint128 answerRaw_) public;
```

### test_Constructor_RevertsZeroGovernor()

- **Signature**: `test_Constructor_RevertsZeroGovernor()`
- **Visibility**: public
- **Source Range**: 50127:753:624
- **Details**: [function_test_Constructor_RevertsZeroGovernor.md](./function_test_Constructor_RevertsZeroGovernor.md)

**Signature:**
```solidity
/// @notice Tests constructor reverts with zero governor address
///  @dev Covers SuperOracleBase.sol:77 - if (superGovernor_ == address(0))
function test_Constructor_RevertsZeroGovernor() public;
```

### test_Constructor_BasesQuotesMismatch()

- **Signature**: `test_Constructor_BasesQuotesMismatch()`
- **Visibility**: public
- **Source Range**: 51033:876:624
- **Details**: [function_test_Constructor_BasesQuotesMismatch.md](./function_test_Constructor_BasesQuotesMismatch.md)

**Signature:**
```solidity
/// @notice Tests constructor array validation - bases/quotes mismatch
///  @dev Covers SuperOracleBase.sol:82-84 - array length validation
function test_Constructor_BasesQuotesMismatch() public;
```

### test_Constructor_BasesProvidersMismatch()

- **Signature**: `test_Constructor_BasesProvidersMismatch()`
- **Visibility**: public
- **Source Range**: 52065:882:624
- **Details**: [function_test_Constructor_BasesProvidersMismatch.md](./function_test_Constructor_BasesProvidersMismatch.md)

**Signature:**
```solidity
/// @notice Tests constructor array validation - bases/providers mismatch
///  @dev Covers SuperOracleBase.sol:82-84 - array length validation
function test_Constructor_BasesProvidersMismatch() public;
```

### test_Constructor_BasesFeedsMismatch()

- **Signature**: `test_Constructor_BasesFeedsMismatch()`
- **Visibility**: public
- **Source Range**: 53099:874:624
- **Details**: [function_test_Constructor_BasesFeedsMismatch.md](./function_test_Constructor_BasesFeedsMismatch.md)

**Signature:**
```solidity
/// @notice Tests constructor array validation - bases/feeds mismatch
///  @dev Covers SuperOracleBase.sol:82-84 - array length validation
function test_Constructor_BasesFeedsMismatch() public;
```

### test_ConfigureOracles_NewProviderAdded()

- **Signature**: `test_ConfigureOracles_NewProviderAdded()`
- **Visibility**: public
- **Source Range**: 54302:801:624
- **Details**: [function_test_ConfigureOracles_NewProviderAdded.md](./function_test_ConfigureOracles_NewProviderAdded.md)

**Signature:**
```solidity
/// @notice Tests _configureOracles with new provider addition
///  @dev Covers SuperOracleBase.sol:595 - if (!providerExists)
function test_ConfigureOracles_NewProviderAdded() public;
```

### test_ConfigureOracles_MaxProvidersExceeded()

- **Signature**: `test_ConfigureOracles_MaxProvidersExceeded()`
- **Visibility**: public
- **Source Range**: 55287:1073:624
- **Details**: [function_test_ConfigureOracles_MaxProvidersExceeded.md](./function_test_ConfigureOracles_MaxProvidersExceeded.md)

**Signature:**
```solidity
/// @notice Tests _configureOracles reverts when max providers exceeded
///  @dev Covers SuperOracleBase.sol:596-598 - if (activeProviders.length >= MAX_SAMPLE_PROVIDERS)
function test_ConfigureOracles_MaxProvidersExceeded() public;
```

### test_GetQuoteFromProvider_SingleProviderPath()

- **Signature**: `test_GetQuoteFromProvider_SingleProviderPath()`
- **Visibility**: public
- **Source Range**: 56528:359:624
- **Details**: [function_test_GetQuoteFromProvider_SingleProviderPath.md](./function_test_GetQuoteFromProvider_SingleProviderPath.md)

**Signature:**
```solidity
/// @notice Tests getQuoteFromProvider for single provider (non-average)
///  @dev Covers SuperOracleBase.sol:284-292 - else branch (not AVERAGE_PROVIDER)
function test_GetQuoteFromProvider_SingleProviderPath() public view;
```

### test_GetAverageQuote_MaxSampleBreak()

- **Signature**: `test_GetAverageQuote_MaxSampleBreak()`
- **Visibility**: public
- **Source Range**: 57060:1627:624
- **Details**: [function_test_GetAverageQuote_MaxSampleBreak.md](./function_test_GetAverageQuote_MaxSampleBreak.md)

**Signature:**
```solidity
/// @notice Tests _getAverageQuote breaks early at MAX_SAMPLE_PROVIDERS
///  @dev Covers SuperOracleBase.sol:504-506 - if (count == MAX_SAMPLE_PROVIDERS) break
function test_GetAverageQuote_MaxSampleBreak() public;
```

### test_CalculateStdDev_MeanBranches()

- **Signature**: `test_CalculateStdDev_MeanBranches()`
- **Visibility**: public
- **Source Range**: 58832:478:624
- **Details**: [function_test_CalculateStdDev_MeanBranches.md](./function_test_CalculateStdDev_MeanBranches.md)

**Signature:**
```solidity
/// @notice Tests _calculateStdDev with values >= mean branch
///  @dev Covers SuperOracleBase.sol:537-540 - if (values[i] >= mean)
function test_CalculateStdDev_MeanBranches() public view;
```

### test_Sqrt_ZeroInput()

- **Signature**: `test_Sqrt_ZeroInput()`
- **Visibility**: public
- **Source Range**: 59427:691:624
- **Details**: [function_test_Sqrt_ZeroInput.md](./function_test_Sqrt_ZeroInput.md)

**Signature:**
```solidity
/// @notice Tests _sqrt with zero input
///  @dev Covers SuperOracleBase.sol:556 - if (x == 0) return 0
function test_Sqrt_ZeroInput() public;
```

### test_ExecuteProviderRemoval_ArraySwapLogic()

- **Signature**: `test_ExecuteProviderRemoval_ArraySwapLogic()`
- **Visibility**: public
- **Source Range**: 60273:629:624
- **Details**: [function_test_ExecuteProviderRemoval_ArraySwapLogic.md](./function_test_ExecuteProviderRemoval_ArraySwapLogic.md)

**Signature:**
```solidity
/// @notice Tests executeProviderRemoval with array swap logic
///  @dev Covers SuperOracleBase.sol:225 - if (j < activeProviders.length - 1)
function test_ExecuteProviderRemoval_ArraySwapLogic() public;
```

### test_ExecuteProviderRemoval_LastElement()

- **Signature**: `test_ExecuteProviderRemoval_LastElement()`
- **Visibility**: public
- **Source Range**: 61072:665:624
- **Details**: [function_test_ExecuteProviderRemoval_LastElement.md](./function_test_ExecuteProviderRemoval_LastElement.md)

**Signature:**
```solidity
/// @notice Tests executeProviderRemoval removing last element (no swap needed)
///  @dev Covers the else case of line 225 - removing last provider in array
function test_ExecuteProviderRemoval_LastElement() public;
```

### test_SetFeedMaxStalenessBatch_Unauthorized()

- **Signature**: `test_SetFeedMaxStalenessBatch_Unauthorized()`
- **Visibility**: public
- **Source Range**: 61909:422:624
- **Details**: [function_test_SetFeedMaxStalenessBatch_Unauthorized.md](./function_test_SetFeedMaxStalenessBatch_Unauthorized.md)

**Signature:**
```solidity
/// @notice Tests setFeedMaxStalenessBatch with unauthorized caller
///  @dev Covers SuperOracleBase.sol:134 - if (msg.sender != SUPER_GOVERNOR) (revert path)
function test_SetFeedMaxStalenessBatch_Unauthorized() public;
```

### test_SetFeedMaxStalenessBatch_ZeroLength()

- **Signature**: `test_SetFeedMaxStalenessBatch_ZeroLength()`
- **Visibility**: public
- **Source Range**: 62497:303:624
- **Details**: [function_test_SetFeedMaxStalenessBatch_ZeroLength.md](./function_test_SetFeedMaxStalenessBatch_ZeroLength.md)

**Signature:**
```solidity
/// @notice Tests setFeedMaxStalenessBatch with zero length array
///  @dev Covers SuperOracleBase.sol:136 - if (length == 0) revert ZERO_ARRAY_LENGTH()
function test_SetFeedMaxStalenessBatch_ZeroLength() public;
```

### test_SetFeedMaxStalenessBatch_ArrayLengthMismatch()

- **Signature**: `test_SetFeedMaxStalenessBatch_ArrayLengthMismatch()`
- **Visibility**: public
- **Source Range**: 62975:539:624
- **Details**: [function_test_SetFeedMaxStalenessBatch_ArrayLengthMismatch.md](./function_test_SetFeedMaxStalenessBatch_ArrayLengthMismatch.md)

**Signature:**
```solidity
/// @notice Tests setFeedMaxStalenessBatch with mismatched array lengths
///  @dev Covers SuperOracleBase.sol:137-138 - if (length != newMaxStalenessList.length)
function test_SetFeedMaxStalenessBatch_ArrayLengthMismatch() public;
```

### test_SetFeedMaxStalenessBatch_Success()

- **Signature**: `test_SetFeedMaxStalenessBatch_Success()`
- **Visibility**: public
- **Source Range**: 63673:684:624
- **Details**: [function_test_SetFeedMaxStalenessBatch_Success.md](./function_test_SetFeedMaxStalenessBatch_Success.md)

**Signature:**
```solidity
/// @notice Tests batch staleness update success path
///  @dev Covers SuperOracleBase.sol:134 (success path), 141-142 (for loop in batch update)
function test_SetFeedMaxStalenessBatch_Success() public;
```

### test_SetFeedMaxStalenessBatch_SingleElement()

- **Signature**: `test_SetFeedMaxStalenessBatch_SingleElement()`
- **Visibility**: public
- **Source Range**: 64509:389:624
- **Details**: [function_test_SetFeedMaxStalenessBatch_SingleElement.md](./function_test_SetFeedMaxStalenessBatch_SingleElement.md)

**Signature:**
```solidity
/// @notice Tests batch staleness update with single element
///  @dev Covers SuperOracleBase.sol:141 - loop with length=1 (boundary case)
function test_SetFeedMaxStalenessBatch_SingleElement() public;
```

### test_SetFeedMaxStaleness_ZeroResetsToDefault()

- **Signature**: `test_SetFeedMaxStaleness_ZeroResetsToDefault()`
- **Visibility**: public
- **Source Range**: 65066:447:624
- **Details**: [function_test_SetFeedMaxStaleness_ZeroResetsToDefault.md](./function_test_SetFeedMaxStaleness_ZeroResetsToDefault.md)

**Signature:**
```solidity
/// @notice Tests _setFeedMaxStaleness with newMaxStaleness == 0 reset to default
///  @dev Covers SuperOracleBase.sol:349-351 - if (newMaxStaleness == 0)
function test_SetFeedMaxStaleness_ZeroResetsToDefault() public;
```

### test_Constructor_DefaultStaleness()

- **Signature**: `test_Constructor_DefaultStaleness()`
- **Visibility**: public
- **Source Range**: 65644:834:624
- **Details**: [function_test_Constructor_DefaultStaleness.md](./function_test_Constructor_DefaultStaleness.md)

**Signature:**
```solidity
/// @notice Tests constructor sets default staleness correctly
///  @dev Verifies line 79 - defaultStaleness = 1 days
function test_Constructor_DefaultStaleness() public;
```

### test_GetOracleAddress_SuccessPath()

- **Signature**: `test_GetOracleAddress_SuccessPath()`
- **Visibility**: public
- **Source Range**: 66836:808:624
- **Details**: [function_test_GetOracleAddress_SuccessPath.md](./function_test_GetOracleAddress_SuccessPath.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress returns correct oracle for configured pair
///  @dev Covers SuperOracleBase.sol:186-190 - Success path (line 188)
function test_GetOracleAddress_SuccessPath() public view;
```

### test_GetOracleAddress_RevertsOnUnregisteredProvider()

- **Signature**: `test_GetOracleAddress_RevertsOnUnregisteredProvider()`
- **Visibility**: public
- **Source Range**: 67825:380:624
- **Details**: [function_test_GetOracleAddress_RevertsOnUnregisteredProvider.md](./function_test_GetOracleAddress_RevertsOnUnregisteredProvider.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress reverts when provider is not registered
///  @dev Covers SuperOracleBase.sol:187 - INVALID_ORACLE_PROVIDER for unregistered provider
function test_GetOracleAddress_RevertsOnUnregisteredProvider() public;
```

### test_GetOracleAddress_RevertsOnNoOracleConfiguredForPair()

- **Signature**: `test_GetOracleAddress_RevertsOnNoOracleConfiguredForPair()`
- **Visibility**: public
- **Source Range**: 68417:378:624
- **Details**: [function_test_GetOracleAddress_RevertsOnNoOracleConfiguredForPair.md](./function_test_GetOracleAddress_RevertsOnNoOracleConfiguredForPair.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress reverts when provider is set but oracle for base/quote is not configured
///  @dev Covers SuperOracleBase.sol:189 - NO_ORACLES_CONFIGURED when oracle == address(0)
function test_GetOracleAddress_RevertsOnNoOracleConfiguredForPair() public;
```

### test_GetOracleAddress_RevertsAfterProviderRemoval()

- **Signature**: `test_GetOracleAddress_RevertsAfterProviderRemoval()`
- **Visibility**: public
- **Source Range**: 68967:953:624
- **Details**: [function_test_GetOracleAddress_RevertsAfterProviderRemoval.md](./function_test_GetOracleAddress_RevertsAfterProviderRemoval.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress reverts when provider was removed
///  @dev Covers SuperOracleBase.sol:187 - INVALID_ORACLE_PROVIDER after provider removal
function test_GetOracleAddress_RevertsAfterProviderRemoval() public;
```

### test_GetOracleAddress_RevertsOnAverageProvider()

- **Signature**: `test_GetOracleAddress_RevertsOnAverageProvider()`
- **Visibility**: public
- **Source Range**: 70121:303:624
- **Details**: [function_test_GetOracleAddress_RevertsOnAverageProvider.md](./function_test_GetOracleAddress_RevertsOnAverageProvider.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress with AVERAGE_PROVIDER (should revert as it's not a real provider)
///  @dev AVERAGE_PROVIDER is a special constant for averaging, not an actual provider
function test_GetOracleAddress_RevertsOnAverageProvider() public;
```

### test_GetOracleAddress_SuccessAfterAddingNewProvider()

- **Signature**: `test_GetOracleAddress_SuccessAfterAddingNewProvider()`
- **Visibility**: public
- **Source Range**: 70601:992:624
- **Details**: [function_test_GetOracleAddress_SuccessAfterAddingNewProvider.md](./function_test_GetOracleAddress_SuccessAfterAddingNewProvider.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress after adding new provider with new oracle
///  @dev Verifies oracle address is correctly set after queueing and executing update
function test_GetOracleAddress_SuccessAfterAddingNewProvider() public;
```

### test_GetOracleAddress_ReturnsUpdatedOracleAfterUpdate()

- **Signature**: `test_GetOracleAddress_ReturnsUpdatedOracleAfterUpdate()`
- **Visibility**: public
- **Source Range**: 71738:1279:624
- **Details**: [function_test_GetOracleAddress_ReturnsUpdatedOracleAfterUpdate.md](./function_test_GetOracleAddress_ReturnsUpdatedOracleAfterUpdate.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress after updating existing provider's oracle
///  @dev Verifies oracle address changes after update
function test_GetOracleAddress_ReturnsUpdatedOracleAfterUpdate() public;
```

### test_GetOracleAddress_MultipleAssetPairsForSameProvider()

- **Signature**: `test_GetOracleAddress_MultipleAssetPairsForSameProvider()`
- **Visibility**: public
- **Source Range**: 73190:1313:624
- **Details**: [function_test_GetOracleAddress_MultipleAssetPairsForSameProvider.md](./function_test_GetOracleAddress_MultipleAssetPairsForSameProvider.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress with multiple asset pairs for same provider
///  @dev Verifies provider can have different oracles for different asset pairs
function test_GetOracleAddress_MultipleAssetPairsForSameProvider() public;
```

### test_GetOracleAddress_WithZeroAddressBase()

- **Signature**: `test_GetOracleAddress_WithZeroAddressBase()`
- **Visibility**: public
- **Source Range**: 74666:467:624
- **Details**: [function_test_GetOracleAddress_WithZeroAddressBase.md](./function_test_GetOracleAddress_WithZeroAddressBase.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress with zero address for base token
///  @dev Verifies behavior with zero address (should reach provider check first)
function test_GetOracleAddress_WithZeroAddressBase() public;
```

### test_GetOracleAddress_WithZeroAddressQuote()

- **Signature**: `test_GetOracleAddress_WithZeroAddressQuote()`
- **Visibility**: public
- **Source Range**: 75267:308:624
- **Details**: [function_test_GetOracleAddress_WithZeroAddressQuote.md](./function_test_GetOracleAddress_WithZeroAddressQuote.md)

**Signature:**
```solidity
/// @notice Tests getOracleAddress with zero address for quote token
///  @dev Verifies behavior with zero address quote
function test_GetOracleAddress_WithZeroAddressQuote() public;
```

### test_GetOracleDecimals_ReturnsCorrectDecimals()

- **Signature**: `test_GetOracleDecimals_ReturnsCorrectDecimals()`
- **Visibility**: public
- **Source Range**: 75930:573:624
- **Details**: [function_test_GetOracleDecimals_ReturnsCorrectDecimals.md](./function_test_GetOracleDecimals_ReturnsCorrectDecimals.md)

**Signature:**
```solidity
/// @notice Tests _getOracleDecimals returns correct decimals from oracle
///  @dev Covers SuperOracleBase.sol:514-516 - _getOracleDecimals function
function test_GetOracleDecimals_ReturnsCorrectDecimals() public view;
```

### test_GetOracleDecimals_WithVariousDecimals()

- **Signature**: `test_GetOracleDecimals_WithVariousDecimals()`
- **Visibility**: public
- **Source Range**: 76668:583:624
- **Details**: [function_test_GetOracleDecimals_WithVariousDecimals.md](./function_test_GetOracleDecimals_WithVariousDecimals.md)

**Signature:**
```solidity
/// @notice Tests _getOracleDecimals with different decimal configurations
///  @dev Verifies the function works with various decimal values (6, 8, 18)
function test_GetOracleDecimals_WithVariousDecimals() public;
```

### test_GetOracleDecimals_EdgeCaseDecimals()

- **Signature**: `test_GetOracleDecimals_EdgeCaseDecimals()`
- **Visibility**: public
- **Source Range**: 77405:616:624
- **Details**: [function_test_GetOracleDecimals_EdgeCaseDecimals.md](./function_test_GetOracleDecimals_EdgeCaseDecimals.md)

**Signature:**
```solidity
/// @notice Tests _getOracleDecimals with edge case decimal values
///  @dev Tests minimum (0) and maximum (18) decimal values commonly used
function test_GetOracleDecimals_EdgeCaseDecimals() public;
```

### test_GetOracleDecimals_ConsistentResults()

- **Signature**: `test_GetOracleDecimals_ConsistentResults()`
- **Visibility**: public
- **Source Range**: 78166:498:624
- **Details**: [function_test_GetOracleDecimals_ConsistentResults.md](./function_test_GetOracleDecimals_ConsistentResults.md)

**Signature:**
```solidity
/// @notice Tests _getOracleDecimals consistency across multiple calls
///  @dev Verifies that decimals() returns consistent values
function test_GetOracleDecimals_ConsistentResults() public view;
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
