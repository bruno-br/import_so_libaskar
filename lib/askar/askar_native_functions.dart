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

base class ArcHandleFfiEntryList extends Struct {
  external Pointer<Void> _0;
}

typedef CallbackId = Int64;

typedef ScanHandle = IntPtr;
typedef StoreHandle = IntPtr;
typedef SessionHandle = IntPtr;

typedef EntryListHandle = Pointer<ArcHandleFfiEntryList>;

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

final DynamicLibrary nativeLib =
    DynamicLibrary.open('android/app/src/main/libaries_askar/libaries_askar.so');

final Pointer<Utf8> Function() nativeAskarVersion = nativeLib
    .lookup<NativeFunction<Pointer<Utf8> Function()>>('askar_version')
    .asFunction();

final int Function(Pointer<Pointer<Utf8>> error_json_p) nativeAskarGetCurrentError =
    nativeLib
        .lookup<NativeFunction<Int32 Function(Pointer<Pointer<Utf8>> error_json_p)>>(
            'askar_get_current_error')
        .asFunction();

final void Function(Pointer<SecretBuffer> buffer) nativeAskarBufferFree = nativeLib
    .lookup<NativeFunction<Void Function(Pointer<SecretBuffer> buffer)>>(
        'askar_buffer_free')
    .asFunction();

final void Function() nativeAskarClearCustomLogger = nativeLib
    .lookup<NativeFunction<Void Function()>>('askar_clear_custom_logger')
    .asFunction();

typedef AskarSetCustomLoggerNative = Int32 Function(
  Pointer<Void> context,
  Pointer<NativeFunction<LogCallback>> log,
  Pointer<OptionEnabledCallbackStruct> enabled,
  Pointer<OptionFlushCallbackStruct> flush,
  Int32 max_level,
);

final int Function(
  Pointer<Void> context,
  Pointer<NativeFunction<LogCallback>> log,
  Pointer<OptionEnabledCallbackStruct> enabled,
  Pointer<OptionFlushCallbackStruct> flush,
  int max_level,
) nativeAskarSetCustomLogger = nativeLib
    .lookup<NativeFunction<AskarSetCustomLoggerNative>>('askar_set_custom_logger')
    .asFunction();

final int Function() nativeAskarSetDefaultLogger = nativeLib
    .lookup<NativeFunction<Int32 Function()>>('askar_set_default_logger')
    .asFunction();

final int Function(int max_level) nativeAskarSetMaxLogLevel = nativeLib
    .lookup<NativeFunction<Int32 Function(Int32 max_level)>>('askar_set_max_log_level')
    .asFunction();

typedef AskarEntryListCountNative = Int32 Function(
    EntryListHandle handle, Pointer<Int32> count);

final int Function(EntryListHandle handle, Pointer<Int32> count)
    nativeAskarEntryListCount = nativeLib
        .lookup<NativeFunction<AskarEntryListCountNative>>('askar_entry_list_count')
        .asFunction();

typedef AskarEntryListFreeNative = Void Function(EntryListHandle handle);

final void Function(EntryListHandle handle) nativeAskarEntryListFree = nativeLib
    .lookup<NativeFunction<AskarEntryListFreeNative>>('askar_entry_list_free')
    .asFunction();

typedef AskarEntryListGetCategoryNative = Int32 Function(
  EntryListHandle handle,
  Int32 index,
  Pointer<Pointer<Utf8>> category,
);

final int Function(
  EntryListHandle handle,
  int index,
  Pointer<Pointer<Utf8>> category,
) nativeAskarEntryListGetCategory = nativeLib
    .lookup<NativeFunction<AskarEntryListGetCategoryNative>>(
        'askar_entry_list_get_category')
    .asFunction();

typedef AskarEntryListGetNameNative = Int32 Function(
  EntryListHandle handle,
  Int32 index,
  Pointer<Pointer<Utf8>> name,
);

final int Function(
  EntryListHandle handle,
  int index,
  Pointer<Pointer<Utf8>> name,
) nativeAskarEntryListGetName = nativeLib
    .lookup<NativeFunction<AskarEntryListGetNameNative>>('askar_entry_list_get_name')
    .asFunction();

typedef AskarEntryListGetTagsNative = Int32 Function(
  EntryListHandle handle,
  Int32 index,
  Pointer<Pointer<Utf8>> tags,
);

final int Function(
  EntryListHandle handle,
  int index,
  Pointer<Pointer<Utf8>> tags,
) nativeAskarEntryListGetTags = nativeLib
    .lookup<NativeFunction<AskarEntryListGetTagsNative>>('askar_entry_list_get_tags')
    .asFunction();

typedef AskarEntryListGetValueNative = Int32 Function(
  EntryListHandle handle,
  Int32 index,
  Pointer<SecretBuffer> value,
);

final int Function(
  EntryListHandle handle,
  int index,
  Pointer<SecretBuffer> value,
) nativeAskarEntryListGetValue = nativeLib
    .lookup<NativeFunction<AskarEntryListGetValueNative>>('askar_entry_list_get_value')
    .asFunction();

typedef AskarSessionStartNative = Int32 Function(
  StoreHandle handle,
  Pointer<Utf8> profile,
  Int8 as_transaction,
  Pointer<NativeFunction<Void Function(CallbackId, Int32, SessionHandle)>> cb,
  CallbackId cb_id,
);

final int Function(
  int handle,
  Pointer<Utf8> profile,
  int as_transaction,
  Pointer<NativeFunction<Void Function(CallbackId, Int32, SessionHandle)>> cb,
  int cb_id,
) nativeAskarSessionStart = nativeLib
    .lookup<NativeFunction<AskarSessionStartNative>>('askar_session_start')
    .asFunction();

typedef AskarStoreProvisionNative = Int32 Function(
  Pointer<Utf8> spec_uri,
  Pointer<Utf8> key_method,
  Pointer<Utf8> pass_key,
  Pointer<Utf8> profile,
  Int8 recreate,
  Pointer<NativeFunction<Void Function(Int32, Int32, StoreHandle)>> cb,
  CallbackId cb_id,
);

final int Function(
  Pointer<Utf8> spec_uri,
  Pointer<Utf8> key_method,
  Pointer<Utf8> pass_key,
  Pointer<Utf8> profile,
  int recreate,
  Pointer<NativeFunction<Void Function(Int32, Int32, StoreHandle)>> cb,
  int cb_id,
) nativeAskarStoreProvision = nativeLib
    .lookup<NativeFunction<AskarStoreProvisionNative>>('askar_store_provision')
    .asFunction();
