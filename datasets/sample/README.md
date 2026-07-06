# Sample tasks — ILLUSTRATIVE ONLY

These **12 tasks (3 per domain)** are a tiny, hand-checkable **sample** of what the
adapter produces. They exist so you can inspect the Harbor task layout and run a
verifier without generating anything. **This is not the dataset.**

The source dataset [`allenai/Dolci-RL-Zero-Mix-7B`](https://huggingface.co/datasets/allenai/Dolci-RL-Zero-Mix-7B)
has **46,900** examples. To generate the full set, run the adapter:

```bash
cd ../../adapters/dolci
uv run dolci                     # → datasets/dolci-rl-zero-mix-7b/ (git-ignored; ~3.4GB)
uv run dolci --per-type-limit 25 # a larger sample, if you just want more examples
```

The full generated output is intentionally **not committed** (it is ~3.4 GB /
~360k files, dominated by the per-task IFEval checker library). Like Harbor's own
adapters, the deliverable in git is the **adapter**, not the generated tasks.

## What's here

| Domain | Tasks | Oracle |
|--------|-------|--------|
| `math`       | 3 | `oracle_verified = "trivial"` |
| `code`       | 3 | `oracle_verified = "verified"` (reference solution passed its own tests) |
| `code_stdio` | 3 | `oracle_verified = "none"` (source ships no reference solution) |
| `ifeval`     | 3 | `oracle_verified = "none"` (no gold response) |

Run one verifier locally (Docker):

```bash
docker build -t t ./math_00001_*/environment
# ... see the top-level README / adapter README for the full verifier flow
```
