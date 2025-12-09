# Function: test_MultipleProviderRemoval()

**Contract**: [test/oracles/SuperOracle.t.sol/contract_SuperOracleTest.md]

## Metadata

- **Contract**: SuperOracleTest
- **Signature**: `test_MultipleProviderRemoval()`
- **Visibility**: public
- **Source Range**: 27071:1997:624

## Implementation

```solidity
function test_MultipleProviderRemoval() public {
    bytes32[] memory providersToRemove = new bytes32[](2);
    providersToRemove[0] = PROVIDER_1;
    providersToRemove[1] = PROVIDER_2;
    superOracle.queueProviderRemoval(providersToRemove);
    vm.warp((block.timestamp + 1 hours) + 1 seconds);
    mockFeed3.setUpdatedAt(block.timestamp);
    superOracle.executeProviderRemoval();
    bytes32[] memory activeProviders = superOracle.getActiveProviders();
    assertEq(activeProviders.length, 1, "Should have 1 provider after removal");
    assertEq(activeProviders[0], PROVIDER_3, "Only Provider 3 should remain");
    vm.expectRevert(ISuperOracle.INVALID_ORACLE_PROVIDER.selector);
    superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_1);
    vm.expectRevert(ISuperOracle.INVALID_ORACLE_PROVIDER.selector);
    superOracle.getOracleAddress(address(mockETH), address(mockUSD), PROVIDER_2);
    bool isProvider1Set = superOracle.isProviderSet(PROVIDER_1);
    bool isProvider2Set = superOracle.isProviderSet(PROVIDER_2);
    assertEq(isProvider1Set, false, "Provider 1 should not be set");
    assertEq(isProvider2Set, false, "Provider 2 should not be set");
    (uint256 quoteAmount, , , ) = superOracle.getQuoteFromProvider(1e18, address(mockETH), address(mockUSD), PROVIDER_3);
    assertEq(quoteAmount, 0.9e6, "Quote should be $900 from Provider 3");
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

### assertEq(bytes32,bytes32,string)

- **Kind**: internal
- **Source**: 4521:177:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes32,bytes32,string)`

```solidity
function assertEq(bytes32 left, bytes32 right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2487:171:12
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    if (left != right) {
        vm.assertEq(left, right, err);
    }
}
```

## External Calls

- **SuperOracle::queueProviderRemoval(bytes32[])**
- **Vm::warp(uint256)**
- **MockAggregator::setUpdatedAt(uint256)**
- **SuperOracle::executeProviderRemoval()**
- **SuperOracle::getActiveProviders()**
- **Vm::expectRevert(bytes4)**
- **SuperOracle::getOracleAddress(address,address,bytes32)**
- **SuperOracle::isProviderSet(bytes32)**
- **SuperOracle::getQuoteFromProvider(uint256,address,address,bytes32)**

## State Variable Reads

- **PROVIDER_1** (`bytes32`)
- **PROVIDER_2** (`bytes32`)
- **superOracle** (`contract SuperOracle`) [src/oracles/SuperOracle.sol/contract_SuperOracle.md]
- **mockFeed3** (`contract MockAggregator`) [test/mocks/MockAggregator.sol/contract_MockAggregator.md]
- **PROVIDER_3** (`bytes32`)
- **mockETH** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **mockUSD** (`contract MockERC20`) [test/mocks/MockERC20.sol/contract_MockERC20.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperOracleTest.test_MultipleProviderRemoval() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [activeProviders.length, 1, "Should have 1 provider after removal"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes32,bytes32,string) (NodeID: 2)
  │   💬 Args: [activeProviders[0], PROVIDER_3, "Only Provider 3 should remain"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 3)
  │   💬 Args: [isProvider1Set, false, "Provider 1 should not be set"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 4)
  │   💬 Args: [isProvider2Set, false, "Provider 2 should not be set"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [quoteAmount, 0.9e6, "Quote should be $900 from Provider 3"]
      👁️  Def: internal
```
