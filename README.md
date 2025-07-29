# project-bootstrap

> 🛠️ A modern, opinionated GitHub template for scaffolding clean, documented, and CI-ready software projects.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![CI](https://github.com/npazzaglia/project-bootstrap/actions/workflows/ci.yml/badge.svg)](https://github.com/npazzaglia/project-bootstrap/actions/workflows/ci.yml)
[![CodeQL](https://github.com/npazzaglia/project-bootstrap/actions/workflows/codeql.yml/badge.svg)](https://github.com/npazzaglia/project-bootstrap/actions/workflows/codeql.yml)
[![GitHub Template](https://img.shields.io/badge/template-enabled-brightgreen)](https://github.com/npazzaglia/project-bootstrap/generate)

An organizational template for clean, secure, and automation-ready projects.

## Overview

This repository serves as a template for creating robust and scalable software projects. It includes the following components:
- **Source Code**: Located in the `src/` directory.
- **Tests**: Located in the `tests/` directory.
- **Documentation**: Located in the `docs/` directory.
- **Configuration Files**: Located in the `config/` directory.
- **Scripts**: Utility scripts in the `scripts/` directory.

## Getting Started

### Prerequisites

- [Git](https://git-scm.com/)
- [Python 3.11+](https://www.python.org/)
- [Make](https://www.gnu.org/software/make/) (optional)

### Installation

Clone the repository:
```bash
git clone https://github.com/npazzaglia/project-bootstrap.git
cd project-bootstrap
make install
```

### Post-Fork Setup

After cloning or forking this template, run the following bootstrap to initialize your local environment:

```bash
make bootstrap
```

This will:
- Validate GitHub CLI auth
- Set up repo metadata
- Run project-specific initialization

### Running the Project

```bash
make run
# or, if defined, run your app manually:
# python src/main.py
```

## Running Tests

```bash
make test
```

---

## 📚 Documentation

- [Getting Started](docs/getting-started.md)
- [Architecture](docs/architecture.md)
- [Tech Stack](docs/stack.md)
- [Operations](docs/operations.md)
- [Decision Log](docs/decision-log.md)
- [GitHub Best Practices](docs/github-best-practices.md)
- [Changelog](CHANGELOG.md)

---

## 🤝 Contributing

Pull requests are welcome! For major changes, open an issue first to propose your idea.

Please review [`CONTRIBUTING.md`](CONTRIBUTING.md) and [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) before contributing.

---

## 📄 License

MIT License. See [`LICENSE`](LICENSE) for full details.