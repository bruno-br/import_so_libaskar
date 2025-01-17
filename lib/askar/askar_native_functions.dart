import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef AskarVersionNative = Pointer<Utf8> Function();

typedef AskarSessionStartNative = Int32 Function(
  Int32 handle,
  Pointer<Utf8> profile,
  Int8 as_transaction,
  Pointer<NativeFunction<Void Function(Int32, Int32, Int32)>> cb,
  Int32 cb_id,
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
