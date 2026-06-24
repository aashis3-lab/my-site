
# ── Portfolio index.html comprehensive fix script ──
$filePath = "C:\Users\prsha\portfolio\index.html"
$backupPath = "C:\Users\prsha\portfolio\index.html.bak"

# Backup original
Copy-Item $filePath $backupPath -Force
Write-Host "Backup created: $backupPath"

$lines = [System.IO.File]::ReadAllLines($filePath, [System.Text.Encoding]::UTF8)
Write-Host "Lines loaded: $($lines.Length)"
Write-Host "Size before: $([Math]::Round((Get-Item $filePath).Length / 1MB, 2)) MB"

$result = [System.Collections.Generic.List[string]]::new($lines.Length + 100)
foreach ($l in $lines) { $result.Add($l) }

# ─────────────────────────────────────────────
# ALL CHANGES — applied in REVERSE line order
# so that Insert operations don't shift earlier indices
# ─────────────────────────────────────────────

# ── Fix console.log/error in physics footer ──
# Line 2480 (0-idx 2479): keep catch, remove console.error
$result[2479] = '    } catch(e) { }'
# Line 2478 (0-idx 2477): remove console.log for loop
$result[2477] = ''
# Line 2256 (0-idx 2255): remove console.log W/H
$result[2255] = ''
# Line 2248 (0-idx 2247): remove console.log initPhysics
$result[2247] = ''

# ── Audio: fix forEach to use file paths ──
# Line 1716 (0-idx 1715)
$result[1715] = '  loc.audioUrl = "audios/" + loc.id + ".mp3";'
# Line 1713 (0-idx 1712): remove WELCOME blob line (audioUrl will be set in literal below)
$result[1712] = ''
# Line 1710 (0-idx 1709): WELCOME object — replace b64 property with audioUrl
$result[1709] = '  id: "welcome", name: "to my world", audioUrl: "audios/welcome.mp3",'
# Line 1708 (0-idx 1707): remove WELCOME_B64 — huge base64 string
$result[1707] = ''
# Lines 1701-1707 (0-idx 1700-1706): remove b64ToBlob function + comment
for ($i = 1700; $i -le 1706; $i++) { $result[$i] = '' }
# Lines 1693,1695,1697 (0-idx 1692,1694,1696): remove b64 property from LOCATIONS entries
$result[1692] = $result[1692] -replace ',\s*b64:\s*HOME_B64', ''
$result[1694] = $result[1694] -replace ',\s*b64:\s*SCHOOL_B64', ''
$result[1696] = $result[1696] -replace ',\s*b64:\s*ROOTS_B64', ''
# Lines 1688-1690 (0-idx 1687-1689): remove HOME_B64, SCHOOL_B64, ROOTS_B64 constants
$result[1687] = ''
$result[1688] = ''
$result[1689] = ''

# ── Remove PDF Base64 blob IIFE (lines 1521-1532, 0-idx 1520-1531) ──
for ($i = 1520; $i -le 1531; $i++) { $result[$i] = '' }

# ── PDF iframe: add src="portfolio.pdf" (line 1315, 0-idx 1314) ──
$result[1314] = '        <iframe id="pdfFrame" src="portfolio.pdf" style="display:block;width:100%;border:none;" title="Portfolio PDF"></iframe>'

# ── Add meaningful alt to moon (line 1307, 0-idx 1306) ──
$result[1306] = '  <img src="moon.png" class="eng-moon" alt="Moon illustration">'

# ── Fix 100vh → 100dvh (lines 540, 117; 0-idx 539, 116) ──
$result[539] = '  height: 100dvh;'
$result[116] = '  height: 100dvh;'

# ─────────────────────────────────────────────
# INSERT OPERATIONS (done last, in reverse order of position)
# ─────────────────────────────────────────────

# ── Insert 3D models section HTML after life-values </section> (line 1359, 0-idx 1358) ──
# Insert after index 1358 (at position 1359)
$cadSection = @'

