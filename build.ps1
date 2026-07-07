# i'm right here — build: compile the Twee source to index.html at the repo root.
# index.html IS the work product (committed; GitHub Pages serves it directly).
#
# Tweego is not vendored here. The build borrows the sewer-demons toolchain
# (../sewer-demons/.tools/) or uses $env:TWEEGO / a tweego on PATH. TWEEGO_PATH
# must point at a storyformats dir containing SugarCube 2.37 or the compile
# fails on the version pin in StoryData.
#
# Run:  .\build.ps1

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

$tweego = $env:TWEEGO
if (-not $tweego) {
    $sibling = Join-Path $root "..\sewer-demons\.tools\tweego.exe"
    if (Test-Path $sibling) {
        $tweego = $sibling
        if (-not $env:TWEEGO_PATH) {
            $env:TWEEGO_PATH = Join-Path $root "..\sewer-demons\.tools\storyformats"
        }
    }
    else {
        $tweego = "tweego"
    }
}

& $tweego -o (Join-Path $root "index.html") (Join-Path $root "src")
if (-not $?) { Write-Error "tweego compile failed"; exit 1 }

Write-Host "Build OK -> index.html"
