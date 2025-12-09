# Function: createAccount(bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/safe/SafeFactory.sol/contract_SafeFactory.md]

## Metadata

- **Contract**: SafeFactory
- **Signature**: `createAccount(bytes32,bytes)`
- **Visibility**: public
- **Source Range**: 1291:637:173

## Implementation

```solidity
function createAccount(bytes32 salt, bytes memory initCode) override public returns (address safe) {
    ISafe7579Launchpad.InitData memory initData = abi.decode(initCode, (ISafe7579Launchpad.InitData));
    bytes32 initHash = launchpad.hash(initData);
    bytes memory factoryInitializer = abi.encodeCall(ISafe7579Launchpad.preValidationSetup, (initHash, address(0), ""));
    safe = address(safeProxyFactory.createProxyWithNonce(address(launchpad), factoryInitializer, uint256(salt)));
}
```

## External Calls

- **ISafe7579Launchpad::hash(struct ISafe7579Launchpad.InitData)**
- **ISafeProxyFactory::createProxyWithNonce(address,bytes,uint256)**

## State Variable Reads

- **launchpad** (`contract ISafe7579Launchpad`) [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafe7579Launchpad.sol/interface_ISafe7579Launchpad.md]
- **safeProxyFactory** (`contract ISafeProxyFactory`) [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafeProxyFactory.sol/interface_ISafeProxyFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeFactory.createAccount(bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
