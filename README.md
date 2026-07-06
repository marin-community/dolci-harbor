# Dolci-Zero-Harbor

Convert [`allenai/Dolci-RL-Zero-Mix-7B`](https://huggingface.co/datasets/allenai/Dolci-RL-Zero-Mix-7B)
— the RL-with-verifiable-rewards mix from Olmo post-training — into the
[Harbor](https://www.harborframework.com) task format, so every example becomes a
containerized, verifiable RL/eval task.

## Layout

```
adapters/dolci/                     # the adapter (see its README for full docs)
  src/dolci/
    main.py                         # CLI: stream the HF dataset → task dirs
    adapter.py                      # per-record → Harbor task
    graders/                        # math / code / code_stdio / ifeval graders
      ifeval_lib/                   # vendored open-instruct IFEvalG checkers (Apache-2.0)
    task-template/                  # shared Dockerfiles + test.sh
datasets/dolci-rl-zero-mix-7b/      # a generated, verified sample (3 tasks per domain)
```

## Quick start

```bash
cd adapters/dolci
uv sync                       # or: pip install -e .
uv run dolci --per-type-limit 25 --overwrite      # generate a balanced sample
harbor run -p ../../datasets/dolci-rl-zero-mix-7b -a <agent> -m "<model>"
```

The four source domains (`math`, `code`, `code_stdio`, `ifeval`) each map to a
container task with a verifiable reward written to `/logs/verifier/reward.txt`. See
[`adapters/dolci/README.md`](adapters/dolci/README.md) for the format mapping,
grading details, options, and verification results.
