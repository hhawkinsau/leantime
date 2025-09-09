# Leantime Plugin Recoverability & Deployment Notes

Date: 2025-09-09

## 1. Scope
Summary of investigated (paid / marketplace) plugin traces inside this Leantime OSS container, file locations, recoverability estimates, and practical steps to: (a) externalize the existing Pomodoro timer into a proper plugin, (b) mount / persist plugin code & data using Docker Compose, (c) back up & restore all state safely.

> UPDATE (Marketplace cross-check): Confirmed via public sources (Leantime 3.0.0 release blog & marketplace search) the initial commercial / marketplace plugin set: **Whiteboards, Notes, Strategy, Pomodoro Timer** plus newer additions like **Advanced Auth** and bundles (e.g., MCP + Advanced Auth). This document now clearly separates: (A) What physically exists in this repo/container, (B) What is referenced indirectly, (C) What is only known externally (missing entirely here).

## 2. Core Plugin / Module Infrastructure (File Map)
| Purpose | Location |
|---------|----------|
| Plugin discovery (load register.php) | `app/Core/Plugins/PluginManager.php` |
| Enabled plugin path resolution | `app/Core/Plugins/Plugins.php` |
| Service provider binding for plugin services | `app/Core/Plugins/PluginsServiceProvider.php` |
| Runtime registration helper (menus, langs, assets) | `app/Domain/Plugins/Services/Registration.php` |
| Marketplace + install / enable / license handling | `app/Domain/Plugins/Services/Plugins.php` |
| Module availability (e.g. `strategyPro`) | `app/Domain/Modulemanager/Services/Modulemanager.php` |
| Menu base repo (for context) | `app/Domain/Menu/Repositories/Menu.php` |

### 2.1 Event / Hook Touchpoints Relevant to Plugins
| Concern | Hook / Mechanism | Origin File |
|---------|------------------|-------------|
| Register language & assets | `Registration` methods trigger `EventDispatcher::add_event_listener` & `add_filter_listener` | `app/Domain/Plugins/Services/Registration.php` |
| Add menu items | Filter: `leantime.domain.menu.repositories.menu.getMenuStructure.menuStructures.{section}` | `Registration.php` |
| Determine menu section type | Filter: `leantime.domain.menu.repositories.menu.getSectionMenuType.menuSections` | `Registration.php` |
| Inject header JS/CSS | Event: `leantime.*.afterLinkTags` | `Registration.php` |
| Inject footer JS | Event: `leantime.*.beforeBodyClose` | `Registration.php` |
| Cache invalidation on plugin state change | `clearCache()` removing `plugins.enabledPlugins` etc. | `app/Domain/Plugins/Services/Plugins.php` |
| Module availability extension | Filter: `moduleAvailability` | `Modulemanager.php` |

Use these existing hooks when integrating any newly mounted plugin code.

## 2.2 Observed Repo Artifacts (Strict Inventory)
This list enumerates every observed file in the current container that relates to plugin or potential paid-feature functionality. If a plugin folder is later mounted under `app/Plugins/`, treat that folder as additive; baseline below allows diff-based auditing.

| Path | Type | Purpose / Notes |
|------|------|-----------------|
| `app/Core/Plugins/PluginManager.php` | PHP | Loads `register.php` inside each plugin path. |
| `app/Core/Plugins/Plugins.php` | PHP | Resolves enabled plugin paths (folder or phar). |
| `app/Core/Plugins/PluginsServiceProvider.php` | PHP | Binds plugin service singleton. |
| `app/Domain/Plugins/Services/Registration.php` | PHP | Public API for plugins to register menus, langs, assets. |
| `app/Domain/Plugins/Services/Plugins.php` | PHP | Marketplace comms, install/enable/disable, licensing. |
| `app/Domain/Plugins/Contracts/PluginDisplayStrategy.php` | PHP | Display strategy interface (used by models). |
| `app/Domain/Plugins/Models/InstalledPlugin.php` | PHP | Represents installed plugin entry. |
| `app/Domain/Plugins/Models/MarketplacePlugin.php` | PHP | Represents marketplace plugin metadata. |
| `app/Domain/Modulemanager/Services/Modulemanager.php` | PHP | Checks availability (plugins & system modules). |
| `public/assets/js/libs/pomodoro/pomodoro.js` | JS | Standalone Pomodoro timer logic (unpackaged). |
| `public/assets/js/app/core/nestedSortable.js` | JS | Contains logic referencing `.pomodoroDrop` (drag affordance). |

