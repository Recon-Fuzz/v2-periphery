# Function: setUp()

**Contract**: [test/draft/test/unit/VaultBankFromExecutor.t.sol/contract_VaultBankFromExecutor.md]

## Metadata

- **Contract**: VaultBankFromExecutor
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 3108:2637:571

## Implementation

```solidity
function setUp() public {
    vm.createSelectFork(vm.envString(ETHEREUM_RPC_URL_KEY), ETH_BLOCK);
    underlying = CHAIN_1_USDC;
    ledgerConfig = address(new SuperLedgerConfiguration());
    yieldSourceAddress = CHAIN_1_MORPHO_VAULT;
    anotherYieldSourceAddress = CHAIN_1_YEARN_VAULT;
    yieldSourceOracle = address(new ERC4626YieldSourceOracle(address(ledgerConfig)));
    vaultInstance = IERC4626(yieldSourceAddress);
    validator = new SuperValidator();
    vm.label(address(validator), "Validator source");
    (signer, signerPrvKey) = makeAddrAndKey("signer");
    superExecutor = ISuperExecutor(new SuperExecutor(address(ledgerConfig)));
    address[] memory allowedExecutors = new address[](1);
    allowedExecutors[0] = address(superExecutor);
    ledger = ISuperLedger(address(new SuperLedger(address(ledgerConfig), allowedExecutors)));
    feeRecipient = makeAddr("feeRecipient");
    ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[] memory configs = new ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[](1);
    configs[0] = ISuperLedgerConfiguration.YieldSourceOracleConfigArgs({yieldSourceOracle: yieldSourceOracle, feePercent: 100, feeRecipient: feeRecipient, ledger: address(ledger)});
    bytes32[] memory salts = new bytes32[](1);
    salts[0] = bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY));
    ISuperLedgerConfiguration(ledgerConfig).setYieldSourceOracles(salts, configs);
    approveHook = address(new ApproveERC20Hook());
    deposit4626Hook = address(new Deposit4626VaultHook());
    mintSuperPositionsHook = address(new MintSuperPositionsHook());
    superGovernor = SuperGovernor(payable(VmContractHelper546(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D).deployCode({_artifact: "src/SuperGovernor.sol:SuperGovernor", _args: encodeArgs438(DeployHelper438.FoundryPpConstructorArgs(address(this), address(this), address(this), address(this), address(this), address(this), address(this), false))})));
    superRegistry = new SuperRegistry(address(superGovernor), address(this), address(this));
    vaultBank = new VaultBank(address(superGovernor), address(superRegistry));
    superRegistry.addVaultBank(uint64(block.chainid), address(vaultBank));
    superGovernor.registerHook(address(approveHook));
    superGovernor.registerHook(address(deposit4626Hook));
    superGovernor.registerHook(address(mintSuperPositionsHook));
}
```

## Related Implementations

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20479:242:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
}
```

### makeAddr(string)

- **Kind**: internal
- **Source**: 20760:125:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

## External Calls

- **Vm::createSelectFork(string,uint256)**
- **Vm::envString(string)**
- **Vm::label(address,string)**
- **ISuperLedgerConfiguration::setYieldSourceOracles(bytes32[],struct ISuperLedgerConfiguration.YieldSourceOracleConfigArgs[])**
- **VmContractHelper546::deployCode(string,bytes)**
- **SuperRegistry::addVaultBank(uint64,address)**
- **SuperGovernor::registerHook(address)**

## State Variable Reads

- **ledgerConfig** (`address`)
- **yieldSourceAddress** (`address`)
- **validator** (`contract SuperValidator`) [lib/v2-core/src/validators/SuperValidator.sol/contract_SuperValidator.md]
- **superExecutor** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **yieldSourceOracle** (`address`)
- **feeRecipient** (`address`)
- **ledger** (`contract ISuperLedger`) [lib/v2-core/src/interfaces/accounting/ISuperLedger.sol/interface_ISuperLedger.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract VaultBank`) [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]
- **approveHook** (`address`)
- **deposit4626Hook** (`address`)
- **mintSuperPositionsHook** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **underlying** (`address`)
- **ledgerConfig** (`address`)
- **yieldSourceAddress** (`address`)
- **anotherYieldSourceAddress** (`address`)
- **yieldSourceOracle** (`address`)
- **vaultInstance** (`contract IERC4626`) [lib/v2-core/lib/openzeppelin-contracts/contracts/interfaces/IERC4626.sol/interface_IERC4626.md]
- **validator** (`contract SuperValidator`) [lib/v2-core/src/validators/SuperValidator.sol/contract_SuperValidator.md]
- **signer** (`address`)
- **signerPrvKey** (`uint256`)
- **superExecutor** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **ledger** (`contract ISuperLedger`) [lib/v2-core/src/interfaces/accounting/ISuperLedger.sol/interface_ISuperLedger.md]
- **feeRecipient** (`address`)
- **approveHook** (`address`)
- **deposit4626Hook** (`address`)
- **mintSuperPositionsHook** (`address`)
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vaultBank** (`contract VaultBank`) [test/draft/src/VaultBank/VaultBank.sol/contract_VaultBank.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankFromExecutor.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 1)
  │   💬 Args: ["signer"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 2)
      💬 Args: ["feeRecipient"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 3)
        💬 Args: [name]
        👁️  Def: internal
```
