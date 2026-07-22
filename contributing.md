# Contributing to CTD_SIMU_RAI

Thanks for your interest! Quick guidelines:

1. Open an issue before starting larger changes, especially anything touching the model equations or the calibrated parameters.
2. Create a descriptive branch: `feature/xyz` or `fix/typo`.
3. Keep commits focused and with clear messages.
4. Open a Pull Request against `main` and describe the change.
5. A linter runs on PRs (Markdown/JSON/YAML).

## Model changes

If you modify the ODE model, the calibrated parameters, or the two patient archetypes (`Demonstrateur98f.m` / `Demonstrateur666f.m`), please note in the PR description whether the change affects reproducibility of the results in the companion papers (see [`CITATION.cff`](CITATION.cff)).
