const admin = require('firebase-admin');
const serviceAccount = require('./petadote-service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

async function checkDenounces() {
  try {
    console.log('🔍 Verificando denúncias no Firestore...');
    const snapshot = await db.collection('denounces').orderBy('createdAt', 'desc').limit(5).get();
    
    if (snapshot.empty) {
      console.log('❌ Nenhuma denúncia encontrada no Firestore');
    } else {
      console.log(`✅ Encontradas ${snapshot.size} denúncias:`);
      snapshot.forEach(doc => {
        const data = doc.data();
        console.log(`- ${data.protocol}: ${data.typeDisplay} em ${data.location}`);
        console.log(`  Status: ${data.status}, Email enviado: ${data.emailSent}`);
      });
    }
    process.exit(0);
  } catch (error) {
    console.error('❌ Erro ao verificar Firestore:', error.message);
    process.exit(1);
  }
}

checkDenounces();
