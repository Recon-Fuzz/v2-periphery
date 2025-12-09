# Function: test_10_RuggableVault_Withdraw_ConvertDistortion()

**Contract**: [test/integration/SuperVault/SuperVault.t.sol/contract_SuperVaultTest.md]

## Metadata

- **Contract**: SuperVaultTest
- **Signature**: `test_10_RuggableVault_Withdraw_ConvertDistortion()`
- **Visibility**: public
- **Source Range**: 335085:1986:580

## Implementation

```solidity
function test_10_RuggableVault_Withdraw_ConvertDistortion() public {
    RugTestVarsWithdraw memory vars;
    vars.depositAmount = 1000e6;
    vars.rugPercentage = 5000;
    vars.initialTimestamp = block.timestamp;
    RuggableConvertVault ruggableConvertVault = RuggableConvertVault(Create2.deploy(0, keccak256(abi.encodePacked(TEST_SALT)), abi.encodePacked(type(RuggableConvertVault).creationCode, abi.encode(IERC20(address(asset)), "Ruggable Convert Vault", "RUGC", vars.rugPercentage, true))));
    console2.log("ruggableConvertVault", address(ruggableConvertVault));
    assertEq(address(ruggableConvertVault), test10_RuggableVault_Withdraw_ConvertDistortion, "TEST10_CONVERT VAULT NOT EQUAL TO PREDICTED");
    vars.ruggableVault = address(ruggableConvertVault);
    vars.convertVault = true;
    _testRuggableVaultWithdraw(vars);
    uint256 vaultTotalAssets = ruggableConvertVault.totalAssets();
    console2.log("Ruggable vault total assets:", vaultTotalAssets);
    ruggableConvertVault.setRugEnabled(false);
    uint256 vaultTotalAssetsWithoutRug = ruggableConvertVault.totalAssets();
    console2.log("Ruggable total assets (rug disabled):", vaultTotalAssetsWithoutRug);
    console2.log("Difference:", vaultTotalAssets - vaultTotalAssetsWithoutRug);
    assertGt(vaultTotalAssets, vaultTotalAssetsWithoutRug, "SuperVault total assets should be higher with rug enabled");
}
```

## Related Implementations

### deploy(uint256,bytes32,bytes)

- **Kind**: internal
- **Source**: 1210:847:53
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Create2.sol:Create2:deploy(uint256,bytes32,bytes)`

```solidity
///  @dev Deploys a contract using `CREATE2`. The address where the contract
///  will be deployed can be known in advance via {computeAddress}.
///  The bytecode for a contract can be obtained from Solidity with
///  `type(contractName).creationCode`.
///  Requirements:
///  - `bytecode` must not be empty.
///  - `salt` must have not been used for `bytecode` already.
///  - the factory must have a balance of at least `amount`.
///  - if `amount` is non-zero, `bytecode` must have a `payable` constructor.
function deploy(uint256 amount, bytes32 salt, bytes memory bytecode) internal returns (address addr) {
    if (address(this).balance < amount) {
        revert Errors.InsufficientBalance(address(this).balance, amount);
    }
    if (bytecode.length == 0) {
        revert Create2EmptyBytecode();
    }
    assembly ("memory-safe") {
        addr := create2(amount, add(bytecode, 0x20), mload(bytecode), salt)
        if and(iszero(addr), not(iszero(returndatasize()))) {
            let p := mload(0x40)
            returndatacopy(p, 0, returndatasize())
            revert(p, returndatasize())
        }
    }
    if (addr == address(0)) {
        revert Errors.FailedDeployment();
    }
}
```

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
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

### _testRuggableVaultWithdraw(struct SuperVaultTest.RugTestVarsWithdraw)

- **Kind**: internal
- **Source**: 363356:13000:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_testRuggableVaultWithdraw(struct SuperVaultTest.RugTestVarsWithdraw)`

```solidity
function _testRuggableVaultWithdraw(RugTestVarsWithdraw memory vars) internal {
    _getTokens(address(asset), address(this), 2 * LARGE_DEPOSIT);
    asset.approve(vars.ruggableVault, type(uint256).max);
    IERC4626(vars.ruggableVault).deposit(2 * LARGE_DEPOSIT, address(this));
    _deployNewSuperVaultWithRuggableVault(vars.ruggableVault);
    _updateRedeemSlippages(8000);
    vars.depositUsers = new address[](5);
    vars.depositAmounts = new uint256[](5);
    for (uint256 i = 0; i < 5; i++) {
        vars.depositUsers[i] = accInstances[i].account;
        vars.depositAmounts[i] = vars.depositAmount;
    }
    for (uint256 i = 0; i < 5; i++) {
        _getTokens(address(asset), vars.depositUsers[i], vars.depositAmounts[i]);
        vm.startPrank(vars.depositUsers[i]);
        asset.approve(address(vault), vars.depositAmounts[i]);
        vault.deposit(vars.depositAmounts[i], vars.depositUsers[i]);
        vm.stopPrank();
    }
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](2);
    expectedAssetsOrSharesOut[0] = IERC4626(address(fluidVault)).convertToShares((vars.depositAmount * 5) / 2);
    expectedAssetsOrSharesOut[1] = IERC4626(address(vars.ruggableVault)).convertToShares((vars.depositAmount * 5) / 2);
    _depositFreeAssets((vars.depositAmount * 5) / 2, (vars.depositAmount * 5) / 2, address(fluidVault), vars.ruggableVault);
    console2.log("\n=== TIME WARPING ===");
    vars.ppsBeforeWarp = aggregator.getPPS(address(strategy));
    console2.log("PPS BEFORE WARP", vars.ppsBeforeWarp);
    vm.warp(block.timestamp + 10 weeks);
    _updateSuperVaultPPS(address(strategy), address(vault));
    vars.ppsAfterWarp = aggregator.getPPS(address(strategy));
    console2.log("PPS AFTER WARP", vars.ppsAfterWarp);
    vars.initialTotalAssets = vault.totalAssets();
    vars.initialTotalSupply = vault.totalSupply();
    vars.initialPricePerShare = vars.initialTotalAssets.mulDiv(1e18, vars.initialTotalSupply, Math.Rounding.Floor);
    console2.log("\n=== Initial State Before Redemption ===");
    console2.log("Initial Total Assets:", vars.initialTotalAssets);
    console2.log("Initial Total Supply:", vars.initialTotalSupply);
    console2.log("Initial Price per share:", vars.initialPricePerShare);
    console2.log("Ruggable Vault Balance:", IERC4626(vars.ruggableVault).balanceOf(address(strategy)));
    console2.log("Fluid Vault Balance:", fluidVault.balanceOf(address(strategy)));
    assertGt(vars.initialTotalAssets, 0, "Initial total assets should be positive");
    assertGt(vars.initialTotalSupply, 0, "Initial total supply should be positive");
    vars.redeemUsers = new address[](3);
    vars.redeemAmounts = new uint256[](3);
    vars.totalRedeemShares = 0;
    for (uint256 i = 0; i < 3; i++) {
        vars.redeemUsers[i] = vars.depositUsers[i];
        uint256 userShares = vault.balanceOf(vars.redeemUsers[i]);
        vars.redeemAmounts[i] = userShares;
        vars.totalRedeemShares += vars.redeemAmounts[i];
    }
    for (uint256 i = 0; i < 3; i++) {
        vm.startPrank(vars.redeemUsers[i]);
        vault.requestRedeem(vars.redeemAmounts[i], vars.redeemUsers[i], vars.redeemUsers[i]);
        vm.stopPrank();
    }
    console2.log("\n=== TIME WARPING ===");
    vars.ppsBeforeWarp = aggregator.getPPS(address(strategy));
    console2.log("PPS BEFORE WARP", vars.ppsBeforeWarp);
    vm.warp(block.timestamp + 12 weeks);
    _updateSuperVaultPPS(address(strategy), address(vault));
    vars.ppsAfterWarp = aggregator.getPPS(address(strategy));
    console2.log("PPS AFTER WARP", vars.ppsAfterWarp);
    vars.redeemSharesVault1 = vars.totalRedeemShares / 2;
    vars.redeemSharesVault2 = vars.totalRedeemShares - vars.redeemSharesVault1;
    vars.assetsVault1 = IERC4626(address(fluidVault)).convertToAssets(vars.redeemSharesVault1);
    vars.assetsVault2 = IERC4626(address(vars.ruggableVault)).convertToAssets(vars.redeemSharesVault2);
    vars.expectedAssetsOrSharesOut = new uint256[](2);
    vars.expectedAssetsOrSharesOut[0] = vars.assetsVault1;
    vars.expectedAssetsOrSharesOut[1] = (!vars.convertVault) ? 1 : vars.assetsVault2;
    _executeRedeemHooks4626ForUsers(vars.redeemUsers, vars.redeemSharesVault1, vars.redeemSharesVault2, address(fluidVault), vars.ruggableVault, vars.expectedAssetsOrSharesOut, ISuperVaultStrategy.MINIMUM_OUTPUT_AMOUNT_ASSETS_NOT_MET.selector);
    vars.expectedAssetsOrSharesOut[0] = vars.assetsVault1 / 2;
    vars.expectedAssetsOrSharesOut[1] = vars.assetsVault2 / 2;
    _executeRedeemHooks4626ForUsers(vars.redeemUsers, vars.redeemSharesVault1, vars.redeemSharesVault2, address(fluidVault), vars.ruggableVault, vars.expectedAssetsOrSharesOut, bytes4(0));
    console2.log("\n=== Post-Fulfillment State ===");
    vars.totalAssetsPreClaimTaintedAssets = vault.totalAssets();
    vars.totalSupplyPreClaimTaintedAssets = vault.totalSupply();
    console2.log("Total Assets:", vars.totalAssetsPreClaimTaintedAssets);
    console2.log("Total Supply:", vars.totalSupplyPreClaimTaintedAssets);
    vars.pricePerSharePreClaimTaintedAssets = vars.totalAssetsPreClaimTaintedAssets.mulDiv(1e18, vars.totalSupplyPreClaimTaintedAssets, Math.Rounding.Floor);
    console2.log("Price per share:", vars.pricePerSharePreClaimTaintedAssets);
    console2.log("Ruggable Vault Balance:", IERC4626(vars.ruggableVault).balanceOf(address(strategy)));
    console2.log("Fluid Vault Balance:", fluidVault.balanceOf(address(strategy)));
    vars.finalTotalAssets = vault.totalAssets();
    vars.finalTotalSupply = vault.totalSupply();
    uint256 finalPricePerShare = vars.finalTotalAssets.mulDiv(1e18, vars.finalTotalSupply, Math.Rounding.Floor);
    console2.log("\n=== Final State ===");
    console2.log("Final Total Assets:", vars.finalTotalAssets);
    console2.log("Final Total Supply:", vars.finalTotalSupply);
    console2.log("Final Price per share:", finalPricePerShare);
    console2.log("\n=== Allocating from Rugged Vault back to Fluid Vault ===");
    vars.initialRuggableVaultBalance = IERC4626(vars.ruggableVault).balanceOf(address(strategy));
    vars.initialFluidVaultBalance = fluidVault.balanceOf(address(strategy));
    console2.log("Initial Ruggable Vault balance:", vars.initialRuggableVaultBalance);
    console2.log("Initial Fluid Vault balance:", vars.initialFluidVaultBalance);
    vars.initialRuggableVaultAssets = IERC4626(vars.ruggableVault).convertToAssets(vars.initialRuggableVaultBalance);
    vars.initialFluidVaultAssets = fluidVault.convertToAssets(vars.initialFluidVaultBalance);
    console2.log("Initial Ruggable Vault assets:", vars.initialRuggableVaultAssets);
    console2.log("Initial Fluid Vault assets:", vars.initialFluidVaultAssets);
    vars.amountToReallocate = vars.initialRuggableVaultBalance;
    vars.assetAmountToReallocate = (IERC4626(vars.ruggableVault).convertToAssets(vars.amountToReallocate) * 5000) / 10_000;
    console2.log("Shares to reallocate from Ruggable Vault:", vars.amountToReallocate);
    console2.log("Asset amount to reallocate:", vars.assetAmountToReallocate);
    if (vars.amountToReallocate > 0) {
        address withdrawHookAddress = _getHookAddress(ETH, REDEEM_4626_VAULT_HOOK_KEY);
        address depositHookAddress = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
        address[] memory hooksAddresses = new address[](2);
        hooksAddresses[0] = withdrawHookAddress;
        hooksAddresses[1] = depositHookAddress;
        bytes[] memory hooksData = new bytes[](2);
        hooksData[0] = _createRedeem4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)), vars.ruggableVault, address(strategy), vars.amountToReallocate, false);
        hooksData[1] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)), address(fluidVault), address(asset), vars.assetAmountToReallocate, false, address(0), 0);
        bytes[] memory argsForProofs = new bytes[](2);
        argsForProofs[0] = ISuperHookInspector(hooksAddresses[0]).inspect(hooksData[0]);
        argsForProofs[1] = ISuperHookInspector(hooksAddresses[1]).inspect(hooksData[1]);
        vm.startPrank(MANAGER);
        strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: hooksAddresses, hookCalldata: hooksData, expectedAssetsOrSharesOut: new uint256[](2), globalProofs: _getMerkleProofsForHooks(hooksAddresses, argsForProofs), strategyProofs: new bytes32[][](hooksAddresses.length)}));
        vm.stopPrank();
        vars.finalRuggableVaultBalance = IERC4626(vars.ruggableVault).balanceOf(address(strategy));
        vars.finalFluidVaultBalance = fluidVault.balanceOf(address(strategy));
        console2.log("Final Ruggable Vault balance:", vars.finalRuggableVaultBalance);
        console2.log("Final Fluid Vault balance:", vars.finalFluidVaultBalance);
        vars.finalRuggableVaultAssets = IERC4626(vars.ruggableVault).convertToAssets(vars.finalRuggableVaultBalance);
        vars.finalFluidVaultAssets = fluidVault.convertToAssets(vars.finalFluidVaultBalance);
        console2.log("Final Ruggable Vault assets:", vars.finalRuggableVaultAssets);
        console2.log("Final Fluid Vault assets:", vars.finalFluidVaultAssets);
        assertApproxEqRel(vars.finalRuggableVaultBalance, vars.initialRuggableVaultBalance - vars.amountToReallocate, 0.01e18, "Ruggable Vault balance should decrease by the reallocated amount");
        assertGt(vars.finalFluidVaultBalance, vars.initialFluidVaultBalance, "Fluid Vault balance should increase");
        vars.initialTotalValue = vars.initialRuggableVaultAssets + vars.initialFluidVaultAssets;
        vars.finalTotalValue = vars.finalRuggableVaultAssets + vars.finalFluidVaultAssets;
        console2.log("Initial total value:", vars.initialTotalValue);
        console2.log("Final total value:", vars.finalTotalValue);
        vars.vaultTotalAssetsAfterAllocation = vault.totalAssets();
        vars.pricePerShareAfterAllocation = vars.vaultTotalAssetsAfterAllocation.mulDiv(1e18, vars.finalTotalSupply, Math.Rounding.Floor);
        console2.log("Vault total assets after allocation:", vars.vaultTotalAssetsAfterAllocation);
        console2.log("Price per share after allocation:", vars.pricePerShareAfterAllocation);
    } else {
        console2.log("Skipping reallocation as there are no shares to reallocate");
    }
}
```

