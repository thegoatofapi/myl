# Script de déobfuscation
$scriptPath = "script.ps1"

if (-not (Test-Path $scriptPath)) {
    Write-Host "ERREUR: script.ps1 introuvable!" -ForegroundColor Red
    exit 1
}

Write-Host "Lecture du script.ps1..." -ForegroundColor Cyan
$scriptContent = Get-Content $scriptPath -Raw

# Vérifier si le script est obfusqué
if (-not $scriptContent.TrimStart().StartsWith(". ((Gv '*MdR*')")) {
    Write-Host "Le script ne semble pas etre obfusque!" -ForegroundColor Yellow
    exit 0
}

Write-Host "Deobfuscation en cours..." -ForegroundColor Cyan

# Extraire la partie obfusquée (entre les guillemets simples)
$startIndex = $scriptContent.IndexOf("'") + 1
$endIndex = $scriptContent.LastIndexOf("'")
$obfuscatedPart = $scriptContent.Substring($startIndex, $endIndex - $startIndex)

# Séparer par le séparateur
$separator = ',f}_aLspo~'
$parts = $obfuscatedPart -split [regex]::Escape($separator)

# Déobfusquer chaque partie
$deobfuscated = ""
foreach ($part in $parts) {
    try {
        # Essayer de convertir en caractère
        $charCode = [int]$part
        $char = [char]$charCode
        $deobfuscated += $char
    } catch {
        # Si ce n'est pas un nombre, essayer de parser (peut contenir des lettres)
        try {
            # Certaines parties peuvent être des lettres seules (comme 'L', 'p', 'f', etc.)
            if ($part.Length -eq 1 -and $part -match '[a-zA-Z]') {
                # C'est probablement un caractère ASCII représenté par une lettre
                # Essayer de trouver le code ASCII correspondant
                $charCode = [int][char]$part
                $char = [char]$charCode
                $deobfuscated += $char
            } else {
                # Essayer de parser comme nombre
                $charCode = [int]$part
                $char = [char]$charCode
                $deobfuscated += $char
            }
        } catch {
            # Si ça échoue, essayer de parser avec des lettres devant (ex: a83, o121)
            if ($part -match '^([a-zA-Z])(\d+)$') {
                $letter = $matches[1]
                $number = [int]$matches[2]
                $char = [char]$number
                $deobfuscated += $char
            } else {
                # Si tout échoue, essayer de convertir directement
                try {
                    $charCode = [int]$part
                    $char = [char]$charCode
                    $deobfuscated += $char
                } catch {
                    Write-Host "Partie non parseable: $part" -ForegroundColor Yellow
                }
            }
        }
    }
}

# Sauvegarder le script déobfusqué
$backupPath = "script_obf_backup.ps1"
Copy-Item $scriptPath -Destination $backupPath -Force
Write-Host "Backup cree: $backupPath" -ForegroundColor Cyan

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText("$PWD\$scriptPath", $deobfuscated, $utf8NoBom)

Write-Host "`nScript deobfusque avec succes!" -ForegroundColor Green
Write-Host "Fichier: $PWD\$scriptPath" -ForegroundColor Green
Write-Host "Backup: $PWD\$backupPath" -ForegroundColor Green

