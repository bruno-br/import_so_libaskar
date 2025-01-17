import 'dart:ffi';
import 'package:ffi/ffi.dart';

base class ByteBuffer extends Struct {
  @Int64()
  external int len;

  external Pointer<Uint8> data;
}

base class SecretBuffer extends Struct {
  @Int64()
  external int len;

  external Pointer<Uint8> data;
}

base class AeadParams extends Struct {
  @Int32()
  external int nonce_length;

  @Int32()
  external int tag_length;
}

base class OptionEnabledCallbackStruct extends Struct {
  external Pointer<NativeFunction<OptionEnabledCallback>> callback;
}

base class OptionFlushCallbackStruct extends Struct {
  external Pointer<NativeFunction<OptionFlushCallback>> callback;
}

typedef LogCallback = Void Function(
    Pointer<Void> context,
    Int32 level,
    Pointer<Utf8> target,
    Pointer<Utf8> message,
    Pointer<Utf8> module_path,
    Pointer<Utf8> file,
    Int32 line);

typedef OptionEnabledCallback = Void Function(Pointer<Void> context);

typedef OptionFlushCallback = Void Function(Pointer<Void> context);

//
// Native Functions
//

typedef AskarVersionNative = Pointer<Utf8> Function();

typedef AskarSessionStartNative = Int32 Function(
  Int32 handle,
  Pointer<Utf8> profile,
  Int8 as_transaction,
  Pointer<NativeFunction<Void Function(Int32, Int32, Int32)>> cb,
  Int32 cb_id,
);

typedef AskarGetCurrentErrorNative = Int32 Function(
    Pointer<Pointer<Utf8>> error_json_p);

typedef AskarBufferFreeNative = Void Function(Pointer<SecretBuffer> buffer);

typedef AskarClearCustomLoggerNative = Void Function();

typedef AskarSetCustomLoggerNative = Int32 Function(
  Pointer<Void> context,
  Pointer<NativeFunction<LogCallback>> log,
  Pointer<OptionEnabledCallbackStruct> enabled,
  Pointer<OptionFlushCallbackStruct> flush,
  Int32 max_level,
);

typedef AskarStoreProvisionNative = Int32 Function(
  Pointer<Utf8> spec_uri,
  Pointer<Utf8> key_method,
  Pointer<Utf8> pass_key,
  Pointer<Utf8> profile,
  Int8 recreate,
  Pointer<NativeFunction<Void Function(Int32, Int32, Pointer<Void>)>> cb,
  Int32 cb_id,
);

final DynamicLibrary nativeLib = DynamicLibrary.open(
    'android/app/src/main/libaries_askar/libaries_askar.so');

final Pointer<Utf8> Function() nativeAskarVersion = nativeLib
    .lookup<NativeFunction<AskarVersionNative>>('askar_version')
    .asFunction();

final int Function(Pointer<Pointer<Utf8>> error_json_p)
    nativeAskarGetCurrentError = nativeLib
        .lookup<NativeFunction<AskarGetCurrentErrorNative>>(
            'askar_get_current_error')
        .asFunction();

final void Function(Pointer<SecretBuffer> buffer) nativeAskarBufferFree =
    nativeLib
        .lookup<NativeFunction<AskarBufferFreeNative>>('askar_buffer_free')
        .asFunction();

final void Function() nativeAskarClearCustomLogger = nativeLib
    .lookup<NativeFunction<AskarClearCustomLoggerNative>>(
        'askar_clear_custom_logger')
    .asFunction();

final int Function(
  Pointer<Void> context,
  Pointer<NativeFunction<LogCallback>> log,
  Pointer<OptionEnabledCallbackStruct> enabled,
  Pointer<OptionFlushCallbackStruct> flush,
  int max_level,
) nativeAskarSetCustomLogger = nativeLib
    .lookup<NativeFunction<AskarSetCustomLoggerNative>>(
        'askar_set_custom_logger')
    .asFunction();

final int Function(
  int handle,
  Pointer<Utf8> profile,
  int as_transaction,
  Pointer<NativeFunction<Void Function(Int32, Int32, Int32)>> cb,
  int cb_id,
) nativeAskarSessionStart = nativeLib
    .lookup<NativeFunction<AskarSessionStartNative>>('askar_session_start')
    .asFunction();

final int Function(
  Pointer<Utf8> spec_uri,
  Pointer<Utf8> key_method,
  Pointer<Utf8> pass_key,
  Pointer<Utf8> profile,
  int recreate,
  Pointer<NativeFunction<Void Function(Int32, Int32, Pointer<Void>)>> cb,
  int cb_id,
) nativeAskarStoreProvision = nativeLib
    .lookup<NativeFunction<AskarStoreProvisionNative>>('askar_store_provision')
    .asFunction();
