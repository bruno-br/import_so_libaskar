import 'package:import_so_libaskar/askar/askar_error_code.dart';
import 'package:import_so_libaskar/askar/callback_native_functions.dart';

base class CallbackResult {
  final ErrorCode errorCode;
  final int handle;
  final bool finished;

  CallbackResult(this.errorCode, this.handle, this.finished);
}

int getNextCallbackId() {
  return nativeNextCallbackId();
}

CallbackResult getCallbackParams(int callbackId) {
  final callbackParams = nativeGetCallbackParams(callbackId);

  print(
      'CallbackId: ${callbackId}, ErrorCode: ${callbackParams.err}, StoreHandle: ${callbackParams.handle}, Finished: ${callbackParams.finished}');

  return CallbackResult(intToErrorCode(callbackParams.err), callbackParams.handle, callbackParams.finished);
}
