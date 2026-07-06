# Dolci-Zero-Harbor

An **adapter** that converts [`allenai/Dolci-RL-Zero-Mix-7B`](https://huggingface.co/datasets/allenai/Dolci-RL-Zero-Mix-7B)
— the 46,900-example RL-with-verifiable-rewards mix from Olmo post-training — into the
[Harbor](https://www.harborframework.com) task format, so every example becomes a
containerized, verifiable RL/eval task.

> **The deliverable is the adapter, not a checked-in dataset.** Like Harbor's own
> adapters, this repo ships the converter; you generate the tasks on demand. The
> `datasets/sample/` directory holds **12 illustrative example tasks** (3 per domain)
> so you can inspect the format and run a verifier — **it is a sample, not the
> dataset.** The full 46,900-task output is ~3.4 GB / ~360k files and is
> intentionally **not committed** (git-ignored).

## Layout

```
adapters/dolci/                     # the adapter — THIS is the deliverable
  src/dolci/
    main.py                         # CLI: stream the HF dataset → task dirs
    adapter.py                      # per-record → Harbor task
    graders/                        # math / code / code_stdio / ifeval graders
      ifeval_lib/                   # vendored open-instruct IFEvalG checkers (Apache-2.0)
    task-template/                  # shared Dockerfiles + test.sh
datasets/sample/                    # 12 EXAMPLE tasks (3/domain) — a sample, not the dataset
```

## Quick start

```bash
cd adapters/dolci
uv sync                                    # or: pip install -e .

uv run dolci                               # convert ALL 46,900 → datasets/dolci-rl-zero-mix-7b/ (git-ignored)
uv run dolci --per-type-limit 25           # or a smaller balanced sample

# run a verifier against the committed examples:
harbor run -p ../../datasets/sample -a <agent> -m "<model>"
```

The four source domains (`math`, `code`, `code_stdio`, `ifeval`) each map to a
container task with a verifiable reward written to `/logs/verifier/reward.txt`.

**Generality:** the adapter was run over 3,000 real rows streamed from the hub —
2,998 converted cleanly, 2 dropped by oracle verification, **0 errors**, with all 54
distinct IFEval instruction-IDs covered and no `code_stdio` decode failures. See
[`adapters/dolci/README.md`](adapters/dolci/README.md) for the format mapping,
grading details, options, and full verification results.
