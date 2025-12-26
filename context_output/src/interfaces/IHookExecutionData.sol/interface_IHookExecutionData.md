# Interface: IHookExecutionData

## Metadata

- **Name**: IHookExecutionData
- **Type**: Interface
- **Path**: src/interfaces/IHookExecutionData.sol

## Structs

### HookExecutionData

```solidity
/// @notice Data required for executing hooks with Merkle proof verification.
///  @param hooks Array of addresses of hooks to execute.
///  @param data Array of arbitrary data to pass to each hook.
///  @param merkleProofs Double array of Merkle proofs verifying each hook's allowed targets.
///  @param expectedAssetsOrSharesOut Array of minimum expected output amounts for slippage protection.
struct HookExecutionData {
    address[] hooks;
    bytes[] data;
    bytes32[][] merkleProofs;
    uint256[] expectedAssetsOrSharesOut;
}
```
