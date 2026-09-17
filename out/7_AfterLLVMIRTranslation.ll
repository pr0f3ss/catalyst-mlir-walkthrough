; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@"{'mcmc': False, 'num_burnin': 0, 'kernel_name': None}" = internal constant [54 x i8] c"{'mcmc': False, 'num_burnin': 0, 'kernel_name': None}\00"
@LightningSimulator = internal constant [19 x i8] c"LightningSimulator\00"
@"/Users/filip/src/catalyst/.venv/lib/python3.13/site-packages/pennylane_lightning/liblightning_qubit_catalyst.dylib" = internal constant [115 x i8] c"/Users/filip/src/catalyst/.venv/lib/python3.13/site-packages/pennylane_lightning/liblightning_qubit_catalyst.dylib\00"

declare void @__catalyst__rt__finalize()

declare void @__catalyst__rt__initialize(ptr)

declare void @__catalyst__rt__device_release()

declare void @__catalyst__rt__qubit_release_array(ptr)

declare double @__catalyst__qis__Expval(i64)

declare i64 @__catalyst__qis__NamedObs(i64, ptr)

declare void @__catalyst__qis__CNOT(ptr, ptr, ptr)

declare void @__catalyst__qis__RX(double, ptr, ptr)

declare ptr @__catalyst__rt__array_get_element_ptr_1d(ptr, i64)

declare ptr @__catalyst__rt__qubit_allocate_array(i64)

declare void @__catalyst__rt__device_init(ptr, ptr, ptr, i64, i1)

declare void @_mlir_memref_to_llvm_free(ptr)

declare ptr @_mlir_memref_to_llvm_alloc(i64)

define { ptr, ptr, i64 } @jit_workflow(ptr %0, ptr %1, i64 %2) {
  %4 = load double, ptr %1, align 8
  %5 = fmul double %4, 2.000000e+00
  %6 = call ptr @_mlir_memref_to_llvm_alloc(i64 72)
  %7 = ptrtoint ptr %6 to i64
  %8 = add i64 %7, 63
  %9 = urem i64 %8, 64
  %10 = sub i64 %8, %9
  %11 = inttoptr i64 %10 to ptr
  store double %5, ptr %11, align 8
  %12 = call { ptr, ptr, i64 } @circuit_0(ptr %6, ptr %11, i64 0)
  %13 = extractvalue { ptr, ptr, i64 } %12, 1
  %14 = load double, ptr %13, align 8
  call void @_mlir_memref_to_llvm_free(ptr %6)
  %15 = fadd double %14, 1.000000e+00
  %16 = call ptr @_mlir_memref_to_llvm_alloc(i64 72)
  %17 = ptrtoint ptr %16 to i64
  %18 = add i64 %17, 63
  %19 = urem i64 %18, 64
  %20 = sub i64 %18, %19
  %21 = inttoptr i64 %20 to ptr
  %22 = insertvalue { ptr, ptr, i64 } poison, ptr %16, 0
  %23 = insertvalue { ptr, ptr, i64 } %22, ptr %21, 1
  %24 = insertvalue { ptr, ptr, i64 } %23, i64 0, 2
  store double %15, ptr %21, align 8
  %25 = ptrtoint ptr %16 to i64
  %26 = icmp eq i64 3735928559, %25
  br i1 %26, label %27, label %32

27:                                               ; preds = %3
  %28 = call ptr @_mlir_memref_to_llvm_alloc(i64 8)
  %29 = insertvalue { ptr, ptr, i64 } poison, ptr %28, 0
  %30 = insertvalue { ptr, ptr, i64 } %29, ptr %28, 1
  %31 = insertvalue { ptr, ptr, i64 } %30, i64 0, 2
  call void @llvm.memcpy.p0.p0.i64(ptr %28, ptr %21, i64 8, i1 false)
  br label %33

32:                                               ; preds = %3
  br label %33

33:                                               ; preds = %27, %32
  %34 = phi { ptr, ptr, i64 } [ %24, %32 ], [ %31, %27 ]
  br label %35

35:                                               ; preds = %33
  ret { ptr, ptr, i64 } %34
}

define void @_catalyst_pyface_jit_workflow(ptr %0, ptr %1) {
  %3 = load { ptr, ptr }, ptr %1, align 8
  %4 = extractvalue { ptr, ptr } %3, 0
  call void @_catalyst_ciface_jit_workflow(ptr %0, ptr %4)
  ret void
}

define void @_catalyst_ciface_jit_workflow(ptr %0, ptr %1) {
  %3 = load { ptr, ptr, i64 }, ptr %1, align 8
  %4 = extractvalue { ptr, ptr, i64 } %3, 0
  %5 = extractvalue { ptr, ptr, i64 } %3, 1
  %6 = extractvalue { ptr, ptr, i64 } %3, 2
  %7 = call { ptr, ptr, i64 } @jit_workflow(ptr %4, ptr %5, i64 %6)
  store { ptr, ptr, i64 } %7, ptr %0, align 8
  ret void
}

define internal { ptr, ptr, i64 } @circuit_0(ptr %0, ptr %1, i64 %2) {
  call void @__catalyst__rt__device_init(ptr @"/Users/filip/src/catalyst/.venv/lib/python3.13/site-packages/pennylane_lightning/liblightning_qubit_catalyst.dylib", ptr @LightningSimulator, ptr @"{'mcmc': False, 'num_burnin': 0, 'kernel_name': None}", i64 0, i1 false)
  %4 = call ptr @__catalyst__rt__qubit_allocate_array(i64 2)
  %5 = call ptr @__catalyst__rt__array_get_element_ptr_1d(ptr %4, i64 0)
  %6 = load ptr, ptr %5, align 8
  %7 = load double, ptr %1, align 8
  call void @__catalyst__qis__RX(double %7, ptr %6, ptr null)
  call void @__catalyst__qis__RX(double %7, ptr %6, ptr null)
  %8 = call ptr @__catalyst__rt__array_get_element_ptr_1d(ptr %4, i64 1)
  %9 = load ptr, ptr %8, align 8
  call void @__catalyst__qis__CNOT(ptr %6, ptr %9, ptr null)
  %10 = call i64 @__catalyst__qis__NamedObs(i64 3, ptr %6)
  %11 = call double @__catalyst__qis__Expval(i64 %10)
  %12 = call ptr @_mlir_memref_to_llvm_alloc(i64 72)
  %13 = ptrtoint ptr %12 to i64
  %14 = add i64 %13, 63
  %15 = urem i64 %14, 64
  %16 = sub i64 %14, %15
  %17 = inttoptr i64 %16 to ptr
  %18 = insertvalue { ptr, ptr, i64 } poison, ptr %12, 0
  %19 = insertvalue { ptr, ptr, i64 } %18, ptr %17, 1
  %20 = insertvalue { ptr, ptr, i64 } %19, i64 0, 2
  store double %11, ptr %17, align 8
  call void @__catalyst__rt__qubit_release_array(ptr %4)
  call void @__catalyst__rt__device_release()
  ret { ptr, ptr, i64 } %20
}

define void @setup() {
  call void @__catalyst__rt__initialize(ptr null)
  ret void
}

define void @teardown() {
  call void @__catalyst__rt__finalize()
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
