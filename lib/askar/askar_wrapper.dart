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
  Pointer<NativeFunction<Void Function(CallbackId, Int32, SessionHandle)>> cb,
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

ErrorCode askarGetCurrentError(Pointer<Pointer<Utf8>> errorJsonPointer) {
  final result = nativeAskarGetCurrentError(errorJsonPointer);
  return intToErrorCode(result);
}

void askarBufferFree(Pointer<SecretBuffer> buffer) {
  nativeAskarBufferFree(buffer);
}

void askarClearCustomLogger() {
  nativeAskarClearCustomLogger();
}

ErrorCode askarSetCustomLogger(
  Pointer<Void> context,
  Pointer<NativeFunction<LogCallback>> log,
  Pointer<OptionEnabledCallbackStruct> enabled,
  Pointer<OptionFlushCallbackStruct> flush,
  int maxLevel,
) {
  final result = nativeAskarSetCustomLogger(
    context,
    log,
    enabled,
    flush,
    maxLevel,
  );

  return intToErrorCode(result);
}

ErrorCode askarSetDefaultLogger() {
  final result = nativeAskarSetDefaultLogger();
  return intToErrorCode(result);
}

ErrorCode askarSetMaxLogLevel(int maxLevel) {
  final result = nativeAskarSetMaxLogLevel(maxLevel);
  return intToErrorCode(result);
}

ErrorCode askarEntryListCount(EntryListHandle handle, int count) {
  final countPointer = calloc<Int32>();
  countPointer.value = count;

  final result = nativeAskarEntryListCount(handle, countPointer);

  calloc.free(countPointer);

  return intToErrorCode(result);
}

void askarEntryListFree(EntryListHandle handle) {
  nativeAskarEntryListFree(handle);
}

ErrorCode askarEntryListGetCategory(
    EntryListHandle handle, int index, Pointer<Pointer<Utf8>> category) {
  final result = nativeAskarEntryListGetCategory(handle, index, category);
  return intToErrorCode(result);
}

ErrorCode askarEntryListGetName(
    EntryListHandle handle, int index, Pointer<Pointer<Utf8>> name) {
  final result = nativeAskarEntryListGetName(handle, index, name);
  return intToErrorCode(result);
}

ErrorCode askarEntryListGetTags(
    EntryListHandle handle, int index, Pointer<Pointer<Utf8>> tags) {
  final result = nativeAskarEntryListGetTags(handle, index, tags);
  return intToErrorCode(result);
}

ErrorCode askarEntryListGetValue(
    EntryListHandle handle, int index, Pointer<SecretBuffer> value) {
  final result = nativeAskarEntryListGetValue(handle, index, value);
  return intToErrorCode(result);
}

ErrorCode askarStringListCount(StringListHandle handle, int count) {
  final countPointer = calloc<Int32>();
  countPointer.value = count;

  final result = nativeAskarStringListCount(handle, countPointer);

  final errorCode = intToErrorCode(result);
  count = countPointer.value;

  calloc.free(countPointer);

  return errorCode;
}

void askarStringListFree(StringListHandle handle) {
  nativeAskarStringListFree(handle);
}

ErrorCode askarStringListGetItem(
    StringListHandle handle, int index, Pointer<Pointer<Utf8>> item) {
  final result = nativeAskarStringListGetItem(handle, index, item);
  return intToErrorCode(result);
}

ErrorCode askarKeyAeadDecrypt(
  LocalKeyHandle handle,
  ByteBuffer ciphertext,
  ByteBuffer nonce,
  ByteBuffer tag,
  ByteBuffer aad,
  Pointer<SecretBuffer> out,
) {
  final result = nativeAskarKeyAeadDecrypt(
    handle,
    ciphertext,
    nonce,
    tag,
    aad,
    out,
  );

  return intToErrorCode(result);
}

ErrorCode askarKeyAeadEncrypt(
  LocalKeyHandle handle,
  ByteBuffer message,
  ByteBuffer nonce,
  ByteBuffer aad,
  Pointer<EncryptedBuffer> out,
) {
  final result = nativeAskarKeyAeadEncrypt(
    handle,
    message,
    nonce,
    aad,
    out,
  );

  return intToErrorCode(result);
}

ErrorCode askarKeyAeadGetPadding(
  LocalKeyHandle handle,
  int msgLen,
  Pointer<Int32> out,
) {
  final result = nativeAskarKeyAeadGetPadding(
    handle,
    msgLen,
    out,
  );

  return intToErrorCode(result);
}

ErrorCode askarKeyAeadGetParams(
  LocalKeyHandle handle,
  Pointer<AeadParams> out,
) {
  final result = nativeAskarKeyAeadGetParams(
    handle,
    out,
  );

  return intToErrorCode(result);
}

ErrorCode askarKeyAeadRandomNonce(
  LocalKeyHandle handle,
  Pointer<SecretBuffer> out,
) {
  final result = nativeAskarKeyAeadRandomNonce(
    handle,
    out,
  );

  return intToErrorCode(result);
}

ErrorCode askarStoreProvision(
  String specUri,
  String keyMethod,
  String passKey,
  String profile,
  int recreate,
  Pointer<NativeFunction<Void Function(Int32, Int32, StoreHandle)>> cb,
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
