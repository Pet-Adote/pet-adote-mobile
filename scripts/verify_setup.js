#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('🔍 VERIFICANDO CONFIGURAÇÃO DO SISTEMA DE DENÚNCIAS...\n');

let allGood = true;

// Verificar arquivos essenciais
const requiredFiles = [
  { file: 'package.json', desc: 'Configuração npm' },
  { file: 'email_processor.js', desc: 'Processador principal' },
  { file: 'test_email.js', desc: 'Script de teste' },
  { file: 'petadote-service-account.json', desc: 'Chave Firebase' }
];

console.log('📁 Verificando arquivos...');
requiredFiles.forEach(({ file, desc }) => {
  const exists = fs.existsSync(path.join(__dirname, file));
  console.log(`${exists ? '✅' : '❌'} ${file} - ${desc}`);
  if (!exists) allGood = false;
});

// Verificar dependências
console.log('\n📦 Verificando dependências...');
try {
  const pkg = require('./package.json');
  const requiredDeps = ['firebase-admin', 'nodemailer'];
  
  requiredDeps.forEach(dep => {
    const exists = pkg.dependencies && pkg.dependencies[dep];
    console.log(`${exists ? '✅' : '❌'} ${dep}`);
    if (!exists) allGood = false;
  });
} catch (e) {
  console.log('❌ Erro ao ler package.json');
  allGood = false;
}

// Verificar configuração do email
console.log('\n📧 Verificando configuração de email...');
try {
  const testEmailContent = fs.readFileSync('./test_email.js', 'utf8');
  const hasGmailConfig = testEmailContent.includes('pet.adote2025@gmail.com');
  const hasPassword = !testEmailContent.includes('SUBSTITUA_PELA_SENHA_DE_APP');
  
  console.log(`${hasGmailConfig ? '✅' : '❌'} Email configurado`);
  console.log(`${hasPassword ? '✅' : '❌'} Senha de app configurada`);
  
  if (!hasGmailConfig || !hasPassword) allGood = false;
} catch (e) {
  console.log('❌ Erro ao verificar configuração de email');
  allGood = false;
}

// Verificar Firebase
console.log('\n🔥 Verificando Firebase...');
try {
  const serviceAccount = require('./petadote-service-account.json');
  const hasProjectId = serviceAccount.project_id === 'petadote-7fa2d';
  const hasPrivateKey = serviceAccount.private_key && serviceAccount.private_key.length > 100;
  
  console.log(`${hasProjectId ? '✅' : '❌'} Projeto correto (petadote-7fa2d)`);
  console.log(`${hasPrivateKey ? '✅' : '❌'} Chave privada válida`);
  
  if (!hasProjectId || !hasPrivateKey) allGood = false;
} catch (e) {
  console.log('❌ Erro ao verificar chave Firebase');
  allGood = false;
}

// Resultado final
console.log('\n' + '='.repeat(50));
if (allGood) {
  console.log('🎉 CONFIGURAÇÃO COMPLETA E VÁLIDA!');
  console.log('\n📋 Próximos passos:');
  console.log('1. npm test          # Testar email');
  console.log('2. npm run watch     # Iniciar monitor');
  console.log('3. flutter run       # Executar app');
  console.log('4. Fazer denúncia no app e verificar email');
} else {
  console.log('❌ CONFIGURAÇÃO INCOMPLETA');
  console.log('\n🔧 Consulte o arquivo GUIA_SETUP_DEVS.md para instruções completas');
  process.exit(1);
}

console.log('='.repeat(50));
