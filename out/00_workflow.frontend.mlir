module @workflow {
  func.func public @jit_workflow(%arg0: tensor<f64>) -> tensor<f64> attributes {llvm.emit_c_interface} {
    %cst = stablehlo.constant dense<2.000000e+00> : tensor<f64>
    %0 = stablehlo.multiply %arg0, %cst : tensor<f64>
    %1 = "catalyst.launch_kernel"(%0) {callee = @module_circuit::@circuit} : (tensor<f64>) -> tensor<f64>
    %cst_0 = stablehlo.constant dense<1.000000e+00> : tensor<f64>
    %2 = stablehlo.add %1, %cst_0 : tensor<f64>
    return %2 : tensor<f64>
  }
  module @module_circuit {
    module attributes {transform.with_named_sequence} {
      "transform.named_sequence"() ({
      ^bb0(%arg0: !transform.op<"builtin.module">):
        "transform.yield"() : () -> ()
      }) {function_type = (!transform.op<"builtin.module">) -> (), sym_name = "__transform_main"} : () -> ()
    }
    func.func public @circuit(%arg0: tensor<f64>) -> tensor<f64> attributes {diff_method = "adjoint", llvm.linkage = #llvm.linkage<internal>, quantum.node} {
      %c = stablehlo.constant dense<0> : tensor<i64>
      %0 = "tensor.extract"(%c) : (tensor<i64>) -> i64
      "quantum.device"(%0) {device_name = "LightningSimulator", kwargs = "{'mcmc': False, 'num_burnin': 0, 'kernel_name': None}", lib = "/Users/filip/src/catalyst/.venv/lib/python3.13/site-packages/pennylane_lightning/liblightning_qubit_catalyst.dylib"} : (i64) -> ()
      %c_0 = stablehlo.constant dense<2> : tensor<i64>
      %1 = "quantum.alloc"() {nqubits_attr = 2 : i64} : () -> !quantum.reg
      %2 = "tensor.extract"(%c) : (tensor<i64>) -> i64
      %3 = "quantum.extract"(%1, %2) : (!quantum.reg, i64) -> !quantum.bit
      %4 = "tensor.extract"(%arg0) : (tensor<f64>) -> f64
      %5 = "quantum.custom"(%4, %3) {gate_name = "RX", operandSegmentSizes = array<i32: 1, 1, 0, 0>, resultSegmentSizes = array<i32: 1, 0>} : (f64, !quantum.bit) -> !quantum.bit
      %6 = "tensor.extract"(%arg0) : (tensor<f64>) -> f64
      %7 = "quantum.custom"(%6, %5) {gate_name = "RX", operandSegmentSizes = array<i32: 1, 1, 0, 0>, resultSegmentSizes = array<i32: 1, 0>} : (f64, !quantum.bit) -> !quantum.bit
      %c_1 = stablehlo.constant dense<1> : tensor<i64>
      %8 = "tensor.extract"(%c_1) : (tensor<i64>) -> i64
      %9 = "quantum.extract"(%1, %8) : (!quantum.reg, i64) -> !quantum.bit
      %10:2 = "quantum.custom"(%7, %9) {gate_name = "CNOT", operandSegmentSizes = array<i32: 0, 2, 0, 0>, resultSegmentSizes = array<i32: 2, 0>} : (!quantum.bit, !quantum.bit) -> (!quantum.bit, !quantum.bit)
      %11 = "quantum.namedobs"(%10#0) {type = #quantum<named_observable PauliZ>} : (!quantum.bit) -> !quantum.obs
      %12 = "quantum.expval"(%11) : (!quantum.obs) -> f64
      %13 = "tensor.from_elements"(%12) : (f64) -> tensor<f64>
      %14 = "tensor.extract"(%c) : (tensor<i64>) -> i64
      %15 = "quantum.insert"(%1, %14, %10#0) : (!quantum.reg, i64, !quantum.bit) -> !quantum.reg
      %16 = "tensor.extract"(%c_1) : (tensor<i64>) -> i64
      %17 = "quantum.insert"(%15, %16, %10#1) : (!quantum.reg, i64, !quantum.bit) -> !quantum.reg
      "quantum.dealloc"(%17) : (!quantum.reg) -> ()
      "quantum.device_release"() : () -> ()
      return %13 : tensor<f64>
    }
  }
  func.func @setup() {
    "quantum.init"() : () -> ()
    return
  }
  func.func @teardown() {
    "quantum.finalize"() : () -> ()
    return
  }
}
