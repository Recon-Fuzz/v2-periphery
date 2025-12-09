# Function: test_batchDistributeRewardsToSuperBank()

**Contract**: [test/draft/test/unit/VaultBank.t.sol/contract_VaultBankTest.md]

## Metadata

- **Contract**: VaultBankTest
- **Signature**: `test_batchDistributeRewardsToSuperBank()`
- **Visibility**: public
- **Source Range**: 62098:1575:570

## Implementation

```solidity
function test_batchDistributeRewardsToSuperBank() public {
    address[] memory tokens = new address[](2);
    tokens[0] = address(token);
    tokens[1] = address(otherToken);
    uint256[] memory amounts = new uint256[](2);
    amounts[0] = 100 ether;
    amounts[1] = 50 ether;
    address mockSuperBank = address(0x9999);
    token.mint(address(vaultBank), amounts[0]);
    otherToken.mint(address(vaultBank), amounts[1]);
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("isSuperBank(address)", mockSuperBank), abi.encode(true));
    vm.mockCall(address(superRegistry), abi.encodeWithSignature("isRelayer(address)", address(this)), abi.encode(true));
    vm.mockCall(address(superGovernor), abi.encodeWithSignature("getAddress(bytes32)", keccak256("SUPER_BANK")), abi.encode(mockSuperBank));
    uint256 initialTokenBalance = token.balanceOf(mockSuperBank);
    uint256 initialOtherTokenBalance = otherToken.balanceOf(mockSuperBank);
    vaultBank.batchDistributeRewardsToSuperBank(tokens, amounts);
    assertEq(token.balanceOf(mockSuperBank), initialTokenBalance + amounts[0], "Token reward amount should be distributed to SuperBank");
    assertEq(otherToken.balanceOf(mockSuperBank), initialOtherTokenBalance + amounts[1], "Other token reward amount should be distributed to SuperBank");
}
```

## Related Implementations

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

## External Calls

- **MockERC20::mint(address,uint256)**
- **Vm::mockCall(address,bytes,bytes)**
- **MockERC20::balanceOf(address)**
- **TestVaultBank::batchDistributeRewardsToSuperBank(address[],uint256[])**

## State Variable Reads

- **token** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **otherToken** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vaultBank** (`contract TestVaultBank`) [test/draft/test/unit/VaultBank.t.sol/contract_TestVaultBank.md]
- **superGovernor** (`contract SuperGovernor`) [src/SuperGovernor.sol/contract_SuperGovernor.md]
- **superRegistry** (`contract SuperRegistry`) [test/draft/src/SuperRegistry.sol/contract_SuperRegistry.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: VaultBankTest.test_batchDistributeRewardsToSuperBank() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [token.balanceOf(mockSuperBank), initialTokenBalance + amounts[0], "Token reward amount should be distributed to SuperBank"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [otherToken.balanceOf(mockSuperBank), initialOtherTokenBalance + amounts[1], "Other token reward amount should be distributed to SuperBank"]
      👁️  Def: internal
```
