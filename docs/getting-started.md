# 🚀 Getting Started

> This guide explains how to set up your development environment and run the project locally.

## Prerequisites

- [ ] Git
- [ ] Python 3.11+ (or other runtime depending on the project)
- [ ] Make / Bash (or just CLI tools)
- [ ] Docker (if applicable)
- [ ] Virtualenv or pyenv (optional)

## Setup

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/YOUR_PROJECT.git
cd YOUR_PROJECT

# Create virtual environment
python -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

## Running the App

```bash
python src/main.py
```

Or, if Docker-based:

```bash
docker compose up
```

## Environment Variables

Copy `.env.template` to `.env` and populate the following values:

```env
EXAMPLE_VAR=value
SECRET_KEY=your-secret
```

## Troubleshooting

- If dependencies don’t install, upgrade pip: `python -m pip install --upgrade pip`
- If environment won’t activate on macOS, run: `source .venv/bin/activate.fish` or `.zsh`
