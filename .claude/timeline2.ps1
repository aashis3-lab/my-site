
$filePath = "C:\Users\prsha\portfolio\index.html"
$v = [System.IO.File]::ReadAllLines($filePath, [System.Text.Encoding]::UTF8)
$r = [System.Collections.Generic.List[string]]::new($v)
Write-Host "Loaded $($r.Count) lines"

# ─── NEW CONTENT ──────────────────────────────────────────────────────────────

$newCSS = @'
/* ── Horizontal Work Timeline ── */
#work {
  padding: 8vh 0 5vh;
}
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
.tl-scroll-outer.tl-no-overflow {
  -webkit-mask-image: none;
  mask-image: none;
}
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
  left: 0;
  right: 0;
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
  transition: min-width 0.52s cubic-bezier(0.25, 1, 0.5, 1);
}
.tl-item:hover { min-width: 320px; }

.tl-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: rgba(249,248,245,0.55);
  flex-shrink: 0;
  position: relative;
  z-index: 2;
  transform: scale(0);
  transition: transform 0.45s cubic-bezier(0.34, 1.56, 0.64, 1), background 0.3s ease;
}
.tl-track.tl-animated .tl-dot { transform: scale(1); }
.tl-item:hover .tl-dot { background: rgba(249,248,245,0.9); }

.tl-connector {
  width: 1px;
  height: 16px;
  background: rgba(249,248,245,0.1);
  flex-shrink: 0;
  transition: background 0.3s ease;
}
.tl-item:hover .tl-connector { background: rgba(249,248,245,0.25); }

.tl-pill {
  width: 100%;
  border: 1px solid rgba(249,248,245,0.09);
  border-radius: 10px;
  background: rgba(249,248,245,0.03);
  padding: 0.9rem 1.1rem;
  overflow: hidden;
  opacity: 0;
  transition: background 0.35s ease, border-color 0.35s ease, opacity 0.55s ease;
  transform: translateY(0);
}
.tl-track.tl-animated .tl-pill { opacity: 1; }
.tl-item:hover .tl-pill {
  background: rgba(249,248,245,0.07);
  border-color: rgba(249,248,245,0.18);
}

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
  transition: color 0.3s ease;
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

