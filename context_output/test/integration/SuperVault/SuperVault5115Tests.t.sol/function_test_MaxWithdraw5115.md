# Function: test_MaxWithdraw5115()

**Contract**: [test/integration/SuperVault/SuperVault5115Tests.t.sol/contract_SuperVault5115Tests.md]

## Metadata

- **Contract**: SuperVault5115Tests
- **Signature**: `test_MaxWithdraw5115()`
- **Visibility**: public
- **Source Range**: 23883:1235:581

## Implementation

```solidity
function test_MaxWithdraw5115() public {
    vm.selectFork(FORKS[ETH]);
    _setup5115Vault();
    uint256 depositAmount = 1000e6;
    _deposit(depositAmount, address(sv5115), address(asset5115));
    _depositFreeAssetsFromSingleAmount5115(depositAmount, address(strategy5115SuperVault), pendleEthenaAddress);
    uint256 userBalance = sv5115.balanceOf(accountEth);
    uint256 maxWithdraw = sv5115.maxWithdraw(accountEth);
    console2.log("----- userBalance", userBalance);
    console2.log("----- maxWithdraw", maxWithdraw);
    assertEq(maxWithdraw, 0, "maxWithdraw should be 0 before redemption is fulfilled");
    _requestRedeem(userBalance, address(sv5115));
    _fulfillRedeem5115(userBalance, address(sv5115), address(strategy5115SuperVault));
    uint256 claimable = strategy5115SuperVault.claimableWithdraw(accountEth);
    uint256 maxWithdrawAfter = sv5115.maxWithdraw(accountEth);
    assertEq(maxWithdrawAfter, claimable, "maxWithdraw should match claimable amount");
}
```

## Related Implementations

### _setup5115Vault()

- **Kind**: internal
- **Source**: 3469:1990:581
- **Link**: `test/integration/SuperVault/SuperVault5115Tests.t.sol:SuperVault5115Tests:_setup5115Vault()`

```solidity
function _setup5115Vault() internal {
    (address svAddr, address strategySuperVaultAddr, address escrowSuperVaultAddr) = _deployVault(address(asset5115), "sv5115");
    assertEq(strategySuperVaultAddr, globalSV5115Strategy, "SV STRATEGY NOT EQUAL TO PREDICTED");
    vm.label(svAddr, "SuperVault-5115");
    vm.label(strategySuperVaultAddr, "SuperVaultStrategy-5115");
    vm.label(escrowSuperVaultAddr, "SuperVaultEscrow-5115");
    sv5115 = SuperVault(svAddr);
    escrow5115SuperVault = SuperVaultEscrow(escrowSuperVaultAddr);
    strategy5115SuperVault = SuperVaultStrategy(payable(strategySuperVaultAddr));
    vm.startPrank(MANAGER);
    strategy5115SuperVault.manageYieldSource(address(pendleEthenaAddress), _getContract(ETH, ERC5115_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    vm.stopPrank();
    vm.startPrank(MANAGER);
    strategy5115SuperVault.proposeVaultFeeConfigUpdate(100, 0, TREASURY);
    vm.warp(block.timestamp + 1 weeks);
    strategy5115SuperVault.executeVaultFeeConfigUpdate();
    vm.stopPrank();
    vm.startPrank(MANAGER);
    strategy5115SuperVault.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 86_400);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 86_400);
    vm.warp(block.timestamp + 2 weeks);
    strategy5115SuperVault.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
    vm.stopPrank();
    _updateSuperVaultPPS(address(strategy5115SuperVault), address(sv5115));
    _updateSuperVaultPPS(address(strategy), address(vault));
}
```

### _deployVault(address,string)

- **Kind**: internal
- **Source**: 13311:1259:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deployVault(address,string)`

```solidity
///  @notice Deploys a new SuperVault with default configuration
///  @return vaultAddr The address of the deployed SuperVault
///  @return strategyAddr The address of the deployed SuperVaultStrategy
///  @return escrowAddr The address of the deployed SuperVaultEscrow
function _deployVault(address _asset, string memory _superVaultSymbol) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    vm.startPrank(SV_MANAGER);
    (vaultAddr, strategyAddr, escrowAddr) = aggregator.createVault(ISuperVaultAggregator.VaultCreationParams({asset: _asset, name: "SuperVault", symbol: _superVaultSymbol, mainManager: MANAGER, secondaryManagers: new address[](0), minUpdateInterval: 5, maxStaleness: 1 weeks, feeConfig: ISuperVaultStrategy.FeeConfig({performanceFeeBps: 1000, managementFeeBps: 0, recipient: address(this)})}));
    vm.label(vaultAddr, string.concat("SuperVault ", _superVaultSymbol));
    vm.label(strategyAddr, string.concat("SuperVaultStrategy ", _superVaultSymbol));
    vm.label(escrowAddr, string.concat("SuperVaultEscrow ", _superVaultSymbol));
    vm.stopPrank();
    return (vaultAddr, strategyAddr, escrowAddr);
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 4179:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### _getContract(uint64,string)

- **Kind**: internal
- **Source**: 20955:162:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_getContract(uint64,string)`

```solidity
function _getContract(uint64 chainId, string memory contractName) internal view returns (address) {
    return contractAddresses[chainId][contractName];
}
```

### _updateSuperVaultPPS(address,address)

- **Kind**: internal
- **Source**: 113586:2774:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_updateSuperVaultPPS(address,address)`

```solidity
///  @notice Updates the PPS (Price Per Share) using TotalAssetHelper
///  @return pps The calculated and updated price per share value
///  @dev This function uses TotalAssetHelper to get totalAssets, calculates PPS,
///       creates a signature, and updates the PPS through the ECDSAPPSOracle contract
function _updateSuperVaultPPS(address strategyAddr, address vault_) internal returns (uint256 pps) {
    UpdatePPSVars memory vars;
    vars.totalSupplyAmount = SuperVault(vault_).totalSupply();
    (vars.currentTotalAssets, ) = totalAssetHelper.totalAssets(strategyAddr);
    vars.precision = SuperVault(vault_).PRECISION();
    if (vars.totalSupplyAmount == 0) {
        vars.pps = vars.precision;
    } else {
        vars.pps = vars.currentTotalAssets.mulDiv(vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor);
    }
    vars.timestamp = block.timestamp;
    bytes32 structHash = keccak256(abi.encodePacked(ecdsappsOracle.UPDATE_PPS_TYPEHASH(), strategyAddr, vars.pps, vars.timestamp, ecdsappsOracle.noncePerStrategy(strategyAddr)));
    vars.ethSignedMessageHash = MessageHashUtils.toTypedDataHash(ecdsappsOracle.domainSeparator(), structHash);
    (vars.v, vars.r, vars.s) = vm.sign(VALIDATOR_KEY, vars.ethSignedMessageHash);
    vars.signature = abi.encodePacked(vars.r, vars.s, vars.v);
    vars.proofs = new bytes[](1);
    vars.proofs[0] = vars.signature;
    address[] memory strategies = new address[](1);
    strategies[0] = strategyAddr;
    bytes[][] memory proofsArray = new bytes[][](1);
    proofsArray[0] = vars.proofs;
    uint256[] memory ppss = new uint256[](1);
    ppss[0] = vars.pps;
    uint256[] memory timestamps = new uint256[](1);
    timestamps[0] = vars.timestamp;
    ecdsappsOracle.updatePPS(IECDSAPPSOracle.UpdatePPSArgs({strategies: strategies, proofsArray: proofsArray, ppss: ppss, timestamps: timestamps}));
    console2.log("Updated PPS for strategy", strategyAddr, vars.pps);
    pps = vars.pps;
    return pps;
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:61
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

```solidity
///  @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
function toUint(bool b) internal pure returns (uint256 u) {
    assembly ("memory-safe") {
        u := iszero(iszero(b))
    }
}
```

### unsignedRoundsUp(enum Math.Rounding)

- **Kind**: internal
- **Source**: 32020:122:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

```solidity
///  @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
///  denominator == 0.
///  Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
///  Uniswap Labs also under MIT license.
function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
    unchecked {
        (uint256 high, uint256 low) = mul512(x, y);
        if (high == 0) {
            return low / denominator;
        }
        if (denominator <= high) {
            Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
        }
        uint256 remainder;
        assembly ("memory-safe") {
            remainder := mulmod(x, y, denominator)
            high := sub(high, gt(remainder, low))
            low := sub(low, remainder)
        }
        uint256 twos = denominator & (0 - denominator);
        assembly ("memory-safe") {
            denominator := div(denominator, twos)
            low := div(low, twos)
            twos := add(div(sub(0, twos), twos), 1)
        }
        low |= high * twos;
        uint256 inverse = (3 * denominator) ^ 2;
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        result = low * inverse;
        return result;
    }
}
```

### mul512(uint256,uint256)

- **Kind**: internal
- **Source**: 1027:550:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

```solidity
///  @dev Return the 512-bit multiplication of two uint256.
///  The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
function mul512(uint256 a, uint256 b) internal pure returns (uint256 high, uint256 low) {
    assembly ("memory-safe") {
        let mm := mulmod(a, b, not(0))
        low := mul(a, b)
        high := sub(sub(mm, low), lt(mm, low))
    }
}
```

### panic(uint256)

- **Kind**: internal
- **Source**: 1776:194:55
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

```solidity
/// @dev Reverts with a panic code. Recommended to use with
///  the internal constants with predefined codes.
function panic(uint256 code) internal pure {
    assembly ("memory-safe") {
        mstore(0x00, 0x4e487b71)
        mstore(0x20, code)
        revert(0x1c, 0x24)
    }
}
```

### ternary(bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5071:294:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

```solidity
///  @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
///  IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
///  However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
///  one branch when needed, making this function more expensive.
function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
    unchecked {
        return b ^ ((a ^ b) * SafeCast.toUint(condition));
    }
}
```

### toTypedDataHash(bytes32,bytes32)

- **Kind**: internal
- **Source**: 3874:374:58
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol:MessageHashUtils:toTypedDataHash(bytes32,bytes32)`

```solidity
///  @dev Returns the keccak256 digest of an EIP-712 typed data (ERC-191 version `0x01`).
///  The digest is calculated from a `domainSeparator` and a `structHash`, by prefixing them with
///  `\x19\x01` and hashing the result. It corresponds to the hash signed by the
///  https://eips.ethereum.org/EIPS/eip-712[`eth_signTypedData`] JSON-RPC method as part of EIP-712.
///  See {ECDSA-recover}.
function toTypedDataHash(bytes32 domainSeparator, bytes32 structHash) internal pure returns (bytes32 digest) {
    assembly ("memory-safe") {
        let ptr := mload(0x40)
        mstore(ptr, "\u0019\u0001")
        mstore(add(ptr, 0x02), domainSeparator)
        mstore(add(ptr, 0x22), structHash)
        digest := keccak256(ptr, 0x42)
    }
}
```

### log(string,address,uint256)

- **Kind**: internal
- **Source**: 13838:169:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address,uint256)`

```solidity
function log(string memory p0, address p1, uint256 p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 8891:133:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 8650:235:23
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### _deposit(uint256,address,address)

- **Kind**: internal
- **Source**: 33093:162:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deposit(uint256,address,address)`

```solidity
function _deposit(uint256 depositAmount, address superVault, address asset_) internal {
    __deposit(instanceOnEth, depositAmount, superVault, asset_);
}
```

### __deposit(struct AccountInstance,uint256,address,address)

- **Kind**: internal
- **Source**: 24723:958:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:__deposit(struct AccountInstance,uint256,address,address)`

```solidity
function __deposit(AccountInstance memory accInst, uint256 depositAmount, address superVault, address asset_) internal {
    address[] memory hooksAddresses = new address[](1);
    hooksAddresses[0] = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
    bytes[] memory hooksData = new bytes[](1);
    hooksData[0] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), superVault, asset_, depositAmount, false, address(0), 0);
    ISuperExecutor.ExecutorEntry memory entry = ISuperExecutor.ExecutorEntry({hooksAddresses: hooksAddresses, hooksData: hooksData});
    UserOpData memory userOpData = _getExecOps(accInst, superExecutorOnEth, abi.encode(entry));
    executeOp(userOpData);
}
```

### _getHookAddress(uint64,string)

- **Kind**: internal
- **Source**: 21123:153:480
- **Link**: `lib/v2-core/test/BaseTest.t.sol:BaseTest:_getHookAddress(uint64,string)`

```solidity
function _getHookAddress(uint64 chainId, string memory hookName) internal view returns (address) {
    return hookAddresses[chainId][hookName];
}
```

### _createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256)

- **Kind**: internal
- **Source**: 12335:449:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256)`

```solidity
function _createApproveAndDeposit4626HookData(bytes32 yieldSourceOracleId, address vault, address token, uint256 amount, bool usePrevHookAmount, address vaultBank, uint256 dstChainId) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, token, amount, usePrevHookAmount, vaultBank, dstChainId);
}
```

### _getYieldSourceOracleId(bytes32,address)

- **Kind**: internal
- **Source**: 4752:156:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_getYieldSourceOracleId(bytes32,address)`

```solidity
function _getYieldSourceOracleId(bytes32 id, address sender) internal pure returns (bytes32) {
    return keccak256(abi.encodePacked(id, sender));
}
```

### _getExecOps(struct AccountInstance,contract ISuperExecutor,bytes)

- **Kind**: internal
- **Source**: 3424:376:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_getExecOps(struct AccountInstance,contract ISuperExecutor,bytes)`

```solidity
function _getExecOps(AccountInstance memory instance, ISuperExecutor superExecutor, bytes memory data) internal returns (UserOpData memory userOpData) {
    return instance.getExecOps(address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator));
}
```

### getExecOps(struct AccountInstance,address,uint256,bytes,address)

- **Kind**: internal
- **Source**: 4143:577:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:getExecOps(struct AccountInstance,address,uint256,bytes,address)`

```solidity
/// @notice Configures a userOp to execute a single operation
///  @param instance AccountInstance struct containing the account and accountHelper
///  @param target The address of the contract to call
///  @param value The amount of ether to send
///  @param callData The data to send to the contract
///  @param txValidator The address of the transaction validator
///  @return userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
function getExecOps(AccountInstance memory instance, address target, uint256 value, bytes memory callData, address txValidator) internal returns (UserOpData memory userOpData) {
    bytes memory erc7579ExecCall = HelperBase(instance.accountHelper).encode(target, value, callData);
    (userOpData.userOp, userOpData.userOpHash) = HelperBase(instance.accountHelper).execUserOp(instance, erc7579ExecCall, txValidator);
    userOpData.entrypoint = instance.aux.entrypoint;
}
```

### executeOp(struct UserOpData)

- **Kind**: internal
- **Source**: 2902:141:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:executeOp(struct UserOpData)`

```solidity
function executeOp(UserOpData memory userOpData) public returns (ExecutionReturnData memory) {
    return userOpData.execUserOps();
}
```

### execUserOps(struct UserOpData)

- **Kind**: internal
- **Source**: 3413:243:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:execUserOps(struct UserOpData)`

```solidity
/// @notice Executes userOps on the entrypoint
///  @param userOpData UserOpData struct containing the userOp, userOpHash, and entrypoint
///  @return ExecutionReturnData struct containing the logs from the execution
function execUserOps(UserOpData memory userOpData) internal returns (ExecutionReturnData memory) {
    return ERC4337Helpers.exec4337(userOpData.userOp, userOpData.entrypoint);
}
```

### exec4337(struct PackedUserOperation,contract IEntryPoint)

