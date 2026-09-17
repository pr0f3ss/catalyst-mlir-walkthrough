# MLIR walkthrough

One example program, followed from PennyLane Python down to LLVM IR.

The example lives in [program.py](program.py): a 2-qubit QNode (`RX`, `RX`, `CNOT`,
`expval(Z)`) wrapped in classical pre/post-processing, so both the quantum and the
classical halves of the IR are visible.

```bash
.venv/bin/python 01_jaxpr.py
.venv/bin/python 02_mlir.py
.venv/bin/python 03_stages.py     # writes ./out/
./04_single_pass.sh
.venv/bin/python 05_apply_pass_from_python.py
```

`01_jaxpr.py` and `02_mlir.py` call `QJIT.capture()` and `QJIT.generate_ir()` directly,
so each stops at its own layer. No passes run and no binary is produced. `03_stages.py`
onwards actually compiles.

## The layers

| # | What happens | Where the code lives in Catalyst |
|---|---|---|
| 1 | Python → **jaxpr**. Quantum ops become JAX primitives (`qalloc`, `qinst`, `expval`, …). | [frontend/catalyst/jax_tracer.py](../frontend/catalyst/jax_tracer.py), [jax_primitives.py](../frontend/catalyst/jax_primitives.py) |
| 2 | jaxpr → **MLIR**. Each primitive has a lowering rule emitting `quantum` / `catalyst` / `stablehlo` ops. | [frontend/catalyst/jax_primitives.py](../frontend/catalyst/jax_primitives.py), [mlir/lib/CAPI/](../mlir/lib/CAPI/) |
| 3 | MLIR → LLVM via **5 pass stages**. | [mlir/include/Driver/DefaultPipelines/DefaultPipelines.h](../mlir/include/Driver/DefaultPipelines/DefaultPipelines.h), [frontend/catalyst/pipelines.py](../frontend/catalyst/pipelines.py) |
| 4 | LLVM IR → object → `.so`, loaded back into Python. | [mlir/lib/Driver/](../mlir/lib/Driver/), [frontend/catalyst/compiled_functions.py](../frontend/catalyst/compiled_functions.py) |
| 5 | Gate calls resolve to the **runtime** at execution time. | [runtime/lib/](../runtime/lib/) |

## Stage 3 in detail

`03_stages.py` writes one file per stage into `out/`, next to the layer 1 and 2 dumps:

```
00_workflow.jaxpr.txt                    written by 01: the jaxpr (a Python object, dumped by hand)
00_workflow.frontend.mlir                written by 02: raw generate_ir() output, before canonicalize
0_workflow.mlir                          frontend output: quantum + stablehlo, QNode in a nested module
1_AfterQuantumCompilationStage.mlir      15 passes: value semantics, transform sequence, ctrl/adjoint lowering
2_AfterHLOLoweringStage.mlir             18 passes: stablehlo -> linalg/scf/arith/tensor
3_AfterGradientLoweringStage.mlir         2 passes: gradient dialect -> concrete adjoint/fd code
4_AfterBufferizationStage.mlir           14 passes: tensor -> memref
5_AfterCrossCompileTargets.mlir          target attributes
6_AfterMLIRToLLVMDialectConversion.mlir  25 passes: everything -> llvm dialect, gates -> __catalyst__qis__* calls
7_AfterLLVMIRTranslation.ll              LLVM IR
```

## Useful knobs

```bash
# finest granularity: one file per pass that changed anything
../.venv/bin/python -c "
import jax.numpy as jnp; from program import make
fn = make(keep_intermediate='changed'); fn(jnp.float64(0.3)); print(fn.workspace)"

# run any pass by hand
../mlir/build/bin/quantum-opt --help | grep -i <pass-name>
./04_single_pass.sh out/1_AfterQuantumCompilationStage.mlir merge-rotations

# the driver, standalone
../mlir/build/bin/catalyst --tool=opt --keep-intermediate --workspace=/tmp/ws out/0_workflow.mlir
```

`qjit(verbose=True)` prints every subprocess invocation; `keep_intermediate` levels are
`"none" | "pipeline" | "changed" | "pass"`.
