# Script pour modifier LD.exe et changer l'URL de téléchargement des cheats
# Utilise dnSpy ou ILSpy pour décompiler, modifier, et recompiler

param(
    [string]$OldRepo = "forensics-honor/exe",
    [string]$NewRepo = "TON_USERNAME/TON_REPO",
    [string]$OldTag = "CHT",
    [string]$NewTag = "CHT"
)

Write-Host "=== MODIFICATION DE LD.EXE ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "L'URL dans LD.exe est probablement construite dynamiquement."
Write-Host "Il faut décompiler LD.exe, modifier le code, et recompiler."
Write-Host ""
Write-Host "MÉTHODE 1: Utiliser dnSpy (Recommandé)"
Write-Host "1. Télécharger dnSpy: https://github.com/dnSpy/dnSpy/releases"
Write-Host "2. Ouvrir LD.exe dans dnSpy"
Write-Host "3. Chercher la méthode 'getCheatUrl' dans 'HollowClicker.Form1'"
Write-Host "4. Modifier l'URL pour pointer vers ton repo:"
Write-Host "   Ancien: https://github.com/$OldRepo/releases/download/$OldTag/"
Write-Host "   Nouveau: https://github.com/$NewRepo/releases/download/$NewTag/"
Write-Host "5. Fichier > Enregistrer le module (Ctrl+Shift+S)"
Write-Host ""
Write-Host "MÉTHODE 2: Utiliser ILSpy + Reflexil"
Write-Host "1. Télécharger ILSpy: https://github.com/icsharpcode/ILSpy/releases"
Write-Host "2. Installer le plugin Reflexil"
Write-Host "3. Ouvrir LD.exe, chercher getCheatUrl, modifier, sauvegarder"
Write-Host ""
Write-Host "MÉTHODE 3: Patch binaire (avancé)"
Write-Host "Si l'URL est en clair dans le binaire, on peut la remplacer directement."
Write-Host ""

# Tentative de patch binaire
$ldPath = "LD.exe"
if (Test-Path $ldPath) {
    Write-Host "Tentative de patch binaire..." -ForegroundColor Yellow
    $bytes = [System.IO.File]::ReadAllBytes($ldPath)
    $oldUrl = "https://github.com/$OldRepo/releases/download/$OldTag/"
    $newUrl = "https://github.com/$NewRepo/releases/download/$NewTag/"
    
    # Essayer UTF8
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    if ($text.Contains($oldUrl)) {
        $text = $text.Replace($oldUrl, $newUrl)
        $newBytes = [System.Text.Encoding]::UTF8.GetBytes($text)
        [System.IO.File]::WriteAllBytes("LD_modified.exe", $newBytes)
        Write-Host "✓ Patch réussi! Fichier créé: LD_modified.exe" -ForegroundColor Green
    } else {
        Write-Host "✗ URL non trouvée en clair. Il faut décompiler/recompiler." -ForegroundColor Red
    }
} else {
    Write-Host "✗ LD.exe non trouvé dans le répertoire actuel" -ForegroundColor Red
}

Write-Host ""
Write-Host "Après modification, encode LD_modified.exe en base64:"
Write-Host '  $bytes = [System.IO.File]::ReadAllBytes("LD_modified.exe")'
Write-Host '  $base64 = [Convert]::ToBase64String($bytes)'
Write-Host '  [System.IO.File]::WriteAllText("file.txt", $base64)'
Write-Host ""