- **Kind**: internal
- **Source**: 5908:333:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:exec4337(struct PackedUserOperation,contract IEntryPoint)`

```solidity
function exec4337(PackedUserOperation memory userOp, IEntryPoint onEntryPoint) internal returns (ExecutionReturnData memory logs) {
    PackedUserOperation[] memory userOps = new PackedUserOperation[](1);
    userOps[0] = userOp;
    return exec4337(userOps, onEntryPoint);
}
```

### exec4337(struct PackedUserOperation[],contract IEntryPoint)

- **Kind**: internal
- **Source**: 1486:4373:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:exec4337(struct PackedUserOperation[],contract IEntryPoint)`

```solidity
function exec4337(PackedUserOperation[] memory userOps, IEntryPoint onEntryPoint) internal returns (ExecutionReturnData memory executionData) {
    ExecutionContext memory ctx = ExecutionContext({isExpectRevert: getExpectRevert(), beneficiary: payable(address(0x69)), userOpCalldata: "", success: false, returnData: ""});
    if (envOr("SIMULATE", false) || getSimulateUserOp()) {
        bool simulationSuccess = userOps[0].simulateUserOp(address(onEntryPoint));
        if (ctx.isExpectRevert == 0) {
            require(simulationSuccess, "UserOperation simulation failed");
        }
    }
    recordLogs();
    ctx.userOpCalldata = abi.encodeCall(IEntryPoint.handleOps, (userOps, ctx.beneficiary));
    (ctx.success, ctx.returnData) = address(onEntryPoint).call(ctx.userOpCalldata);
    if (ctx.isExpectRevert == 0) {
        require(ctx.success, "UserOperation execution failed");
    } else if ((ctx.isExpectRevert == 2) && (!ctx.success)) {
        checkRevertMessage(ctx.returnData);
    }
    VmSafe.Log[] memory logs = getRecordedLogs();
    executionData = ExecutionReturnData(logs);
    uint256 totalUserOpGas = 0;
    for (uint256 i; i < logs.length; i++) {
        if (logs[i].topics[0] == 0x49628fd1471006c1482da88028e9ce4dbb080b815c9b0344d39e5a8e6ec1419f) {
            (uint256 nonce, bool userOpSuccess, , uint256 actualGasUsed) = abi.decode(logs[i].data, (uint256, bool, uint256, uint256));
            totalUserOpGas = actualGasUsed;
            if (!userOpSuccess) {
                bytes32 userOpHash = logs[i].topics[1];
                if (ctx.isExpectRevert == 0) {
                    bytes memory revertReason = getUserOpRevertReason(logs, userOpHash);
                    address account = address(bytes20(logs[i].topics[2]));
                    revert UserOperationReverted(userOpHash, account, getLabel(account), nonce, revertReason);
                } else {
                    if (ctx.isExpectRevert == 2) {
                        checkRevertMessage(getUserOpRevertReason(logs, userOpHash));
                    }
                    clearExpectRevert();
                }
            }
        } else if (logs[i].topics[0] == 0xd21d0b289f126c4b473ea641963e766833c2f13866e4ff480abd787c100ef123) {
            (uint256 moduleType, address module) = abi.decode(logs[i].data, (uint256, address));
            writeInstalledModule(InstalledModule(moduleType, module), logs[i].emitter);
        } else if (logs[i].topics[0] == 0x341347516a9de374859dfda710fa4828b2d48cb57d4fbe4c1149612b8e02276e) {
            (uint256 moduleType, address module) = abi.decode(logs[i].data, (uint256, address));
            InstalledModule[] memory installedModules = getInstalledModules(logs[i].emitter);
            for (uint256 j; j < installedModules.length; j++) {
                if ((installedModules[j].moduleAddress == module) && (installedModules[j].moduleType == moduleType)) {
                    removeInstalledModule(j, logs[i].emitter);
                    break;
                }
            }
        }
    }
    string memory gasIdentifier = getGasIdentifier();
    if ((envOr("GAS", false) && (bytes(gasIdentifier).length > 0)) && (bytes(gasIdentifier).length < 50)) {
        calculateGas(userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas);
    }
    for (uint256 i; i < userOps.length; i++) {
        emit ModuleKitLogs.ModuleKit_Exec4337(userOps[i].sender);
    }
}
```

### getExpectRevert()

- **Kind**: free-function
- **Source**: 588:163:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getExpectRevert()`

```solidity
function getExpectRevert() view returns (uint256 value) {
    bytes32 slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        value := sload(slot)
    }
}
```

### getSimulateUserOp()

- **Kind**: free-function
- **Source**: 1949:166:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getSimulateUserOp()`

```solidity
function getSimulateUserOp() view returns (bool value) {
    bytes32 slot = keccak256("ModuleKit.SimulateUserOp");
    assembly {
        value := sload(slot)
    }
}
```

### envOr(string,bool)

- **Kind**: internal
- **Source**: 4355:148:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:envOr(string,bool)`

```solidity
function envOr(string memory name, bool defaultValue) public view returns (bool value) {
    return Vm(VM_ADDR).envOr(name, defaultValue);
}
```

### simulateUserOp(struct PackedUserOperation,address)

- **Kind**: internal
- **Source**: 1279:1591:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:simulateUserOp(struct PackedUserOperation,address)`

```solidity
///  Simulates a UserOperation and validates the ERC-4337 rules
///  @dev This function will revert if the UserOperation is invalid
///  @dev If the simulation fails, the rules might not be checked correctly so simulationSuccess
///  should be handled accordingly
///  @dev This function is used for v0.7 ERC-4337
///  @param userOp The PackedUserOperation to simulate
///  @param onEntryPoint The address of the entry point to simulate the UserOperation on
///  @return simulationSuccess True if the simulation was successful, false otherwise
function simulateUserOp(PackedUserOperation memory userOp, address onEntryPoint) internal returns (bool simulationSuccess) {
    _preSimulation();
    bytes memory epCallData = abi.encodeCall(IEntryPointSimulations.simulateValidation, (userOp));
    bytes memory returnData;
    (simulationSuccess, returnData) = address(onEntryPoint).call(epCallData);
    if (!simulationSuccess) {
        return simulationSuccess;
    }
    IEntryPointSimulations.ValidationResult memory result = abi.decode(returnData, (IEntryPointSimulations.ValidationResult));
    if (result.returnInfo.accountValidationData != 0) {
        bool sigFailed = (result.returnInfo.accountValidationData & 1) == 1;
        if (sigFailed) {
            simulationSuccess = false;
        }
    }
    UserOperationDetails memory userOpDetails = UserOperationDetails({entryPoint: onEntryPoint, sender: userOp.sender, initCode: userOp.initCode, paymasterAndData: userOp.paymasterAndData});
    _postSimulation(userOpDetails);
}
```

### _preSimulation()

- **Kind**: internal
- **Source**: 4794:514:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:_preSimulation()`

```solidity
///  Pre-simulation setup
function _preSimulation() internal {
    uint256 snapShotId = snapshotState();
    bytes32 snapShotSlot = keccak256(abi.encodePacked("Simulator.SnapshotId"));
    assembly {
        sstore(snapShotSlot, snapShotId)
    }
    startMappingRecording();
    startDebugTraceRecording();
}
```

### snapshotState()

- **Kind**: free-function
- **Source**: 394:86:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:snapshotState()`

```solidity
function snapshotState() returns (uint256) {
    return Vm(VM_ADDR).snapshotState();
}
```

### startMappingRecording()

- **Kind**: free-function
- **Source**: 579:77:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:startMappingRecording()`

```solidity
function startMappingRecording() {
    Vm(VM_ADDR).startMappingRecording();
}
```

### startDebugTraceRecording()

- **Kind**: free-function
- **Source**: 961:83:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:startDebugTraceRecording()`

```solidity
function startDebugTraceRecording() {
    Vm(VM_ADDR).startDebugTraceRecording();
}
```

### _postSimulation(struct UserOperationDetails)

- **Kind**: internal
- **Source**: 5436:688:139
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/Simulator.sol:Simulator:_postSimulation(struct UserOperationDetails)`

```solidity
///  Post-simulation validation
///  @param userOpDetails The UserOperationDetails to validate
function _postSimulation(UserOperationDetails memory userOpDetails) internal {
    VmSafe.DebugStep[] memory debugTrace = stopAndReturnDebugTraceRecording();
    ERC4337SpecsParser.parseValidation(userOpDetails, debugTrace);
    stopMappingRecording();
    uint256 snapShotId;
    bytes32 snapShotSlot = keccak256(abi.encodePacked("Simulator.SnapshotId"));
    assembly {
        snapShotId := sload(snapShotSlot)
    }
    revertToState(snapShotId);
}
```

### stopAndReturnDebugTraceRecording()

- **Kind**: free-function
- **Source**: 1046:148:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:stopAndReturnDebugTraceRecording()`

```solidity
function stopAndReturnDebugTraceRecording() returns (VmSafe.DebugStep[] memory steps) {
    return Vm(VM_ADDR).stopAndReturnDebugTraceRecording();
}
```

### parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[])

- **Kind**: internal
- **Source**: 1656:1779:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[])`

```solidity
///  Parses and validates the ERC-4337 rules
///  @param userOpDetails The UserOperationDetails to validate
///  @param debugTrace A trace of used opcodes, stack and memory to validate
function parseValidation(UserOperationDetails memory userOpDetails, VmSafe.DebugStep[] memory debugTrace) internal {
    Entities memory entities = getEntities(userOpDetails);
    (VmSafe.DebugStep[] memory filteredUserOpSteps, VmSafe.DebugStep[] memory filteredPaymasterUserOpSteps) = filterDebugTrace(debugTrace, entities, userOpDetails.entryPoint);
    validateBannedOpcodes(filteredUserOpSteps, entities);
    validateBannedOpcodes(filteredPaymasterUserOpSteps, entities);
    validateOutOfGas(filteredUserOpSteps);
    validateOutOfGas(filteredPaymasterUserOpSteps);
    validateBannedStorageLocations(filteredUserOpSteps, entities, userOpDetails);
    validateBannedStorageLocations(filteredPaymasterUserOpSteps, entities, userOpDetails);
    validateCalls(filteredUserOpSteps, entities, userOpDetails.entryPoint);
    validateCalls(filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint);
    validateExtOpcodes(filteredUserOpSteps, entities);
    validateExtOpcodes(filteredPaymasterUserOpSteps, entities);
    validateCreate(filteredUserOpSteps, entities, userOpDetails);
    validateCreate(filteredPaymasterUserOpSteps, entities, userOpDetails);
}
```

### getEntities(struct UserOperationDetails)

- **Kind**: internal
- **Source**: 25300:1252:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:getEntities(struct UserOperationDetails)`

```solidity
///  Returns the entities of the UserOperation
///  @param userOpDetails The UserOperationDetails to get the entities of
///  @return entities The entities of the UserOperation
function getEntities(UserOperationDetails memory userOpDetails) internal view returns (Entities memory entities) {
    address factory;
    if (userOpDetails.initCode.length > 20) {
        bytes memory initCode = userOpDetails.initCode;
        assembly {
            factory := mload(add(initCode, 20))
        }
    }
    address paymaster;
    if (userOpDetails.paymasterAndData.length > 20) {
        bytes memory paymasterAndData = userOpDetails.paymasterAndData;
        assembly {
            paymaster := mload(add(paymasterAndData, 20))
        }
    }
    address aggregator;
    entities = Entities({account: userOpDetails.sender, factory: factory, isFactoryStaked: isStaked(factory, userOpDetails.entryPoint), paymaster: paymaster, isPaymasterStaked: isStaked(paymaster, userOpDetails.entryPoint), aggregator: aggregator, isAggregatorStaked: isStaked(aggregator, userOpDetails.entryPoint)});
}
```

### isStaked(address,address)

- **Kind**: internal
- **Source**: 28211:470:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isStaked(address,address)`

```solidity
///  Returns whether the entity is staked
///  @param entity The entity to check
///  @return isEntityStaked Whether the entity is staked
function isStaked(address entity, address entryPoint) internal view returns (bool isEntityStaked) {
    IStakeManager.DepositInfo memory deposit = IStakeManager(entryPoint).getDepositInfo(entity);
    isEntityStaked = (deposit.stake >= MIN_STAKE_VALUE) && (deposit.unstakeDelaySec >= MIN_UNSTAKE_DELAY);
}
```

### filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 6062:2998:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Filter debug trace, we are interested in the following debug traces:
///  - Entrypoint -> validateUserOp
///  - Entrypoint - validatePaymasterUserOp
///  @param debugTrace The debug trace to filter
///  @param entities The entities of the userOp
///  @param entryPoint The entryPoint address
///  @return filteredUserOpSteps The filtered debug steps
///  @return filteredPaymasterUserOpSteps The filtered debug steps
function filterDebugTrace(VmSafe.DebugStep[] memory debugTrace, Entities memory entities, address entryPoint) private pure returns (VmSafe.DebugStep[] memory, VmSafe.DebugStep[] memory) {
    VmSafe.DebugStep[] memory filteredUserOpSteps = new VmSafe.DebugStep[](debugTrace.length);
    VmSafe.DebugStep[] memory filteredPaymasterUserOpSteps = new VmSafe.DebugStep[](debugTrace.length);
    uint256 filteredUserOpStepsLength;
    uint256 filteredPaymasterUserOpStepsLength;
    uint256 startDepth = 0;
    for (uint256 i; i < debugTrace.length; i++) {
        if (debugTrace[i].contractAddr == entryPoint) {
            startDepth = debugTrace[i].depth;
            break;
        }
    }
    address currentContractAddr;
    for (uint256 i = 0; i < debugTrace.length; i++) {
        if ((debugTrace[i].depth == startDepth) && (debugTrace[i].contractAddr == entryPoint)) {
            if ((debugTrace[i].opcode == 0xF1) || (debugTrace[i].opcode == 0xFA)) {
                currentContractAddr = address(uint160(uint256(debugTrace[i].stack[1])));
            }
            continue;
        }
        if (debugTrace[i].depth > startDepth) {
            if (currentContractAddr == entities.account) {
                filteredUserOpSteps[filteredUserOpStepsLength++] = debugTrace[i];
            } else if (currentContractAddr == entities.paymaster) {
                filteredPaymasterUserOpSteps[filteredPaymasterUserOpStepsLength++] = debugTrace[i];
            }
        }
    }
    assembly {
        mstore(filteredUserOpSteps, filteredUserOpStepsLength)
        mstore(filteredPaymasterUserOpSteps, filteredPaymasterUserOpStepsLength)
    }
    return (filteredUserOpSteps, filteredPaymasterUserOpSteps);
}
```

### validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)

- **Kind**: internal
- **Source**: 3559:2043:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)`

```solidity
///  Validates that no banned opcodes are used
///  @param debugTrace The debug trace to validate
function validateBannedOpcodes(VmSafe.DebugStep[] memory debugTrace, Entities memory entities) internal pure {
    for (uint256 i; i < debugTrace.length; i++) {
        if (isForbiddenOpcode(debugTrace[i].opcode)) {
            if (debugTrace[i].opcode == 0x5A) {
                if (((i + 1) >= debugTrace.length) || ((((debugTrace[i + 1].opcode != 0xF1) && (debugTrace[i + 1].opcode != 0xF4)) && (debugTrace[i + 1].opcode != 0xF2)) && (debugTrace[i + 1].opcode != 0xFA))) {
                    revert InvalidOpcode(debugTrace[i].contractAddr, 0x5A);
                }
            } else if (((debugTrace[i].opcode == 0x31) || (debugTrace[i].opcode == 0x47)) && isEntityAndStaked(entities, debugTrace[i].contractAddr)) {
                continue;
            } else {
                revert InvalidOpcode(debugTrace[i].contractAddr, debugTrace[i].opcode);
            }
        }
    }
}
```

### isForbiddenOpcode(uint8)

- **Kind**: internal
- **Source**: 29220:729:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isForbiddenOpcode(uint8)`

