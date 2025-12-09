# Contract: StdStyle

## Metadata

- **Name**: StdStyle
- **Type**: Contract
- **Path**: lib/forge-std/src/StdStyle.sol

## State Variables

### vm

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### RED

```solidity
string internal constant RED = "\u001b[91m"
```

### GREEN

```solidity
string internal constant GREEN = "\u001b[92m"
```

### YELLOW

```solidity
string internal constant YELLOW = "\u001b[93m"
```

### BLUE

```solidity
string internal constant BLUE = "\u001b[94m"
```

### MAGENTA

```solidity
string internal constant MAGENTA = "\u001b[95m"
```

### CYAN

```solidity
string internal constant CYAN = "\u001b[96m"
```

### BOLD

```solidity
string internal constant BOLD = "\u001b[1m"
```

### DIM

```solidity
string internal constant DIM = "\u001b[2m"
```

### ITALIC

```solidity
string internal constant ITALIC = "\u001b[3m"
```

### UNDERLINE

```solidity
string internal constant UNDERLINE = "\u001b[4m"
```

### INVERSE

```solidity
string internal constant INVERSE = "\u001b[7m"
```

### RESET

```solidity
string internal constant RESET = "\u001b[0m"
```
