module @workflow {
  func.func public @jit_workflow(%arg0: memref<f64>) -> memref<f64> attributes {llvm.copy_memref, llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(3735928559 : index) : i64
    %cst = arith.constant 2.000000e+00 : f64
    %cst_0 = arith.constant 1.000000e+00 : f64
    %1 = memref.load %arg0[] : memref<f64>
    %2 = arith.mulf %1, %cst : f64
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<f64>
    memref.store %2, %alloc[] : memref<f64>
    %3 = call @circuit_0(%alloc) : (memref<f64>) -> memref<f64>
    %4 = memref.load %3[] : memref<f64>
    memref.dealloc %alloc : memref<f64>
    %5 = arith.addf %4, %cst_0 : f64
    %alloc_1 = memref.alloc() {alignment = 64 : i64} : memref<f64>
    memref.store %5, %alloc_1[] : memref<f64>
    %6 = builtin.unrealized_conversion_cast %alloc_1 : memref<f64> to !llvm.struct<(ptr, ptr, i64)>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(ptr, ptr, i64)> 
    %8 = llvm.ptrtoint %7 : !llvm.ptr to i64
    %9 = llvm.icmp "eq" %0, %8 : i64
    %10 = scf.if %9 -> (memref<f64>) {
      %alloc_2 = memref.alloc() : memref<f64>
      memref.copy %alloc_1, %alloc_2 : memref<f64> to memref<f64>
      scf.yield %alloc_2 : memref<f64>
    } else {
      scf.yield %alloc_1 : memref<f64>
    }
    return %10 : memref<f64>
  }
  func.func public @circuit_0(%arg0: memref<f64>) -> memref<f64> attributes {diff_method = "adjoint", llvm.linkage = #llvm.linkage<internal>, qnode} {
    %c0_i64 = arith.constant 0 : i64
    quantum.device shots(%c0_i64) ["/Users/filip/src/catalyst/.venv/lib/python3.13/site-packages/pennylane_lightning/liblightning_qubit_catalyst.dylib", "LightningSimulator", "{'mcmc': False, 'num_burnin': 0, 'kernel_name': None}"]
    %0 = quantum.alloc( 2) : !quantum.reg
    %1 = quantum.extract %0[ 0] : !quantum.reg -> !quantum.bit
    %2 = memref.load %arg0[] : memref<f64>
    %out_qubits = quantum.custom "RX"(%2) %1 : !quantum.bit
    %out_qubits_0 = quantum.custom "RX"(%2) %out_qubits : !quantum.bit
    %3 = quantum.extract %0[ 1] : !quantum.reg -> !quantum.bit
    %out_qubits_1:2 = quantum.custom "CNOT"() %out_qubits_0, %3 : !quantum.bit, !quantum.bit
    %4 = quantum.namedobs %out_qubits_1#0[ PauliZ] : !quantum.obs
    %5 = quantum.expval %4 : f64
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<f64>
    memref.store %5, %alloc[] : memref<f64>
    %6 = quantum.insert %0[ 0], %out_qubits_1#0 : !quantum.reg, !quantum.bit
    %7 = quantum.insert %6[ 1], %out_qubits_1#1 : !quantum.reg, !quantum.bit
    quantum.dealloc %7 : !quantum.reg
    quantum.device_release
    return %alloc : memref<f64>
  }
  func.func @setup() {
    quantum.init
    return
  }
  func.func @teardown() {
    quantum.finalize
    return
  }
}