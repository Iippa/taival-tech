<#
.SYNOPSIS
    Taival Technologies — Vercel deploy-skripti
    Aja tämä kun haluat deployta nettisivut Verceliin.

.TILA (2026-02-19)
    GitHub Pages: LIVE ✅
    URL: https://iippa.github.io/taival-tech/
    Repo: https://github.com/Iippa/taival-tech
    
    Vercel deploy vaatii kirjautumisen — tee se alla olevilla komennoilla.

.KÄYTTÖ
    1. Aja tämä skripti: .\website\deploy.ps1
    2. Tai aja komennot manuaalisesti askel askeleelta
    
.VAATIMUKSET
    - Node.js / npm (asennettuna: C:\Program Files\nodejs)
    - Vercel-tili osoitteessa: https://vercel.com/signup (ilmainen)
#>

$ErrorActionPreference = "Stop"
$env:PATH += ";C:\Program Files\nodejs;$env:APPDATA\npm"
$websiteDir = "$PSScriptRoot"

Write-Host "🚀 Taival Technologies — Vercel Deploy"
Write-Host "========================================"
Write-Host ""

# ── TARKISTA VERCEL CLI ─────────────────────────────────────
$vercelCmd = "$env:APPDATA\npm\vercel.cmd"
if (-not (Test-Path $vercelCmd)) {
    Write-Host "📦 Asennetaan Vercel CLI..."
    & "C:\Program Files\nodejs\npm.cmd" install -g vercel
    Write-Host "✅ Vercel CLI asennettu"
} else {
    $ver = & $vercelCmd --version 2>$null | Select-Object -First 1
    Write-Host "✅ Vercel CLI löytyy: $ver"
}

Write-Host ""

# ── TARKISTA TOKEN ──────────────────────────────────────────
if ($env:VERCEL_TOKEN) {
    Write-Host "✅ VERCEL_TOKEN löytyy — deployataan suoraan..."
    Write-Host ""
    & $vercelCmd deploy $websiteDir --yes --prod --token $env:VERCEL_TOKEN
} else {
    Write-Host "⚠️  VERCEL_TOKEN puuttuu. Tarvitaan kirjautuminen."
    Write-Host ""
    Write-Host "VAIHTOEHTO A — Kirjaudu interaktiivisesti (avaa selaimen):"
    Write-Host "  vercel login"
    Write-Host "  vercel deploy --yes --prod $websiteDir"
    Write-Host ""
    Write-Host "VAIHTOEHTO B — Käytä tokenia:"
    Write-Host "  1. Mene: https://vercel.com/account/tokens"
    Write-Host "  2. Luo uusi token nimellä 'TaivalDeploy'"
    Write-Host "  3. Aseta ympäristömuuttuja:"
    Write-Host '     $env:VERCEL_TOKEN = "token-tähän"'
    Write-Host "  4. Aja tämä skripti uudelleen"
    Write-Host ""
    Write-Host "VAIHTOEHTO C — GitHub Pages (jo LIVE!):"
    Write-Host "  ✅ https://iippa.github.io/taival-tech/"
    Write-Host ""
    
    # Ask if user wants to login now
    $choice = Read-Host "Haluatko kirjautua nyt? (k/e)"
    if ($choice -eq "k" -or $choice -eq "K" -or $choice -eq "y") {
        Write-Host ""
        Write-Host "Kirjaudutaan Verceliin..."
        & $vercelCmd login
        Write-Host ""
        Write-Host "Deployataan..."
        & $vercelCmd deploy $websiteDir --yes --prod
    }
}

Write-Host ""
Write-Host "📋 GitHub Pages URL (jo toimii):"
Write-Host "   https://iippa.github.io/taival-tech/"
Write-Host ""
Write-Host "📋 GitHub Repo:"
Write-Host "   https://github.com/Iippa/taival-tech"
