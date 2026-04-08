# ============================================================
#  DEEMONA API — Dockerfile (multi-stage)
#  Build:  docker build -t deemona-api .
#  Run:    docker run -p 3000:3000 --env-file .env deemona-api
# ============================================================

# ── Stage 1: deps ─────────────────────────────────────────
FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production && npm cache clean --force

# ── Stage 2: production image ─────────────────────────────
FROM node:20-alpine AS production
WORKDIR /app

# Security: run as non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S deemona -u 1001

# Copy production node_modules from deps stage
COPY --from=deps /app/node_modules ./node_modules

# Copy source
COPY --chown=deemona:nodejs . .

# Create upload directory
RUN mkdir -p public/uploads && chown -R deemona:nodejs public/uploads

# Remove dev files
RUN rm -rf tests/ .github/ .env* docker-compose*

USER deemona

ENV NODE_ENV=production
EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
  CMD wget -qO- http://localhost:3000/api/health || exit 1

CMD ["node", "server.js"]