# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Er is a configurable Hugo theme for blogs with Tailwind CSS styling. The theme features:

- Atom feed generation
- Open graph tags
- Tag and category pages
- Table of contents for posts (using tocbot)
- Math rendering with KaTeX
- Tag cloud display
- Responsive design with Tailwind CSS

## Development Commands

### Setup Development Environment

```bash
# Using Nix (recommended if you have Nix installed)
nix develop

# Without Nix
npm install
```

### Theme Development

```bash
# Watch mode - rebuilds CSS on changes
npm run dev

# Production build - minified CSS
npm run build
```

### Testing with Hugo

```bash
# Preview the theme with Hugo's built-in server
# Run from a test site that uses this theme
hugo server

# Build the site for production
hugo --minify
```

## Architecture

This project follows the standard Hugo theme structure:

1. **Layouts**: HTML templates for different content types
   - `_default/`: Base templates for list and single pages
   - `partials/`: Reusable components (header, footer, navigation)
   - Special templates for RSS/Atom feed and homepage

2. **Assets**: Source files for CSS
   - CSS is processed with Tailwind CSS and PostCSS

3. **Static**: Generated CSS and other static files

4. **Configuration**:
   - `theme.toml`: Theme metadata
   - `tailwind.config.js`: Tailwind CSS configuration
   - `config/_default/module.yaml`: Hugo module configuration

## Customization Points

When modifying this theme, focus on:

1. **Tailwind Styling**: Edit `tailwind.config.js` to change colors, typography, etc.
2. **Layouts**: Modify HTML templates in the layouts directory
3. **CSS**: Edit files in `assets/css/` directory when adding custom CSS outside of Tailwind

## Build Process

The build process uses Tailwind CSS to generate the final CSS:

1. Source CSS is located in `assets/css/input.css`
2. Tailwind processes this file using the configuration in `tailwind.config.js`
3. The output is written to `static/css/styles.css`
4. Hugo then incorporates this stylesheet into the final site