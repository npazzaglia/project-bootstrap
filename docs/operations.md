# ⚙️ Operations

> This guide documents how to deploy, run, monitor, and maintain the project in staging or production environments.

## Deployment

### Manual

```bash
git pull origin main
docker compose build
docker compose up -d
```

### CI/CD (Expanded)

- CI/CD is handled via [GitHub Actions](https://docs.github.com/en/actions)
- The `deploy.yml` workflow (if present) can handle automatic builds, deploys, or container pushes
- Triggers:
  - On merge to `main` → Deploy to `prod`
  - On push to `preview/*` → Deploy to `staging` (if configured)

> ⚠️ Ensure required secrets (e.g. `DOCKERHUB_TOKEN`, `PROD_API_KEY`) are configured in GitHub Actions before running deployments.

- CI/CD is handled via GitHub Actions
- On merge to `main`, a deployment job (if configured) can publish artifacts or trigger infrastructure updates

## Infrastructure Assumptions

> ℹ️ This project assumes a containerized environment using Docker Compose. You can adapt it for Kubernetes, ECS, or another target with minimal changes.

All deployments assume:
- Docker and Docker Compose are available
- A `.env` file or GitHub Secrets is configured
- CI/CD deploy logic exists in `.github/workflows/deploy.yml`

## Environments

- `dev`: Local development on Docker or directly
- `staging`: Preview branch deployments (optional)
- `prod`: Mainline deploy target

## Secrets & Config

> 💡 Secrets are stored using GitHub Actions secrets or `.env` files (not committed).  
> Environment variables should be documented in [`getting-started.md`](getting-started.md)

- Secrets are stored using GitHub Actions secrets or `.env` files (not committed)
- Environment variables should be documented in [`getting-started.md`](getting-started.md)

## Monitoring & Logs

- Log output is directed to `stdout` and can be collected by container logging agents
- Optional integration with:
  - Log aggregation tools (e.g. Loki, ELK, Datadog)
  - Metrics tools (e.g. Prometheus, Grafana)

## Backup & Restore

- Define backup schedule and mechanisms here (e.g. database dumps, object store snapshots)

## Rollback & Disaster Recovery

- Rollbacks are manual unless otherwise scripted
- To roll back:
  1. Revert the `main` branch to a stable tag (`git revert` or reset)
  2. Re-deploy using the CI/CD pipeline or manual `docker compose up`
- Consider:
  - Snapshotting data volumes
  - Keeping previous container builds available (versioned tags)

## Troubleshooting

- Check container logs: `docker compose logs -f`
- Restart service: `docker compose restart <service>`
- Inspect healthchecks: `docker inspect --format='{{json .State.Health}}' <container>`
