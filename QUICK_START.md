# Quick Start Guide - 5 Minutes to Setup

## 🚀 For Farmington Concession Stand

**⚠️ IMPORTANT:** This menu system requires a web server to function properly. It cannot be opened as local HTML files due to JSON loading requirements.

---

## Step 1: Copy These Files to Your Repo

Replace these files in your GitHub repository:

```
✅ index.html              (Improved launcher + admin panel)
✅ main/index.html         (Improved TV display)
✅ items.json              (Keep your existing data)
```

**Optional but recommended:**
```
📖 IMPROVEMENTS.md         (Documentation)
📖 BEFORE_AFTER.md         (Code comparison)
📖 QUICK_START.md          (This guide)
```

---

## Step 2: Test Locally

**⚠️ IMPORTANT:** This menu system requires a web server to load JSON data. **Do not open HTML files directly in your browser** - use a live server instead.

### Option A: VS Code Live Server (Recommended)
1. Install the "Live Server" extension in VS Code
2. Right-click `index.html` → "Open with Live Server"
3. Browser opens automatically at `http://127.0.0.1:5500/index.html`

### Option B: Python Server
```bash
# Navigate to your project folder
cd path/to/menu1-main

# Python 3
python -m http.server 8000

# Or Python 2
python -m SimpleHTTPServer 8000
```
Then open: `http://localhost:8000/index.html`

### Option C: Node.js Server
```bash
# Install http-server globally
npm install -g http-server

# Run in project folder
http-server -p 8080
```
Then open: `http://localhost:8080/index.html`

---

### Test the System:
1. **Open `index.html` in your live server**
2. **Click "⚙️ Admin Panel"** at the bottom
3. **Try editing an item:**
   - Click the ✏️ button on any item
   - Change the price
   - Click "Save"
   - Notice "Last Saved" time updates
4. **Open TV display:**
   - Click "📺 Main Display" from launcher
   - Notice your edit appears (or wait 30 seconds for auto-refresh)

---

## Step 3: Deploy to GitHub Pages

### Option A: GitHub Web Interface
1. Go to your repo on GitHub.com
2. Click **Add file** → **Upload files**
3. Drag the improved files
4. Click **Commit changes**
5. Wait ~1 minute for deployment

### Option B: Git Command Line
```bash
# In your local repo folder
git add index.html main/index.html
git commit -m "Improved menu system with auto-refresh"
git push origin main
```

---

## Step 4: Setup Your TV Display

### **Windows PC/Laptop:**
1. Open **Chrome** (recommended for best performance)
2. Navigate to: `https://yourusername.github.io/menu1/main/index.html`
3. Press **F11** for fullscreen
4. **Settings** → **Display** → Set "Never turn off display"

### **Smart TV with Browser:**
1. Open built-in web browser
2. Navigate to your GitHub Pages URL
3. Bookmark it for easy access

### **Raspberry Pi / Kiosk Setup:**
```bash
# Install Chromium in kiosk mode
sudo apt-get install chromium-browser
chromium-browser --kiosk --disable-infobars \
  https://yourusername.github.io/menu1/main/index.html
```

### **Fire TV / Android TV:**
1. Install "Kiosk Browser" app from store
2. Set your menu URL as homepage
3. Enable auto-launch on boot

---

## Step 5: Use the Admin Panel

### **On Your Phone/Tablet:**
1. Open: `https://yourusename.github.io/menu1/index.html`
2. Click "⚙️ Admin Panel"
3. **Bookmark this page** for quick access

### **Common Admin Tasks:**

**Add a new item:**
1. Switch to the correct tab (Food, Drinks, etc.)
2. Scroll to "Add Item" form
3. Fill in Name, Price, Image path
4. Click "Add Item"

**Mark item out of stock:**
1. Find the item in the list
2. Click the "✅ In Stock" button
3. It changes to "❌ Out"
4. TV display updates in ~30 seconds

**Change a price:**
1. Click ✏️ next to the item
2. Update the price
3. Click "Save"

**Make changes permanent:**
1. Go to "Export/Backup" tab
2. Click "Download JSON File"
3. Replace `items.json` in your repo with downloaded file
4. Push to GitHub

---

## 🎯 Typical Workflow

### **Daily Operation:**
```
Morning:
  → Open admin panel on tablet
  → Check stock
  → Mark out-of-stock items (❌)
  → Changes appear on TV automatically

During the day:
  → Update prices if needed
  → Add new items as they arrive
  → TV refreshes every 30 seconds

End of day:
  → Export changes if you made permanent menu updates
  → Upload to GitHub (optional - for permanent changes)
```

---

## ⚡ Pro Tips

### **Server Requirement:**
- **Always use a web server** - never open HTML files directly
- VS Code Live Server extension is easiest for development
- GitHub Pages handles this automatically for production

