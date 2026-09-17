module @workflow {
  llvm.func @__catalyst__rt__finalize()
  llvm.func @__catalyst__rt__initialize(!llvm.ptr)
  llvm.func @__catalyst__rt__device_release()
  llvm.func @__catalyst__rt__qubit_release_array(!llvm.ptr)
  llvm.func @__catalyst__qis__Expval(i64) -> f64
  llvm.func @__catalyst__qis__NamedObs(i64, !llvm.ptr) -> i64
  llvm.func @__catalyst__qis__CNOT(!llvm.ptr, !llvm.ptr, !llvm.ptr)
  llvm.func @__catalyst__qis__RX(f64, !llvm.ptr, !llvm.ptr)
  llvm.func @__catalyst__rt__array_get_element_ptr_1d(!llvm.ptr, i64) -> !llvm.ptr
  llvm.func @__catalyst__rt__qubit_allocate_array(i64) -> !llvm.ptr
  llvm.mlir.global internal constant @"{'mcmc': False, 'num_burnin': 0, 'kernel_name': None}"("{'mcmc': False, 'num_burnin': 0, 'kernel_name': None}\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @LightningSimulator("LightningSimulator\00") {addr_space = 0 : i32}
  llvm.mlir.global internal constant @"/Users/filip/src/catalyst/.venv/lib/python3.13/site-packages/pennylane_lightning/liblightning_qubit_catalyst.dylib"("/Users/filip/src/catalyst/.venv/lib/python3.13/site-packages/pennylane_lightning/liblightning_qubit_catalyst.dylib\00") {addr_space = 0 : i32}
  llvm.func @__catalyst__rt__device_init(!llvm.ptr, !llvm.ptr, !llvm.ptr, i64, i1)
  llvm.func @_mlir_memref_to_llvm_free(!llvm.ptr)
  llvm.func @_mlir_memref_to_llvm_alloc(i64) -> !llvm.ptr
  llvm.func @jit_workflow(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) -> !llvm.struct<(ptr, ptr, i64)> attributes {llvm.copy_memref, llvm.emit_c_interface} {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(64 : index) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %6 = llvm.mlir.constant(3735928559 : index) : i64
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %8 = llvm.load %arg1 : !llvm.ptr -> f64
    %9 = llvm.fmul %8, %5 : f64
    %10 = llvm.getelementptr %2[1] : (!llvm.ptr) -> !llvm.ptr, f64
    %11 = llvm.ptrtoint %10 : !llvm.ptr to i64
    %12 = llvm.add %11, %1 : i64
    %13 = llvm.call @_mlir_memref_to_llvm_alloc(%12) : (i64) -> !llvm.ptr
    %14 = llvm.ptrtoint %13 : !llvm.ptr to i64
    %15 = llvm.sub %1, %3 : i64
    %16 = llvm.add %14, %15 : i64
    %17 = llvm.urem %16, %1 : i64
    %18 = llvm.sub %16, %17 : i64
    %19 = llvm.inttoptr %18 : i64 to !llvm.ptr
    llvm.store %9, %19 : f64, !llvm.ptr
    %20 = llvm.call @circuit_0(%13, %19, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %21 = llvm.extractvalue %20[1] : !llvm.struct<(ptr, ptr, i64)> 
    %22 = llvm.load %21 : !llvm.ptr -> f64
    llvm.call @_mlir_memref_to_llvm_free(%13) : (!llvm.ptr) -> ()
    %23 = llvm.fadd %22, %4 : f64
    %24 = llvm.getelementptr %2[1] : (!llvm.ptr) -> !llvm.ptr, f64
    %25 = llvm.ptrtoint %24 : !llvm.ptr to i64
    %26 = llvm.add %25, %1 : i64
    %27 = llvm.call @_mlir_memref_to_llvm_alloc(%26) : (i64) -> !llvm.ptr
    %28 = llvm.ptrtoint %27 : !llvm.ptr to i64
    %29 = llvm.sub %1, %3 : i64
    %30 = llvm.add %28, %29 : i64
    %31 = llvm.urem %30, %1 : i64
    %32 = llvm.sub %30, %31 : i64
    %33 = llvm.inttoptr %32 : i64 to !llvm.ptr
    %34 = llvm.insertvalue %27, %7[0] : !llvm.struct<(ptr, ptr, i64)> 
    %35 = llvm.insertvalue %33, %34[1] : !llvm.struct<(ptr, ptr, i64)> 
    %36 = llvm.insertvalue %0, %35[2] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.store %23, %33 : f64, !llvm.ptr
    %37 = llvm.ptrtoint %27 : !llvm.ptr to i64
    %38 = llvm.icmp "eq" %6, %37 : i64
    llvm.cond_br %38, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %39 = llvm.getelementptr %2[1] : (!llvm.ptr) -> !llvm.ptr, f64
    %40 = llvm.ptrtoint %39 : !llvm.ptr to i64
    %41 = llvm.call @_mlir_memref_to_llvm_alloc(%40) : (i64) -> !llvm.ptr
    %42 = llvm.insertvalue %41, %7[0] : !llvm.struct<(ptr, ptr, i64)> 
    %43 = llvm.insertvalue %41, %42[1] : !llvm.struct<(ptr, ptr, i64)> 
    %44 = llvm.insertvalue %0, %43[2] : !llvm.struct<(ptr, ptr, i64)> 
    %45 = llvm.getelementptr %2[1] : (!llvm.ptr) -> !llvm.ptr, f64
    %46 = llvm.ptrtoint %45 : !llvm.ptr to i64
    %47 = llvm.mul %46, %3 : i64
    "llvm.intr.memcpy"(%41, %33, %47) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.br ^bb3(%44 : !llvm.struct<(ptr, ptr, i64)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%36 : !llvm.struct<(ptr, ptr, i64)>)
  ^bb3(%48: !llvm.struct<(ptr, ptr, i64)>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %48 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @_catalyst_pyface_jit_workflow(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr)> 
    llvm.call @_catalyst_ciface_jit_workflow(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @_catalyst_ciface_jit_workflow(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {llvm.copy_memref, llvm.emit_c_interface} {
    %0 = llvm.load %arg1 : !llvm.ptr -> !llvm.struct<(ptr, ptr, i64)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i64)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64)> 
    %3 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i64)> 
    %4 = llvm.call @jit_workflow(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.struct<(ptr, ptr, i64)>
    llvm.store %4, %arg0 : !llvm.struct<(ptr, ptr, i64)>, !llvm.ptr
    llvm.return
  }
  llvm.func internal @circuit_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) -> !llvm.struct<(ptr, ptr, i64)> attributes {diff_method = "adjoint", qnode} {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(64 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(false) : i1
    %8 = llvm.mlir.addressof @"{'mcmc': False, 'num_burnin': 0, 'kernel_name': None}" : !llvm.ptr
    %9 = llvm.mlir.addressof @LightningSimulator : !llvm.ptr
    %10 = llvm.mlir.addressof @"/Users/filip/src/catalyst/.venv/lib/python3.13/site-packages/pennylane_lightning/liblightning_qubit_catalyst.dylib" : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64)>
    %13 = llvm.getelementptr inbounds %10[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<115 x i8>
    %14 = llvm.getelementptr inbounds %9[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<19 x i8>
    %15 = llvm.getelementptr inbounds %8[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<54 x i8>
    llvm.call @__catalyst__rt__device_init(%13, %14, %15, %11, %7) : (!llvm.ptr, !llvm.ptr, !llvm.ptr, i64, i1) -> ()
    %16 = llvm.call @__catalyst__rt__qubit_allocate_array(%6) : (i64) -> !llvm.ptr
    %17 = llvm.call @__catalyst__rt__array_get_element_ptr_1d(%16, %11) : (!llvm.ptr, i64) -> !llvm.ptr
    %18 = llvm.load %17 : !llvm.ptr -> !llvm.ptr
    %19 = llvm.load %arg1 : !llvm.ptr -> f64
    llvm.call @__catalyst__qis__RX(%19, %18, %5) : (f64, !llvm.ptr, !llvm.ptr) -> ()
    llvm.call @__catalyst__qis__RX(%19, %18, %5) : (f64, !llvm.ptr, !llvm.ptr) -> ()
    %20 = llvm.call @__catalyst__rt__array_get_element_ptr_1d(%16, %4) : (!llvm.ptr, i64) -> !llvm.ptr
    %21 = llvm.load %20 : !llvm.ptr -> !llvm.ptr
    llvm.call @__catalyst__qis__CNOT(%18, %21, %5) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %22 = llvm.call @__catalyst__qis__NamedObs(%3, %18) : (i64, !llvm.ptr) -> i64
    %23 = llvm.call @__catalyst__qis__Expval(%22) : (i64) -> f64
    %24 = llvm.getelementptr %5[1] : (!llvm.ptr) -> !llvm.ptr, f64
    %25 = llvm.ptrtoint %24 : !llvm.ptr to i64
    %26 = llvm.add %25, %1 : i64
    %27 = llvm.call @_mlir_memref_to_llvm_alloc(%26) : (i64) -> !llvm.ptr
    %28 = llvm.ptrtoint %27 : !llvm.ptr to i64
    %29 = llvm.sub %1, %2 : i64
    %30 = llvm.add %28, %29 : i64
    %31 = llvm.urem %30, %1 : i64
    %32 = llvm.sub %30, %31 : i64
    %33 = llvm.inttoptr %32 : i64 to !llvm.ptr
    %34 = llvm.insertvalue %27, %12[0] : !llvm.struct<(ptr, ptr, i64)> 
    %35 = llvm.insertvalue %33, %34[1] : !llvm.struct<(ptr, ptr, i64)> 
    %36 = llvm.insertvalue %0, %35[2] : !llvm.struct<(ptr, ptr, i64)> 
    llvm.store %23, %33 : f64, !llvm.ptr
    llvm.call @__catalyst__rt__qubit_release_array(%16) : (!llvm.ptr) -> ()
    llvm.call @__catalyst__rt__device_release() : () -> ()
    llvm.return %36 : !llvm.struct<(ptr, ptr, i64)>
  }
  llvm.func @setup() {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.call @__catalyst__rt__initialize(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @teardown() {
    llvm.call @__catalyst__rt__finalize() : () -> ()
    llvm.return
  }
}