### _getTokens(address,address,uint256)

- **Kind**: internal
- **Source**: 3137:118:500
- **Link**: `lib/v2-core/test/utils/Helpers.sol:Helpers:_getTokens(address,address,uint256)`

```solidity
function _getTokens(address token_, address to_, uint256 amount_) internal {
    deal(token_, to_, amount_);
}
```

### deal(address,address,uint256)

- **Kind**: internal
- **Source**: 27270:117:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256)`

```solidity
function deal(address token, address to, uint256 give) virtual internal {
    deal(token, to, give, false);
}
```

### deal(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 27666:837:14
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256,bool)`

```solidity
function deal(address token, address to, uint256 give, bool adjust) virtual internal {
    (, bytes memory balData) = token.staticcall(abi.encodeWithSelector(0x70a08231, to));
    uint256 prevBal = abi.decode(balData, (uint256));
    stdstore.target(token).sig(0x70a08231).with_key(to).checked_write(give);
    if (adjust) {
        (, bytes memory totSupData) = token.staticcall(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));
        if (give < prevBal) {
            totSup -= (prevBal - give);
        } else {
            totSup += (give - prevBal);
        }
        stdstore.target(token).sig(0x18160ddd).checked_write(totSup);
    }
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13254:156:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    return stdStorageSafe.target(self, _target);
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 6743:156:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    self._target = _target;
    return self;
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 13416:143:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    return stdStorageSafe.sig(self, _sig);
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 6905:143:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    self._sig = _sig;
    return self;
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13721:152:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    return stdStorageSafe.with_key(self, who);
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 7396:179:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    self._keys.push(bytes32(uint256(uint160(who))));
    return self;
}
```

### checked_write(struct StdStorage,uint256)

- **Kind**: internal
- **Source**: 14942:120:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,uint256)`

```solidity
function checked_write(StdStorage storage self, uint256 amt) internal {
    checked_write(self, bytes32(amt));
}
```

### checked_write(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 15434:1484:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,bytes32)`

```solidity
function checked_write(StdStorage storage self, bytes32 set) internal {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = stdStorageSafe.getCallParams(self);
    if (!self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        find(self, false);
    }
    FindData storage data = self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    if ((data.offsetLeft + data.offsetRight) > 0) {
        uint256 maxVal = 2 ** (256 - (data.offsetLeft + data.offsetRight));
        require(uint256(set) < maxVal, string(abi.encodePacked("stdStorage find(StdStorage): Packed slot. We can't fit value greater than ", vm.toString(maxVal))));
    }
    bytes32 curVal = vm.load(who, bytes32(data.slot));
    bytes32 valToSet = stdStorageSafe.getUpdatedSlotValue(curVal, uint256(set), data.offsetLeft, data.offsetRight);
    vm.store(who, bytes32(data.slot), valToSet);
    (bool success, bytes32 callResult) = stdStorageSafe.callTarget(self);
    if ((!success) || (callResult != set)) {
        vm.store(who, bytes32(data.slot), curVal);
        revert("stdStorage find(StdStorage): Failed to write value.");
    }
    clear(self);
}
```

### getCallParams(struct StdStorage)

- **Kind**: internal
- **Source**: 953:236:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getCallParams(struct StdStorage)`

```solidity
function getCallParams(StdStorage storage self) internal view returns (bytes memory) {
    if (self._calldata.length == 0) {
        return flatten(self._keys);
    } else {
        return self._calldata;
    }
}
```

### flatten(bytes32[])

- **Kind**: internal
- **Source**: 11182:393:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:flatten(bytes32[])`

```solidity
function flatten(bytes32[] memory b) private pure returns (bytes memory) {
    bytes memory result = new bytes(b.length * 32);
    for (uint256 i = 0; i < b.length; i++) {
        bytes32 k = b[i];
        /// @solidity memory-safe-assembly
        assembly {
            mstore(add(result, add(32, mul(32, i))), k)
        }
    }
    return result;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 13107:141:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:find(struct StdStorage,bool)`

```solidity
function find(StdStorage storage self, bool _clear) internal returns (uint256) {
    return stdStorageSafe.find(self, _clear).slot;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 4245:2492:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:find(struct StdStorage,bool)`

```solidity
/// @notice find an arbitrary storage slot given a function sig, input data, address of the contract and a value to check against
function find(StdStorage storage self, bool _clear) internal returns (FindData storage) {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = getCallParams(self);
    if (self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        if (_clear) {
            clear(self);
        }
        return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    }
    vm.record();
    (, bytes32 callResult) = callTarget(self);
    (bytes32[] memory reads, ) = vm.accesses(address(who));
    if (reads.length == 0) {
        revert("stdStorage find(StdStorage): No storage use detected for target.");
    } else {
        for (uint256 i = reads.length; (--i) >= 0; ) {
            bytes32 prev = vm.load(who, reads[i]);
            if (prev == bytes32(0)) {
                emit WARNING_UninitedSlot(who, uint256(reads[i]));
            }
            if (!checkSlotMutatesCall(self, reads[i])) {
                continue;
            }
            (uint256 offsetLeft, uint256 offsetRight) = (0, 0);
            if (self._enable_packed_slots) {
                bool found;
                (found, offsetLeft, offsetRight) = findOffsets(self, reads[i]);
                if (!found) {
                    continue;
                }
            }
            uint256 curVal = (uint256(prev) & getMaskByOffsets(offsetLeft, offsetRight)) >> offsetRight;
            if (uint256(callResult) != curVal) {
                continue;
            }
            emit SlotFound(who, fsig, keccak256(abi.encodePacked(params, field_depth)), uint256(reads[i]));
            self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))] = FindData(uint256(reads[i]), offsetLeft, offsetRight, true);
            break;
        }
    }
    require(self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found, "stdStorage find(StdStorage): Slot(s) not found.");
    if (_clear) {
        clear(self);
    }
    return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 11581:239:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    delete self._target;
    delete self._sig;
    delete self._keys;
    delete self._depth;
    delete self._enable_packed_slots;
    delete self._calldata;
}
```

### callTarget(struct StdStorage)

