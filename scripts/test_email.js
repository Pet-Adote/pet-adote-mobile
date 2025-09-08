// Script simples para testar envio de emails
// Execute: node test_email.js

const nodemailer = require('nodemailer');

// Configuração do Gmail SMTP
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'pet.adote2025@gmail.com',
    pass: 'DIGITE_SENHA_AQUI' // Configure isso abaixo
  }
});

async function testEmail() {
  try {
    console.log('📧 Testando envio de email...');
    
    const testEmailContent = `
🚨 TESTE - SISTEMA DE DENÚNCIAS PETADOTE 🚨

═══════════════════════════════════════
📋 TESTE DE CONFIGURAÇÃO
═══════════════════════════════════════

Este é um email de teste para verificar se o sistema
de denúncias está funcionando corretamente.

Se você recebeu este email, significa que:
✅ A configuração do Gmail está correta
✅ O script Node.js está funcionando
✅ As denúncias serão enviadas automaticamente

═══════════════════════════════════════
⚡ PRÓXIMOS PASSOS
═══════════════════════════════════════

1. Configure a senha de app do Gmail
2. Execute o script principal: npm start
3. Faça uma denúncia no app para testar

Data de Teste: ${new Date().toLocaleString('pt-BR')}
Fonte: Script de Teste PetAdote
`;

    const mailOptions = {
      from: 'pet.adote2025@gmail.com',
      to: 'pet.adote2025@gmail.com',
      subject: '🧪 TESTE - Sistema de Denúncias PetAdote',
      text: testEmailContent
    };

    const result = await transporter.sendMail(mailOptions);
    console.log('✅ Email de teste enviado com sucesso!');
    console.log('📬 ID da mensagem:', result.messageId);
    
  } catch (error) {
    console.error('❌ Erro ao enviar email de teste:', error);
    console.log('\n🔧 PASSOS PARA CORRIGIR:');
    console.log('1. Ative a verificação em 2 etapas no Gmail');
    console.log('2. Gere uma senha de app em: https://myaccount.google.com/apppasswords');
    console.log('3. Substitua "SUBSTITUA_PELA_SENHA_DE_APP" pela senha gerada');
  }
}

testEmail();
