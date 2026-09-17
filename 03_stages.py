"""Layer 3 - the MLIR pass pipeline, stage by stage.

Compiles with keep_intermediate="pipeline" so the driver writes the IR after every
stage, then copies those files into ./out/ and prints the pass list per stage.

Use keep_intermediate="changed" instead to get one file per *pass* that changed
anything - the finest-grained view.

Run:  ../.venv/bin/python 03_stages.py
"""

import shutil
from pathlib import Path

import jax.numpy as jnp

from catalyst.pipelines import default_pipeline
from program import make

HERE = Path(__file__).parent
OUT = HERE / "out"


def main():
    OUT.mkdir(exist_ok=True)
    for stale in OUT.glob("[0-9]_*"):  # keep the 00_* dumps from layers 1 and 2
        stale.unlink()

    fn = make(keep_intermediate="pipeline")
    print("result:", fn(jnp.float64(0.3)))

    ws = Path(str(fn.workspace))
    for f in sorted(ws.iterdir()):
        if f.suffix in (".mlir", ".ll"):
            shutil.copy(f, OUT / f.name)
    shutil.rmtree(ws, ignore_errors=True)

    print("\n=== IR snapshots in ./out ===")
    for f in sorted(OUT.iterdir()):
        print(f"  {f.name:<45} {f.stat().st_size:>8} bytes")

    print("\n=== default pipeline ===")
    for name, passes in default_pipeline():
        print(f"\n{name}  ({len(passes)} passes)")
        for p in passes:
            print("   ", p)


if __name__ == "__main__":
    main()
