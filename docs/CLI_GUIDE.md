# Leantime CLI Quick Guide

Date: 2025-09-09

This guide complements `PLUGIN_FINDINGS.md` and documents practical usage of the Leantime console (`bin/leantime`).

## 1. Overview
The CLI is Laravel/Artisan-based. It manages:
- Plugin lifecycle (install/enable/disable/remove/list)
- Database migrations, backups, seeds
- Cache, optimization, events & translations
- System updates
- MCP server discovery & run commands
- User and settings management

It does NOT build front-end assets. Dist assets ship precompiled.

Run base list:
```
php bin/leantime list
```

## 2. Plugin Management
| Action | Command | Notes |
|--------|---------|-------|
| Install from folder/phar | `php bin/leantime plugin:install <Name>` | Name = folder (StudlyCase) under `app/Plugins` |
| Enable | `php bin/leantime plugin:enable <Name>` | Validates & marks enabled in DB/cache |
| Disable | `php bin/leantime plugin:disable <Name>` | Runs deactivate logic for phar if needed |
| Remove | `php bin/leantime plugin:remove <Name>` | Executes uninstall hook then deletes DB row |
| List | `php bin/leantime plugin:list [--installed=1] [--enabled=1]` | Filters by status |

Typical flow after mounting a new plugin folder:
```
php bin/leantime plugin:install Pomodoro
php bin/leantime plugin:enable Pomodoro
php bin/leantime cache:clearAll
```

## 3. Database & Schema
| Purpose | Command | When |
|---------|---------|------|
| Run core & new migrations | `php bin/leantime migrate` or `db:migrate` | After updating code or adding plugin migrations |
| Seed data | `php bin/leantime db:seed` | Initial/demo data |
| Fresh rebuild | `php bin/leantime migrate:fresh` | Dev reset (drops all tables) |
| Backup DB | `php bin/leantime db:backup` | Before upgrades or plugin installs |

## 4. Caching & Optimization
| Target | Command | Effect |
|--------|---------|--------|
| Clear all caches | `php bin/leantime cache:clearAll` | Broad reset of caches (custom command) |
| Config cache | `php bin/leantime config:cache` | Speeds config loading |
| View cache | `php bin/leantime view:cache` / `view:clear` | Blade compilation & cleanup |
| Events cache | `php bin/leantime event:cache` | Discovers & caches event listeners |
| Optimize | `php bin/leantime optimize` / `optimize:clear` | Bootstrap/performance cache build & clear |

## 5. Settings, Users, and Misc
| Task | Command | Notes |
|------|---------|-------|
| Add user | `php bin/leantime user:add --email=... --password=... --role=50` | Roles: 10/20/40/50 etc. |
| Save setting | `php bin/leantime setting:save --key=site_name --value="My Instance"` | Creates if missing |
| Test email | `php bin/leantime email:testemail --to=you@example.com` | Validates mail config |
| Clean orphaned files | `php bin/leantime files:cleanup` | Compares FS vs DB references |
| Check unused translations | `php bin/leantime translations:check-unused` | Helps prune INI entries |
| Clear language cache | `php bin/leantime language:clear` | After adding translation files |

## 6. System Update
```
php bin/leantime system:update
```
Performs code update from GitHub (ensure backups first; may overwrite local modifications). Pre-flight:
1. `php bin/leantime db:backup`
2. Backup plugin & theme volumes
3. Run update
4. `php bin/leantime migrate` if needed

## 7. Maintenance & Housekeeping
| Area | Command | Use Case |
|------|---------|----------|
| Maintenance mode | `php bin/leantime down` / `up` | Graceful maintenance window |
| Event listener validation | `php bin/leantime event:check-listeners` | Ensure no stale references |
| Prune models | `php bin/leantime model:prune` | Cleanup old records (if configured) |
| Queue inspection | `php bin/leantime queue:failed` / `queue:clear` | Background job health |

## 8. MCP (Model Context Protocol)
| Command | Purpose |
|---------|---------|
| `mcp:discover` | Scans for MCP tools/prompts & caches metadata |
| `mcp:list` | Lists discovered elements |
| `mcp:serve --transport=stdio` | Launches MCP server (stdio or http) |

Use for integrating external AI tools or automations referencing Leantime context.

## 9. Typical Automation Scripts
Nightly backup & prune sample (cron host):
```sh
php bin/leantime db:backup
php bin/leantime files:cleanup
php bin/leantime cache:clearAll
```
(Ensure environment variables or `.env` present in cron context.)

## 10. Exit Codes & CI
- Non‑zero exit implies failure (safe for CI gating).
- Combine with `--quiet` or verbosity flags (`-v`, `-vv`, `-vvv`) when scripting.

## 11. Troubleshooting
| Symptom | Resolution |
|---------|------------|
| Plugin not in list after install | Verify folder name (StudlyCase) matches; check `composer.json` inside plugin; run `cache:clearAll`. |
| Command not found | Confirm image version; run `php -v` & `php bin/leantime list`. |
| Migration errors | Check DB user perms & charset; re-run `migrate:status`. |
| Event not firing | Run `event:list` & `event:check-listeners`; ensure plugin `register.php` loaded. |

## 12. Safe Workflow for New Plugin Deployment
1. Copy plugin into mounted `app/Plugins` path.
2. `php bin/leantime plugin:install MyPlugin`
3. `php bin/leantime plugin:enable MyPlugin`
4. (If migrations) `php bin/leantime migrate`
5. `php bin/leantime cache:clearAll`
6. Verify UI & logs.

## 13. Integration With Docker
If using docker compose (named volumes):
- Run commands with `docker exec -it leantime php bin/leantime <command>`.
- Backup DB: `docker exec leantime php bin/leantime db:backup` (outputs where script is configured to write; otherwise use `mysqldump`).

## 14. Future Enhancements (Optional)
Potential helpful additions you could implement:
- `theme:list` / `theme:activate <name>` command
- `assets:scan` to detect unreferenced dist entries
- `plugin:doctor` to validate structure

---
Generated automatically inside container.