```solidity
///  Checks if the opcode is a forbidden opcode
///  @param opcode The opcode to check
///  @return isForbidden Whether the opcode is forbidden
function isForbiddenOpcode(uint8 opcode) private pure returns (bool isForbidden) {
    return ((((((((((((((opcode == 0x3A) || (opcode == 0x45)) || (opcode == 0x44)) || (opcode == 0x42)) || (opcode == 0x48)) || (opcode == 0x40)) || (opcode == 0x43)) || (opcode == 0x47)) || (opcode == 0x31)) || (opcode == 0x32)) || (opcode == 0x5A)) || (opcode == 0xF0)) || (opcode == 0x41)) || (opcode == 0xFE)) || (opcode == 0xFF);
}
```

### isEntityAndStaked(struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 26835:634:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isEntityAndStaked(struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Returns whether something is an entity and is staked
///  @param entities The entities of the UserOperation
///  @param toCheck The address to check
///  @return addressIsEntityAndStaked Whether the address is an entity and is staked
function isEntityAndStaked(Entities memory entities, address toCheck) internal pure returns (bool addressIsEntityAndStaked) {
    if (toCheck == entities.account) {
        addressIsEntityAndStaked = true;
    } else if (toCheck == entities.factory) {
        addressIsEntityAndStaked = entities.isFactoryStaked;
    } else if (toCheck == entities.paymaster) {
        addressIsEntityAndStaked = entities.isPaymasterStaked;
    } else if (toCheck == entities.aggregator) {
        addressIsEntityAndStaked = entities.isAggregatorStaked;
    }
}
```

### validateOutOfGas(struct VmSafe.DebugStep[])

- **Kind**: internal
- **Source**: 9203:345:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateOutOfGas(struct VmSafe.DebugStep[])`

```solidity
///  Validate that the simulation does not revert with Out of Gas
///  @param debugTrace The debug trace to validate
function validateOutOfGas(VmSafe.DebugStep[] memory debugTrace) internal pure {
    for (uint256 i; i < debugTrace.length; i++) {
        if (debugTrace[i].isOutOfGas) {
            revert("[OP-020] Simulation reverts with Out of Gas");
        }
    }
}
```

### validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)

- **Kind**: internal
- **Source**: 9851:4230:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)`

```solidity
///  Validates that no banned storage locations are accessed
///  @param debugTrace The debug trace to validate
///  @param entities  The entities of the userOp
///  @param userOpDetails The UserOperationDetails to validate
function validateBannedStorageLocations(VmSafe.DebugStep[] memory debugTrace, Entities memory entities, UserOperationDetails memory userOpDetails) internal {
    for (uint256 i; i < debugTrace.length; i++) {
        VmSafe.DebugStep memory currentStep = debugTrace[i];
        if ((((currentStep.opcode != 0x54) && (currentStep.opcode != 0x55)) && (currentStep.opcode != 0x5C)) && (currentStep.opcode != 0x5D)) {
            continue;
        }
        address currentAccessAccount = currentStep.contractAddr;
        bytes32 currentSlot = bytes32(uint256(currentStep.stack[0]));
        bool notEntity = !isEntity(entities, currentAccessAccount);
        if (currentAccessAccount == entities.account) {
            continue;
        }
        /// Access to associated storage of the account in an external (non-entity) contract
        bool accountAlreadyExists = (entities.account.code.length != 0) || ((currentAccessAccount == userOpDetails.entryPoint) && (entities.account != address(0)));
        bool isFactoryStaked = entities.isFactoryStaked;
        if ((notEntity && isAssociatedStorage(currentSlot, currentAccessAccount, entities.account)) && (accountAlreadyExists || isFactoryStaked)) {
            continue;
        }
        if (entities.isFactoryStaked || entities.isPaymasterStaked) {
            if (((currentAccessAccount == entities.factory) && entities.isFactoryStaked) || ((currentAccessAccount == entities.paymaster) && entities.isPaymasterStaked)) {
                continue;
            } else if (notEntity && ((isAssociatedStorage(currentSlot, currentAccessAccount, entities.factory) && entities.isFactoryStaked) || (isAssociatedStorage(currentSlot, currentAccessAccount, entities.paymaster) && entities.isPaymasterStaked))) {
                continue;
            } else if (notEntity && ((currentStep.opcode == 0x54) || (currentStep.opcode == 0x5C))) {
                continue;
            }
        }
        bool isWrite = (currentStep.opcode == 0x55) || (currentStep.opcode == 0x5D);
        revert InvalidStorageLocation(currentAccessAccount, getLabel(currentAccessAccount), currentSlot, isWrite ? bytes32(uint256(currentStep.stack[1])) : bytes32(0), isWrite);
    }
}
```

### isEntity(struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 27643:388:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isEntity(struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Returns wether something is an entity
///  @param entities The entities of the UserOperation
///  @param toCheck The address to check
function isEntity(Entities memory entities, address toCheck) internal pure returns (bool addressIsEntity) {
    if ((((toCheck == entities.account) || (toCheck == entities.factory)) || (toCheck == entities.paymaster)) || (toCheck == entities.aggregator)) {
        addressIsEntity = true;
    }
}
```

### isAssociatedStorage(bytes32,address,address)

- **Kind**: internal
- **Source**: 20836:774:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isAssociatedStorage(bytes32,address,address)`

```solidity
///  Returns whether the current storage slot matches a specific entity
///  @param currentSlot The current storage slot
///  @param currentAccessAccount The contract address of the current access
///  @param entity The entity to check
///  @return isAssociated Whether the current storage slot matches a specific entity
function isAssociatedStorage(bytes32 currentSlot, address currentAccessAccount, address entity) internal returns (bool isAssociated) {
    if (slotMatchesEntity(currentSlot, entity)) {
        isAssociated = true;
    } else {
        (bool found, bytes32 key) = getMappingParent(currentAccessAccount, currentSlot);
        if (found) {
            if (slotMatchesEntity(key, entity)) {
                isAssociated = true;
            }
        }
    }
}
```

### slotMatchesEntity(bytes32,address)

- **Kind**: internal
- **Source**: 23408:355:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:slotMatchesEntity(bytes32,address)`

```solidity
///  Returns whether the current storage slot matches an entity
///  @param slot The current storage slot
///  @param entity The entity to check
///  @return _ Whether the current storage slot matches an entity
function slotMatchesEntity(bytes32 slot, address entity) internal pure returns (bool) {
    if (slot == bytes32(0)) {
        return false;
    }
    return slot == bytes32(uint256(uint160(entity)));
}
```

### getMappingParent(address,bytes32)

- **Kind**: internal
- **Source**: 24067:1014:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:getMappingParent(address,bytes32)`

```solidity
///  Returns the parent of the current storage slot
///  @param currentAccessAccount The contract address of the current access
///  @param currentSlot The current storage slot
///  @return found Whether the parent was found
///  @return key The parent slot
function getMappingParent(address currentAccessAccount, bytes32 currentSlot) internal returns (bool found, bytes32 key) {
    (bool _found, bytes32 _key, ) = getMappingKeyAndParentOf(currentAccessAccount, currentSlot);
    if (_found) {
        found = _found;
        key = _key;
    } else {
        for (uint256 k = 1; (k <= 128) && (k <= uint256(currentSlot)); k++) {
            (_found, _key, ) = getMappingKeyAndParentOf(currentAccessAccount, bytes32(uint256(currentSlot) - k));
            if (_found) {
                found = _found;
                key = _key;
                break;
            }
        }
    }
}
```

### getMappingKeyAndParentOf(address,bytes32)

- **Kind**: free-function
- **Source**: 735:163:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:getMappingKeyAndParentOf(address,bytes32)`

```solidity
function getMappingKeyAndParentOf(address target, bytes32 slot) returns (bool, bytes32, bytes32) {
    return Vm(VM_ADDR).getMappingKeyAndParentOf(target, slot);
}
```

### getLabel(address)

- **Kind**: free-function
- **Source**: 289:103:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:getLabel(address)`

```solidity
function getLabel(address addr) view returns (string memory) {
    return Vm(VM_ADDR).getLabel(addr);
}
```

### validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)

- **Kind**: internal
- **Source**: 14362:2479:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address)`

```solidity
///  Validates *CALL operations in the trace (CALL, DELEGATECALL, CALLCODE, STATICCALL)
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
///  @param entryPoint The EntryPoint contract address
function validateCalls(VmSafe.DebugStep[] memory debugSteps, Entities memory entities, address entryPoint) internal view {
    for (uint256 i = 0; i < debugSteps.length; i++) {
        uint8 op = debugSteps[i].opcode;
        if ((((op != 0xF1) && (op != 0xF2)) && (op != 0xF4)) && (op != 0xFA)) {
            continue;
        }
        address targetAddr = address(uint160(uint256(debugSteps[i].stack[1])));
        uint256 value = ((op == 0xF1) || (op == 0xF2)) ? uint256(debugSteps[i].stack[2]) : 0;
        bytes memory callData = debugSteps[i].memoryInput;
        if (((targetAddr.code.length == 0) && (!isPrecompile(targetAddr))) && (targetAddr != entities.account)) {
            revert("[OP-041] Cannot *CALL addresses without code");
        }
        bool callerIsAccount = debugSteps[i].contractAddr == entities.account;
        bool callerIsFactory = debugSteps[i].contractAddr == entities.factory;
        bool calleeIsEntryPoint = targetAddr == entryPoint;
        if (value > 0) {
            if (!((callerIsAccount || callerIsFactory) && calleeIsEntryPoint)) {
                revert("[OP-061] Cannot use value except from account or factory to EntryPoint");
            }
        }
        if (calleeIsEntryPoint) {
            bytes4 selector;
            if (callData.length >= 4) {
                selector = bytes4(abi.encodePacked(callData[0], callData[1], callData[2], callData[3]));
            }
            if (!(((callerIsAccount || callerIsFactory) && (selector == bytes4(0xb760faf9))) || (callerIsAccount && (callData.length == 0)))) {
                revert("[OP-052] Cannot call EntryPoint except depositTo from factory or account");
            }
        }
    }
}
```

### isPrecompile(address)

- **Kind**: internal
- **Source**: 28874:160:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:isPrecompile(address)`

```solidity
///  Returns whether the address is a precompile
///  @param target The address to check
///  @return isPrecompile Whether the address is a precompile
function isPrecompile(address target) internal pure returns (bool) {
    return (uint256(uint160(target)) <= 0x09) || (uint256(uint160(target)) == 0x100);
}
```

### validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)

- **Kind**: internal
- **Source**: 17061:862:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities)`

```solidity
///  Validates EXT* operations in the trace (EXTCODESIZE, EXTCODEHASH, EXTCODECOPY)
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
function validateExtOpcodes(VmSafe.DebugStep[] memory debugSteps, Entities memory entities) internal view {
    for (uint256 i = 0; i < debugSteps.length; i++) {
        uint8 op = debugSteps[i].opcode;
        if (((op != 0x3B) && (op != 0x3C)) && (op != 0x3F)) {
            continue;
        }
        address targetAddr = address(uint160(uint256(debugSteps[i].stack[0])));
        if (((targetAddr.code.length == 0) && (!isPrecompile(targetAddr))) && (targetAddr != entities.account)) {
            revert("[OP-041] EXT* opcodes cannot access addresses without code");
        }
    }
}
```

### validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)

- **Kind**: internal
- **Source**: 18178:1122:140
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/SpecsParser.sol:ERC4337SpecsParser:validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails)`

```solidity
///  Validates CREATE operations in the trace
///  @param debugSteps The filtered debug steps to validate
///  @param entities The entities of the userOp
///  @param userOpDetails The UserOperationDetails containing initCode
function validateCreate(VmSafe.DebugStep[] memory debugSteps, Entities memory entities, UserOperationDetails memory userOpDetails) internal pure {
    uint256 createCount = 0;
    for (uint256 i = 0; i < debugSteps.length; i++) {
        if (debugSteps[i].opcode == 0xF5) {
            createCount++;
            if (userOpDetails.initCode.length == 0) {
                revert("[OP-031] CREATE2 not allowed without initCode");
            }
            if (createCount > 1) {
                revert("[OP-031] Multiple CREATE2 operations not allowed");
            }
            address createdAddr = address(uint160(uint256(debugSteps[i].stack[0])));
            if (createdAddr != entities.account) {
                revert("[OP-031] CREATE2 must deploy the account contract");
            }
        }
    }
}
```

### stopMappingRecording()

- **Kind**: free-function
- **Source**: 658:75:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:stopMappingRecording()`

```solidity
function stopMappingRecording() {
    Vm(VM_ADDR).stopMappingRecording();
}
```

### revertToState(uint256)

- **Kind**: free-function
- **Source**: 482:95:142
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@rhinestone/erc4337-validation/src/lib/Vm.sol:revertToState(uint256)`

```solidity
function revertToState(uint256 id) returns (bool) {
    return Vm(VM_ADDR).revertToState(id);
}
```

### recordLogs()

- **Kind**: free-function
- **Source**: 1458:55:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:recordLogs()`

```solidity
function recordLogs() {
    Vm(VM_ADDR).recordLogs();
}
```

### checkRevertMessage(bytes)

- **Kind**: internal
- **Source**: 6800:719:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:checkRevertMessage(bytes)`

```solidity
function checkRevertMessage(bytes memory actualReason) internal view {
    bytes memory revertMessage = getExpectRevertMessage();
    if (actualReason.length >= 4) {
        bytes4 actual = bytes4(actualReason);
        bytes4 expected = bytes4(revertMessage);
        if (actual == bytes4(0x65c8fd4d)) {
            return parseFailedOpWithRevert(actualReason, revertMessage);
        } else if (actual != expected) {
            revert InvalidRevertMessageBytes(revertMessage, actualReason);
        }
        return;
    }
    if (revertMessage.length != actualReason.length) {
        revert InvalidRevertMessageBytes(revertMessage, actualReason);
    }
}
```

### getExpectRevertMessage()

- **Kind**: free-function
- **Source**: 753:180:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getExpectRevertMessage()`

```solidity
function getExpectRevertMessage() view returns (bytes memory data) {
    bytes32 slot = keccak256("ModuleKit.ExpectMessageSlot");
    assembly {
        data := sload(slot)
    }
}
```

### parseFailedOpWithRevert(bytes,bytes)

- **Kind**: internal
- **Source**: 7525:1258:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:parseFailedOpWithRevert(bytes,bytes)`

```solidity
function parseFailedOpWithRevert(bytes memory actualReason, bytes memory revertMessage) internal pure {
    uint256 bytesOffset;
    assembly {
        let ptr := add(actualReason, 0x20)
        ptr := add(ptr, 0x04)
        ptr := add(ptr, 0x40)
        bytesOffset := mload(ptr)
    }
    bytes memory actual;
    assembly {
        let ptr := add(actualReason, 0x20)
        ptr := add(ptr, 0x04)
        ptr := add(ptr, bytesOffset)
        let innerLength := mload(ptr)
        actual := mload(0x40)
        mstore(actual, innerLength)
        let srcPtr := add(ptr, 0x20)
        let destPtr := add(actual, 0x20)
        mstore(destPtr, mload(srcPtr))
        mstore(0x40, add(add(actual, 0x20), innerLength))
    }
    if (revertMessage.length == 4) {
        bytes4 expected = bytes4(revertMessage);
        if (expected != bytes4(actual)) {
            revert InvalidRevertMessage(expected, bytes4(actual));
        }
    } else {
        if (keccak256(actual) != keccak256(revertMessage)) {
            revert InvalidRevertMessageBytes(revertMessage, actual);
        }
    }
}
```

### getRecordedLogs()

- **Kind**: free-function
- **Source**: 1515:102:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:getRecordedLogs()`

```solidity
function getRecordedLogs() returns (VmSafe.Log[] memory) {
    return Vm(VM_ADDR).getRecordedLogs();
}
```

