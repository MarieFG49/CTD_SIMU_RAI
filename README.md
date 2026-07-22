# CTD_SIMU_RAI — RAIR-Sim

A compartmental (deterministic) simulator of the therapeutic response to **radioactive iodine (RAI) therapy** in metastatic thyroid cancer, used to explore how protocol parameters — number of iratherapy sessions (fractions), interval between sessions, and administered activity — affect the biomarker trajectory (thyroglobulin, Tg) that tracks tumor burden. Part of a broader "hybrid digital twin" effort combining mechanistic modeling with data-driven methods for individualized RAI treatment planning; see [Related work](#related-work).

## The model

Three coupled ODEs, solved in closed form (symbolically) fraction by fraction:

- **Administered activity** $A(t)$ (GBq), decaying at an effective rate $a$ (month⁻¹, folding in both radioactive and biological clearance):

$$\frac{dA}{dt} = -a\ln(2)\,A(t)$$

- **Tumor cell number** $N(t)$: logistic-like growth at rate $\ln(2)/T_d$ ($T_d$ = tumor doubling time, months) minus a radiation-induced kill term proportional to both cell number and instantaneous activity, with cell-kill-rate constant $r_0$ (GBq⁻¹.month⁻¹):

$$\frac{dN}{dt} = N(t)\left(\frac{\ln 2}{T_d}\right) - r_0\,A(t)\,N(t)$$

- **Thyroglobulin** $Tg(t)$ (ng/mL), the clinical biomarker: secreted in proportion to tumor cell number at rate $\lambda$ (ng/(mL·month) per cell) and cleared at rate $k_e$ (month⁻¹):

$$\frac{dTg}{dt} = \lambda\,N(t) - k_e\,Tg(t)$$

**Fractionation**: for a treatment of $n$ sessions spaced $\Delta T$ months apart with per-session activity $A_{\text{dose}}$, the three ODEs are solved in closed form (MATLAB `dsolve`) over each inter-session interval; at the end of interval $i$, $N$, $Tg$, and the residual activity $A$ are evaluated at $t=\Delta T$ and become the initial conditions for interval $i{+}1$, with a fresh bolus $A_{\text{dose}}$ added to the residual activity. This produces a full multi-fraction $Tg(t)$ trajectory from purely closed-form pieces (no numerical ODE integration).

Two virtual patient archetypes are hardcoded via $T_d$, the single parameter separating a fast-growing, RAI-refractory tumor from a slow-growing, RAI-responsive one — all other parameters ($r_0$, $a$, $\lambda$, $k_e$, $N_0$, $Tg_0$) are shared:

| Archetype | $T_d$ (months) | File |
|---|---|---|
| Non-responding | 9.8 | `Demonstrateur98f.m` / `main_demonstrateur98f.m` |
| Responding | 66.6 | `Demonstrateur666f.m` / `main_demonstrateur666f.m` |

## Files

- **`SIMULATEUR1VF2024.m`** — **RAIR-Sim**, the interactive MATLAB App Designer GUI: configure a virtual patient (responding/non-responding, plus the individual kinetic parameters) and a treatment protocol (activity per fraction, number of fractions, delay between fractions), then generate the simulated $Tg(t)$ curve. (Previously committed without the `.m` extension, which made it unrecognizable to MATLAB as a class/app file — fixed.)
- **`Demonstrateur98f.m`** / **`Demonstrateur666f.m`** — the underlying simulation function for each patient archetype, reusable for scripted sensitivity sweeps (called repeatedly by the `main_*` scripts below).
- **`main_demonstrateur98f.m`** / **`main_demonstrateur666f.m`** — sensitivity-analysis scripts reproducing the figures described below: for each archetype, sweep (a) number of sessions 1-8, (b) inter-session interval 1-8 months, and (c) activity per fraction 1-8 GBq, holding the other two parameters fixed, and overlay the resulting $Tg(t)$ curves.

Note: `Demonstrateur98f.m` and `Demonstrateur666f.m` are identical except for the hardcoded `Td` value — a deliberate duplication (one file per archetype) rather than a shared parameterized function; keep both in sync if the shared kinetic parameters ($r_0$, $a$, $\lambda$, $k_e$) are ever revised.

## Requirements

MATLAB with the **Symbolic Math Toolbox** (`syms`, `dsolve`, `vpa`, `subs`) and **App Designer** support (for `SIMULATEUR1VF2024.m`).

## Usage

```matlab
% Interactive GUI:
SIMULATEUR1VF2024

% Scripted sensitivity analysis (non-responding archetype, Td = 9.8 months):
main_demonstrateur98f

% Responding archetype, Td = 66.6 months:
main_demonstrateur666f
```

## Related work

- The Conversation (May 2026): ["IA et cancer de la thyroïde : demain, la fin des traitements standardisés ?"](https://theconversation.com/ia-et-cancer-de-la-thyro-de-demain-la-fin-des-traitements-standardises-274352) — accessible-audience summary of the "hybrid digital twin" approach this simulator is part of, combining AI and mechanistic modeling to test therapeutic scenarios (fraction number, activity, timing) before treating a patient.
- Companion paper: *Scientific Reports* — https://www.nature.com/articles/s41598-026-56267-1
- Preprint: HAL — https://hal.science/hal-05410326/

*(Full title/author list for the Scientific Reports paper to be added to [`CITATION.cff`](CITATION.cff) once confirmed.)*

## Citation

If you use this code, please cite this repository (see [`CITATION.cff`](CITATION.cff)) and, in academic work, the companion paper above.

## License

MIT. See [`LICENSE`](LICENSE).
