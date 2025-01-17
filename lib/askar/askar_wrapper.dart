import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:import_so_libaskar/askar/askar_error_code.dart';
import 'askar_native_functions.dart';

String askarVersion() {
  Pointer<Utf8> resultPointer = nativeAskarVersion();
  return resultPointer.toDartString();
}

ErrorCode askarSessionStart(
  int handle,
  String profile,
  int asTransaction,
  Pointer<NativeFunction<Void Function(Int32, Int32, Int32)>> cb,
  int cbId,
) {
  final profilePointer = profile.toNativeUtf8();

  final result = nativeAskarSessionStart(
    handle,
    profilePointer,
    asTransaction,
    cb,
    cbId,
  );

  calloc.free(profilePointer);

  return intToErrorCode(result);
}

ErrorCode askarStoreProvision(
  String specUri,
  String keyMethod,
  String passKey,
  String profile,
  int recreate,
  Pointer<NativeFunction<Void Function(Int32, Int32, Pointer<Void>)>> cb,
  int cbId,
) {
  final specUriPointer = specUri.toNativeUtf8();
  final keyMethodPointer = keyMethod.toNativeUtf8();
  final passKeyPointer = passKey.toNativeUtf8();
  final profilePointer = profile.toNativeUtf8();

  final result = nativeAskarStoreProvision(
    specUriPointer,
    keyMethodPointer,
    passKeyPointer,
    profilePointer,
    recreate,
    cb,
    cbId,
  );

  calloc.free(specUriPointer);
  calloc.free(keyMethodPointer);
  calloc.free(passKeyPointer);
  calloc.free(profilePointer);

  return intToErrorCode(result);
}
