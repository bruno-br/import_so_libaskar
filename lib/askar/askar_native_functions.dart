import 'dart:ffi';
import 'package:ffi/ffi.dart';

// Define the path to the shared library
final DynamicLibrary nativeLib = DynamicLibrary.open('android/app/src/main/libaries_askar/libaries_askar.so');

final Pointer<Utf8> Function() nativeAskarVersion = nativeLib
    .lookup<NativeFunction<Pointer<Utf8> Function()>>('askar_version')
    .asFunction();

