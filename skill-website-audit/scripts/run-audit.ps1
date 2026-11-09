param(
    [Parameter(Mandatory = $false)]
    [string]$TargetPath = "."
)

$ErrorActionPreference = "SilentlyContinue"
$resolvedPath = (Resolve-Path $TargetPath).Path
if (-not $resolvedPath) {
    Write-Error "Target path '$TargetPath' not found."
    exit 1
}

Write-Output "================================================================="
Write-Output " WEBSITE 360 AUDIT SCANNER (8 Areas / 40 Questions + 09 SEO/GEO)"
Write-Output " Target: $resolvedPath"
Write-Output " Database Reference: $env:USERPROFILE/Desktop/websites/database"
Write-Output "================================================================="

$excludeDirs = @("node_modules", ".git", ".next", "dist", "build", ".astro", ".svelte-kit", "vendor", "database")

$markupFiles = Get-ChildItem -Path $resolvedPath -Recurse -File -Include *.html, *.htm, *.jsx, *.tsx, *.vue, *.astro, *.svelte | Where-Object {
    $full = $_.FullName
    $skip = $false
    foreach ($ex in $excludeDirs) {
        if ($full -match "[\\/]$ex[\\/]") { $skip = $true; break }
    }
    -not $skip
}

$styleFiles = Get-ChildItem -Path $resolvedPath -Recurse -File -Include *.css, *.scss, *.less | Where-Object {
    $full = $_.FullName
    $skip = $false
    foreach ($ex in $excludeDirs) {
        if ($full -match "[\\/]$ex[\\/]") { $skip = $true; break }
    }
    -not $skip
}

$allMarkup = ($markupFiles | ForEach-Object { Get-Content $_.FullName -Raw }) -join "`n"
$allStyles = ($styleFiles | ForEach-Object { Get-Content $_.FullName -Raw }) -join "`n"

function Report-Check {
    param([string]$Code, [string]$Name, [bool]$Passed, [string]$Details)
    $status = if ($Passed) { "[PASS]" } else { "[WARN/FAIL]" }
    Write-Output ("{0,-12} {1,-12} {2} - {3}" -f $Code, $status, $Name, $Details)
}