- **Kind**: internal
- **Source**: 1251:339:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:callTarget(struct StdStorage)`

```solidity
function callTarget(StdStorage storage self) internal view returns (bool, bytes32) {
    bytes memory cd = abi.encodePacked(self._sig, getCallParams(self));
    (bool success, bytes memory rdat) = self._target.staticcall(cd);
    bytes32 result = bytesToBytes32(rdat, 32 * self._depth);
    return (success, result);
}
```

### bytesToBytes32(bytes,uint256)

- **Kind**: internal
- **Source**: 10872:304:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:bytesToBytes32(bytes,uint256)`

```solidity
function bytesToBytes32(bytes memory b, uint256 offset) private pure returns (bytes32) {
    bytes32 out;
    uint256 max = (b.length > 32) ? 32 : b.length;
    for (uint256 i = 0; i < max; i++) {
        out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
}
```

### checkSlotMutatesCall(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 1847:546:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:checkSlotMutatesCall(struct StdStorage,bytes32)`

```solidity
function checkSlotMutatesCall(StdStorage storage self, bytes32 slot) internal returns (bool) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool success, bytes32 prevReturnValue) = callTarget(self);
    bytes32 testVal = (prevReturnValue == bytes32(0)) ? bytes32(UINT256_MAX) : bytes32(0);
    vm.store(self._target, slot, testVal);
    (, bytes32 newReturnValue) = callTarget(self);
    vm.store(self._target, slot, prevSlotValue);
    return (success && (prevReturnValue != newReturnValue));
}
```

### findOffsets(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 3076:534:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffsets(struct StdStorage,bytes32)`

```solidity
function findOffsets(StdStorage storage self, bytes32 slot) internal returns (bool, uint256, uint256) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool foundLeft, uint256 offsetLeft) = findOffset(self, slot, true);
    (bool foundRight, uint256 offsetRight) = findOffset(self, slot, false);
    vm.store(self._target, slot, prevSlotValue);
    return (foundLeft && foundRight, offsetLeft, offsetRight);
}
```

### findOffset(struct StdStorage,bytes32,bool)

- **Kind**: internal
- **Source**: 2556:514:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffset(struct StdStorage,bytes32,bool)`

```solidity
function findOffset(StdStorage storage self, bytes32 slot, bool left) internal returns (bool, uint256) {
    for (uint256 offset = 0; offset < 256; offset++) {
        uint256 valueToPut = left ? (1 << (255 - offset)) : (1 << offset);
        vm.store(self._target, slot, bytes32(valueToPut));
        (bool success, bytes32 data) = callTarget(self);
        if (success && (uint256(data) > 0)) {
            return (true, offset);
        }
    }
    return (false, 0);
}
```

### getMaskByOffsets(uint256,uint256)

- **Kind**: internal
- **Source**: 12013:376:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getMaskByOffsets(uint256,uint256)`

```solidity
function getMaskByOffsets(uint256 offsetLeft, uint256 offsetRight) internal pure returns (uint256 mask) {
    assembly {
        mask := shl(offsetRight, sub(shl(sub(256, add(offsetRight, offsetLeft)), 1), 1))
    }
}
```

### getUpdatedSlotValue(bytes32,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 12451:300:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getUpdatedSlotValue(bytes32,uint256,uint256,uint256)`

```solidity
function getUpdatedSlotValue(bytes32 curValue, uint256 varValue, uint256 offsetLeft, uint256 offsetRight) internal pure returns (bytes32 newValue) {
    return bytes32((uint256(curValue) & (~getMaskByOffsets(offsetLeft, offsetRight))) | (varValue << offsetRight));
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 14700:92:20
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    stdStorageSafe.clear(self);
}
```

### _deployNewSuperVaultWithRuggableVault(address)

- **Kind**: internal
- **Source**: 376362:1346:580
- **Link**: `test/integration/SuperVault/SuperVault.t.sol:SuperVaultTest:_deployNewSuperVaultWithRuggableVault(address)`

```solidity
function _deployNewSuperVaultWithRuggableVault(address ruggableVault) internal {
    address vaultAddr;
    address strategyAddr;
    address escrowAddr;
    (vaultAddr, strategyAddr, escrowAddr) = _deployVault("SV_USDC_RUG");
    vault = SuperVault(vaultAddr);
    strategy = SuperVaultStrategy(payable(strategyAddr));
    escrow = SuperVaultEscrow(escrowAddr);
    vm.startPrank(MANAGER);
    strategy.manageYieldSource(address(fluidVault), _getContract(ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    strategy.manageYieldSource(ruggableVault, _getContract(ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY), ISuperVaultStrategy.YieldSourceAction.Add);
    vm.stopPrank();
    vm.startPrank(MANAGER);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Propose, 86_400);
    vm.warp(block.timestamp + 2 weeks);
    strategy.managePPSExpiration(ISuperVaultStrategy.PPSExpirationAction.Execute, 0);
    vm.stopPrank();
    _updateSuperVaultPPS(address(strategy), address(vault));
}
```

### _deployVault(string)

- **Kind**: internal
- **Source**: 16658:225:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_deployVault(string)`

```solidity
///  @notice Deploys a new SuperVault with default configuration
///  @param _superVaultSymbol The symbol for the SuperVault
///  @return vaultAddr The address of the deployed SuperVault
///  @return strategyAddr The address of the deployed SuperVaultStrategy
///  @return escrowAddr The address of the deployed SuperVaultEscrow
function _deployVault(string memory _superVaultSymbol) internal returns (address vaultAddr, address strategyAddr, address escrowAddr) {
    return _deployVault(address(asset), _superVaultSymbol);
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

### _updateRedeemSlippages(uint16)

- **Kind**: internal
- **Source**: 129206:302:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_updateRedeemSlippages(uint16)`

```solidity
/// @notice Updates redeem slippages for all accounts
function _updateRedeemSlippages(uint16 slippageBps) internal {
    for (uint256 i; i < ACCOUNT_COUNT; ++i) {
        vm.prank(accInstances[i].account);
        strategy.setRedeemSlippage(slippageBps);
    }
}
```

### _depositFreeAssets(uint256,uint256,address,address)

- **Kind**: internal
- **Source**: 55893:2240:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_depositFreeAssets(uint256,uint256,address,address)`

```solidity
function _depositFreeAssets(uint256 allocationAmountVault1, uint256 allocationAmountVault2, address vault1, address vault2) internal {
    address depositHookAddress = _getHookAddress(ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY);
    address[] memory fulfillHooksAddresses = new address[](2);
    fulfillHooksAddresses[0] = depositHookAddress;
    fulfillHooksAddresses[1] = depositHookAddress;
    bytes[] memory fulfillHooksData = new bytes[](2);
    fulfillHooksData[0] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(asset), allocationAmountVault1, false, address(0), 0);
    fulfillHooksData[1] = _createApproveAndDeposit4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(asset), allocationAmountVault2, false, address(0), 0);
    uint256[] memory expectedAssetsOrSharesOut = new uint256[](2);
    expectedAssetsOrSharesOut[0] = IERC4626(address(vault1)).convertToShares(allocationAmountVault1);
    expectedAssetsOrSharesOut[1] = IERC4626(address(vault2)).convertToShares(allocationAmountVault2);
    vm.startPrank(MANAGER);
    bytes[] memory argsForProofs = new bytes[](2);
    argsForProofs[0] = ISuperHookInspector(fulfillHooksAddresses[0]).inspect(fulfillHooksData[0]);
    argsForProofs[1] = ISuperHookInspector(fulfillHooksAddresses[1]).inspect(fulfillHooksData[1]);
    strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: fulfillHooksAddresses, hookCalldata: fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: _getMerkleProofsForHooks(fulfillHooksAddresses, argsForProofs), strategyProofs: new bytes32[][](2)}));
    vm.stopPrank();
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

### log(string)

- **Kind**: internal
- **Source**: 6191:121:26
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 14795:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    if (left <= right) {
        vm.assertGt(left, right, err);
    }
}
```

### _executeRedeemHooks4626ForUsers(address[],uint256,uint256,address,address,uint256[],bytes4)

- **Kind**: internal
- **Source**: 75585:4155:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_executeRedeemHooks4626ForUsers(address[],uint256,uint256,address,address,uint256[],bytes4)`

```solidity
function _executeRedeemHooks4626ForUsers(address[] memory requestingUsers, uint256 redeemSharesVault1, uint256 redeemSharesVault2, address vault1, address vault2, uint256[] memory expectedAssetsOrSharesOut, bytes4 revertSelector) internal {
    ExecuteRedeemHooks4626ForUsersVars memory vars;
    vars.underlyingSharesVault1 = _convertSVSharestoUnderlyingVaultShares(redeemSharesVault1, vault1);
    vars.underlyingSharesVault2 = _convertSVSharestoUnderlyingVaultShares(redeemSharesVault2, vault2);
    vars.underlyingSharesVault1 = _truncateToActualBalance(vars.underlyingSharesVault1, vault1, 100);
    vars.underlyingSharesVault2 = _truncateToActualBalance(vars.underlyingSharesVault2, vault2, 100);
    for (uint256 i; i < expectedAssetsOrSharesOut.length; i++) {
        expectedAssetsOrSharesOut[i] = expectedAssetsOrSharesOut[i] - ((expectedAssetsOrSharesOut[i] * 4e2) / 1e5);
    }
    vars.withdrawHookAddress = _getHookAddress(ETH, REDEEM_4626_VAULT_HOOK_KEY);
    vars.fulfillHooksAddresses = new address[](2);
    vars.fulfillHooksAddresses[0] = vars.withdrawHookAddress;
    vars.fulfillHooksAddresses[1] = vars.withdrawHookAddress;
    vars.fulfillHooksData = new bytes[](2);
    vars.fulfillHooksData[0] = _createRedeem4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(strategy), vars.underlyingSharesVault1, false);
    vars.fulfillHooksData[1] = _createRedeem4626HookData(_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(strategy), vars.underlyingSharesVault2, false);
    vars.argsForProofs = new bytes[](2);
    vars.argsForProofs[0] = ISuperHookInspector(vars.fulfillHooksAddresses[0]).inspect(vars.fulfillHooksData[0]);
    vars.argsForProofs[1] = ISuperHookInspector(vars.fulfillHooksAddresses[1]).inspect(vars.fulfillHooksData[1]);
    vars.proofs = _getMerkleProofsForHooks(vars.fulfillHooksAddresses, vars.argsForProofs);
    vm.startPrank(MANAGER);
    if (revertSelector != bytes4(0)) {
        vm.expectRevert(revertSelector);
        strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: vars.fulfillHooksAddresses, hookCalldata: vars.fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: vars.proofs, strategyProofs: new bytes32[][](2)}));
        vm.stopPrank();
        return;
    } else {
        strategy.executeHooks(ISuperVaultStrategy.ExecuteArgs({hooks: vars.fulfillHooksAddresses, hookCalldata: vars.fulfillHooksData, expectedAssetsOrSharesOut: expectedAssetsOrSharesOut, globalProofs: vars.proofs, strategyProofs: new bytes32[][](2)}));
    }
    requestingUsers = _sortAndUniqueControllers(requestingUsers);
    vars.totalAssetsOut = calculateAdjustedFulfillment(strategy, requestingUsers, expectedAssetsOrSharesOut);
    strategy.fulfillRedeemRequests(requestingUsers, vars.totalAssetsOut);
    vm.stopPrank();
}
```

### _convertSVSharestoUnderlyingVaultShares(uint256,address)

- **Kind**: internal
- **Source**: 123408:334:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_convertSVSharestoUnderlyingVaultShares(uint256,address)`