No other plugin folders are present under `app/Plugins/` (directory currently empty at time of audit).

## 2.3 Marketplace Plugin Inventory vs Repo Presence
| Marketplace Plugin (Public) | Repo Presence (Exact Paths) | Presence Type | Missing Elements (High-Level) |
|-----------------------------|------------------------------|---------------|------------------------------|
| Pomodoro Timer | `public/assets/js/libs/pomodoro/pomodoro.js`; references in `public/assets/js/app/core/nestedSortable.js` | Partial (front-end logic only) | Packaging (composer, register.php), UI view, menu/lang, persistence, task linking |
| Strategy (Board / StrategyPro) | Strategy project type & menu: `app/Domain/Menu/Repositories/Menu.php` (`menu.blueprints`); creation flow references in `app/Domain/Projects/Controllers/Createnew.php` | Core partial (base strategy integrated) | Enhanced strategy board features presumably in paid plugin (advanced canvases, dashboards) |
| Notes (NotesPro) | Core wiki/notes domain (e.g., `app/Domain/Wiki/*`, templates) | Core present | Advanced features (tagging, version diff, extended search, AI) |
| Whiteboards | None (no `Whiteboard` or `Whiteboards` plugin code; only generic Canvas domains) | Absent | Entire realtime whiteboard UI, persistence & collaboration layer |
| Advanced Auth | Socialite vendor libs; env var doc patterns; no plugin folder | Absent | OAuth provider management UI, SAML, PAT issuance, routes/controllers, settings pages |
| MCP Server (bundle mention) | None specific (likely relies on PAT + API infrastructure) | Absent | Plugin code exporting remote control / automation endpoints |
| Program / Portfolio (pgmPro) | Availability check in `Createnew.php` for `pgmPro`; no folder | Absent | Aggregation dashboards, cross-project metrics UI |

Legend: Partial = Some code assets exist but not structured as a plugin; Core partial = baseline open-source functionality covers part of advertised feature; Absent = no code artifacts related to plugin specifics.

> When a plugin is later mounted (e.g. via bind or volume) it should appear under `app/Plugins/<PluginName>` with: `composer.json`, `register.php`, optional `bootstrap.php`, `Controllers/`, `Views/`, `Language/`, and possibly a `dist/` directory. Absence today means any future appearance is attributable to an added plugin and can be diffed against this inventory.

## 3. Marketplace / Paid Feature Traces
| Feature / Product (marketplace) | OSS Artifacts Found | Missing (Implied Paid) | Recoverability* |
|---------------------------------|---------------------|------------------------|-----------------|
| Pomodoro Timer | `public/assets/js/libs/pomodoro/pomodoro.js`; drag target hints in `public/assets/js/app/core/nestedSortable.js` (class `.pomodoroDrop`) | Packaged plugin wrapper (register.php, menu, view, persistence, integration with tasks/time log) | Medium |
| Advanced Auth (OAuth + SAML + PAT) | Socialite vendor libs in `vendor/`; env var pattern (docs); no plugin dir or UI | Provider config UI, callback routes, PAT issuance, SAML ACS & metadata mgmt, license gating | Low |
| Strategy / StrategyPro | Existing project type & menu link (`menu.blueprints`, references in `Projects/Controllers/Createnew.php`) | Enhanced boards, advanced strategy canvases, dashboards | Low–Medium |
| Program / Portfolio (pgmPro) | Availability check `pgmPro` in `Createnew.php` | Aggregation views & metrics | Low |
| Notes / NotesPro | Core Wiki/Notes (templates, menu) | Pro enhancements (tagging, version diff, AI summaries, maybe advanced search) | Medium (base) / Low (delta) |
| Whiteboards | None (only generic Canvas & retros canvas domains) | Realtime whiteboard UI (tldraw/excalidraw), persistence, collab | Low |
| MCP / API / Integrations | Core API modules & events | Packaged remote control endpoints, token UI (ties to Advanced Auth) | Medium |

