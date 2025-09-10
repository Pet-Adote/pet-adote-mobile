# 🐾 PetAdote

**PetAdote** é um aplicativo desenvolvido para facilitar o processo de adoção de cães e gatos resgatados. A plataforma conecta ONGs, protetores independentes e pessoas interessadas em adotar animais, promovendo a adoção responsável e o bem-estar animal.

## 📱 Descrição

O PetAdote simplifica a jornada de adoção para usuários que buscam praticidade e acesso a informações confiáveis sobre pets disponíveis.

### Funcionalidades principais
- Listagem de animais com foto, nome, idade, sexo, porte, vacinação e descrição.
- Filtros por espécie, porte, sexo, localização e categorias.
- Favoritar pets.
- Perfil completo do pet com botão de contato.
- Cadastro de novo pet (envio de foto e dados).
- Navegação por categorias (cachorros, gatos, etc.).
- Barra de navegação inferior e menu lateral.

O app foi inspirado por plataformas como AdotaPet e OLX Adoção, com foco em adoções locais e parceria com pequenas ONGs regionais.

## 🛠️ Tecnologias utilizadas

Lista sumarizada das tecnologias, bibliotecas e ferramentas usadas no projeto:

- Linguagem e framework
	- Flutter (Dart)

- Backend e serviços
	- Firebase (Authentication, Cloud Firestore, Storage, Cloud Messaging)

- Principais pacotes Flutter (exemplos encontrados no projeto)
	- cloud_firestore
	- firebase_auth
	- firebase_core
	- firebase_storage
	- connectivity_plus
	- image_picker
	- url_launcher
	- share_plus

- Scripts e utilitários
	- Node.js (scripts em `scripts/` que usam `firebase-admin`, `nodemailer`)

- Ferramentas de desenvolvimento
	- Git, Android Studio / VS Code, Flutter CLI

Consulte o `pubspec.yaml` e a pasta `scripts/` para a lista completa de dependências e versões.

## 📌 Protótipo e Backlog

- 💻 [Acessar Slide da Apresentação](https://drive.google.com/file/d/1tppseJlAEVGzjT-a2wD1QehMJmntJ_7B/view?usp=drivesdk)
- 🔗 [Acessar Protótipo no Figma](https://www.figma.com/design/c52xd53drkQAqOK8SjchHO/PetAdote?node-id=0-1&p=f)
- 🗒️ [Acessar Backlog e Plano de Desenvolvimento](https://docs.google.com/document/d/1uuX4fHcee58DXW6_sza1U6ltoJ_X_spGoUQ33atCouE/edit?usp=drive_link)
- 📝 [Acessar Trello](https://trello.com/b/pmKufRar/kanban-quadro-modelo)
- 💻 [Acessar Slide da Apresentação Final](https://drive.google.com/file/d/1YibIQhMkB0ajC5T5-TIXwqlTCXakbSrp/view?usp=sharing)


## ▶️ Como executar

Checklist das pré-condições mínimas:

- Flutter SDK instalado e configurado (versão compatível com o projeto).
- Android SDK / emulador ou dispositivo físico configurado.
- Node.js e npm (para executar scripts na pasta `scripts/`).
- Arquivo `android/app/google-services.json` existente (já presente no repositório) e projeto Firebase configurado.
- (Opcional) Conta de serviço do Firebase para scripts: `scripts/petadote-service-account.json` — NÃO fazer commit deste arquivo.

Passos rápidos (PowerShell):

1) Instalar dependências do Flutter e executar o app:

```powershell
flutter pub get
flutter run
```

2) Executar scripts auxiliares (opcional):

```powershell
cd scripts
npm install
# executar script de teste de e-mail
node test_email.js
# processador que lê o Firestore e envia e-mails (requer arquivo de credenciais)
node email_processor.js
```

3) Executar testes (unitários / widget):

```powershell
flutter test
```

Notas importantes
- Coloque a chave de serviço do Firebase (JSON) em `scripts/petadote-service-account.json` se precisar usar `firebase-admin`. O arquivo não foi commitado.
- Para envio de e-mails via Gmail use senha de app e configure os scripts conforme `GUIA_SETUP_DEVS.md`.

## ✅ Testes

Testes de widget e unitários estão na pasta `test/`. Execute com `flutter test`.

## Arquivos úteis

- `GUIA_SETUP_DEVS.md` — instruções detalhadas de configuração do Firebase e e-mail.
- `scripts/test_email.js` — script de teste de envio de e-mail.
- `scripts/email_processor.js` — processador que pode enviar notificações por e-mail.
- `scripts/verify_setup.js` — verificação de setup.

## 👥 Equipe

| Nome | E-mail |
|---|---|
| Filipe Gomes | filipeandradegomes@gmail.com |
| Felipe Mendes | felipe.mendess@ufape.edu.br |
| Luiz Fellipe | luizfellipedearb@gmail.com |

## 🚧 Status

- Concluído

---

> Projeto desenvolvido como parte da disciplina de desenvolvimento mobile - UFAPE.