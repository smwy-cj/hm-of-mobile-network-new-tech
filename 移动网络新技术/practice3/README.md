# Practice 3: M-ary Symmetric Channel (M-ary对称信道)

## Exercise Description

The M-ary Symmetric Channel (MSC) models the behavior of a noisy communication channel where each transmitted symbol has a probability $P_e$ of being corrupted. It generalizes the Binary Symmetric Channel (BSC) to alphabets of size $q$ (the radix).

The channel is defined by:
- **radix** ($q$): The size of the symbol alphabet. Valid symbols are integers in $[0, q-1]$.
- **Pe** ($P_e$): The symbol error probability, a value in $[0, 1]$.

## Channel Behavior

For each symbol in the input vector, independently:

1. With probability $1 - P_e$: The symbol passes through **unchanged**.
2. With probability $P_e$: The symbol is **corrupted** — replaced by a random value uniformly chosen from all $q-1$ *incorrect* values.

Formally, for input symbol $x_i$ and output symbol $y_i$:

$$P(y_i = v \mid x_i) = \begin{cases} 1 - P_e & \text{if } v = x_i \\ \frac{P_e}{q-1} & \text{if } v \neq x_i \end{cases}$$

This ensures the channel is **symmetric**: the probability of confusing $a \to b$ equals the probability of $b \to a$ for any $a \neq b$.

## Code Structure

```
function received_vector = MSC(encoded_vector, radix, Pe)
```

| Section | Description |
|---------|-------------|
| **Input validation** | Checks `radix >= 2`, `Pe` in $[0,1]$, row-vector input, and symbols in $[0, \text{radix}-1]$. |
| **Error mask** | Generates a logical mask using `rand(1, n) < Pe` to determine which positions are in error. |
| **Error replacement** | For each erroneous position, selects uniformly from the $q-1$ incorrect values using `setdiff` and `randi`. |
| **Output** | Returns the modified vector (same length as input). |

## Principle

The M-ary symmetric channel is the natural generalization of the binary symmetric channel (BSC) to non-binary alphabets. Its key properties:

- **Memoryless**: Each symbol is corrupted independently.
- **Symmetric**: All error transitions are equally likely ($P_e / (q-1)$).
- **Uniform error distribution**: When an error occurs, each incorrect value is equally probable. This maximizes entropy (worst-case) for a given $P_e$.

The channel model provides a tractable baseline for evaluating error-correcting codes. The 2D parity code's performance over this channel is studied via Monte Carlo simulation in Practice 4.
