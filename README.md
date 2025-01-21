# import_so_libaskar

A new Flutter project that imports aries library.

## Atualiza Libs

dart pub get

## Gerar `libcallback.so`:

```bash
g++ -shared -o android/app/src/main/libaries_askar/askar_callbacks.so -fPIC askar_callbacks.cpp
```
