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

base class EncryptedBuffer extends Struct {
  external SecretBuffer buffer;

  @Int64()
  external int tag_pos;

  @Int64()
  external int nonce_pos;
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

base class ArcHandleFfiStringList extends Struct {
  external Pointer<Void> _0;
}

base class ArcHandleLocalKey extends Struct {
  external Pointer<Void> _0;
}

base class ArcHandleKeyEntryList extends Struct {
  external Pointer<Void> _0;
}

typedef CallbackId = Int64;

typedef ScanHandle = IntPtr;
typedef StoreHandle = IntPtr;
typedef SessionHandle = IntPtr;

typedef EntryListHandle = Pointer<ArcHandleFfiEntryList>;
typedef LocalKeyHandle = Pointer<ArcHandleLocalKey>;
typedef KeyEntryListHandle = Pointer<ArcHandleKeyEntryList>;

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

typedef StringListHandle = Pointer<ArcHandleFfiStringList>;

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

typedef AskarStringListCountNative = Int32 Function(
  StringListHandle handle,
  Pointer<Int32> count,
);

final int Function(
  StringListHandle handle,
  Pointer<Int32> count,
) nativeAskarStringListCount = nativeLib
    .lookup<NativeFunction<AskarStringListCountNative>>('askar_string_list_count')
    .asFunction();

typedef AskarStringListFreeNative = Void Function(StringListHandle handle);

final void Function(StringListHandle handle) nativeAskarStringListFree = nativeLib
    .lookup<NativeFunction<AskarStringListFreeNative>>('askar_string_list_free')
    .asFunction();

typedef AskarStringListGetItemNative = Int32 Function(
  StringListHandle handle,
  Int32 index,
  Pointer<Pointer<Utf8>> item,
);

final int Function(
  StringListHandle handle,
  int index,
  Pointer<Pointer<Utf8>> item,
) nativeAskarStringListGetItem = nativeLib
    .lookup<NativeFunction<AskarStringListGetItemNative>>('askar_string_list_get_item')
    .asFunction();

typedef AskarKeyAeadDecryptNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> ciphertext,
  Pointer<ByteBuffer> nonce,
  Pointer<ByteBuffer> tag,
  Pointer<ByteBuffer> aad,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> ciphertext,
  Pointer<ByteBuffer> nonce,
  Pointer<ByteBuffer> tag,
  Pointer<ByteBuffer> aad,
  Pointer<SecretBuffer> out,
) nativeAskarKeyAeadDecrypt = nativeLib
    .lookup<NativeFunction<AskarKeyAeadDecryptNative>>('askar_key_aead_decrypt')
    .asFunction();

typedef AskarKeyAeadEncryptNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> message,
  Pointer<ByteBuffer> nonce,
  Pointer<ByteBuffer> aad,
  Pointer<EncryptedBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> message,
  Pointer<ByteBuffer> nonce,
  Pointer<ByteBuffer> aad,
  Pointer<EncryptedBuffer> out,
) nativeAskarKeyAeadEncrypt = nativeLib
    .lookup<NativeFunction<AskarKeyAeadEncryptNative>>('askar_key_aead_encrypt')
    .asFunction();

typedef AskarKeyAeadGetPaddingNative = Int32 Function(
  LocalKeyHandle handle,
  Int64 msg_len,
  Pointer<Int32> out,
);

final int Function(
  LocalKeyHandle handle,
  int msg_len,
  Pointer<Int32> out,
) nativeAskarKeyAeadGetPadding = nativeLib
    .lookup<NativeFunction<AskarKeyAeadGetPaddingNative>>('askar_key_aead_get_padding')
    .asFunction();

typedef AskarKeyAeadGetParamsNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<AeadParams> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<AeadParams> out,
) nativeAskarKeyAeadGetParams = nativeLib
    .lookup<NativeFunction<AskarKeyAeadGetParamsNative>>('askar_key_aead_get_params')
    .asFunction();

typedef AskarKeyAeadRandomNonceNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<SecretBuffer> out,
) nativeAskarKeyAeadRandomNonce = nativeLib
    .lookup<NativeFunction<AskarKeyAeadRandomNonceNative>>('askar_key_aead_random_nonce')
    .asFunction();

typedef AskarKeyConvertNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<Utf8> alg,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<Utf8> alg,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyConvert = nativeLib
    .lookup<NativeFunction<AskarKeyConvertNative>>('askar_key_convert')
    .asFunction();

typedef AskarKeyCryptoBoxNative = Int32 Function(
  LocalKeyHandle recip_key,
  LocalKeyHandle sender_key,
  Pointer<ByteBuffer> message,
  Pointer<ByteBuffer> nonce,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle recip_key,
  LocalKeyHandle sender_key,
  Pointer<ByteBuffer> message,
  Pointer<ByteBuffer> nonce,
  Pointer<SecretBuffer> out,
) nativeAskarKeyCryptoBox = nativeLib
    .lookup<NativeFunction<AskarKeyCryptoBoxNative>>('askar_key_crypto_box')
    .asFunction();

typedef AskarKeyCryptoBoxOpenNative = Int32 Function(
  LocalKeyHandle recip_key,
  LocalKeyHandle sender_key,
  Pointer<ByteBuffer> message,
  Pointer<ByteBuffer> nonce,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle recip_key,
  LocalKeyHandle sender_key,
  Pointer<ByteBuffer> message,
  Pointer<ByteBuffer> nonce,
  Pointer<SecretBuffer> out,
) nativeAskarKeyCryptoBoxOpen = nativeLib
    .lookup<NativeFunction<AskarKeyCryptoBoxOpenNative>>('askar_key_crypto_box_open')
    .asFunction();

typedef AskarKeyCryptoBoxRandomNonceNative = Int32 Function(
  Pointer<SecretBuffer> out,
);

final int Function(
  Pointer<SecretBuffer> out,
) nativeAskarKeyCryptoBoxRandomNonce = nativeLib
    .lookup<NativeFunction<AskarKeyCryptoBoxRandomNonceNative>>(
        'askar_key_crypto_box_random_nonce')
    .asFunction();

typedef AskarKeyCryptoBoxSealNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> message,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> message,
  Pointer<SecretBuffer> out,
) nativeAskarKeyCryptoBoxSeal = nativeLib
    .lookup<NativeFunction<AskarKeyCryptoBoxSealNative>>('askar_key_crypto_box_seal')
    .asFunction();

typedef AskarKeyCryptoBoxSealOpenNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> ciphertext,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> ciphertext,
  Pointer<SecretBuffer> out,
) nativeAskarKeyCryptoBoxSealOpen = nativeLib
    .lookup<NativeFunction<AskarKeyCryptoBoxSealOpenNative>>(
        'askar_key_crypto_box_seal_open')
    .asFunction();

