# .github/SECRETS.md
# ============================================================
#  GitHub Actions — Required Secrets & Variables
#  Settings → Secrets and variables → Actions
# ============================================================

## Secrets (Settings → Secrets → Actions → New repository secret)

### Core Auth
| Secret | Description | Example |
|--------|-------------|---------|
| `JWT_SECRET` | 64-char random string for access tokens | `openssl rand -hex 64` |
| `JWT_REFRESH_SECRET` | Separate 64-char string for refresh tokens | `openssl rand -hex 64` |

### Production Server (SSH deploy)
| Secret | Description |
|--------|-------------|
| `PROD_HOST` | Server IP or hostname |
| `PROD_USER` | SSH username (e.g. `ubuntu`, `deemona`) |
| `PROD_SSH_KEY` | Private key content (paste the full `-----BEGIN...-----END` block) |
| `PRODUCTION_URL` | `https://api.yourdomain.com` |

### Staging Server (SSH deploy)
| Secret | Description |
|--------|-------------|
| `STAGING_HOST` | Staging server IP or hostname |
| `STAGING_USER` | SSH username |
| `STAGING_SSH_KEY` | Private key content |
| `STAGING_URL` | `https://staging.yourdomain.com` |

### Notifications
| Secret | Description |
|--------|-------------|
| `SLACK_WEBHOOK_URL` | From Slack: Apps → Incoming Webhooks → Add |

### Optional: Cloud Storage (DB backups)
| Secret | Description |
|--------|-------------|
| `AWS_ACCESS_KEY_ID` | AWS IAM key with S3 write access |
| `AWS_SECRET_ACCESS_KEY` | Paired secret key |
| `AWS_BACKUP_BUCKET` | S3 bucket name (e.g. `deemona-backups`) |

### Optional: Railway / Render (alternative deploy targets)
| Secret | Description |
|--------|-------------|
| `RAILWAY_TOKEN_STAGING` | From Railway: Account Settings → Tokens |
| `RAILWAY_TOKEN_PROD` | Separate token for production |
| `RENDER_DEPLOY_HOOK_STAGING` | From Render: Service → Deploy hooks |
| `RENDER_DEPLOY_HOOK_PROD` | Separate hook for production |

### Optional: Codecov
| Secret | Description |
|--------|-------------|
| `CODECOV_TOKEN` | From codecov.io (free for public repos — omit token) |

---

## Variables (Settings → Secrets → Variables → New repository variable)
Variables are non-sensitive config — visible in logs.

| Variable | Description | Example |
|----------|-------------|---------|
| `SLACK_ENABLED` | Set to `true` to enable Slack notifications | `true` |
| `BASE_DOMAIN` | Base domain for PR previews | `yourdomain.com` |

---

## Environments
Create these in Settings → Environments:

### `production`
- Add required reviewers (forces manual approval before deploy)
- Set deployment protection rules: only `main` branch

### `staging`
- No required reviewers
- Allow `develop` branch

### `pr-preview-*`
- Created automatically per PR — no manual setup needed

---

## How to generate SSH keys for deployment

```bash
# 1. Generate a dedicated deploy key (no passphrase)
ssh-keygen -t ed25519 -C "github-actions-deploy" -f ~/.ssh/deemona_deploy -N ""

# 2. Add the PUBLIC key to your server's authorized_keys
ssh-copy-id -i ~/.ssh/deemona_deploy.pub ubuntu@your-server-ip
# OR manually: cat ~/.ssh/deemona_deploy.pub >> ~/.ssh/authorized_keys

# 3. Copy the PRIVATE key content and paste into the PROD_SSH_KEY secret
cat ~/.ssh/deemona_deploy
# Copy everything including -----BEGIN and -----END lines

# 4. Test the connection
ssh -i ~/.ssh/deemona_deploy ubuntu@your-server-ip "echo connected"
```

---

## Quick start: first deploy

```bash
# 1. Push to develop — triggers staging deploy
git push origin develop

# 2. Check Actions tab for pipeline status

# 3. Merge to main — triggers production deploy
# (requires Environment protection approval if configured)
git push origin main

# 4. Manual rollback if needed
# GitHub UI → Actions → Emergency Rollback → Run workflow
# Input: target_sha = sha from a known-good release
```

---

## Workflow files summary

| File | Trigger | Purpose |
|------|---------|---------|
| `ci.yml` | push/PR | Main pipeline: lint → test → build → deploy |
| `rollback.yml` | manual | Emergency revert to any previous image |
| `nightly.yml` | 02:00 UTC | Dependency audit, DB backup, stale cleanup |
| `pr-preview.yml` | PR events | Ephemeral preview URL per PR |
