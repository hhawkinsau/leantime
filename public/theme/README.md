# Leantime Custom Themes Directory

This directory contains custom themes for Leantime. Themes allow you to customize the appearance of your Leantime instance.

## Theme Structure

Each theme should be in its own subdirectory and follow this structure:
```
ThemeName/
├── theme.ini             # Theme metadata and configuration  
├── css/
│   ├── light.css        # Light mode styles
│   └── dark.css         # Dark mode styles
├── layout/              # Optional layout overrides
├── images/              # Theme-specific images
└── fonts/               # Custom fonts (optional)
```

## Theme Configuration (theme.ini)

```ini
[general]
name = "My Custom Theme"
description = "Custom theme for our organization"
version = "1.0.0"
logo = "/theme/custom/MyTheme/images/logo.svg"
primaryColor = "#004666"
secondaryColor = "#00a887"
colorModeSupport = true
colorPickerSupport = true
```

## CSS Customization

### Light Mode (css/light.css)
```css
:root {
  --primary-color: #004666;
  --secondary-color: #00a887;
  --background-color: #ffffff;
  --text-color: #333333;
}

/* Custom styles here */
.header-custom {
  background: var(--primary-color);
}
```

### Dark Mode (css/dark.css)
```css
:root {
  --primary-color: #0066cc;
  --secondary-color: #00cc99;
  --background-color: #1a1a1a;
  --text-color: #ffffff;
}

/* Dark mode specific styles */
```

## Development Workflow

1. Create theme directory: `mkdir themes/MyTheme`
2. Add theme.ini and CSS files
3. Configure Leantime to use the theme (via settings or environment)
4. Test in both light and dark modes

## Default Theme

The default Leantime theme is located at `/var/www/html/public/theme/default/` inside the container. You can copy this as a starting point:

```bash
docker cp leantime:/var/www/html/public/theme/default ./themes/MyTheme
```

## Production Notes

- Themes are mounted at `/var/www/html/public/theme/custom/` in the container
- For production, consider building themes into the Docker image
- Test themes thoroughly in both light and dark modes
- Ensure all assets (fonts, images) are properly referenced

## Backup

Custom themes are backed up automatically as part of the bind mount backup process.
