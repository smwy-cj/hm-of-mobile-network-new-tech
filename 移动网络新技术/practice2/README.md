# Practice 2: 2D Parity Check Decoder (二维奇欧解码器)

## Exercise Description

After the encoded vector passes through a noisy channel, some symbols may be altered. The decoder's job is to detect and correct these errors using the 2D parity structure, recovering the original message.

The decoder receives:
- `received_vector`: The (possibly corrupted) encoded vector of length $R \times C$.
- `radix`, `rows`, `columns`: The same parameters used during encoding.

It outputs a decoded message vector of length $(\text{rows}-1) \times (\text{columns}-1)$.

## Decoding Algorithm

### Syndrome Computation

The received vector is reshaped into an $R \times C$ matrix $E$. For each row $i$ and column $j$, the **syndrome** is:

$$S_r(i) = \sum_{j=1}^{C} E_{i,j} \bmod q, \qquad S_c(j) = \sum_{i=1}^{R} E_{i,j} \bmod q$$

A zero syndrome means the parity check passes (no detected error in that row/column). A non-zero syndrome indicates at least one error.

### Iterative Correction

The decoder applies three strategies in order, recomputing syndromes after each correction:

#### Strategy 1 — Exact Match (Matching Syndrome)

If $S_r(i) = S_c(j) \neq 0$ for some position $(i, j)$, then the symbol at $(i, j)$ is corrected:

$$E_{i,j} \leftarrow (E_{i,j} - S_r(i)) \bmod q$$

This handles single errors anywhere in the matrix (including parity positions) and diagonal double errors.

#### Strategy 2 — Unique Column

For each **data row** $i$ (not the parity row): if exactly one data column $j$ has $S_c(j) \neq 0$, the error is at $(i, j)$ with value $S_r(i)$:

$$E_{i,j} \leftarrow (E_{i,j} - S_r(i)) \bmod q$$

This handles multiple errors aligned in the same column.

#### Strategy 3 — Unique Row

For each **data column** $j$ (not the parity column): if exactly one data row $i$ has $S_r(i) \neq 0$, the error is at $(i, j)$ with value $S_c(j)$:

$$E_{i,j} \leftarrow (E_{i,j} - S_c(j)) \bmod q$$

This handles multiple errors aligned in the same row.

### Termination

The algorithm iterates until no correction is made in a full pass, or until a maximum of $R \times C$ iterations. The data submatrix $E_{1:R-1, 1:C-1}$ is then extracted as the decoded message.

## Code Structure

```
function decoded_vector = Decoder(received_vector, radix, rows, columns)
```

| Section | Description |
|---------|-------------|
| **Input validation** | Checks radix, rows, columns ranges, row-vector input, length match, and symbol range. |
| **Reshape** | Converts the received vector into an $R \times C$ matrix. |
| **Iterative loop** | Repeats syndrome computation and correction until no more fixes are possible. |
| **Strategy 1** | Searches for any $(i,j)$ where row and column syndromes match. |
| **Strategy 2** | For each data row, checks if only one data column has non-zero syndrome. |
| **Strategy 3** | For each data column, checks if only one data row has non-zero syndrome. |
| **Extract message** | Reads the data submatrix column by column to produce the output vector. |

## Principle

The 2D parity code's error correction capability comes from the **cross-validation** of row and column parity checks:

- **Single error**: The row and column syndromes are equal to the error value, uniquely identifying the location and magnitude.
- **Two errors in different rows and columns**: Each error produces a matching row-column syndrome pair, enabling independent correction.
- **Multiple errors in one column**: Row syndromes give per-row error values; the column syndrome is the sum. Strategy 2 isolates each row's contribution.
- **Multiple errors in one row**: Column syndromes give per-column error values. Strategy 3 isolates each column's contribution.

The code cannot correct all error patterns (e.g., a $2 \times 2$ error rectangle creates ambiguous syndromes), but the three-strategy approach maximizes correctable cases.
