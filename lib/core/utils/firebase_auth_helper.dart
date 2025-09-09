class FirebaseAuthHelper {
  /// Traduz códigos de erro do Firebase Auth para mensagens em português
  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      // Erros de login
      case 'invalid-email':
        return 'O endereço de e-mail não é válido.';
      case 'user-disabled':
        return 'Esta conta foi desabilitada.';
      case 'user-not-found':
        return 'Usuário não encontrado. Verifique seu e-mail.';
      case 'wrong-password':
        return 'Senha incorreta. Tente novamente.';
      case 'invalid-credential':
        return 'As credenciais fornecidas estão incorretas, malformadas ou expiraram.';
      case 'too-many-requests':
        return 'Muitas tentativas de login. Tente novamente mais tarde.';
      case 'network-request-failed':
        return 'Erro de conexão. Verifique sua internet.';
      
      // Erros de cadastro
      case 'email-already-in-use':
        return 'Este e-mail já está sendo usado por outra conta.';
      case 'operation-not-allowed':
        return 'Operação não permitida. Entre em contato com o suporte.';
      case 'weak-password':
        return 'A senha é muito fraca. Use pelo menos 6 caracteres.';
      
      // Erros de redefinição de senha
      case 'invalid-action-code':
        return 'Código de ação inválido ou expirado.';
      case 'expired-action-code':
        return 'O código de redefinição de senha expirou.';
      case 'invalid-continue-uri':
        return 'URL de continuação inválida.';
      
      // Erros de reautenticação
      case 'requires-recent-login':
        return 'Esta operação requer login recente. Faça login novamente.';
      case 'credential-already-in-use':
        return 'Esta credencial já está associada a uma conta diferente.';
      
      // Erros gerais
      case 'internal-error':
        return 'Erro interno do servidor. Tente novamente.';
      case 'invalid-api-key':
        return 'Chave de API inválida.';
      case 'app-deleted':
        return 'Aplicativo foi deletado.';
      case 'quota-exceeded':
        return 'Cota excedida. Tente novamente mais tarde.';
      
      // Erros de configuração
      case 'missing-android-pkg-name':
        return 'Nome do pacote Android ausente.';
      case 'missing-continue-uri':
        return 'URL de continuação ausente.';
      case 'missing-ios-bundle-id':
        return 'ID do pacote iOS ausente.';
      case 'invalid-dynamic-link-domain':
        return 'Domínio de link dinâmico inválido.';
      
      // Erro padrão
      default:
        return 'Ocorreu um erro inesperado. Tente novamente.';
    }
  }
  
  /// Verifica se o erro é relacionado à conectividade
  static bool isNetworkError(String errorCode) {
    return [
      'network-request-failed',
      'too-many-requests',
    ].contains(errorCode);
  }
  
  /// Verifica se o erro é relacionado às credenciais
  static bool isCredentialError(String errorCode) {
    return [
      'invalid-credential',
      'wrong-password',
      'user-not-found',
      'invalid-email',
    ].contains(errorCode);
  }
  
  /// Verifica se o erro é relacionado ao cadastro
  static bool isRegistrationError(String errorCode) {
    return [
      'email-already-in-use',
      'weak-password',
      'operation-not-allowed',
    ].contains(errorCode);
  }
}
