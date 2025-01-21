import 'package:import_so_libaskar/askar/askar_error_code.dart';
import 'package:test/test.dart';
import 'package:import_so_libaskar/askar/askar_wrapper.dart';

void main() {
  group('AskarError tests', () {
    test('Askar Store Provision - Deve criar um arquivo "storage.db" e retornar sucesso',
        () {
      final String specUri = 'sqlite://storage.db';
      final String keyMethod = 'raw';
      final String passKey = 'mySecretKey';
      final String profile = 'rekey';
      final int recreate = 1; // 1 para recriar, 0 para manter

      final result = askarStoreProvision(specUri, keyMethod, passKey, profile, recreate);

      // Imprime os resultados
      print('Resultado: ${result}');

      expect(result, equals(ErrorCode.Success));
    });
  });
}