*Recoverability = how much can be rebuilt quickly from visible OSS code.

## 4. Pomodoro Timer Conversion Plan
Existing front-end code is self‑contained (pure JS + DOM expects certain element IDs & alarm assets). To convert into a plugin:
1. Create directory: `/app/Plugins/Pomodoro/`.
2. Add `composer.json`:
   ```json
   {
     "name": "yourorg/pomodoro",
     "description": "Pomodoro timer plugin (OSS extraction)",
     "version": "0.1.0",
     "type": "leantime-plugin",
     "autoload": {"psr-4": {"Leantime\\Plugins\\Pomodoro\\": "/"}}
   }
   ```
3. `register.php`:
   ```php
   <?php
   use Leantime\Domain\Plugins\Services\Registration;
   $registration = app()->makeWith(Registration::class, ['pluginId' => 'Pomodoro']);
   $registration->registerLanguageFiles(['en-US']);
   $registration->addMenuItem([
       'title' => 'pomodoro.menu.title',
       'icon' => 'fa fa-hourglass-half',
       'tooltip' => 'pomodoro.menu.tooltip',
       'href' => '/pomodoro/show'
   ], 'personal', [90]);
   $registration->addFooterJs(['pomodoro.js']);
   $registration->addCss(['pomodoro.css']);
   ```
4. `Language/en-US.ini`:
   ```ini
   pomodoro.menu.title = "Pomodoro"
   pomodoro.menu.tooltip = "Focus timer"
   pomodoro.headline = "Pomodoro Timer"
   pomodoro.start = "Start"
   pomodoro.pause = "Pause"
   pomodoro.reset = "Reset"
   ```
5. Controller `Controllers/PomodoroController.php` returning Blade view.
6. View `Views/show.blade.php` containing HTML structure expected by JS (buttons `btn_start`, `btn_pause`, etc.).
7. Move `pomodoro.js` (minify/adjust) into plugin root `dist/` (or source + build). For simple case you can store raw JS in `dist/pomodoro.js` and reference via manifest (see below).
8. Build Manifest Integration: The `Registration` helper auto-registers `dist` if present. Create a minimal `mix-manifest.json` segment for plugin or run the Leantime asset build process including plugin dist directory; simplest manual manifest (if supported) mapping original paths: `{"/var/www/html/app/Plugins/Pomodoro/dist/pomodoro.js":"/app/Plugins/Pomodoro/dist/pomodoro.js"}`.
9. (Optional) Associate dragged ticket: Add drop handler that, when `.pomodoroDrop` receives a ticket ID, updates a hidden field or starts timer & posts to new plugin controller endpoint (for future timesheet logging).

## 5. Docker Compose: Persisting & Developing Plugins
Current compose volume for plugins:
```yaml
volumes:
  - plugins:/var/www/html/app/Plugins
```
This is a named volume (data lives in Docker internal volume). To edit plugin code from host, prefer a bind mount:
```yaml
  - ./plugins:/var/www/html/app/Plugins
```
Recommended approach:
1. Create a `plugins/` folder next to your `docker-compose.yml` on the host.
2. Add (or copy out) plugin code there.
3. Switch volume definition from named volume to bind mount (as above). Remove `plugins:` under top-level `volumes:` if you no longer want the named volume. (Keep backups first.)

### Migrating Existing Named Volume to Host Folder
If you already populated the named volume and want to extract:
```sh
# Create host folder
mkdir -p plugins_export
# Copy from container (container name: leantime)
docker cp leantime:/var/www/html/app/Plugins/. ./plugins_export/
# Update compose to bind mount ./plugins_export -> /var/www/html/app/Plugins
# Rename folder to 'plugins' and adjust compose
mv plugins_export plugins
```
Then `docker compose up -d --force-recreate`.

### Alternative: Custom Image Bake-In
Create `Dockerfile`:
```Dockerfile
FROM leantime/leantime:latest
COPY plugins/Pomodoro /var/www/html/app/Plugins/Pomodoro
```
Build & run with same external data volumes for DB, userfiles, logs.
Use when you want immutable plugin code across environments.

