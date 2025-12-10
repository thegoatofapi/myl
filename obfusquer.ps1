# Script d'obfuscation EXACTEMENT comme le pote dans hollow
$scriptPath = "script.ps1"

if (-not (Test-Path $scriptPath)) {
    Write-Host "ERREUR: script.ps1 introuvable!" -ForegroundColor Red
    exit 1
}

Write-Host "Lecture du script.ps1..." -ForegroundColor Cyan
$scriptContent = Get-Content $scriptPath -Raw

# Vérifier si déjà obfusqué
if ($scriptContent.TrimStart().StartsWith(". ((Gv '*MdR*')")) {
    Write-Host "ATTENTION: Le script semble deja obfusque!" -ForegroundColor Yellow
    Write-Host "Voulez-vous quand meme continuer? (O/N)" -ForegroundColor Yellow
    $response = Read-Host
    if ($response -ne 'O' -and $response -ne 'o') {
        Write-Host "Operation annulee." -ForegroundColor Red
        exit 0
    }
    Write-Host "Obfuscation d'un script deja obfusque (peut ne pas fonctionner)..." -ForegroundColor Yellow
} else {
    Write-Host "Obfuscation en cours (methode EXACTE du pote)..." -ForegroundColor Cyan
}
$chars = $scriptContent.ToCharArray()
$obfuscated = @()
$separator = ',f}_aLspo~'

foreach ($char in $chars) {
    $code = [int][char]$char
    $random = Get-Random -Maximum 3
    
    # Mapping EXACT du pote analyse depuis hollow/script.ps1
    switch ($char) {
        '[' { $obfuscated += '91' }
        'S' { 
            if ($random -eq 0) { $obfuscated += 'a' + $code.ToString() }  # a83
            elseif ($random -eq 1) { $obfuscated += '115' }
            else { $obfuscated += $code.ToString() }
        }
        'y' { 
            if ($random -eq 0) { $obfuscated += 'o' + $code.ToString() }  # o121
            elseif ($random -eq 1) { $obfuscated += '97' }
            else { $obfuscated += $code.ToString() }
        }
        's' { 
            if ($random -eq 0) { $obfuscated += '_' + $code.ToString() }  # _115
            elseif ($random -eq 1) { $obfuscated += 'L' }
            elseif ($random -eq 2) { $obfuscated += '76' }
            else { $obfuscated += $code.ToString() }
        }
        't' { 
            if ($random -eq 0) { $obfuscated += 's' + $code.ToString() }  # s116
            elseif ($random -eq 1) { $obfuscated += 'p' }
            elseif ($random -eq 2) { $obfuscated += '112' }
            else { $obfuscated += $code.ToString() }
        }
        'e' { 
            if ($random -eq 0) { $obfuscated += '_' + $code.ToString() }  # _101
            elseif ($random -eq 1) { $obfuscated += 'f' }
            else { $obfuscated += $code.ToString() }
        }
        'm' { 
            if ($random -eq 0) { $obfuscated += 'o' + $code.ToString() }  # o111
            elseif ($random -eq 1) { $obfuscated += '111' }
            else { $obfuscated += $code.ToString() }
        }
        '.' { 
            if ($random -eq 0) { $obfuscated += 'L' + $code.ToString() }  # L46
            elseif ($random -eq 1) { $obfuscated += '126' }
            else { $obfuscated += $code.ToString() }
        }
        'N' { 
            if ($random -eq 0) { $obfuscated += 'a' + $code.ToString() }  # a78
            elseif ($random -eq 1) { $obfuscated += '95' }
            else { $obfuscated += $code.ToString() }
        }
        'T' { 
            if ($random -eq 0) { $obfuscated += 'p' + $code.ToString() }  # p84
            elseif ($random -eq 1) { $obfuscated += '125' }
            else { $obfuscated += $code.ToString() }
        }
        'P' { 
            if ($random -eq 0) { $obfuscated += 'o' + $code.ToString() }  # o80
            elseif ($random -eq 1) { $obfuscated += '44' }
            else { $obfuscated += $code.ToString() }
        }
        ':' { 
            if ($random -eq 0) { $obfuscated += 'f' + $code.ToString() }  # f58
            elseif ($random -eq 1) { $obfuscated += '97' }
            else { $obfuscated += $code.ToString() }
        }
        '=' { 
            if ($random -eq 0) { $obfuscated += 'p' + $code.ToString() }  # p61
            elseif ($random -eq 1) { $obfuscated += '115' }
            else { $obfuscated += $code.ToString() }
        }
        ' ' { 
            if ($random -eq 0) { $obfuscated += '~' + $code.ToString() }  # ~32
            elseif ($random -eq 1) { $obfuscated += '76' }
            elseif ($random -eq 2) { $obfuscated += '32' }
            else { $obfuscated += $code.ToString() }
        }
        "`n" { $obfuscated += '13}10' }
        "`r" { continue }
        default { 
            $obfuscated += $code.ToString()
        }
    }
}

$obfuscatedString = $obfuscated -join $separator

# Structure exacte du pote
$finalCommand = ". ((Gv '*MdR*').NAME[3,11,2]-jOIn'')( `" `$( SeT-iTem 'vaRiAblE:oFS' '') `" + [StrinG]( '$obfuscatedString'.splIt(',f}_aLspo~') |FOreACh { ( [InT]`$_ -AS[ChaR]) }) +`" `$(SEt  'oFs'  ' ' )`" )"

# Sauvegarder sans BOM
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText("$PWD\$scriptPath", $finalCommand, $utf8NoBom)

Write-Host "`nScript obfusque avec succes!" -ForegroundColor Green
Write-Host "Fichier: $PWD\$scriptPath" -ForegroundColor Green
Write-Host "Longueur: $($finalCommand.Length) caracteres" -ForegroundColor Green
