# Contract: EfficientHashLib

## Metadata

- **Name**: EfficientHashLib
- **Type**: Contract
- **Path**: lib/v2-core/lib/solady/src/utils/EfficientHashLib.sol
- **Documentation**: @notice Library for efficiently performing keccak256 hashes.
   @author Solady (https://github.com/vectorized/solady/blob/main/src/utils/EfficientHashLib.sol)
   @dev To avoid stack-too-deep, you can use:
   ```
   bytes32[] memory buffer = EfficientHashLib.malloc(10);
   EfficientHashLib.set(buffer, 0, value0);
   ..
   EfficientHashLib.set(buffer, 9, value9);
   bytes32 finalHash = EfficientHashLib.hash(buffer);
   ```
