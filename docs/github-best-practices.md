# ✅ GitHub Best Practices

> Frequently asked questions about repository workflows and automation standards.

## Branch Naming

Branches should be short lived and use the pattern `type/short-description`,
for example `feat/add-login` or `fix/typo-readme`.

## Semantic Versioning

This project follows [SemVer](https://semver.org/). Increment the version in the
`CHANGELOG` and tags according to the impact of your change.

## Required Checks

All pull requests must pass lint and test jobs before they can be merged.
Failing checks will block the GitHub merge button.

## CI Enforcement

Continuous integration runs via GitHub Actions. Workflows run on every pull
request and on pushes to `main` to ensure quality gates are met.

## Badge Setup

Status badges for CI and other tools can be added to the README using the
shields.io format. Example badges are already configured in this template.

## Contributor Workflow

Fork the repository or create a feature branch. Open a pull request early and
link it to any relevant issues. Follow the pull request template and ensure
checklists are complete.

## Codex Usage Protocols

When using Codex, include the prompt and model details in the pull request as
shown in the template. Review the generated code before merging.
