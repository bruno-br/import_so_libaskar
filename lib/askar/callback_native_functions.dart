import 'dart:ffi';
import 'package:import_so_libaskar/askar/askar_native_functions.dart';

base class CallbackParams extends Struct {
  @Int32()
  external int err;

  @Int64()
  external int handle;

  @Bool()
  external bool finished;
}

final DynamicLibrary nativeLibCallbacks =
    DynamicLibrary.open('android/app/src/main/libaries_askar/askar_callbacks.so');

typedef NextCallbackIdNative = CallbackId Function();

final int Function() nativeNextCallbackId = nativeLibCallbacks
    .lookup<NativeFunction<NextCallbackIdNative>>('next_cb_id')
    .asFunction();

typedef GetCallbackParamsNative = CallbackParams Function(CallbackId cb_id);

final CallbackParams Function(int cb_id) nativeGetCallbackParams = nativeLibCallbacks
    .lookup<NativeFunction<GetCallbackParamsNative>>('get_cb_params')
    .asFunction();

typedef CbWithHandleNative = Void Function(Int32, Int32, StoreHandle);

final nativeCbWithHandle =
    nativeLibCallbacks.lookup<NativeFunction<CbWithHandleNative>>('cb_with_handle');

typedef CbWithoutHandleNative = Void Function(CallbackId cb_id, Int32 err);

final nativeCbWithoutHandle =
    nativeLibCallbacks.lookup<NativeFunction<CbWithoutHandleNative>>('cb_without_handle');
