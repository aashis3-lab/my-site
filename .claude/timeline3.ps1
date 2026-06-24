
$filePath = "C:\Users\prsha\portfolio\index.html"
$v = [System.IO.File]::ReadAllLines($filePath, [System.Text.Encoding]::UTF8)
$r = [System.Collections.Generic.List[string]]::new($v)
Write-Host "Loaded $($r.Count) lines"

# Find CSS block bounds dynamically
$cssStart = -1; $cssEnd = -1
for ($i = 0; $i -lt $r.Count; $i++) {
  if ($cssStart -eq -1 -and $r[$i] -match 'Horizontal Work Timeline') { $cssStart = $i }
  if ($cssStart -ge 0 -and $cssEnd -eq -1 -and $i -gt $cssStart+2 -and $r[$i] -match 'eng-moon') { $cssEnd = $i - 1 }
}
Write-Host "CSS: 0-idx $cssStart–$cssEnd"

$newCSS = @'
/* ── Horizontal Work Timeline ── */
#work { padding: 8vh 0 5vh; }
.tl-label {
  font-family: 'Inter', sans-serif;
  font-size: 0.72rem;
  font-weight: 300;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: rgba(249,248,245,0.3);
  padding: 0 5vw;
  margin-bottom: 3rem;
}
.tl-scroll-outer {
  overflow-x: auto;
  overflow-y: visible;
  scrollbar-width: none;
  -ms-overflow-style: none;
  cursor: grab;
  -webkit-mask-image: linear-gradient(to right, #000 80%, transparent 100%);
  mask-image: linear-gradient(to right, #000 80%, transparent 100%);
}
.tl-scroll-outer.tl-at-end,
.tl-scroll-outer.tl-no-overflow { -webkit-mask-image: none; mask-image: none; }
.tl-scroll-outer.tl-grabbing { cursor: grabbing !important; }
.tl-scroll-outer::-webkit-scrollbar { display: none; }
.tl-track {
  display: flex;
  align-items: flex-start;
  gap: 8px;
  padding: 2rem 5vw 3.5rem;
  min-width: 100%;
  position: relative;
}
.tl-axis {
  position: absolute;
  left: 0; right: 0;
  top: calc(2rem + 4px);
  height: 1px;
  background: rgba(249,248,245,0.07);
  pointer-events: none;
  z-index: 0;
}
.tl-axis-fill {
  height: 1px;
  width: 0;
  background: linear-gradient(to right, rgba(249,248,245,0.4), rgba(249,248,245,0.08) 85%, transparent);
  transition: width 1.6s cubic-bezier(0.25, 1, 0.5, 1);
}
.tl-track.tl-animated .tl-axis-fill { width: 100%; }
.tl-item {
  flex: 1 0 0;
  min-width: 110px;
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
}
/* Two-property transitions: entry-animation property first, hover property second.
   Stagger delays only target the first (entry) property — hover stays instant. */
.tl-dot {
  width: 8px; height: 8px;
  border-radius: 50%;
  background: rgba(249,248,245,0.55);
  flex-shrink: 0;
  position: relative;
  z-index: 2;
  transform: scale(0);
  transition: transform 0.45s cubic-bezier(0.34, 1.56, 0.64, 1), background 0.2s ease;
}
.tl-track.tl-animated .tl-dot { transform: scale(1); }
.tl-item:hover .tl-dot { background: rgba(249,248,245,0.95); }
.tl-item:nth-child(1) .tl-dot { transition-delay: 0.08s, 0s; }
.tl-item:nth-child(2) .tl-dot { transition-delay: 0.20s, 0s; }
.tl-item:nth-child(3) .tl-dot { transition-delay: 0.32s, 0s; }
.tl-item:nth-child(4) .tl-dot { transition-delay: 0.44s, 0s; }
.tl-item:nth-child(5) .tl-dot { transition-delay: 0.56s, 0s; }
.tl-connector {
  width: 1px; height: 16px;
  background: rgba(249,248,245,0.1);
  flex-shrink: 0;
  transition: background 0.2s ease;
}
.tl-item:hover .tl-connector { background: rgba(249,248,245,0.3); }
/* Pill: 5 properties — opacity is #5 (entry only), others are hover (immediate) */
.tl-pill {
  width: 100%;
  border: 1px solid rgba(249,248,245,0.09);
  border-radius: 10px;
  background: rgba(249,248,245,0.03);
  padding: 0.9rem 1.1rem;
  overflow: hidden;
  opacity: 0;
  transform: translateY(0px);
  transition:
    background    0.22s ease,
    border-color  0.22s ease,
    box-shadow    0.22s ease,
    transform     0.22s ease,
    opacity       0.5s  ease;
}
.tl-track.tl-animated .tl-pill { opacity: 1; }
.tl-item:hover .tl-pill {
  background: rgba(249,248,245,0.08);
  border-color: rgba(249,248,245,0.2);
  box-shadow: 0 8px 28px rgba(0,0,0,0.4);
  transform: translateY(-4px);
}
/* Stagger only the 5th property (opacity) — hover properties 1-4 stay at 0s */
.tl-item:nth-child(1) .tl-pill { transition-delay: 0s, 0s, 0s, 0s, 0.12s; }
.tl-item:nth-child(2) .tl-pill { transition-delay: 0s, 0s, 0s, 0s, 0.24s; }
.tl-item:nth-child(3) .tl-pill { transition-delay: 0s, 0s, 0s, 0s, 0.36s; }
.tl-item:nth-child(4) .tl-pill { transition-delay: 0s, 0s, 0s, 0s, 0.48s; }
.tl-item:nth-child(5) .tl-pill { transition-delay: 0s, 0s, 0s, 0s, 0.60s; }
.tl-company {
  font-family: 'Inter', sans-serif;
  font-size: 0.88rem;
  font-weight: 400;
  color: #f9f8f5;
  display: block;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  margin-bottom: 0.22rem;
}
.tl-role {
  font-family: 'Inter', sans-serif;
  font-size: 0.71rem;
  font-weight: 300;
  color: rgba(249,248,245,0.38);
  display: block;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
/* Grid trick: animates height 0 → auto without max-height guessing */
.tl-pill-body {
  display: grid;
  grid-template-rows: 0fr;
  opacity: 0;
  transition: grid-template-rows 0.28s cubic-bezier(0.25, 1, 0.5, 1), opacity 0.22s ease;
}
.tl-body-inner { overflow: hidden; min-height: 0; }
.tl-item:hover .tl-pill-body {
  grid-template-rows: 1fr;
  opacity: 1;
}
.tl-dates {
  font-family: 'Inter', sans-serif;
  font-size: 0.67rem;
  font-weight: 300;
  color: rgba(249,248,245,0.28);
  display: block;
  margin: 0.75rem 0 0.45rem;
  padding-top: 0.65rem;
  border-top: 1px solid rgba(249,248,245,0.08);
}
.tl-desc {
  font-family: 'Inter', sans-serif;
  font-size: 0.76rem;
  font-weight: 300;
  color: rgba(249,248,245,0.5);
  line-height: 1.62;
  margin-bottom: 0.65rem;
}
.tl-tags { display: flex; flex-wrap: wrap; gap: 0.25rem; }
.tl-tag {
  font-family: 'Inter', sans-serif;
  font-size: 0.63rem;
  font-weight: 400;
  color: rgba(249,248,245,0.34);
  background: rgba(249,248,245,0.05);
  border: 1px solid rgba(249,248,245,0.09);
  border-radius: 100px;
  padding: 0.12rem 0.44rem;
  white-space: nowrap;
}
'@

# Also update HTML to add tl-body-inner wrapper (required for grid trick)
# Find HTML bounds
$htmlStart = -1; $htmlEnd = -1
for ($i = 0; $i -lt $r.Count; $i++) {
  if ($r[$i] -match 'WORK EXPERIENCE TIMELINE') { $htmlStart = $i }
  if ($htmlStart -ge 0 -and $r[$i] -match '#work -->') { $htmlEnd = $i; break }
}
Write-Host "HTML: 0-idx $htmlStart–$htmlEnd"

$newHTML = @'
  <!-- ── WORK EXPERIENCE TIMELINE ── -->
  <div id="work">
    <p class="tl-label">Work Experience</p>
    <div class="tl-scroll-outer">
      <div class="tl-track" id="tlTrack">
        <div class="tl-axis"><div class="tl-axis-fill"></div></div>

        <div class="tl-item">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-pill">
            <span class="tl-company">Pleco Solutions</span>
            <span class="tl-role">Data Analytics Engineer</span>
            <div class="tl-pill-body"><div class="tl-body-inner">
              <span class="tl-dates">May 2026 – Present</span>
              <p class="tl-desc">Built the first AI demand-forecaster for large databases by developing an end-to-end Python-based data pipeline. Pitched the product to Pleco Solution's clients.</p>
              <div class="tl-tags">
                <span class="tl-tag">Snowflake</span><span class="tl-tag">Power BI</span><span class="tl-tag">SQL</span><span class="tl-tag">Supply-Chain</span>
              </div>
            </div></div>
          </div>
        </div>

        <div class="tl-item">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-pill">
            <span class="tl-company">AviLux</span>
            <span class="tl-role">Operations &amp; Regulations Lead</span>
            <div class="tl-pill-body"><div class="tl-body-inner">
              <span class="tl-dates">Jan 2026 – Present</span>
              <p class="tl-desc">Working directly with the founder of an early-stage food-delivery startup on drone deployment. Lead operations and regulations — FAA protocol development, GTM budgets, and launch prep.</p>
              <div class="tl-tags">
                <span class="tl-tag">Regulatory Strategy</span><span class="tl-tag">GTM</span><span class="tl-tag">Drone Tech</span><span class="tl-tag">Operations</span>
              </div>
            </div></div>
          </div>
        </div>

        <div class="tl-item">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-pill">
            <span class="tl-company">Autodesk</span>
            <span class="tl-role">Design &amp; Make Ambassador</span>
            <div class="tl-pill-body"><div class="tl-body-inner">
              <span class="tl-dates">Jun 2025 – May 2026</span>
              <p class="tl-desc">Selected to share the "Design and Make" platform through technical workshops and community-building initiatives.</p>
              <div class="tl-tags">
                <span class="tl-tag">Fusion</span><span class="tl-tag">AutoCAD</span><span class="tl-tag">Technical Education</span>
              </div>
            </div></div>
          </div>
        </div>

        <div class="tl-item">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-pill">
            <span class="tl-company">BSB Design</span>
            <span class="tl-role">Architectural Design Intern</span>
            <div class="tl-pill-body"><div class="tl-body-inner">
              <span class="tl-dates">Aug 2024 &middot; Frisco, TX</span>
              <p class="tl-desc">Translated client requirements into 2D CAD deliverables within a live architectural workflow. Hands-on exposure to stakeholder communication and iterative revision management.</p>
              <div class="tl-tags">
                <span class="tl-tag">Revit</span><span class="tl-tag">2D Drafting</span><span class="tl-tag">Client Communication</span>
              </div>
            </div></div>
          </div>
        </div>

        <div class="tl-item">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-pill">
            <span class="tl-company">Abbott</span>
            <span class="tl-role">Independent Study &amp; Mentorship</span>
            <div class="tl-pill-body"><div class="tl-body-inner">
              <span class="tl-dates">Jan – May 2024 &middot; Irving, TX</span>
              <p class="tl-desc">Conducted a self-directed thermodynamics research project under mentorship from Abbott's Manager of Global Technical Support.</p>
              <div class="tl-tags">
                <span class="tl-tag">Thermodynamics</span><span class="tl-tag">3D Modelling</span><span class="tl-tag">Research</span><span class="tl-tag">CAD</span>
              </div>
            </div></div>
          </div>
        </div>

      </div><!-- /#tlTrack -->
    </div><!-- /.tl-scroll-outer -->
  </div><!-- /#work -->
'@

# Also update mobile CSS to handle tl-body-inner and remove the pill-body override
$mobileStart = -1; $mobileEnd = -1
for ($i = 0; $i -lt $r.Count; $i++) {
  if ($r[$i] -match 'Work Timeline.*mobile') { $mobileStart = $i }
  if ($mobileStart -ge 0 -and $i -gt $mobileStart+3 -and $r[$i] -match 'eng-moon|Engineering moon') { $mobileEnd = $i - 2; break }
}
Write-Host "Mobile CSS: 0-idx $mobileStart–$mobileEnd"

$newMobileCSS = @'

  /* ── Work Timeline — mobile: vertical stack ── */
  .tl-scroll-outer { overflow-x: visible; cursor: default; -webkit-mask-image: none !important; mask-image: none !important; }
  .tl-track { flex-direction: column; gap: 0; padding: 0 6vw 3rem; }
  .tl-axis { display: none; }
  .tl-item { flex: none; width: 100%; min-width: 0 !important; padding-top: 1.2rem; border-top: 1px solid rgba(249,248,245,0.08); align-items: flex-start; cursor: default; }
  .tl-dot, .tl-connector { display: none; }
  .tl-pill { border: none; background: transparent !important; box-shadow: none !important; transform: none !important; padding: 0; opacity: 1 !important; }
  .tl-pill-body { display: block; opacity: 1 !important; grid-template-rows: unset; }
  .tl-body-inner { overflow: visible; }
  .tl-company, .tl-role { white-space: normal; }
'@

# ─── APPLY (highest indices first) ───────────────────────────────────────────

# 3. Replace HTML
$htmlLines = $newHTML -split "`n"
for ($i = $htmlEnd; $i -ge $htmlStart; $i--) { $r.RemoveAt($i) }
foreach ($ln in [Linq.Enumerable]::Reverse($htmlLines)) { $r.Insert($htmlStart, $ln) }

# 2. Replace mobile CSS
$mobileLines = $newMobileCSS -split "`n"
for ($i = $mobileEnd; $i -ge $mobileStart; $i--) { $r.RemoveAt($i) }
foreach ($ln in [Linq.Enumerable]::Reverse($mobileLines)) { $r.Insert($mobileStart, $ln) }

# 1. Replace desktop CSS
$cssLines = $newCSS -split "`n"
for ($i = $cssEnd; $i -ge $cssStart; $i--) { $r.RemoveAt($i) }
foreach ($ln in [Linq.Enumerable]::Reverse($cssLines)) { $r.Insert($cssStart, $ln) }

[System.IO.File]::WriteAllLines($filePath, $r, [System.Text.Encoding]::UTF8)
Write-Host "Done. Lines: $($r.Count), Size: $([Math]::Round((Get-Item $filePath).Length/1MB,2)) MB"

# Verify key classes present
$v2 = [System.IO.File]::ReadAllLines($filePath, [System.Text.Encoding]::UTF8)
$checks = @('tl-body-inner', 'grid-template-rows', 'transition-delay: 0s, 0s, 0s, 0s', 'tl-grabbing')
foreach ($c in $checks) {
  $found = $false
  for ($i = 0; $i -lt $v2.Count; $i++) { if ($v2[$i] -match [regex]::Escape($c)) { $found = $true; break } }
  Write-Host "[$( if ($found) {'OK'} else {'MISSING'})] $c"
}
