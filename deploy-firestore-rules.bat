@echo off
echo Fazendo deploy das regras do Firestore...
echo.

echo 1. Fazendo login no Firebase...
firebase login

echo.
echo 2. Inicializando projeto Firebase (se necessario)...
firebase init firestore --project petadote-7fa2d

echo.
echo 3. Fazendo deploy das regras...
firebase deploy --only firestore:rules --project petadote-7fa2d

echo.
echo Deploy concluido! Teste a funcionalidade de favoritos no app.
pause