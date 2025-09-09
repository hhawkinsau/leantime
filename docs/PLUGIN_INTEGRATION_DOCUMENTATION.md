# Leantime Plugin Integration - Exact Process Documentation

**Date**: September 9, 2025  
**Author**: Hudson Hawkins (GVM - Global Vision Media)  
**Purpose**: Comprehensive documentation of how custom plugins are integrated in Leantime

## Overview

This document provides the exact technical details of how custom plugins are integrated into the Leantime application, based on analysis of the actual codebase and the existing Pomodoro plugin implementation.

## Plugin Integration Architecture

### 1. Bootstrap Phase (Application Start)

During application initialization, the following sequence occurs:

#### Event Discovery
```php
// In EventDispatcher::discoverEvents()
EventDispatcher::discoverEvents();
```

This method:
1. Loads all domain `register.php` files from `app/Domain/*/register.php`
2. Loads system plugins defined in configuration
3. Initializes the route loading system

#### System Plugin Loading
```php
// System plugins loaded during bootstrap
if (isset(app(Environment::class)->plugins) && $configplugins = explode(',', app(Environment::class)->plugins)) {
    foreach ($configplugins as $plugin) {
        if (file_exists($pluginEventsPath = APP_ROOT.'/app/Plugins/'.$plugin.'/register.php')) {
            include_once $pluginEventsPath;
        }
    }
}
```

System plugins are:
- Defined in environment configuration (`LEAN_PLUGINS` env var)
- Always loaded and cannot be disabled via UI
- Loaded before user-enabled plugins

#### Route Loading
```php
// Routes loaded for domains and system plugins
RouteLoader::loadRoutes();
```

Routes are loaded in this order:
1. Domain routes (`app/Domain/*/routes.php`)
2. System plugin routes (`app/Plugins/{system-plugin}/routes.php`)
3. User plugin routes (loaded later via event)

### 2. Middleware Phase (Request Processing)

Every HTTP request goes through the `LoadPlugins` middleware:

```php
// In LoadPlugins::handle()
public function handle($request, Closure $next): Response
{
    // Event Registrar hooks into this and calls enabled plugin register files
    self::dispatchEvent('pluginsStart', ['request' => $request]);

    // Good event to use for all kinds of plugin events that should run early on like adding language files
    self::dispatchEvent('pluginsEvents', ['request' => $request], 'leantime.core.middleware.loadplugins.handle');

    $response = $next($request);

    self::dispatchEvent('pluginsTermintate', ['request' => $request, 'response' => $response]);

    return $response;
}
```

#### Plugin Loading Event
The `pluginsStart` event triggers the loading of user-enabled plugins:

```php
EventDispatcher::add_event_listener('leantime.core.middleware.loadplugins.handle.pluginsStart', function () {
    if (! session('isInstalled')) {
        return;
    }

    $pluginPath = APP_ROOT.'/app/Plugins/';
    $pluginService = app()->make(\Leantime\Domain\Plugins\Services\Plugins::class);
    $enabledPlugins = $pluginService->getEnabledPlugins();

    foreach ($enabledPlugins as $plugin) {
        // Handle incomplete class objects (session cache issues)
        if (is_a($plugin, '__PHP_Incomplete_Class') || $plugin == null) {
            continue;
        }

        if ($plugin->format == 'phar') {
            $pharPath = "phar://{$pluginPath}{$plugin->foldername}/{$plugin->foldername}.phar";
            if (file_exists($pharPath)) {
                include_once $pharPath;
                if (file_exists("$pharPath/register.php")) {
                    include_once "$pharPath/register.php";
                }
            }
        } else {
            // Folder-based plugin
            if (file_exists($registerPath = "{$pluginPath}{$plugin->foldername}/register.php")) {
                include_once $registerPath;
            }
        }
    }
});
```

#### Plugin Events Registration
The `pluginsEvents` event is used for plugin registration activities:

```php
EventDispatcher::add_event_listener('leantime.core.middleware.loadplugins.handle.pluginsEvents', function () {
    // Plugin registration activities happen here
    // Language files, menu items, assets, etc.
}, 50);
```

### 3. Plugin Registration Process

Each plugin's `register.php` file follows this pattern:

```php
<?php
use Leantime\Domain\Plugins\Services\Registration;

$registration = app()->makeWith(Registration::class, ['pluginId' => 'PluginName']);

// Register language files
$registration->registerLanguageFiles(['en-US']);

// Add menu items
$registration->addMenuItem([
    'title' => 'plugin.menu.title',
    'icon' => 'fa fa-icon',
    'tooltip' => 'plugin.menu.tooltip',
    'href' => '/plugin/route'
], 'section', [priority]);

// Register assets
$registration->addCss(['plugin.css']);
$registration->addFooterJs(['plugin.js']);

// Register middleware (optional)
$registration->registerMiddleware([...]);
```

## Registration Service Methods

### Asset Registration

#### CSS Registration
```php
public function addCss(array $paths)
{
    EventDispatcher::add_event_listener('leantime.*.afterLinkTags', function () use ($paths) {
        $mix = app()->make(\Leantime\Core\Support\Mix::class);
        $basePath = $this->getPluginBasePath();
        $files = $mix->getManifest()[$basePath.'/dist'];

        foreach ($paths as $cssFile) {
            if (isset($files[$cssFile])) {
                echo '<link rel="stylesheet" href="'.BASE_URL.$files[$cssFile].'" />';
            }
        }
    });
}
```

#### JavaScript Registration
```php
public function addFooterJs(array $paths)
{
    EventDispatcher::add_event_listener('leantime.*.beforeBodyClose', function () use ($paths) {
        $mix = app()->make(\Leantime\Core\Support\Mix::class);
        $basePath = $this->getPluginBasePath();
        $files = $mix->getManifest()[$basePath.'/dist'];

        foreach ($paths as $jsFile) {
            if (isset($files[$jsFile])) {
                echo '<script src="'.BASE_URL.$files[$jsFile].'"></script>';
            }
        }
    });
}
```

### Menu Integration

```php
public function addMenuItem(array $item, string $section, array $location)
{
    EventDispatcher::add_filter_listener('leantime.domain.menu.repositories.menu.getMenuStructure.menuStructures.'.$section,
        function ($menu) use ($item, $location, $pluginId) {
            // Prepare menu item
            $item['title'] = "<span class='".$item['icon']."'></span> ".__($item['title']);
            $item['tooltip'] = __($item['tooltip']);
            $item['type'] = 'item';
            $item['module'] = $pluginId;

            // Add to menu structure
            $primaryLocationKey = $location[0] ?? $menu[count($menu)];
            if (count($location) <= 1) {
                $menu[$primaryLocationKey] = $item;
            }
            if (count($location) == 2) {
                $submenuLocationKey = $location[1] ?? $menu[$primaryLocationKey]['submenu'][count($menu[$primaryLocationKey]['submenu'])];
                $menu[$primaryLocationKey]['submenu'][$submenuLocationKey] = $item;
            }

            return $menu;
        }, 50
    );
}
```

### Language Integration

```php
public function registerLanguageFiles(array $languages = [])
{
    if (empty($languages)) {
        $languages = $this->findLanguageFiles();
    }

    EventDispatcher::add_event_listener('leantime.core.middleware.loadplugins.handle.pluginsEvents', function () use ($languages) {
        $language = app()->make(Language::class);
        $currentUserLanguage = session('usersettings.language');

        // Register English first, then user language
        if (in_array('en-US', $languages)) {
            $pluginLangArray = $this->loadPluginLanguage('en-US');
            $language->mergeLanguageArray($pluginLangArray);
        }

        if (in_array($currentUserLanguage, $languages)) {
            $pluginLangArray = $this->loadPluginLanguage($currentUserLanguage);
            $language->mergeLanguageArray($pluginLangArray);
        }
    }, 5);
}
```

### Middleware Registration

```php
public function registerMiddleware(array $middleware)
{
    EventDispatcher::add_filter_listener('leantime.core.middleware.loadplugins.handle.pluginsEvents',
        function (array $existing) use ($middleware) {
            return array_merge($existing, $middleware);
        }
    );

    EventDispatcher::add_filter_listener('leantime.core.http.httpkernel.*.plugins_middleware',
        function (array $existing) use ($middleware) {
            return array_merge($existing, $middleware);
        }
    );
}
```

## Route Loading System

### System Plugin Routes
```php
private static function loadSystemPluginRoutes(): void
{
    if (isset(app(Environment::class)->plugins) && $configPlugins = explode(',', app(Environment::class)->plugins)) {
        foreach ($configPlugins as $plugin) {
            if (file_exists($pluginRoutesPath = APP_ROOT.'/app/Plugins/'.$plugin.'/routes.php')) {
                require_once $pluginRoutesPath;
            }
        }
    }
}
```

