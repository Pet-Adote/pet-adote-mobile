# 📧 GUIA SIMPLES - Email Automático PetAdote

## ⚡ O que você precisa fazer (4 passos apenas!)

### 📦 PASSO 1: Instalar dependências

```bash
cd scripts
npm install
```

### 🔑 PASSO 2: Baixar arquivo do Firebase

1. **Acesse:** https://console.firebase.google.com/project/petadote-7fa2d/settings/serviceaccounts/adminsdk
2. **Clique:** "Gerar nova chave privada"
3. **Salve:** O arquivo como `petadote-service-account.json` na pasta `scripts/`

### 📱 PASSO 3: Gerar senha do Gmail

1. **Acesse:** https://myaccount.google.com/apppasswords
2. **Selecione:** App: "Mail", Dispositivo: "Outro" → "PetAdote"
3. **Copie:** A senha de 16 caracteres (ex: `abcd efgh ijkl mnop`)

### ✏️ PASSO 4: Colocar senha nos 2 arquivos

**Arquivo 1:** `scripts/test_email.js` (linha 11):
```javascript
pass: 'cole_sua_senha_aqui'
```

**Arquivo 2:** `scripts/email_processor.js` (linha 22):
```javascript
pass: 'cole_a_mesma_senha_aqui'
```

*(Use a MESMA senha nos 2 arquivos)*

---

## ✅ TESTAR SE FUNCIONOU

### 1. Testar email:
```bash
cd scripts
npm test
```

### 2. Executar monitor automático:
```bash
npm run watch
```

### 3. No app Flutter:
- Faça login
- Menu → "Denúncia" 
- Preencha e envie

**✅ Email deve chegar em pet.adote2025@gmail.com automaticamente!**

---

## 🆘 NÃO FUNCIONOU?

### ❌ Email não chega?
→ Verificar se a senha do Gmail está correta nos 2 arquivos (`test_email.js` e `email_processor.js`)

### ❌ Erro "Firebase not found"?
→ Verificar se baixou o arquivo `petadote-service-account.json` na pasta `scripts/`

### ❌ Erro "Permission denied"?
→ Fazer login no app primeiro

---

## 📁 Arquivos importantes:

```
scripts/
├── petadote-service-account.json  ← Baixar do Firebase
├── test_email.js                  ← Colocar senha aqui (linha 11)
└── email_processor.js             ← Colocar senha aqui (linha 22)
```

**⚠️ NUNCA commitar o arquivo `petadote-service-account.json`!**
