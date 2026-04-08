# ── Stage 1: build ────────────────────────────────────────
FROM node:20-alpine AS build
WORKDIR /app

# Accept build-time env vars (Vite bakes them into bundle)
ARG VITE_API_URL=/api
ARG VITE_RAZORPAY_KEY_ID=rzp_test_placeholder
ENV VITE_API_URL=$VITE_API_URL
ENV VITE_RAZORPAY_KEY_ID=$VITE_RAZORPAY_KEY_ID

# Install deps first (layer cache)
COPY package*.json ./
RUN npm ci

# Copy source and build
COPY . .
RUN npm run build

# ── Stage 2: serve ────────────────────────────────────────
FROM nginx:1.25-alpine AS production

# Copy built assets
COPY --from=build /app/dist /usr/share/nginx/html

# Custom nginx config for SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -qO- http://localhost/health || exit 1

CMD ["nginx", "-g", "daemon off;"]
