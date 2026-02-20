# Taival Tech Oy — Website

Static HTML/CSS/JS site for [taival.tech](https://taival.tech).

## Files

```
website/
├── index.html     # Single-page site
├── style.css      # All styles (design tokens at top for easy brand updates)
├── script.js      # Vanilla JS: nav scroll, mobile menu, scroll reveal
└── README.md      # This file
```

## Placeholders to replace before launch

Search for these strings in `index.html` and swap with real values:

| Placeholder | Replace with |
|---|---|
| `#PLACEHOLDER_INTAKE_URL` | URL to the customer intake/interview platform |
| `#PLACEHOLDER_CALENDLY_URL` | Calendly or calendar booking link |
| `#PLACEHOLDER_LINKEDIN_URL` | Taival Tech Oy LinkedIn company page URL |
| `#PLACEHOLDER_PRIVACY_URL` | Privacy policy page URL |
| `hello@taival.tech` | Verify this email exists before launch |
| `Now accepting clients` | Update badge text when relevant |

## Brand / Design tokens

All colors, fonts, and spacing are CSS custom properties at the top of `style.css`.
When the brand is finalized, update the `:root { }` block — the whole site updates.

Key tokens:
```css
--color-accent:   #6366f1;   /* Primary brand color */
--color-accent-2: #22d3ee;   /* Secondary accent */
--font-sans:      'Inter';   /* Body font */
```

---

## Deploy to Vercel

### Option A — CLI (fastest)

```bash
# 1. Install Vercel CLI (once)
npm i -g vercel

# 2. From the website/ directory:
cd website
vercel

# Follow the prompts:
#   - Link to existing project? No → create new
#   - Project name: taival-tech
#   - Which directory? ./ (current)
#   - Override settings? No

# Your site is live at *.vercel.app instantly.
```

### Option B — GitHub + Vercel (recommended for ongoing updates)

```bash
# 1. Push the website folder to a GitHub repo
git init
git add .
git commit -m "feat: initial website"
git remote add origin https://github.com/YOUR_ORG/taival-tech-website.git
git push -u origin main

# 2. Go to vercel.com → New Project → Import from GitHub
# 3. Select your repo — Vercel auto-detects static site
# 4. Click Deploy. Done.
```

Every push to `main` triggers an automatic redeploy.

---

## Connect domain taival.tech

After deploying to Vercel:

1. **Vercel Dashboard → Project → Settings → Domains**
2. Add `taival.tech` and `www.taival.tech`
3. Vercel shows you the DNS records to add

### DNS setup (at your registrar — e.g. Namecheap, Cloudflare):

| Type | Name | Value |
|------|------|-------|
| `A` | `@` | `76.76.21.21` (Vercel IP) |
| `CNAME` | `www` | `cname.vercel-dns.com` |

> **Tip:** If using Cloudflare, set DNS-only (grey cloud), not proxied — Vercel handles TLS.

SSL certificate is provisioned automatically by Vercel. Usually takes 5–10 minutes.

---

## GitHub Pages (alternative, 100% free)

If you prefer GitHub Pages over Vercel:

```bash
# Push to a repo, then:
# GitHub repo → Settings → Pages → Source: Deploy from branch → main / (root)
# Site available at: https://YOUR_ORG.github.io/REPO_NAME/

# For custom domain: add CNAME file to repo root
echo "taival.tech" > CNAME
git add CNAME && git commit -m "add custom domain" && git push
```

Then add the same DNS records at your registrar (see above).

---

## Local preview

No build step needed — just open `index.html` in a browser.

Or use a local server for accurate behaviour:
```bash
# Python (built-in)
python -m http.server 3000

# Node (npx)
npx serve .

# Then open http://localhost:3000
```

