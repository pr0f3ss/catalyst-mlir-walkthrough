module @workflow {
  func.func public @jit_workflow(%arg0: tensor<f64>) -> tensor<f64> attributes {llvm.emit_c_interface} {
    %cst = arith.constant 2.000000e+00 : f64
    %cst_0 = arith.constant 1.000000e+00 : f64
    %extracted = tensor.extract %arg0[] : tensor<f64>
    %0 = arith.mulf %extracted, %cst : f64
    %from_elements = tensor.from_elements %0 : tensor<f64>
    %1 = call @circuit_0(%from_elements) : (tensor<f64>) -> tensor<f64>
    %extracted_1 = tensor.extract %1[] : tensor<f64>
    %2 = arith.addf %extracted_1, %cst_0 : f64
    %from_elements_2 = tensor.from_elements %2 : tensor<f64>
    return %from_elements_2 : tensor<f64>
  }
  func.func public @circuit_0(%arg0: tensor<f64>) -> tensor<f64> attributes {diff_method = "adjoint", llvm.linkage = #llvm.linkage<internal>, qnode} {
    %c0_i64 = arith.constant 0 : i64
    quantum.device shots(%c0_i64) ["/Users/filip/src/catalyst/.venv/lib/python3.13/site-packages/pennylane_lightning/liblightning_qubit_catalyst.dylib", "LightningSimulator", "{'mcmc': False, 'num_burnin': 0, 'kernel_name': None}"]
    %0 = quantum.alloc( 2) : !quantum.reg
    %1 = quantum.extract %0[ 0] : !quantum.reg -> !quantum.bit
    %extracted = tensor.extract %arg0[] : tensor<f64>
    %out_qubits = quantum.custom "RX"(%extracted) %1 : !quantum.bit
    %out_qubits_0 = quantum.custom "RX"(%extracted) %out_qubits : !quantum.bit
    %2 = quantum.extract %0[ 1] : !quantum.reg -> !quantum.bit
    %out_qubits_1:2 = quantum.custom "CNOT"() %out_qubits_0, %2 : !quantum.bit, !quantum.bit
    %3 = quantum.namedobs %out_qubits_1#0[ PauliZ] : !quantum.obs
    %4 = quantum.expval %3 : f64
    %from_elements = tensor.from_elements %4 : tensor<f64>
    %5 = quantum.insert %0[ 0], %out_qubits_1#0 : !quantum.reg, !quantum.bit
    %6 = quantum.insert %5[ 1], %out_qubits_1#1 : !quantum.reg, !quantum.bit
    quantum.dealloc %6 : !quantum.reg
    quantum.device_release
    return %from_elements : tensor<f64>
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