### User Plugin Routes
```php
private static function loadUserPluginRoutes(): void
{
    if (! session('isInstalled')) {
        return;
    }

    try {
        $pluginService = app()->make(\Leantime\Core\Plugins\Plugins::class);
        $enabledPluginPaths = $pluginService->getEnabledPluginPaths();

        foreach ($enabledPluginPaths as $pluginInfo) {
            $routesPath = $pluginInfo['path'].'/routes.php';
            if (file_exists($routesPath)) {
                require_once $routesPath;
            }
        }
    } catch (\Exception $e) {
        // Silently continue if plugin service is unavailable
    }
}
```

## Asset Management System

### Mix Manifest Integration
```php
protected function registerManifestFolder()
{
    if ($this->distFolderRegistered === false) {
        $distPath = '';
        $basePath = $this->getPluginBasePath();
        if (file_exists($basePath.'/dist')) {
            $distPath = $basePath.'/dist';
        }

        if ($distPath !== '') {
            EventDispatcher::add_filter_listener(
                'leantime.core.support.mix.__construct.mix_manifest_directories',
                function (array $directories) use ($distPath) {
                    return array_merge($directories, [$distPath]);
                }
            );
            $this->distFolderRegistered = true;
        }
    }
}
```

### Plugin Base Path Resolution
```php
private function getPluginBasePath()
{
    $pluginPath = APP_ROOT.'/app/Plugins/';
    $pharPath = "phar://{$pluginPath}{$this->pluginId}/{$this->pluginId}.phar";
    $regularPath = "{$pluginPath}{$this->pluginId}";

    if (file_exists($pharPath)) {
        return $pharPath;
    }

    if (file_exists($regularPath)) {
        return $regularPath;
    }

    return '/';
}
```

## Plugin Structure Requirements

### Required Files
```
PluginName/
├── composer.json          # Plugin metadata and PSR-4 autoloading (REQUIRED)
├── register.php           # Bootstrap file (REQUIRED)
├── Services/              # Business logic (REQUIRED)
│   └── PluginName.php     # Main service class (REQUIRED)
├── Controllers/           # HTTP endpoints
├── Models/                # Data structures
├── Views/                 # Blade template files
├── Language/              # Internationalization files (.ini format)
├── dist/                  # Compiled assets (CSS/JS)
├── bootstrap.php          # Optional additional initialization
├── routes.php             # Optional route definitions
└── Docs/                  # Optional documentation
```

**Critical Requirements:**
- **`Services/PluginName.php` is REQUIRED** - The plugin installation process expects a service class with the same name as the plugin folder
- **Service class must implement install/uninstall methods** - Even if empty, these methods are called during plugin lifecycle

## HelloWorld Plugin Example

Based on the official Leantime documentation, here's a complete working example:

### Directory Structure
```
/app/Plugins/HelloWorld/
├── bootstrap.php           # Plugin initialization
├── composer.json          # Plugin metadata
├── register.php          # Event/feature registration
├── Controllers/         # Plugin controllers
│   └── HelloWorld.php  # Main controller
├── Views/              # Blade templates
│   └── show.blade.php # Main view
├── Language/          # Translation files
│   └── en-US.ini     # English translations
└── Docs/             # Documentation
    └── plugin-development.md
```

### composer.json
```json
{
    "name": "leantime/helloworld",
    "description": "A simple Hello World plugin for Leantime",
    "version": "1.0.0",
    "type": "leantime-plugin",
    "license": "MIT",
    "autoload": {
        "psr-4": {
            "Leantime\\Plugins\\HelloWorld\\": "/"
        }
    }
}
```

### register.php
```php
<?php
use Leantime\Domain\Plugins\Services\Registration;

$registration = app()->makeWith(Registration::class, ['pluginId' => 'HelloWorld']);

// Register languages
$registration->registerLanguageFiles(['en-US']);

// Add menu item
$registration->addMenuItem([
    'title' => 'helloworld.menu.title',
    'icon' => 'fa fa-smile',
    'tooltip' => 'helloworld.menu.tooltip',
    'href' => '/hello-world/show',
], 'personal', [10]);
```