## 6. Persistent Data Overview
| Data Type | Location in Container | Current Persistence Method | Recommendation |
|-----------|-----------------------|----------------------------|----------------|
| MySQL DB | `leantime_db` -> `/var/lib/mysql` | Named volume `db_data` | Keep; schedule dumps |
| User uploads (public) | `/var/www/html/public/userfiles` | `public_userfiles` volume | Retain; include in backups |
| Private uploads | `/var/www/html/userfiles` | `userfiles` volume | Retain; back up |
| Plugins code | `/var/www/html/app/Plugins` | Named volume `plugins` | Switch to bind mount for dev OR bake into image |
| Logs | `/var/www/html/storage/logs` | `logs` volume | Rotate & back up selectively |

## 7. Backup Strategy
Goal: Safeguard against accidental container rebuilds or image updates.

### 7.1 Database Dumps
Ad‑hoc:
```sh
docker exec leantime_db mysqldump -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --port=13306 "$MYSQL_DATABASE" > backup_$(date +%Y%m%d_%H%M)_leantime.sql
```
(Port flag optional inside container; credentials from `.env`.)

Automated (cron on host):
```sh
0 2 * * * docker exec leantime_db mysqldump -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > /backups/db_$(date +\%F).sql 2>>/backups/backup.log
```

### 7.2 Volume Archives
Generic function (run from directory with write permission):
```sh
for v in db_data userfiles public_userfiles plugins logs; do 
  docker run --rm -v ${v}:/data -v "$PWD":/backup busybox \
    sh -c "tar czf /backup/${v}_$(date +%Y%m%d_%H%M).tgz -C /data .";
done
```

### 7.3 Restore Procedure
Database:
```sh
docker exec -i leantime_db mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < backup_YYYYMMDD_HHMM_leantime.sql
```
Volume (example for plugins):
```sh
docker run --rm -v plugins:/data -v $PWD:/backup busybox sh -c "rm -rf /data/* && tar xzf /backup/plugins_YYYYMMDD_HHMM.tgz -C /data"
```

### 7.4 Integrity & Retention
- Keep at least 7 daily, 4 weekly, 3 monthly database snapshots.
- Hash (SHA256) each archive; store manifest.
- Test restore quarterly into a staging stack (clone compose with different network & volume names).

## 8. Disaster Recovery Checklist
1. Stop stack: `docker compose down` (keep volumes).
2. Launch DB only & restore dump (if needed).
3. Restore plugin & userfile volumes from most recent archives.
4. Bring stack up: `docker compose up -d`.
5. Verify login, menu integrity, plugin availability.
6. Rebuild custom image if using baked-in plugin & tag drifted.

## 9. Development Workflow for New Plugin (Pomodoro Example)
| Step | Action |
|------|--------|
| 1 | Bind mount `./plugins` → container |
| 2 | Scaffold `Pomodoro` plugin (files same as §4) |
| 3 | Run container; hit `/pomodoro/show` to test UI |
| 4 | Add language overrides for other locales if needed |
| 5 | Implement optional ticket drag start (JS) & endpoint |
| 6 | Add timesheet integration after timer completes |
| 7 | Write minimal PHPUnit test (controller returns 200) |
| 8 | Tag version in plugin `composer.json` before packaging |

## 10. Packaging & Distribution (Optional)
To distribute as marketplace-style folder plugin (not PHAR):
1. Ensure clean `composer.json`.
2. Include `LICENSE` & `README.md` inside plugin directory.
3. (Optional) Provide build script that emits minified JS/CSS into `dist/`.
4. Zip contents of `Pomodoro` folder (excluding `.git`, node modules if any) for portability.

## 11. Security Considerations
- Never commit secrets (provider client secrets) into plugin folder when switching to bind mount.
- Use environment variables or secure settings service for OAuth credentials (Advanced Auth scenario).
- Validate incoming IDs on any timer/ticket association endpoint to avoid unauthorized time logging.

## 12. Next Suggested Actions
1. Switch `plugins` volume to bind mount if you plan active development.
2. Scaffold Pomodoro plugin skeleton (can be automated next).
3. Set up nightly DB + weekly volume backups.
4. Draft Advanced Auth plugin design doc (data model + route map) before coding.

