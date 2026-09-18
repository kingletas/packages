# Changelog

This repository isn't versioned: every push to `main` is live. Entries are dated, and say what changed for somebody installing the modules.

## 2026-09-23

- The repository serves nine modules: `module-catalog-index` and `module-catalog-batch` join the seven below, each at 1.0.0. Both had been public since 2026-09-16 with no release, so the `composer require` in their READMEs could not resolve for anybody.

## 2026-09-19

- **A module installs from this repository onto a real store, proved end to end.** On a clean Mage-OS 3.5.0 store that had never used the repository, `composer require kingletas/module-process-guard` resolved three packages from here: `module-process-guard` v2.0.0 against `^2.0`, `module-foundation` v2.3.1 against `^2.0`, and `module-logger` v3.0.0 against `^3.0`. All three enabled, `setup:upgrade` and `setup:di:compile` ran clean, and the module's own console command read the real store's event graph afterwards.
- The transitive dependency resolved to a **newer** version than the flat one, so the constraint solving was real rather than incidental.

## 2026-09-16

- The repository serves seven modules: `module-logger`, `module-foundation`, `module-process-guard`, `module-catalog-access`, `module-promotion-access`, `module-cache-vary` and `module-section-policy`.
- Releases from before the Kingletas name are not offered. They require `commerce/*` packages that no longer exist, so they could never install.
- A build is published only when every release in it installs, and never when it lists a repository that isn't public.
