#include <stdio.h>
#include <stdint.h>

typedef int32_t ErrorCode;
typedef int64_t CallbackId;
typedef int64_t StoreHandle;

struct CallbackParams {
    CallbackId cb_id;
    ErrorCode err;
    StoreHandle handle;
};

CallbackParams g_callback_params;

extern "C" void cb_with_handle(CallbackId cb_id, ErrorCode err, StoreHandle handle) {
    g_callback_params.cb_id = cb_id;
    g_callback_params.err = err;
    g_callback_params.handle = handle;
}

extern "C" CallbackParams get_callback_params() {
    return g_callback_params;
}

extern "C" void cb_without_handle(CallbackId cb_id, ErrorCode err) {
    // Handle the callback logic here
    if (err != 0) {
        // Handle error
        printf("Error: %d\n", err);
    } else {
        // Handle success
        printf("Success\n");
    }
}