Write-Output "`n--- 01. NAWIGACJA (Navigation & Information Architecture) ---"
$hasHeaderNav = $allMarkup -match "<header\b" -and $allMarkup -match "<nav\b"
$hasSkipLink = $allMarkup -match "skip-link|skip-to-content|#main-content|#main\b"
$hasAriaCurrent = $allMarkup -match "aria-current="
$hasBreadcrumbs = $allMarkup -match "Breadcrumb|breadcrumb"
$hasSearch = $allMarkup -match "<search\b|role=[`"']search[`"']|type=[`"']search[`"']|cmdk"
Report-Check "Q1.1" "Header, Nav & Skip-Link" ($hasHeaderNav -and $hasSkipLink) "Header+Nav: $hasHeaderNav, SkipLink: $hasSkipLink"
Report-Check "Q1.2" "Wayfinding (aria-current & Breadcrumbs)" ($hasAriaCurrent -or $hasBreadcrumbs) "aria-current: $hasAriaCurrent, Breadcrumbs: $hasBreadcrumbs"
Report-Check "Q1.5" "Site Search / Command Palette" $hasSearch "Search landmark or input present: $hasSearch"

Write-Output "`n--- 02. STRUKTURA I UKLAD (Structure, H1-H3 & Layout Stability) ---"
$h1Matches = [regex]::Matches($allMarkup, "<h1\b", "IgnoreCase").Count
$hasMain = $allMarkup -match "<main\b"
$hasFooter = $allMarkup -match "<footer\b"
$hasGridFlex = $allStyles -match "display:\s*(grid|flex)" -or $allMarkup -match "\b(grid|flex)\b"
$hasContainerQuery = $allStyles -match "@container|container-type"
$imgTags = [regex]::Matches($allMarkup, "<img\b[^>]*>", "IgnoreCase")
$imgsWithDims = 0
foreach ($img in $imgTags) {
    if ($img.Value -match "width=" -or $img.Value -match "aspect-ratio") { $imgsWithDims++ }
}
Report-Check "Q2.1" "Heading H1 Presence" ($h1Matches -ge 1) "Total <h1> tags across files: $h1Matches (Markup files: $($markupFiles.Count))"
Report-Check "Q2.2" "HTML5 Landmarks (<main>, <footer>)" ($hasMain -and $hasFooter) "main: $hasMain, footer: $hasFooter"
Report-Check "Q2.3" "Modern CSS Grid / Flexbox" $hasGridFlex "Grid/Flex detected: $hasGridFlex"
Report-Check "Q2.4" "Container Queries (@container)" $hasContainerQuery "Container queries detected: $hasContainerQuery"
Report-Check "Q2.5" "CLS Image Dimensions" ($imgTags.Count -eq 0 -or $imgsWithDims -eq $imgTags.Count) "Images with width/aspect-ratio: $imgsWithDims / $($imgTags.Count)"

Write-Output "`n--- 03. TRESC I CZYTELNOSC (Content, Typography & Contrast) ---"
$hasClampOrRem = $allStyles -match "clamp\(|rem\b"
$hasMeasureLimit = $allStyles -match "\bch\b|max-width"
$hasJustify = $allStyles -match "text-align:\s*justify"
$hasOklchOrVars = $allStyles -match "oklch\(|var\(--"
Report-Check "Q3.1" "Fluid/Relative Typography (clamp/rem)" $hasClampOrRem "Uses rem/clamp(): $hasClampOrRem"
Report-Check "Q3.2" "Modern Color Tokens (OKLCH / CSS Vars)" $hasOklchOrVars "Uses OKLCH or CSS Custom Properties: $hasOklchOrVars"
Report-Check "Q3.3" "Measure & No text-align:justify" ($hasMeasureLimit -and -not $hasJustify) "Max-width/ch: $hasMeasureLimit, Avoids justify: $(-not $hasJustify)"

Write-Output "`n--- 04. FORMULARZE (Forms & Real-Time Validation) ---"
$inputCount = [regex]::Matches($allMarkup, "<(input|select|textarea)\b", "IgnoreCase").Count
$labelCount = [regex]::Matches($allMarkup, "<label\b|aria-label=|aria-labelledby=", "IgnoreCase").Count
$hasAutocomplete = $allMarkup -match "autocomplete=|inputmode="
$hasAriaInvalid = $allMarkup -match "aria-invalid|aria-describedby"
Report-Check "Q4.2" "Form Inputs & Accessible Labels" ($inputCount -eq 0 -or $labelCount -ge $inputCount) "Inputs: $inputCount, Labels/ARIA-labels: $labelCount"
Report-Check "Q4.3" "Autocomplete & Inputmode Attributes" ($inputCount -eq 0 -or $hasAutocomplete) "autocomplete/inputmode present: $hasAutocomplete"
Report-Check "Q4.4" "ARIA Error Binding (aria-invalid/describedby)" ($inputCount -eq 0 -or $hasAriaInvalid) "ARIA error attributes present: $hasAriaInvalid"

Write-Output "`n--- 05. FUNKCJONALNOSC I WYDAJNOSC (Functionality & Core Web Vitals) ---"
$hasFetchPriority = $allMarkup -match "fetchpriority=[`"']high[`"']"
$hasLazyLoading = $allMarkup -match "loading=[`"']lazy[`"']"
$hasModernFonts = ($allStyles + $allMarkup) -match "woff2|font-display:\s*(swap|optional)"
Report-Check "Q5.3a" "LCP Hero fetchpriority='high'" $hasFetchPriority "fetchpriority='high' found: $hasFetchPriority"
Report-Check "Q5.3b" "Lazy Loading & WOFF2 font-display" ($hasLazyLoading -or $hasModernFonts) "loading='lazy': $hasLazyLoading, woff2/font-display: $hasModernFonts"

