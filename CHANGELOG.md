# Changelog

This repository isn't versioned: every push to `main` is live. Entries are dated, and say what changed for somebody installing the modules.

## 2026-09-16

- The repository serves seven modules: `module-logger`, `module-foundation`, `module-process-guard`, `module-catalog-access`, `module-promotion-access`, `module-cache-vary` and `module-section-policy`.
- Releases from before the Kingletas name are not offered. They require `commerce/*` packages that no longer exist, so they could never install.
- A build is published only when every release in it installs, and never when it lists a repository that isn't public.
