import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:import_so_libaskar/askar/askar_error_code.dart';
import 'package:import_so_libaskar/askar/askar_native_functions.dart';
import 'package:import_so_libaskar/askar/askar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:import_so_libaskar/askar/callback_wrapper.dart';
import 'package:import_so_libaskar/main.dart';

void main() {
  group('Askar Tests', () {
    test('Askar Version - Retorna versão do Askar', () {
      final result = askarVersion();
      expect(result, equals('0.3.2'));
    });

    testWidgets('Askar Store', (WidgetTester tester) async {
      // Faz build do app.
      await tester.pumpWidget(const MyApp());

      // Cria uma carteira
      await tester.runAsync(() async {
        final storeProvisionResult = await storeProvisionTest();
        expect(storeProvisionResult.errorCode, equals(ErrorCode.Success));
        expect(storeProvisionResult.finished, equals(true));

        // Abre a carteira
        // final storeOpenResult = storeOpenTest();
        // expect(storeOpenResult.errorCode, equals(ErrorCode.Success));
        // expect(storeOpenResult.finished, true);

        // Inicia uma sessão
        final sessionStartResult = await sessionStartTest(storeProvisionResult.handle);
        expect(sessionStartResult.errorCode, equals(ErrorCode.Success));
        expect(sessionStartResult.finished, equals(true));

        // Insere key
        // final sessionInsertKeyResult = sessionInsertKeyTest(storeOpenResult.handle);
        // expect(sessionInsertKeyResult.errorCode, equals(ErrorCode.Input));
        // expect(sessionInsertKeyResult.finished, true);

        // Atualiza sessao
        // final sessionUpdateResult = sessionUpdateTest(storeOpenResult.handle);
        // expect(sessionUpdateResult.errorCode, equals(ErrorCode.Success));
        // expect(sessionUpdateResult.finished, true);

        // Fecha a carteira
        // expect(storeCloseTest(), equals(ErrorCode.Success));
      });
    });
  });
}

Future<CallbackResult> storeProvisionTest() async {
  final String specUri = 'sqlite://storage.db';
  final String keyMethod = 'kdf:argon2i:mod';
  final String passKey = 'mySecretKey';
  final String profile = 'rekey';
  final int recreate = 1; // 1 para recriar, 0 para manter

  final result =
      await askarStoreProvision(specUri, keyMethod, passKey, profile, recreate);

  print('Store Provision Result: (${result.errorCode}, Handle: ${result.handle})\n');

  return result;
}

CallbackResult storeOpenTest() {
  final String specUri = 'sqlite://storage.db';
  final String keyMethod = 'kdf:argon2i:mod';
  final String passKey = 'mySecretKey';
  final String profile = 'rekey';

  final result = askarStoreOpen(specUri, keyMethod, passKey, profile);

  print('Store Open Result: (${result.errorCode}, Handle: ${result.handle})\n');

  return result;
}

Future<CallbackResult> sessionStartTest(int handle) async {
  String profile = 'rekey';
  int asTransaction = 1;

  final result = await askarSessionStart(handle, profile, asTransaction);

  print('Session Start Result: (${result.errorCode}, Handle: ${result.handle})\n');

  return result;
}

CallbackResult sessionInsertKeyTest(int handle) {
  Pointer<ArcHandleLocalKey> keyHandlePointer = calloc<ArcHandleLocalKey>();
  String name = 'testkey"';
  String metadata = 'meta';
  String reference = 'None';
  Map<String, String> tags = {'a': 'b'};
  int expiryMs = 2000;

  final result =
      askarSessionInsertKey(handle, keyHandlePointer, name, metadata, tags, expiryMs);

  print('Session Insert Key Result: (${result.errorCode}, Handle: ${result.handle})\n');

  calloc.free(keyHandlePointer);

  return result;
}

Future<CallbackResult> sessionUpdateTest(int handle) async {
  int operation = 0;
  String category = 'category-one';
  String name = 'testEntry';
  String value = 'foobar';
  String tags = '';
  int expiryMs = 2000;

  final result =
      askarSessionUpdate(handle, operation, category, name, value, tags, expiryMs);

  print('Session Update Result: (${result.errorCode}, Handle: ${result.handle})\n');

  return result;
}

ErrorCode storeCloseTest() {
  final int handle = 1; // 0 = não remove os dados do store

  final result = askarStoreClose(handle);

  print('Store Close Result: ${result}\n');

  return result;
}
