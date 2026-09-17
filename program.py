"""The one example program used for the whole walkthrough."""

import pennylane as qp
from catalyst import qjit

dev = qp.device("lightning.qubit", wires=2)


@qp.qnode(dev)
def circuit(theta):
    qp.RX(theta, wires=0)
    qp.RX(theta, wires=0)  # two adjacent rotations, so `merge-rotations` has work to do
    qp.CNOT(wires=[0, 1])
    return qp.expval(qp.PauliZ(0))


def make(**qjit_kwargs):
    """Return the qjit-wrapped entry point (classical pre/post-processing included)."""

    @qjit(**qjit_kwargs)
    def workflow(theta):
        return circuit(theta * 2.0) + 1.0

    return workflow