<!-- ── SECTION 4.5: CAD Models ── -->
<section id="cad-models" style="background:#0f0f0f;padding:5rem 2rem 4rem;border-top:1px solid rgba(255,255,255,0.07);">
  <div style="max-width:1200px;margin:0 auto;">
    <p style="font-size:0.72rem;letter-spacing:0.2em;text-transform:uppercase;color:#555;margin-bottom:0.75rem;font-family:'Inter',sans-serif;font-weight:300;">Interactive CAD</p>
    <h2 style="font-family:'League Spartan',sans-serif;font-size:clamp(2.2rem,5vw,3.5rem);color:#f9f8f5;font-weight:700;letter-spacing:-0.02em;margin-bottom:0.5rem;">3D Models</h2>
    <p style="font-size:0.82rem;color:#555;margin-bottom:3.5rem;font-family:'Inter',sans-serif;font-weight:300;">Built in Fusion 360 — drag to rotate, scroll to zoom.</p>
    <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:1px;background:rgba(255,255,255,0.06);">

      <div style="background:#0f0f0f;display:flex;flex-direction:column;overflow:hidden;">
        <div style="height:320px;background:#1a1a1a;position:relative;">
          <model-viewer src="glb/drone.glb" alt="T-Drone M1200 UAV frame designed in Fusion 360"
            camera-controls auto-rotate rotation-per-second="12deg"
            interaction-prompt="none" shadow-intensity="0.6" exposure="1.1"
            style="width:100%;height:100%;--poster-color:transparent;">
          </model-viewer>
        </div>
        <div style="padding:1.1rem 1.4rem;border-top:1px solid rgba(255,255,255,0.06);">
          <p style="font-size:0.65rem;letter-spacing:0.15em;text-transform:uppercase;color:#555;margin-bottom:0.35rem;font-family:'Inter',sans-serif;">UAV · Fusion 360</p>
          <p style="font-size:0.95rem;color:#f9f8f5;font-family:'Inter',sans-serif;font-weight:400;">T-Drone M1200</p>
        </div>
      </div>

      <div style="background:#0f0f0f;display:flex;flex-direction:column;overflow:hidden;">
        <div style="height:320px;background:#1a1a1a;position:relative;">
          <model-viewer src="glb/suspension.glb" alt="Baja SAE offroad racing suspension component"
            camera-controls auto-rotate rotation-per-second="12deg"
            interaction-prompt="none" shadow-intensity="0.6" exposure="1.1"
            style="width:100%;height:100%;--poster-color:transparent;">
          </model-viewer>
        </div>
        <div style="padding:1.1rem 1.4rem;border-top:1px solid rgba(255,255,255,0.06);">
          <p style="font-size:0.65rem;letter-spacing:0.15em;text-transform:uppercase;color:#555;margin-bottom:0.35rem;font-family:'Inter',sans-serif;">Baja SAE · Fusion 360</p>
          <p style="font-size:0.95rem;color:#f9f8f5;font-family:'Inter',sans-serif;font-weight:400;">Offroad Suspension</p>
        </div>
      </div>

      <div style="background:#0f0f0f;display:flex;flex-direction:column;overflow:hidden;">
        <div style="height:320px;background:#1a1a1a;position:relative;">
          <model-viewer src="glb/assembly.glb" alt="Full CAD assembly model built in Fusion 360"
            camera-controls auto-rotate rotation-per-second="12deg"
            interaction-prompt="none" shadow-intensity="0.6" exposure="1.1"
            style="width:100%;height:100%;--poster-color:transparent;">
          </model-viewer>
        </div>
        <div style="padding:1.1rem 1.4rem;border-top:1px solid rgba(255,255,255,0.06);">
          <p style="font-size:0.65rem;letter-spacing:0.15em;text-transform:uppercase;color:#555;margin-bottom:0.35rem;font-family:'Inter',sans-serif;">Assembly · Fusion 360</p>
          <p style="font-size:0.95rem;color:#f9f8f5;font-family:'Inter',sans-serif;font-weight:400;">CAD Assembly</p>
        </div>
      </div>

      <div style="background:#0f0f0f;display:flex;flex-direction:column;overflow:hidden;">
        <div style="height:320px;background:#1a1a1a;position:relative;">
          <model-viewer src="glb/research.glb" alt="Nanostructure research model"
            camera-controls auto-rotate rotation-per-second="12deg"
            interaction-prompt="none" shadow-intensity="0.6" exposure="1.1"
            style="width:100%;height:100%;--poster-color:transparent;">
          </model-viewer>
        </div>
        <div style="padding:1.1rem 1.4rem;border-top:1px solid rgba(255,255,255,0.06);">
          <p style="font-size:0.65rem;letter-spacing:0.15em;text-transform:uppercase;color:#555;margin-bottom:0.35rem;font-family:'Inter',sans-serif;">Research · Fusion 360</p>
          <p style="font-size:0.95rem;color:#f9f8f5;font-family:'Inter',sans-serif;font-weight:400;">Nanostructure Study</p>
        </div>
      </div>

    </div>
  </div>
</section>
'@

$cadLines = $cadSection -split "`n"
# Insert after index 1358 (life-values </section>)
$insertAt = 1359
foreach ($cadLine in [Linq.Enumerable]::Reverse($cadLines)) {
  $result.Insert($insertAt, $cadLine)
}

# ── Add model-viewer script + meta description to <head> ──
# </head> was at 0-idx 1103, now shifted by $cadLines.Count insertions above
# We'll find it by content instead
$headCloseIdx = -1
for ($i = 0; $i -lt $result.Count; $i++) {
  if ($result[$i].Trim() -eq '</head>') { $headCloseIdx = $i; break }
}
Write-Host "Found </head> at index: $headCloseIdx"

# Insert model-viewer script before </head>
$result.Insert($headCloseIdx, '<script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.0.0/model-viewer.min.js"></script>')

# Add meta description — find viewport meta
$viewportIdx = -1
for ($i = 0; $i -lt 20; $i++) {
  if ($result[$i] -match 'name="viewport"') { $viewportIdx = $i; break }
}
Write-Host "Found viewport meta at index: $viewportIdx"
$result.Insert($viewportIdx + 1, '<meta name="description" content="Aashi Shah — Systems Engineering student at UIUC. Data Analytics Engineer, CAD designer, and drone operations lead. Explore my work at the intersection of hardware, software, and people.">')

# ─────────────────────────────────────────────
# WRITE OUTPUT
# ─────────────────────────────────────────────
[System.IO.File]::WriteAllLines($filePath, $result, [System.Text.Encoding]::UTF8)

$newSize = [Math]::Round((Get-Item $filePath).Length / 1MB, 2)
Write-Host ""
Write-Host "Done! Lines after: $($result.Count)"
Write-Host "Size after: $newSize MB"
Write-Host "Reduction: $([Math]::Round(13.51 - $newSize, 2)) MB saved"
