// Script Node.js para processar denúncias do Firestore e enviar emails
// Execute: node email_processor.js

const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

// Configuração do Firebase Admin (usando arquivo de chave de serviço)
const serviceAccount = require('./petadote-service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://petadote-7fa2d-default-rtdb.firebaseio.com'
});

const db = admin.firestore();

// Configuração do Gmail SMTP
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'pet.adote2025@gmail.com',
    pass: 'DIGITE_SENHA_AQUI' // Senha de app que funcionou no teste
  }
});

async function processEmailQueue() {
  try {
    console.log('🔍 Verificando denúncias pendentes...');
    
    // Buscar denúncias que precisam de email
    const snapshot = await db.collection('denounces')
      .where('needsEmailNotification', '==', true)
      .where('emailSent', '==', false)
      .limit(10)
      .get();

    if (snapshot.empty) {
      console.log('✅ Nenhuma denúncia pendente para envio de email.');
      return;
    }

    console.log(`📧 Encontradas ${snapshot.size} denúncias para processar`);

    for (const doc of snapshot.docs) {
      const data = doc.data();
      
      try {
        await sendDenounceEmail(data);
        
        // Marcar como enviado
        await doc.ref.update({
          emailSent: true,
          emailSentAt: admin.firestore.FieldValue.serverTimestamp(),
          emailMethod: 'nodemailer-gmail'
        });
        
        console.log(`✅ Email enviado para denúncia ${data.protocol}`);
        
      } catch (error) {
        console.error(`❌ Erro ao enviar email para denúncia ${data.protocol}:`, error);
        
        // Marcar erro mas não parar o processo
        await doc.ref.update({
          emailError: error.message,
          emailAttempts: (data.emailAttempts || 0) + 1
        });
      }
    }
    
  } catch (error) {
    console.error('❌ Erro geral no processamento:', error);
  }
}

async function sendDenounceEmail(denounceData) {
  const emailBody = `
🚨 NOVA DENÚNCIA RECEBIDA - PETADOTE 🚨

═══════════════════════════════════════
📋 INFORMAÇÕES DA DENÚNCIA
═══════════════════════════════════════

🔸 Protocolo: ${denounceData.protocol}
🔸 Tipo: ${denounceData.typeDisplay}
🔸 Local: ${denounceData.location}
🔸 Data do Ocorrido: ${denounceData.dateOccurred}
🔸 Evidências: ${denounceData.hasImages ? 'Sim' : 'Não'}
🔸 Prioridade: ${denounceData.priority}

📝 DESCRIÇÃO:
${denounceData.description}

═══════════════════════════════════════
👤 INFORMAÇÕES DO DENUNCIANTE
═══════════════════════════════════════

🔸 Tipo: ${denounceData.isAnonymous ? 'Denúncia Anônima' : 'Denúncia Identificada'}
${!denounceData.isAnonymous ? `🔸 Nome: ${denounceData.denouncerName || 'Não informado'}` : ''}
${!denounceData.isAnonymous ? `🔸 Telefone: ${denounceData.denouncerPhone || 'Não informado'}` : ''}

═══════════════════════════════════════
⚡ AÇÃO NECESSÁRIA
═══════════════════════════════════════

Por favor, revise esta denúncia e tome as medidas cabíveis.
Para casos graves, considere contatar as autoridades competentes.

Data de Envio: ${new Date().toLocaleString('pt-BR')}
Fonte: Aplicativo PetAdote
`;

  const mailOptions = {
    from: 'pet.adote2025@gmail.com',
    to: 'pet.adote2025@gmail.com',
    subject: `🚨 DENÚNCIA PETADOTE #${denounceData.protocol} - ${denounceData.typeDisplay}`,
    text: emailBody,
    html: emailBody.replace(/\n/g, '<br>')
  };

  await transporter.sendMail(mailOptions);
}

// Executar uma vez
processEmailQueue().then(() => {
  console.log('Processamento concluído.');
  process.exit(0);
});

// Ou executar em intervalo (descomente para usar)
// setInterval(processEmailQueue, 30000); // A cada 30 segundos