Write-Output "`n--- 06. DOSTEPNOSC (Accessibility, Keyboard & WCAG 2.2) ---"
$hasHtmlLang = $allMarkup -match "<html[^>]+lang="
$hasFocusVisible = $allStyles -match ":focus-visible"
$imgsWithAlt = 0
foreach ($img in $imgTags) {
    if ($img.Value -match "\balt=") { $imgsWithAlt++ }
}
$hasReducedMotion = $allStyles -match "prefers-reduced-motion"
Report-Check "Q6.2" "Keyboard Focus Indicator (:focus-visible)" $hasFocusVisible ":focus-visible in CSS: $hasFocusVisible"
Report-Check "Q6.3" "HTML lang & Image alt Attributes" ($hasHtmlLang -and ($imgTags.Count -eq 0 -or $imgsWithAlt -eq $imgTags.Count)) "html[lang]: $hasHtmlLang, img[alt]: $imgsWithAlt / $($imgTags.Count)"
Report-Check "Q6.5" "Respects prefers-reduced-motion" $hasReducedMotion "@media (prefers-reduced-motion) found: $hasReducedMotion"

Write-Output "`n--- 07. ESTETYKA (Design Systems & Brand Tokens) ---"
$cssVarDefs = [regex]::Matches($allStyles, "--[a-zA-Z0-9_-]+\s*:").Count
$rawHexCount = [regex]::Matches($allStyles, "#[0-9a-fA-F]{3,8}\b").Count
$hasDarkMode = ($allStyles + $allMarkup) -match "prefers-color-scheme:\s*dark|color-scheme:\s*light\s+dark|\.dark\b"
Report-Check "Q7.1" "Design Tokens (--* CSS Custom Properties)" ($cssVarDefs -ge 5) "CSS Custom Property definitions: $cssVarDefs, Raw HEX count: $rawHexCount"
Report-Check "Q7.2" "Dark / Light Theme Support" $hasDarkMode "Dark mode media query or class detected: $hasDarkMode"

Write-Output "`n--- 08. BEZPIECZENSTWO (Security, HTTPS & Data Protection) ---"
$httpLinks = [regex]::Matches($allMarkup, "http://(?!localhost|127\.0\.0\.1|www\.w3\.org|schema\.org)").Count
$unsafeInner = [regex]::Matches($allMarkup, "dangerouslySetInnerHTML|\.innerHTML\s*=").Count
$hasDomPurify = $allMarkup -match "DOMPurify|sanitize"
Report-Check "Q8.1" "Zero Mixed Content (No insecure http://)" ($httpLinks -eq 0) "Insecure http:// links found: $httpLinks"
Report-Check "Q8.4" "DOM XSS Protection (No raw innerHTML)" ($unsafeInner -eq 0 -or $hasDomPurify) "Raw innerHTML/dangerouslySetInnerHTML: $unsafeInner (DOMPurify: $hasDomPurify)"

Write-Output "`n--- 09. DODATKOWE: SEO, GEO (AI-Search) & INFRASTRUCTURE ---"
$hasTitle = $allMarkup -match "<title\b"
$hasMetaDesc = $allMarkup -match "name=[`"']description[`"']"
$hasCanonical = $allMarkup -match "rel=[`"']canonical[`"']"
$hasSchemaJsonLd = $allMarkup -match "application/ld\+json"
$hasRobots = Test-Path (Join-Path $resolvedPath "robots.txt") -or Test-Path (Join-Path $resolvedPath "public/robots.txt")
$hasSitemap = Test-Path (Join-Path $resolvedPath "sitemap.xml") -or Test-Path (Join-Path $resolvedPath "public/sitemap.xml")
$hasLlmsTxt = Test-Path (Join-Path $resolvedPath "llms.txt") -or Test-Path (Join-Path $resolvedPath "public/llms.txt")
Report-Check "SEO.1" "Meta Title, Description & Canonical" ($hasTitle -and $hasMetaDesc) "Title: $hasTitle, Description: $hasMetaDesc, Canonical: $hasCanonical"
Report-Check "SEO.2" "Schema.org JSON-LD Structured Data" $hasSchemaJsonLd "application/ld+json present: $hasSchemaJsonLd"
Report-Check "GEO.1" "robots.txt, sitemap.xml & /llms.txt" ($hasRobots -and $hasSitemap -and $hasLlmsTxt) "robots.txt: $hasRobots, sitemap.xml: $hasSitemap, llms.txt: $hasLlmsTxt"

Write-Output "`n================================================================="
Write-Output " Audit scan finished. Review the findings above with SKILL.md."
Write-Output "================================================================="