### getUserOpRevertReason(struct VmSafe.Log[],bytes32)

- **Kind**: internal
- **Source**: 6247:547:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:getUserOpRevertReason(struct VmSafe.Log[],bytes32)`

```solidity
function getUserOpRevertReason(VmSafe.Log[] memory logs, bytes32 userOpHash) internal pure returns (bytes memory revertReason) {
    for (uint256 i; i < logs.length; i++) {
        if ((logs[i].topics[0] == 0x1c4fada7374c0a9ee8841fc38afe82932dc0f8e69012e927f061a8bae611a201) && (logs[i].topics[1] == userOpHash)) {
            (, revertReason) = abi.decode(logs[i].data, (uint256, bytes));
        }
    }
}
```

### getLabel(address)

- **Kind**: free-function
- **Source**: 1066:103:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:getLabel(address)`

```solidity
function getLabel(address addr) view returns (string memory) {
    return Vm(VM_ADDR).getLabel(addr);
}
```

### clearExpectRevert()

- **Kind**: free-function
- **Source**: 935:230:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:clearExpectRevert()`

```solidity
function clearExpectRevert() {
    bytes32 slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        sstore(slot, 0)
    }
    slot = keccak256("ModuleKit.ExpectMessageSlot");
    assembly {
        sstore(slot, 0)
    }
}
```

### writeInstalledModule(struct InstalledModule,address)

- **Kind**: free-function
- **Source**: 6700:1960:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeInstalledModule(struct InstalledModule,address)`

```solidity
// Failed to render writeInstalledModule(struct InstalledModule,address) implementation (FunctionDefinition#96186). Check logs for details.
```

### getInstalledModules(address)

- **Kind**: free-function
- **Source**: 10596:2115:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getInstalledModules(address)`

```solidity
function getInstalledModules(address account) view returns (InstalledModule[] memory modules) {
    bytes32 lengthSlot = keccak256(abi.encode("ModuleKit.InstalledModuleSlot.", keccak256(abi.encodePacked(account))));
    bytes32 headSlot = keccak256(abi.encode("ModuleKit.InstalledModuleHead.", keccak256(abi.encodePacked(account))));
    assembly {
        let length := sload(lengthSlot)
        let structSize := 0x40
        let size := mul(length, structSize)
        let totalSize := add(add(size, 0x40), mul(0x20, length))
        let freeMemoryPtr := mload(0x40)
        modules := freeMemoryPtr
        mstore(modules, length)
        mstore(0x40, add(freeMemoryPtr, totalSize))
        let storageLocation := sload(headSlot)
        for {
            let i := 0
        } lt(i, length) {
            i := add(i, 1)
        } {
            let structLocation := add(add(freeMemoryPtr, add(0x40, mul(i, structSize))), mul(0x20, length))
            let moduleType := sload(storageLocation)
            let moduleAddress := sload(add(storageLocation, 0x20))
            mstore(add(freeMemoryPtr, add(0x20, mul(i, 0x20))), structLocation)
            mstore(structLocation, moduleType)
            mstore(add(structLocation, 0x20), moduleAddress)
            storageLocation := sload(add(storageLocation, 0x60))
        }
    }
}
```

### removeInstalledModule(uint256,address)

- **Kind**: free-function
- **Source**: 8701:1838:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:removeInstalledModule(uint256,address)`

```solidity
function removeInstalledModule(uint256 index, address account) {
    bytes32 lengthSlot = keccak256(abi.encode("ModuleKit.InstalledModuleSlot.", keccak256(abi.encodePacked(account))));
    bytes32 headSlot = keccak256(abi.encode("ModuleKit.InstalledModuleHead.", keccak256(abi.encodePacked(account))));
    bytes32 tailSlot = keccak256(abi.encode("ModuleKit.InstalledModuleTail.", keccak256(abi.encodePacked(account))));
    assembly {
        let length := sload(lengthSlot)
        let elementSlot := sload(headSlot)
        if lt(index, length) {
            for {
                let i := 0
            } lt(i, index) {
                i := add(i, 1)
            } {
                elementSlot := sload(add(elementSlot, 0x60))
            }
            let prevSlot := sload(add(elementSlot, 0x40))
            let nextSlot := sload(add(elementSlot, 0x60))
            sstore(add(prevSlot, 0x60), nextSlot)
            sstore(add(nextSlot, 0x40), prevSlot)
            if eq(elementSlot, sload(headSlot)) {
                sstore(headSlot, nextSlot)
            }
            if eq(elementSlot, sload(tailSlot)) {
                sstore(tailSlot, prevSlot)
            }
            sstore(elementSlot, 0)
            sstore(add(elementSlot, 0x20), 0)
            sstore(add(elementSlot, 0x40), 0)
            sstore(add(elementSlot, 0x60), 0)
            sstore(lengthSlot, sub(length, 1))
        }
    }
}
```

### getGasIdentifier()

- **Kind**: free-function
- **Source**: 1476:151:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:getGasIdentifier()`

```solidity
function getGasIdentifier() view returns (string memory id) {
    bytes32 slot = keccak256("ModuleKit.GasIdentifierSlot");
    id = readString(slot);
}
```

### readString(bytes32)

- **Kind**: free-function
- **Source**: 13545:742:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:readString(bytes32)`

```solidity
function readString(bytes32 slot) view returns (string memory) {
    uint256 length;
    assembly {
        length := sload(slot)
    }
    bytes memory strBytes = new bytes(length);
    for (uint256 i = 0; i < length; i += 32) {
        bytes32 charSlot = keccak256(abi.encodePacked(slot, i / 32));
        bytes32 data;
        assembly {
            data := sload(charSlot)
        }
        for (uint256 j = 0; (j < 32) && ((i + j) < length); j++) {
            strBytes[i + j] = bytes1(uint8(uint256(data >> (248 - (j * 8)))));
        }
    }
    return string(strBytes);
}
```

### calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256)

- **Kind**: internal
- **Source**: 8789:510:241
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/ERC4337Helpers.sol:ERC4337Helpers:calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256)`

```solidity
function calculateGas(PackedUserOperation[] memory userOps, IEntryPoint onEntryPoint, address beneficiary, string memory gasIdentifier, uint256 totalUserOpGas) internal {
    bytes memory userOpCalldata = abi.encodeWithSelector(onEntryPoint.handleOps.selector, userOps, beneficiary);
    GasParser.parseAndWriteGas(userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas);
}
```

### parseAndWriteGas(bytes,address,string,address,uint256)

- **Kind**: internal
- **Source**: 243:1164:246
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasParser.sol:GasParser:parseAndWriteGas(bytes,address,string,address,uint256)`

```solidity
function parseAndWriteGas(bytes memory userOpCalldata, address entrypoint, string memory gasIdentifier, address sender, uint256 totalUserOpGas) internal {
    string memory fileName = string.concat("./gas_calculations/", gasIdentifier, ".json");
    GasCalculations memory gasCalculations = GasCalculations({creation: GasDebug(entrypoint).getGasConsumed(sender, 0), validation: GasDebug(entrypoint).getGasConsumed(sender, 1), execution: GasDebug(entrypoint).getGasConsumed(sender, 2), total: totalUserOpGas, arbitrum: getArbitrumL1Gas(userOpCalldata), opStack: getOpStackL1Gas(userOpCalldata)});
    GasCalculations memory prevGasCalculations;
    if (exists(fileName)) {
        string memory fileContent = readFile(fileName);
        prevGasCalculations = parsePrevGasReport(fileContent);
    }
    string memory finalJson = formatGasToWrite(gasIdentifier, prevGasCalculations, gasCalculations);
    writeJson(finalJson, fileName);
    writeGasIdentifier("");
}
```

### getArbitrumL1Gas(bytes)

- **Kind**: free-function
- **Source**: 1197:185:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getArbitrumL1Gas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata on Arbitrum L1.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata on Arbitrum L1.
function getArbitrumL1Gas(bytes memory data) pure returns (uint256 calldataGas) {
    bytes memory compressed = LibZip.flzCompress(data);
    calldataGas = getCallDataGas(compressed);
}
```

### flzCompress(bytes)

- **Kind**: internal
- **Source**: 1102:3958:322
- **Link**: `lib/v2-core/lib/solady/src/utils/LibZip.sol:LibZip:flzCompress(bytes)`

```solidity
/// @dev Returns the compressed `data`.
function flzCompress(bytes memory data) internal pure returns (bytes memory result) {
    /// @solidity memory-safe-assembly
    assembly {
        function ms8 (d_, v_) -> _d {
            mstore8(d_, v_)
            _d := add(d_, 1)
        }
        function u24 (p_) -> _u {
            _u := mload(p_)
            _u := or(shl(16, byte(2, _u)), or(shl(8, byte(1, _u)), byte(0, _u)))
        }
        function cmp (p_, q_, e_) -> _l {
            for {
                e_ := sub(e_, q_)
            } lt(_l, e_) {
                _l := add(_l, 1)
            } {
                e_ := mul(iszero(byte(0, xor(mload(add(p_, _l)), mload(add(q_, _l))))), e_)
            }
        }
        function literals (runs_, src_, dest_) -> _o {
            for {
                _o := dest_
            } iszero(lt(runs_, 0x20)) {
                runs_ := sub(runs_, 0x20)
            } {
                mstore(ms8(_o, 31), mload(src_))
                _o := add(_o, 0x21)
                src_ := add(src_, 0x20)
            }
            if iszero(runs_) {
                leave
            }
            mstore(ms8(_o, sub(runs_, 1)), mload(src_))
            _o := add(1, add(_o, runs_))
        }
        function mt (l_, d_, o_) -> _o {
            for {
                d_ := sub(d_, 1)
            } iszero(lt(l_, 263)) {
                l_ := sub(l_, 262)
            } {
                o_ := ms8(ms8(ms8(o_, add(224, shr(8, d_))), 253), and(0xff, d_))
            }
            if iszero(lt(l_, 7)) {
                _o := ms8(ms8(ms8(o_, add(224, shr(8, d_))), sub(l_, 7)), and(0xff, d_))
                leave
            }
            _o := ms8(ms8(o_, add(shl(5, l_), shr(8, d_))), and(0xff, d_))
        }
        function setHash (i_, v_) {
            let p_ := add(mload(0x40), shl(2, i_))
            mstore(p_, xor(mload(p_), shl(224, xor(shr(224, mload(p_)), v_))))
        }
        function getHash (i_) -> _h {
            _h := shr(224, mload(add(mload(0x40), shl(2, i_))))
        }
        function hash (v_) -> _r {
            _r := and(shr(19, mul(2654435769, v_)), 0x1fff)
        }
        function setNextHash (ip_, ipStart_) -> _ip {
            setHash(hash(u24(ip_)), sub(ip_, ipStart_))
            _ip := add(ip_, 1)
        }
        result := mload(0x40)
        calldatacopy(result, calldatasize(), 0x8000)
        let op := add(result, 0x8000)
        let a := add(data, 0x20)
        let ipStart := a
        let ipLimit := sub(add(ipStart, mload(data)), 13)
        for {
            let ip := add(2, a)
        } lt(ip, ipLimit) {} {
            let r := 0
            let d := 0
            for {} 1 {} {
                let s := u24(ip)
                let h := hash(s)
                r := add(ipStart, getHash(h))
                setHash(h, sub(ip, ipStart))
                d := sub(ip, r)
                if iszero(lt(ip, ipLimit)) {
                    break
                }
                ip := add(ip, 1)
                if iszero(gt(d, 0x1fff)) {
                    if eq(s, u24(r)) {
                        break
                    }
                }
            }
            if iszero(lt(ip, ipLimit)) {
                break
            }
            ip := sub(ip, 1)
            if gt(ip, a) {
                op := literals(sub(ip, a), a, op)
            }
            let l := cmp(add(r, 3), add(ip, 3), add(ipLimit, 9))
            op := mt(l, d, op)
            ip := setNextHash(setNextHash(add(ip, l), ipStart), ipStart)
            a := ip
        }
        let end := sub(literals(sub(add(ipStart, mload(data)), a), a, op), 0x7fe0)
        let o := add(result, 0x20)
        mstore(result, sub(end, o))
        for {} iszero(gt(o, end)) {
            o := add(o, 0x20)
        } {
            mstore(o, mload(add(o, 0x7fe0)))
        }
        mstore(end, 0)
        mstore(0x40, add(end, 0x20))
    }
}
```

### getCallDataGas(bytes)

- **Kind**: free-function
- **Source**: 768:254:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getCallDataGas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata.
function getCallDataGas(bytes memory data) pure returns (uint256 calldataGas) {
    for (uint256 i = 0; i < data.length; i++) {
        if (data[i] == 0x00) {
            calldataGas += 4;
        } else {
            calldataGas += 16;
        }
    }
}
```

### getOpStackL1Gas(bytes)

- **Kind**: free-function
- **Source**: 1555:300:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:getOpStackL1Gas(bytes)`

```solidity
/// @notice Calculate the gas cost of calldata on OpStack L1.
///  @param data The calldata to be sent.
///  @return calldataGas The gas cost of the calldata on OpStack L1.
function getOpStackL1Gas(bytes memory data) pure returns (uint256 calldataGas) {
    uint256 opStackConstant = 2028;
    UD60x18 opStackScalar = ud(0.684e18);
    calldataGas = intoUint256(PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)) + opStackConstant;
}
```

### ud(uint256)

- **Kind**: free-function
- **Source**: 3445:86:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:ud(uint256)`

```solidity
/// @notice Alias for {wrap}.
function ud(uint256 x) pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### intoUint256(UD60x18)

- **Kind**: free-function
- **Source**: 2647:97:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:intoUint256(UD60x18)`

```solidity
/// @notice Casts a UD60x18 number into uint128.
///  @dev This is basically an alias for {unwrap}.
function intoUint256(UD60x18 x) pure returns (uint256 result) {
    result = UD60x18.unwrap(x);
}
```

### intoUD60x18(uint256)

- **Kind**: internal
- **Source**: 3135:112:109
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/casting/Uint256.sol:PRBMathCastingUint256:intoUD60x18(uint256)`

```solidity
/// @notice Casts a uint256 number to UD60x18.
function intoUD60x18(uint256 x) internal pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### mul(UD60x18,UD60x18)

- **Kind**: free-function
- **Source**: 18914:128:137
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Math.sol:mul(UD60x18,UD60x18)`

```solidity
/// @notice Multiplies two UD60x18 numbers together, returning a new UD60x18 number.
///  @dev Uses {Common.mulDiv} to enable overflow-safe multiplication and division.
///  Notes:
///  - Refer to the notes in {Common.mulDiv}.
///  Requirements:
///  - Refer to the requirements in {Common.mulDiv}.
///  @dev See the documentation in {Common.mulDiv18}.
///  @param x The multiplicand as a UD60x18 number.
///  @param y The multiplier as a UD60x18 number.
///  @return result The product as a UD60x18 number.
///  @custom:smtchecker abstract-function-nondet
function mul(UD60x18 x, UD60x18 y) pure returns (UD60x18 result) {
    result = wrap(Common.mulDiv18(x.unwrap(), y.unwrap()));
}
```

### wrap(uint256)

- **Kind**: free-function
- **Source**: 3865:88:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:wrap(uint256)`

```solidity
/// @notice Wraps a uint256 number into the UD60x18 value type.
function wrap(uint256 x) pure returns (UD60x18 result) {
    result = UD60x18.wrap(x);
}
```

### mulDiv18(uint256,uint256)