### Service (Services/HelloWorld.php)
```php
<?php
namespace Leantime\Plugins\HelloWorld\Services;

/**
 * HelloWorld Service
 * 
 * Handles plugin business logic and lifecycle management.
 * This class is REQUIRED for plugin installation.
 */
class HelloWorld
{
    /**
     * Install the plugin
     */
    public function install(): void
    {
        // Plugin installation logic can go here
        // For simple plugins, this can be empty
    }

    /**
     * Uninstall the plugin
     */
    public function uninstall(): void
    {
        // Plugin uninstallation logic can go here
        // For simple plugins, this can be empty
    }
}
```

### Controller (Controllers/HelloWorld.php)
```php
<?php
namespace Leantime\Plugins\HelloWorld\Controllers;

use Leantime\Core\Controller;

class HelloWorldController extends Controller
{
    public function show()
    {
        return $this->tpl->display('plugins.helloworld.show');
    }
}
```

### View (show.blade.php)
```blade
@extends($layout)

@section('content')
    <div class="pageheader">
        <div class="pageicon"><i class="fa fa-smile"></i></div>
        <div class="pagetitle">
            <h1>{{ __('helloworld.headline') }}</h1>
        </div>
    </div>

    <div class="maincontent">
        <div class="maincontentinner">
            <h3>{{ __('helloworld.text') }}</h3>
        </div>
    </div>
@endsection
```

### Language File (en-US.ini)
```ini
helloworld.menu.title = "Hello World"
helloworld.menu.tooltip = "A simple Hello World example"
helloworld.headline = "Hello World Plugin"
helloworld.text = "Hello from your first Leantime plugin!"
```

### Composer.json Requirements
```json
{
    "name": "vendor/plugin-name",
    "description": "Plugin description",
    "version": "1.0.0",
    "type": "leantime-plugin",
    "homepage": "https://github.com/vendor/plugin-name",
    "authors": [
        {
            "name": "Author Name",
            "email": "author@example.com"
        }
    ],
    "autoload": {
        "psr-4": {
            "Leantime\\Plugins\\PluginName\\": "/"
        }
    },
    "require": {
        "php": ">=8.2"
    },
    "license": "MIT",
    "keywords": ["plugin", "leantime-plugin"]
}
```

**Critical Requirements:**
- **`homepage` field is REQUIRED** - Plugin discovery will fail with "Undefined array key 'homepage'" error if missing
- **`Services` directory and class are REQUIRED** - Plugin installation will fail if `Services\PluginName` class doesn't exist

## Frontcontroller Routing Pattern

Leantime uses a frontcontroller pattern for automatic routing based on URL structure.

### URL Structure
- `/module/controller/method` maps to `ModuleName\Controllers\ControllerName::method()`
- `/hx/module/controller/method` maps to `ModuleName\Hxcontrollers\ControllerName::method()`
- Plugin controllers use namespace: `Leantime\Plugins\ModuleName\Controllers\ControllerName`

### Controller Resolution Process
```php
// In Frontcontroller::getClassPath()
public function getClassPath(string $controllerType, string $moduleName, string $actionName): string
{
    $controllerNs = 'Domain';
    $classname = 'Leantime\\Domain\\'.$moduleName.'\\'.$controllerType.'\\'.$actionName;

    if (class_exists($classname)) {
        return $classname;
    }

    // Check if hxcontroller exists
    $classname = 'Leantime\\Domain\\'.$moduleName.'\\Hxcontrollers\\'.$actionName;
    if (class_exists($classname)) {
        return $classname;
    }

    // Check plugin controllers
    $classname = 'Leantime\\Plugins\\'.$moduleName.'\\'.$controllerType.'\\'.$actionName;

    // Verify plugin is enabled
    $enabledPlugins = app()->make(\Leantime\Domain\Plugins\Services\Plugins::class)->getEnabledPlugins();
    $pluginEnabled = false;
    foreach ($enabledPlugins as $key => $obj) {
        if (strtolower($obj->foldername) !== strtolower($moduleName)) {
            continue;
        }
        $pluginEnabled = true;
        break;
    }

    if (!$pluginEnabled) {
        return false; // Plugin not enabled
    }

    if (class_exists($classname)) {
        return $classname;
    }

    // Check plugin hxcontrollers
    $classname = 'Leantime\\Plugins\\'.$moduleName.'\\Hxcontrollers\\'.$actionName;
    if (class_exists($classname)) {
        return $classname;
    }

    return false;
}
```