### **Faster Updates:**
- Admin and TV display on same computer? Changes appear instantly (cross-tab sync)
- Different devices? Wait ~30 seconds for auto-refresh

### **Image Management:**
```
Good image paths:
  ✅ ../images/hotdog.jpg
  ✅ ../images/nachos.jpg

Bad image paths:
  ❌ images/hotdog.jpg (missing ../)
  ❌ /images/hotdog.jpg (absolute path won't work on GitHub Pages)
  ❌ C:/Users/Reid/Desktop/hotdog.jpg (local path)
```

### **Backup Strategy:**
```
Weekly:
  → Export JSON
  → Save to Google Drive / Dropbox
  → Commit to GitHub

Why? If browser cache clears, you lose live edits not in items.json
```

---

## 🐛 Troubleshooting

### **"CORS error" or "Failed to load items.json"**
```
Cause: Opening HTML files directly in browser (file:// protocol)
Fix: Use a live web server instead!

Solutions:
1. VS Code: Install "Live Server" extension, right-click index.html → "Open with Live Server"
2. Python: cd to project folder, run: python -m http.server 8000
3. Node.js: npm install -g http-server, then: http-server -p 8080
4. Any static server that serves on localhost

Then open: http://localhost:PORT/index.html (not file://...)
```

### **"TV display not updating"**
```
Try:
1. Hard refresh: Ctrl+F5 (Windows) or Cmd+Shift+R (Mac)
2. Check browser console for errors (F12)
3. Verify items.json is accessible
4. Clear browser cache
```

### **"Lost all my edits!"**
```
Cause: Cleared browser storage or different browser
Fix: Always export before closing admin panel
Recovery: Check if items.json has your last permanent export
```

### **"Images not showing"**
```
Check:
1. Image path uses ../images/filename.jpg format
2. File exists in images folder
3. Filename matches exactly (case-sensitive)
4. Image isn't corrupted
```

### **"Admin panel blank"**
```
Try:
1. Check browser console (F12)
2. Verify items.json is valid JSON (use jsonlint.com)
3. Clear localStorage: localStorage.clear() in console
4. Reload page
```

---

## 📱 Mobile Admin Panel

**iOS (iPhone/iPad):**
1. Open Safari → Navigate to admin URL
2. Tap **Share** → **Add to Home Screen**
3. Icon appears like a native app
4. Opens in fullscreen when tapped

**Android:**
1. Open Chrome → Navigate to admin URL
2. Tap ⋮ (menu) → **Add to Home screen**
3. Icon appears in app drawer
4. Opens like a native app

---

## 🎨 Customization Quick Reference

### **Change refresh interval:**
`main/index.html` → Line ~240:
```javascript
const AUTO_REFRESH_INTERVAL = 30000; // Change this (milliseconds)
```

### **Change colors:**
`main/index.html` → `<style>` section:
```css
body {
  background-color: #d1001f; /* Your color here */
  color: #eaeae5;            /* Text color */
}
```

### **Bigger text for TV:**
`main/index.html` → `.item-name` style:
```css
.item-name { 
  font-size: clamp(32px, 5vw, 42px); /* Increase these */
}
```

---

## ✅ Launch Checklist

Before going live:

- [ ] **Web server configured** (GitHub Pages, local server, etc.)
- [ ] All items have correct prices
- [ ] All images load properly
- [ ] Out-of-stock items marked correctly
- [ ] TV display auto-refreshes (wait 30 seconds to verify)
- [ ] Admin panel accessible on staff devices
- [ ] Exported backup saved somewhere safe
- [ ] GitHub Pages deployed successfully
- [ ] TV display bookmarked/set as homepage
- [ ] Staff trained on admin panel
- [ ] Paper menu backup printed (just in case!)

---

## 🆘 Emergency Procedures

### **If TV display crashes:**
1. Refresh page (F5)
2. If still broken, use paper menu backup
3. Check GitHub Pages status: https://www.githubstatus.com

### **If need to revert changes:**
1. Admin panel → Export/Backup tab
2. Click "Reset to items.json"
3. Confirms reversion to last permanent export

### **If GitHub Pages down:**
- Keep a local copy of the files
- **Run on local server:** Use `python -m http.server` or VS Code Live Server
- **Do NOT open as file://** - requires HTTP server for JSON loading
- Or use simple Python server: `python -m http.server`

---

## 📞 Support Resources

**Documentation:**
- Full guide: `IMPROVEMENTS.md`
- Code comparison: `BEFORE_AFTER.md`
- GitHub Pages docs: https://docs.github.com/pages

**Validation Tools:**
- JSON validator: https://jsonlint.com
- Image optimizer: https://tinypng.com
- HTML validator: https://validator.w3.org

---

**Total setup time: ~7 minutes** ✅  
**Last updated: March 2026**

---

**Questions?** Check the browser console (F12) - it logs everything that happens!