- **Kind**: free-function
- **Source**: 19680:819:107
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/Common.sol:mulDiv18(uint256,uint256)`

```solidity
/// @notice Calculates x*y÷1e18 with 512-bit precision.
///  @dev A variant of {mulDiv} with constant folding, i.e. in which the denominator is hard coded to 1e18.
///  Notes:
///  - The body is purposely left uncommented; to understand how this works, see the documentation in {mulDiv}.
///  - The result is rounded toward zero.
///  - We take as an axiom that the result cannot be `MAX_UINT256` when x and y solve the following system of equations:
///  $$
///  \begin{cases}
///      x * y = MAX\_UINT256 * UNIT \\
///      (x * y) \% UNIT \geq \frac{UNIT}{2}
///  \end{cases}
///  $$
///  Requirements:
///  - Refer to the requirements in {mulDiv}.
///  - The result must fit in uint256.
///  @param x The multiplicand as an unsigned 60.18-decimal fixed-point number.
///  @param y The multiplier as an unsigned 60.18-decimal fixed-point number.
///  @return result The result as an unsigned 60.18-decimal fixed-point number.
///  @custom:smtchecker abstract-function-nondet
function mulDiv18(uint256 x, uint256 y) pure returns (uint256 result) {
    uint256 prod0;
    uint256 prod1;
    assembly ("memory-safe") {
        let mm := mulmod(x, y, not(0))
        prod0 := mul(x, y)
        prod1 := sub(sub(mm, prod0), lt(mm, prod0))
    }
    if (prod1 == 0) {
        unchecked {
            return prod0 / UNIT;
        }
    }
    if (prod1 >= UNIT) {
        revert PRBMath_MulDiv18_Overflow(x, y);
    }
    uint256 remainder;
    assembly ("memory-safe") {
        remainder := mulmod(x, y, UNIT)
        result := mul(or(div(sub(prod0, remainder), UNIT_LPOTD), mul(sub(prod1, gt(remainder, prod0)), add(div(sub(0, UNIT_LPOTD), UNIT_LPOTD), 1))), UNIT_INVERSE)
    }
}
```

### unwrap(UD60x18)

- **Kind**: free-function
- **Source**: 3707:92:132
- **Link**: `lib/v2-core/lib/modulekit/node_modules/@prb/math/src/ud60x18/Casting.sol:unwrap(UD60x18)`

```solidity
/// @notice Unwraps a UD60x18 number into uint256.
function unwrap(UD60x18 x) pure returns (uint256 result) {
    result = UD60x18.unwrap(x);
}
```

### exists(string)

- **Kind**: free-function
- **Source**: 3719:96:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:exists(string)`

```solidity
function exists(string memory path) view returns (bool) {
    return Vm(VM_ADDR).exists(path);
}
```

### readFile(string)

- **Kind**: free-function
- **Source**: 3608:109:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:readFile(string)`

```solidity
function readFile(string memory path) view returns (string memory) {
    return Vm(VM_ADDR).readFile(path);
}
```

### parsePrevGasReport(string)

- **Kind**: free-function
- **Source**: 2023:722:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:parsePrevGasReport(string)`

```solidity
/// @notice Parse the previous gas report from a file.
///  @param fileContent The content of the file.
///  @return prevGasCalculations The previous gas calculations.
function parsePrevGasReport(string memory fileContent) pure returns (GasCalculations memory prevGasCalculations) {
    prevGasCalculations.total = parseUintFromASCII(parseJson(fileContent, ".Total"));
    prevGasCalculations.creation = parseUintFromASCII(parseJson(fileContent, ".Phases.Creation"));
    prevGasCalculations.validation = parseUintFromASCII(parseJson(fileContent, ".Phases.Validation"));
    prevGasCalculations.execution = parseUintFromASCII(parseJson(fileContent, ".Phases.Execution"));
    prevGasCalculations.arbitrum = parseUintFromASCII(parseJson(fileContent, ".Calldata.Arbitrum"));
    prevGasCalculations.opStack = parseUintFromASCII(parseJson(fileContent, ".Calldata.OP-Stack"));
}
```

### parseUintFromASCII(bytes)

- **Kind**: free-function
- **Source**: 2865:632:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:parseUintFromASCII(bytes)`

```solidity
/// @notice Parse a uint256 from ASCII.
///  @param ascii The ASCII to be parsed.
///  @return _ret The parsed uint256.
function parseUintFromASCII(bytes memory ascii) pure returns (uint256 _ret) {
    bytes memory prevTotal;
    uint256 offset = (ascii.length > 32) ? 32 : 0;
    for (uint256 i; i < ascii.length; i++) {
        if (ascii[i] == 0x28) {
            break;
        } else {
            if (i >= offset) {
                prevTotal = abi.encodePacked(prevTotal, ascii[i]);
            }
        }
    }
    uint256 j = 1;
    for (uint256 i = prevTotal.length - 1; i > 0; i--) {
        if ((uint8(prevTotal[i]) >= 48) && (uint8(prevTotal[i]) <= 57)) {
            _ret += (uint8(prevTotal[i]) - 48) * j;
            j *= 10;
        }
    }
}
```

### parseJson(string,string)

- **Kind**: free-function
- **Source**: 4352:134:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:parseJson(string,string)`

```solidity
function parseJson(string memory json, string memory key) pure returns (bytes memory) {
    return Vm(VM_ADDR).parseJson(json, key);
}
```

### formatGasToWrite(string,struct GasCalculations,struct GasCalculations)

- **Kind**: internal
- **Source**: 1413:2033:246
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasParser.sol:GasParser:formatGasToWrite(string,struct GasCalculations,struct GasCalculations)`

```solidity
function formatGasToWrite(string memory gasIdentifier, GasCalculations memory prevGasCalculations, GasCalculations memory gasCalculations) internal returns (string memory finalJson) {
    string memory jsonObj = string(abi.encodePacked(gasIdentifier));
    serializeString(jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total}));
    string memory phasesObj = "phases";
    serializeString(phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation}));
    serializeString(phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation}));
    string memory phasesOutput = serializeString(phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution}));
    string memory l2sObj = "l2s";
    serializeString(l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack}));
    string memory l2sOutput = serializeString(l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum}));
    serializeString(jsonObj, "Phases", phasesOutput);
    finalJson = serializeString(jsonObj, "Calldata", l2sOutput);
}
```

### serializeString(string,string,string)

- **Kind**: free-function
- **Source**: 3290:213:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:serializeString(string,string,string)`

```solidity
function serializeString(string memory objectKey, string memory valueKey, string memory value) returns (string memory json) {
    return Vm(VM_ADDR).serializeString(objectKey, valueKey, value);
}
```

### formatGasValue(uint256,uint256)

- **Kind**: free-function
- **Source**: 3669:445:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:formatGasValue(uint256,uint256)`

```solidity
/// @notice Format the gas value.
///  @param prevValue The previous gas value.
///  @param newValue The new gas value.
///  @return formattedValue The formatted gas value.
function formatGasValue(uint256 prevValue, uint256 newValue) pure returns (string memory formattedValue) {
    if (prevValue == 0) {
        formattedValue = string.concat(formatGas(int256(newValue)), " gas");
    } else {
        formattedValue = string.concat(formatGas(int256(newValue)), " gas (diff: ", formatGas(int256(newValue) - int256(prevValue)), ")");
    }
}
```

### formatGas(int256)

- **Kind**: free-function
- **Source**: 4268:455:245
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/gas/GasCalculations.sol:formatGas(int256)`

```solidity
/// @notice Format the gas value with underscores for readability.
///  @param value The gas value to be formatted.
///  @return The formatted gas value.
function formatGas(int256 value) pure returns (string memory) {
    string memory str = toString(value);
    bytes memory bStr = bytes(str);
    bytes memory result = new bytes(bStr.length + ((bStr.length - 1) / 3));
    uint256 j = result.length;
    for (uint256 i = 0; i < bStr.length; i++) {
        if ((i > 0) && ((i % 3) == 0)) {
            result[--j] = "_";
        }
        result[--j] = bStr[(bStr.length - i) - 1];
    }
    return string(result);
}
```

### toString(int256)

- **Kind**: free-function
- **Source**: 3924:104:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:toString(int256)`

```solidity
function toString(int256 input) pure returns (string memory) {
    return Vm(VM_ADDR).toString(input);
}
```

### writeJson(string,string)

- **Kind**: free-function
- **Source**: 3505:101:244
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Vm.sol:writeJson(string,string)`

```solidity
function writeJson(string memory json, string memory path) {
    Vm(VM_ADDR).writeJson(json, path);
}
```

### writeGasIdentifier(string)

- **Kind**: free-function
- **Source**: 1337:137:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeGasIdentifier(string)`

```solidity
function writeGasIdentifier(string memory id) {
    bytes32 slot = keccak256("ModuleKit.GasIdentifierSlot");
    writeString(slot, id);
}
```

### writeString(bytes32,string)

- **Kind**: free-function
- **Source**: 12883:660:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeString(bytes32,string)`

```solidity
function writeString(bytes32 slot, string memory value) {
    bytes memory strBytes = bytes(value);
    uint256 length = strBytes.length;
    assembly {
        sstore(slot, length)
    }
    for (uint256 i = 0; i < length; i += 32) {
        bytes32 data;
        for (uint256 j = 0; (j < 32) && ((i + j) < length); j++) {
            data |= bytes32(uint256(uint8(strBytes[i + j])) << (248 - (j * 8)));
        }
        bytes32 charSlot = keccak256(abi.encodePacked(slot, i / 32));
        assembly {
            sstore(charSlot, data)
        }
    }
}
```

### _depositFreeAssetsFromSingleAmount5115(uint256,address,address)

- **Kind**: internal
- **Source**: 36874:1941:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_depositFreeAssetsFromSingleAmount5115(uint256,address,address)`

```solidity
function _depositFreeAssetsFromSingleAmount5115(uint256 depositAmount, address strategyAddress, address underlyingVault) internal {
    address depositHookAddress = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY);
    address[] memory fulfillHooksAddresses = new address[](1);
    fulfillHooksAddresses[0] = depositHookAddress;
    bytes[] memory fulfillHooksData = new bytes[](1);
    fulfillHooksData[0] = _createApproveAndDeposit5115HookData(_getYieldSourceOracleId(bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER), underlyingVault, address(asset5115), depositAmount, 0, false);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
    expectedAssetsOrSharesOut[0] = IStandardizedYield(address(underlyingVault)).previewDeposit(address(asset5115), depositAmount);
    bytes[] memory argsForProofs = new bytes[](1);
    argsForProofs[0] = ISuperHookInspector(fulfillHooksAddresses[0]).inspect(fulfillHooksData[0]);
    vm.startPrank(MANAGER);
    SuperVaultStrategy(payable(strategyAddress)).executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: fulfillHooksAddresses, hookCalldata: fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _getMerkleProofsForHooks(fulfillHooksAddresses, argsForProofs), strategyProofs: new bytes32[][](1)}));
    vm.stopPrank();
    uint256 pricePerShare = _getSuperVaultPricePerShare();
    uint256 shares = depositAmount.mulDiv(strategy.PRECISION(), pricePerShare);
    _trackDeposit(accountEth, shares, depositAmount);
}
```

### _createApproveAndDeposit5115HookData(bytes32,address,address,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 94:419:669
- **Link**: `test/utils/hooks/HooksHelpers.sol:HooksHelpers:_createApproveAndDeposit5115HookData(bytes32,address,address,uint256,uint256,bool)`

```solidity
function _createApproveAndDeposit5115HookData(bytes32 yieldSourceOracleId, address vault, address tokenIn, uint256 amount, uint256 minSharesOut, bool usePrevHookAmount) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, tokenIn, amount, minSharesOut, usePrevHookAmount);
}
```

### _getMerkleProofsForHooks(address[],bytes[])

- **Kind**: internal
- **Source**: 6398:1705:672
- **Link**: `test/utils/merkle/helper/MerkleReader.sol:MerkleReader:_getMerkleProofsForHooks(address[],bytes[])`

```solidity
///  @notice Get Merkle proofs for multiple hooks with specific arguments (OPTIMIZED)
///  @dev Uses efficient JS-based lookup to avoid gas-expensive Solidity operations
///  @param hookAddresses Array of hook contract addresses
///  @param encodedHookArgs Array of packed-encoded hook arguments corresponding to each hook
///  @return proofs Array of Merkle proofs for each hook/args combination
function _getMerkleProofsForHooks(address[] memory hookAddresses, bytes[] memory encodedHookArgs) internal returns (bytes32[][] memory proofs) {
    if (hookAddresses.length != encodedHookArgs.length) revert InvalidArrayLengths();
    if (hookAddresses.length == 0) revert EmptyInput();
    string memory addressesArg = "";
    string memory argsArg = "";
    for (uint256 i = 0; i < hookAddresses.length; i++) {
        if (i > 0) {
            addressesArg = string.concat(addressesArg, ",");
            argsArg = string.concat(argsArg, ",");
        }
        addressesArg = string.concat(addressesArg, vm.toString(hookAddresses[i]));
        argsArg = string.concat(argsArg, vm.toString(encodedHookArgs[i]));
    }
    string[] memory cmd = new string[](6);
    cmd[0] = "node";
    cmd[1] = string.concat(vm.projectRoot(), "/test/utils/merkle/merkle-js/efficient-proof-lookup.js");
    cmd[2] = "batch";
    cmd[3] = addressesArg;
    cmd[4] = argsArg;
    cmd[5] = vm.toString(currentChainId);
    bytes memory result = vm.ffi(cmd);
    string memory resultStr = string(result);
    proofs = abi.decode(vm.parseJson(resultStr), (bytes32[][]));
    return proofs;
}
```

### _getSuperVaultPricePerShare()

- **Kind**: internal
- **Source**: 112127:597:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_getSuperVaultPricePerShare()`

```solidity
function _getSuperVaultPricePerShare() internal view returns (uint256 pricePerShare) {
    uint256 totalSupplyAmount = vault.totalSupply();
    if (totalSupplyAmount == 0) {
        pricePerShare = vault.PRECISION();
    } else {
        (uint256 totalAssetsVault, ) = totalAssetHelper.totalAssets(address(strategy));
        pricePerShare = totalAssetsVault.mulDiv(vault.PRECISION(), totalSupplyAmount, Math.Rounding.Floor);
    }
}
```

### _trackDeposit(address,uint256,uint256)

- **Kind**: internal
- **Source**: 110828:238:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_trackDeposit(address,uint256,uint256)`

```solidity
function _trackDeposit(address user, uint256 shares, uint256 assets) internal {
    SuperVaultState storage state = superVaultStates[user];
    state.accumulatorShares += shares;
    state.accumulatorCostBasis += assets;
}
```

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2823:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### _requestRedeem(uint256,address)

- **Kind**: internal
- **Source**: 34556:155:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_requestRedeem(uint256,address)`

```solidity
function _requestRedeem(uint256 redeemShares, address superVault) internal {
    __requestRedeem(instanceOnEth, redeemShares, false, superVault);
}
```

### __requestRedeem(struct AccountInstance,uint256,bool,address)

- **Kind**: internal
- **Source**: 30258:1041:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:__requestRedeem(struct AccountInstance,uint256,bool,address)`

```solidity
function __requestRedeem(AccountInstance memory accInst, uint256 redeemShares, bool shouldRevert, address superVault) internal {
    address[] memory redeemHooksAddresses = new address[](1);
    redeemHooksAddresses[0] = _getHookAddress(ETH, REQUEST_REDEEM_7540_VAULT_HOOK_KEY);
    bytes[] memory redeemHooksData = new bytes[](1);
    redeemHooksData[0] = _createRequestRedeem7540VaultHookData(_getYieldSourceOracleId(bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER), superVault, redeemShares, false);
    ISuperExecutor.ExecutorEntry memory redeemEntry = ISuperExecutor.ExecutorEntry({hooksAddresses: redeemHooksAddresses, hooksData: redeemHooksData});
    UserOpData memory redeemUserOpData = _getExecOps(accInst, superExecutorOnEth, abi.encode(redeemEntry));
    if (shouldRevert) {
        accInst.expect4337Revert();
    }
    executeOp(redeemUserOpData);
}
```

### _createRequestRedeem7540VaultHookData(bytes32,address,uint256,bool)

- **Kind**: internal
- **Source**: 14859:341:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createRequestRedeem7540VaultHookData(bytes32,address,uint256,bool)`