typedef AskarKeyDeriveEcdh1puNative = Int32 Function(
  Pointer<Utf8> alg,
  LocalKeyHandle ephem_key,
  LocalKeyHandle sender_key,
  LocalKeyHandle recip_key,
  Pointer<ByteBuffer> alg_id,
  Pointer<ByteBuffer> apu,
  Pointer<ByteBuffer> apv,
  Pointer<ByteBuffer> cc_tag,
  Int8 receive,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  Pointer<Utf8> alg,
  LocalKeyHandle ephem_key,
  LocalKeyHandle sender_key,
  LocalKeyHandle recip_key,
  Pointer<ByteBuffer> alg_id,
  Pointer<ByteBuffer> apu,
  Pointer<ByteBuffer> apv,
  Pointer<ByteBuffer> cc_tag,
  int receive,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyDeriveEcdh1pu = nativeLib
    .lookup<NativeFunction<AskarKeyDeriveEcdh1puNative>>('askar_key_derive_ecdh_1pu')
    .asFunction();

typedef AskarKeyDeriveEcdhEsNative = Int32 Function(
  Pointer<Utf8> alg,
  LocalKeyHandle ephem_key,
  LocalKeyHandle recip_key,
  Pointer<ByteBuffer> alg_id,
  Pointer<ByteBuffer> apu,
  Pointer<ByteBuffer> apv,
  Int8 receive,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  Pointer<Utf8> alg,
  LocalKeyHandle ephem_key,
  LocalKeyHandle recip_key,
  Pointer<ByteBuffer> alg_id,
  Pointer<ByteBuffer> apu,
  Pointer<ByteBuffer> apv,
  int receive,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyDeriveEcdhEs = nativeLib
    .lookup<NativeFunction<AskarKeyDeriveEcdhEsNative>>('askar_key_derive_ecdh_es')
    .asFunction();

typedef AskarKeyEntryListCountNative = Int32 Function(
  KeyEntryListHandle handle,
  Pointer<Int32> count,
);

final int Function(
  KeyEntryListHandle handle,
  Pointer<Int32> count,
) nativeAskarKeyEntryListCount = nativeLib
    .lookup<NativeFunction<AskarKeyEntryListCountNative>>('askar_key_entry_list_count')
    .asFunction();

typedef AskarKeyEntryListFreeNative = Void Function(KeyEntryListHandle handle);

final void Function(KeyEntryListHandle handle) nativeAskarKeyEntryListFree = nativeLib
    .lookup<NativeFunction<AskarKeyEntryListFreeNative>>('askar_key_entry_list_free')
    .asFunction();

typedef AskarKeyEntryListGetAlgorithmNative = Int32 Function(
  KeyEntryListHandle handle,
  Int32 index,
  Pointer<Pointer<Utf8>> alg,
);

final int Function(
  KeyEntryListHandle handle,
  int index,
  Pointer<Pointer<Utf8>> alg,
) nativeAskarKeyEntryListGetAlgorithm = nativeLib
    .lookup<NativeFunction<AskarKeyEntryListGetAlgorithmNative>>(
        'askar_key_entry_list_get_algorithm')
    .asFunction();

typedef AskarKeyEntryListGetMetadataNative = Int32 Function(
  KeyEntryListHandle handle,
  Int32 index,
  Pointer<Pointer<Utf8>> metadata,
);

final int Function(
  KeyEntryListHandle handle,
  int index,
  Pointer<Pointer<Utf8>> metadata,
) nativeAskarKeyEntryListGetMetadata = nativeLib
    .lookup<NativeFunction<AskarKeyEntryListGetMetadataNative>>(
        'askar_key_entry_list_get_metadata')
    .asFunction();

typedef AskarKeyEntryListGetNameNative = Int32 Function(
  KeyEntryListHandle handle,
  Int32 index,
  Pointer<Pointer<Utf8>> name,
);

final int Function(
  KeyEntryListHandle handle,
  int index,
  Pointer<Pointer<Utf8>> name,
) nativeAskarKeyEntryListGetName = nativeLib
    .lookup<NativeFunction<AskarKeyEntryListGetNameNative>>(
        'askar_key_entry_list_get_name')
    .asFunction();

typedef AskarKeyEntryListGetTagsNative = Int32 Function(
  KeyEntryListHandle handle,
  Int32 index,
  Pointer<Pointer<Utf8>> tags,
);

final int Function(
  KeyEntryListHandle handle,
  int index,
  Pointer<Pointer<Utf8>> tags,
) nativeAskarKeyEntryListGetTags = nativeLib
    .lookup<NativeFunction<AskarKeyEntryListGetTagsNative>>(
        'askar_key_entry_list_get_tags')
    .asFunction();

typedef AskarKeyEntryListLoadLocalNative = Int32 Function(
  KeyEntryListHandle handle,
  Int32 index,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  KeyEntryListHandle handle,
  int index,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyEntryListLoadLocal = nativeLib
    .lookup<NativeFunction<AskarKeyEntryListLoadLocalNative>>(
        'askar_key_entry_list_load_local')
    .asFunction();

typedef AskarKeyFreeNative = Void Function(LocalKeyHandle handle);

final void Function(LocalKeyHandle handle) nativeAskarKeyFree =
    nativeLib.lookup<NativeFunction<AskarKeyFreeNative>>('askar_key_free').asFunction();

typedef AskarKeyFromJwkNative = Int32 Function(
  Pointer<ByteBuffer> jwk,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  Pointer<ByteBuffer> jwk,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyFromJwk = nativeLib
    .lookup<NativeFunction<AskarKeyFromJwkNative>>('askar_key_from_jwk')
    .asFunction();

typedef AskarKeyFromKeyExchangeNative = Int32 Function(
  Pointer<Utf8> alg,
  LocalKeyHandle sk_handle,
  LocalKeyHandle pk_handle,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  Pointer<Utf8> alg,
  LocalKeyHandle sk_handle,
  LocalKeyHandle pk_handle,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyFromKeyExchange = nativeLib
    .lookup<NativeFunction<AskarKeyFromKeyExchangeNative>>('askar_key_from_key_exchange')
    .asFunction();

typedef AskarKeyFromPublicBytesNative = Int32 Function(
  Pointer<Utf8> alg,
  Pointer<ByteBuffer> public_,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  Pointer<Utf8> alg,
  Pointer<ByteBuffer> public_,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyFromPublicBytes = nativeLib
    .lookup<NativeFunction<AskarKeyFromPublicBytesNative>>('askar_key_from_public_bytes')
    .asFunction();

typedef AskarKeyFromSecretBytesNative = Int32 Function(
  Pointer<Utf8> alg,
  Pointer<ByteBuffer> secret,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  Pointer<Utf8> alg,
  Pointer<ByteBuffer> secret,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyFromSecretBytes = nativeLib
    .lookup<NativeFunction<AskarKeyFromSecretBytesNative>>('askar_key_from_secret_bytes')
    .asFunction();

typedef AskarKeyFromSeedNative = Int32 Function(
  Pointer<Utf8> alg,
  Pointer<ByteBuffer> seed,
  Pointer<Utf8> method,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  Pointer<Utf8> alg,
  Pointer<ByteBuffer> seed,
  Pointer<Utf8> method,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyFromSeed = nativeLib
    .lookup<NativeFunction<AskarKeyFromSeedNative>>('askar_key_from_seed')
    .asFunction();

typedef AskarKeyGenerateNative = Int32 Function(
  Pointer<Utf8> alg,
  Pointer<Utf8> key_backend,
  Int8 ephemeral,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  Pointer<Utf8> alg,
  Pointer<Utf8> key_backend,
  int ephemeral,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyGenerate = nativeLib
    .lookup<NativeFunction<AskarKeyGenerateNative>>('askar_key_generate')
    .asFunction();

typedef AskarKeyGetAlgorithmNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<Pointer<Utf8>> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<Pointer<Utf8>> out,
) nativeAskarKeyGetAlgorithm = nativeLib
    .lookup<NativeFunction<AskarKeyGetAlgorithmNative>>('askar_key_get_algorithm')
    .asFunction();

typedef AskarKeyGetEphemeralNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<Int8> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<Int8> out,
) nativeAskarKeyGetEphemeral = nativeLib
    .lookup<NativeFunction<AskarKeyGetEphemeralNative>>('askar_key_get_ephemeral')
    .asFunction();

typedef AskarKeyGetJwkPublicNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<Utf8> alg,
  Pointer<Pointer<Utf8>> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<Utf8> alg,
  Pointer<Pointer<Utf8>> out,
) nativeAskarKeyGetJwkPublic = nativeLib
    .lookup<NativeFunction<AskarKeyGetJwkPublicNative>>('askar_key_get_jwk_public')
    .asFunction();

typedef AskarKeyGetJwkSecretNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<SecretBuffer> out,
) nativeAskarKeyGetJwkSecret = nativeLib
    .lookup<NativeFunction<AskarKeyGetJwkSecretNative>>('askar_key_get_jwk_secret')
    .asFunction();

typedef AskarKeyGetJwkThumbprintNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<Utf8> alg,
  Pointer<Pointer<Utf8>> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<Utf8> alg,
  Pointer<Pointer<Utf8>> out,
) nativeAskarKeyGetJwkThumbprint = nativeLib
    .lookup<NativeFunction<AskarKeyGetJwkThumbprintNative>>(
        'askar_key_get_jwk_thumbprint')
    .asFunction();

typedef AskarKeyGetPublicBytesNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<SecretBuffer> out,
) nativeAskarKeyGetPublicBytes = nativeLib
    .lookup<NativeFunction<AskarKeyGetPublicBytesNative>>('askar_key_get_public_bytes')
    .asFunction();

typedef AskarKeyGetSecretBytesNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<SecretBuffer> out,
) nativeAskarKeyGetSecretBytes = nativeLib
    .lookup<NativeFunction<AskarKeyGetSecretBytesNative>>('askar_key_get_secret_bytes')
    .asFunction();

typedef AskarKeySignMessageNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> message,
  Pointer<Utf8> sig_type,
  Pointer<SecretBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> message,
  Pointer<Utf8> sig_type,
  Pointer<SecretBuffer> out,
) nativeAskarKeySignMessage = nativeLib
    .lookup<NativeFunction<AskarKeySignMessageNative>>('askar_key_sign_message')
    .asFunction();

typedef AskarKeyUnwrapKeyNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<Utf8> alg,
  Pointer<ByteBuffer> ciphertext,
  Pointer<ByteBuffer> nonce,
  Pointer<ByteBuffer> tag,
  Pointer<LocalKeyHandle> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<Utf8> alg,
  Pointer<ByteBuffer> ciphertext,
  Pointer<ByteBuffer> nonce,
  Pointer<ByteBuffer> tag,
  Pointer<LocalKeyHandle> out,
) nativeAskarKeyUnwrapKey = nativeLib
    .lookup<NativeFunction<AskarKeyUnwrapKeyNative>>('askar_key_unwrap_key')
    .asFunction();

