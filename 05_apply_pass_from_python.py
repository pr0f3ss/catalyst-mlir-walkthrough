"""Layer 5 - turning an MLIR pass on from Python.

`catalyst.passes.*` decorators do not transform anything at trace time. They append
an entry to the QNode's `transform.named_sequence` in the nested module; the
`apply-transform-sequence` pass in QuantumCompilationStage then schedules the real
MLIR pass. Diff the first block below against 02_mlir.py to see it populate.

Run:  ../.venv/bin/python 05_apply_pass_from_python.py
"""

import shutil
from pathlib import Path

import jax.numpy as jnp
import pennylane as qp

from catalyst import qjit
from catalyst.passes import merge_rotations

dev = qp.device("lightning.qubit", wires=2)


@qjit(keep_intermediate="pipeline")
@merge_rotations
@qp.qnode(dev)
def circuit(theta):
    qp.RX(theta, wires=0)
    qp.RX(theta, wires=0)
    qp.CNOT(wires=[0, 1])
    return qp.expval(qp.PauliZ(0))


circuit(jnp.float64(0.3))

print("========== frontend IR: the transform sequence names the pass ==========")
print(circuit.mlir)
print("========== after QuantumCompilationStage: the two RX are merged ==========")
print(circuit.compiler.get_output_of("AfterQuantumCompilationStage", circuit.workspace))

shutil.rmtree(str(circuit.workspace), ignore_errors=True)
