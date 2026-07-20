# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- CHANGELOG.md for tracking project changes
- CSS custom properties system in `_includes/css/variables.scss` with comprehensive design tokens
- Global focus styles for keyboard navigation accessibility
- Skip link support for keyboard users
- Reduced motion media queries for accessibility
- Text shadow enhancements for better contrast on vibrant backgrounds

### Changed
- Replaced viewport units (`vh`, `vw`) with dynamic viewport units (`dvh`, `dvw`) for better mobile browser compatibility
- Replaced viewport-based font sizes (`vmin`, `vw`) with `clamp()` functions for better accessibility and user zoom support
- Updated all media queries to use consistent spacing variables
- Standardized spacing system using CSS variables while preserving original branding colors
- Updated all image sizing to use responsive `clamp()` functions with max-width constraints
- Enhanced focus states for all interactive elements
- Added `prefers-reduced-motion` support for users who prefer reduced motion
- Removed `prefers-color-scheme` media queries to preserve vibrant/dark branding colors
- Restored original hardcoded color values (#0BC, #FFF, #CCC, etc.) for consistent branding
- Fixed visited link color to use original #0BC instead of variable
- Removed underline from unvisited links to match original design

### Fixed
- Mobile viewport issues with dynamic browser chrome (address bars, toolbars)
- Missing focus indicators for keyboard users
- Inconsistent spacing and sizing across breakpoints
- Hardcoded spacing and sizing values that made maintenance difficult

### Fixed
- Mobile viewport issues with dynamic browser chrome
- Insufficient color contrast for text on vibrant backgrounds
- Missing focus indicators for keyboard users

## [1.0.0] - 2024-07-16

### Added
- Initial project setup with Jekyll
- Main site structure and content
- CSS styling for all pages
- Blog functionality
- Digital garden pages
