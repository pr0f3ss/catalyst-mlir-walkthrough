"""Layer 1 - Python -> jaxpr, with nothing else running.

`QJIT.capture(args)` is the actual first stage of the frontend: it traces the Python
function with JAX and stops. No MLIR, no passes, no binary. It is what feeds layer 2.

Two things to look for in the output:
  - `mul` / `add` are stock JAX primitives (the classical pre/post-processing).
  - `quantum_kernel` wraps the QNode; inside it, the gates are Catalyst's own JAX
    primitives (qalloc / qextract / qinst / namedobs / expval / qinsert / qdealloc),
    registered in frontend/catalyst/jax_primitives.py.

Run:  ../.venv/bin/python 01_jaxpr.py
"""

from pathlib import Path

import jax.numpy as jnp

from program import make

OUT = Path(__file__).parent / "out"
OUT.mkdir(exist_ok=True)

fn = make()  # a QJIT object; nothing has been traced or compiled yet
jaxpr, out_type, out_treedef, sig = fn.capture((jnp.float64(0.3),))

print("========== top-level equations ==========")
for eqn in jaxpr.eqns:
    print(f"  {eqn.primitive.name:<20} -> {[str(v.aval) for v in eqn.outvars]}")

print("\n========== full jaxpr ==========")
print(jaxpr)

# A jaxpr is an in-memory Python object, not a file format. Nothing dumps it for us,
# so write it out by hand to sit alongside the MLIR snapshots from layer 3.
dest = OUT / "00_workflow.jaxpr.txt"
dest.write_text(str(jaxpr) + "\n")
print(f"\nwrote {dest}")