### Example URL Mappings
- `/pomodoro/show` → `Leantime\Plugins\Pomodoro\Controllers\Pomodoro::show()`
- `/hx/pomodoro/update` → `Leantime\Plugins\Pomodoro\Hxcontrollers\Pomodoro::update()`
- `/hello-world/show` → `Leantime\Plugins\HelloWorld\Controllers\HelloWorld::show()`

### URL Parsing Logic
```php
// In Frontcontroller::parseRequestParts()
$segments = $request->segments();

// First part is hx tells us this is a htmx controller request
$controllerType = 'Controllers';
if ($segments[0] == 'hx') {
    array_shift($segments);
    $controllerType = 'Hxcontrollers';
}

// First segment is always module
$moduleName = $segments[0] ?? '';

// Second is action (controller name)
$controllerName = $segments[1] ?? '';

// Third is either id or method
if (isset($segments[2]) && (is_numeric($segments[2]) || Str::isUuid($segments[2]))) {
    $id = $segments[2];
} else {
    $method = $segments[2];
}
```

## Event System Integration

### Key Events
- `pluginsStart` - Triggered when plugin loading begins
- `pluginsEvents` - Used for plugin registration activities
- `pluginsTerminate` - Triggered after request processing
- `leantime.*.afterLinkTags` - For CSS injection
- `leantime.*.beforeBodyClose` - For JavaScript injection

### Event Usage
```php
// Add event listener
EventDispatcher::add_event_listener('event.name', $callback, $priority);

// Add filter listener
EventDispatcher::add_filter_listener('filter.name', $callback, $priority);
```

## Plugin Types and Formats

### Plugin Types
1. **System Plugins**: Defined in config, always loaded, cannot be disabled
2. **Marketplace Plugins**: From marketplace, phar format, license validation
3. **Custom Plugins**: Folder-based, user-enabled via admin interface

### Plugin Formats
1. **Folder Format**: Regular directory structure
2. **Phar Format**: Compressed archive (marketplace plugins only)

## Security Considerations

- Plugins run with same privileges as core application
- Input validation required for all user inputs
- No direct database access (use repositories)
- Follow principle of least privilege
- Validate file uploads and handle securely

## Performance Considerations

- Language files are cached for 7 days
- Plugin discovery is cached in production
- Assets use Mix manifest for versioning
- Middleware runs after core pipeline

## Development Workflow

1. Create plugin directory structure
2. Implement `composer.json` with proper autoloading **and required `homepage` field**
3. Create `Services/PluginName.php` class with install/uninstall methods
4. Create `register.php` with registration logic
5. Add controllers, services, and views
6. Include language files and assets
7. Test plugin functionality
8. Package for distribution

**Critical Steps:**
- **Step 2**: Must include `homepage` field in composer.json or plugin discovery will fail
- **Step 3**: Must create Services class or plugin installation will fail

## Troubleshooting

### Common Issues

#### Plugin Discovery Failures
- **"Invalid plugin name" error**: Plugin not found in discovery
  - Check `composer.json` has required `homepage` field
  - Verify plugin folder name matches expected structure
  - Ensure `register.php` exists and is valid

- **"Undefined array key 'homepage'" error**: Missing required field in composer.json
  - Add `"homepage": "https://github.com/vendor/plugin-name"` to composer.json

#### Plugin Installation Failures
- **"Target class [Services\PluginName] does not exist" error**: Missing service class
  - Create `Services/PluginName.php` with install/uninstall methods
  - Ensure class name matches plugin folder name exactly

- **Plugin not loading**: Check `register.php` exists and is valid
- **Assets not loading**: Verify `dist/` folder and manifest registration
- **Menu items not appearing**: Check menu section and location parameters
- **Language not working**: Verify `.ini` files in `Language/` directory

### Debug Information
- Check `storage/logs/` for error messages
- Verify plugin is enabled in database
- Ensure proper file permissions
- Check autoloading configuration

## CLI Plugin Management

Leantime provides a comprehensive command-line interface for plugin management through `php bin/leantime [command]`.

### CLI Architecture

The CLI is built on Laravel's Artisan console with custom Leantime extensions:

```php
// CLI Entry Point: bin/leantime
#!/usr/bin/env php
<?php
use Leantime\Core\Console\ConsoleKernel;
use Symfony\Component\Console\Input\ArgvInput;

define('LEAN_CLI', true);
define('ARTISAN_BINARY', 'bin/leantime');

require __DIR__.'/../vendor/autoload.php';
$app = require_once __DIR__.'/../bootstrap/app.php';
$status = $app->handleCommand(new ArgvInput);
exit($status);
```

### Plugin Management Commands

#### List Plugins
```bash
# List all available plugins
php bin/leantime plugin:list

# List only installed plugins
php bin/leantime plugin:list --installed=true

# List only enabled plugins
php bin/leantime plugin:list --enabled=true

# List plugins that are both installed and enabled
php bin/leantime plugin:list --installed=true --enabled=true
```

#### Plugin Lifecycle
```bash
# Install a plugin (from folder/phar)
php bin/leantime plugin:install PluginName

# Enable a plugin
php bin/leantime plugin:enable PluginName

# Disable a plugin
php bin/leantime plugin:disable PluginName

# Remove a plugin (executes uninstall hook)
php bin/leantime plugin:remove PluginName
```

### CLI Command Structure

All plugin commands extend `AbstractPluginCommand`:

```php
abstract class AbstractPluginCommand extends Command
{
    protected function getAllPlugins(): array
    {
        $installedPlugins = $this->plugins->getAllPlugins() ?: [];
        $discoveredPlugins = $this->plugins->discoverNewPlugins();
        
        return array_values(array_merge($installedPlugins, $discoveredPlugins));
    }

    protected function getPlugin(string $name): InstalledPlugin
    {
        $allPlugins = $this->getAllPlugins();
        foreach ($allPlugins as $plugin) {
            if ($name === $plugin->name) {
                return $plugin;
            }
        }
        throw new RuntimeException(sprintf('Invalid plugin name: %s', $name));
    }
}
```

### Plugin Discovery Process

The CLI automatically discovers plugins by:

1. **Scanning Directory**: Checks `app/Plugins/` for plugin folders
2. **Reading Metadata**: Parses `composer.json` files for plugin information
3. **Validating Structure**: Ensures `register.php` exists
4. **Checking Dependencies**: Validates plugin requirements

### Complete Plugin Development Workflow

```bash
# 1. Create plugin directory structure
mkdir -p app/Plugins/MyPlugin/{Controllers,Services,Models,Views,Language,dist}

# 2. Add composer.json with proper metadata
# 3. Create register.php with registration logic
# 4. Implement controllers, services, and views
# 5. Add language files and assets

# 6. Install the plugin
php bin/leantime plugin:install MyPlugin

# 7. Enable the plugin
php bin/leantime plugin:enable MyPlugin

# 8. Clear caches to ensure changes take effect
php bin/leantime cache:clearAll

# 9. Run migrations if plugin has database changes
php bin/leantime migrate

# 10. Test the plugin functionality
# 11. List plugins to verify installation
php bin/leantime plugin:list --installed=true
```

### Additional CLI Commands

#### System Management
```bash
# Update Leantime installation
php bin/leantime system:update

# Add a new user
php bin/leantime user:add

# Save system settings
php bin/leantime setting:save key value
```

#### Database Operations
```bash
# Run migrations
php bin/leantime migrate

# Seed database
php bin/leantime db:seed

# Fresh migration (drops all tables)
php bin/leantime migrate:fresh

# Backup database
php bin/leantime db:backup
```

#### Cache Management
```bash
# Clear all caches
php bin/leantime cache:clearAll

# Cache configuration
php bin/leantime config:cache

# Optimize application
php bin/leantime optimize
```

#### Development Tools
```bash
# List all registered events
php bin/leantime event:list

# Clear event cache
php bin/leantime event:clear

# Check translation files
php bin/leantime translation:check

# Test email configuration
php bin/leantime email:test
```

### CLI Features

- **Interactive Mode**: Prompts for confirmation on destructive operations
- **Non-Interactive Mode**: Supports automated scripts and CI/CD
- **Error Handling**: Comprehensive error messages and exit codes
- **Plugin Validation**: Ensures plugin structure and dependencies
- **Cache Management**: Automatic cache clearing after plugin operations
- **Database Integration**: Handles plugin migrations and data

This documentation provides the complete technical details of how plugins are integrated into Leantime, including CLI management, based on analysis of the actual codebase implementation.
