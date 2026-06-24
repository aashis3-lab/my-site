
$filePath = "C:\Users\prsha\portfolio\index.html"
$lines    = [System.IO.File]::ReadAllLines($filePath, [System.Text.Encoding]::UTF8)
$result   = [System.Collections.Generic.List[string]]::new($lines)
Write-Host "Lines loaded: $($result.Count)"

# ────────────────────────────────────────────────────────────
# NEW CONTENT strings
# ────────────────────────────────────────────────────────────

$newCSS = @'
/* ── Horizontal Work Timeline ── */
#work {
  padding: 8vh 0 5vh;
  overflow: hidden;
}
.tl-label {
  font-family: 'Inter', sans-serif;
  font-size: 0.72rem;
  font-weight: 300;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: rgba(249,248,245,0.3);
  padding: 0 5vw;
  margin-bottom: 3.5rem;
}
.tl-scroll-outer {
  overflow-x: auto;
  overflow-y: visible;
  scrollbar-width: none;
  -ms-overflow-style: none;
  cursor: grab;
  mask-image: linear-gradient(to right, #000 80%, transparent 100%);
  -webkit-mask-image: linear-gradient(to right, #000 80%, transparent 100%);
}
.tl-scroll-outer.tl-at-end,
.tl-scroll-outer.tl-no-overflow {
  mask-image: none;
  -webkit-mask-image: none;
}
.tl-scroll-outer.tl-grabbing { cursor: grabbing; }
.tl-scroll-outer::-webkit-scrollbar { display: none; }
.tl-track {
  display: flex;
  height: 520px;
  padding: 0 5vw;
  min-width: 100%;
  position: relative;
}
.tl-axis {
  position: absolute;
  left: 0; right: 0; top: 50%;
  height: 1px;
  background: rgba(249,248,245,0.07);
  pointer-events: none;
  z-index: 0;
}
.tl-axis-fill {
  height: 1px;
  width: 0;
  background: linear-gradient(to right, rgba(249,248,245,0.38), rgba(249,248,245,0.1) 85%, transparent);
  transition: width 1.6s cubic-bezier(0.25, 1, 0.5, 1);
}
.tl-track.tl-animated .tl-axis-fill { width: 100%; }
.tl-item {
  flex: 1 0 180px;
  max-width: 260px;
  position: relative;
}
.tl-dot {
  position: absolute;
  top: 50%; left: 50%;
  width: 6px; height: 6px;
  border-radius: 50%;
  background: rgba(249,248,245,0.7);
  transform: translate(-50%, -50%) scale(0);
  transition: transform 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
  z-index: 2;
}
.tl-track.tl-animated .tl-dot { transform: translate(-50%, -50%) scale(1); }
.tl-connector {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  width: 1px;
  background: rgba(249,248,245,0.1);
  z-index: 1;
}
.tl-above .tl-connector { bottom: 50%; height: 26px; }
.tl-below .tl-connector { top:    50%; height: 26px; }
.tl-card {
  position: absolute;
  left: 10px; right: 10px;
  opacity: 0;
  transition: opacity 0.6s ease, transform 0.65s cubic-bezier(0.25, 1, 0.5, 1);
}
.tl-above .tl-card { bottom: calc(50% + 32px); transform: translateY(-12px); }
.tl-below .tl-card { top:    calc(50% + 32px); transform: translateY( 12px); }
.tl-track.tl-animated .tl-card { opacity: 1; transform: translateY(0); }
.tl-item:nth-child(1) .tl-dot  { transition-delay: 0.08s; }
.tl-item:nth-child(2) .tl-dot  { transition-delay: 0.24s; }
.tl-item:nth-child(3) .tl-dot  { transition-delay: 0.40s; }
.tl-item:nth-child(4) .tl-dot  { transition-delay: 0.56s; }
.tl-item:nth-child(5) .tl-dot  { transition-delay: 0.72s; }
.tl-item:nth-child(1) .tl-card { transition-delay: 0.16s; }
.tl-item:nth-child(2) .tl-card { transition-delay: 0.32s; }
.tl-item:nth-child(3) .tl-card { transition-delay: 0.48s; }
.tl-item:nth-child(4) .tl-card { transition-delay: 0.64s; }
.tl-item:nth-child(5) .tl-card { transition-delay: 0.80s; }
.tl-company {
  font-family: 'Inter', sans-serif;
  font-size: 0.95rem;
  font-weight: 400;
  color: #f9f8f5;
  display: block;
  margin-bottom: 0.18rem;
}
.tl-dates {
  font-family: 'Inter', sans-serif;
  font-size: 0.71rem;
  font-weight: 300;
  color: rgba(249,248,245,0.3);
  display: block;
  margin-bottom: 0.5rem;
}
.tl-role {
  font-family: 'Inter', sans-serif;
  font-size: 0.8rem;
  font-weight: 300;
  color: rgba(249,248,245,0.45);
  display: block;
  margin-bottom: 0.55rem;
  padding-bottom: 0.55rem;
  border-bottom: 1px solid rgba(249,248,245,0.08);
}
.tl-body {
  font-family: 'Inter', sans-serif;
  font-size: 0.77rem;
  font-weight: 300;
  color: rgba(249,248,245,0.48);
  line-height: 1.65;
  margin-bottom: 0.6rem;
  display: -webkit-box;
  -webkit-line-clamp: 4;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
.tl-tags { display: flex; flex-wrap: wrap; gap: 0.26rem; }
.tl-tag {
  font-family: 'Inter', sans-serif;
  font-size: 0.65rem;
  font-weight: 400;
  color: rgba(249,248,245,0.36);
  background: rgba(249,248,245,0.05);
  border: 1px solid rgba(249,248,245,0.09);
  border-radius: 100px;
  padding: 0.13rem 0.46rem;
  white-space: nowrap;
}
'@

$newMobileCSS = @'

  /* ── Work Timeline — mobile: vertical stack ── */
  .tl-scroll-outer {
    overflow-x: visible;
    cursor: default;
    mask-image: none !important;
    -webkit-mask-image: none !important;
  }
  .tl-track {
    flex-direction: column;
    height: auto;
    padding: 0 6vw;
  }
  .tl-axis { display: none; }
  .tl-item { flex: none; width: auto; max-width: none; padding: 1.4rem 0; border-top: 1px solid rgba(249,248,245,0.1); }
  .tl-dot, .tl-connector { display: none; }
  .tl-card { position: static; opacity: 1 !important; transform: none !important; transition: none !important; }
'@

$newHTML = @'
  <!-- ── WORK EXPERIENCE TIMELINE ── -->
  <div id="work">
    <p class="tl-label">Work Experience</p>
    <div class="tl-scroll-outer">
      <div class="tl-track" id="tlTrack">
        <div class="tl-axis"><div class="tl-axis-fill"></div></div>

        <!-- 1: Pleco — above -->
        <div class="tl-item tl-above">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-card">
            <span class="tl-company">Pleco Solutions</span>
            <span class="tl-dates">May 2026 – Present</span>
            <span class="tl-role">Data Analytics Engineer</span>
            <p class="tl-body">Built the first AI demand-forecaster for large databases by developing an end to end Python-based data pipeline. Pitched the product to Pleco Solution's clients.</p>
            <div class="tl-tags">
              <span class="tl-tag">Snowflake</span><span class="tl-tag">Data Analytics</span><span class="tl-tag">Power BI</span><span class="tl-tag">Supply-Chain</span><span class="tl-tag">SQL</span>
            </div>
          </div>
        </div>

        <!-- 2: AviLux — below -->
        <div class="tl-item tl-below">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-card">
            <span class="tl-company">AviLux</span>
            <span class="tl-dates">Jan 2026 – Present</span>
            <span class="tl-role">Operations &amp; Regulations Lead</span>
            <p class="tl-body">Working directly with the founder of an early-stage food-delivery startup to help ease the deployment of drones efficiently. I lead the operations and regulations team, developing the protocols in FAA accordance and go-to-market budgets, to prepare for launch.</p>
            <div class="tl-tags">
              <span class="tl-tag">Regulatory Strategy</span><span class="tl-tag">GTM</span><span class="tl-tag">Drone Tech</span><span class="tl-tag">Energy Systems</span><span class="tl-tag">Operations</span>
            </div>
          </div>
        </div>

        <!-- 3: Autodesk — above -->
        <div class="tl-item tl-above">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-card">
            <span class="tl-company">Autodesk</span>
            <span class="tl-dates">Jun 2025 – May 2026</span>
            <span class="tl-role">Design &amp; Make Ambassador</span>
            <p class="tl-body">Selected to share the "Design and Make" platform through technical workshops and community-building initiatives.</p>
            <div class="tl-tags">
              <span class="tl-tag">Fusion</span><span class="tl-tag">AutoCAD</span><span class="tl-tag">Technical Education</span><span class="tl-tag">Community Engagement</span>
            </div>
          </div>
        </div>

        <!-- 4: BSB Design — below -->
        <div class="tl-item tl-below">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-card">
            <span class="tl-company">BSB Design</span>
            <span class="tl-dates">Aug 2024</span>
            <span class="tl-role">Architectural Design Intern &middot; Frisco, TX</span>
            <p class="tl-body">Translated client requirements into 2D CAD deliverables and technical specifications within a live architectural workflow, gaining hands-on exposure to stakeholder communication and iterative revision management.</p>
            <div class="tl-tags">
              <span class="tl-tag">Revit</span><span class="tl-tag">2D Drafting</span><span class="tl-tag">Technical Documentation</span><span class="tl-tag">Client Communication</span>
            </div>
          </div>
        </div>

        <!-- 5: Abbott — above -->
        <div class="tl-item tl-above">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-card">
            <span class="tl-company">Abbott</span>
            <span class="tl-dates">Jan 2024 – May 2024</span>
            <span class="tl-role">Independent Study &amp; Mentorship &middot; Irving, TX</span>
            <p class="tl-body">Conducted a self-directed thermodynamics research project under mentorship from Abbott's Manager of Global Technical Support.</p>
            <div class="tl-tags">
              <span class="tl-tag">3D Modelling</span><span class="tl-tag">Simulation</span><span class="tl-tag">Thermodynamics</span><span class="tl-tag">Research</span><span class="tl-tag">CAD</span>
            </div>
          </div>
        </div>

      </div><!-- /#tlTrack -->
    </div><!-- /.tl-scroll-outer -->
  </div><!-- /#work -->
'@

$newScript = @'

<script>
(function () {
  /* ── Work timeline: drag-to-scroll + animated reveal ── */
  var outer = document.querySelector('.tl-scroll-outer');
  var track = document.getElementById('tlTrack');
  if (!outer || !track) return;

  function checkOverflow() {
    if (outer.scrollWidth <= outer.clientWidth + 2) outer.classList.add('tl-no-overflow');
  }
  checkOverflow();
  window.addEventListener('resize', checkOverflow);

  outer.addEventListener('scroll', function () {
    var atEnd = outer.scrollLeft + outer.clientWidth >= outer.scrollWidth - 4;
    outer.classList.toggle('tl-at-end', atEnd);
  }, { passive: true });

  var isDown = false, startX = 0, sl = 0;
  outer.addEventListener('mousedown', function (e) {
    isDown = true; outer.classList.add('tl-grabbing');
    startX = e.pageX - outer.offsetLeft; sl = outer.scrollLeft;
  });
  document.addEventListener('mouseup', function () {
    isDown = false; outer.classList.remove('tl-grabbing');
  });
  outer.addEventListener('mousemove', function (e) {
    if (!isDown) return;
    e.preventDefault();
    outer.scrollLeft = sl - (e.pageX - outer.offsetLeft - startX) * 1.4;
  });

  var obs = new IntersectionObserver(function (entries) {
    if (entries[0].isIntersecting) { track.classList.add('tl-animated'); obs.disconnect(); }
  }, { threshold: 0.15 });
  obs.observe(track);
})();
</script>
'@

# ────────────────────────────────────────────────────────────
# APPLY CHANGES — reverse order so indices stay valid
# ────────────────────────────────────────────────────────────

# ── 4. Insert timeline script after GSAP CDN (0-idx 2188 = line 2189) ──
$scriptLines = $newScript -split "`n"
$gsapIdx = -1
for ($i = 0; $i -lt $result.Count; $i++) {
  if ($result[$i] -match 'ScrollTrigger\.min\.js') { $gsapIdx = $i; break }
}
Write-Host "GSAP ScrollTrigger at 0-idx: $gsapIdx"
foreach ($sl in [Linq.Enumerable]::Reverse($scriptLines)) { $result.Insert($gsapIdx + 1, $sl) }

# ── 3. Replace work HTML (0-idx 1229–1305 = lines 1230–1306) ──
$htmlLines = $newHTML -split "`n"
for ($i = 1305; $i -ge 1229; $i--) { $result.RemoveAt($i) }
foreach ($hl in [Linq.Enumerable]::Reverse($htmlLines)) { $result.Insert(1229, $hl) }

# ── 2. Replace mobile work CSS (0-idx 1016–1026 = lines 1017–1027) ──
$mobileLines = $newMobileCSS -split "`n"
for ($i = 1026; $i -ge 1016; $i--) { $result.RemoveAt($i) }
foreach ($ml in [Linq.Enumerable]::Reverse($mobileLines)) { $result.Insert(1016, $ml) }

# ── 1. Replace desktop work CSS (0-idx 665–737 = lines 666–738) ──
$cssLines = $newCSS -split "`n"
for ($i = 737; $i -ge 665; $i--) { $result.RemoveAt($i) }
foreach ($cl in [Linq.Enumerable]::Reverse($cssLines)) { $result.Insert(665, $cl) }

# ── Write ──
[System.IO.File]::WriteAllLines($filePath, $result, [System.Text.Encoding]::UTF8)
Write-Host "Done. Lines: $($result.Count)"
Write-Host "Size: $([Math]::Round((Get-Item $filePath).Length / 1MB, 2)) MB"

# Verify
$v = [System.IO.File]::ReadAllLines($filePath, [System.Text.Encoding]::UTF8)
for ($i = 0; $i -lt $v.Count; $i++) {
  if ($v[$i] -match 'tl-label|tl-track|tl-animated|tl-scroll-outer|tlTrack') {
    Write-Host "L$($i+1): $($v[$i].Substring(0, [Math]::Min(90, $v[$i].Length)))"
  }
}
