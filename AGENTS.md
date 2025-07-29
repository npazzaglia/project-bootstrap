---
name: "Codex Contribution Guide"
description: "Guidelines for automated contributions to the project-bootstrap repository"
lastUpdated: "2025-07-29"
---

# Codex Contribution Guide

These instructions apply to the entire repository.

## Commit Conventions
- Use [Conventional Commits](https://www.conventionalcommits.org/) for commit messages.
- Keep commits focused and avoid unrelated changes.
- Write descriptive commit bodies when the change is non-trivial.

## Code Guidelines
- Follow POSIX shell style for scripts and include shebangs (`#!/bin/sh`).
- Keep Python code PEP 8 compliant and favor readability over brevity.
- Update documentation in `docs/` when behavior or interfaces change.

## Programmatic Checks
- Run `make lint` and `make test` before every commit. Both should succeed.
- If a check cannot run due to environment limitations, note it in the PR description.

## Pull Requests
- Use `.github/pull_request_template.md` when creating PRs.
- Provide a clear summary of changes and reference related issues.
- Link to any discussion or decision log entries when relevant.

## Additional Notes
- Avoid committing large binaries or secrets.
- Keep the repository tidy by removing stray files or debugging artifacts.

## Post-Fork Setup
- Run `make bootstrap` after creating a new fork. This script updates README badges and runs `bin/post-fork.sh`.
- Review `bin/post-fork.conf` to customize your organization name and default version tag before running the bootstrap.
- Update project metadata such as `README.md`, `LICENSE`, and `CODE_OF_CONDUCT.md` to reflect the new repository.
- Configure GitHub Secrets listed in `bin/post-fork.sh` for CI/CD workflows.
