# Function: getAddress(bytes32,bytes)

**Contract**: [lib/v2-core/lib/modulekit/src/accounts/safe/SafeFactory.sol/contract_SafeFactory.md]

## Metadata

- **Contract**: SafeFactory
- **Signature**: `getAddress(bytes32,bytes)`
- **Visibility**: public
- **Source Range**: 1934:752:173

## Implementation

```solidity
function getAddress(bytes32 salt, bytes memory initCode) override public view returns (address) {
    ISafe7579Launchpad.InitData memory initData = abi.decode(initCode, (ISafe7579Launchpad.InitData));
    bytes32 initHash = launchpad.hash(initData);
    bytes memory factoryInitializer = abi.encodeCall(ISafe7579Launchpad.preValidationSetup, (initHash, address(0), ""));
    return launchpad.predictSafeAddress({singleton: address(launchpad), safeProxyFactory: address(safeProxyFactory), creationCode: SAFE_PROXY_BYTECODE, salt: salt, factoryInitializer: factoryInitializer});
}
```

## External Calls

- **ISafe7579Launchpad::hash(struct ISafe7579Launchpad.InitData)**
- **ISafe7579Launchpad::predictSafeAddress(address,address,bytes,bytes32,bytes)**

## State Variable Reads

- **launchpad** (`contract ISafe7579Launchpad`) [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafe7579Launchpad.sol/interface_ISafe7579Launchpad.md]
- **safeProxyFactory** (`contract ISafeProxyFactory`) [lib/v2-core/lib/modulekit/src/accounts/safe/interfaces/ISafeProxyFactory.sol/interface_ISafeProxyFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeFactory.getAddress(bytes32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