```solidity
function _createRequestRedeem7540VaultHookData(bytes32 yieldSourceOracleId, address yieldSource, uint256 amount, bool usePrevHookAmount) internal pure returns (bytes memory) {
    return abi.encodePacked(yieldSourceOracleId, yieldSource, amount, usePrevHookAmount);
}
```

### expect4337Revert(struct AccountInstance)

- **Kind**: internal
- **Source**: 21316:97:232
- **Link**: `lib/v2-core/lib/modulekit/src/test/ModuleKitHelpers.sol:ModuleKitHelpers:expect4337Revert(struct AccountInstance)`

```solidity
/// @notice Sets the expect revert flag to true
function expect4337Revert(AccountInstance memory) internal {
    writeExpectRevert("");
}
```

### writeExpectRevert(bytes)

- **Kind**: free-function
- **Source**: 235:351:243
- **Link**: `lib/v2-core/lib/modulekit/src/test/utils/Storage.sol:writeExpectRevert(bytes)`

```solidity
function writeExpectRevert(bytes memory message) {
    uint256 value = 1;
    bytes32 slot = keccak256("ModuleKit.ExpectMessageSlot");
    if (message.length > 0) {
        value = 2;
        assembly {
            sstore(slot, message)
        }
    }
    slot = keccak256("ModuleKit.ExpectSlot");
    assembly {
        sstore(slot, value)
    }
}
```

### _fulfillRedeem5115(uint256,address,address)

- **Kind**: internal
- **Source**: 53579:2308:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_fulfillRedeem5115(uint256,address,address)`

```solidity
function _fulfillRedeem5115(uint256 redeemShares, address, address strat) internal {
    address[] memory requestingUsers = new address[](1);
    requestingUsers[0] = accountEth;
    vm.prank(accountEth);
    SuperVaultStrategy(payable(strat)).setRedeemSlippage(2000);
    address[] memory hooksAddresses = new address[](1);
    hooksAddresses[0] = _getHookAddress(ETH, REDEEM_5115_VAULT_HOOK_KEY);
    uint256 vaultShare = pendleEthena.previewRedeem(CHAIN_1_SUSDE, redeemShares);
    bytes[] memory hooksData = new bytes[](1);
    hooksData[0] = _create5115RedeemHookData(_getYieldSourceOracleId(bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER), pendleEthenaAddress, CHAIN_1_SUSDE, vaultShare, 0, false);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](1);
    expectedAssetsOrSharesOut[0] = pendleEthena.previewRedeem(CHAIN_1_SUSDE, vaultShare);
    bytes[] memory argsForProofs = new bytes[](1);
    argsForProofs[0] = ISuperHookInspector(hooksAddresses[0]).inspect(hooksData[0]);
    vm.startPrank(MANAGER);
    SuperVaultStrategy(payable(strat)).executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: hooksAddresses, hookCalldata: hooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _getMerkleProofsForHooks(hooksAddresses, argsForProofs), strategyProofs: new bytes32[][](1)}));
    requestingUsers = _sortAndUniqueControllers(requestingUsers);
    uint256[] memory totalAssetsOut = calculateAdjustedFulfillment(ISuperVaultStrategy(strat), requestingUsers, expectedAssetsOrSharesOut);
    SuperVaultStrategy(payable(strat)).fulfillRedeemRequests(requestingUsers, totalAssetsOut);
    vm.stopPrank();
}
```

### _create5115RedeemHookData(bytes32,address,address,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 13671:415:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_create5115RedeemHookData(bytes32,address,address,uint256,uint256,bool)`

```solidity
function _create5115RedeemHookData(bytes32 yieldSourceOracleId, address vault, address tokenOut, uint256 shares, uint256 minTokenOut, bool usePrevHookAmount) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, tokenOut, shares, minTokenOut, false, usePrevHookAmount);
}
```

### _sortAndUniqueControllers(address[])

- **Kind**: internal
- **Source**: 139422:377:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_sortAndUniqueControllers(address[])`

```solidity
/// @notice Helper function to sort controllers and ensure uniqueness for fulfillRedeemRequests
///  @param controllers Array of controller addresses to sort and deduplicate
///  @return sortedControllers Sorted and deduplicated array
function _sortAndUniqueControllers(address[] memory controllers) internal pure returns (address[] memory sortedControllers) {
    if (controllers.length == 0) return controllers;
    controllers.insertionSort();
    controllers.uniquifySorted();
    return controllers;
}
```

### insertionSort(address[])

- **Kind**: internal
- **Source**: 2133:100:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:insertionSort(address[])`

```solidity
/// @dev Sorts the array in-place with insertion sort.
function insertionSort(address[] memory a) internal pure {
    insertionSort(_toUints(a));
}
```

### insertionSort(uint256[])

- **Kind**: internal
- **Source**: 840:1020:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:insertionSort(uint256[])`

```solidity
/// @dev Sorts the array in-place with insertion sort.
function insertionSort(uint256[] memory a) internal pure {
    /// @solidity memory-safe-assembly
    assembly {
        let n := mload(a)
        mstore(a, 0)
        let h := add(a, shl(5, n))
        let w := not(0x1f)
        for {
            let i := add(a, 0x20)
        } 1 {} {
            i := add(i, 0x20)
            if gt(i, h) {
                break
            }
            let k := mload(i)
            let j := add(i, w)
            let v := mload(j)
            if iszero(gt(v, k)) {
                continue
            }
            for {} 1 {} {
                mstore(add(j, 0x20), v)
                j := add(j, w)
                v := mload(j)
                if iszero(gt(v, k)) {
                    break
                }
            }
            mstore(add(j, 0x20), k)
        }
        mstore(a, n)
    }
}
```

### _toUints(address[])

- **Kind**: internal
- **Source**: 28279:415:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:_toUints(address[])`

```solidity
/// @dev Reinterpret cast to an uint256 array.
function _toUints(address[] memory a) private pure returns (uint256[] memory casted) {
    /// @solidity memory-safe-assembly
    assembly {
        casted := a
    }
}
```

### uniquifySorted(address[])

- **Kind**: internal
- **Source**: 9420:102:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:uniquifySorted(address[])`

```solidity
/// @dev Removes duplicate elements from a ascendingly sorted memory array.
function uniquifySorted(address[] memory a) internal pure {
    uniquifySorted(_toUints(a));
}
```

### uniquifySorted(uint256[])

- **Kind**: internal
- **Source**: 8425:722:321
- **Link**: `lib/v2-core/lib/solady/src/utils/LibSort.sol:LibSort:uniquifySorted(uint256[])`

```solidity
/// @dev Removes duplicate elements from a ascendingly sorted memory array.
function uniquifySorted(uint256[] memory a) internal pure {
    /// @solidity memory-safe-assembly
    assembly {
        if iszero(lt(mload(a), 2)) {
            let x := add(a, 0x20)
            let y := add(a, 0x40)
            let end := add(a, shl(5, add(mload(a), 1)))
            for {} 1 {} {
                if iszero(eq(mload(x), mload(y))) {
                    x := add(x, 0x20)
                    mstore(x, mload(y))
                }
                y := add(y, 0x20)
                if eq(y, end) {
                    break
                }
            }
            mstore(a, shr(5, sub(x, a)))
        }
    }
}
```

### calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[])

- **Kind**: internal
- **Source**: 6811:1305:575
- **Link**: `test/integration/SuperVault/AssetAdjustmentHelper.t.sol:AssetAdjustmentHelper:calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[])`

```solidity
///  @notice Complete workflow to calculate adjusted totalAssetsOut for fulfillRedeemRequests
///  @dev This function combines theoretical preview calculations with actual executeHooks
///       output to produce adjusted fulfillment amounts. This is the main function to use
///       when you need to fulfill redemption requests while accounting for execution losses.
///       Workflow:
///       1. Get theoretical net assets for all controllers via batch preview
///       2. Calculate total available assets from executeHooks output
///       3. Adjust theoretical amounts pro-rata to match available assets
///       4. Return adjusted array ready for fulfillRedeemRequests as totalAssetsOut
///       NOTE: The returned amounts represent totalAssetsOut (pre-fee) for fulfillRedeemRequests.
///       Fees are calculated and deducted internally based on full theoretical amounts,
///       ensuring fees are never reduced due to execution losses.
///  @param strategy The SuperVault strategy contract
///  @param controllers Sorted/unique controller addresses with pending redemptions
///  @param expectedAssetsFromHooks Array of assets expected from executeHooks (from expectedAssetsOrSharesOut)
///  @return fulfillRedeemTotalAssetsOut Final totalAssetsOut array for fulfillRedeemRequests call (pre-fee amounts)
function calculateAdjustedFulfillment(ISuperVaultStrategy strategy, address[] memory controllers, uint256[] memory expectedAssetsFromHooks) internal view returns (uint256[] memory fulfillRedeemTotalAssetsOut) {
    if ((controllers.length == 0) || (expectedAssetsFromHooks.length == 0)) {
        revert EMPTY_ARRAYS();
    }
    (uint256 totalTheoreticalAssets, uint256[] memory theoreticalAssets) = strategy.previewExactRedeemBatch(controllers);
    uint256 totalAvailableAssets = 0;
    for (uint256 i = 0; i < expectedAssetsFromHooks.length; i++) {
        console2.log("Available from hooks [index %s]: %s", i, expectedAssetsFromHooks[i]);
        totalAvailableAssets += expectedAssetsFromHooks[i];
    }
    fulfillRedeemTotalAssetsOut = calculateFulfillRedeemTotalAssetsOut(controllers, theoreticalAssets, totalTheoreticalAssets, totalAvailableAssets);
    return fulfillRedeemTotalAssetsOut;
}
```

### log(string,uint256,uint256)

- **Kind**: internal
- **Source**: 11745:169:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256,uint256)`

```solidity
function log(string memory p0, uint256 p1, uint256 p2) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2));
}
```

### calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256)

- **Kind**: internal
- **Source**: 2792:2430:575
- **Link**: `test/integration/SuperVault/AssetAdjustmentHelper.t.sol:AssetAdjustmentHelper:calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256)`

```solidity
///  @notice Adjusts netAssetsOut arrays to match actual available assets from executeHooks
///  @dev This function handles the precision mismatch between theoretical fulfillment amounts
///       (calculated at current PPS) and actual assets obtained from executeHooks (which may
///       have rounding losses). The shortfall is distributed pro-rata based on each controller's
///       theoretical redemption amount.
///       Example scenario:
///       - Controller A: 800 theoretical assets (80% of total)
///       - Controller B: 200 theoretical assets (20% of total)
///       - Total theoretical: 1000 assets
///       - Available from hooks: 998 assets (2 wei loss)
///       - Adjusted A: 798.4 → 798 assets (1.6 wei loss)
///       - Adjusted B: 199.6 → 199 assets (0.4 wei loss)
///  @param controllers Array of controller addresses (must be sorted/unique)
///  @param theoreticalAssets Array of theoretical assets per controller from previewExactRedeem
///  @param totalTheoreticalAssets Total theoretical assets (sum of theoreticalAssets, from
///  previewExactRedeemBatch)
///  @param totalAvailableAssets Actual assets available from executeHooks (sum of expectedAssetsOrSharesOut)
///  @return fulfillRedeemTotalAssetsOut Array adjusted to match available liquidity, sum <= totalAvailableAssets
function calculateFulfillRedeemTotalAssetsOut(address[] memory controllers, uint256[] memory theoreticalAssets, uint256 totalTheoreticalAssets, uint256 totalAvailableAssets) internal pure returns (uint256[] memory fulfillRedeemTotalAssetsOut) {
    if ((controllers.length == 0) || (theoreticalAssets.length == 0)) {
        revert EMPTY_ARRAYS();
    }
    if (controllers.length != theoreticalAssets.length) {
        revert ARRAY_LENGTH_MISMATCH();
    }
    fulfillRedeemTotalAssetsOut = new uint256[](controllers.length);
    if (totalTheoreticalAssets == 0) {
        revert ZERO_TOTAL_THEORETICAL();
    }
    if (totalAvailableAssets >= totalTheoreticalAssets) {
        return theoreticalAssets;
    }
    if (totalAvailableAssets > totalTheoreticalAssets) {
        revert INSUFFICIENT_AVAILABLE_ASSETS();
    }
    console2.log("Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets);
    uint256 totalAdjusted = 0;
    for (uint256 i = 0; i < theoreticalAssets.length; i++) {
        fulfillRedeemTotalAssetsOut[i] = theoreticalAssets[i].mulDiv(totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor);
        totalAdjusted += fulfillRedeemTotalAssetsOut[i];
    }
    uint256 remainder = totalAvailableAssets - totalAdjusted;
    if (remainder > 0) {
        console2.log("Remainder kept in vault as free assets:", remainder);
    }
    return fulfillRedeemTotalAssetsOut;
}
```

### mulDiv(uint256,uint256,uint256,enum Math.Rounding)

- **Kind**: internal
- **Source**: 11054:238:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256,enum Math.Rounding)`

```solidity
///  @dev Calculates x * y / denominator with full precision, following the selected rounding direction.
function mulDiv(uint256 x, uint256 y, uint256 denominator, Rounding rounding) internal pure returns (uint256) {
    return mulDiv(x, y, denominator) + SafeCast.toUint(unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0));
}
```

### toUint(bool)

- **Kind**: internal
- **Source**: 34795:145:295
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint(bool)`

```solidity
///  @dev Cast a boolean (false or true) to a uint256 (0 or 1) with no jump.
function toUint(bool b) internal pure returns (uint256 u) {
    assembly ("memory-safe") {
        u := iszero(iszero(b))
    }
}
```

### unsignedRoundsUp(enum Math.Rounding)

- **Kind**: internal
- **Source**: 32020:122:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:unsignedRoundsUp(enum Math.Rounding)`

```solidity
///  @dev Returns whether a provided rounding mode is considered rounding up for unsigned integers.
function unsignedRoundsUp(Rounding rounding) internal pure returns (bool) {
    return (uint8(rounding) % 2) == 1;
}
```

### mulDiv(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 7242:3683:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mulDiv(uint256,uint256,uint256)`

```solidity
///  @dev Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or
///  denominator == 0.
///  Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv) with further edits by
///  Uniswap Labs also under MIT license.
function mulDiv(uint256 x, uint256 y, uint256 denominator) internal pure returns (uint256 result) {
    unchecked {
        (uint256 high, uint256 low) = mul512(x, y);
        if (high == 0) {
            return low / denominator;
        }
        if (denominator <= high) {
            Panic.panic(ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW));
        }
        uint256 remainder;
        assembly ("memory-safe") {
            remainder := mulmod(x, y, denominator)
            high := sub(high, gt(remainder, low))
            low := sub(low, remainder)
        }
        uint256 twos = denominator & (0 - denominator);
        assembly ("memory-safe") {
            denominator := div(denominator, twos)
            low := div(low, twos)
            twos := add(div(sub(0, twos), twos), 1)
        }
        low |= high * twos;
        uint256 inverse = (3 * denominator) ^ 2;
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        inverse *= 2 - (denominator * inverse);
        result = low * inverse;
        return result;
    }
}
```

### mul512(uint256,uint256)

- **Kind**: internal
- **Source**: 1027:550:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:mul512(uint256,uint256)`

```solidity
///  @dev Return the 512-bit multiplication of two uint256.
///  The result is stored in two 256 variables such that product = high * 2²⁵⁶ + low.
function mul512(uint256 a, uint256 b) internal pure returns (uint256 high, uint256 low) {
    assembly ("memory-safe") {
        let mm := mulmod(a, b, not(0))
        low := mul(a, b)
        high := sub(sub(mm, low), lt(mm, low))
    }
}
```

### panic(uint256)

- **Kind**: internal
- **Source**: 1776:194:281
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/Panic.sol:Panic:panic(uint256)`