.tl-pill-body {
  max-height: 0;
  overflow: hidden;
  opacity: 0;
  transition: max-height 0.55s cubic-bezier(0.25, 1, 0.5, 1), opacity 0.4s ease 0.08s;
}
.tl-item:hover .tl-pill-body {
  max-height: 300px;
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

/* stagger dot + pill entry */
.tl-item:nth-child(1) .tl-dot  { transition-delay: 0.08s; }
.tl-item:nth-child(2) .tl-dot  { transition-delay: 0.22s; }
.tl-item:nth-child(3) .tl-dot  { transition-delay: 0.36s; }
.tl-item:nth-child(4) .tl-dot  { transition-delay: 0.50s; }
.tl-item:nth-child(5) .tl-dot  { transition-delay: 0.64s; }
.tl-item:nth-child(1) .tl-pill { transition-delay: 0.14s; }
.tl-item:nth-child(2) .tl-pill { transition-delay: 0.28s; }
.tl-item:nth-child(3) .tl-pill { transition-delay: 0.42s; }
.tl-item:nth-child(4) .tl-pill { transition-delay: 0.56s; }
.tl-item:nth-child(5) .tl-pill { transition-delay: 0.70s; }
'@

$newMobileCSS = @'

  /* ── Work Timeline — mobile: vertical stack ── */
  .tl-scroll-outer {
    overflow-x: visible;
    cursor: default;
    -webkit-mask-image: none !important;
    mask-image: none !important;
  }
  .tl-track { flex-direction: column; gap: 0; padding: 0 6vw 3rem; }
  .tl-axis { display: none; }
  .tl-item { flex: none; width: 100%; min-width: 0 !important; max-width: none; padding-top: 1rem; border-top: 1px solid rgba(249,248,245,0.08); align-items: flex-start; cursor: default; }
  .tl-dot, .tl-connector { display: none; }
  .tl-pill { border: none; background: transparent; padding: 0; }
  .tl-pill-body { max-height: none !important; opacity: 1 !important; overflow: visible; }
  .tl-role { white-space: normal; }
  .tl-company { white-space: normal; }
'@

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
            <div class="tl-pill-body">
              <span class="tl-dates">May 2026 – Present</span>
              <p class="tl-desc">Built the first AI demand-forecaster for large databases by developing an end-to-end Python-based data pipeline. Pitched the product to Pleco Solution's clients.</p>
              <div class="tl-tags">
                <span class="tl-tag">Snowflake</span><span class="tl-tag">Power BI</span><span class="tl-tag">SQL</span><span class="tl-tag">Supply-Chain</span>
              </div>
            </div>
          </div>
        </div>

        <div class="tl-item">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-pill">
            <span class="tl-company">AviLux</span>
            <span class="tl-role">Operations &amp; Regulations Lead</span>
            <div class="tl-pill-body">
              <span class="tl-dates">Jan 2026 – Present</span>
              <p class="tl-desc">Working directly with the founder of an early-stage food-delivery startup on drone deployment. Lead the operations and regulations team — FAA protocol development, GTM budgets, and launch prep.</p>
              <div class="tl-tags">
                <span class="tl-tag">Regulatory Strategy</span><span class="tl-tag">GTM</span><span class="tl-tag">Drone Tech</span><span class="tl-tag">Operations</span>
              </div>
            </div>
          </div>
        </div>

        <div class="tl-item">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-pill">
            <span class="tl-company">Autodesk</span>
            <span class="tl-role">Design &amp; Make Ambassador</span>
            <div class="tl-pill-body">
              <span class="tl-dates">Jun 2025 – May 2026</span>
              <p class="tl-desc">Selected to share the "Design and Make" platform through technical workshops and community-building initiatives.</p>
              <div class="tl-tags">
                <span class="tl-tag">Fusion</span><span class="tl-tag">AutoCAD</span><span class="tl-tag">Technical Education</span>
              </div>
            </div>
          </div>
        </div>

        <div class="tl-item">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-pill">
            <span class="tl-company">BSB Design</span>
            <span class="tl-role">Architectural Design Intern</span>
            <div class="tl-pill-body">
              <span class="tl-dates">Aug 2024 &middot; Frisco, TX</span>
              <p class="tl-desc">Translated client requirements into 2D CAD deliverables within a live architectural workflow. Hands-on exposure to stakeholder communication and iterative revision management.</p>
              <div class="tl-tags">
                <span class="tl-tag">Revit</span><span class="tl-tag">2D Drafting</span><span class="tl-tag">Client Communication</span>
              </div>
            </div>
          </div>
        </div>

        <div class="tl-item">
          <div class="tl-dot"></div>
          <div class="tl-connector"></div>
          <div class="tl-pill">
            <span class="tl-company">Abbott</span>
            <span class="tl-role">Independent Study &amp; Mentorship</span>
            <div class="tl-pill-body">
              <span class="tl-dates">Jan – May 2024 &middot; Irving, TX</span>
              <p class="tl-desc">Conducted a self-directed thermodynamics research project under mentorship from Abbott's Manager of Global Technical Support.</p>
              <div class="tl-tags">
                <span class="tl-tag">Thermodynamics</span><span class="tl-tag">3D Modelling</span><span class="tl-tag">Research</span><span class="tl-tag">CAD</span>
              </div>
            </div>
          </div>
        </div>

      </div><!-- /#tlTrack -->
    </div><!-- /.tl-scroll-outer -->
  </div><!-- /#work -->
'@

$newJS = @'
<script>
(function () {
  /* ── Work timeline: scroll fix + drag + animated reveal ── */
  var outer = document.querySelector('.tl-scroll-outer');
  var track = document.getElementById('tlTrack');
  if (!outer || !track) return;

  /* Check if track overflows container */
  function checkOverflow() {
    var noOverflow = outer.scrollWidth <= outer.clientWidth + 2;
    outer.classList.toggle('tl-no-overflow', noOverflow);
  }
  checkOverflow();
  window.addEventListener('resize', checkOverflow, { passive: true });

  /* Fade mask when scrolled to end */
  outer.addEventListener('scroll', function () {
    var atEnd = outer.scrollLeft + outer.clientWidth >= outer.scrollWidth - 4;
    outer.classList.toggle('tl-at-end', atEnd);
  }, { passive: true });

  /* Delegate vertical wheel scroll to the page — don't trap it */
  outer.addEventListener('wheel', function (e) {
    if (Math.abs(e.deltaY) >= Math.abs(e.deltaX)) return; /* vertical: let page handle */
    e.preventDefault();
    outer.scrollLeft += e.deltaX;
  }, { passive: false });

  /* Drag-to-scroll — only engage after confirmed horizontal intent */
  var down = false, dragLocked = false, sx = 0, sy = 0, sl = 0;

  outer.addEventListener('mousedown', function (e) {
    if (e.button !== 0) return;
    down = true; dragLocked = false;
    sx = e.clientX; sy = e.clientY; sl = outer.scrollLeft;
  });

  window.addEventListener('mouseup', function () {
    if (!down) return;
    down = false; dragLocked = false;
    outer.classList.remove('tl-grabbing');
  });

  outer.addEventListener('mousemove', function (e) {
    if (!down) return;
    var dx = e.clientX - sx, dy = e.clientY - sy;
    if (!dragLocked) {
      if (Math.abs(dx) < 5 && Math.abs(dy) < 5) return;   /* wait for intent */
      if (Math.abs(dy) > Math.abs(dx)) { down = false; return; } /* vertical intent → release */
      dragLocked = true;
      outer.classList.add('tl-grabbing');
    }
    e.preventDefault();
    outer.scrollLeft = sl - dx * 1.1;
  });

  /* Entry animation via IntersectionObserver */
  var obs = new IntersectionObserver(function (entries) {
    if (entries[0].isIntersecting) {
      track.classList.add('tl-animated');
      obs.disconnect();
    }
  }, { threshold: 0.12 });
  obs.observe(track);
})();
</script>
'@

# ─── APPLY CHANGES (highest indices first) ────────────────────────────────────

# 4. Replace JS block (0-idx 2279–2316)
$jsLines = $newJS -split "`n"
for ($i = 2316; $i -ge 2279; $i--) { $r.RemoveAt($i) }
foreach ($ln in [Linq.Enumerable]::Reverse($jsLines)) { $r.Insert(2279, $ln) }

# 3. Replace HTML block (0-idx 1310–1394)
$htmlLines = $newHTML -split "`n"
for ($i = 1394; $i -ge 1310; $i--) { $r.RemoveAt($i) }
foreach ($ln in [Linq.Enumerable]::Reverse($htmlLines)) { $r.Insert(1310, $ln) }

# 2. Replace mobile CSS (0-idx 1092–1107)
$mobileLines = $newMobileCSS -split "`n"
for ($i = 1107; $i -ge 1092; $i--) { $r.RemoveAt($i) }
foreach ($ln in [Linq.Enumerable]::Reverse($mobileLines)) { $r.Insert(1092, $ln) }

# 1. Replace desktop CSS (0-idx 665–813)
$cssLines = $newCSS -split "`n"
for ($i = 813; $i -ge 665; $i--) { $r.RemoveAt($i) }
foreach ($ln in [Linq.Enumerable]::Reverse($cssLines)) { $r.Insert(665, $ln) }

# Write
[System.IO.File]::WriteAllLines($filePath, $r, [System.Text.Encoding]::UTF8)
Write-Host "Done. Lines: $($r.Count), Size: $([Math]::Round((Get-Item $filePath).Length/1MB,2)) MB"

# Quick verify
$v2 = [System.IO.File]::ReadAllLines($filePath, [System.Text.Encoding]::UTF8)
$hits = @()
for ($i = 0; $i -lt $v2.Count; $i++) {
  if ($v2[$i] -match 'tl-pill-body|tl-pill-head|tl-item:hover .tl-pill-body|wheel|dragLocked|WORK EXPERIENCE') {
    $hits += "L$($i+1): $($v2[$i].Trim().Substring(0,[Math]::Min(90,$v2[$i].Trim().Length)))"
  }
}
$hits | Select-Object -First 20 | ForEach-Object { Write-Host $_ }
