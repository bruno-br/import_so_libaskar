import 'package:import_so_libaskar/askar/askar_error_code.dart';
import 'package:import_so_libaskar/askar/askar_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:import_so_libaskar/main.dart';

void main() {
  group('AskarError tests', () {
    test('Askar Version - Retorna versão do Askar', () {
      final result = askarVersion();
      expect(result, equals('0.3.2'));
    });

    testWidgets('Askar Store Provision', (WidgetTester tester) async {
      // Faz build do app.
      await tester.pumpWidget(const MyApp());

      // Cria uma carteira
      expect(storeProvisionTest(), equals(ErrorCode.Success));

      // Abre a carteira
      expect(storeOpenTest(), equals(ErrorCode.Success));

      // Fecha a carteira
      expect(storeCloseTest(), equals(ErrorCode.Success));
    });
  });
}

ErrorCode storeProvisionTest() {
  final String specUri = 'sqlite://storage.db';
  final String keyMethod = 'raw';
  final String passKey = 'mySecretKey';
  final String profile = 'rekey';
  final int recreate = 1; // 1 para recriar, 0 para manter

  final result = askarStoreProvision(specUri, keyMethod, passKey, profile, recreate);

  print('Store Provision Result: ${result}');

  return result;
}

ErrorCode storeOpenTest() {
  final String specUri = 'sqlite://storage.db';
  final String keyMethod = 'raw';
  final String passKey = 'mySecretKey';
  final String profile = 'rekey';

  final result = askarStoreOpen(specUri, keyMethod, passKey, profile);

  print('Store Open Result: ${result}');

  return result;
}

ErrorCode storeCloseTest() {
  final int handle = 1; // 0 = não remove os dados do store

  final result = askarStoreClose(handle);

  print('Store Close Result: ${result}');

  return result;
}