```solidity
/// @dev Reverts with a panic code. Recommended to use with
///  the internal constants with predefined codes.
function panic(uint256 code) internal pure {
    assembly ("memory-safe") {
        mstore(0x00, 0x4e487b71)
        mstore(0x20, code)
        revert(0x1c, 0x24)
    }
}
```

### ternary(bool,uint256,uint256)

- **Kind**: internal
- **Source**: 5071:294:294
- **Link**: `lib/v2-core/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:ternary(bool,uint256,uint256)`

```solidity
///  @dev Branchless ternary evaluation for `a ? b : c`. Gas costs are constant.
///  IMPORTANT: This function may reduce bytecode size and consume less gas when used standalone.
///  However, the compiler may optimize Solidity ternary operations (i.e. `a ? b : c`) to only compute
///  one branch when needed, making this function more expensive.
function ternary(bool condition, uint256 a, uint256 b) internal pure returns (uint256) {
    unchecked {
        return b ^ ((a ^ b) * SafeCast.toUint(condition));
    }
}
```

## External Calls

- **Vm::selectFork(uint256)**
- **SuperVault::balanceOf(address)**
- **SuperVault::maxWithdraw(address)**
- **SuperVaultStrategy::claimableWithdraw(address)**

## State Variable Reads

- **sv5115** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **strategy5115SuperVault** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **contractAddresses** (`mapping(uint64 => mapping(string => address))`)
- **totalAssetHelper** (`contract TotalAssetHelper`) [test/integration/SuperVault/TotalAssetHelper.sol/contract_TotalAssetHelper.md]
- **ecdsappsOracle** (`contract IECDSAPPSOracle`) [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]
- **instanceOnEth** (`struct AccountInstance`)
- **superExecutorOnEth** (`contract ISuperExecutor`) [lib/v2-core/src/interfaces/ISuperExecutor.sol/interface_ISuperExecutor.md]
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)
- **VM_ADDR** (`address`)
- **MIN_STAKE_VALUE** (`uint256`)
- **MIN_UNSTAKE_DELAY** (`uint256`)
- **asset5115** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **accountEth** (`address`)
- **currentChainId** (`uint256`)
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **superVaultStates** (`mapping(address => struct BaseSuperVaultTest.SuperVaultState)`)
- **pendleEthena** (`contract IStandardizedYield`) [lib/v2-core/src/vendor/pendle/IStandardizedYield.sol/interface_IStandardizedYield.md]
- **pendleEthenaAddress** (`address`)

## State Variable Writes

