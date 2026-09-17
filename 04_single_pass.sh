#!/usr/bin/env bash
# Layer 4 - drive the compiler binaries directly, one pass at a time.
#
#   ./04_single_pass.sh                                  # curated tour
#   ./04_single_pass.sh out/0_workflow.mlir pass1 pass2   # any file + any passes
#
#   quantum-opt : mlir-opt with every Catalyst dialect + pass registered.
#   catalyst    : the real driver (quantum-opt -> mlir-translate -> llc -> .so).
#
# Note: dialect-conversion passes (convert-*-to-llvm) usually only legalize as part
# of their whole stage, so poke at those via `catalyst --catalyst-pipeline=...`.
set -euo pipefail
cd "$(dirname "$0")"

OPT=../mlir/build/bin/quantum-opt
CLI=../mlir/build/bin/catalyst

[[ -f out/0_workflow.mlir ]] || { echo "run 03_stages.py first"; exit 1; }

run() { f=$1; shift; "$OPT" --pass-pipeline="builtin.module($(IFS=,; echo "$*"))" "$f"; }

if [[ $# -gt 0 ]]; then
  exec run "$@"
fi

show() { echo; echo "########## $1"; shift; run "$@"; }

# The QNode comes out of the frontend inside a nested module. These three flatten it:
# outline the tape, run the transform sequence, inline back into the parent module.
show "split-multiple-tapes + apply-transform-sequence + inline-nested-module" \
  out/0_workflow.mlir split-multiple-tapes apply-transform-sequence inline-nested-module

# A quantum peephole on the flattened IR: two adjacent RX collapse into one.
show "merge-rotations" out/1_AfterQuantumCompilationStage.mlir merge-rotations

# The end state of quantum lowering: gates are calls into the runtime C API,
# implemented in runtime/lib/. (Produced by the MLIRToLLVMDialectConversion stage.)
echo
echo "########## runtime symbols after quantum -> LLVM"
grep -o '@__catalyst[a-zA-Z_]*' out/6_AfterMLIRToLLVMDialectConversion.mlir | sort -u

echo
echo "########## the full pipeline the driver would run"
"$CLI" --dump-catalyst-pipeline out/0_workflow.mlir 2>&1 | head -30