```solidity
///  @notice Convert individual SuperVault shares allocated to a specific vault to underlying vault shares
///  @param svShares SuperVault shares allocated to this specific vault
///  @param underlyingVault The underlying ERC4626 vault
///  @return underlyingShares The corresponding underlying vault shares
function _convertSVSharestoUnderlyingVaultShares(uint256 svShares, address underlyingVault) internal view returns (uint256 underlyingShares) {
    uint256 assets = vault.convertToAssets(svShares);
    underlyingShares = IERC4626(underlyingVault).previewWithdraw(assets);
}
```

### _truncateToActualBalance(uint256,address,uint256)

- **Kind**: internal
- **Source**: 124206:1588:576
- **Link**: `test/integration/SuperVault/BaseSuperVaultTest.t.sol:BaseSuperVaultTest:_truncateToActualBalance(uint256,address,uint256)`

```solidity
///  @notice Truncates expected underlying shares to actual balance if needed
///  @dev Reverts if actual balance is below the tolerance threshold
///  @param expectedShares The expected underlying vault shares
///  @param underlyingVault The underlying ERC4626 vault address
///  @param toleranceBps The tolerance in basis points (10000 = 100%)
///  @return adjustedShares The adjusted shares (truncated to balance if necessary)
function _truncateToActualBalance(uint256 expectedShares, address underlyingVault, uint256 toleranceBps) internal view returns (uint256 adjustedShares) {
    uint256 actualBalance = IERC20(underlyingVault).balanceOf(address(strategy));
    if (actualBalance >= expectedShares) {
        console2.log("no truncation of balance of shares");
        console2.log("---");
        return expectedShares;
    }
    uint256 minAcceptableBalance = (expectedShares * (10_000 - toleranceBps)) / 10_000;
    console2.log("vault", underlyingVault);
    console2.log("minAcceptableBalance", minAcceptableBalance);
    console2.log("actualBalance", actualBalance);
    if (actualBalance < minAcceptableBalance) {
        revert(string(abi.encodePacked("Vault balance too low: more than ", Strings.toString(toleranceBps), " bps below expected")));
    }
    uint256 truncatedValue = expectedShares - actualBalance;
    console2.log("truncated value", truncatedValue);
    console2.log("---");
    return actualBalance;
}
```

### toString(uint256)

- **Kind**: internal
- **Source**: 1308:634:56
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` decimal representation.
function toString(uint256 value) internal pure returns (string memory) {
    unchecked {
        uint256 length = Math.log10(value) + 1;
        string memory buffer = new string(length);
        uint256 ptr;
        assembly ("memory-safe") {
            ptr := add(add(buffer, 0x20), length)
        }
        while (true) {
            ptr--;
            assembly ("memory-safe") {
                mstore8(ptr, byte(mod(value, 10), HEX_DIGITS))
            }
            value /= 10;
            if (value == 0) break;
        }
        return buffer;
    }
}
```

### log10(uint256)

