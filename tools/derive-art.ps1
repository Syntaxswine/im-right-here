# derive-art: art/<name>.png (the plates, committed at full weight) -> img/<name>.jpg
# (the web derivatives the story actually loads). Idempotent; run after adding or
# replacing a plate. Max width 840px (2x the ~420px display width), JPEG q82 —
# the ink-wash textures survive this untouched at ~10% of the PNG weight.
#
# Run:  .\tools\derive-art.ps1

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing

$root = Split-Path $PSScriptRoot -Parent
$artDir = Join-Path $root "art"
$imgDir = Join-Path $root "img"
if (-not (Test-Path $imgDir)) { New-Item -ItemType Directory -Path $imgDir | Out-Null }

$maxW = 840
$quality = 82L

$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
    Where-Object { $_.MimeType -eq "image/jpeg" }
$encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
    [System.Drawing.Imaging.Encoder]::Quality, $quality)

Get-ChildItem (Join-Path $artDir "*.png") | ForEach-Object {
    $name = $_.BaseName.ToLowerInvariant()
    $out = Join-Path $imgDir "$name.jpg"
    $src = [System.Drawing.Bitmap]::FromFile($_.FullName)
    try {
        $scale = [Math]::Min(1.0, $maxW / $src.Width)
        $w = [int]($src.Width * $scale)
        $h = [int]($src.Height * $scale)
        $dst = New-Object System.Drawing.Bitmap($w, $h)
        try {
            $g = [System.Drawing.Graphics]::FromImage($dst)
            $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
            $g.DrawImage($src, 0, 0, $w, $h)
            $g.Dispose()
            $dst.Save($out, $codec, $encParams)
        }
        finally { $dst.Dispose() }
        $kb = [math]::Round((Get-Item $out).Length / 1KB)
        Write-Host ("{0}: {1}x{2} -> {3}x{4}, {5} KB" -f $name, $src.Width, $src.Height, $w, $h, $kb)
    }
    finally { $src.Dispose() }
}

Write-Host "Derive OK -> img/"