- **sv5115** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]
- **escrow5115SuperVault** (`contract SuperVaultEscrow`) [src/SuperVault/SuperVaultEscrow.sol/contract_SuperVaultEscrow.md]
- **strategy5115SuperVault** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVault5115Tests.test_MaxWithdraw5115() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperVault5115Tests._setup5115Vault() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._deployVault(address,string) (NodeID: 2)
  │ │   💬 Args: [address(asset5115), "sv5115"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 3)
  │ │   💬 Args: [strategySuperVaultAddr, globalSV5115Strategy, "SV STRATEGY NOT EQUAL TO PREDICTED"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 4)
  │ │   💬 Args: [ETH, ERC5115_YIELD_SOURCE_ORACLE_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 5)
  │ │   💬 Args: [address(strategy5115SuperVault), address(sv5115)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 6)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 7)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 8)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 9)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 10)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 11)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 12)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 13)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 14)
  │ │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 15)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 16)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 17)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 18)
  │     💬 Args: [address(strategy), address(vault)]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 19)
  │   │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 20)
  │   │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │   │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 21)
  │   │ │     💬 Args: [rounding]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 22)
  │   │     💬 Args: [x, y, denominator]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 23)
  │   │   │   💬 Args: [x, y]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 24)
  │   │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 25)
  │   │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │   │         👁️  Def: internal
  │   │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 26)
  │   │           💬 Args: [condition]
  │   │           👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 27)
  │   │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 28)
  │       💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 29)
  │         💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 30)
  │           💬 Args: [_sendLogPayloadView]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._deposit(uint256,address,address) (NodeID: 31)
  │   💬 Args: [depositAmount, address(sv5115), address(asset5115)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest.__deposit(struct AccountInstance,uint256,address,address) (NodeID: 32)
  │     💬 Args: [instanceOnEth, depositAmount, superVault, asset_]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 33)
  │   │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 34)
  │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), superVault, asset_, depositAmount, false, address(0), 0]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 35)
  │   │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 36)
  │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(entry)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 37)
  │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 38)
  │       💬 Args: [userOpData]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 39)
  │         💬 Args: [userOpData]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 40)
  │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 41)
  │             💬 Args: [userOps, onEntryPoint]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 42)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 43)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 44)
  │           │   💬 Args: ["SIMULATE", false]
  │           │   👁️  Def: public
  │           ├─ [7] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 45)
  │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 46)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 47)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 48)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 49)
  │           │ │     💬 Args: [no args]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 50)
  │           │     💬 Args: [userOpDetails]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 51)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 52)
  │           │   │   💬 Args: [userOpDetails, debugTrace]
  │           │   │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 53)
  │           │   │ │   💬 Args: [userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 54)
  │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 55)
  │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 56)
  │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 57)
  │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: private
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 58)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 59)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 60)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 61)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 62)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 63)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 64)
  │           │   │ │   💬 Args: [filteredUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 65)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 66)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 67)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 68)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 69)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 70)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 71)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 72)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 73)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 74)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 75)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 76)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 77)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 78)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 79)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 80)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 81)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 82)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 83)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 84)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 85)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 86)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 87)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 88)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 89)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 90)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 91)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 92)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 93)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 94)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 95)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 96)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 97)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 98)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 99)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 100)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 101)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 102)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 103)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 104)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 105)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 106)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 107)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 108)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 109)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 110)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 111)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 112)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 113)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 114)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 115)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 116)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 117)
  │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 118)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 119)
  │           │       💬 Args: [snapShotId]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 120)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 121)
  │           │   💬 Args: [ctx.returnData]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 122)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 123)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 124)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 125)
  │           │   💬 Args: [logs, userOpHash]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 126)
  │           │   💬 Args: [account]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 127)
  │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 130)
  │           │ │   💬 Args: [logs, userOpHash]
  │           │ │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 128)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 129)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 131)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 132)
  │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 133)
  │           │   💬 Args: [logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 134)
  │           │   💬 Args: [j, logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 135)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 136)
  │           │     💬 Args: [slot]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 137)
  │           │   💬 Args: ["GAS", false]
  │           │   👁️  Def: public
  │           └─ [7] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 138)
  │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 139)
  │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │                 👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 140)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 141)
  │               │ │   💬 Args: [data]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 142)
  │               │     💬 Args: [compressed]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 143)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 144)
  │               │ │   💬 Args: [0.684e18]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 145)
  │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │               │     👁️  Def: internal
  │               │   ├─ [11] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 146)
  │               │   │   💬 Args: [getCallDataGas(data)]
  │               │   │   👁️  Def: internal
  │               │   │ └─ [12] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 147)
  │               │   │     💬 Args: [data]
  │               │   │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 148)
  │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │               │       👁️  Def: internal
  │               │     └─ [12] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 149)
  │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │               │         👁️  Def: internal
  │               │       └─ [13] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 150)
  │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │               │           👁️  Def: internal
  │               │         ├─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 151)
  │               │         │   💬 Args: [x]
  │               │         │   👁️  Def: internal
  │               │         └─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 152)
  │               │             💬 Args: [y]
  │               │             👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 153)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 154)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 155)
  │               │   💬 Args: [fileContent]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 156)
  │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 157)
  │               │ │     💬 Args: [fileContent, ".Total"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 158)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 159)
  │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 160)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 161)
  │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 162)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 163)
  │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 164)
  │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 165)
  │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │               │ │     👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 166)
  │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │               │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 167)
  │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │               │       👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 168)
  │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 169)
  │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 170)
  │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 171)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 172)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 173)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 174)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 175)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 176)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 177)
  │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 178)
  │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 179)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 180)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 181)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 182)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 183)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 184)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 185)
  │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 186)
  │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 187)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 188)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 189)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 190)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 191)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 192)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 193)
  │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 194)
  │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 195)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 196)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 197)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 198)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 199)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 200)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 201)
  │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 202)
  │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 203)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 204)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 205)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 206)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 207)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 208)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 209)
  │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 210)
  │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 211)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 212)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 213)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 214)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 215)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 216)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 217)
  │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 218)
  │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 219)
  │               │   💬 Args: [finalJson, fileName]
  │               │   👁️  Def: internal
  │               └─ [9] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 220)
  │                   💬 Args: [""]
  │                   👁️  Def: internal
  │                 └─ [10] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 221)
  │                     💬 Args: [slot, id]
  │                     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssetsFromSingleAmount5115(uint256,address,address) (NodeID: 222)
  │   💬 Args: [depositAmount, address(strategy5115SuperVault), pendleEthenaAddress]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 223)
  │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_5115_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: HooksHelpers._createApproveAndDeposit5115HookData(bytes32,address,address,uint256,uint256,bool) (NodeID: 224)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER), underlyingVault, address(asset5115), depositAmount, 0, false]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 225)
  │ │     💬 Args: [bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 226)
  │ │   💬 Args: [fulfillHooksAddresses, argsForProofs]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._getSuperVaultPricePerShare() (NodeID: 227)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 228)
  │ │     💬 Args: [totalAssetsVault, vault.PRECISION(), totalSupplyAmount, Math.Rounding.Floor]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 229)
  │ │   │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 230)
  │ │   │     💬 Args: [rounding]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 231)
  │ │       💬 Args: [x, y, denominator]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 232)
  │ │     │   💬 Args: [x, y]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 233)
  │ │         💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 234)
  │ │           💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 235)
  │ │             💬 Args: [condition]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 236)
  │ │   💬 Args: [depositAmount, strategy.PRECISION(), pricePerShare]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 237)
  │ │ │   💬 Args: [x, y]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 238)
  │ │     💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 239)
  │ │       💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 240)
  │ │         💬 Args: [condition]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._trackDeposit(address,uint256,uint256) (NodeID: 241)
  │     💬 Args: [accountEth, shares, depositAmount]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 242)
  │   💬 Args: ["----- userBalance", userBalance]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 243)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 244)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 245)
  │   💬 Args: ["----- maxWithdraw", maxWithdraw]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 246)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 247)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 248)
  │   💬 Args: [maxWithdraw, 0, "maxWithdraw should be 0 before redemption is fulfilled"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._requestRedeem(uint256,address) (NodeID: 249)
  │   💬 Args: [userBalance, address(sv5115)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: BaseSuperVaultTest.__requestRedeem(struct AccountInstance,uint256,bool,address) (NodeID: 250)
  │     💬 Args: [instanceOnEth, redeemShares, false, superVault]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 251)
  │   │   💬 Args: [ETH, REQUEST_REDEEM_7540_VAULT_HOOK_KEY]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._createRequestRedeem7540VaultHookData(bytes32,address,uint256,bool) (NodeID: 252)
  │   │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER), superVault, redeemShares, false]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 253)
  │   │     💬 Args: [bytes32(bytes(ERC7540_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: InternalHelpers._getExecOps(struct AccountInstance,contract ISuperExecutor,bytes) (NodeID: 254)
  │   │   💬 Args: [accInst, superExecutorOnEth, abi.encode(redeemEntry)]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.getExecOps(struct AccountInstance,address,uint256,bytes,address) (NodeID: 255)
  │   │     💬 Args: [instance, address(superExecutor), 0, abi.encodeCall(superExecutor.execute, (data)), address(instance.defaultValidator)]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: ModuleKitHelpers.expect4337Revert(struct AccountInstance) (NodeID: 256)
  │   │   💬 Args: [accInst]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.writeExpectRevert(bytes) (NodeID: 257)
  │   │     💬 Args: [""]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: InternalHelpers.executeOp(struct UserOpData) (NodeID: 258)
  │       💬 Args: [redeemUserOpData]
  │       👁️  Def: public
  │     └─ [4] ⚙️ FUNCTION: ModuleKitHelpers.execUserOps(struct UserOpData) (NodeID: 259)
  │         💬 Args: [userOpData]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation,contract IEntryPoint) (NodeID: 260)
  │           💬 Args: [userOpData.userOp, userOpData.entrypoint]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: ERC4337Helpers.exec4337(struct PackedUserOperation[],contract IEntryPoint) (NodeID: 261)
  │             💬 Args: [userOps, onEntryPoint]
  │             👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getExpectRevert() (NodeID: 262)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getSimulateUserOp() (NodeID: 263)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 264)
  │           │   💬 Args: ["SIMULATE", false]
  │           │   👁️  Def: public
  │           ├─ [7] ⚙️ FUNCTION: Simulator.simulateUserOp(struct PackedUserOperation,address) (NodeID: 265)
  │           │   💬 Args: [userOps[0], address(onEntryPoint)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Simulator._preSimulation() (NodeID: 266)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.snapshotState() (NodeID: 267)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ ├─ [9] ⚙️ FUNCTION: Unknown.startMappingRecording() (NodeID: 268)
  │           │ │ │   💬 Args: [no args]
  │           │ │ │   👁️  Def: internal
  │           │ │ └─ [9] ⚙️ FUNCTION: Unknown.startDebugTraceRecording() (NodeID: 269)
  │           │ │     💬 Args: [no args]
  │           │ │     👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Simulator._postSimulation(struct UserOperationDetails) (NodeID: 270)
  │           │     💬 Args: [userOpDetails]
  │           │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopAndReturnDebugTraceRecording() (NodeID: 271)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: ERC4337SpecsParser.parseValidation(struct UserOperationDetails,struct VmSafe.DebugStep[]) (NodeID: 272)
  │           │   │   💬 Args: [userOpDetails, debugTrace]
  │           │   │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.getEntities(struct UserOperationDetails) (NodeID: 273)
  │           │   │ │   💬 Args: [userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 274)
  │           │   │ │ │   💬 Args: [factory, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 275)
  │           │   │ │ │   💬 Args: [paymaster, userOpDetails.entryPoint]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isStaked(address,address) (NodeID: 276)
  │           │   │ │     💬 Args: [aggregator, userOpDetails.entryPoint]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.filterDebugTrace(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 277)
  │           │   │ │   💬 Args: [debugTrace, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: private
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 278)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 279)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 280)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 281)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isForbiddenOpcode(uint8) (NodeID: 282)
  │           │   │ │ │   💬 Args: [debugTrace[i].opcode]
  │           │   │ │ │   👁️  Def: private
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntityAndStaked(struct ERC4337SpecsParser.Entities,address) (NodeID: 283)
  │           │   │ │     💬 Args: [entities, debugTrace[i].contractAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 284)
  │           │   │ │   💬 Args: [filteredUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateOutOfGas(struct VmSafe.DebugStep[]) (NodeID: 285)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps]
  │           │   │ │   👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 286)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 287)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 288)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 289)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 290)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 291)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 292)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 293)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 294)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 295)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 296)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 297)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 298)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 299)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 300)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 301)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 302)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 303)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 304)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 305)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 306)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateBannedStorageLocations(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 307)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isEntity(struct ERC4337SpecsParser.Entities,address) (NodeID: 308)
  │           │   │ │ │   💬 Args: [entities, currentAccessAccount]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 309)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.account]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 310)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 311)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 312)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 313)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 314)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 315)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.paymaster]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 316)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 317)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 318)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 319)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 320)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ ├─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isAssociatedStorage(bytes32,address,address) (NodeID: 321)
  │           │   │ │ │   💬 Args: [currentSlot, currentAccessAccount, entities.factory]
  │           │   │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 322)
  │           │   │ │ │ │   💬 Args: [currentSlot, entity]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ ├─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.getMappingParent(address,bytes32) (NodeID: 323)
  │           │   │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ ├─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 324)
  │           │   │ │ │ │ │   💬 Args: [currentAccessAccount, currentSlot]
  │           │   │ │ │ │ │   👁️  Def: internal
  │           │   │ │ │ │ └─ [13] ⚙️ FUNCTION: Unknown.getMappingKeyAndParentOf(address,bytes32) (NodeID: 325)
  │           │   │ │ │ │     💬 Args: [currentAccessAccount, bytes32(uint256(currentSlot) - k)]
  │           │   │ │ │ │     👁️  Def: internal
  │           │   │ │ │ └─ [12] ⚙️ FUNCTION: ERC4337SpecsParser.slotMatchesEntity(bytes32,address) (NodeID: 326)
  │           │   │ │ │     💬 Args: [key, entity]
  │           │   │ │ │     👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 327)
  │           │   │ │     💬 Args: [currentAccessAccount]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 328)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 329)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCalls(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,address) (NodeID: 330)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails.entryPoint]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 331)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 332)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 333)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateExtOpcodes(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities) (NodeID: 334)
  │           │   │ │   💬 Args: [filteredPaymasterUserOpSteps, entities]
  │           │   │ │   👁️  Def: internal
  │           │   │ │ └─ [11] ⚙️ FUNCTION: ERC4337SpecsParser.isPrecompile(address) (NodeID: 335)
  │           │   │ │     💬 Args: [targetAddr]
  │           │   │ │     👁️  Def: internal
  │           │   │ ├─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 336)
  │           │   │ │   💬 Args: [filteredUserOpSteps, entities, userOpDetails]
  │           │   │ │   👁️  Def: internal
  │           │   │ └─ [10] ⚙️ FUNCTION: ERC4337SpecsParser.validateCreate(struct VmSafe.DebugStep[],struct ERC4337SpecsParser.Entities,struct UserOperationDetails) (NodeID: 337)
  │           │   │     💬 Args: [filteredPaymasterUserOpSteps, entities, userOpDetails]
  │           │   │     👁️  Def: internal
  │           │   ├─ [9] ⚙️ FUNCTION: Unknown.stopMappingRecording() (NodeID: 338)
  │           │   │   💬 Args: [no args]
  │           │   │   👁️  Def: internal
  │           │   └─ [9] ⚙️ FUNCTION: Unknown.revertToState(uint256) (NodeID: 339)
  │           │       💬 Args: [snapShotId]
  │           │       👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.recordLogs() (NodeID: 340)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 341)
  │           │   💬 Args: [ctx.returnData]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 342)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 343)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getRecordedLogs() (NodeID: 344)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 345)
  │           │   💬 Args: [logs, userOpHash]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getLabel(address) (NodeID: 346)
  │           │   💬 Args: [account]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: ERC4337Helpers.checkRevertMessage(bytes) (NodeID: 347)
  │           │   💬 Args: [getUserOpRevertReason(logs, userOpHash)]
  │           │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: ERC4337Helpers.getUserOpRevertReason(struct VmSafe.Log[],bytes32) (NodeID: 350)
  │           │ │   💬 Args: [logs, userOpHash]
  │           │ │   👁️  Def: internal
  │           │ ├─ [8] ⚙️ FUNCTION: Unknown.getExpectRevertMessage() (NodeID: 348)
  │           │ │   💬 Args: [no args]
  │           │ │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: ERC4337Helpers.parseFailedOpWithRevert(bytes,bytes) (NodeID: 349)
  │           │     💬 Args: [actualReason, revertMessage]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.clearExpectRevert() (NodeID: 351)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.writeInstalledModule(struct InstalledModule,address) (NodeID: 352)
  │           │   💬 Args: [InstalledModule(moduleType, module), logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getInstalledModules(address) (NodeID: 353)
  │           │   💬 Args: [logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.removeInstalledModule(uint256,address) (NodeID: 354)
  │           │   💬 Args: [j, logs[i].emitter]
  │           │   👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Unknown.getGasIdentifier() (NodeID: 355)
  │           │   💬 Args: [no args]
  │           │   👁️  Def: internal
  │           │ └─ [8] ⚙️ FUNCTION: Unknown.readString(bytes32) (NodeID: 356)
  │           │     💬 Args: [slot]
  │           │     👁️  Def: internal
  │           ├─ [7] ⚙️ FUNCTION: Helpers.envOr(string,bool) (NodeID: 357)
  │           │   💬 Args: ["GAS", false]
  │           │   👁️  Def: public
  │           └─ [7] ⚙️ FUNCTION: ERC4337Helpers.calculateGas(struct PackedUserOperation[],contract IEntryPoint,address,string,uint256) (NodeID: 358)
  │               💬 Args: [userOps, onEntryPoint, ctx.beneficiary, gasIdentifier, totalUserOpGas]
  │               👁️  Def: internal
  │             └─ [8] ⚙️ FUNCTION: GasParser.parseAndWriteGas(bytes,address,string,address,uint256) (NodeID: 359)
  │                 💬 Args: [userOpCalldata, address(onEntryPoint), gasIdentifier, userOps[0].sender, totalUserOpGas]
  │                 👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getArbitrumL1Gas(bytes) (NodeID: 360)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: LibZip.flzCompress(bytes) (NodeID: 361)
  │               │ │   💬 Args: [data]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 362)
  │               │     💬 Args: [compressed]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.getOpStackL1Gas(bytes) (NodeID: 363)
  │               │   💬 Args: [userOpCalldata]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.ud(uint256) (NodeID: 364)
  │               │ │   💬 Args: [0.684e18]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.intoUint256(UD60x18) (NodeID: 365)
  │               │     💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)).mul(opStackScalar)]
  │               │     👁️  Def: internal
  │               │   ├─ [11] ⚙️ FUNCTION: PRBMathCastingUint256.intoUD60x18(uint256) (NodeID: 366)
  │               │   │   💬 Args: [getCallDataGas(data)]
  │               │   │   👁️  Def: internal
  │               │   │ └─ [12] ⚙️ FUNCTION: Unknown.getCallDataGas(bytes) (NodeID: 367)
  │               │   │     💬 Args: [data]
  │               │   │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.mul(UD60x18,UD60x18) (NodeID: 368)
  │               │       💬 Args: [PRBMathCastingUint256.intoUD60x18(getCallDataGas(data)), opStackScalar]
  │               │       👁️  Def: internal
  │               │     └─ [12] ⚙️ FUNCTION: Unknown.wrap(uint256) (NodeID: 369)
  │               │         💬 Args: [Common.mulDiv18(x.unwrap(), y.unwrap())]
  │               │         👁️  Def: internal
  │               │       └─ [13] ⚙️ FUNCTION: Unknown.mulDiv18(uint256,uint256) (NodeID: 370)
  │               │           💬 Args: [Common, x.unwrap(), y.unwrap()]
  │               │           👁️  Def: internal
  │               │         ├─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 371)
  │               │         │   💬 Args: [x]
  │               │         │   👁️  Def: internal
  │               │         └─ [14] ⚙️ FUNCTION: Unknown.unwrap(UD60x18) (NodeID: 372)
  │               │             💬 Args: [y]
  │               │             👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.exists(string) (NodeID: 373)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.readFile(string) (NodeID: 374)
  │               │   💬 Args: [fileName]
  │               │   👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.parsePrevGasReport(string) (NodeID: 375)
  │               │   💬 Args: [fileContent]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 376)
  │               │ │   💬 Args: [parseJson(fileContent, ".Total")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 377)
  │               │ │     💬 Args: [fileContent, ".Total"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 378)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Creation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 379)
  │               │ │     💬 Args: [fileContent, ".Phases.Creation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 380)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Validation")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 381)
  │               │ │     💬 Args: [fileContent, ".Phases.Validation"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 382)
  │               │ │   💬 Args: [parseJson(fileContent, ".Phases.Execution")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 383)
  │               │ │     💬 Args: [fileContent, ".Phases.Execution"]
  │               │ │     👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 384)
  │               │ │   💬 Args: [parseJson(fileContent, ".Calldata.Arbitrum")]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 385)
  │               │ │     💬 Args: [fileContent, ".Calldata.Arbitrum"]
  │               │ │     👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.parseUintFromASCII(bytes) (NodeID: 386)
  │               │     💬 Args: [parseJson(fileContent, ".Calldata.OP-Stack")]
  │               │     👁️  Def: internal
  │               │   └─ [11] ⚙️ FUNCTION: Unknown.parseJson(string,string) (NodeID: 387)
  │               │       💬 Args: [fileContent, ".Calldata.OP-Stack"]
  │               │       👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: GasParser.formatGasToWrite(string,struct GasCalculations,struct GasCalculations) (NodeID: 388)
  │               │   💬 Args: [gasIdentifier, prevGasCalculations, gasCalculations]
  │               │   👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 389)
  │               │ │   💬 Args: [jsonObj, "Total", formatGasValue({prevValue: prevGasCalculations.total, newValue: gasCalculations.total})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 390)
  │               │ │     💬 Args: [prevGasCalculations.total, gasCalculations.total]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 391)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 392)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 393)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 394)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 395)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 396)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 397)
  │               │ │   💬 Args: [phasesObj, "Creation", formatGasValue({prevValue: prevGasCalculations.creation, newValue: gasCalculations.creation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 398)
  │               │ │     💬 Args: [prevGasCalculations.creation, gasCalculations.creation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 399)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 400)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 401)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 402)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 403)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 404)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 405)
  │               │ │   💬 Args: [phasesObj, "Validation", formatGasValue({prevValue: prevGasCalculations.validation, newValue: gasCalculations.validation})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 406)
  │               │ │     💬 Args: [prevGasCalculations.validation, gasCalculations.validation]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 407)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 408)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 409)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 410)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 411)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 412)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 413)
  │               │ │   💬 Args: [phasesObj, "Execution", formatGasValue({prevValue: prevGasCalculations.execution, newValue: gasCalculations.execution})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 414)
  │               │ │     💬 Args: [prevGasCalculations.execution, gasCalculations.execution]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 415)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 416)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 417)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 418)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 419)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 420)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 421)
  │               │ │   💬 Args: [l2sObj, "OP-Stack", formatGasValue({prevValue: prevGasCalculations.opStack, newValue: gasCalculations.opStack})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 422)
  │               │ │     💬 Args: [prevGasCalculations.opStack, gasCalculations.opStack]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 423)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 424)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 425)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 426)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 427)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 428)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 429)
  │               │ │   💬 Args: [l2sObj, "Arbitrum", formatGasValue({prevValue: prevGasCalculations.arbitrum, newValue: gasCalculations.arbitrum})]
  │               │ │   👁️  Def: internal
  │               │ │ └─ [11] ⚙️ FUNCTION: Unknown.formatGasValue(uint256,uint256) (NodeID: 430)
  │               │ │     💬 Args: [prevGasCalculations.arbitrum, gasCalculations.arbitrum]
  │               │ │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 431)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 432)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   ├─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 433)
  │               │ │   │   💬 Args: [int256(newValue)]
  │               │ │   │   👁️  Def: internal
  │               │ │   │ └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 434)
  │               │ │   │     💬 Args: [value]
  │               │ │   │     👁️  Def: internal
  │               │ │   └─ [12] ⚙️ FUNCTION: Unknown.formatGas(int256) (NodeID: 435)
  │               │ │       💬 Args: [int256(newValue) - int256(prevValue)]
  │               │ │       👁️  Def: internal
  │               │ │     └─ [13] ⚙️ FUNCTION: Unknown.toString(int256) (NodeID: 436)
  │               │ │         💬 Args: [value]
  │               │ │         👁️  Def: internal
  │               │ ├─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 437)
  │               │ │   💬 Args: [jsonObj, "Phases", phasesOutput]
  │               │ │   👁️  Def: internal
  │               │ └─ [10] ⚙️ FUNCTION: Unknown.serializeString(string,string,string) (NodeID: 438)
  │               │     💬 Args: [jsonObj, "Calldata", l2sOutput]
  │               │     👁️  Def: internal
  │               ├─ [9] ⚙️ FUNCTION: Unknown.writeJson(string,string) (NodeID: 439)
  │               │   💬 Args: [finalJson, fileName]
  │               │   👁️  Def: internal
  │               └─ [9] ⚙️ FUNCTION: Unknown.writeGasIdentifier(string) (NodeID: 440)
  │                   💬 Args: [""]
  │                   👁️  Def: internal
  │                 └─ [10] ⚙️ FUNCTION: Unknown.writeString(bytes32,string) (NodeID: 441)
  │                     💬 Args: [slot, id]
  │                     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BaseSuperVaultTest._fulfillRedeem5115(uint256,address,address) (NodeID: 442)
  │   💬 Args: [userBalance, address(sv5115), address(strategy5115SuperVault)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 443)
  │ │   💬 Args: [ETH, REDEEM_5115_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._create5115RedeemHookData(bytes32,address,address,uint256,uint256,bool) (NodeID: 444)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER), pendleEthenaAddress, CHAIN_1_SUSDE, vaultShare, 0, false]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 445)
  │ │     💬 Args: [bytes32(bytes(ERC5115_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 446)
  │ │   💬 Args: [hooksAddresses, argsForProofs]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._sortAndUniqueControllers(address[]) (NodeID: 447)
  │ │   💬 Args: [requestingUsers]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: LibSort.insertionSort(address[]) (NodeID: 448)
  │ │ │   💬 Args: [controllers]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: LibSort.insertionSort(uint256[]) (NodeID: 449)
  │ │ │     💬 Args: [_toUints(a)]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 450)
  │ │ │       💬 Args: [a]
  │ │ │       👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: LibSort.uniquifySorted(address[]) (NodeID: 451)
  │ │     💬 Args: [controllers]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: LibSort.uniquifySorted(uint256[]) (NodeID: 452)
  │ │       💬 Args: [_toUints(a)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 453)
  │ │         💬 Args: [a]
  │ │         👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[]) (NodeID: 454)
  │     💬 Args: [ISuperVaultStrategy(strat), requestingUsers, expectedAssetsOrSharesOut]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 455)
  │   │   💬 Args: ["Available from hooks [index %s]: %s", i, expectedAssetsFromHooks[i]]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 456)
  │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 457)
  │   │       💬 Args: [_sendLogPayloadView]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256) (NodeID: 458)
  │       💬 Args: [controllers, theoreticalAssets, totalTheoreticalAssets, totalAvailableAssets]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 459)
  │     │   💬 Args: ["Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 460)
  │     │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 461)
  │     │       💬 Args: [_sendLogPayloadView]
  │     │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 462)
  │     │   💬 Args: [theoreticalAssets[i], totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor]
  │     │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 463)
  │     │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │     │ │   👁️  Def: internal
  │     │ │ └─ [6] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 464)
  │     │ │     💬 Args: [rounding]
  │     │ │     👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 465)
  │     │     💬 Args: [x, y, denominator]
  │     │     👁️  Def: internal
  │     │   ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 466)
  │     │   │   💬 Args: [x, y]
  │     │   │   👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 467)
  │     │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │     │       👁️  Def: internal
  │     │     └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 468)
  │     │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │     │         👁️  Def: internal
  │     │       └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 469)
  │     │           💬 Args: [condition]
  │     │           👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 470)
  │         💬 Args: ["Remainder kept in vault as free assets:", remainder]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 471)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 472)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 473)
      💬 Args: [maxWithdrawAfter, claimable, "maxWithdraw should match claimable amount"]
      👁️  Def: internal
```