## 13. Reference Commands (Convenience)
```sh
# Copy a file (e.g., existing JS) out of container
docker cp leantime:/var/www/html/public/assets/js/libs/pomodoro/pomodoro.js ./plugins/Pomodoro/dist/pomodoro.js

# Exec interactive shell
docker exec -it leantime sh

# List volumes with size (Docker 24+ may need plugin)
docker system df -v | grep -E 'db_data|plugins|userfiles'
```

## 14. Limitations / Notes
- No proprietary marketplace plugin PHP code present; only surface references & generic assets (Pomodoro JS) visible.
- Reconstructing paid plugins beyond exposed assets must avoid license infringement—build functionally similar, original code.
 - Inventory tables (§2.2, §2.3) reflect repository state at generation time; re-run audit after mounting new plugins to update.
 - Strategy/Notes core features in OSS may overlap naming with commercial variants; differentiation relies on enhanced UI or added services absent here.

## 15. Customization Surfaces (Themes, Assets, Plugins)  
This section documents every currently observable customization vector so future custom work (themes, override CSS/JS, build artifacts) can be tracked alongside plugin findings.

### 15.1 Theme System (Current State)
Location: `public/theme/default/`
Files:
| File/Folder | Purpose |
|-------------|---------|
| `theme.ini` | Declares theme metadata (name, colors, logo path, feature flags). |
| `css/light.css` / `css/dark.css` | Final (precompiled) style overrides for light & dark modes. |
| `layout/` | Layout fragments (if any) – allows structural overrides. |

Example `theme.ini` (from repo):
```
[general]
name = "More"
description = "Leantime theme"
version = "1.0.0"
logo = "/dist/images/logo.svg"
primaryColor = "#004666"
secondaryColor = "#00a887"
colorModeSupport = true
colorPickerSupport = true
```

To create a custom theme (no recompilation):
1. Copy `public/theme/default` → `public/theme/<YourTheme>`.
2. Edit `<YourTheme>/theme.ini` (change `name`, colors, `logo`).
3. Modify `css/light.css` & `css/dark.css` with variable or class overrides.
4. (Optional) Add custom layout partials in `layout/`.
5. Configure app (setting or small plugin) to select the new theme.

Mount strategy (persist across container rebuilds): bind mount an external `./theme` directory to `/var/www/html/public/theme` in compose (add an entry similar to how `plugins` is mounted).

### 15.2 Asset Compilation & Dist Pipeline
Observed source inputs:
| Source | Path | Notes |
|--------|------|-------|
| LESS Aggregate | `public/assets/less/main.less` | Imports numerous library CSS files. |
| Editor Styles | `public/assets/less/editor.less` | WYSIWYG/editor imports. |
| Tailwind Layer | `public/assets/less/app.less` | Contains `@tailwind` directives. |

Compiled outputs: `public/dist/` (CSS & JS) referenced via `public/dist/mix-manifest.json` and served through custom `Mix` class (`app/Core/Support/Mix.php`).

Currently missing from repo: build scripts (`webpack.mix.js`, `vite.config.js`). Therefore, *rebuilding core hashed assets* requires reconstructing a toolchain (see 15.6) or limiting changes to theme/plugin-level CSS/JS.

### 15.3 Adding Custom CSS/JS Without Rebuilding Core
Best practice: deliver via a plugin so it’s tracked as an extension.
1. Create plugin with `dist/` directory.
2. Place `custom.css`, `custom.js` inside `dist/`.
3. Add a `mix-manifest.json` in that `dist/`:
  ```json
  {"/custom.css": "/custom.css", "/custom.js": "/custom.js"}
  ```
4. In `register.php`:
  ```php
  $registration->addCss(['custom.css']);
  $registration->addFooterJs(['custom.js']);
  ```
5. `Registration` auto-registers plugin `dist` path (via event) → `Mix` exposes files at `/api/static-asset/<plugin-slug>/...`.

No build step needed if you supply already-minified assets.