- **Kind**: internal
- **Source**: 29154:916:60
- **Link**: `lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

```solidity
///  @dev Return the log in base 10 of a positive value rounded towards zero.
///  Returns 0 if given 0.
function log10(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if (value >= (10 ** 64)) {
            value /= 10 ** 64;
            result += 64;
        }
        if (value >= (10 ** 32)) {
            value /= 10 ** 32;
            result += 32;
        }
        if (value >= (10 ** 16)) {
            value /= 10 ** 16;
            result += 16;
        }
        if (value >= (10 ** 8)) {
            value /= 10 ** 8;
            result += 8;
        }
        if (value >= (10 ** 4)) {
            value /= 10 ** 4;
            result += 4;
        }
        if (value >= (10 ** 2)) {
            value /= 10 ** 2;
            result += 2;
        }
        if (value >= (10 ** 1)) {
            result += 1;
        }
    }
    return result;
}
```

### _createRedeem4626HookData(bytes32,address,address,uint256,bool)

- **Kind**: internal
- **Source**: 13305:360:501
- **Link**: `lib/v2-core/test/utils/InternalHelpers.sol:InternalHelpers:_createRedeem4626HookData(bytes32,address,address,uint256,bool)`

```solidity
function _createRedeem4626HookData(bytes32 yieldSourceOracleId, address vault, address owner, uint256 shares, bool usePrevHookAmount) internal pure returns (bytes memory hookData) {
    hookData = abi.encodePacked(yieldSourceOracleId, vault, owner, shares, usePrevHookAmount);
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

### assertApproxEqRel(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 20668:288:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertApproxEqRel(uint256,uint256,uint256,string)`

```solidity
function assertApproxEqRel(uint256 left, uint256 right, uint256 maxPercentDelta, string memory err) virtual internal pure {
    vm.assertApproxEqRel(left, right, maxPercentDelta, err);
}
```

## External Calls

- **RuggableConvertVault::totalAssets()**
- **RuggableConvertVault::setRugEnabled(bool)**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **stdstore** (`struct StdStorage`)
- **UINT256_MAX** (`uint256`)
- **asset** (`contract IERC20Metadata`) [lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **aggregator** (`contract SuperVaultAggregator`) [src/SuperVault/SuperVaultAggregator.sol/contract_SuperVaultAggregator.md]
- **contractAddresses** (`mapping(uint64 => mapping(string => address))`)
- **totalAssetHelper** (`contract TotalAssetHelper`) [test/integration/SuperVault/TotalAssetHelper.sol/contract_TotalAssetHelper.md]
- **ecdsappsOracle** (`contract IECDSAPPSOracle`) [src/interfaces/oracles/IECDSAPPSOracle.sol/interface_IECDSAPPSOracle.md]
- **accInstances** (`struct AccountInstance[]`)
- **strategy** (`contract SuperVaultStrategy`) [src/SuperVault/SuperVaultStrategy.sol/contract_SuperVaultStrategy.md]
- **hookAddresses** (`mapping(uint64 => mapping(string => address))`)
- **currentChainId** (`uint256`)
- **vault** (`contract SuperVault`) [src/SuperVault/SuperVault.sol/contract_SuperVault.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperVaultTest.test_10_RuggableVault_Withdraw_ConvertDistortion() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Create2.deploy(uint256,bytes32,bytes) (NodeID: 1)
  │   💬 Args: [0, keccak256(abi.encodePacked(TEST_SALT)), abi.encodePacked(type(RuggableConvertVault).creationCode, abi.encode(IERC20(address(asset)), "Ruggable Convert Vault", "RUGC", vars.rugPercentage, true))]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 2)
  │   💬 Args: ["ruggableConvertVault", address(ruggableConvertVault)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 3)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 4)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 5)
  │   💬 Args: [address(ruggableConvertVault), test10_RuggableVault_Withdraw_ConvertDistortion, "TEST10_CONVERT VAULT NOT EQUAL TO PREDICTED"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperVaultTest._testRuggableVaultWithdraw(struct SuperVaultTest.RugTestVarsWithdraw) (NodeID: 6)
  │   💬 Args: [vars]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Helpers._getTokens(address,address,uint256) (NodeID: 7)
  │ │   💬 Args: [address(asset), address(this), 2 * LARGE_DEPOSIT]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 8)
  │ │     💬 Args: [token_, to_, amount_]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 9)
  │ │       💬 Args: [token, to, give, false]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 10)
  │ │     │   💬 Args: [stdstore, token]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 11)
  │ │     │     💬 Args: [self, _target]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 12)
  │ │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 13)
  │ │     │     💬 Args: [self, _sig]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 14)
  │ │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 15)
  │ │     │     💬 Args: [self, who]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 16)
  │ │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 17)
  │ │     │     💬 Args: [self, bytes32(amt)]
  │ │     │     👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 18)
  │ │     │   │   💬 Args: [self]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 19)
  │ │     │   │     💬 Args: [self._keys]
  │ │     │   │     👁️  Def: private
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 20)
  │ │     │   │   💬 Args: [self, false]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 21)
  │ │     │   │     💬 Args: [self, _clear]
  │ │     │   │     👁️  Def: internal
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 22)
  │ │     │   │   │   💬 Args: [self]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 23)
  │ │     │   │   │     💬 Args: [self._keys]
  │ │     │   │   │     👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 24)
  │ │     │   │   │   💬 Args: [self]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 25)
  │ │     │   │   │   💬 Args: [self]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 26)
  │ │     │   │   │ │   💬 Args: [self]
  │ │     │   │   │ │   👁️  Def: internal
  │ │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 27)
  │ │     │   │   │ │     💬 Args: [self._keys]
  │ │     │   │   │ │     👁️  Def: private
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 28)
  │ │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │     👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 29)
  │ │     │   │   │   💬 Args: [self, reads[i]]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 30)
  │ │     │   │   │ │   💬 Args: [self]
  │ │     │   │   │ │   👁️  Def: internal
  │ │     │   │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 31)
  │ │     │   │   │ │ │   💬 Args: [self]
  │ │     │   │   │ │ │   👁️  Def: internal
  │ │     │   │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 32)
  │ │     │   │   │ │ │     💬 Args: [self._keys]
  │ │     │   │   │ │ │     👁️  Def: private
  │ │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 33)
  │ │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │ │     👁️  Def: private
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 34)
  │ │     │   │   │     💬 Args: [self]
  │ │     │   │   │     👁️  Def: internal
  │ │     │   │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 35)
  │ │     │   │   │   │   💬 Args: [self]
  │ │     │   │   │   │   👁️  Def: internal
  │ │     │   │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 36)
  │ │     │   │   │   │     💬 Args: [self._keys]
  │ │     │   │   │   │     👁️  Def: private
  │ │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 37)
  │ │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │       👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 38)
  │ │     │   │   │   💬 Args: [self, reads[i]]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 39)
  │ │     │   │   │ │   💬 Args: [self, slot, true]
  │ │     │   │   │ │   👁️  Def: internal
  │ │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 40)
  │ │     │   │   │ │     💬 Args: [self]
  │ │     │   │   │ │     👁️  Def: internal
  │ │     │   │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 41)
  │ │     │   │   │ │   │   💬 Args: [self]
  │ │     │   │   │ │   │   👁️  Def: internal
  │ │     │   │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 42)
  │ │     │   │   │ │   │     💬 Args: [self._keys]
  │ │     │   │   │ │   │     👁️  Def: private
  │ │     │   │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 43)
  │ │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │ │       👁️  Def: private
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 44)
  │ │     │   │   │     💬 Args: [self, slot, false]
  │ │     │   │   │     👁️  Def: internal
  │ │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 45)
  │ │     │   │   │       💬 Args: [self]
  │ │     │   │   │       👁️  Def: internal
  │ │     │   │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 46)
  │ │     │   │   │     │   💬 Args: [self]
  │ │     │   │   │     │   👁️  Def: internal
  │ │     │   │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 47)
  │ │     │   │   │     │     💬 Args: [self._keys]
  │ │     │   │   │     │     👁️  Def: private
  │ │     │   │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 48)
  │ │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │         👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 49)
  │ │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 50)
  │ │     │   │       💬 Args: [self]
  │ │     │   │       👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 51)
  │ │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 52)
  │ │     │   │     💬 Args: [offsetLeft, offsetRight]
  │ │     │   │     👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 53)
  │ │     │   │   💬 Args: [self]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 54)
  │ │     │   │ │   💬 Args: [self]
  │ │     │   │ │   👁️  Def: internal
  │ │     │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 55)
  │ │     │   │ │     💬 Args: [self._keys]
  │ │     │   │ │     👁️  Def: private
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 56)
  │ │     │   │     💬 Args: [rdat, 32 * self._depth]
  │ │     │   │     👁️  Def: private
  │ │     │   └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 57)
  │ │     │       💬 Args: [self]
  │ │     │       👁️  Def: internal
  │ │     │     └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 58)
  │ │     │         💬 Args: [self]
  │ │     │         👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 59)
  │ │     │   💬 Args: [stdstore, token]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 60)
  │ │     │     💬 Args: [self, _target]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 61)
  │ │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 62)
  │ │     │     💬 Args: [self, _sig]
  │ │     │     👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 63)
  │ │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 64)
  │ │           💬 Args: [self, bytes32(amt)]
  │ │           👁️  Def: internal
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 65)
  │ │         │   💬 Args: [self]
  │ │         │   👁️  Def: internal
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 66)
  │ │         │     💬 Args: [self._keys]
  │ │         │     👁️  Def: private
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 67)
  │ │         │   💬 Args: [self, false]
  │ │         │   👁️  Def: internal
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 68)
  │ │         │     💬 Args: [self, _clear]
  │ │         │     👁️  Def: internal
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 69)
  │ │         │   │   💬 Args: [self]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 70)
  │ │         │   │     💬 Args: [self._keys]
  │ │         │   │     👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 71)
  │ │         │   │   💬 Args: [self]
  │ │         │   │   👁️  Def: internal
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 72)
  │ │         │   │   💬 Args: [self]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 73)
  │ │         │   │ │   💬 Args: [self]
  │ │         │   │ │   👁️  Def: internal
  │ │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 74)
  │ │         │   │ │     💬 Args: [self._keys]
  │ │         │   │ │     👁️  Def: private
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 75)
  │ │         │   │     💬 Args: [rdat, 32 * self._depth]
  │ │         │   │     👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 76)
  │ │         │   │   💬 Args: [self, reads[i]]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 77)
  │ │         │   │ │   💬 Args: [self]
  │ │         │   │ │   👁️  Def: internal
  │ │         │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 78)
  │ │         │   │ │ │   💬 Args: [self]
  │ │         │   │ │ │   👁️  Def: internal
  │ │         │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 79)
  │ │         │   │ │ │     💬 Args: [self._keys]
  │ │         │   │ │ │     👁️  Def: private
  │ │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 80)
  │ │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │         │   │ │     👁️  Def: private
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 81)
  │ │         │   │     💬 Args: [self]
  │ │         │   │     👁️  Def: internal
  │ │         │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 82)
  │ │         │   │   │   💬 Args: [self]
  │ │         │   │   │   👁️  Def: internal
  │ │         │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 83)
  │ │         │   │   │     💬 Args: [self._keys]
  │ │         │   │   │     👁️  Def: private
  │ │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 84)
  │ │         │   │       💬 Args: [rdat, 32 * self._depth]
  │ │         │   │       👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 85)
  │ │         │   │   💬 Args: [self, reads[i]]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 86)
  │ │         │   │ │   💬 Args: [self, slot, true]
  │ │         │   │ │   👁️  Def: internal
  │ │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 87)
  │ │         │   │ │     💬 Args: [self]
  │ │         │   │ │     👁️  Def: internal
  │ │         │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 88)
  │ │         │   │ │   │   💬 Args: [self]
  │ │         │   │ │   │   👁️  Def: internal
  │ │         │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 89)
  │ │         │   │ │   │     💬 Args: [self._keys]
  │ │         │   │ │   │     👁️  Def: private
  │ │         │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 90)
  │ │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │         │   │ │       👁️  Def: private
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 91)
  │ │         │   │     💬 Args: [self, slot, false]
  │ │         │   │     👁️  Def: internal
  │ │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 92)
  │ │         │   │       💬 Args: [self]
  │ │         │   │       👁️  Def: internal
  │ │         │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 93)
  │ │         │   │     │   💬 Args: [self]
  │ │         │   │     │   👁️  Def: internal
  │ │         │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 94)
  │ │         │   │     │     💬 Args: [self._keys]
  │ │         │   │     │     👁️  Def: private
  │ │         │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 95)
  │ │         │   │         💬 Args: [rdat, 32 * self._depth]
  │ │         │   │         👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 96)
  │ │         │   │   💬 Args: [offsetLeft, offsetRight]
  │ │         │   │   👁️  Def: internal
  │ │         │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 97)
  │ │         │       💬 Args: [self]
  │ │         │       👁️  Def: internal
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 98)
  │ │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │         │   👁️  Def: internal
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 99)
  │ │         │     💬 Args: [offsetLeft, offsetRight]
  │ │         │     👁️  Def: internal
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 100)
  │ │         │   💬 Args: [self]
  │ │         │   👁️  Def: internal
  │ │         │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 101)
  │ │         │ │   💬 Args: [self]
  │ │         │ │   👁️  Def: internal
  │ │         │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 102)
  │ │         │ │     💬 Args: [self._keys]
  │ │         │ │     👁️  Def: private
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 103)
  │ │         │     💬 Args: [rdat, 32 * self._depth]
  │ │         │     👁️  Def: private
  │ │         └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 104)
  │ │             💬 Args: [self]
  │ │             👁️  Def: internal
  │ │           └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 105)
  │ │               💬 Args: [self]
  │ │               👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperVaultTest._deployNewSuperVaultWithRuggableVault(address) (NodeID: 106)
  │ │   💬 Args: [vars.ruggableVault]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._deployVault(string) (NodeID: 107)
  │ │ │   💬 Args: ["SV_USDC_RUG"]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: BaseSuperVaultTest._deployVault(address,string) (NodeID: 108)
  │ │ │     💬 Args: [address(asset), _superVaultSymbol]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 109)
  │ │ │   💬 Args: [ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getContract(uint64,string) (NodeID: 110)
  │ │ │   💬 Args: [ETH, ERC4626_YIELD_SOURCE_ORACLE_KEY]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 111)
  │ │     💬 Args: [address(strategy), address(vault)]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 112)
  │ │   │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │   │   👁️  Def: internal
  │ │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 113)
  │ │   │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │   │ │   👁️  Def: internal
  │ │   │ │ └─ [6] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 114)
  │ │   │ │     💬 Args: [rounding]
  │ │   │ │     👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 115)
  │ │   │     💬 Args: [x, y, denominator]
  │ │   │     👁️  Def: internal
  │ │   │   ├─ [6] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 116)
  │ │   │   │   💬 Args: [x, y]
  │ │   │   │   👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 117)
  │ │   │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │   │       👁️  Def: internal
  │ │   │     └─ [7] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 118)
  │ │   │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │   │         👁️  Def: internal
  │ │   │       └─ [8] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 119)
  │ │   │           💬 Args: [condition]
  │ │   │           👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 120)
  │ │   │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 121)
  │ │       💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 122)
  │ │         💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 123)
  │ │           💬 Args: [_sendLogPayloadView]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateRedeemSlippages(uint16) (NodeID: 124)
  │ │   💬 Args: [8000]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Helpers._getTokens(address,address,uint256) (NodeID: 125)
  │ │   💬 Args: [address(asset), vars.depositUsers[i], vars.depositAmounts[i]]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 126)
  │ │     💬 Args: [token_, to_, amount_]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 127)
  │ │       💬 Args: [token, to, give, false]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 128)
  │ │     │   💬 Args: [stdstore, token]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 129)
  │ │     │     💬 Args: [self, _target]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 130)
  │ │     │   💬 Args: [stdstore.target(token), 0x70a08231]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 131)
  │ │     │     💬 Args: [self, _sig]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 132)
  │ │     │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 133)
  │ │     │     💬 Args: [self, who]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 134)
  │ │     │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 135)
  │ │     │     💬 Args: [self, bytes32(amt)]
  │ │     │     👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 136)
  │ │     │   │   💬 Args: [self]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 137)
  │ │     │   │     💬 Args: [self._keys]
  │ │     │   │     👁️  Def: private
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 138)
  │ │     │   │   💬 Args: [self, false]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 139)
  │ │     │   │     💬 Args: [self, _clear]
  │ │     │   │     👁️  Def: internal
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 140)
  │ │     │   │   │   💬 Args: [self]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 141)
  │ │     │   │   │     💬 Args: [self._keys]
  │ │     │   │   │     👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 142)
  │ │     │   │   │   💬 Args: [self]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 143)
  │ │     │   │   │   💬 Args: [self]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 144)
  │ │     │   │   │ │   💬 Args: [self]
  │ │     │   │   │ │   👁️  Def: internal
  │ │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 145)
  │ │     │   │   │ │     💬 Args: [self._keys]
  │ │     │   │   │ │     👁️  Def: private
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 146)
  │ │     │   │   │     💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │     👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 147)
  │ │     │   │   │   💬 Args: [self, reads[i]]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 148)
  │ │     │   │   │ │   💬 Args: [self]
  │ │     │   │   │ │   👁️  Def: internal
  │ │     │   │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 149)
  │ │     │   │   │ │ │   💬 Args: [self]
  │ │     │   │   │ │ │   👁️  Def: internal
  │ │     │   │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 150)
  │ │     │   │   │ │ │     💬 Args: [self._keys]
  │ │     │   │   │ │ │     👁️  Def: private
  │ │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 151)
  │ │     │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │ │     👁️  Def: private
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 152)
  │ │     │   │   │     💬 Args: [self]
  │ │     │   │   │     👁️  Def: internal
  │ │     │   │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 153)
  │ │     │   │   │   │   💬 Args: [self]
  │ │     │   │   │   │   👁️  Def: internal
  │ │     │   │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 154)
  │ │     │   │   │   │     💬 Args: [self._keys]
  │ │     │   │   │   │     👁️  Def: private
  │ │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 155)
  │ │     │   │   │       💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │       👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 156)
  │ │     │   │   │   💬 Args: [self, reads[i]]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 157)
  │ │     │   │   │ │   💬 Args: [self, slot, true]
  │ │     │   │   │ │   👁️  Def: internal
  │ │     │   │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 158)
  │ │     │   │   │ │     💬 Args: [self]
  │ │     │   │   │ │     👁️  Def: internal
  │ │     │   │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 159)
  │ │     │   │   │ │   │   💬 Args: [self]
  │ │     │   │   │ │   │   👁️  Def: internal
  │ │     │   │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 160)
  │ │     │   │   │ │   │     💬 Args: [self._keys]
  │ │     │   │   │ │   │     👁️  Def: private
  │ │     │   │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 161)
  │ │     │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │ │       👁️  Def: private
  │ │     │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 162)
  │ │     │   │   │     💬 Args: [self, slot, false]
  │ │     │   │   │     👁️  Def: internal
  │ │     │   │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 163)
  │ │     │   │   │       💬 Args: [self]
  │ │     │   │   │       👁️  Def: internal
  │ │     │   │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 164)
  │ │     │   │   │     │   💬 Args: [self]
  │ │     │   │   │     │   👁️  Def: internal
  │ │     │   │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 165)
  │ │     │   │   │     │     💬 Args: [self._keys]
  │ │     │   │   │     │     👁️  Def: private
  │ │     │   │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 166)
  │ │     │   │   │         💬 Args: [rdat, 32 * self._depth]
  │ │     │   │   │         👁️  Def: private
  │ │     │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 167)
  │ │     │   │   │   💬 Args: [offsetLeft, offsetRight]
  │ │     │   │   │   👁️  Def: internal
  │ │     │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 168)
  │ │     │   │       💬 Args: [self]
  │ │     │   │       👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 169)
  │ │     │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 170)
  │ │     │   │     💬 Args: [offsetLeft, offsetRight]
  │ │     │   │     👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 171)
  │ │     │   │   💬 Args: [self]
  │ │     │   │   👁️  Def: internal
  │ │     │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 172)
  │ │     │   │ │   💬 Args: [self]
  │ │     │   │ │   👁️  Def: internal
  │ │     │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 173)
  │ │     │   │ │     💬 Args: [self._keys]
  │ │     │   │ │     👁️  Def: private
  │ │     │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 174)
  │ │     │   │     💬 Args: [rdat, 32 * self._depth]
  │ │     │   │     👁️  Def: private
  │ │     │   └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 175)
  │ │     │       💬 Args: [self]
  │ │     │       👁️  Def: internal
  │ │     │     └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 176)
  │ │     │         💬 Args: [self]
  │ │     │         👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 177)
  │ │     │   💬 Args: [stdstore, token]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 178)
  │ │     │     💬 Args: [self, _target]
  │ │     │     👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 179)
  │ │     │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 180)
  │ │     │     💬 Args: [self, _sig]
  │ │     │     👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 181)
  │ │         💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 182)
  │ │           💬 Args: [self, bytes32(amt)]
  │ │           👁️  Def: internal
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 183)
  │ │         │   💬 Args: [self]
  │ │         │   👁️  Def: internal
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 184)
  │ │         │     💬 Args: [self._keys]
  │ │         │     👁️  Def: private
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 185)
  │ │         │   💬 Args: [self, false]
  │ │         │   👁️  Def: internal
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 186)
  │ │         │     💬 Args: [self, _clear]
  │ │         │     👁️  Def: internal
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 187)
  │ │         │   │   💬 Args: [self]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 188)
  │ │         │   │     💬 Args: [self._keys]
  │ │         │   │     👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 189)
  │ │         │   │   💬 Args: [self]
  │ │         │   │   👁️  Def: internal
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 190)
  │ │         │   │   💬 Args: [self]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 191)
  │ │         │   │ │   💬 Args: [self]
  │ │         │   │ │   👁️  Def: internal
  │ │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 192)
  │ │         │   │ │     💬 Args: [self._keys]
  │ │         │   │ │     👁️  Def: private
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 193)
  │ │         │   │     💬 Args: [rdat, 32 * self._depth]
  │ │         │   │     👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 194)
  │ │         │   │   💬 Args: [self, reads[i]]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 195)
  │ │         │   │ │   💬 Args: [self]
  │ │         │   │ │   👁️  Def: internal
  │ │         │   │ │ ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 196)
  │ │         │   │ │ │   💬 Args: [self]
  │ │         │   │ │ │   👁️  Def: internal
  │ │         │   │ │ │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 197)
  │ │         │   │ │ │     💬 Args: [self._keys]
  │ │         │   │ │ │     👁️  Def: private
  │ │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 198)
  │ │         │   │ │     💬 Args: [rdat, 32 * self._depth]
  │ │         │   │ │     👁️  Def: private
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 199)
  │ │         │   │     💬 Args: [self]
  │ │         │   │     👁️  Def: internal
  │ │         │   │   ├─ [11] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 200)
  │ │         │   │   │   💬 Args: [self]
  │ │         │   │   │   👁️  Def: internal
  │ │         │   │   │ └─ [12] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 201)
  │ │         │   │   │     💬 Args: [self._keys]
  │ │         │   │   │     👁️  Def: private
  │ │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 202)
  │ │         │   │       💬 Args: [rdat, 32 * self._depth]
  │ │         │   │       👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 203)
  │ │         │   │   💬 Args: [self, reads[i]]
  │ │         │   │   👁️  Def: internal
  │ │         │   │ ├─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 204)
  │ │         │   │ │   💬 Args: [self, slot, true]
  │ │         │   │ │   👁️  Def: internal
  │ │         │   │ │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 205)
  │ │         │   │ │     💬 Args: [self]
  │ │         │   │ │     👁️  Def: internal
  │ │         │   │ │   ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 206)
  │ │         │   │ │   │   💬 Args: [self]
  │ │         │   │ │   │   👁️  Def: internal
  │ │         │   │ │   │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 207)
  │ │         │   │ │   │     💬 Args: [self._keys]
  │ │         │   │ │   │     👁️  Def: private
  │ │         │   │ │   └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 208)
  │ │         │   │ │       💬 Args: [rdat, 32 * self._depth]
  │ │         │   │ │       👁️  Def: private
  │ │         │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 209)
  │ │         │   │     💬 Args: [self, slot, false]
  │ │         │   │     👁️  Def: internal
  │ │         │   │   └─ [11] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 210)
  │ │         │   │       💬 Args: [self]
  │ │         │   │       👁️  Def: internal
  │ │         │   │     ├─ [12] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 211)
  │ │         │   │     │   💬 Args: [self]
  │ │         │   │     │   👁️  Def: internal
  │ │         │   │     │ └─ [13] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 212)
  │ │         │   │     │     💬 Args: [self._keys]
  │ │         │   │     │     👁️  Def: private
  │ │         │   │     └─ [12] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 213)
  │ │         │   │         💬 Args: [rdat, 32 * self._depth]
  │ │         │   │         👁️  Def: private
  │ │         │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 214)
  │ │         │   │   💬 Args: [offsetLeft, offsetRight]
  │ │         │   │   👁️  Def: internal
  │ │         │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 215)
  │ │         │       💬 Args: [self]
  │ │         │       👁️  Def: internal
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 216)
  │ │         │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │ │         │   👁️  Def: internal
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 217)
  │ │         │     💬 Args: [offsetLeft, offsetRight]
  │ │         │     👁️  Def: internal
  │ │         ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 218)
  │ │         │   💬 Args: [self]
  │ │         │   👁️  Def: internal
  │ │         │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 219)
  │ │         │ │   💬 Args: [self]
  │ │         │ │   👁️  Def: internal
  │ │         │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 220)
  │ │         │ │     💬 Args: [self._keys]
  │ │         │ │     👁️  Def: private
  │ │         │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 221)
  │ │         │     💬 Args: [rdat, 32 * self._depth]
  │ │         │     👁️  Def: private
  │ │         └─ [7] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 222)
  │ │             💬 Args: [self]
  │ │             👁️  Def: internal
  │ │           └─ [8] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 223)
  │ │               💬 Args: [self]
  │ │               👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._depositFreeAssets(uint256,uint256,address,address) (NodeID: 224)
  │ │   💬 Args: [(vars.depositAmount * 5) / 2, (vars.depositAmount * 5) / 2, address(fluidVault), vars.ruggableVault]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 225)
  │ │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 226)
  │ │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(asset), allocationAmountVault1, false, address(0), 0]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 227)
  │ │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 228)
  │ │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(asset), allocationAmountVault2, false, address(0), 0]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 229)
  │ │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 230)
  │ │     💬 Args: [fulfillHooksAddresses, argsForProofs]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 231)
  │ │   💬 Args: ["\n=== TIME WARPING ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 232)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 233)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 234)
  │ │   💬 Args: ["PPS BEFORE WARP", vars.ppsBeforeWarp]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 235)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 236)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 237)
  │ │   💬 Args: [address(strategy), address(vault)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 238)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 239)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 240)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 241)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 242)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 243)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 244)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 245)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 246)
  │ │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 247)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 248)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 249)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 250)
  │ │   💬 Args: ["PPS AFTER WARP", vars.ppsAfterWarp]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 251)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 252)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 253)
  │ │   💬 Args: [vars.initialTotalAssets, 1e18, vars.initialTotalSupply, Math.Rounding.Floor]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 254)
  │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 255)
  │ │ │     💬 Args: [rounding]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 256)
  │ │     💬 Args: [x, y, denominator]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 257)
  │ │   │   💬 Args: [x, y]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 258)
  │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 259)
  │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 260)
  │ │           💬 Args: [condition]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 261)
  │ │   💬 Args: ["\n=== Initial State Before Redemption ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 262)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 263)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 264)
  │ │   💬 Args: ["Initial Total Assets:", vars.initialTotalAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 265)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 266)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 267)
  │ │   💬 Args: ["Initial Total Supply:", vars.initialTotalSupply]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 268)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 269)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 270)
  │ │   💬 Args: ["Initial Price per share:", vars.initialPricePerShare]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 271)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 272)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 273)
  │ │   💬 Args: ["Ruggable Vault Balance:", IERC4626(vars.ruggableVault).balanceOf(address(strategy))]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 274)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 275)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 276)
  │ │   💬 Args: ["Fluid Vault Balance:", fluidVault.balanceOf(address(strategy))]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 277)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 278)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 279)
  │ │   💬 Args: [vars.initialTotalAssets, 0, "Initial total assets should be positive"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 280)
  │ │   💬 Args: [vars.initialTotalSupply, 0, "Initial total supply should be positive"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 281)
  │ │   💬 Args: ["\n=== TIME WARPING ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 282)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 283)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 284)
  │ │   💬 Args: ["PPS BEFORE WARP", vars.ppsBeforeWarp]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 285)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 286)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._updateSuperVaultPPS(address,address) (NodeID: 287)
  │ │   💬 Args: [address(strategy), address(vault)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 288)
  │ │ │   💬 Args: [vars.currentTotalAssets, vars.precision, vars.totalSupplyAmount, Math.Rounding.Floor]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 289)
  │ │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 290)
  │ │ │ │     💬 Args: [rounding]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 291)
  │ │ │     💬 Args: [x, y, denominator]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 292)
  │ │ │   │   💬 Args: [x, y]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 293)
  │ │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 294)
  │ │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │ │         👁️  Def: internal
  │ │ │       └─ [7] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 295)
  │ │ │           💬 Args: [condition]
  │ │ │           👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MessageHashUtils.toTypedDataHash(bytes32,bytes32) (NodeID: 296)
  │ │ │   💬 Args: [ecdsappsOracle.domainSeparator(), structHash]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: console.log(string,address,uint256) (NodeID: 297)
  │ │     💬 Args: ["Updated PPS for strategy", strategyAddr, vars.pps]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 298)
  │ │       💬 Args: [abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 299)
  │ │         💬 Args: [_sendLogPayloadView]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 300)
  │ │   💬 Args: ["PPS AFTER WARP", vars.ppsAfterWarp]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 301)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 302)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._executeRedeemHooks4626ForUsers(address[],uint256,uint256,address,address,uint256[],bytes4) (NodeID: 303)
  │ │   💬 Args: [vars.redeemUsers, vars.redeemSharesVault1, vars.redeemSharesVault2, address(fluidVault), vars.ruggableVault, vars.expectedAssetsOrSharesOut, ISuperVaultStrategy.MINIMUM_OUTPUT_AMOUNT_ASSETS_NOT_MET.selector]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._convertSVSharestoUnderlyingVaultShares(uint256,address) (NodeID: 304)
  │ │ │   💬 Args: [redeemSharesVault1, vault1]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._convertSVSharestoUnderlyingVaultShares(uint256,address) (NodeID: 305)
  │ │ │   💬 Args: [redeemSharesVault2, vault2]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._truncateToActualBalance(uint256,address,uint256) (NodeID: 306)
  │ │ │   💬 Args: [vars.underlyingSharesVault1, vault1, 100]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 307)
  │ │ │ │   💬 Args: ["no truncation of balance of shares"]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 308)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 309)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 310)
  │ │ │ │   💬 Args: ["---"]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 311)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 312)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,address) (NodeID: 313)
  │ │ │ │   💬 Args: ["vault", underlyingVault]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 314)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 315)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 316)
  │ │ │ │   💬 Args: ["minAcceptableBalance", minAcceptableBalance]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 317)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 318)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 319)
  │ │ │ │   💬 Args: ["actualBalance", actualBalance]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 320)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 321)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 322)
  │ │ │ │   💬 Args: [toleranceBps]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 323)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 324)
  │ │ │ │   💬 Args: ["truncated value", truncatedValue]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 325)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 326)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 327)
  │ │ │     💬 Args: ["---"]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 328)
  │ │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 329)
  │ │ │         💬 Args: [_sendLogPayloadView]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._truncateToActualBalance(uint256,address,uint256) (NodeID: 330)
  │ │ │   💬 Args: [vars.underlyingSharesVault2, vault2, 100]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 331)
  │ │ │ │   💬 Args: ["no truncation of balance of shares"]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 332)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 333)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 334)
  │ │ │ │   💬 Args: ["---"]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 335)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 336)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,address) (NodeID: 337)
  │ │ │ │   💬 Args: ["vault", underlyingVault]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 338)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 339)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 340)
  │ │ │ │   💬 Args: ["minAcceptableBalance", minAcceptableBalance]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 341)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 342)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 343)
  │ │ │ │   💬 Args: ["actualBalance", actualBalance]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 344)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 345)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 346)
  │ │ │ │   💬 Args: [toleranceBps]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 347)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 348)
  │ │ │ │   💬 Args: ["truncated value", truncatedValue]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 349)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 350)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 351)
  │ │ │     💬 Args: ["---"]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 352)
  │ │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 353)
  │ │ │         💬 Args: [_sendLogPayloadView]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 354)
  │ │ │   💬 Args: [ETH, REDEEM_4626_VAULT_HOOK_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InternalHelpers._createRedeem4626HookData(bytes32,address,address,uint256,bool) (NodeID: 355)
  │ │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(strategy), vars.underlyingSharesVault1, false]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 356)
  │ │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InternalHelpers._createRedeem4626HookData(bytes32,address,address,uint256,bool) (NodeID: 357)
  │ │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(strategy), vars.underlyingSharesVault2, false]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 358)
  │ │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 359)
  │ │ │   💬 Args: [vars.fulfillHooksAddresses, vars.argsForProofs]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._sortAndUniqueControllers(address[]) (NodeID: 360)
  │ │ │   💬 Args: [requestingUsers]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: LibSort.insertionSort(address[]) (NodeID: 361)
  │ │ │ │   💬 Args: [controllers]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: LibSort.insertionSort(uint256[]) (NodeID: 362)
  │ │ │ │     💬 Args: [_toUints(a)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 363)
  │ │ │ │       💬 Args: [a]
  │ │ │ │       👁️  Def: private
  │ │ │ └─ [4] ⚙️ FUNCTION: LibSort.uniquifySorted(address[]) (NodeID: 364)
  │ │ │     💬 Args: [controllers]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: LibSort.uniquifySorted(uint256[]) (NodeID: 365)
  │ │ │       💬 Args: [_toUints(a)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 366)
  │ │ │         💬 Args: [a]
  │ │ │         👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[]) (NodeID: 367)
  │ │     💬 Args: [strategy, requestingUsers, expectedAssetsOrSharesOut]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 368)
  │ │   │   💬 Args: ["Available from hooks [index %s]: %s", i, expectedAssetsFromHooks[i]]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 369)
  │ │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 370)
  │ │   │       💬 Args: [_sendLogPayloadView]
  │ │   │       👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256) (NodeID: 371)
  │ │       💬 Args: [controllers, theoreticalAssets, totalTheoreticalAssets, totalAvailableAssets]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 372)
  │ │     │   💬 Args: ["Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 373)
  │ │     │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │ │     │     👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 374)
  │ │     │       💬 Args: [_sendLogPayloadView]
  │ │     │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 375)
  │ │     │   💬 Args: [theoreticalAssets[i], totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor]
  │ │     │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 376)
  │ │     │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 377)
  │ │     │ │     💬 Args: [rounding]
  │ │     │ │     👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 378)
  │ │     │     💬 Args: [x, y, denominator]
  │ │     │     👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 379)
  │ │     │   │   💬 Args: [x, y]
  │ │     │   │   👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 380)
  │ │     │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     │       👁️  Def: internal
  │ │     │     └─ [8] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 381)
  │ │     │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │     │         👁️  Def: internal
  │ │     │       └─ [9] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 382)
  │ │     │           💬 Args: [condition]
  │ │     │           👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 383)
  │ │         💬 Args: ["Remainder kept in vault as free assets:", remainder]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 384)
  │ │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 385)
  │ │             💬 Args: [_sendLogPayloadView]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseSuperVaultTest._executeRedeemHooks4626ForUsers(address[],uint256,uint256,address,address,uint256[],bytes4) (NodeID: 386)
  │ │   💬 Args: [vars.redeemUsers, vars.redeemSharesVault1, vars.redeemSharesVault2, address(fluidVault), vars.ruggableVault, vars.expectedAssetsOrSharesOut, bytes4(0)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._convertSVSharestoUnderlyingVaultShares(uint256,address) (NodeID: 387)
  │ │ │   💬 Args: [redeemSharesVault1, vault1]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._convertSVSharestoUnderlyingVaultShares(uint256,address) (NodeID: 388)
  │ │ │   💬 Args: [redeemSharesVault2, vault2]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._truncateToActualBalance(uint256,address,uint256) (NodeID: 389)
  │ │ │   💬 Args: [vars.underlyingSharesVault1, vault1, 100]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 390)
  │ │ │ │   💬 Args: ["no truncation of balance of shares"]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 391)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 392)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 393)
  │ │ │ │   💬 Args: ["---"]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 394)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 395)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,address) (NodeID: 396)
  │ │ │ │   💬 Args: ["vault", underlyingVault]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 397)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 398)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 399)
  │ │ │ │   💬 Args: ["minAcceptableBalance", minAcceptableBalance]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 400)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 401)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 402)
  │ │ │ │   💬 Args: ["actualBalance", actualBalance]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 403)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 404)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 405)
  │ │ │ │   💬 Args: [toleranceBps]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 406)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 407)
  │ │ │ │   💬 Args: ["truncated value", truncatedValue]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 408)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 409)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 410)
  │ │ │     💬 Args: ["---"]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 411)
  │ │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 412)
  │ │ │         💬 Args: [_sendLogPayloadView]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._truncateToActualBalance(uint256,address,uint256) (NodeID: 413)
  │ │ │   💬 Args: [vars.underlyingSharesVault2, vault2, 100]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 414)
  │ │ │ │   💬 Args: ["no truncation of balance of shares"]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 415)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 416)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 417)
  │ │ │ │   💬 Args: ["---"]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 418)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 419)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,address) (NodeID: 420)
  │ │ │ │   💬 Args: ["vault", underlyingVault]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 421)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 422)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 423)
  │ │ │ │   💬 Args: ["minAcceptableBalance", minAcceptableBalance]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 424)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 425)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 426)
  │ │ │ │   💬 Args: ["actualBalance", actualBalance]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 427)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 428)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 429)
  │ │ │ │   💬 Args: [toleranceBps]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 430)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 431)
  │ │ │ │   💬 Args: ["truncated value", truncatedValue]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 432)
  │ │ │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 433)
  │ │ │ │       💬 Args: [_sendLogPayloadView]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: console.log(string) (NodeID: 434)
  │ │ │     💬 Args: ["---"]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 435)
  │ │ │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 436)
  │ │ │         💬 Args: [_sendLogPayloadView]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 437)
  │ │ │   💬 Args: [ETH, REDEEM_4626_VAULT_HOOK_KEY]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InternalHelpers._createRedeem4626HookData(bytes32,address,address,uint256,bool) (NodeID: 438)
  │ │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault1, address(strategy), vars.underlyingSharesVault1, false]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 439)
  │ │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: InternalHelpers._createRedeem4626HookData(bytes32,address,address,uint256,bool) (NodeID: 440)
  │ │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER), vault2, address(strategy), vars.underlyingSharesVault2, false]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 441)
  │ │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), MANAGER]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 442)
  │ │ │   💬 Args: [vars.fulfillHooksAddresses, vars.argsForProofs]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: BaseSuperVaultTest._sortAndUniqueControllers(address[]) (NodeID: 443)
  │ │ │   💬 Args: [requestingUsers]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: LibSort.insertionSort(address[]) (NodeID: 444)
  │ │ │ │   💬 Args: [controllers]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: LibSort.insertionSort(uint256[]) (NodeID: 445)
  │ │ │ │     💬 Args: [_toUints(a)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 446)
  │ │ │ │       💬 Args: [a]
  │ │ │ │       👁️  Def: private
  │ │ │ └─ [4] ⚙️ FUNCTION: LibSort.uniquifySorted(address[]) (NodeID: 447)
  │ │ │     💬 Args: [controllers]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: LibSort.uniquifySorted(uint256[]) (NodeID: 448)
  │ │ │       💬 Args: [_toUints(a)]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: LibSort._toUints(address[]) (NodeID: 449)
  │ │ │         💬 Args: [a]
  │ │ │         👁️  Def: private
  │ │ └─ [3] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateAdjustedFulfillment(contract ISuperVaultStrategy,address[],uint256[]) (NodeID: 450)
  │ │     💬 Args: [strategy, requestingUsers, expectedAssetsOrSharesOut]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 451)
  │ │   │   💬 Args: ["Available from hooks [index %s]: %s", i, expectedAssetsFromHooks[i]]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 452)
  │ │   │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 453)
  │ │   │       💬 Args: [_sendLogPayloadView]
  │ │   │       👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: AssetAdjustmentHelper.calculateFulfillRedeemTotalAssetsOut(address[],uint256[],uint256,uint256) (NodeID: 454)
  │ │       💬 Args: [controllers, theoreticalAssets, totalTheoreticalAssets, totalAvailableAssets]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: console.log(string,uint256,uint256) (NodeID: 455)
  │ │     │   💬 Args: ["Adjusting assets: Theoretical=%s, Available=%s", totalTheoreticalAssets, totalAvailableAssets]
  │ │     │   👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 456)
  │ │     │     💬 Args: [abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2)]
  │ │     │     👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 457)
  │ │     │       💬 Args: [_sendLogPayloadView]
  │ │     │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 458)
  │ │     │   💬 Args: [theoreticalAssets[i], totalAvailableAssets, totalTheoreticalAssets, Math.Rounding.Floor]
  │ │     │   👁️  Def: internal
  │ │     │ ├─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 459)
  │ │     │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │     │ │   👁️  Def: internal
  │ │     │ │ └─ [7] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 460)
  │ │     │ │     💬 Args: [rounding]
  │ │     │ │     👁️  Def: internal
  │ │     │ └─ [6] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 461)
  │ │     │     💬 Args: [x, y, denominator]
  │ │     │     👁️  Def: internal
  │ │     │   ├─ [7] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 462)
  │ │     │   │   💬 Args: [x, y]
  │ │     │   │   👁️  Def: internal
  │ │     │   └─ [7] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 463)
  │ │     │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │     │       👁️  Def: internal
  │ │     │     └─ [8] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 464)
  │ │     │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │     │         👁️  Def: internal
  │ │     │       └─ [9] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 465)
  │ │     │           💬 Args: [condition]
  │ │     │           👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 466)
  │ │         💬 Args: ["Remainder kept in vault as free assets:", remainder]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 467)
  │ │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │           👁️  Def: internal
  │ │         └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 468)
  │ │             💬 Args: [_sendLogPayloadView]
  │ │             👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 469)
  │ │   💬 Args: ["\n=== Post-Fulfillment State ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 470)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 471)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 472)
  │ │   💬 Args: ["Total Assets:", vars.totalAssetsPreClaimTaintedAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 473)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 474)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 475)
  │ │   💬 Args: ["Total Supply:", vars.totalSupplyPreClaimTaintedAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 476)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 477)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 478)
  │ │   💬 Args: [vars.totalAssetsPreClaimTaintedAssets, 1e18, vars.totalSupplyPreClaimTaintedAssets, Math.Rounding.Floor]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 479)
  │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 480)
  │ │ │     💬 Args: [rounding]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 481)
  │ │     💬 Args: [x, y, denominator]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 482)
  │ │   │   💬 Args: [x, y]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 483)
  │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 484)
  │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 485)
  │ │           💬 Args: [condition]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 486)
  │ │   💬 Args: ["Price per share:", vars.pricePerSharePreClaimTaintedAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 487)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 488)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 489)
  │ │   💬 Args: ["Ruggable Vault Balance:", IERC4626(vars.ruggableVault).balanceOf(address(strategy))]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 490)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 491)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 492)
  │ │   💬 Args: ["Fluid Vault Balance:", fluidVault.balanceOf(address(strategy))]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 493)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 494)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 495)
  │ │   💬 Args: [vars.finalTotalAssets, 1e18, vars.finalTotalSupply, Math.Rounding.Floor]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 496)
  │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 497)
  │ │ │     💬 Args: [rounding]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 498)
  │ │     💬 Args: [x, y, denominator]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 499)
  │ │   │   💬 Args: [x, y]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 500)
  │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 501)
  │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 502)
  │ │           💬 Args: [condition]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 503)
  │ │   💬 Args: ["\n=== Final State ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 504)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 505)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 506)
  │ │   💬 Args: ["Final Total Assets:", vars.finalTotalAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 507)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 508)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 509)
  │ │   💬 Args: ["Final Total Supply:", vars.finalTotalSupply]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 510)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 511)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 512)
  │ │   💬 Args: ["Final Price per share:", finalPricePerShare]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 513)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 514)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 515)
  │ │   💬 Args: ["\n=== Allocating from Rugged Vault back to Fluid Vault ==="]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 516)
  │ │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 517)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 518)
  │ │   💬 Args: ["Initial Ruggable Vault balance:", vars.initialRuggableVaultBalance]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 519)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 520)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 521)
  │ │   💬 Args: ["Initial Fluid Vault balance:", vars.initialFluidVaultBalance]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 522)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 523)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 524)
  │ │   💬 Args: ["Initial Ruggable Vault assets:", vars.initialRuggableVaultAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 525)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 526)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 527)
  │ │   💬 Args: ["Initial Fluid Vault assets:", vars.initialFluidVaultAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 528)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 529)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 530)
  │ │   💬 Args: ["Shares to reallocate from Ruggable Vault:", vars.amountToReallocate]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 531)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 532)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 533)
  │ │   💬 Args: ["Asset amount to reallocate:", vars.assetAmountToReallocate]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 534)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 535)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 536)
  │ │   💬 Args: [ETH, REDEEM_4626_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: BaseTest._getHookAddress(uint64,string) (NodeID: 537)
  │ │   💬 Args: [ETH, APPROVE_AND_DEPOSIT_4626_VAULT_HOOK_KEY]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createRedeem4626HookData(bytes32,address,address,uint256,bool) (NodeID: 538)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)), vars.ruggableVault, address(strategy), vars.amountToReallocate, false]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 539)
  │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: InternalHelpers._createApproveAndDeposit4626HookData(bytes32,address,address,uint256,bool,address,uint256) (NodeID: 540)
  │ │   💬 Args: [_getYieldSourceOracleId(bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)), address(fluidVault), address(asset), vars.assetAmountToReallocate, false, address(0), 0]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: InternalHelpers._getYieldSourceOracleId(bytes32,address) (NodeID: 541)
  │ │     💬 Args: [bytes32(bytes(ERC4626_YIELD_SOURCE_ORACLE_KEY)), address(this)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MerkleReader._getMerkleProofsForHooks(address[],bytes[]) (NodeID: 542)
  │ │   💬 Args: [hooksAddresses, argsForProofs]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 543)
  │ │   💬 Args: ["Final Ruggable Vault balance:", vars.finalRuggableVaultBalance]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 544)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 545)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 546)
  │ │   💬 Args: ["Final Fluid Vault balance:", vars.finalFluidVaultBalance]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 547)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 548)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 549)
  │ │   💬 Args: ["Final Ruggable Vault assets:", vars.finalRuggableVaultAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 550)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 551)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 552)
  │ │   💬 Args: ["Final Fluid Vault assets:", vars.finalFluidVaultAssets]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 553)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 554)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertApproxEqRel(uint256,uint256,uint256,string) (NodeID: 555)
  │ │   💬 Args: [vars.finalRuggableVaultBalance, vars.initialRuggableVaultBalance - vars.amountToReallocate, 0.01e18, "Ruggable Vault balance should decrease by the reallocated amount"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 556)
  │ │   💬 Args: [vars.finalFluidVaultBalance, vars.initialFluidVaultBalance, "Fluid Vault balance should increase"]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 557)
  │ │   💬 Args: ["Initial total value:", vars.initialTotalValue]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 558)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 559)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 560)
  │ │   💬 Args: ["Final total value:", vars.finalTotalValue]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 561)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 562)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256,enum Math.Rounding) (NodeID: 563)
  │ │   💬 Args: [vars.vaultTotalAssetsAfterAllocation, 1e18, vars.finalTotalSupply, Math.Rounding.Floor]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 564)
  │ │ │   💬 Args: [unsignedRoundsUp(rounding) && (mulmod(x, y, denominator) > 0)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.unsignedRoundsUp(enum Math.Rounding) (NodeID: 565)
  │ │ │     💬 Args: [rounding]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.mulDiv(uint256,uint256,uint256) (NodeID: 566)
  │ │     💬 Args: [x, y, denominator]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Math.mul512(uint256,uint256) (NodeID: 567)
  │ │   │   💬 Args: [x, y]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Panic.panic(uint256) (NodeID: 568)
  │ │       💬 Args: [ternary(denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW)]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: Math.ternary(bool,uint256,uint256) (NodeID: 569)
  │ │         💬 Args: [denominator == 0, Panic.DIVISION_BY_ZERO, Panic.UNDER_OVERFLOW]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: SafeCast.toUint(bool) (NodeID: 570)
  │ │           💬 Args: [condition]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 571)
  │ │   💬 Args: ["Vault total assets after allocation:", vars.vaultTotalAssetsAfterAllocation]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 572)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 573)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 574)
  │ │   💬 Args: ["Price per share after allocation:", vars.pricePerShareAfterAllocation]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 575)
  │ │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 576)
  │ │       💬 Args: [_sendLogPayloadView]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: console.log(string) (NodeID: 577)
  │     💬 Args: ["Skipping reallocation as there are no shares to reallocate"]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 578)
  │       💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 579)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 580)
  │   💬 Args: ["Ruggable vault total assets:", vaultTotalAssets]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 581)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 582)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 583)
  │   💬 Args: ["Ruggable total assets (rug disabled):", vaultTotalAssetsWithoutRug]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 584)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 585)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 586)
  │   💬 Args: ["Difference:", vaultTotalAssets - vaultTotalAssetsWithoutRug]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 587)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 588)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 589)
      💬 Args: [vaultTotalAssets, vaultTotalAssetsWithoutRug, "SuperVault total assets should be higher with rug enabled"]
      👁️  Def: internal
```
