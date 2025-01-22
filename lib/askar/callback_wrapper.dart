import 'package:import_so_libaskar/askar/askar_error_code.dart';
import 'package:import_so_libaskar/askar/callback_native_functions.dart';

base class CallbackResult {
  final ErrorCode errorCode;
  final int handle;

  CallbackResult(this.errorCode, this.handle);
}

int getNextCallbackId() {
  return nativeNextCallbackId();
}

CallbackResult getCallbackParams(int callbackId) {
  final callbackParams = nativeGetCallbackParams(callbackId);

  print(
      'CallbackId: ${callbackId}, ErrorCode: ${callbackParams.err}, StoreHandle: ${callbackParams.handle}');

  return CallbackResult(intToErrorCode(callbackParams.err), callbackParams.handle);
}