### 15.4 Other Customization Vectors
| Vector | Mechanism | Needs Compile? | Tracking Note |
|--------|-----------|----------------|--------------|
| Branding (logos, colors) | Theme folder edits | No | Record theme folder name in this doc when added. |
| Fonts | Theme CSS `@font-face` | No | Store font files under theme or plugin dist. |
| Menus | Plugin `addMenuItem()` | No | Document plugin & menu key here on addition. |
| Translations | Plugin `Language/*.ini` | No | Add language codes used. |
| Event Behaviors | Plugin event listeners | No | Note hook names used to avoid collisions. |
| New Pages | Plugin controller + view | No | Namespace under plugin folder. |
| Data Extensions | Plugin service/model classes | No | Composer autoload inside plugin. |
| Tailwind Utilities | Rebuild `app.less` & pipeline | Yes | Only if deep structural changes. |
| Global CSS Refactor | Recompile `main.less` | Yes | Capture build process + hash alignment. |

### 15.5 When Recompilation is Strictly Necessary
Trigger conditions:
- Need to remove unused Tailwind utilities (size optimization).
- Upgrading Bootstrap or core library CSS referenced in `main.less`.
- Introducing new global utility classes that must appear in hashed `main.*.min.css` (rather than separate plugin file for performance reasons).

If only adding features or overrides, prefer plugin or theme-based attach to avoid complexity.

### 15.6 Reconstructing a Lightweight Build Pipeline (Outline)
*(Do this only if unavoidable)*
1. Create `package.json` with dependencies: `tailwindcss`, `postcss`, `autoprefixer`, `less`, optionally `esbuild`.
2. Scripts example:
  ```json
  {
    "scripts": {
     "build:less": "lessc public/assets/less/main.less public/dist/css/main.custom.css && lessc public/assets/less/editor.less public/dist/css/editor.custom.css",
     "build:tailwind": "tailwindcss -i public/assets/less/app.less -o public/dist/css/app.custom.css --minify",
     "build": "npm run build:less && npm run build:tailwind && node scripts/gen-manifest.js"
    }
  }
  ```
3. `scripts/gen-manifest.js`: merge new compiled file paths into `mix-manifest.json` keeping existing entries unless you intend to replace them.
4. Optionally version/hard-hash file names yourself (e.g. `app.custom.<timestamp>.css`).
5. Custom Docker build (multi-stage) installs Node, runs build, copies only `public/dist` into final image.

### 15.7 Safely Replacing Dist Assets
If replacing any existing key (e.g. `/css/main.3.5.12.min.css`):
1. Backup original `mix-manifest.json` & dist file.
2. Keep naming convention or update manifest & ensure no cached references remain.
3. Test in staging container before promoting.

### 15.8 Theme vs Plugin Decision Matrix
| Goal | Prefer Theme | Prefer Plugin |
|------|--------------|---------------|
| Pure visual (color/logo) | ✔ | |
| Add page + menu entry | | ✔ |
| Inject small JS widget | | ✔ |
| Replace base layout structure globally | ✔ | (plugin possible but theme clearer) |
| Ship feature for reuse/share | | ✔ |
| Company-specific brand only | ✔ | |

### 15.9 Recording Future Custom Work
When a new custom theme or plugin is added, append a subsection here:
```
#### Custom Theme: MyCorpX (Added 2025-09-10)
Path: public/theme/mycorpx
Purpose: Brand colors & header layout.
Notes: No dist rebuild; uses custom fonts under theme css/.

#### Custom Plugin: FocusTools (Added 2025-09-11)
Path: app/Plugins/FocusTools
Assets: dist/custom.css, dist/custom.js (manifest entries)
Hooks Used: addMenuItem(personal,[95]), addFooterJs, addCss
```

Maintaining this ledger ensures upgrade & merge safety.

### 15.10 Quick Actions Summary
| Need | Action |
|------|--------|
| New brand | Copy theme → edit `theme.ini` & CSS |
| Extra CSS/JS | Plugin with `dist/` + manifest + `addCss`/`addFooterJs` |
| New feature page | Plugin controller + view + menu item |
| Deep global style overhaul | Rebuild pipeline (15.6) |
| Minor override only | Add to theme `light.css` / `dark.css` |

---
*End of customization additions integrated into plugin findings audit.*

---
Prepared automatically inside container environment.