typedef AskarKeyVerifySignatureNative = Int32 Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> message,
  Pointer<ByteBuffer> signature,
  Pointer<Utf8> sig_type,
  Pointer<Int8> out,
);

final int Function(
  LocalKeyHandle handle,
  Pointer<ByteBuffer> message,
  Pointer<ByteBuffer> signature,
  Pointer<Utf8> sig_type,
  Pointer<Int8> out,
) nativeAskarKeyVerifySignature = nativeLib
    .lookup<NativeFunction<AskarKeyVerifySignatureNative>>('askar_key_verify_signature')
    .asFunction();

typedef AskarKeyWrapKeyNative = Int32 Function(
  LocalKeyHandle handle,
  LocalKeyHandle other,
  Pointer<ByteBuffer> nonce,
  Pointer<EncryptedBuffer> out,
);

final int Function(
  LocalKeyHandle handle,
  LocalKeyHandle other,
  Pointer<ByteBuffer> nonce,
  Pointer<EncryptedBuffer> out,
) nativeAskarKeyWrapKey = nativeLib
    .lookup<NativeFunction<AskarKeyWrapKeyNative>>('askar_key_wrap_key')
    .asFunction();

typedef AskarKeyGetSupportedBackendsNative = Int32 Function(
  Pointer<StringListHandle> out,
);

final int Function(
  Pointer<StringListHandle> out,
) nativeAskarKeyGetSupportedBackends = nativeLib
    .lookup<NativeFunction<AskarKeyGetSupportedBackendsNative>>(
        'askar_key_get_supported_backends')
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
