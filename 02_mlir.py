"""Layer 2 - jaxpr -> MLIR, as an explicit second step.

`QJIT.generate_ir()` walks the jaxpr from layer 1 and calls each primitive's lowering
rule (see `lower_jaxpr_to_mlir` in frontend/catalyst/jax_tracer.py). Still no passes -
this is the raw frontend output. Layer 3's out/0_workflow.mlir is the same module
after one `canonicalize` run, which is why it prints in the prettier assembly form.

What comes out mixes three dialects:
  - stablehlo : classical math, inherited from JAX/XLA
  - quantum   : mlir/include/Quantum - alloc, extract, custom, namedobs, expval, ...
  - catalyst  : mlir/include/Catalyst - launch_kernel, callbacks, print

Note the QNode sits in a *nested* module carrying an empty `transform.named_sequence`.
That is the hook circuit-transform passes get scheduled into (see 05_...py).

Run:  ../.venv/bin/python 02_mlir.py
"""

from pathlib import Path

import jax.numpy as jnp

from program import make

OUT = Path(__file__).parent / "out"
OUT.mkdir(exist_ok=True)

fn = make()
fn.jaxpr, _, _, _ = fn.capture((jnp.float64(0.3),))  # layer 1
module = fn.generate_ir()  # layer 2

print(module)

dest = OUT / "00_workflow.frontend.mlir"
dest.write_text(str(module))
print(f"\nwrote {dest}")
