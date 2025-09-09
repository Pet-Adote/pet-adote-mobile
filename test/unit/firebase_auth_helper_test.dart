import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/core/utils/firebase_auth_helper.dart';

void main() {
  group('FirebaseAuthHelper (Unit)', () {
    test('deve retornar mensagem traduzida para invalid-email', () {
      final message = FirebaseAuthHelper.getErrorMessage('invalid-email');
      expect(message, 'O endereço de e-mail não é válido.');
    });

    test('deve identificar erros de rede', () {
      final isNetwork = FirebaseAuthHelper.isNetworkError('network-request-failed');
      expect(isNetwork, isTrue);
    });

    test('deve identificar erros de credencial', () {
      final isCredential = FirebaseAuthHelper.isCredentialError('wrong-password');
      expect(isCredential, isTrue);
    });

    test('deve identificar erros de cadastro', () {
      final isRegistration = FirebaseAuthHelper.isRegistrationError('email-already-in-use');
      expect(isRegistration, isTrue);
    });
  });
}