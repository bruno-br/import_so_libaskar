import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'askar_native_functions.dart';

String askarVersion() {
  Pointer<Utf8> resultPointer = nativeAskarVersion();
  return resultPointer.toDartString();
}
