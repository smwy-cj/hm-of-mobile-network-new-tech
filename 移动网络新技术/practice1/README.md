# Practice 1: 2D Parity Check Encoder (二维奇欧编码器)

## Exercise Description

In a wireless communication system, messages are transmitted through a noisy channel that can corrupt symbols. A 2D (two-dimensional) parity check encoder protects the message by adding redundant parity symbols organized in rows and columns.

The encoder is parameterized by:
- **radix** ($q$): The alphabet size. Each symbol is an integer in $[0, q-1]$.
- **rows** ($R$): Number of rows in the *extended* (encoded) matrix.
- **columns** ($C$): Number of columns in the *extended* matrix.

The input message is a row vector of length $(R-1) \times (C-1)$.

## Encoding Process

### Step 1 — Reshape

The message vector is rearranged into an $(R-1) \times (C-1)$ matrix. Symbols are filled **column by column**: start at the leftmost column, fill from top to bottom, then move to the next column.

Example: message $[0, 1, 1, 0]$ with $R=3, C=3$ → a $2 \times 2$ data matrix:

```
Column 1: 0, 1     →    [0, 1]
Column 2: 1, 0          [1, 0]
```

### Step 2 — Add Parity

An extra row (bottom) and an extra column (right) are appended, forming an $R \times C$ matrix. The added values are chosen so that:

- **Row parity**: $\sum_{j=1}^{C} E_{i,j} \equiv 0 \pmod{q}$ for every row $i$.
- **Column parity**: $\sum_{i=1}^{R} E_{i,j} \equiv 0 \pmod{q}$ for every column $j$.

The bottom-right corner element simultaneously satisfies both the last row and last column parity constraints.

### Step 3 — Vectorize

The extended matrix is converted back into a row vector by reading column by column (top to bottom within each column, left to right across columns).

## Code Structure

```
function encoded_vector = Encoder(message_vector, radix, rows, columns)
```

| Section | Description |
|---------|-------------|
| **Input validation** | Checks `radix >= 2`, `rows >= 2`, `columns >= 2`, message is a row vector of correct length, and all symbols are in $[0, \text{radix}-1]$. Errors use identifier `NJU:argChk`. |
| **Reshape** | Fills a `(rows-1) × (columns-1)` matrix by iterating columns then rows. |
| **Row parity** | For each data row, computes $E_{r,C} = -\!\sum_{c=1}^{C-1} E_{r,c} \pmod{q}$. |
| **Column parity** | For each data column, computes $E_{R,c} = -\!\sum_{r=1}^{R-1} E_{r,c} \pmod{q}$. |
| **Corner parity** | Sets $E_{R,C}$ to satisfy the last row's parity constraint. By construction, this also satisfies the last column. |
| **Vectorize** | Reads the extended matrix column by column into the output vector of length $R \times C$. |

## Principle

The 2D parity code is a **product code** constructed from two single parity check (SPC) codes applied orthogonally. It adds $R + C - 1$ parity symbols to protect $(R-1)(C-1)$ data symbols, yielding a code rate of:

$$\text{Rate} = \frac{(R-1)(C-1)}{R \cdot C}$$

The code can detect any single error (and correct it with the decoder from Practice 2) by observing which row and column have non-zero syndromes.
