# Practice 4: Monte Carlo Simulation (蒙特卡洛仿真)

## Exercise Description

The end-to-end performance of the 2D parity-coded communication system is evaluated through Monte Carlo simulation. By simulating the full chain — encode → channel → decode — many times and counting residual errors, we estimate the **Symbol Error Rate (SER)** after decoding as a function of the channel error probability $P_e$.

## Simulation Flow

```
Message → Encoder → MSC (noisy channel) → Decoder → Compare
```

For each value of $P_e$:
1. Generate random message vectors.
2. Encode each message using Practice 1's `Encoder`.
3. Pass the encoded vector through Practice 3's `MSC` channel.
4. Decode the received vector using Practice 2's `Decoder`.
5. Count symbol-level disagreements between original and decoded messages.

The process repeats until **100–1000 symbol errors** have accumulated at a given $P_e$, ensuring statistically stable estimates (more errors = smoother curve).

## Output

The simulation generates:

- `simulation_results.mat`: Raw data (`Pe_values`, `ser_results` arrays).
- `simulation_results.fig` / `simulation_results.png`: A **log-log plot** showing:
  - **Decoded SER** (blue curve with markers): The residual error rate after correction.
  - **Uncoded SER** (red dashed line): The channel $P_e$ for reference.
- Console output: Per-$P_e$ progress with SER and error counts.

## Code Structure

```
function main()
```

| Section | Description |
|---------|-------------|
| **Path setup** | Adds `practice1`, `practice2`, `practice3` to the MATLAB path so `Encoder`, `Decoder`, `MSC` are accessible. |
| **Parameter grid** | Defines $P_e$ values using `logspace(-3, -0.3, 10)` for logarithmically spaced points. |
| **Simulation loop** | For each $P_e$, runs batches of 1000 vectors until 100–1000 symbol errors are found. |
| **SER computation** | $\text{SER} = \frac{\text{total symbol errors}}{\text{total symbols transmitted}}$. |
| **Checkpoint save** | Saves intermediate results after each $P_e$ point (allows resuming). |
| **Plotting** | Uses `loglog` for a log-log SER vs. $P_e$ curve with labels, legend, grid, and axis limits. |

## Principle

Monte Carlo simulation estimates the decoder's error rate by brute-force random sampling. The key design choices:

- **Logarithmic $P_e$ spacing**: Error rates often follow power-law relationships ($\text{SER} \propto P_e^t$), which appear as straight lines on log-log axes. The exponent $t$ reveals the code's **diversity order** (error correction capability).
- **Error-count termination**: Running until a fixed number of *errors* (not trials) stabilizes the relative error of the estimate across all $P_e$ values. At low $P_e$, more trials are needed to find 100 errors, but the estimate quality remains consistent.
- **Comparison with uncoded SER**: The gap between the decoded curve and the $y = x$ reference line visualizes the **coding gain**: how much the 2D parity code improves reliability.

### Expected Behavior

For the $(R-1)(C-1)$ 2D parity code:
- **Single errors are fully corrected** → at low $P_e$, $\text{SER} \propto P_e^2$ (since an uncorrectable error requires at least 2 symbol errors in the encoded vector).
- **As $P_e$ increases**, the decoder's ability to correct multiple simultaneous errors degrades, and the curve approaches the uncoded line.
